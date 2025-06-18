-- database - одна субд может управлять множеством баз данных
-- внутри базы данных хранятся таблицы, в которых хранится информация

-- DML - data manipulation language (SELECT, INSERT, DELETE, UPDATE)
-- DDL - data definition language (CREATE, DROP, ALTER, TRUNCATE)

create database learn; -- создание базы данных

use learn; -- переключиться на использование конкретной базы данных

create table products(
id integer primary key auto_increment,
title varchar(128),
price integer,
discount decimal(2,1)
);

insert into products (title,price, discount) values ('bike',50000,0.9);
insert into products (title,price, discount) values ('skates',15000,0.1);
insert into products (title,price, discount) values ('skis',25000,null);
insert into products (title,price, discount) values ('board',30000,0.9);
insert into products (title,price, discount) values ('scooter',10000,0.8);

-- SELECT - выборка данных из таблицы (выборка никогда не изменяет данные в таблице)

SELECT -- команда выборки
* -- выбор всех колонок из таблицы
FROM products;  -- указываем из какой таблицы выбираем данные

-- выполнение текущего запроса :
-- windows ctrl + enter
-- mac command + enter
-- либо в workbench вторая молния (та что с курсором)


/*
SELECT - оператор выборки
перечисляем имена полей, что хотим выбрать или * если все поля
FROM имя таблицы откуда выбираем
WHERE условие для фильтрации выборки;
*/

SELECT
*
FROM products;

SELECT
title,
price
FROM products;

SELECT
discount,
title,
price
FROM products;

SELECT 
title
FROM products;

SELECT
*
FROM products
LIMIT 3;   -- ограничение на количество строк выборки

-- WHERE - определяет условие для выборки (фильтрует строки, которые будут в результате)

SELECT
*
FROM products
WHERE price > 20000;   -- >, < , = , <=, >=, <>

SELECT
*
FROM products
WHERE title = 'skis';

SELECT
title,
price
FROM products 
WHERE title = 'board';

-- AND, OR

SELECT
*
FROM products
WHERE title = 'board' OR price < 20000;

SELECT
*
FROM products
WHERE discount = 0.9 AND price > 30000;

SELECT
*
FROM products
WHERE price >= 20000 AND price <=30000;

-- BETWEEN , NOT BETWEEN границы включены в условие

SELECT
* 
FROM products
WHERE price BETWEEN 20000 AND 30000;

SELECT
*
FROM products
WHERE price NOT BETWEEN 20000 AND 30000;

-- 3, 2, 5
SELECT
*
FROM products
WHERE id = 3 OR id = 2 OR id = 5;

-- IN , NOT IN - в списке, не в списке
SELECT
*
FROM products
WHERE id IN (3, 2, 5);

SELECT
*
FROM products
WHERE id NOT IN (3, 2, 5);

-- skis, bike, scooter

SELECT
*
FROM products
WHERE title IN ('skis','board','scooter');

-- LIKE , NOT LIKE - '%' - любое количество символов, '_' - один символ
SELECT
*
FROM products
WHERE title LIKE 'b%';  -- '%b'

SELECT
*
FROM products
WHERE title LIKE 's%';  

SELECT
*
FROM products
WHERE title LIKE '%s';  

SELECT
*
FROM products
WHERE title LIKE '%e_';  

SELECT
*
FROM products;

-- null, 0 , 0.0, ''

-- null - отсутствие какого либо значения в поле, не путать с 0 или пустой строкой

-- IS NULL, IS NOT NULL

SELECT
*
FROM products
WHERE discount IS NULL;

SELECT
*
FROM products
WHERE discount IS NOT NULL;

insert into products (title,price, discount) values ('',50000,0.9);
insert into products (title,price, discount) values (null,50000,0.9);

SELECT
*
FROM products
WHERE title = '' OR title IS NULL;

use learn; -- после перезагрузки воркбенча нужно переключаться на нужную базу данных

-- 30_09 summary
use hr;

-- 1. Найти всех сотрудников , работающих в департаменте с id 90
SELECT
*
FROM employees;

SELECT
*
FROM employees
WHERE department_id = 90;

-- 2. Найти всех сотрудников с зарплатой больше чем 5000
SELECT
*
FROM employees
WHERE salary > 5000;

-- 3. Найти всех сотрудников , чья фамилия начинается на L
SELECT 
* 
FROM employees
WHERE last_name LIKE 'L%';

-- 4. Найти все департаменты , у которых location_id = 1700
SELECT 
* 
FROM departments
WHERE location_id = 1700;

-- 5. Найти все города с country_id = US
SELECT 
*
FROM locations
WHERE country_id = 'US';

-- 6. Вывести зарплату сотрудника с именем Lex и фамилией De Haan

SELECT
salary
FROM employees
WHERE first_name = 'Lex' AND last_name='De Haan';

-- 7. Вывести всех сотрудников с job_id = 'FI_ACCOUNT'и зарабатывающих меньше 8000 
SELECT
*
FROM employees
WHERE job_id = 'FI_ACCOUNT' AND salary < 8000;

-- 8.Вывести всех сотрудников у кого commission_pct = NULL
SELECT
*
FROM employees
WHERE commission_pct IS NULL;

-- 9. Вывести имена и фамилии тех сотрудников , кто не работает 
-- в департаментах с ид 80,90,110

SELECT 
first_name,
last_name
FROM employees
WHERE department_id NOT IN(80, 90, 110);

-- lesson two
use learn;

SELECT 
*
FROM products;

-- AS - добавляет альтернативное имя для поля
-- оригинальные имена полей в базе данных не меняются
-- это только отображение в результирующей выборке

SELECT
title AS product_name,
price AS product_price
FROM products;

SELECT
title product_name
FROM products;

-- +,-,*, /

SELECT
title,
price,
price * 1.5 AS new_price_one,
price - 500 AS discount_price,
price * 2 AS new_price_two
FROM products;

SELECT
title,
price,
discount,
price * discount AS sale_price
FROM products;

SELECT
title,
price,
price * 0.9 AS price_with_discount_10,
price * 0.8 AS price_with_discount_20,
price * 0.7 AS price_with_discount_30
FROM products;

-- SQL позволяет добавить любое константное поле в выборку

SELECT
title,
'sport' AS category,
0 AS rate
FROM products;

-- math function
SELECT 60; -- constant without source
SELECT ABS(-15); -- absolut value
SELECT POW(3,2); -- power of value
SELECT ROUND(4.7); -- round of value
SELECT SQRT(225); -- sqrt

SELECT
title,
POW(price, 2) as price
FROM products;

-- strings function

-- concat - объединяет строки
SELECT
CONCAT('Hello', '-', 'World') AS greetings;

SELECT
CONCAT(title,' ',price) AS title,
id,
CONCAT('Hello', '-', 'World') AS greetings
FROM products;

-- concat_ws - соединяет несколько колонок через разделитель
SELECT
CONCAT_WS(' ',title, id, price) AS description,
discount
FROM products;

-- LOWER, UPPER
SELECT
UPPER(title),
LOWER('HeLlo') AS greetings
FROM products;

SELECT
LENGTH('Hello'); -- длина строки

SELECT
LENGTH('Привет');

SELECT
TRIM('   Hello   '), -- обрезает пробелы слева и справа
LEFT('Hello' , 3), -- выбирает количество символов слева
RIGHT('Hello', 2), -- выбирает количество символов справа
SUBSTRING('Hello World', 7, 5), -- берет подстроку с определенной позиции
REPLACE('9-0-0-1','-',''), -- заменяет символы в строке
LOCATE('l', 'Hello'); -- определяет вхождение символа в строку(позицию)

-- ORDER BY , ASC - сортировка по возрастанию(по умолчанию)
-- DESC - сортировка по убыванию

SELECT
title,
price
FROM products
ORDER BY title DESC;

/*
SELECT
...
...
... AS ...
FROM ...
WHERE ...
ORDER BY ...
*/

-- Task1 - select all, order price from bigger to lower

SELECT
*
FROM products
ORDER BY price DESC;

SELECT
*
FROM products
ORDER BY price DESC, title ASC;

-- DISTINCT выбирает только уникальные записи
-- оригинальная таблица остается без изменений

insert into products (title,price, discount) values ('board',30000,0.9);

SELECT
*
FROM products;

-- для этого запроса дубль это title+id
SELECT DISTINCT
title,
id
FROM products;

SELECT DISTINCT
title,
price
FROM products;

-- -------------
/*
SELECT
какое_то_поле_таблицы,
(какая_то_функция или действие с полем) AS какое-то имя,
какое_то_поле_таблицы
FROM какая_то_таблицa;
*/

-- CASE единственный вариант условного оператора в SQL

/*
(CASE 
	WHEN (something) THEN something1
    WHEN (something) THEN something2
    WHEN (something) THEN something3
    ...
    WHEN (something) THEN somethingN
    ELSE somethingElse
END ) AS something_name
*/

SELECT
title,
price,
discount,
(CASE
	WHEN price < 11000 THEN 1
    WHEN price < 20000 THEN 2
    WHEN price < 30000 THEN 3
    ELSE 4
END) AS price_category
FROM products;

SELECT
title,
price,
discount,
(CASE
	WHEN price < 11000 THEN 'low'
    WHEN price < 20000 THEN 'middle'
    WHEN price < 30000 THEN 'high'
    ELSE 'lux'
END) AS price_category
FROM products;

