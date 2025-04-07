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

select * from SELLERS;
select * from CUSTOMERS;
select * from ORDERS;

-- 1. Вывести имена продавцов и их начальников.
select sell.SNAME as seller_name, boss.SNAME as boss_name
from SELLERS as sell
join SELLERS as boss
on  sell.BOSS_ID = boss.SELL_ID;

-- 2. Вывести продавцов, у которых тот же начальник, что и у "Екатерины".
select * from SELLERS
where BOSS_ID = (select BOSS_ID 
				from SELLERS
                where SNAME = 'Екатерина')
and SNAME != 'Екатерина';

-- 3. Вывести пары продавцов, работающих в одном городе.
select sell1.SNAME as seller_name1, sell2.SNAME as seller_name2, sell1.CITY as city
from SELLERS as sell1
join SELLERS as sell2
on sell1.SELL_ID < sell2.SELL_ID
where sell1.CITY = sell2.CITY;

-- 4. Вывести продавцов, у которых есть хотя бы один подчиненный.
select distinct boss.SNAME as boss_name
from SELLERS as sell
join SELLERS as boss
on  sell.BOSS_ID = boss.SELL_ID;

-- 5. Вывести продавцов, у которых тот же начальник, что и у продавца из "Сочи".
select * from SELLERS
where BOSS_ID = (select BOSS_ID
			from SELLERS
            where CITY = 'Сочи') and CITY != 'Сочи';
             
-- 6. Вывести пары клиентов из одного города, у которых разный рейтинг.
select cus1.CNAME as customers_name1, cus1.RATING as customers_rating1, cus2.CNAME as customers_name2, cus2.rating as customers_rating2
from CUSTOMERS as cus1
join CUSTOMERS  as cus2
on cus1.CNAME != cus2.CNAME
where cus1.CITY = cus2.CITY  and cus1.rating < cus2.rating;

-- 2 вариант
select c1.cname as c1_name, c1.city as c1_city, c1.rating as c1_rating, c2.cname as c2_name, c2.city as c2_city, c2.rating as c2_rating
from customers as c1 
join customers as c2
on c1.CUST_ID > c2.CUST_ID
where c1.CITY = c2.CITY and c1.RATING != c2.RATING;

-- 7. Вывести заказы, оформленные продавцами, у которых есть подчиненные.
select distinct boss.SNAME as boss_name, ordr.*
from SELLERS as boss
join SELLERS as sell
on  sell.BOSS_ID = boss.SELL_ID
join ORDERS as ordr
on ordr.SELL_ID = boss.SELL_ID;

-- 8. Вывести имена начальников и их подчиненных, если у начальника комиссия выше, чем у подчиненного.
select sell.SNAME as seller_name, sell.COMM as seller_comission, boss.SNAME as boss_name, boss.COMM as boss_comission
from SELLERS as sell
join SELLERS as boss
on  sell.BOSS_ID = boss.SELL_ID
where boss.COMM > sell.COMM;

-- 9. Вывести продавцов, у которых есть начальник, но сами не имеют подчиненных.
select boss.SNAME as boss_name, sell.SNAME as seller_name
from SELLERS as boss
left join SELLERS as sell 
on  boss.SELL_ID = sell.BOSS_ID
where sell.BOSS_ID is null and boss.BOSS_ID  is not null;

select sell.SNAME as seller_name
from SELLERS sell
where sell.BOSS_ID is not null
and sell.SELL_ID not in (select distinct BOSS_ID from SELLERS where BOSS_ID is not null);