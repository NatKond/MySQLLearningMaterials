CREATE DATABASE store;
USE store;

-- Таблица клиентов
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

-- Таблица товаров
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

-- Таблица категорий товаров
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100)
);

-- Таблица заказов
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total DECIMAL(10, 2)
);

-- Таблица деталей заказа
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2)
);


-- Заполнение таблицы клиентов
INSERT INTO customers (first_name, last_name, email) VALUES
('John', 'Doe', 'john@example.com'),
('Jane', 'Smith', 'jane@example.com'),
('Alice', 'Johnson', 'alice@example.com'),
('Bob', 'Brown', 'bob@example.com'),
('Ben', 'King', 'ben@example.com'),
('Mike', 'Cors', 'mike@example.com'),
('Jack', 'Smith', 'jack@example.com'),
('Emma', 'King', 'emma@example.com');

-- Заполнение таблицы категорий товаров
INSERT INTO categories (category_name) VALUES
('Electronics'),
('Furniture'),
('Clothing'),
('Toys');

-- Заполнение таблицы товаров
INSERT INTO products (product_name, price, category_id) VALUES
('Laptop', 1000.00, 1),
('Table', 150.00, 2),
('T-shirt', 20.00, 3),
('Bed', 100.00, 2),
('Phone', 1520.00, 1),
('Skirt', 50.00, 3);

-- Заполнение таблицы заказов
INSERT INTO orders (customer_id, order_date, total) VALUES
(1, '2024-09-10', 1020.00),
(2, '2024-09-12', 170.00),
(3, '2024-09-09', 70.00),
(4, '2024-08-09', 1520.00);

-- Заполнение таблицы деталей заказа
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 1000.00),
(1, 3, 1, 20.00),
(2, 2, 1, 150.00),
(2, 3, 1, 20.00),
(3, 3, 1, 20.00),
(3, 6, 1, 50.00),
(4, 5, 1, 1520.00);

select * from customers;
select * from categories;
select * from products;
select * from orders;
select * from order_items;

-- 1. Вывести список категорий(category_name) и товаров(product_name), которые относятся к этим категориям.
select cat.category_name, prod.product_name
from categories as cat
join products as prod
on cat.category_id = prod.category_id;

-- 2. Получить список всех товаров(product_name), включённых в заказы, с указанием их цен(price) и категорий(category_name).
select prod.product_name, prod.price, cat.category_name
from products as prod
join categories as cat
on prod.category_id = cat.category_id
join order_items as orit
on prod.product_id = orit.product_id;

-- 3. Найти заказы, содержащие товар "Laptop". Вывести order_id, order_date, first_name, last_name.
select ordr.order_id, ordr.order_date, cus.first_name, cus.last_name
from orders as ordr
join customers as cus
on ordr.customer_id = cus.customer_id
join order_items as orit
on orit.order_id = ordr.order_id
join products as prd
on orit.product_id = prd.product_id
where prd.product_name = 'Laptop';

-- 4. Вывести даты заказов(order_date) и имена клиентов(first_name, last_name), которые их сделали.
select ordr.order_date, cus.first_name, cus.last_name
from orders as ordr
join customers as cus
on ordr.customer_id = cus.customer_id;

-- 5. Вывести названия товаров(product_name), которые заказывал клиент с фамилией 'Smith'.
select prod.product_name
from products as prod
join order_items as orit
on orit.product_id = prod.product_id 
join orders as ordr
on ordr.order_id = orit.order_id
join customers as cus
on cus.customer_id  = ordr.customer_id
where cus.last_name = 'Smith';

-- 6. Найти имена и фамилии клиентов, которые купили товары из категории "Electronics".
select cus.first_name, cus.last_name
from customers as cus
join orders as ordr
on cus.customer_id = ordr.customer_id
join order_items as orit
on orit.order_id = ordr.order_id
join products as prd
on orit.product_id = prd.product_id
join categories as ctg
on ctg.category_id = prd.category_id
where ctg.category_name = 'Electronics';

-- 7. Вывести названия товаров и их количество(quantity) в каждом заказе.
select prod.product_name, orit.quantity, orit.order_id
from products as prod
join order_items as orit
on prod.product_id = orit.product_id;

-- 8. Получить список всех товаров(product_name), включённых в заказ клиента с email 'john@example.com'.
select prod.product_name
from products as prod
join order_items as orit
on prod.product_id = orit.product_id
join orders as ordr
on ordr.order_id = orit.order_id
join customers as cus
on cus.customer_id = ordr.customer_id
where cus.email = 'john@example.com';

-- 9. Вывести список всех заказанных товаров с указанием клиентов, которые их заказали.
select prod.product_name, cus.first_name, cus.last_name
from products as prod
join order_items as orit
on prod.product_id = orit.product_id
join orders as ordr
on ordr.order_id = orit.order_id
join customers as cus
on cus.customer_id = ordr.customer_id; 

-- 10. Получить список клиентов(first_name, last_name), которые заказали "Phone".
select cus.first_name, cus.last_name
from customers as cus
join orders as ordr
on cus.customer_id = ordr.customer_id
join order_items as orit
on orit.order_id = ordr.order_id
join products as prod
on orit.product_id = prod.product_id
where prod.product_name = 'Phone';