SELECT
title,
price,
(CASE
	WHEN discount IS NULL 
		THEN price
    ELSE price * discount
END) AS sale_price
FROM products;

use airport;

SELECT
*
FROM airliners;

-- model_name, category - from 1000 to 2500(incl) - short
-- 						   from 2500 to 6000(incl) medium
-- 						    from 6000 long

INSERT INTO airliners VALUES ('00569305', 'Cessna 172', 900, 1978, 'white', '9501', 'Russia');

SELECT
model_name,
distance,
(CASE
	WHEN distance > 1000 AND distance <=2500 THEN 'short'
    WHEN distance > 2500 AND distance <=6000 THEN 'medium'
    WHEN distance > 6000 THEN 'long'
    ELSE 'undefined'
END) AS category
FROM airliners;

-- summary lesson 
use airport;

-- class - 'old', 'mid', 'new' : < 2000 - old,  2000 and 2010 - mid, new - all > 2010
-- exclude airplanes  with distance > 10000
-- исключить самолеты которые летят больше чем 10000
-- WHERE distance <= 10000
-- order by class
-- в выборке должны присутствовать вот эти поля - side_number, age, class

SELECT
side_number,
production_year AS age,
(CASE
	WHEN production_year < 2000 THEN 'old'
    WHEN production_year <=2010 THEN 'mid'
    ELSE 'new'
END) AS class
FROM airliners
WHERE distance <= 10000
ORDER BY class;

/*

SELECT 
...
FROM ...
WHERE ...
ORDER BY ...;

*/

SELECT 
*
FROM tickets;

-- new_price : Business - 10%, Economy - 15 %, PremiumEconomy - 20%
-- field id, trip_id, new_price

SELECT 
id,
trip_id,
(CASE
	WHEN service_class = 'Business' THEN price * 0.9
    WHEN service_class = 'Economy' THEN price * 0.85
    WHEN service_class = 'PremiumEconomy' THEN price * 0.8
END) AS new_price
FROM tickets
WHERE service_class NOT IN ('FirstClass');


-- lesson three 09.10.2024

-- varchar(32) - (2,4,8,16,32,64,128,255) хранит строковые данные
-- integer; int - хранит целое число
-- numeric(8.2) - хранит числа с плавающей запятой

-- DML - data manipulation language (SELECT, INSERT, DELETE, UPDATE)
-- DDL - data definition language (CREATE, DROP, ALTER, TRUNCATE)

-- CREATE - команда для создания таблицы(TABLE) или базы данных (DATABASE)

CREATE DATABASE students; -- создали базу данных students;
USE students; -- переключились на использование базы данных students;

CREATE TABLE people ( -- создает таблицу с именем people
first_name varchar(32), -- создаем колонку 
last_name varchar(32), -- создаем колонку 
age integer -- создаем колонку 
);

SELECT *
FROM people;

-- INSERT (INTO) - добавляет данные в таблицу

-- полный вариант добавления данных 

INSERT INTO people(first_name, last_name, age) VALUES ('Alex','Alexeev', 35);
-- отличный порядок колонок от порядка при создании таблицы
INSERT INTO people(age, first_name, last_name) VALUES (25,'Oleg','Olegov');

-- вариант без указания перечня полей для вставки
-- будет использован порядок полей, указанных при создании таблицы!!!
-- такой вариант может поломаться при добавлении колонок в таблицу
INSERT INTO people VALUES ('Egor', 'Egorov', 40);

SELECT *
FROM people;

-- вариант вставки значений не во все колонки
INSERT INTO people(first_name, age) VALUES ('Max', 20);

INSERT INTO people(first_name, last_name) VALUES ('Petr', 'Petrov');

-- множественная вставка данных
INSERT INTO people(first_name, last_name) VALUES ('Petr','Maximov'),
												 ('Maxim','Egorov'),
												 ('Oleg', 'Petrov');
                                                 
SELECT *
FROM people;

-- вариант с использованием команды SET
INSERT INTO people SET last_name = 'Alexeev', age = 30;

-- для отключения блокировки от изменения и удаления данных , нужно выполнить :
SET SQL_SAFE_UPDATES = 0;

-- DELETE построчно удаляет данные из таблицы(возможно восстановить удаленные данные)
-- команда группы DML, (восстановить чтобы никто не заметил не получится)

DELETE FROM people; -- удаляет все строки из таблицы( построчно, можно восстановить)

INSERT INTO people(first_name, age) VALUES ('Alex', 20);

-- рекомендуется сделать выборку с таким же фильтром перед удалением
SELECT *
FROM people
WHERE age = 20;

DELETE FROM people
WHERE age = 20; -- удалили студентов с возрастом == 20

-- удалить студентов с незаполненным возрастом и фамилией начинающейся на M
SELECT
*
FROM people
WHERE age IS NULL AND last_name LIKE 'M%';

DELETE FROM people
WHERE age IS NULL AND last_name LIKE 'M%';

SELECT
*
FROM people;

-- TRUNCATE - полностью очищает таблицу(включая счетчики), без возможности восстановить
-- данные!!! , но работает очень быстро
-- команда группы DDL

TRUNCATE TABLE people; -- полностью очищает таблицу

-- UPDATE - команда группы DML, изменяет данные в таблице

SELECT *
FROM people
WHERE first_name IS NULL;

UPDATE people
SET first_name = 'Max'
WHERE first_name IS NULL;

UPDATE people
SET age = 0
WHERE age IS NULL;

UPDATE people
SET age = age + 1;   

-- ALTER -- команда группы DDL, изменяет структуру таблицы

ALTER TABLE people  
ADD rate integer; -- добавляет колонку в таблицу

SELECT 
first_name,
rate,
last_name
FROM people;

SELECT *
FROM people;

UPDATE people
SET rate = 0;

ALTER TABLE people
DROP COLUMN rate; -- удаление столбуца из таблицы

ALTER TABLE people
ADD address varchar(16);

UPDATE people
SET address = 'Berlin, Bonn, Regensburg, Dusseldorf'
WHERE first_name = 'Maxim';
-- Error Code: 1406. Data too long for column 'address' at row 5

ALTER TABLE people
MODIFY COLUMN address varchar(64); -- изменяет тип колонки

ALTER TABLE people
MODIFY COLUMN address varchar(8); 
-- Error Code: 1406. Data too long for column 'address' at row 5

ALTER TABLE people
CHANGE last_name surname varchar(64); -- изменяет имя колонки

SELECT *
FROM people;

ALTER TABLE people
RENAME COLUMN surname TO last_name; -- изменяет имя колонки

ALTER TABLE people
RENAME TO people_two; -- изменяет имя таблицы

SELECT *
FROM people_two;

ALTER TABLE people_two
RENAME TO people;

-- DROP команда группы DDL, удаляет таблицу или базу данных (целиком и без восстановления)

-- DROP TABLE people; -- удаление таблицу !!!
-- DROP DATABASE students; - удаление базы данных !!!


-- Summary

SELECT *
FROM people;

CREATE TABLE other_people AS -- Создание новой таблицы на основе результата выборки
SELECT
*
FROM people;

SELECT *
FROM other_people;

CREATE TABLE young_people AS
SELECT
*
FROM people
WHERE age < 26;

SELECT 
*
FROM young_people;

CREATE TABLE other_young_people AS
SELECT 
first_name,
age
FROM people
WHERE age < 26;

SELECT
*
FROM other_young_people;

CREATE TABLE other_young_people_two AS
SELECT 
first_name AS name,
age
FROM people
WHERE age < 26;

SELECT
*
FROM other_young_people_two;

CREATE TABLE other_people_three AS
SELECT
*
FROM people
WHERE 1 = 0;

SELECT
*
FROM other_people_three;

DROP TABLE other_people_three;
DROP TABLE other_young_people_two;
DROP TABLE other_young_people;
DROP TABLE other_people;
DROP TABLE young_people;

SELECT
*
FROM people
WHERE 1 = 0;

-- VIEW - Представление

CREATE VIEW v_other_people AS
SELECT
*
FROM people;

SELECT 
*
FROM v_other_people;

DELETE FROM people
WHERE age IS NULL;

SELECT
*
FROM people;

CREATE VIEW v_other_people_two AS
SELECT
first_name,
age
FROM people;

SELECT
*
FROM v_other_people_two;

ALTER TABLE people
CHANGE first_name  name varchar(128);

ALTER TABLE people
CHANGE name first_name varchar(128);

SELECT
*
FROM people;

CREATE TABLE other_people AS
SELECT
*
FROM people
WHERE 1 = 0;

SELECT
*
FROM other_people;

SELECT
*
FROM people
WHERE age > 32;

INSERT INTO other_people (first_name, last_name, age) VALUES ('Max','Maximov', 38);

-- Вариант вставки данных на основе выборки из другой таблицы
INSERT INTO other_people (first_name, last_name, age)   (SELECT
														 *
														 FROM people
                                                         WHERE age > 32);

SELECT
t1.first_name
FROM   (SELECT   -- Поздапрос
		*
		FROM people
		WHERE age > 32) AS t1;
        
        
-- lesson four
-- Констрейны - ограничения для колонок в таблице

-- not null - Данное ограничение исключает возможность поместить null в колонку
-- unique - Данное ограничение исключает возможность поместить дублирующее значение в эту же колонку
-- check - Устанавливает значения, которые можно установить в колонку
-- примеры этого констрейна :
		-- age integer check (age > 18)
        -- age integer check (age between 18 and 45)
        -- exists varchar(1) check (exists in ('Y','N'))

