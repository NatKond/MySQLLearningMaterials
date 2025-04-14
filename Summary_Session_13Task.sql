-- 1. Создать и активировать базу данных tasks.
create database tasks;
use tasks;
-- 2. Создать таблицу store с полями:  
   -- • id — целое число, первичный ключ, автоинкремент.  
   -- • title — строка (128 символов), не NULL.  
   -- • price — целое число.  
   -- • quantity — целое число.
create table store(
	id int primary key auto_increment,
    title varchar(128) not null,
    price int,
    quantity int
);
-- 3. Добавить в таблицу store записи:  
   -- • title — 'Skirt', price — 120, quantity — 10.  
   -- • title — 'Shirt', price — 55, quantity — 4.  
   -- • title — 'Jeanse', price — 135, quantity — 15.  
insert into store (title, price, quantity)
values ('Skirt', 120, 10);

insert into store (title, price, quantity)
values ('Skirt', 55, 4);

insert into store (title, price, quantity)
values ('Jeanse', 135, 15);

select * from store;

-- 4. Из таблицы store вывести те товары, цена которых больше 100.  
select *
from store
where price > 100;

-- 5. Из таблицы store вывести те товары, название которых начинается на букву 'S'.  
select *
from store
where title like 'S%';

-- 6. Увеличить количество товара с названием 'Jeanse' на 5.
set sql_safe_updates = 0;

update store
set quantity = quantity + 5
where title = 'Jeanse';

-- 7. Добавить новое поле quality — целое число.  

alter table store
add column quality int;

-- 8. Заполнить поле quality:  
   -- • Если цена товара больше 100, установить значение 5.  
   -- • Если цена товара меньше или равна 100, установить значение 4.
update store
set quality = case
				when price > 100 then 5
                else 4
                end;
   
-- 9. Удалить из таблицы store товары, где количество меньше 10.
delete from store
where quantity < 10;

-- 10. Удалить таблицу store.  
drop table store;

-- 11. Удалить базу данных tasks.  
drop database tasks;

-- 12. Создать базу данных shop и заполнить её, используя скрипт:  
    -- https://github.com/annykh/GT081024-m/blob/main/shop.sql
drop database shop;

CREATE DATABASE shop;

USE shop;

CREATE TABLE SELLERS(
       SELL_ID    INTEGER, 
       SNAME   VARCHAR(20), 
       CITY    VARCHAR(20), 
       COMM    NUMERIC(2, 2),
             BOSS_ID  INTEGER
);
                                            
CREATE TABLE CUSTOMERS(
       CUST_ID    INTEGER, 
       CNAME   VARCHAR(20), 
       CITY    VARCHAR(20), 
       RATING  INTEGER
);

CREATE TABLE ORDERS(
       ORDER_ID  INTEGER, 
       AMT     NUMERIC(7,2), 
       ODATE   DATE, 
       CUST_ID    INTEGER,
       SELL_ID    INTEGER 
);

INSERT INTO SELLERS VALUES(201,'Олег','Москва',0.12,202);
INSERT INTO SELLERS VALUES(202,'Лев','Сочи',0.13,204);
INSERT INTO SELLERS VALUES(203,'Арсений','Владимир',0.10,204);
INSERT INTO SELLERS VALUES(204,'Екатерина','Москва',0.11,205);
INSERT INTO SELLERS VALUES(205,'Леонид ','Казань',0.15,NULL);


INSERT INTO CUSTOMERS VALUES(301,'Андрей','Москва',100);
INSERT INTO CUSTOMERS VALUES(302,'Михаил','Тула',200);
INSERT INTO CUSTOMERS VALUES(303,'Иван','Сочи',200);
INSERT INTO CUSTOMERS VALUES(304,'Дмитрий','Ярославль',300);
INSERT INTO CUSTOMERS VALUES(305,'Руслан','Москва',100);
INSERT INTO CUSTOMERS VALUES(306,'Артём','Тула',100);
INSERT INTO CUSTOMERS VALUES(307,'Юлия','Сочи',300);


