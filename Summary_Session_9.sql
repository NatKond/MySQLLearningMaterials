create database university;
use university;

-- Создать базу данных university
-- 1) Создать таблицу Students
-- с полями:
-- - id целое число первичный ключ автоинкремент
-- - name строка 128 не null
-- - age целое число

create table Students(
id integer primary key auto_increment,
name varchar(128) not null,
age int);

-- 2) Создать таблицу Teachers
-- с полями:
-- id целое число первичный ключ автоинкремент
-- name строка 128 не null
-- age целое число

create table Teachers(
id integer primary key auto_increment,
name varchar(128) not null,
age int);

-- 3) Создать таблицу Competencies
-- с полями:
-- id целое число первичный ключ автоинкремент
-- title строка 128 не null

create table Competencies(
id integer primary key auto_increment,
title varchar(128) not null);

-- 4) Создать таблицу Teachers2Competencies
-- с полями:
-- id целое число первичный ключ автоинкремент
-- teacher_id целое число
-- competencies_id целое число

create table Teachers2Competencies(
id integer primary key auto_increment,
teacher_id int,
competencies_id int);

-- 5) Создать таблицу Courses
-- id целое число первичный ключ автоинкремент
-- teacher_id целое число
-- title строка 128 не null
-- headman_id целое число

create table Courses(
id integer primary key auto_increment,
teacher_id int,
title varchar(128) not null,
headman_id int);

-- 6)Создать таблицу Students2Courses
-- id целое число первичный ключ автоинкремент
-- student_id целое число
-- course_id целое число

create table Students2Courses(
id integer primary key auto_increment,
student_id int,
course_id int);

-- Добавить 6 записей в таблицу Students
-- Анатолий 29
-- Олег 25
-- Семен 27
-- Олеся 28
-- Ольга 31
-- Иван 22

insert into Students (name, age)
values ('Анатолий', 29),
		('Олег', 25),
		('Семен', 27),
		('Олеся', 28),
		('Ольга', 31),
		('Иван', 22);

-- Добавить 6 записей в таблицу Teachers
-- Петр 39
-- Максим 35
-- Антон 37
-- Всеволод 38
-- Егор 41
-- Светлана 32

insert into Teachers (name, age)
values ('Петр', 39),
		('Максим', 35),
		('Антон', 37),
		('Всеволод', 38),
		('Егор', 41),
		('Светлана', 32);

-- Добавить 4 записей в таблицу Competencies
-- Математика 
-- Информатика
-- Программирование
-- Графика

insert into Competencies (title)
values ('Математика'),
		('Информатика'),
		('Программирование'),
		('Графика');

-- Добавьте 6 записей в таблицу Teachers2Competencies
-- 1 1
-- 2 1
-- 2 3
-- 3 2
-- 4 1
-- 5 3

insert into Teachers2Competencies (teacher_id, competencies_id)
values (1, 1),
		(2, 1),
		(2, 3),
		(3, 2),
		(4, 1),
		(5, 3);

-- Добавьте 5 записей в таблицу Courses
-- 1 Алгебра логики 2
-- 2 Математическая статистика 3
-- 4 Высшая математика 5
-- 5 Javascript 1
-- 5 Базовый Python 1

insert into Courses(teacher_id, title, headman_id)
values (1, 'Алгебра логики', 2),
		(2, 'Математическая статистика', 3),
		(4, 'Высшая математика', 5),
		(5, 'Javascript', 1),
		(5, 'Базовый Python', 1);


-- Добавьте 5 записей в таблицу Students2Courses
-- 1 1
-- 2 1
-- 3 2
-- 3 3
-- 4 5

insert into Students2Courses( student_id, course_id)
values (1,1),
		(2,1),
		(3,2),
		(3,3),
		(4,5);
        
select * from Students;
select * from Teachers;
select * from Competencies;
select * from Teachers2Competencies;
select * from Courses;
select * from Students2Courses;
        
-- 1. Вывести имена студентов (name) и идентификаторы курсов (course_id), которые они посещают.
select st.name, stcr.course_id 
from Students as st
join students2courses as stcr
on st.id = stcr.student_id;

-- 2. Вывести имена студентов и идентификаторы курсов:
-- Если студент проходит курс, указать соответствующий course_id.
-- Если студент не проходит ни одного курса, вывести NULL в качестве значения course_id.
select st.name, stcr.course_id 
from Students as st
left join students2courses as stcr
on st.id = stcr.student_id;

-- 3. Вывести имена студентов, которые не записаны ни на один курс.
select st.name, stcr.course_id 
from Students as st
left join students2courses as stcr
on st.id = stcr.student_id
where stcr.course_id is null;

-- 4. Найти курсы, которые не посещает ни один студент.
select cr.id, cr.title
from Courses as cr
left join students2courses as stcr
on cr.id = stcr.course_id
where stcr.student_id is null;

-- 5. Найти компетенции, которые не принадлежат ни одному преподавателю.
select cmpt.title
from Competencies as cmpt
left join Teachers2Competencies as tcmpt
on cmpt.id = tcmpt.competencies_id
where tcmpt.teacher_id is null;

-- 6. Вывести название курса и имя преподавателя, который является заведующим кафедрой для данного курса.
select cr.title, tch.name
from Courses as cr
join teachers as tch
on tch.id = cr.headman_id;

-- 6.1.  Вывести название курса и преподавателя, который ведет этот курс
select cr.title, tch.name
from Courses as cr
join teachers as tch
on tch.id = cr.teacher_id;

-- 7. Вывести имя студента и имена преподавателей, которые являются заведующими кафедрой для курсов, на которые записан студент.
select st.name as student_name, cr.title, tch.name as headman_name
from Students as st
join students2courses as stcr
on st.id = stcr.student_id
join Courses as cr
on cr.id = stcr.course_id
join teachers as tch
on tch.id = cr.headman_id;

-- 7. Вывести имя студента и имена преподавателей, которые ведут курс у этого студента.
select st.name as student_name, cr.title, tch.name as teacher_name
from Students as st
join students2courses as stcr
on st.id = stcr.student_id
join Courses as cr
on cr.id = stcr.course_id
join teachers as tch
on tch.id = cr.teacher_id;