-- primary key (PK) (not null + unique) - первичный ключ , комбинация двух констрейнов not null + unique

-- auto_increment - автоматическое увеличение значения в поле с каждой новой записью
-- default - устанавливает значение по умолчанию для колонки

use learn;

drop table if exists students; -- удалит таблицу если она существует

CREATE TABLE students (
id integer primary key auto_increment,
name varchar(32) not null,
surname varchar(32) not null,
age integer check (age between 18 and 60),
email varchar(64) unique
);

INSERT INTO students (name, surname, age, email) VALUES 
('Alex','Alexeev', 30,'hello@hello.com'),
('Oleg','Olegov', 25, 'hi@hi.com');

SELECT
*
FROM students;
-- WHERE id = 2;

INSERT INTO students (name, surname, age, email) VALUES 
('Maxim','Maximov', 40 , 'hello@hello.com');
-- Error Code: 1062. Duplicate entry 'hello@hello.com' for key 'students.email'

INSERT INTO students (name, surname, age, email) VALUES 
('Maxim','Maximov', 65 , 'hello2@hello.com');
-- Error Code: 3819. Check constraint 'students_chk_1' is violated.

INSERT INTO students (name, age, email) VALUES 
('Maxim',45 , 'hello2@hello.com');
-- Error Code: 1364. Field 'surname' doesn't have a default value

INSERT INTO students (id, name, surname, age, email) VALUES 
(2,'Maxim','Maximov', 30 , 'hello3@hello.com');
-- Error Code: 1062. Duplicate entry '2' for key 'students.PRIMARY'

INSERT INTO students (id, name, surname, age, email) VALUES 
(5,'Maxim','Maximov', 30 , 'hello3@hello.com');

ALTER TABLE students
MODIFY COLUMN surname varchar(32) not null default '';

INSERT INTO students (name, age, email) VALUES 
('Maxim', 45 , 'hello2@hello.com');

SELECT 
*
FROM students;

INSERT INTO students (name,surname, age, email) VALUES 
('Maxim', null ,45 , 'hello2@hello.com');
-- Error Code: 1048. Column 'surname' cannot be null

-- add field rate with defautl 0

ALTER TABLE students
ADD rate integer check (rate between 0 and 5) default 0;

SELECT
*
FROM students;

INSERT INTO students (name, surname, age, email) VALUES 
('Egor', 'Egorov' ,30 , 'hello5@hello.com');

INSERT INTO students (name, surname, age, email, rate) VALUES 
('Egor', 'Egorov' ,30 , 'hello6@hello.com', 7);
-- Error Code: 3819. Check constraint 'students_chk_2' is violated.

INSERT INTO students (name, surname, age, email, rate) VALUES 
('Petr', 'Petrov' , 25, null, 3);

ALTER TABLE students
MODIFY COLUMN email varchar(64) unique not null;
-- Error Code: 1138. Invalid use of NULL value

-- 1831 Duplicate index 'email_2' defined on the table 'learn.students'. 
-- This is deprecated and will be disallowed in a future release.


SET SQL_SAFE_UPDATES = 0;

UPDATE students
SET email = id
WHERE email IS NULL;

DELETE FROM students
WHERE id = 8;

INSERT INTO students (name, surname, age, email, rate) VALUES 
('Petr', 'Petrovich' , 40, 'email@email.com', 3);

DELETE FROM students;

-- TRUNCATE - не только удаляет данные, но и сбрасывает все счетчики
-- приводит таблицу в состояние как после создания
-- помним, что восстановить данные нельзя!!!
TRUNCATE TABLE students;

-- Вертикальное объединение таблиц
-- UNION , UNION ALL -- команда позволяет строки одной таблицы присоединить к строкам
-- другой таблицы, причем соответствие колонок идет попозиционно

CREATE TABLE students_from_berlin(
id integer primary key auto_increment,
name varchar(32) not null,
surname varchar(32) not null
);

CREATE TABLE students_from_bonn(
id integer primary key auto_increment,
first_name varchar(32) not null,
last_name varchar(32) not null
);

INSERT INTO students_from_berlin(name ,surname ) VALUES
('Alex','Alexeev'),('Egor','Egorov');

INSERT INTO students_from_bonn(first_name ,last_name ) VALUES
('Max','Maximov'),('Oleg','Olegov');

SELECT *
FROM students_from_berlin;

SELECT *
FROM students_from_bonn;

-- При UNION, UNION ALL за структуру результата( выборки) , а именно, имена колонок, порядок
-- колонок, количество колонок отвечает первый SELECT

-- При UNION, UNION ALL очень важно, что бы количество колонок в выборке было одинаковым
-- в каждом SELECT!!! (не путать с количеством колонок в бд)

SELECT id, name,       surname   FROM students_from_berlin
UNION ALL
SELECT id, first_name, last_name FROM students_from_bonn;

ALTER TABLE students_from_bonn
ADD rate integer check (rate between 0 and 5) default 1;

-- include rate in select
SELECT id, name,       surname , 0 AS rate  FROM students_from_berlin
UNION ALL
SELECT id, first_name, last_name, rate FROM students_from_bonn;

SELECT CONCAT('br','-',id) AS id, 0 AS rate,  name,       surname   FROM students_from_berlin
UNION ALL
SELECT CONCAT('bn','-',id),       rate,       first_name, last_name FROM students_from_bonn;


CREATE TABLE students_from_dusseldorf(
id integer primary key auto_increment,
first_name varchar(32) not null,
last_name varchar(32) not null,
address varchar(32) not null
);

INSERT INTO students_from_dusseldorf(first_name ,last_name, address ) VALUES
('Petr','Alexeev','Dusseldorf 0010101'),('Vin','Egorov','Bonn 020202');


SELECT *
FROM students_from_berlin;

SELECT *
FROM students_from_bonn;

SELECT *
FROM students_from_dusseldorf;

SELECT id , first_name AS name, last_name AS surname, 0 AS rate, address FROM students_from_dusseldorf
UNION ALL
SELECT id , name, 				surname,    		  0 AS rate ,''	     FROM students_from_berlin
UNION ALL
SELECT id , first_name,         last_name,			        rate,'UNDEFINED' FROM  students_from_bonn;

-- add city

SELECT id , first_name AS name, last_name AS surname, 0 AS rate, address,'Dusseldorf' AS city  FROM students_from_dusseldorf
UNION ALL
SELECT id , name,surname, 0 AS rate ,'', 'Berlin' FROM students_from_berlin
UNION ALL
SELECT id , first_name, last_name, rate, 'UNDEFINED', 'Bonn' FROM  students_from_bonn
ORDER BY id;

SELECT  last_name FROM students_from_dusseldorf
UNION ALL -- в результат попадает все, включая дубликаты
SELECT  surname FROM students_from_berlin;

SELECT  last_name FROM students_from_dusseldorf
UNION  -- в результат попадает все, кроме дубликатов
SELECT  surname FROM students_from_berlin;

-- дубликат определяется целиком по строке (записи во всех колонках одинаковые)

SELECT  first_name, last_name FROM students_from_dusseldorf
UNION 
SELECT name, surname FROM students_from_berlin;

-- add duplicate
INSERT INTO students_from_dusseldorf(first_name ,last_name, address ) VALUES
('Egor','Egorov','Bonn 020202');

SELECT  first_name, last_name FROM students_from_dusseldorf
UNION 
SELECT name, surname FROM students_from_berlin;

SELECT  first_name, last_name FROM students_from_dusseldorf
UNION ALL
SELECT name, surname FROM students_from_berlin;

-- summary 

use learn;

SELECT  first_name, last_name, address FROM students_from_dusseldorf
UNION ALL
SELECT name, surname, '' FROM students_from_berlin
UNION ALL
SELECT first_name, last_name, '' FROM  students_from_bonn;

-- SUBSELECT 
-- SUBSELECT in FROM - результат работы одного запроса, является источником данных для другого запроса

SELECT
t1.first_name,
t1.last_name
FROM
	(SELECT  first_name, last_name, address FROM students_from_dusseldorf
	UNION ALL
	SELECT name, surname, '' FROM students_from_berlin
	UNION ALL
	SELECT first_name, last_name, '' FROM  students_from_bonn) AS t1
WHERE t1.first_name LIKE '%x'
ORDER BY t1.last_name;

SELECT
t1.first_name
FROM
	(SELECT
	first_name,
	last_name,
	address 
	FROM c
	WHERE address LIKE 'B%') AS t1;


SELECT
*
FROM c;

SELECT
*
FROM students_from_berlin;

-- SUBSELECT in WHERE - результат работы одного запроса - условие для другого

SELECT
*
FROM students_from_dusseldorf
WHERE first_name NOT IN (
						SELECT
						name
						FROM 
						students_from_berlin);
                        
                        
 CREATE DATABASE factory;
 USE factory;
 
-- employees : id int PK AI, surname v(128) not null, salary int 0;
 
-- administration : id int PK AI, surname v(128) not null, salary int 0;

-- staff : id int PK AI, surname v(128) not null;

CREATE TABLE employees(
id integer primary key auto_increment,
surname varchar(128) not null,
salary integer default 0
);