INSERT INTO ORDERS VALUES(101,18.69,'2022-03-10',308,207);
INSERT INTO ORDERS VALUES(102,5900.1,'2022-03-10',307,204);
INSERT INTO ORDERS VALUES(103,767.19,'2022-03-10',301,201);
INSERT INTO ORDERS VALUES(104,5160.45,'2022-03-10',303,202);
INSERT INTO ORDERS VALUES(105,1098.16,'2022-03-10',308,207);
INSERT INTO ORDERS VALUES(106,75.75,'2022-04-10',304,202); 
INSERT INTO ORDERS VALUES(107,4723,'2022-05-10',306,201);
INSERT INTO ORDERS VALUES(108,1713.23,'2022-04-10',302,203);
INSERT INTO ORDERS VALUES(109,1309.95,'2022-06-10',304,203);
INSERT INTO ORDERS VALUES(110,9891.88,'2022-06-10',306,201);
    -- Техническое описание этой базы данных доступно по ссылке:  
    -- https://github.com/annykh/GT081024-m/blob/main/%D0%A2%D0%B5%D1%85_%D0%BE%D0%BF%D0%B8%D1%81%D0%B0%D0%BD%D0%B8%D0%B5_shop.txt
select * from SELLERS;
select * from CUSTOMERS;
select * from ORDERS;
-- 13. Вывести всех продавцов, чьи имена начинаются на букву 'Л'.
select *
from SELLERS
where SNAME like 'Л%';

-- 14. Вывести всех клиентов из города Тула с рейтингом больше 100.
select *
from CUSTOMERS
where CITY = 'Тула' and RATING > 100;

-- 15. Вывести всех продавцов, чьи комиссии между 0.10 и 0.15 (включительно).
select *
from SELLERS
where COMM between 0.10 and 0.15;

-- 16. Вывести пары покупателей и обслуживших их продавцов из одного города.  
select sell.SNAME as seller_name, sell.CITY as seller_city, cust.CNAME as customer_name, cust.CITY as customer_city
from SELLERS as sell
join ORDERS as ordr
on sell.SELL_ID = ordr.SELL_ID
join CUSTOMERS as cust
on ordr.CUST_ID = cust.CUST_ID
where sell.CITY = cust.CITY;

-- 17. Вывести имена продавцов, у которых нет заказов. 
select sell.SNAME, ord.ORDER_ID
from SELLERS as sell
left join ORDERS as ord
on sell.SELL_ID = ord.SELL_ID
where ORDER_ID is null;

-- 18. Вывести имена всех продавцов, которые продают товары клиентам из Тулы.  
select distinct sell.SNAME as seller_name
from SELLERS as sell
join ORDERS as ordr
on sell.SELL_ID = ordr.SELL_ID
join CUSTOMERS as cust
on ordr.CUST_ID = cust.CUST_ID
where cust.CITY = 'Тула';

-- 19. Найти среднюю сумму заказа для каждого клиента.
select cust.CNAME, avg(ordr.AMT)
from CUSTOMERS as cust
join ORDERS as ordr
on ordr.CUST_ID = cust.CUST_ID
group by cust.CNAME;

-- 20. Найти общее количество клиентов в каждом городе.
select CITY, count(CUST_ID)
from CUSTOMERS
group by CITY;

-- 21. Вывести города, в которых средняя сумма заказа превышает 2000.
select cust.CITY, avg(ordr.AMT)
from CUSTOMERS as cust
join ORDERS as ordr
on ordr.CUST_ID = cust.CUST_ID
group by cust.CITY
having avg(ordr.AMT) > 2000;

-- 22. Вывести продавцов, у которых количество заказов больше 2.
select sell.SNAME, count(ordr.ORDER_ID)
from SELLERS as sell
join ORDERS as ordr
on sell.SELL_ID = ordr.SELL_ID
group by sell.SNAME
having count(ordr.ORDER_ID) > 2;

-- 23. Определить количество заказов, сделанных клиентами из Тулы.
select cust.CITY, count(ordr.ORDER_ID)
from CUSTOMERS as cust
join ORDERS as ordr
on ordr.CUST_ID = cust.CUST_ID
where cust.CITY = 'Тула'
group by cust.CITY;
