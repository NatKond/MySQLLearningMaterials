-- Агрегатные функции

-- min(поле) - вычисляет наименьшее значенние (int/integer, numeric/decimal)
-- max(поле) - вычисляет наибольшее значенние (int/integer, numeric/decimal)
-- sum(поле) - вычисляет сумму значений (int/integer, numeric/decimal)
-- avg(поле) - вычисляет среднее значение (int/integer, numeric/decimal)
-- count(*/поле) - вычисляет кол/во строк в запросе/в поле (all data types), * - общее кол/во строк в запросе/в таблице

-- Все агрегатные функции за исключением COUNT(*) игнорируют значения NULL.
use hr;
select * from employees;
select * from countries;
select * from departments;
select * from jobs;
select * from locations;
select * from regions;

-- Вывести максимальную зарплату в компании
select salary 
from employees
order by salary desc
limit 1;

select max(salary)
from employees;

-- Вывести минимальную зарплату в компании
select salary
from employees
order by salary
limit 1;

select min(salary)
from employees;

-- Безопасный режим группировки

-- Если нет безопасного режима группировки

select min(salary), first_name, last_name
from employees;
-- '2100.00', 'Steven', 'King' - ошибочный результат, выводит имя и фамилия первого сотрудника в таблице

select max(salary), first_name, last_name
from employees;
-- '24000.00', 'Steven', 'King' - ошибочный результат, выводит имя и фамилия первого сотрудника в таблице

-- Вкл.
SET sql_mode = CONCAT(@@sql_mode, ',ONLY_FULL_GROUP_BY');

-- Error Code: 1140. In aggregated query without GROUP BY, expression #2 of SELECT list contains nonaggregated column 
-- 'hr.employees.first_name'; this is incompatible with sql_mode=only_full_group_by

-- Выкл.
SET sql_mode=(SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));

-- Вывести минимальную и максимальную зарплату в компании
select min(salary), max(salary)
from employees;

-- Вывести сотрудников, которые получают максимальную зарплату в компании
select max(salary) from employees;

select first_name, last_name, salary
from employees
where salary = (select max(salary) from employees);

-- Вывести сотрудников, которые получают минимальную зарплату в компании
select min(salary) from employees;

select first_name, last_name, salary
from employees
where salary = (select min(salary) from employees);

-- Вывести сумму зарплат всех сотрудников.
select sum(salary)
from employees;

-- Вывести среднюю зарплату в компании.
select avg(salary)
from employees;

-- Вывести кол/во сотрудников в компании.
select count(employee_id) 
from employees;

-- Вывести кол/во строк/записей в таблице employees.
select count(*)
from employees;

-- Вывести кол/во менеджеров в компании.
select count(distinct manager_id) 
from employees;

-- Вывести максимальную зарплату средни сотрудников которые платят комиссии. (commission_pct is not null)
select max(salary)
from employees
where commission_pct is not null;

-- Вывести сумму зарплат сотрудников, которые получают больше 10000.
select sum(salary)
from employees
where salary > 1000;

-- Найти среднюю зарплату среди сотрудников, у которых ид департамента 100.
select avg(salary)
from employees
where department_id = 100;

-- Найти кол/во сотрудников из департамента IT.
select count(emp.employee_id) as emp_count
from employees as emp
join departments as dep
on emp.department_id = dep.department_id
where dep.department_name = 'IT';

-- Вывести сумму зарплат сотрудников из департамента Sales
select sum(emp.salary) as sum_salary
from employees as emp
join departments as dep
on emp.department_id = dep.department_id
where dep.department_name = 'Sales';

-- Найти средную зарплату сотрудников из 'United States of America'(country_name) 
select avg(salary)
from employees as emp
join departments as dep
on emp.department_id = dep.department_id
join locations as loc
on dep.location_id = loc.location_id
join countries as cntr
on loc.country_id = cntr.country_id
where country_name = 'United States of America';

-- * Найти сотрудников, у которых зарплата меньше средней зарплаты по компании
select *
from employees
where salary < (select avg(salary) from employees);

-- Найти кол/во сотрудников, у которых зарплата меньше средней зарплаты по компании
select count(employee_id) as emp_count
from employees
where salary < (select avg(salary) from employees);

-- Найти количество сотрудников из департамента с ID 60, которые зарабатывают больше средней зарплаты по компании.
select count(employee_id)
from employees
where department_id = 60 and salary > (select avg(salary) from employees);

-- Найти сотрудников, у которых зарплата меньше чем половина суммы зарплат всех сотрудников
select *
from employees
where salary < (select avg(salary)/2 from employees);

-- Вывести список сотрудников с должностью 'Programmer'(job_title),  чья зарплата выше средней зарплаты среди всех сотрудников с этой должностью.
select emp.*, jb.job_title
from employees as emp
join jobs as jb
on emp.job_id = jb.job_id
where job_title = 'Programmer' and salary > (select avg(salary) from employees);

select avg(emp.salary)
from employees as emp
join jobs as jb
on emp.job_id = jb.job_id
where jb.job_title = 'Programmer';

select emp.first_name, emp.last_name
from employees as emp
join jobs as jb
on emp.job_id = jb.job_id
where jb.job_title = 'Programmer' and salary > (select avg(emp.salary)
												from employees as emp
												join jobs as jb
												on emp.job_id = jb.job_id
												where jb.job_title = 'Programmer')