CREATE TABLE administration(
id integer primary key auto_increment,
surname varchar(128) not null,
salary integer default 0
);

CREATE TABLE staff(
id integer primary key auto_increment,
surname varchar(128) not null
);

INSERT INTO employees(surname, salary) VALUES ('Alexeev', 2000),('Maximov', 1000);

INSERT INTO administration(surname, salary) VALUES ('Sergeev', 9000),('Olegov', 10000);

INSERT INTO staff(surname) VALUES ('Petroff'),('Egorov');

-- print all personal from factory
-- id, surname, salary, category
-- category - worker, boss, staff

-- 1 | Sergeev | 9000 | Boss
-- 2 | Maximov |1000  | worker
-- ...

-- ORDER BY surname

SELECT id , surname , salary , 'worker' AS category FROM employees
UNION ALL
SELECT id , surname , salary , 'boss' FROM administration
UNION ALL
SELECT id , surname , 0 , 'staff' FROM staff
ORDER BY surname;


--  lesson five
-- JOIN - горизонтальное соединение таблиц, к колонкам одной таблицы присоединяются колонки другой таблицы
-- INNER JOIN, LEFT JOIN, RIGHT JOIN

/*
Table 1								 Table 2			
name | surname | age |				 passport | from | until|
Alex | Alexeev | 35. | 				 5555555  | 2024 | 2034
Max  | Maximov | 20. | 				 4444444  | 2024 | 2034


name | surname | age |passport | from | until|
Alex | Alexeev | 35. |4444444  | 2024 | 2034
*/

-- INNER JOIN - внутреннее соединение таблиц

USE learn;

CREATE TABLE person(
id integer primary key auto_increment,
name varchar(64) not null
);

INSERT INTO person(name) VALUES ('Hayk'),
								('Seva'),
                                ('Seva'),
                                ('Katerina');
                                
SELECT *
FROM person;

-- Hayk 25, Seva - 30, Seva - 40, Katerina - 18
-- 1 - 25; 2 -30; 3 - 40; 4 - 18

CREATE TABLE ages(
person_id integer,
age integer
);

INSERT INTO ages (person_id, age) VALUES (1,25),
										 (2,30),
                                         (3,40),
                                         (4,18);
                                         
-- INSERT INTO ages (person_id, age) VALUES (2,30),
-- 										   (4,18),
--                                         (1,25),
--                                         (3,40);
                                         
SELECT *
FROM ages;

SELECT
t1.*, -- выбираем все поля из таблицы т1
t2.*  -- выбираем все поля из таблицы т2
FROM person AS t1
INNER JOIN ages AS t2    -- команда присоединения колонок одной таблицы к колонкам другой таблицы
ON t1.id = t2.person_id; -- условие сопоставления строк одной таблицы к другой

SELECT
t1.id,
t1.name,
t2.age
FROM person AS t1
INNER JOIN ages AS t2    -- команда присоединения колонок одной таблицы к колонкам другой таблицы
ON t1.id = t2.person_id; -- условие сопоставления строк одной таблицы к другой

SELECT
person.id,
person.name,
ages.age
FROM person 
INNER JOIN ages 
ON person.id = ages.person_id;

-- INNER JOIN - особенности

INSERT INTO person(name) VALUES ('Alex'),
								('Max');
SELECT *
FROM person;     

SELECT
t1.*, 
t2.*  
FROM person AS t1
INNER JOIN ages AS t2   
ON t1.id = t2.person_id;       

INSERT INTO ages (person_id, age) VALUES (9,55),
										 (15,19),
                                         (17,60);                  
-- INNER JOIN включает в результат только те строки, для которых есть совпадение в обоих таблицах по 
-- условию указанному после ключевого слова ON

USE hr;

SELECT *
FROM employees;

SELECT *
FROM departments;

SELECT 
first_name,
last_name,
department_id
FROM employees;

-- print name, surname and departments name

SELECT
t1.first_name,
t1.last_name,
-- t1.department_id,
-- t2.department_id,
t2.department_name
FROM employees AS t1
INNER JOIN departments AS t2
ON t1.department_id = t2.department_id;

-- Task 1 : print name, surname and job title for employee
SELECT *
FROM jobs;

SELECT
t1.first_name,
t1.last_name,
-- t1.job_id,
-- t2.job_id,
t2.job_title
FROM employees AS t1
INNER JOIN jobs AS t2
ON t1.job_id = t2.job_id;

-- Task 2 : print name,surname and departments name, only for employees from departments
-- IT, Treasury, IT Support

SELECT
t1.first_name,
t1.last_name,
t2.department_name
FROM employees AS t1
INNER JOIN departments AS t2
ON t1.department_id = t2.department_id
WHERE t2.department_name IN ('IT', 'Treasury', 'IT Support');

-- когда используется JOIN и в запросе есть условие через WHERE
-- то сначала будут присоеденены все подходящие колонки и строки
-- а потом к общему результату будет применена фильтрация по условию


SELECT
t1.first_name,
t1.last_name,
t2.department_name
FROM employees AS t1
INNER JOIN departments AS t2
ON t1.department_id = t2.department_id AND t2.department_name IN ('IT', 'Treasury', 'IT Support');

-- когда используется JOIN и в запросе есть условие добавленное после оператора ON
-- то уже присоединяются отфильтрованные строки по условию из второй таблицы

-- Для INNER JOIN не важно где условие(вышесказанные) , но для других типов JOIN
-- это влияет на результат!!!!
 
-- Task 3 : print name, surname employee and name and surname his manager

-- SELF JOIN (SELF - это не команда!!!! , это подход) - используем INNER JOIN

SELECT
e.employee_id,
e.first_name AS name,
e.last_name AS surname,
-- e.manager_id ,
-- m.employee_id,
m.first_name AS manager_name,
m.last_name AS manage_surname
FROM employees AS e
INNER JOIN employees AS m
ON e.manager_id = m.employee_id;

-- summary lesson

-- Task 4 : print name, surname, job_id employee with salary more than his manager salary
USE HR;

SELECT *
FROM employees;

SELECT 
e.first_name,
e.last_name,
e.job_id,
e.salary as employee_salary,
m.salary as manager_salary
FROM employees AS e
INNER JOIN employees AS m
ON e.manager_id = m.employee_id  -- AND e.salary > m.salary;
WHERE e.salary > m.salary;


SELECT * 
FROM countries;

SELECT * 
FROM regions;

-- Task 5 : print all country name and its region name
SELECT
t1.country_name,
t2.region_name
FROM countries AS t1
INNER JOIN regions AS t2
ON t1.region_id = t2.region_id;

-- Task 6 : print all location city , province, country_name
SELECT 
l.city,
l.state_province,
c.country_name
FROM locations AS l
INNER JOIN countries AS c
ON l.country_id = c.country_id;

-- Task 7 : print all location city , province, country_name and region_name
SELECT 
l.city,
l.state_province,
c.country_name,
r.region_name
FROM locations AS l
INNER JOIN countries AS c
ON l.country_id = c.country_id
INNER JOIN regions AS r
ON c.region_id = r.region_id;

-- Task 8 : - print name, surname and city where employee work

SELECT *
FROM employees;

SELECT *
FROM departments;

SELECT *
FROM locations;

SELECT
e.first_name,
e.last_name,
-- e.department_id,
-- d.department_id,
-- d.location_id,
-- l.location_id,
l.city
FROM employees AS e
INNER JOIN departments AS d
ON e.department_id = d.department_id
INNER JOIN locations AS l
ON d.location_id = l.location_id;

SELECT
e.first_name,
e.last_name,
-- e.department_id,
-- d.department_id,
-- d.location_id,
-- l.location_id,
l.city
FROM employees AS e
INNER JOIN departments AS d
ON e.department_id = d.department_id
INNER JOIN locations AS l
ON d.location_id = l.location_id AND l.city IN('Seattle','Toronto');

-- lesson six

-- LEFT JOIN , RIGHT JOIN, SELF JOIN(это не команда , а подход)

-- При левом соединение за основу берутся все строки левой таблицы, далее присоедняются колонки
-- из правой таблицы, для тех строк, для которых есть совпадение в правой таблице, в присоединяемых
-- колонках будет значение из правой таблицы, а для тех строк левой таблицы, для которых совпадений нет
-- в присоединяемых колонках будет null

USE learn;

SELECT 
* 
FROM person;

SELECT 
*
FROM ages;

SELECT 
p.name,
a.age
FROM person AS p
INNER JOIN ages AS a
ON p.id = a.person_id;

SELECT 
p.name,
a.age
FROM person AS p -- person левая таблица
LEFT JOIN ages AS a -- ages правая таблица
ON p.id = a.person_id;

-- В отличие от внутреннего соединения, здесь принципиально какая таблица левая, какая правая,
-- за основу здесь берется левая таблица!!! 
-- При внутреннем соединении - все равно где какая таблица

-- Task 1 : Вывести всех персон, для которых не задан возраст(person, ages)

-- все для которых - задано, заполнено, существует и тд  - практически всегда это INNER JOIN
-- все для которых - не задано, не заполнено, не найдено, нет - практически всегда LEFT JOIN

SELECT
p.id,
p.name,
a.age
FROM person AS p
LEFT JOIN ages AS a
ON p.id = a.person_id -- AND a.age IS NULL;
WHERE a.age IS NULL;

-- WHERE - сначала все присоединяем, а потом уже фильтруем те строки для которых в присоединяемых колонках
-- значение null - для этой задачи это корректно!!!


