use gt081024;

-- 1. Создайте таблицу с названием Employees, которая будет содержать информацию о сотрудниках компании. Таблица должна иметь следующие поля:

-- employee_id - уникальный идентификатор сотрудника (Primary Key) и автозаполнение
-- first_name - имя сотрудника (Not Null)
-- last_name - фамилия сотрудника (Not Null)
-- email - адрес электронной почты сотрудника (уникальное значение, не пустое)
-- age - возраст сотрудника (в диапазоне от 20 до 50 (вкл.))

create table employees(
	employee_id int primary key auto_increment,
    firstname varchar(100) not null,
    lastname varchar(100) not null,
    email varchar(100) unique not null,
    age int check(age between 20 and 50)
);

-- 2. Заполните таблицу данными с помощью следующих записей:

-- Сотрудник с именем "John", фамилией "Doe", адресом электронной почты "john.doe@example.ge" и возрастом 39 лет.
-- Сотрудник с именем "Jane", фамилией "Smith", адресом электронной почты "jane.smith@example.com" и возрастом 25 лет.
-- Сотрудник с именем "Michael", фамилией "Johnson", адресом электронной почты "michael.johnson@example.am" и возрастом 22 года.
-- Сотрудник с именем "Emily", фамилией "Brown", адресом электронной почты "emily.brown@example.com" и возрастом 29 лет.

insert into employees(firstname, lastname, email, age)
values ("John", "Doe", "john.doe@example.ge", 39),
("Jane", "Smith", "jane.smith@example.com", 25),
("Michael", "Johnson", "michael.johnson@example.am", 22),
("Emily", "Brown", "emily.brown@example.com", 29);

insert into employees(firstname, lastname, email, age)
values ("Bob", "Doe", "bob.doe@example.ge", 40),
("Jane", "Hardy", "jane.hardy@example.com", 30),
("Jack", "Johnson", "jack.johnson@example.am", 50),
("Emily", "Brown", "emily.brown1@example.com", 29);

insert into employees(firstname, lastname, email, age)
values ("Bob", "Doe", "bob.doe@example.ge", 40);

insert into employees(firstname, lastname, email, age)
values ("Bob", "Brown", "bob.brown@example.ge", 40);

insert into employees(firstname, lastname, email, age)
values ("Bob", "Brown", "bob.brown@example.ge", 40);

insert into employees(firstname, lastname, email, age)
values ("Bob", "Red", "bob.red@example.ge", 40);

rename table employees to Employees; 

select *
from Employees;


create table staff(
	id int primary key auto_increment,
    firstname varchar(60) not null,
    lastname varchar(100) not null,
    position varchar(100),
    age int check(age between 0 and 110),
    has_child char(1) check(has_child in ('Y', 'N')),
    username varchar(100) unique not null
);

-- Найти ошибку в коде:
insert into staff (firstname, lastname, age, has_child, username)
values ('Dave', 'Faviet', 23, 'Y', 'favietDv');