create database test1; -- Создать бд test1

use test1; -- Активировать бд test1

drop database test1; -- Удалить бд test1

use gt081024;

create table test(
id int primary key auto_increment,
title varchar(128),
price int default 0
);

rename table test to test1; -- Переименовать таблицуalter
insert into test1 (title, price)
values ('pencil', 40);

insert into test1 (title, price)
values ('notebook', 70);

insert into test1 (title, price)
values ('pen', 35);

select id, title
from test1
where price > 38;

create table users(
id int primary key auto_increment,
firstname varchar(64),
lastname varchar(128),
age decimal(5,2)
);

-- Изменение таблиц и столбцов
-- alter table название_таблицы
-- add colum название_столбца тип_данных [ограничение]
-- drop column название_столбца - удаление столбца
-- modify colum название_столбца новый_тип_данных -- изменение типа данных
-- rename colum название_столбца to новое_название_столбца
-- change colum название_столбца новое_название_столбца тип_данных/новый_тип_данных; -- переименование поля и изменение тип

-- Добавить поле gender тип данных char(1)

alter table users
add column gender char(1);

-- Добавить поле user_name varchar(128) и переименовать поле firstname to first_name, а lastname to last_name
alter table users
add column user_name varchar(128),
rename column firstname to first_name,
rename column lastname to last_name;

-- Добавить поле sal int, переименовать поле sal на salary, изменить тип данных salary на decimal(8, 2)
alter table users
add column sal int,
rename column sal to salary,
modify column salary decimal(8,2);
-- Error Code: 1054. Unknown column 'salary' in 'users'

alter table users
add column sal int;

alter table users
change column sal salary decimal(8,2);

-- Удалить поле user_name
alter table users
drop column user_name;

-- Удалить поле gender
-- Добавить поле has_child varchar(4) по умолчанию 'No'
-- Переименовать поле id на user_id
-- Изменить тип данных поля has_child на varchar(3)

alter table users
drop column gender,
add column has_child varchar(4) default 'No',
rename column id to user_id;

alter table users
modify column has_child varchar(3);

select * from users;

-- first - в начало
-- after название_поля - после поля
-- before название_поля - поле поля

-- Добавить поле gender char(1), вставить после age
alter table users
add column gender char(1) after age;