-- все для которых - задано, заполнено, существует и тд  - практически всегда это INNER JOIN
-- все для которых - не задано, не заполнено, не найдено, нет - практически всегда LEFT JOIN

-- если в результируещем запросе нам не нужны колонки из второй таблицы, то такие задачи можно
-- решить через подзапрос!!!!

-- Task 1-1 : Вывести всех персон, для которых не задан возраст(person, ages) - решение через подзапрос

SELECT
id, 
name 
FROM person
WHERE id  IN (  SELECT
				person_id
				FROM ages);


SELECT
person_id
FROM ages;

USE HR;

-- Task 2 : Необходимо вывести названия департаментов, в которых никто не работает
SELECT
* 
FROM departments;

SELECT
*
FROM employees;

SELECT
d.department_name,
d.department_id,
e.department_id,
e.employee_id
FROM departments AS d
LEFT JOIN employees AS e
ON d.department_id = e.department_id
WHERE e.department_id IS NULL;


SELECT
department_name
FROM departments
WHERE department_id NOT IN (
							SELECT
							department_id
							FROM employees
 						    WHERE department_id IS NOT NULL);
                            
USE learn;

-- RIGHT JOIN

-- При правом соединении за основу берутся все строки правой таблицы, далее присоедняются колонки
-- из левой таблицы, для тех строк, для которых есть совпадение в левой таблице, в присоединяемых
-- колонках будет значение из левой таблицы, а для тех строк правой таблицы, для которых совпадений нет
-- в присоединяемых колонках будет null

SELECT
p.id,
p.name,
a.age,
a.person_id
FROM person AS p
RIGHT JOIN ages AS a -- за основу берутся строки правой таблицы!!! в левом - основа левая таблица!
ON p.id = a.person_id;

SELECT
p.id,
p.name,
a.age,
a.person_id
FROM ages AS a
LEFT JOIN person AS p 
ON p.id = a.person_id;

-- FULL JOIN  - LEFT JOIN + UNION ALL + RIGHT JOIN

-- shop

USE shop;

SELECT *
FROM CUSTOMERS ;

SELECT *
FROM SELLERS;

SELECT *
FROM ORDERS;

-- Task 2 : print name for all sellers and name their boss

SELECT
s.SNAME AS seller_name,
s.BOSS_id,
b.SNAME AS boss_name
FROM SELLERS AS s
LEFT JOIN SELLERS AS b
ON s.BOSS_id = b.SELL_ID;

-- Task 3 : print all customers and their orders id

SELECT
c.CNAME,
c.CUST_ID,
o.ORDER_ID
FROM customers AS c
LEFT JOIN orders AS o
ON c.CUST_ID = o.CUST_ID;

-- Task 4: print client name, order amount for clients with order amount more than 1000

SELECT
c.CNAME,
c.CUST_ID,
o.ORDER_ID,
o.AMT
FROM customers AS c
LEFT JOIN orders AS o
ON c.CUST_ID = o.CUST_ID
WHERE o.AMT > 1000;

SELECT
c.CNAME,
c.CUST_ID,
o.ORDER_ID,
o.AMT
FROM customers AS c
INNER JOIN orders AS o
ON c.CUST_ID = o.CUST_ID AND o.AMT > 1000;

-- summary 

USE shop;

-- Task 1 : print all sellers(id, name) and their orders(id, date)

SELECT
s.sell_id AS id,
s.sname AS name,
o.order_id AS order_id,
o.odate AS date
FROM sellers AS s
LEFT JOIN orders AS o
ON s.sell_id = o.sell_id;

-- Task 2 : print customers name with orders and add to result sellers name
SELECT 
c.cname AS name,
s.sname AS seller_name
FROM customers AS c
INNER JOIN orders AS o
ON c.cust_id = o.cust_id
INNER JOIN sellers AS s
ON s.sell_id = o.sell_id;

-- add conditional sellers and customers from different cities

SELECT 
c.cname AS name,
s.sname AS seller_name
FROM customers AS c
INNER JOIN orders AS o
ON c.cust_id = o.cust_id
INNER JOIN sellers AS s
ON s.sell_id = o.sell_id
WHERE c.city <> s.city;


-- Task 3 : print customers name without any orders

SELECT
c.cname,
o.order_id
FROM customers AS C
LEFT JOIN orders AS o
ON c.cust_id = o.cust_id
WHERE o.order_id IS NULL;

SELECT
cust_id,
cname
FROM customers
WHERE cust_id NOT IN (
					SELECT
					cust_id
					FROM orders);
                    
-- Task 4 : print seller name, boss name,   difference between boss comm and sel comm  
-- include sellers without boss     

SELECT
s.sell_id AS seller_id,
s.sname AS seller_name,
s.boss_id AS seller_boss,
b.comm - s.comm AS difference
FROM sellers AS s
LEFT JOIN sellers b
ON s.boss_id = b.sell_id;  

-- lesson seven

CREATE DATABASE uni;
USE uni;

-- students (id - pk ai, name string 128 not null, age int)

CREATE TABLE students (
id integer primary key auto_increment,
name varchar(128) not null,
age integer
);

-- teachers (id - pk ai, name string 128 not null, age int)
CREATE TABLE teachers (
id integer primary key auto_increment,
name varchar(128) not null,
age integer
);

-- competencies (id - pk ai,title string 128 not null)
CREATE TABLE competencies (
id integer primary key auto_increment,
title varchar(128) not null
);

-- teachers2competencies (id - pk ai, teacher_id int, competencies_id int)
CREATE TABLE teachers2competencies (
id integer primary key auto_increment,
teacher_id integer,
competencies_id integer
);

-- courses (id - pk ai,teacher_id, title string 128 not null, headman_id int)
CREATE TABLE courses (
id integer primary key auto_increment,
teacher_id integer,
title varchar(128) not null,
headman_id integer
);

-- students2courses (id - pk ai, student_id, course_id)
CREATE TABLE students2courses (
id integer primary key auto_increment,
student_id integer,
course_id integer
);

insert into students (name, age) values ('Анатолий', 29);
insert into students (name, age) values ('Олег', 25);
insert into students (name, age) values ('Семен', 27);
insert into students (name, age) values ('Олеся', 28);
insert into students (name, age) values ('Ольга', 31);
insert into students (name, age) values ('Иван', 22);

insert into teachers (name, age) values ('Петр', 39);
insert into teachers (name, age) values ('Максим', 35);
insert into teachers (name, age) values ('Антон', 37);
insert into teachers (name, age) values ('Всеволод', 38);
insert into teachers (name, age) values ('Егор', 41);
insert into teachers (name, age) values ('Светлана', 32);

insert into Competencies (title) values ('Математика');
insert into Competencies (title) values ('Информатика');
insert into Competencies (title) values ('Программирование');
insert into Competencies (title) values ('Графика');

insert into Teachers2Competencies (teacher_id, competencies_id) values (1, 1);
insert into Teachers2Competencies (teacher_id, competencies_id) values (2, 1);
insert into Teachers2Competencies (teacher_id, competencies_id) values (2, 3);
insert into Teachers2Competencies (teacher_id, competencies_id) values (3, 2);
insert into Teachers2Competencies (teacher_id, competencies_id) values (4, 1);
insert into Teachers2Competencies (teacher_id, competencies_id) values (5, 3);

insert into courses (teacher_id, title, headman_id) values (1, 'Алгебра логики', 2);
insert into courses (teacher_id, title, headman_id) values (2, 'Математическая статистика', 3);
insert into courses (teacher_id, title, headman_id) values (4, 'Высшая математика', 5);
insert into courses (teacher_id, title, headman_id) values (5, 'Javascript', 1);
insert into courses (teacher_id, title, headman_id) values (5, 'Базовый Python', 1);

insert into students2courses (student_id, course_id) values (1, 1);
insert into students2courses (student_id, course_id) values (2, 1);
insert into students2courses (student_id, course_id) values (3, 2);
insert into students2courses (student_id, course_id) values (3, 3);
insert into students2courses (student_id, course_id) values (4, 5);

SELECT
*
FROM students;

SELECT
*
FROM courses;

SELECT
*
FROM students2courses;

-- 1:1, 1:M, M:M ; One-to-One, One-to-Many, Many-to-Many

-- Task 1 : Вывести имена студенов и названия курсов, которые они проходят
SELECT
t1.name,
-- t1.id,
-- t2.student_id,
-- t2.course_id,
-- t3.id,
t3.title
FROM students AS t1
INNER JOIN students2courses AS t2
ON t1.id = t2.student_id
INNER JOIN courses AS t3
ON t3.id = t2.course_id;

-- Task 2 : Вывести имена всех преподавателей и названия их компетенций
-- в выборке должны быть и те преподаватели у которых компетенций нет

SELECT
*
FROM teachers;

SELECT
*
FROM competencies;

SELECT
*
FROM teachers2competencies;

SELECT
t1.name,
-- t1.id,
-- t2.teacher_id,
-- t2.competencies_id,
t3.title
FROM teachers t1
LEFT JOIN teachers2competencies AS t2
ON t1.id = t2.teacher_id
LEFT JOIN competencies t3
ON t3.id = t2.competencies_id;

