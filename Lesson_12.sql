-- Группировка

-- Операторы GROUP BY и HAVING позволяют сгруппировать данные. Они употребляются в рамках команды SELECT.

-- SELECT столбцы
-- FROM таблица
-- [JOIN ... ON]
-- [WHERE условие_фильтрации_строк]
-- [GROUP BY столбцы_для_группировки]
-- [HAVING условие_фильтрации_групп]
-- [ORDER BY столбцы_для_сортировки]
-- [LIMIT];   

-- Выполняются по порядку:
-- FROM
-- JOIN
-- WHERE
-- GROUP BY
-- HAVING
-- SELECT
-- ORDER BY
-- LIMIT

SET sql_mode = CONCAT(@@sql_mode, ',ONLY_FULL_GROUP_BY');
-- Безопасный/строгий режим группировки  
SET sql_mode = CONCAT(@@sql_mode, ',ONLY_FULL_GROUP_BY');

-- Вывести кол/во сотрудников по департаментам.
select department_id, count(employee_id) as emp_count
from employees
where department_id is not null
group by department_id;

-- Вывести ид департаментов, в которых кол/во сотрудников больше 10. department_id и emp_count
select department_id, count(employee_id) as emp_count
from employees
where department_id is not null
group by department_id
having count(employee_id) > 10;

-- Работает только в mysql
select department_id, count(employee_id) as emp_count
from employees
where department_id is not null
group by department_id
having emp_count > 10;

-- Найти средние зарплаты по департаментам. Вывести department_id и avg_salary.
select department_id, avg(salary)
from employees
where department_id is not null
group by department_id;

-- Найти департаменты, в которых сумма зарплат больше 30000. Вывести department_id и sum_salary.
select department_id, sum(salary) as sum_salary
from employees
where department_id is not null
group by department_id
having sum_salary > 30000;

-- Нельзя вывести поля вместе с агрегатными функциями, если этих полей нет в group by.
select department_id, sum(salary) as sum_salary, employee_id
from employees
where department_id is not null
group by department_id
having sum(salary) > 30000;
-- Error Code: 1055. Expression #3 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'hr.employees.employee_id' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by	0.015 sec

-- Найти максимальные зарплаты по департаментам. Вывести название департамента и максимальную зарплату.
select dep.department_name, max(emp.salary) as max_salary
from employees as emp
join departments as dep
on emp.department_id = dep.department_id
group by dep.department_name;

-- Найти департаменты, где средняя зарплата выше 10000. Вывести название департамента и среднюю зарплату.
select dep.department_name, avg(emp.salary) as avg_salary
from employees as emp
join departments as dep
on emp.department_id = dep.department_id
group by dep.department_name
having avg(emp.salary) > 10000;

-- Найти суммы зарплат в департаментах IT, Sales, Finance и Shipping. Вывести названия департаментов и суммы зарплат.
select dep.department_name, sum(emp.salary) as sum_salary
from employees as emp
join departments as dep
on emp.department_id = dep.department_id
where dep.department_name in ('IT', 'Sales', 'Finance', 'Shipping')
group by dep.department_name;

select dep.department_name, sum(emp.salary) as sum_salary
from employees as emp
join departments as dep
on emp.department_id = dep.department_id
group by dep.department_name
having dep.department_name in ('IT', 'Sales', 'Finance', 'Shipping');

-- Найти кол/во департментов в каждом городе. Вывести город и кол/во департаментов.
select loc.city, count(dep.department_id) as count_departments
from departments as dep
join locations as loc
on loc.location_id = dep.location_id
group by loc.city;

-- Найти кол/во сотрудников по департаментам. Вывести название департамена и кол/во сотрудников. Отсортировать выборку по возр. кол/во сотруднков.
select dep.department_name, count(emp.employee_id) as emp_count
from employees as emp
join departments as dep
on emp.department_id = dep.department_id
group by dep.department_name
order by emp_count;

-- ПОДЗАПРОСЫ SUBSELECT

-- Подзапрос, который возвращает таблицу 
-- select column1, aggregate(column2)
-- from table1
-- [join ... on]
-- [where ...]
-- group by column1
-- [having ...];

-- Запрос, где использован подзапрос, который возвращает таблицу.
-- select table1.column1, table2.column2
-- from table1
-- join (ПОДЗАПРОС) as table2
-- [where ...]
-- [group by ...]
-- [having ...]

-- select table1.column1, table1.column2
-- from (ПОДЗАПРОС) as table1
-- [where ...]
-- [group by ...]
-- [having ...]

-- Найти имена и фамилоии сотрудников, которые получают максимальную зарплату в своих департаментах.
-- 1. Найти максимальные зарплаты по департаментам. (Подзапрос)
select department_id, max(salary)
from employees
where department_id is not null
group by department_id;

-- 2. Решение
select emp.first_name, emp.last_name
from employees as emp
join (select department_id, max(salary) as max_salary
		from employees
		where department_id is not null
		group by department_id) as max_salary_by_dep
on emp.department_id = max_salary_by_dep.department_id
where emp.salary = max_salary_by_dep.max_salary;

-- Вывести имена, фамилии и зарплаты сотрудников, которые получают больше чем средняя зарплата в их департаментах.

-- 1. Найти средние зарплаты по департаментам. Вывести ид департамента и среднюю зарплату. (Подзапрос)
select department_id, avg(salary)
from employees
where department_id is not null
group by department_id;

-- 2. Решение.
select emp.first_name, emp.last_name, emp.salary, avg_salary_by_dep.avg_salary, emp.department_id
from employees as emp
join (select department_id, avg(salary) as avg_salary
		from employees
		where department_id is not null
		group by department_id) as avg_salary_by_dep
on emp.department_id = avg_salary_by_dep.department_id
where emp.salary > avg_salary_by_dep.avg_salary;

-- Найти департамент с наименьшим количеством сотрудников
-- 1. Вывести департамень и количество сотрудников
select department_id, count(employee_id)
from employees
where department_id is not null
group by department_id;

-- 2. Найти минимальное количество сотрудников
select min(emp_count_by_dep.emp_count) as min_emp_count
from (select department_id, count(employee_id) as emp_count
		from employees
		where department_id is not null
		group by department_id) as emp_count_by_dep;

-- 3. Вывести названия департаментов с минимальным кол-вом сотрудников
select dep.department_name, count(emp.employee_id) as emp_count
from departments as dep
join employees as emp
on dep.department_id = emp.department_id
group by dep.department_name
having emp_count = (select min(emp_count_by_dep.emp_count) as min_emp_count
					from (select department_id, count(employee_id) as emp_count
								from employees
								where department_id is not null
								group by department_id) as emp_count_by_dep);