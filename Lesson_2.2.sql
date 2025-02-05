-- Создать таблицу students
-- id целое число, уникальное значение, не null, автозаполнение 
-- firstname varchar not null
-- lastname varchar not null
-- class integer от 1 до 10 (вкл)
-- subject_name varchar not null
-- mark integer от 0 до 5 (вкл)
-- school_no integer по умолч. 0
-- checked char(1) значение Y либо N

create table students(
	id int primary key auto_increment,
    firstname varchar(100) not null,
    lastname varchar(100) not null,
    class int check(class between 1 and 10),
    subject_name varchar(100) not null,
    mark int check(mark between 0 and 5),
    school_no int default 0,
    checked char(1) check(checked in ('Y', 'N'))
);

-- Заполнение с ошибками
insert into students
values ('John', 'Smith', 5, 'Math', 4, 120, 'N');
-- Error Code: 1136. Column count doesn't match value count at row 1

insert into students(lastname, class, subject_name, mark,school_no, checked)
values ('Smith', 5, 'Math', 4, 120, 'N');
-- Error Code: 1364. Field 'firstname' doesn't have a default value

insert into students(firstname, lastname, class, subject_name, mark,school_no, checked)
values ('John', 'Smith', 15, 'Math', 4, 120, 'N');
-- Error Code: 3819. Check constraint 'students_chk_1' is violated.

insert into students(firstname, lastname, class, subject_name, mark,school_no, checked)
values ('John', 'Smith', 5, 'Math', 6, 120, 'N');
-- Error Code: 3819. Check constraint 'students_chk_2' is violated.

insert into students(firstname, lastname, class, subject_name, mark,school_no, checked)
values ('John', 'Smith', 5, 'Math', 4, 120, 'L');
-- Error Code: 3819. Check constraint 'students_chk_3' is violated.

insert into students(firstname, lastname, class, subject_name, mark,school_no, checked)
values ('John', 'Smith', 5, 'Math', 4, 120, 'NN');
-- Error Code: 1406. Data too long for column 'checked' at row 1


insert into students(firstname, lastname, class, subject_name, mark,school_no, checked)
values ('John', 'Smith', 5, 'Math', 4, 120, 'N');

insert into students(firstname, lastname, class, subject_name, mark, checked)
values ('John', 'Smith', 5, 'Math', 4, 'N');

select *
from students
where firstname like

