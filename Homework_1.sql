-- 1. Создать базу данных homeworks
-- 2.  В этой базе создать таблицу staff с полями:
--  • id – integer - уникальное значение, не пустое, с автозаполнением 
--  • firstname - varchar - не пустое
--  • lastname - varchar - не пустое
--  • position - varchar
--  • age - integer - от 0 до 110(вкл.)
--  • has_child – char только один символ, по умолчанию 'N' 
--  • username - varchar - уникальный
-- 3. Добавить 5 строк.

create database homeworks;
use homeworks;

create table staff(
	id int primary key auto_increment,
    firstname varchar(100) not null,
    lastname varchar(100) not null,
    position varchar(100),
    age int check(age between 1 and 110),
    has_child char(1) check(has_child in('Y', 'N')) default 'N',
    username varchar(100) unique
);

insert into staff(firstname, lastname, position, age, username)
values 
('John', 'Smith', 'Manager', 35, 'johnsmith'),
('Emily', 'Johnson', 'Accountant', 29, 'emilyj'),
('Michael', 'Brown', 'Developer', 42, 'michaelb'),
('Sarah', 'Davis', 'HR Specialist', 31, 'sarahd'),
('James', 'Wilson', 'Marketing Coordinator', 27, 'jamesw'),
('Sophia', 'Miller', 'Designer', 25, 'sophiam');

insert into staff (firstname, lastname, age, has_child, username)
values ('Dave', 'Faviet', 23, 'Y', 'favietDv');

select *
from staff;