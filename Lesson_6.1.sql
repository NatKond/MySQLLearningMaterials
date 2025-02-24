use gt081024;

drop table employees;

create table employees(
 	employee_id int primary key auto_increment,
 	first_name varchar(128) not null,
 	last_name varchar(128) not null,
 	email varchar(128) not null,
 	salary int, 
	department varchar(128) not null
 );
 
insert into employees(first_name, last_name, email, salary, department) values("Steven","King",	"SKING", 24000, "Sales");
insert into employees(first_name, last_name, email, salary, department) values("Neena" , "Kochhar" , "NKOCHHAR" , 17000 , "Sales");
insert into employees(first_name, last_name, email, salary, department) values("Lex" , "De Haan" , "LDEHAAN" , 17000 , "Sales");
insert into employees(first_name, last_name, email, salary, department) values("Alexander" , "Hunold" , "AHUNOLD" , 9000 , "Finance");
insert into employees(first_name, last_name, email, salary, department) values("Bruce" , "Ernst" , "BERNST" , 6000 , "Finance");
insert into employees(first_name, last_name, email, salary, department) values("Valli" , "Pataballa" , "VPATABAL" , 4800 , "Finance");
insert into employees(first_name, last_name, email, salary, department) values("Diana" , "Lorentz" , "DIANALO" , 8800 , "Finance");
insert into employees(first_name, last_name, email, salary, department) values("Nancy" , "Greenberg" , "NGREENBE" , 12008 , "Shipping");
insert into employees(first_name, last_name, email, salary, department) values("Daniel" , "Faviet" , "DFAVIET" , 9000 , "Shipping");
insert into employees(first_name, last_name, email, salary, department) values("Jose Manuel" , "Urman" , "JMURMAN" , 7800 , "Shipping");
insert into employees(first_name, last_name, email, salary, department) values("Luis" , "Popp" , "LPOPP" , 6900 , "Shipping");
insert into employees(first_name, last_name, email, salary, department) values("Den" , "Raphaely" , "DRAPHEAL" , 11000 , "Marketing");
insert into employees(first_name, last_name, email, salary, department) values("Alexander" , "Khoo" , "AKHOO" , 3100 , "Marketing");
insert into employees(first_name, last_name, email, salary, department) values("Shelli" , "Baida" , "SBAIDA" , 2900 , "Marketing");
insert into employees(first_name, last_name, email, salary, department) values("Sigal" , "Tobias" , "STOBIAS" , 2800 , "Marketing");
insert into employees(first_name, last_name, email, salary, department) values("Matthew" , "Weiss" , "MWEISS" , 8000 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Adam" , "Fripp" , "AFRIPP" , 8200 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Payam" , "Kaufling" , "PKAUFLIN" , 7900 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Shanta" , "Vollman" , "SVOLLMAN" , 6500 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Kevin" , "Mourgos" , "KMOURGOS" , 5800 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Julia" , "Nayer" , "JNAYER" , 3200 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Adam" , "Markle" , "SMARKLE" , 2200 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Laura" , "Bissot" , "LBISSOT" , 3300 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Mozhe" , "Atkinson" , "MATKINSO" , 2800 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Joshua" , "Patel" , "JPATEL" , 2500 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Trenna" , "Rajs" , "TRAJS" , 3500 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("John" , "Russell" , "JRUSSEL" , 14000 , "IT");
insert into employees(first_name, last_name, email, salary, department) values("Karen" , "Partners" , "KPARTNER" , 13500 , "IT");
insert into employees(first_name, last_name, email, salary, department) values("Alberto" , "Errazuriz" , "AERRAZUR" , 12000 , "IT");
insert into employees(first_name, last_name, email, salary, department) values("Gerald" , "Cambrault" , "GCAMBRAU" , 11000 , "IT");
insert into employees(first_name, last_name, email, salary, department) values("Eleni" , "Zlotkey" , "EZLOTKEY" , 10500 , "IT");
insert into employees(first_name, last_name, email, salary, department) values("Adam" , "Vargas" , "PVARGAS" , 2500 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Laura" , "Errazuriz" , "AERRAZUR" , 12000 , "IT");


-- 1. Повысить зарплаты для отдела sales на 20%, для finance 15%, для shipping 10%, для marketing 25%, для HR 20% и для IT 35%. Записать данные в новое поле new_salary. Поле создавать не нужно, используем AS. 
select
    first_name,
    last_name,
    salary,
    department,
    case
        when department = 'sales' then (salary + salary * 20 / 100)
        when department = 'finance' then (salary + salary * 15 / 100)
        when department = 'shipping' then (salary + salary * 10 / 100)
        when department = 'marketing' then (salary + salary * 25 / 100)
        when department = 'HR' then (salary + salary * 20 / 100)
        when department = 'it' then (salary + salary * 35 / 100)
        else salary
    end as new_salary
from
    employees;
    
-- 2. Создать поле new_salary типа numeric(7, 2)
alter table employees
add column new_salary numeric(7, 2);

-- 3. Заполнить поле: повысить зарплаты для отдела sales на 20%, для finance 15%, для shipping 10%, для marketing 25%, для HR 20% и для IT 35%.
update employees 
set 
    new_salary = case
        when department = 'sales' then (salary + salary * 20 / 100)
        when department = 'finance' then (salary + salary * 15 / 100)
        when department = 'shipping' then (salary + salary * 10 / 100)
        when department = 'marketing' then (salary + salary * 25 / 100)
        when department = 'HR' then (salary + salary * 20 / 100)
        when department = 'it' then (salary + salary * 35 / 100)
        else salary
    end;

-- 4. вывести из таблицы employees first_name как user_name, last_name как surname и новое поле full_name, которое состоит из имен и фамилий сотрудников.
    
select 
    first_name as user_name,
    last_name as surname,
    CONCAT(first_name, ' ', last_name) AS full_name
from
    employees;

-- 5. Вывести новое поле commission, которое будет null, если зарплата сотрудника меньше 3000, будет 10, если зарплата меньше 6000, будет 15, если зарплата меньше 9000, и будет 20, если зарплата больше/равно 9000.
select 
    first_name,
    last_name,
    salary,
    department,
    case
        when salary < 9000 then 15
        when salary < 6000 then 10
        when salary < 3000 then null
        else 20
    end as commission
from
    employees;
    
-- 6. Создать новое поле commission и соответственно заполнить.
alter table employees
add column commission int;

update employees 
set 
    commission = case
        when salary < 9000 then 15
        when salary < 6000 then 10
        when salary < 3000 then null
        else 20
    end;
    
-- 7. создать поле final_salary и заполнить формулой salary + salary * commission / 10. 
-- Проверить commission на null, так чтобы в случае неопределенности final_price принимал значение salary
alter table employees
add column final_salary int;

set sql_safe_updates = 0;

update employees 
set 
    final_salary = ifnuLL(salary + salary * commission / 10, salary);

 -- 8. Вывести поле email в нижнем регистре.
select 
    first_name,
    last_name,
	lower(email) AS email
from
    employees;
    
-- 9. Создать новое поле chk_email типа varchar(128).
alter table employees
add column chk_email varchar(128);

-- 10. Заполнить поле chk_email. Если длина email меньше 3, значением chk_email будет 'Введите больше символов', 
-- если длина email больше/равно 3 и меньше 7,  значением chk_email будет 'Кол/во символов совпадает', 
-- если длина email больше/равно 7,  значением chk_email будет 'Введите меньше символов'.
update employees 
set 
    chk_email = case
		when length(email) < 3 then 'введите больше символов'
        when length(email) < 7 then 'Кол/во символов совпадает'
        else 'Введите меньше символов'
end;

seLect *
from employees;
