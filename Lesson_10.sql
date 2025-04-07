use hr;
select * from employees;

-- Вывести имена и фамилии сотрудников и имена и фамилии их менеджеров.
select emp_table.first_name as emp_first_name, emp_table.last_name as emp_last_name, mng_table.first_name as mng_first_name, mng_table.last_name as mng_last_name
from employees as emp_table
join employees as mng_table
on emp_table.manager_id =  mng_table.employee_id; -- id менеджеров всех сотрудников = id менеджеров

insert into employees
values (207, 'John', 'Smith', 'JSMITH', '515.123.8181', 'AC_ACCOUNT', 8000, null, 315, 110);

-- Вывести сотрудников у которых нет менеджера
select emp_table.first_name as emp_first_name, emp_table.last_name as emp_last_name, mng_table.first_name as mng_first_name, mng_table.last_name as mng_last_name
from employees as emp_table
left join employees as mng_table
on emp_table.manager_id =  mng_table.employee_id
where mng_table.employee_id is null;

select all_emp.first_name, all_emp.last_name, all_emp.salary
from employees as all_emp
join employees as j_d
on all_emp.employee_id != j_d.employee_id
where j_d.first_name = 'Jennifer' and j_d.last_name = 'Dilly' and all_emp.salary > j_d.salary;

-- Вывести имена, фамилии и зарплаты сотрудников, которые получают больше чем 'Jennifer' 'Dilly'.

-- select first_name, last_name, salary
-- from employees
-- where salary > 3600;

-- select salary
-- from employees
-- where first_name = 'Jennifer' and last_name = 'Dilly';

select all_emp.first_name, all_emp.last_name, all_emp.salary
from employees as all_emp -- все сотрудники кроме 'Jennifer' 'Dilly'
join employees as j_d -- Только 'Jennifer' 'Dilly'
on all_emp.employee_id != j_d.employee_id -- не включая 'Jennifer' 'Dilly'
where j_d.first_name = 'Jennifer' and j_d.last_name = 'Dilly' and all_emp.salary > j_d.salary; -- вторая таблица состоит только из сотрудника 'Jennifer' 'Dilly' и условие, что зарпалаты выше чем у 'Jennifer' 'Dilly'

select all_emp.first_name, all_emp.last_name, all_emp.salary
from employees as all_emp -- все сотрудники кроме 'Jennifer' 'Dilly'
join employees as j_d -- Только 'Jennifer' 'Dilly'
on all_emp.salary > j_d.salary -- только с зарплатами выше чем у 'Jennifer' 'Dilly'
where j_d.first_name = 'Jennifer' and j_d.last_name = 'Dilly'; -- вторая таблица состоит только из сотрудника 'Jennifer' 'Dilly'

-- Найти сотрудников, коротые работают в том же депараменте, что 'Laura' 'Bissot'.
select all_emp.first_name, all_emp.last_name, all_emp.department_id
from employees as all_emp
join employees as l_b
on all_emp.employee_id != l_b.employee_id
where l_b.first_name = 'Laura' and l_b.last_name = 'Bissot' and all_emp.department_id = l_b.department_id;

select all_emp.first_name, all_emp.last_name, all_emp.department_id
from employees as all_emp
join employees as l_b
on all_emp.department_id = l_b.department_id
where l_b.first_name = 'Laura' and l_b.last_name = 'Bissot';

-- ПОДЗАПРОСЫ - SUBSELECT

-- Подзапрос с одним полем/значением
-- select column1
-- from table1
-- where ...;

-- Запрос с подзапросом
-- select column1, column2, ...
-- from table_name1
-- [joins ...]
-- where column1 = (select column1
-- 				from table1
-- 				where ...)

select salary
from employees
where first_name = 'Jennifer' and last_name = 'Dilly'; -- запрос имеет одно значение

select first_name, last_name, salary
from employees
where salary > (select salary
				from employees
				where first_name = 'Jennifer' and last_name = 'Dilly');
                                
-- Найти сотрудников, коротые работают в том же депараменте, что 'Laura' 'Bissot'. (+ 'Laura' 'Bissot')
select first_name, last_name
from employees
where department_id = (select department_id from employees where first_name = 'Laura' and last_name = 'Bissot');
                
-- Найти сотрудников, коротые работают в том же депараменте, что 'Laura' 'Bissot'. (Все кроме 'Laura' 'Bissot')
-- 1 версия
select first_name, last_name
from employees
where first_name != 'Laura' and last_name != 'Bissot' and department_id = (select department_id
				from employees
				where first_name = 'Laura' and last_name = 'Bissot');

-- 2 версия
select first_name, last_name
from employees
where department_id = (select department_id from employees where first_name = 'Laura' and last_name = 'Bissot') 
and employee_id != (select employee_id from employees where first_name = 'Laura' and last_name = 'Bissot');

-- Вывести имя, фамилию и зарплату первых трех сотрудников, которые зарабатывают меньше "Adam" "Fripp"
-- И через self join, и через подзапросы
select first_name, last_name, salary
from employees
where first_name = 'Adam' and last_name = 'Fripp';

select * from employees
order by salary;

select first_name, last_name, salary
from employees
where salary < (select salary
				from employees
				where first_name = 'Adam' and last_name = 'Fripp')
limit 3;

select all_emp.first_name, all_emp.last_name, all_emp.salary
from employees as all_emp
join employees as a_f
on all_emp.salary < a_f.salary
where a_f.first_name = 'Adam' and a_f.last_name = 'Fripp'
limit 3;

-- Выведите сотрудников, которые зарабатывают больше, чем Charles Johnson, но работают в другом департаменте.
-- И через self join, и через подзапросы

-- 1 вариант
select all_emp.first_name, all_emp.last_name, all_emp.salary
from employees as all_emp
join employees as c_j
on all_emp.salary > c_j.salary
where c_j.first_name = 'Charles' and c_j.last_name = 'Johnson' and  all_emp.department_id != c_j.department_id;

-- 2 вариант
select all_emp.first_name, all_emp.last_name, all_emp.salary
from employees as all_emp
join employees as c_j
on all_emp.salary > c_j.salary and  all_emp.department_id != c_j.department_id
where c_j.first_name = 'Charles' and c_j.last_name = 'Johnson';


select first_name, last_name, salary
from employees
where salary > (select salary
				from employees
				where first_name = 'Charles' and last_name = 'Johnson') 
and department_id != (select department_id
					from employees
					where first_name = 'Charles' and last_name = 'Johnson');