-- Task 3 :  Вывести преподавателя без компетенций
SELECT
t1.name,
t2.teacher_id
FROM teachers t1
LEFT JOIN teachers2competencies AS t2
ON t1.id = t2.teacher_id
WHERE t2.teacher_id IS NULL;

SELECT
name
FROM teachers
WHERE id NOT IN (
				SELECT
				teacher_id
				FROM teachers2competencies);

-- Task 4 :  Вывести студентов которые не проходят ни один курс
SELECT
t1.id,
t1.name,
t2.student_id
FROM students AS t1
LEFT JOIN students2courses AS t2
ON t1.id = t2.student_id
WHERE t2.student_id IS NULL;

SELECT
name
FROM students
WHERE id NOT IN (
				SELECT
				student_id
				FROM students2courses);

-- Task 5 : Вывести курсы, которые не посещает ни один студент
SELECT
t1.title,
t2.course_id
FROM courses AS t1
LEFT JOIN students2courses AS t2
ON t1.id = t2.course_id
WHERE t2.course_id IS NULL;

SELECT
title
FROM courses
WHERE id NOT IN (
				SELECT
				course_id
				FROM students2courses);
                

-- summary lesson

-- millis , 1 Jan 1970 03-00

-- Основные типы колонок для хранения даты в SQL
-- Date - пример формата данного типа  2024.10.27
-- Time - хранит только время 21:05
-- DateTime - хранит дату и время вместе date+time 
-- Timestamp - формат  хранения даты и времени в миллисекундах
-- Year - хранит только год (обрезанный int)

-- Функции для получения текущей даты :

SELECT curdate();  -- only date
SELECT now();      -- date + time when script run (request)
SELECT sysdate();  -- date + time when function run

-- Конвертация строки в дату :

SELECT str_to_date("2024-10-27 21:15:20", "%Y-%m-%d %H:%i:%s");

SELECT str_to_date("2024-10-27 21:15:20", "%Y-%m-%d");

SELECT str_to_date("27-10-2024 21:15:20", "%d-%m-%Y");

-- Извлечь часть даты из строкового значения

SELECT extract(hour from "2024-10-27 21:15:20");
SELECT extract(month from "2024-10-27 21:15:20");
SELECT extract(year from "2024-10-27 21:15:20");
SELECT extract(day from "2024-10-27");
SELECT extract(hour_minute from "024-10-27 21:15:20");
-- hour, month, year, day, minute, second, year_month, day_second, hour_minute

-- date_add, date_sub - Функции для прибавления и вычитания чего-то из даты
SELECT date_add("2024-10-27 21:15:20", interval 5 day); -- add 5 days to date

SELECT date_add("2024-10-27 21:15:20", interval -5 day); -- substract 5 days from date

SELECT date_sub("2024-10-27 21:15:20", interval 5 day); -- substract 5 days from date

SELECT date_add("2024-10-27 21:15:20", interval 5 month); -- add 5 months to date

-- datediff
SELECT datediff("2024-10-27", "2024-11-27"); -- difference between dates in days
SELECT datediff("2024-10-27", "2024-06-27"); -- difference between dates in days


use shop;

SELECT 
* 
FROM orders;

-- Task 1 : print all orders in March
SELECT
MONTH(odate),
odate
FROM orders;

SELECT
*
FROM orders
WHERE MONTH(odate) = 3;

-- Task 2 : print all orders from 10.04.2022 to 10.05.2022 (include these dates)

SELECT 
*
FROM orders
WHERE odate between '2022-04-01' and '2022-05-10';

-- Task 3 : print all orders in Tuesday
-- WEEKDAY, DAYOFWEEK

SELECT
odate,
WEEKDAY(odate),  -- starts from 0 (Monday - 0, Tuesday - 1 etc)
DAYOFWEEK(odate) -- starts from sunday ( Sunday -1 , Monday - 2 etc)
FROM orders;

SELECT 
*
FROM orders
WHERE WEEKDAY(odate) = 1;

-- Task 4 : print all customers who make orders in Tuesday
SELECT
*
FROM customers;

SELECT
t1.*,
t2.*
FROM customers AS t1
INNER JOIN orders AS t2
ON t1.cust_id = t2.cust_id AND WEEKDAY(t2.odate) = 1;

-- lesson eight

-- sum(column_name) - суммирует все значения в колонке
-- avg(column_name) - вычисляет среднее значение по колонке
-- max(column_name) - находит максимальное значение в этой колонке
-- min(column_name) - находит минимальное значение в этой колонке

-- count(column_name) - подсчитывает все not null значения в этой колонке
-- count(*) - подсчитает все строки в выборке

use hr;

SELECT *
FROM employees;

SELECT
SUM(salary),
AVG(salary),
MIN(salary),
MAX(salary),
COUNT(salary)
FROM employees;

SELECT
COUNT(department_id) as count_of_employees -- count all not null values
FROM employees;

SELECT
COUNT(*) as count_of_employees -- count all lines in select
FROM employees;

-- incorrect
SELECT
first_name,
SUM(salary) AS sum_of_salaries
FROM employees;
-- выборка по имени даст 107 строк, выборка по сумме одну, как их совместить вместе -  непонятно
-- поэтому такой запрос не будет работать
-- результат работы агрегатных функций не работает вместе с полями

-- Task 1 : Вывести имя и фамилию сотрудника с максимальной зарплатой

-- incorrect version!!!
SELECT
first_name,
last_name,
MAX(salary) AS max_salary
FROM employees;

SELECT
first_name,
last_name,
salary
FROM employees
WHERE salary = (
				SELECT 
				MAX(salary)
				FROM employees);
                
-- Task 2 : Найти сотрудников,у которых зарплата меньше средней зарплаты по компании

SELECT
first_name,
last_name,
salary
FROM employees
WHERE salary < (SELECT
				AVG(salary)
				FROM employees);
                
-- Task 3: Найти количество департаментов, в которых никто не работает          

-- 1) Найти департаменты в которых никто не работает
-- 2) Посчитать что получилось
	
-- пункт 1 можно решить через JOIN or SUBSELECT

SELECT 
COUNT(*) AS department_cnt
FROM departments AS t1
LEFT JOIN employees AS t2
ON t1.department_id = t2.department_id
WHERE t2.employee_id IS NULL;

SELECT
COUNT(*) AS department_cnt
FROM departments
WHERE department_id NOT IN (SELECT
							department_id
							FROM employees
							WHERE department_id IS NOT NULL);
                            
-- Task 4 : Найти количество сотрудников из департамента с ид 60 и зарплатой больше чем средняя
-- запрлата по компании

SELECT
COUNT(*) AS count_of_employees
FROM employees
WHERE department_id = 60 AND salary > (SELECT
										AVG(salary)
										FROM employees);
                                        
-- DISTINCT - отбор только уникальных значений 
                                        
SELECT
COUNT(DISTINCT department_id) AS count_of_dpt
FROM employees;

SELECT
COUNT(department_id),
COUNT(*),
COUNT(DISTINCT department_id) 
FROM employees;

-- GROUP BY
-- Посчитать сумму всех зарплат в каждом департаменте
/*
d_id 	salary
40		10    
40		15
50		5
60		12
70		5
70		10
70		20

-- SELECT d_id, SUM(salary) FROM table GROUP BY d_id;

40	10 	id = 40 , sum = 25
40	15

50 5 	id = 50 , sum = 5

60 12 	id = 60 , sum = 12

70 5	id = 70, sum = 35
70 10
70 20

d_id   sum
40		25
50		5
60		12
70		35
*/

SELECT
department_id,
SUM(salary)
FROM employees
GROUP BY department_id;

-- Работа группировки : Сначала записи в таблице группируютя в кучки по признаку поля , которе
-- указано после слов GROUP BY, а потом к каждой кучке применяется агрегатная функция

-- Task 5 : Посчитать количество сотрудников в каждом департаменте

SELECT
department_id,
COUNT(*) AS count_emp_each_departments
FROM employees
GROUP BY department_id;

-- Task 6 : Найти департамент с максимальным количеством сотрудников

SELECT
department_id,
COUNT(*) AS cnt
FROM employees
GROUP BY department_id;


SELECT
MAX(t1.cnt)
FROM (SELECT
		department_id,
		COUNT(*) AS cnt
		FROM employees
		GROUP BY department_id) AS t1;
        
        
        
SELECT
t2.department_id,
t2.cnt
FROM (SELECT
		department_id,
		COUNT(*) AS cnt
		FROM employees
		GROUP BY department_id) AS t2
WHERE t2.cnt = (SELECT
					MAX(t1.cnt)
					FROM (SELECT
							department_id,
							COUNT(*) AS cnt
							FROM employees
							GROUP BY department_id) AS t1);


-- summary - агрегатная функция нужна для вычисления какого либо значения по колонке
-- count, sum, min, max, avg
-- count , count (*) 
-- count (*) - все строки включая null
-- count (column) - все значения в колонке , кроме null

use hr;

SELECT
COUNT(department_id),
COUNT(*),
COUNT(DISTINCT department_id) 
FROM employees;

SELECT *
FROM employees;

SELECT 
SUM(salary)
FROM employees;

SELECT
SUM(salary),
department_id
FROM employees
GROUP BY department_id;

use shop;
-- Task 1: определить среднюю стоимость покупок
-- определить среднюю стоимость покупок в марте

SELECT
AVG(AMT)
-- odate,
-- MONTH(odate)
FROM orders
WHERE MONTH(odate) = 3;

