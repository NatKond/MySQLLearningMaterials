CREATE DATABASE CompanyDB;
USE CompanyDB;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Salary DECIMAL(10, 2),
    DepartmentID INT,
    HireDate DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    Budget DECIMAL(10, 2)
);

CREATE TABLE EmployeeProjects (
    EmployeeID INT,
    ProjectID INT,
    HoursWorked DECIMAL(5, 2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID),
    PRIMARY KEY (EmployeeID, ProjectID)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Sales'),
(5, 'Marketing');

INSERT INTO Employees (EmployeeID, FirstName, LastName, Salary, DepartmentID, HireDate) VALUES
(1, 'John', 'Doe', 6000, 1, '2021-01-15'),
(2, 'Jane', 'Smith', 7500, 1, '2019-11-23'),
(3, 'Jim', 'Brown', 8000, 2, '2020-03-12'),
(4, 'Jake', 'Williams', 5500, 2, '2022-07-01'),
(5, 'Jess', 'Taylor', 7000, 3, '2018-05-08'),
(6, 'Jill', 'Adams', 6700, 3, '2021-06-22'),
(7, 'James', 'Davis', 9000, 4, '2020-09-30'),
(8, 'Jenny', 'Wilson', 6500, 4, '2019-04-18'),
(9, 'Jerry', 'Moore', 7200, 5, '2018-08-25');

INSERT INTO Projects (ProjectID, ProjectName, Budget) VALUES
(1, 'Website Redesign', 15000),
(2, 'New HR Software', 20000),
(3, 'Financial Audit', 10000),
(4, 'Sales Campaign', 25000),
(5, 'Market Research', 18000);

INSERT INTO EmployeeProjects (EmployeeID, ProjectID, HoursWorked) VALUES
(1, 1, 120),
(2, 1, 80),
(3, 2, 100),
(4, 2, 60),
(5, 3, 110),
(6, 3, 90),
(7, 4, 150),
(8, 4, 110),
(9, 5, 130);

select * from Departments;
select * from Employees;
select * from Projects;
select * from EmployeeProjects;

-- 1. Найдите среднюю зарплату сотрудников в каждом департаменте. Выведите название департамента и среднюю зарплату
select dep.DepartmentName, avg(emp.Salary)
from Employees as emp
join Departments as dep
on emp.DepartmentID = dep.DepartmentID
group by dep.DepartmentName;

-- Второй способ с объединением таблиц
-- Делаем подзапрос по таблице Employees
select DepartmentID, avg(salary) as avg_salary
from Employees
group by DepartmentID;

-- Объединяем с таблицей из подзапроса
select dep.departmentName, t2.avg_salary
from departments as dep
join (select DepartmentID, avg(salary) as avg_salary
		from employees
		group by DepartmentID) as t2
on dep.DepartmentID = t2.DepartmentID;

-- 2. Определите количество сотрудников в каждом департаменте. Выведите название департамента и количество сотрудников.
select dep.DepartmentName, count(emp.EmployeeID)
from Employees as emp
join Departments as dep
on emp.DepartmentID = dep.DepartmentID
group by dep.DepartmentName;

select dep.DepartmentName, t2.emp_count
from Departments as dep
join (select DepartmentID, count(EmployeeID) as emp_count
		from Employees
		group by DepartmentID) as t2
on dep.DepartmentID = t2.DepartmentID;

-- 3. Найдите минимальную и максимальную зарплаты в каждом департаменте.
-- Выведите название департамента, минимальную и максимальную зарплату.
select dep.DepartmentName, max(emp.Salary), min(emp.Salary)
from Employees as emp
join Departments as dep
on emp.DepartmentID = dep.DepartmentID
group by dep.DepartmentName;

select dep.departmentName, t2.max_salary, t2.min_salary
from departments as dep
join (select DepartmentID, max(salary) as max_salary, min(salary) as min_salary
	from employees
	group by DepartmentID) as t2
on dep.DepartmentID = t2.DepartmentID;

-- 4. Определите общую сумму зарплат в каждом департаменте. Выведите название департамента и общую сумму зарплат.
select dep.DepartmentName, sum(emp.Salary)
from Employees as emp
join Departments as dep
on emp.DepartmentID = dep.DepartmentID
group by dep.DepartmentName;

select dep.DepartmentName, t2.sum_salary
from Departments as dep
join (select DepartmentId, sum(Salary) as sum_salary
from Employees
group by DepartmentId) as t2
on dep.DepartmentId = t2.DepartmentId;

-- 5. Вывести ID департамента с самой высокой средней зарплатой сотрудников.
select dep.DepartmentID, avg(emp.Salary)
from Employees as emp
join Departments as dep
on emp.DepartmentID = dep.DepartmentID
group by dep.DepartmentID
having avg(emp.Salary) = (select max(t2.avrSalary) 
							from (select DepartmentID, avg(Salary) as avrSalary
									from Employees	
									group by DepartmentID) as t2);

-- 2 вариант - если с самой высокой средней зарплатой найден один департамент
select departmentID
from employees
group by DepartmentID
order by avg(salary) desc
limit 1;

-- 3 вариант
select DepartmentID
from employees
group by DepartmentID
having avg(salary) = (select max(t1.avg_salary)
						from (select DepartmentID, avg(salary) as avg_salary
								from employees
								group by DepartmentID) as t1);
                                    
-- 6. Вывести имя департамента с самой высокой средней зарплатой сотрудников.
select dep.DepartmentName, avg(emp.Salary)
from Employees as emp
join Departments as dep
on emp.DepartmentID = dep.DepartmentID
group by dep.DepartmentName
having avg(emp.Salary) = (select max(t2.avrSalary) 
							from (select DepartmentID, avg(Salary) as avrSalary
									from Employees
									group by DepartmentID) as t2);

-- Вариант 2 - если с самой высокой средней зарплатой найден один департамент
select departmentID
from employees
group by DepartmentID
order by avg(salary) desc
limit 1;

-- Вариант 3
select dep.departmentName
from departments as dep -- Таблица всех департаментов
join (select DepartmentID
		from employees
		group by DepartmentID
		having avg(salary) = (select max(t1.avg_salary)
								from (select DepartmentID, avg(salary) as avg_salary
										from employees
										group by DepartmentID) as t1)) as t2 -- таблица департаментов с самой высокой средней зарплатой
on dep.DepartmentID = t2.DepartmentID;

-- 7. Выведите имя, фамилию и зарплату сотрудников, чья зарплата выше средней по их департаменту.
select emp.FirstName, emp.LastName, emp.Salary, t2.avrSalary, t2.DepartmentID
from Employees as emp -- таблица всех сотрудников
join (select DepartmentID, avg(Salary) as avrSalary
		from Employees
		group by DepartmentID) as t2 -- таблица средних зарплат по департаментам
on t2.DepartmentID = emp.DepartmentID
where emp.Salary > t2.avrSalary;

-- 8. Найдите проект с наибольшим количеством сотрудников, проработавших на нем больше 100 часов. Вывести ProjectName.
select pro.ProjectName, count(emp.EmployeeId)
from Employees as emp
join EmployeeProjects as emppro
on emp.EmployeeID = emppro.EmployeeID
join Projects as pro
on emppro.ProjectID = pro.ProjectID
where emppro.HoursWorked > 100
group by pro.ProjectName
having count(emp.EmployeeId) = (select max(t2.countEmployees) 
								from (select emppro.ProjectID, count(emp.EmployeeId) as countEmployees
										from Employees as emp
										join EmployeeProjects as emppro
										on emp.EmployeeID = emppro.EmployeeID
                                        where emppro.HoursWorked > 100
										group by emppro.ProjectID) as t2);
                                        
-- Вариант 1 - если по условию найден только один проект
select t2.projectname
from employeeprojects as t1
join projects as t2
on t1.ProjectID = t2.ProjectID
where t1.HoursWorked > 100
group by t1.ProjectID
order by count(t1.EmployeeID) desc
limit 1;

-- Вариант 2 - если проектов больше
-- 8.1. Вывести ИД проектов и кол/во сотрудников, которые проработали больше 100 часов.
select ProjectID, count(EmployeeID)
from EmployeeProjects
where HoursWorked > 100
group by ProjectID;

-- 8.2. Из запроса 1 вывести максимальное кол/во сотрудников...
select max(t2.count_emp)
from (select ProjectID, count(EmployeeID) as count_emp
		from EmployeeProjects
		where HoursWorked > 100
		group by ProjectID) as t2;
-- 8.3. Вывести ИД проектов, где кол/во сотрудников ровно максимальному кол/во сотрудников(запрос 2).
select ProjectID
from EmployeeProjects
where HoursWorked > 100
group by ProjectID
having count(EmployeeID) = (select max(t2.count_emp)
							from (select ProjectID, count(EmployeeID) as count_emp
									from EmployeeProjects
									where HoursWorked > 100
									group by ProjectID) as t2);

-- 8.4. Вывести название проектов, где ИД проекта из запроса 3 совподает с ИД из projects.
select proj.ProjectName
from projects as proj
join (select ProjectID
		from employeeprojects
		where HoursWorked > 100
		group by ProjectID
		having count(EmployeeID) = (select max(t1.emp_count) as max_emp_count
									from (select ProjectID, count(EmployeeID) as emp_count
									from employeeprojects
									where HoursWorked > 100
									group by ProjectID) as t1)) as t2
on proj.ProjectID = t2.ProjectID;
                                        
-- 9. Найдите департамент с наименьшим количеством сотрудников. Выведите название департамента и количество сотрудников.
select dep.DepartmentName, count(emp.EmployeeID)
from Employees as emp
join Departments as dep
on emp.DepartmentID = dep.DepartmentID
group by dep.DepartmentName
having count(emp.EmployeeID) = (select min(t2.count_emp)
								from (select DepartmentID, count(EmployeeID) as count_emp
										from Employees
										group by DepartmentID) as t2);
                                        
-- 2 вариант                                  
select DepartmentName, t2.emp_count
from departments as dep
join (select DepartmentID, count(EmployeeID) as emp_count
		from employees
		group by DepartmentID
		having count(EmployeeID) = (select min(t1.emp_count) as min_emp_count
									from (select DepartmentID, count(employeeID) as emp_count
											from employees
											group by DepartmentID) as t1)) as t2
on dep.DepartmentID = t2.DepartmentID;

select DepartmentName
from departments as dep
where DepartmentID in (select DepartmentID
		from employees
		group by DepartmentID
		having count(EmployeeID) = (select max(t1.emp_count) as max_emp_count
									from (select DepartmentID, count(employeeID) as emp_count
											from employees
											group by DepartmentID) as t1));

-- Найдите департаменты с наибольшим количеством сотрудников. Выведите название департамента и количество сотрудников.
select dep.DepartmentName, t2.emp_count
from Departments as dep
join (select DepartmentID, count(EmployeeID) as emp_count
		from Employees
        group by DepartmentID
        having count(EmployeeID) = (select max(t1.emp_count)
									from (select DepartmentID, count(employeeID) as emp_count
										from employees
										group by DepartmentID) as t1)) as t2
on dep.DepartmentID = t2.DepartmentID;

-- 10. Определите департамент с наибольшим суммарным бюджетом проектов, на которых работают его сотрудники.
insert into employees values (10, 'Bob', 'Brown', 5000, 1, '2021-02-13');
insert into employeeprojects values (10, 3, 80);

-- 10.1. Вывести ид департамента, имена и фамилии сотрудников, имена проектов и их бюджет.
select emp.FirstName, emp.LastName, dep.DepartmentID, pro.ProjectName, pro.Budget
from Employees as emp
join Departments as dep
on emp.DepartmentID = dep.DepartmentID
join EmployeeProjects as proemp
on emp.EmployeeID = proemp.EmployeeID
join Projects as pro
on pro.ProjectID = proemp.ProjectID
order by emp.DepartmentID;

-- 10.2. Вывести ид депатамента и сумма бюджета проектов по департаментам.
select departmentID, sum(t2.budget) as sum_budget
from ( select dep.DepartmentID, pro.ProjectID, pro.Budget as budget
		from Employees as emp
		join Departments as dep
		on emp.DepartmentID = dep.DepartmentID
		join EmployeeProjects as proemp
		on emp.EmployeeID = proemp.EmployeeID
		join Projects as pro
		on pro.ProjectID = proemp.ProjectID
		group by dep.DepartmentID, pro.ProjectID, pro.Budget) as t2
group by departmentID;

-- 10.3. Вывести маскимальную сумму бюджета проектов по департаментам.
select max(t3.sum_budget) 
from (select departmentID, sum(t2.budget) as sum_budget
		from ( select dep.DepartmentID, pro.ProjectID, pro.Budget as budget
				from Employees as emp
				join Departments as dep
				on emp.DepartmentID = dep.DepartmentID
				join EmployeeProjects as proemp
				on emp.EmployeeID = proemp.EmployeeID
				join Projects as pro
				on pro.ProjectID = proemp.ProjectID
				group by dep.DepartmentID, pro.ProjectID, pro.Budget) as t2
		group by departmentID) as t3;
                                    
-- 10.4. Вывести ид депатамента с максимальной суммой бюджета проектов по департаментам.
select departmentID, sum(t4.budget) as sum_budget
from ( select dep.DepartmentID, pro.ProjectID, pro.Budget as budget
		from Employees as emp
		join Departments as dep
		on emp.DepartmentID = dep.DepartmentID
		join EmployeeProjects as proemp
		on emp.EmployeeID = proemp.EmployeeID
		join Projects as pro
		on pro.ProjectID = proemp.ProjectID
		group by dep.DepartmentID, pro.ProjectID, pro.Budget) as t4
group by departmentID
having sum_budget = (select max(t3.sum_budget) 
					from (select departmentID, sum(t2.budget) as sum_budget
							from ( select dep.DepartmentID, pro.ProjectID, pro.Budget as budget
									from Employees as emp
									join Departments as dep
									on emp.DepartmentID = dep.DepartmentID
									join EmployeeProjects as proemp
									on emp.EmployeeID = proemp.EmployeeID
									join Projects as pro
									on pro.ProjectID = proemp.ProjectID
									group by dep.DepartmentID, pro.ProjectID, pro.Budget)as t2
		group by departmentID) as t3);
                                    
-- 10.5. Вывести имя депатамента с максимальной суммой бюджета проектов по департаментам.
select departmentName 
from departments as dep
where DepartmentID in (select departmentID
						from (select dep.DepartmentID, pro.ProjectID, pro.Budget as budget
								from Employees as emp
								join Departments as dep
								on emp.DepartmentID = dep.DepartmentID
								join EmployeeProjects as proemp
								on emp.EmployeeID = proemp.EmployeeID
								join Projects as pro
								on pro.ProjectID = proemp.ProjectID
								group by dep.DepartmentID, pro.ProjectID, pro.Budget) as t4
						group by departmentID
						having sum(t4.budget) = (select max(t3.sum_budget) 
											from (select departmentID, sum(t2.budget) as sum_budget
													from ( select dep.DepartmentID, pro.ProjectID, pro.Budget as budget
															from Employees as emp
															join Departments as dep
															on emp.DepartmentID = dep.DepartmentID
															join EmployeeProjects as proemp
															on emp.EmployeeID = proemp.EmployeeID
															join Projects as pro
															on pro.ProjectID = proemp.ProjectID
															group by dep.DepartmentID, pro.ProjectID, pro.Budget)as t2
								group by departmentID) as t3));
                                
-- 2 вариант
select departmentName, t3.sum_budget
from departments as dep
join (select t1.departmentID, sum(t1.budget) as sum_budget
		from (select emp.departmentID, proj.projectID, proj.budget
				from employees as emp
				join employeeprojects as emp_proj
				on emp.EmployeeID = emp_proj.EmployeeID
				join projects as proj
				on emp_proj.ProjectID = proj.ProjectID
				group by emp.departmentID, proj.projectID, proj.budget) as t1
		group by t1.departmentID
		having sum(t1.budget) = (select max(t2.sum_budget) as max_sum_budget
								from (select t1.departmentID, sum(t1.budget) as sum_budget
										from (select emp.departmentID, proj.projectID, proj.budget
												from employees as emp
												join employeeprojects as emp_proj
												on emp.EmployeeID = emp_proj.EmployeeID
												join projects as proj
												on emp_proj.ProjectID = proj.ProjectID
												group by emp.departmentID, proj.projectID, proj.budget) as t1
										group by t1.departmentID) as t2)) as t3
on dep.DepartmentID = t3.DepartmentID;

-- 11. Найдите сотрудников, которые работают в департаменте с самой большой суммарной зарплатой среди всех департаментов.
select emp.FirstName, emp.LastName, emp.Salary, dep.DepartmentName
from Employees as emp
join Departments as dep
on dep.DepartmentID = emp.DepartmentID and 
dep.DepartmentID = (select DepartmentID
					from Employees
					group by DepartmentID
					having sum(Salary) = (select max(t2.sum_salary) 
											from (select DepartmentID, sum(Salary) as sum_salary
											from Employees
											group by DepartmentID) as t2));
