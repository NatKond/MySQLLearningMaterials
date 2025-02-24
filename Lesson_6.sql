-- Функция CASE

-- CASE
--     WHEN условие_1 THEN результат_1
--     WHEN условие_2 THEN результат_2
--     .................................
--     WHEN условие_N THEN результат_N
--     [ELSE альтернативный_результат]
-- END

create table phones (
	id int primary key auto_increment,
    product_name varchar(128),
    product_count int,
    product_price int
);

insert into phones (product_name, product_count, product_price)
values ('iphone 15', 15, 700),
		('iphone 15 pro', 19, 750),
        ('samsung A11', 25, 600),
        ('xiaomi redmi 10', 8, 450),
        ('iphone 16', 1, 800),
        ('iphone 16 pro', 0, 900),
        ('iphone 16 pro max', 50, 1000),
        ('xiaomi redmi 11', 0, 650),
        ('sony xperia z3', 13, 720);
        
select * 
from phones;

-- Вывести название продукта, кол/во проданных продуктов, стоимость и посчитать общую сумму заказов(product_count*product_price)
select product_name, product_count, product_price, product_count*product_price as total_sum
from phones;

-- Вывести название продукта, кол/во проданных продуктов, стоимость и 
-- посчитать общую сумму заказов и вывести 'null', если кол/во(product_count) = 0, 
-- и вывести сумму, если кол/во(product_count) больше 0 
select product_name, product_count, product_price,
		case 
			when product_count > 0 then product_count*product_price
            when product_count = 0 then 'null'
		end as total_sum
from phones;

-- Вывести название продукта, кол/во товаров в наличии(product_count) и новое поле count_info, со значениями:
 -- Товар заканчивается, если кол/во меньше 2.
 -- Мало товара, если кол/во меньше 5.
 -- Есть в наличии, если кол/во меньше 15.
 -- Много товара, в остальных случаях
 
 select product_name, product_count, product_price,
		case 
			when product_count < 2 then 'Товар заканчивается'
            when product_count < 5 then 'Мало товара'
            when product_count < 15 then 'Есть в наличии'
            else 'Много товара'
		end as count_info
from phones;

-- Создать поле count_info и заполнить:
	 -- Нет в наличии, если кол/во = 0 
	 -- Товар заканчивается, если кол/во меньше 2.
	 -- Мало товара, если кол/во меньше 5.
	 -- Есть в наличии, если кол/во меньше 15.
	 -- Много товара, в остальных случаях.

alter table phones
add column count_info varchar(255);

set sql_safe_updates = 0;

update phones
set count_info = case
					when product_count = 0 then 'Нет в наличии'
                    when product_count < 2 then 'Товар заканчивается'
                    when product_count < 5 then 'Мало товара'
                    when product_count < 15 then 'Есть в наличии'
                    else 'Много товара'
				 end;

-- Переименовать поле product_name на starting_price
alter table phones
rename column product_price to starting_price;

-- Вывести product_name, starting_price и новое поле tax 
-- Заполнить поле tax:
-- Если начальная цена меньше/равно 700, tax = null,
-- если больше 700 и меньше 850, tax = 15,
-- если больше или равно 850, tax = 25

-- 1 вариант
select product_name, starting_price, 
		case 
			when starting_price <= 700 then null
            when starting_price > 700 and starting_price < 850 then 15
            when starting_price >= 850 then 25
		end as tax
from phones;

-- 2 вариант
select product_name, starting_price, 
case
			when starting_price <= 700 then null
            when starting_price < 850 then 15
            else 25
		end as tax
from phones;
        
-- Создать новое поле tax целое число
-- Заполнить поле tax:
-- Если начальная цена меньше/равно 700, tax = null,
-- если больше 700 и меньше 850, tax = 15,
-- если больше или равно 850, tax = 25
alter table phones
add column tax int;

update phones
set tax = case
			when starting_price <= 700 then null
            when starting_price < 850 then 15
            else 25
		end;
        
select *
from phones;

-- Посчитать конечную цену и представить его как final_price
-- final_price = (starting_price + starting_price * tax / 100)
-- Вывести product_name, starting_price, tax, final_pric

select product_name, starting_price, tax, (starting_price + starting_price*tax/100) as final_price
from phones;

select product_name, starting_price, tax, 
		case
			when tax is null then starting_price
            else (starting_price + starting_price * tax / 100)
		end as final_price
from phones;

-- COALESCE

-- COALESCE(выражение_1, выражение_2, выражение_N) -- возвращает первое из них, которое не равно NULL

-- coalesce('string', 0, '', null, 5) -- 'string'
-- coalesce(10 + 20 * null, round(20 / 3 * null), 'string') -- 'string'

select product_name, starting_price, tax, coalesce(starting_price + starting_price * tax / 100, starting_price) as final_price
from phones;

-- IF

-- IF(условие, значение_1, значение_2) 
-- Если условие, передаваемое в качестве первого параметра, верно, то возвращается первое значение, 
-- иначе возвращается второе значение.
-- IFNULL

-- IFNULL(выражение, значение)
-- Функция IFNULL проверяет значение некоторого выражения.
-- Если оно равно NULL, то функция возвращает значение, которое передается в качестве второго параметра