-- Task 2 : определить какие покупки были совершены во вторник
SELECT *
FROM orders
WHERE WEEKDAY(odate) = 1;

-- Task 3: Определить сколько было совершено покупок в каждый месяц
-- отсортировать результат по возрастанию количества покупок

c
ORDER BY cnt;


-- Task 4: Определить в какой месяц было совершено максимальное количество покупок,
-- вывести номер месяца и количество покупок

CREATE VIEW tmp AS
SELECT 
COUNT(*) AS cnt,
MONTH(odate) as m
FROM orders
GROUP BY MONTH(odate);


SELECT *
FROM tmp
WHERE cnt = (SELECT MAX(cnt) FROM tmp);


-- lesson 

use hr;

SELECT 
*
FROM employees;

SELECT
department_id,
SUM(salary)
FROM employees
GROUP BY department_id;

-- print departments with sum salary > 50000

-- having - оператор условия, который применяется на агрегированные данные
-- когда нужно применить фильтр на то, что получилось в результате работы 
-- какой то агрегатной функции к каким-то группам

SELECT
department_id,
SUM(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 50000;
-- 1) Сгруппировали по кучкам 2) внутри каждой кучки посчитали сумму 
-- 3) к посчитанной сумме применили фильтр и оставили только те записи
-- где сумма больше чем 50000

-- Task 1 : Вывести ид департамента и количество сотрудников, но только 
-- те, где количество сотрудников больше чем 10

SELECT
department_id,
COUNT(*) AS cnt
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 10;

-- Task 2 : Вывести название департамента , в которых работает больше 10 человек

SELECT
department_name
FROM departments
WHERE department_id IN (SELECT
							department_id
							FROM employees
							GROUP BY department_id
							HAVING COUNT(*) > 10);

SELECT
t1.department_name,
t2.cnt
FROM departments t1
INNER JOIN (
			SELECT
			department_id,
			COUNT(*) AS cnt
			FROM employees
			GROUP BY department_id
			HAVING COUNT(*) > 10) AS t2
ON t1.department_id = t2.department_id;

SELECT
*
FROM departments;

SELECT
t2.department_name
-- ,COUNT(*) AS cnt
FROM employees AS t1
INNER JOIN departments AS t2
ON t1.department_id = t2.department_id
GROUP BY t2.department_name
HAVING COUNT(*) > 10;

-- 1) Соединили две таблицы и получили нужное нам поле
-- 2) Сгруппировали по этому полю
-- 3) Посчитали количество записей в каждой группе(кучке)
-- 4) Отобрали те группы(кучки) , которые попадают под условие

-- Task 3 : Необходимо вывести названия отделов, с количеством сотрудников
-- больше среднего

-- 2) найти среднее количество сотрудников
-- 1) посчитать количество сотрудников в каждом отделе
-- 3) отобрать только те отделы, где количество больше чем среднее из п 1
-- 4) присоединить наименование отдела


-- avg ? all company ? or between departments

SELECT
AVG(t1.cnt)
FROM (SELECT
		department_id,
		COUNT(*) AS cnt
		FROM employees
		GROUP BY department_id) AS t1;
-- 8,91
-- Найти названия департаментов с количеством сотрудников больше 8,91

SELECT
department_name
FROM departments
WHERE department_id IN (SELECT
						department_id
						FROM employees
						GROUP BY department_id
						HAVING COUNT(*) > (SELECT
											AVG(t1.cnt)
											FROM (SELECT
													department_id,
													COUNT(*) AS cnt
													FROM employees
													GROUP BY department_id) AS t1) );
 -- Task 4 : Найти департамент с максимальным количеством сотрудников

SELECT
MAX(t1.cnt)
FROM (SELECT
		department_id,
		COUNT(*) AS cnt
		FROM employees
		GROUP BY department_id) AS t1;
        
-- 45

SELECT
department_name
FROM departments
WHERE department_id = (SELECT
						department_id
						FROM employees
						GROUP BY department_id
						HAVING COUNT(*) = (SELECT
											MAX(t1.cnt)
											FROM (SELECT
													department_id,
													COUNT(*) AS cnt
													FROM employees
													GROUP BY department_id) AS t1));

-- SELECT
-- fields
-- FROM table
-- JOIN table
-- ON fields
-- WHERE field
-- GROUP BY field
-- HAVING agr(field)
-- ORDER field

CREATE DATABASE interview;
USE interview;

Create table If Not Exists Sales (sale_id int, product_id int, year int, quantity int, price int);
Create table If Not Exists Product (product_id int, product_name varchar(10));
Truncate table Sales;
insert into Sales (sale_id, product_id, year, quantity, price) values ('1', '100', '2008', '10', '5000');
insert into Sales (sale_id, product_id, year, quantity, price) values ('2', '100', '2009', '12', '5000');
insert into Sales (sale_id, product_id, year, quantity, price) values ('7', '200', '2011', '15', '9000');
Truncate table Product;
insert into Product (product_id, product_name) values ('100', 'Nokia');
insert into Product (product_id, product_name) values ('200', 'Apple');
insert into Product (product_id, c) values ('300', 'Samsung');

-- Task1 Вывести год цену и наименование продукта

/*
+--------------+-------+-------+
| product_name | year  | price |
+--------------+-------+-------+
| Nokia        | 2008  | 5000  |
| Nokia        | 2009  | 5000  |
| Apple        | 2011  | 9000  |
+--------------+-------+-------+
*/

SELECT
t1.product_name,
t2.year,
t2.price
FROM product AS t1
INNER JOIN sales AS t2
ON t1.product_id = t2.product_id;

-- Task2 Вывести количество всего проданного товара по product_id

/*
+--------------+----------------+
| product_id   | total_quantity |
+--------------+----------------+
| 100          | 22             |
| 200          | 15             |
*/


SELECT 
* 
FROM sales;

SELECT
product_id,
SUM(quantity) AS total_quantity
FROM sales
GROUP BY product_id;

-- Taks 3 : Вывести количество всего проданного товара по product_id в каждый год
SELECT
year,
product_id,
SUM(quantity) AS total_quantity
FROM sales
GROUP BY year, product_id;


DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Product;

Create table If Not Exists Sales (sale_id int, product_id int, user_id int, quantity int);
Create table If Not Exists Product (product_id int, price int);

insert into Sales (sale_id, product_id, user_id, quantity) values ('1', '1', '101', '10');
insert into Sales (sale_id, product_id, user_id, quantity) values ('2', '2', '101', '1');
insert into Sales (sale_id, product_id, user_id, quantity) values ('3', '3', '102', '3');
insert into Sales (sale_id, product_id, user_id, quantity) values ('4', '3', '102', '2');
insert into Sales (sale_id, product_id, user_id, quantity) values ('5', '2', '103', '3');

insert into Product (product_id, price) values ('1', '10');
insert into Product (product_id, price) values ('2', '25');
insert into Product (product_id, price) values ('3', '15');

-- Task 4 : Вывести данные о том, какой пользователь(user_id) сколько в целом потратил
-- отсортировать по убыванию потраченного и возрастанию айди пользователя

/*
+---------+----------+
| user_id | spending |
+---------+----------+
| 101     | 125      |
| 102     | 75       |
| 103     | 75       |
+---------+----------+
*/

SELECT * FROM Sales;
SELECT * FROM Product;

SELECT
t1.user_id,
SUM(t2.price * t1.quantity) AS spending
FROM sales AS t1
INNER JOIN product AS t2
ON t1.product_id = t2.product_id
GROUP BY t1.user_id
ORDER BY spending DESC, t1.user_id ASC;

-- lesson 

-- Relationship types

-- One-to-One (1:1)
-- Для каждой строки одной таблицы, может соответствовать только одна!! строка из
-- другой таблицы

DROP DATABASE IF EXISTS relationship;
CREATE DATABASE relationship;
USE relationship;

/*
id PK| name 
1    | Alex

num PK | person_id FK
444444 | 1

save - person
save - passport

id PK| name |passport_num FK
1    | Alex | 444444

id |num PK | 
1  |444444 | 

save - person
save - passport
save - update passport_num person

*/

CREATE TABLE person(
id integer,    -- PK
name varchar(255)
);

DROP TABLE passport;

-- Если добавить ограничение уникальности на колонку, по которой будет
-- находиться соответствие между таблицами , то это будет отношение One-to-One

CREATE TABLE passport(
num varchar(16),
person_id integer unique -- One-to-One    -- FK
);

INSERT INTO person(id, name) VALUES(1,'Alexx'),(2,'Oleg');
INSERT INTO passport(num, person_id) VALUES ('5555555',1),('4444444',2);

SELECT * FROM person;
SELECT * FROM passport;

SELECT
t1.id,
t1.name,
t2.num
FROM person AS t1 
INNER JOIN passport AS t2
ON t1.id = t2.person_id;

INSERT INTO passport(num, person_id) VALUES ('333333',1);

-- Таблица паспортов и таблица персон находятся теперь в отношении (1:1)

-- One-to-Many (1:M) 
-- Для одной строки одной таблицы, может соответствовать несколько строк из другой
-- таблице

CREATE TABLE student (
id integer primary key,
name varchar(64)
);

CREATE TABLE order_course(
order_id integer,
title varchar(64),
student_id integer
);

INSERT INTO student(id, name) VALUES (1,'Alex'),(2, 'Maxim');
INSERT INTO order_course(order_id, title, student_id) VALUES
													(1,'Java',2),(2, 'JS',2),(3,'SQL',1);
                                                    
