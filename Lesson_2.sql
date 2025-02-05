-- Заполнение таблицы

-- Простые типы данных
-- integer/int - целое число
-- numeric/decimal - числовые данные
-- varchar(N) - строки - N - максимальное кол/во символов в  строке 
-- char(M) - строки - M - фиксированое кол/во символов в строке

-- decimal (N, M) - N - максимальное кол/во цифр, которое может хранить число (от 1 до 65) (по умолч. 10)
				 -- M - максимальное кол/во цифр, которое может хранить число после запятой(от 0 до N) (по умолч. 0)
-- decimal(5,2)
-- [-999,99 ; 999,99

 create table products(
	product_id int,
    title varchar(100),
    price decimal,
    quantity int
);

-- insert into название_таблицы
-- values (значение1, значение2, значение3, ...);

-- insert into название_таблицы (поле1, поле2, поле3, ...)
-- values (значение1, значение2, значение3, ...);

-- insert into название_таблицы (поле1, поле2, поле3, ...)
-- values (значение1, значение2, значение3, ...), 
-- (значение1, значение2, значение3, ...),
-- (значение1, значение2, значение3, ...),
-- (...);

-- Заполнить таблицу products

insert into products
values (1, 'Apple', 100, 6),
(2, 'Orange',150, 10),
(4, 'Banana', 150, 11),
(5, 'Mango', 250, 15),
(6, 'Grapes', 100,12);

insert into products 
values (3, 'Kiwi', 120, 4);

insert into products (product_id, title, quantity)
values (7, 'Pear', 8);

insert into products 
values (7, 'Pear', 8);
-- Error Code: 1054. Unknown column 'quantity' in 'field list'	0.000 sec
-- null != 0, null != '', null != undefined
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.

-- Вывести продукты, названия которых начинаются на букву 'M'.
select *
from products;
-- where title like 'm%';

-- Вывести продукты Apple, Mango и Kiwi
select *
from products
where title in ('Apple', 'Mango', 'Kiwi');

-- Вывести продукты, где цена находится в диапазоне от 100 до 150
select * 
from products
where price between 100 and 150;

-- Вывести продукты, где цена больше 100 и кол/во меньше 10.
select *
from products
where price > 100 and quantity < 10;

-- Вывести продукт, где цена не указана
select *
from products
where price is null;

select *
from products
where price is not null;

-- is null
-- is not null


-- Ограничения таблиц

-- Создание таблицы 
-- create table название_таблицы(
-- 	название_поля1 тип_данных [ограничения],
--     назнавие_поля2 тип_данных [ограничения],
--     ...
-- );

-- unique - значения должны быть уникальными;
-- not null - поле не может быть незаполненными (null);
-- primary key - not null + unique, в таблице можно исольщовать толко один раз;
-- check (условие) - значение поля соотвествует какому-либо условию;
-- default - у поля будет значение по умолчанию;
-- auto_increment - позволяет создавать уникальный номер автоматически, когда новая 
-- запись вставляется в таблицу. Часто это поле основного ключа, которое мы хотели бы создать 
-- автоматически каждый раз, когда будет вставлена новая записьproduct_id

