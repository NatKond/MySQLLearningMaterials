rename table students to students2;

create table students(
	name varchar(128) not null,
    lastname varchar(128) not null,
    avg_mark int check(avg_mark between 0 and 5),
    gender varchar(128) check(gender in ('M', 'F'))
);

-- Добавить поле id integer primary key auto_increment, вставить в начало.
alter table students
add column id int primary key auto_increment first;

-- Поменять тип у gender на char(1)
alter table students
modify column gender char(1);

-- Поменять тип у avg_mark на decimal(7, 4)
alter table students
modify column avg_mark decimal(7, 4);

-- Переименовать поле name на firstname
alter table students
rename column name to firstname;

-- Добавить 5 записей студентов
insert into students(firstname, lastname, avg_mark, gender)
values ('Олег', 'Петров', 4.3, 'M');

insert into students(firstname, lastname, avg_mark, gender)
values ('Семен', 'Степанов', 3.1, 'M');

insert into students(firstname, lastname, avg_mark, gender)
values ('Ольга', 'Семенова', 4.7, 'F');

insert into students(firstname, lastname, avg_mark, gender)
values ('Игорь', 'Романов', 3.1, 'M');

insert into students(firstname, lastname, avg_mark, gender)
values ('Ирина', 'Иванова', 4.3, 'M');

-- найти учеников, у которых оценка больше 4
select *
from students
where avg_mark > 4;

-- найти учеников, у которых оценка не входит в диапазон от 3 до 4
select * 
from students 
where avg_mark not between 3 and 4;

-- найти учеников, у которых имя начинается на И
select * 
from students
where firstname like 'И%';

-- найти учеников, у которых оценка 2.2 или 3.1 или 4.7
select * 
from students 
where avg_mark in (2.2, 3.1, 4.7);

-- найти первых трех учеников, у которых оценка меньше 4.5
select * 
from students 
where avg_mark < 4.5
limit 3;

-- вывести всех учеников, отсортировав по возрастанию средних оценок
select * 
from students 
order by avg_mark asc;

-- вывести имя ученика с самой низкой средней оценкой
select * 
from students 
order by avg_mark asc
limit 1;

set sql_safe_updates = 0;
alter table students
drop check students_chk_1;

-- Увеличить всем учащимся оценку в 10 раз
update students
set avg_mark = avg_mark * 10;

-- Поменяйте у Олега Петрова фамилию на Сидоров
update students
set lastname = 'Сидоров'
where lastname = 'Петров';

-- Удалить всех учеников, у которых оценка не больше 31.
delete from students
where avg_mark <= 31;

select *
from students
order by avg_mark;

truncate table students;