SELECT * FROM student;
SELECT * FROM order_course;

SELECT
t1.id AS student_id,
t1.name,
t2.order_id AS course_id,
t2.title AS course_title
FROM student AS t1
LEFT JOIN order_course AS t2
ON t1.id = t2.student_id;

-- Таблица студентов и таблица курсов находятся во взаимоотношении (1:M)   

-- Many-to-Many (M:M) - Для одной строки из первой таблицы, может соответствовать
-- несколько строк из второй таблицы и наоброт, для любой строки второй таблицы,
-- может соответствовать несколько строк из первой таблицы

CREATE TABLE customer(
id integer,
name varchar(64)
);

CREATE TABLE shop(
id integer,
title varchar(64),
address varchar(64)
);

INSERT INTO customer(id, name) VALUES (1,'Alex'),(2,'Max'),(3,'Oleg');
INSERT INTO shop(id, title, address) VALUES (1,'Amazon','Berlin'),(2,'Wallmart','Ontario');

CREATE TABLE shop2customer(
customer_id integer,
shop_id integer
);
-- Alex - Amazon; Max - Amazon, Wallmart; Oleg - Wallmart
-- Amazon - Alex,Max;  Wallmart - Oleg, Max
INSERT INTO shop2customer(customer_id, shop_id) VALUES (1,1),(2,1),(2,2),(3,2);

SELECT * FROM customer;
SELECT * FROM shop;
SELECT * FROM shop2customer;

SELECT
t1.id AS customer_id,
t1.name AS customer_name,
t3.id AS shop_id,
t3.title AS shop_title,
t3.address AS shop_address
FROM customer AS t1
LEFT JOIN shop2Customer AS t2
ON t1.id = t2.customer_id
LEFT JOIN shop AS t3
ON t3.id = t2.shop_id
WHERE t1.id = 2;

SELECT
t3.id AS shop_id,
t3.title AS shop_title,
t3.address AS shop_address,
t1.id AS customer_id,
t1.name AS customer_name
FROM shop AS t3
LEFT JOIN shop2Customer AS t2
ON t3.id = t2.shop_id
LEFT JOIN customer AS t1
ON t1.id = t2.customer_id
WHERE t3.id = 1;

-- PRIMARY KEY, FOREIGN KEY

-- PRIMARY KEY (unique  + not null) 
-- Первычный ключ может быть натуральный(естественный) или искусственный (id)

-- искусственный (id integer primary key)
-- натуральный (passport_number varchar(64) pimary key)

CREATE TABLE person_correct(
id integer primary key,
name varchar(255)
);

-- FOREIGN KEY - значение в колонке , которая является внешним ключем одной таблицы
-- это значение из колонки , которая является первичным ключем в другой таблице

DROP TABLE passport_correct;

CREATE TABLE passport_correct(
id integer primary key,
num varchar(16),
person_id integer unique,
FOREIGN KEY (person_id) REFERENCES person_correct (id) ON DELETE CASCADE
);

-- текущая таблица - (passport_correct) - 1
-- таблица (person_correct) - 2 
-- FOREIGN KEY (имя_колонки из 1) REFERENCES таблицу 2  (имя колонки первичного ключа из 2)
 
INSERT INTO person_correct(id, name) VALUES(1,'Alexx'),(2,'Oleg');
-- Error Code: 1062. Duplicate entry '1' for key 'person_correct.PRIMARY'

INSERT INTO passport_correct(id, num, person_id) VALUES (1,'5555555',1);

INSERT INTO passport_correct(id, num, person_id) VALUES (2,'4444444',2);
-- Error Code: 1452. Cannot add or update a child row: 
-- a foreign key constraint fails (`relationship`.`passport_correct`, 
-- CONSTRAINT `passport_correct_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person_correct` (`id`))


SELECT * FROM person_correct;
SELECT * FROM passport_correct;

DELETE FROM person_correct WHERE id = 1;
-- Error Code: 1451. Cannot delete or update a parent row: 
-- a foreign key constraint fails (`relationship`.`passport_correct`, 
-- CONSTRAINT `passport_correct_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person_correct` (`id`))

-- ON DELETE CASCADE - добавление к внешнему ключу, которое говорит о том, что если запись с первичным
-- ключем будет удалена , то удаляются и все записи из таблиц, которые ссылались на этот первичный ключ

-- AFTER ADD ON DELETE CASCADE

DELETE FROM person_correct WHERE id = 1;

CREATE TABLE customer(
id integer primary key,
name varchar(64)
);

CREATE TABLE shop(
id integer primary key,
title varchar(64),
address varchar(64)
);

CREATE TABLE shop2customer(
customer_id integer,
shop_id integer,
FOREIGN KEY (customer_id) REFERENCES customer (id),
FOREIGN KEY (shop_id) REFERENCES shop (id)
);


-- Вполне достаточно , что бы СКЛ таблица находилась в третьей нормальной форме
-- 1NF, 2NF, 3NF

/*
name | surname | phone
Alex | Alexeev | 6665,7778
Oleg | Olegov. | 6664, 7774, 4444

fio 		 | age | rate
Alex Alexeev | 30. | 5
Oleg Olegov. | 23  | 2

-- 1NF - говорит о том, что в колонках таблицы, не должно быть составных значений
или набора значений ( не должно быть массивов, строк через запятую)
-- fio -> first_name,last_name; address -> country, city, street, building

name | surname | age | rate
Alex | Alexeev | 30. | 5
Oleg | Olegov. | 23  | 2

name | surname | phone
Alex | Alexeev | 6665
Alex | Alexeev | 7778
Oleg | Olegov. | 6664
Oleg | Olegov. | 7774
Oleg | Olegov. | 4444

name | surname | id
Alex | Alexeev | 1
Oleg | Olegov. | 2

phone | person_id
6665  | 1
7778. | 1
6664. | 2
7774. | 2
4444. | 2
*/


-- 2NF -> 1NF  + Primary key - данная нормальная форма говорит о том, что таблица
-- должна соответствовать первой нормальной форме и иметь первичный ключ
/*
name | surname | id(PK)
Alex | Alexeev | 1
Oleg | Olegov. | 2

phone(PK)   | person_id
6665  		| 1
7778. 		| 1
6664. 		| 2
7774. 		| 2
4444. 		| 2
*/

-- 3NF -> 2 NF + (id (PK) | name | course_id | course_title | course_description) 
-- > не должно быть зависимостей между неключевыми полями ->
-- >(id (PK) | name | course_id ), (course_id(PK) | course_title | course_description)

/*
Students:
id (PK) | name | course_id | course_title | course_description
1		| Alex | 3		   | Java		  | Java prof course
2	    | Oleg | 4 		   | SQL	      | SQL for beginners

Students:
id (PK) | name | course_id 
1		| Alex | 3		   
2	    | Oleg | 4 		   

Courses:
course_id(PK) | course_title | course_description
3		       | Java		 | Java prof course
4 		       | SQL	     | SQL for beginners
*/

use hr;
select * from employees;



select * from departments;


/*
Buyer 
id | name | surname 


Address 
id | city | street | building | buyer_id

*/

-- Task : 
/*
User : 

name surname | birth date | phone number | cell_operator | zodiac sign | city | country |

1NF :
name | surname | birth date | phone number | cell_operator | zodiac sign | city | country |

2NF :
id(PK) | name | surname | birth date | phone number | cell_operator | zodiac sign | city | country |

3NF : 

id(PK) | name | surname | birth date | phone_number | location_id


Phones :
phone_number(PK) | cell_operator 

Locations :
id (PK) | city | country_id|
1		Berlin 	Germany


Countries : 
country(PK) | 

Zodiacs : 
zodiac_sign(PK) | start_date | end_date 

*/

/*
Спроектировать службу заказа такси :

Driver
Car
Client
Order
Operator
Service class
Feedback

*/

CREATE DATABASE taxi;
use taxi;

CREATE TABLE cars(
plate integer primary key,
model varchar(32),
class varchar(32)
);

CREATE TABLE drivers (
id integer primary key auto_increment,
name varchar(32),
surname varchar(32),
car_id integer,
FOREIGN KEY (car_id) REFERENCES cars (plate)
);

CREATE TABLE clients (
id integer primary key auto_increment,
name varchar(32),
surname varchar(32),
rate integer
);


CREATE TABLE operators (
id integer primary key auto_increment,
name varchar(32),
surname varchar(32),
alias varchar(16)
);

CREATE TABLE service_classes (
type varchar(16) primary key, 
descr varchar(64)
);

drop table orders;
drop table feedbacks;

CREATE TABLE orders (
id integer primary key auto_increment,
start varchar(255),
finish varchar(255),
state varchar(255),
payment_method varchar(255),
amount integer,
driver_id integer,
operator_id integer,
service_type varchar(16),
client_id integer,
FOREIGN KEY (driver_id) REFERENCES drivers (id),
FOREIGN KEY (operator_id) REFERENCES operators (id),
FOREIGN KEY (service_type) REFERENCES service_classes (type),
FOREIGN KEY (client_id) REFERENCES clients (id)
);

CREATE TABLE feedbacks (
id integer primary key auto_increment,
feedback varchar(255),
order_id integer unique,
FOREIGN KEY (order_id) REFERENCES orders (id)
);



