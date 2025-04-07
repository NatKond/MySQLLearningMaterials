-- OUTER JOIN - LEFT JOIN, RIGHT JOIN

-- select column1, column2, ..
-- from left_table
-- left/right join right_table 
-- on left_table.column = right_table.column;
-- Второй распространенный вариант — внешнее соединение. 
-- Если внутреннее объединение имеет сходство с бинарным «и», то внешнее — несколько вариаций бинарного
-- «или». Такой JOIN более гибкий, он возвращает не только строгое пересечение между двумя таблицами, 
-- но и отдельные элементы, которые принадлежат только одному из множеств. Какому — зависит от типа.

-- Left Join. Возвращает пересечение множеств и все элементы из левой таблицы. 
-- Например, человек хочет посмотреть кино, но на русский фильм согласен, только если это боевик. 
-- Фильтр вернет ему все фильмы из множества «боевики», фильмы из подмножества «русские боевики», 
-- но других фильмов из множества «русские» там не будет.
-- Right Join. Работает по тому же принципу, но вместо левой таблицы — правая. 
-- То есть человек получит в результатах боевики, только если они русские.

-- Left Join с NULL. Возвращает данные из левой таблицы, но без пересечений с правой. 
-- Человеку покажутся все боевики, но русского кино и в частности русских боевиков среди них не будет.

-- Right Join с NULL. Соответственно, работает так же, но по отношению к «правой», второй таблице.

use hr;

select * from countries;
select * from departments;
select * from employees;
select * from jobs;
select * from locations;
select * from regions;

-- Вывести всех сотрудников и названия их департаментов
select emp.first_name, emp.last_name, dep.department_name
from employees as emp
join departments as dep
on emp.department_id = dep.department_id;

-- Вывести все департаменты, в которых работает хотя бы один сотрудник.
select distinct department_name
from departments as dep
join employees as emp
on dep.department_id = emp.department_id;

-- Вывести всех сотрудников и название их департментов, если департамент не указан вывести null.
select first_name, last_name, department_name
from employees as emp
left join departments as dep
on emp.department_id = dep.department_id;

-- Вывести сотрудников, которые не работают в департаментах.
select emp.first_name, emp.last_name, dep.department_name
from employees as emp
left join departments as dep
on emp.department_id = dep.department_id
where dep.department_name is null;

-- Лучше проверить department_id - primary key поля
select first_name, last_name, dep.*
from employees as emp
left join departments as dep
on emp.department_id = dep.department_id
where dep.department_id is null;

-- Вывести департаменты, в котрых не работают сотрудники.
select dep.department_name, emp.*
from departments as dep
left join employees as emp
on emp.department_id = dep.department_id
where emp.employee_id is null;

-- Вывести города, в которых нет департаментов
select city from locations; -- 27 городов

-- Те города, в которых есть департаменты 
select distinct loc.city 
from locations as loc
join departments as dep
on loc.location_id = dep.location_id;

-- Вывести города, в которых нет департаментов
select distinct loc.city
from locations as loc
left join departments as dep
on loc.location_id = dep.location_id
where dep.department_id is null;

-- Вывести названия стран и городов, в которых нет департаметов
select cnt.country_name, loc.city, dep.*
from countries as cnt
join locations as loc
on cnt.country_id = loc.country_id
left join departments as dep
on loc.location_id = dep.location_id
where dep.department_id is null;

-- Вывести имена, фамилии и должность(job_title) сотрудников, которые не работают ни в каких департаментах
select emp.first_name, emp.last_name, job.job_title
from employees as emp
left join departments as dep
on dep.department_id = emp.department_id
join jobs as job
on job.job_id = emp.job_id
where dep.department_id is null;

select emp.first_name, emp.last_name, jb.job_title
from employees as emp
join jobs as jb
on emp.job_id = jb.job_id
left join departments as dep
on dep.department_id = emp.department_id
where dep.department_id is null;

-- Вывести название(department_name) и адрес(street_address) тех департаментов, в которых никто не работает.
select dep.department_name, loc.street_address
from departments as dep
join locations as loc
on dep.location_id = loc.location_id
left join employees as emp
on dep.department_id = emp.department_id
where emp.employee_id is null;

-- select dep.department_name, loc.street_address
-- from employees
-- right join departments
-- on ...
-- join locations
-- on ...;

-- select dep.department_name, loc.street_address
-- from locations
-- join departments
-- on ...
-- left join employees
-- on ...

-- Из региона 'Americas' вывести названия стран, городов и департаментов, в которых никто не работает.
select dep.department_name, loc.city, cnt.country_name
from departments as dep
left join employees as emp
on dep.department_id = emp.department_id
join locations as loc
on dep.location_id = loc.location_id
join countries as cnt
on cnt.country_id = loc.country_id
join regions as reg
on cnt.region_id = reg.region_id
where reg.region_name = 'Americas' and emp.employee_id is null;

-- Вывести из таблицы countries те страны, которых нет в locations
select cnt.*
from countries as cnt
left join locations as loc
on loc.country_id = cnt.country_id
where loc.location_id is null;
