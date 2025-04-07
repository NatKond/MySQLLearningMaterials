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

-- 2. Определите количество сотрудников в каждом департаменте. Выведите название департамента и количество сотрудников.
select dep.DepartmentName, count(emp.EmployeeID)
from Employees as emp
join Departments as dep
on emp.DepartmentID = dep.DepartmentID
group by dep.DepartmentName;

-- 3. Найдите минимальную и максимальную зарплаты в каждом департаменте.
-- Выведите название департамента, минимальную и максимальную зарплату.
select dep.DepartmentName, max(emp.Salary), min(emp.Salary)
from Employees as emp
join Departments as dep
on emp.DepartmentID = dep.DepartmentID
group by dep.DepartmentName;

-- 4. Определите общую сумму зарплат в каждом департаменте. Выведите название департамента и общую сумму зарплат.
select dep.DepartmentName, sum(emp.Salary)
from Employees as emp
join Departments as dep
on emp.DepartmentID = dep.DepartmentID
group by dep.DepartmentName;

-- 5. Вывести ID департамента с самой высокой средней зарплатой сотрудников.
select dep.DepartmentID, avg(emp.Salary)
from Employees as emp
join Departments as dep
on emp.DepartmentID = dep.DepartmentID
group by dep.DepartmentID
having avg(emp.Salary) = (select max(avrSalaryByDep.avrSalary) 
							from (select dep.DepartmentName, avg(emp.Salary) as avrSalary
									from Employees as emp
									join Departments as dep
									on emp.DepartmentID = dep.DepartmentID
									group by dep.DepartmentName) as avrSalaryByDep);
-- 6. Вывести имя департамента с самой высокой средней зарплатой сотрудников.
select dep.DepartmentName, avg(emp.Salary)
from Employees as emp
join Departments as dep
on emp.DepartmentID = dep.DepartmentID
group by dep.DepartmentName
having avg(emp.Salary) = (select max(avrSalaryByDep.avrSalary) 
							from (select dep.DepartmentName, avg(emp.Salary) as avrSalary
									from Employees as emp
									join Departments as dep
									on emp.DepartmentID = dep.DepartmentID
									group by dep.DepartmentName) as avrSalaryByDep);
-- 7. Выведите имя, фамилию и зарплату сотрудников, чья зарплата выше средней по их департаменту.
select emp.FirstName, emp.LastName, emp.Salary, avrSalaryByDep.avrSalary, avrSalaryByDep.DepartmentID
from Employees as emp
join (select dep.DepartmentID, avg(emp.Salary) as avrSalary
		from Employees as emp
		join Departments as dep
		on emp.DepartmentID = dep.DepartmentID
		group by dep.DepartmentID) as avrSalaryByDep
on avrSalaryByDep.DepartmentID = emp.DepartmentID
where emp.Salary > avrSalaryByDep.avrSalary;

-- 8. Найдите проект с наибольшим количеством сотрудников, проработавших на нем больше 100 часов. Вывести ProjectName.
select pro.ProjectName, count(emp.EmployeeId)
from Employees as emp
join EmployeeProjects as emppro
on emp.EmployeeID = emppro.EmployeeID and emppro.HoursWorked > 100
join Projects as pro
on emppro.ProjectID = pro.ProjectID
group by pro.ProjectName
having count(emp.EmployeeId) = (select max(countEmpByPro.countEmployees) 
								from (select pro.ProjectName, count(emp.EmployeeId) as countEmployees
										from Employees as emp
										join EmployeeProjects as emppro
										on emp.EmployeeID = emppro.EmployeeID and emppro.HoursWorked > 100
										join Projects as pro
										on emppro.ProjectID = pro.ProjectID
										group by pro.ProjectName) as countEmpByPro);