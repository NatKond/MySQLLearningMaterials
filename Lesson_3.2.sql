-- Создать таблицу students1 с полями
-- name строка(60) (не null)
-- lastname строка(100) (не null)
-- avg_mark целое число (от 0 до 5 вкл.)
-- gender строка(128) (или 'M' или 'F')

-- Добавить поле id integer primary key auto_increment в начало таблицы 
-- Добавить поле age (тип целое число) после lastname
-- Поменять тип у gender на char(1)
-- Переименовать поле name на firstname

use gt081024;

create table students1(
name varchar(60) not null,
lastname varchar(100) not null,
avg_mark int check(avg_mark between 0 and 5),
gender varchar(128) check(gender in('M', 'F'))
);

alter table students1
add column id int primary key auto_increment first,
add column age int after lastname,
modify column gender char(1),
rename column name to firstname;

select * from students1;