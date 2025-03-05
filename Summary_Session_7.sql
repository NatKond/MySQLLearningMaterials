use gt081024;
-- Uniom/union all
select first_name, last_name, 'berlin' as city
from user_berlin
union all
select first_name, last_name, 'bremen' as city
from user_bremen;

drop table students;

create table students(
	id integer primary key,
	first_name varchar(128),
	last_name varchar(128),
	age int,
	email varchar(128),
	start_year int,
	faculty varchar(128)
);

create table graduates(
	id integer primary key,
	first_name varchar(128),
	last_name varchar(128),
	age int,
    email varchar(128),
    start_year int,
    graduation_year int,
	faculty varchar(128)
);

-- Данные для таблицы students:

INSERT INTO students (id, first_name, last_name, age, email, start_year, faculty)
VALUES
(1, 'John', 'Doe', 20, 'johndoe@university.com', 2022, 'Computer Science'),
(2, 'Alice', 'Smith', 22, 'alicesmith@university.com', 2021, 'Mathematics'),
(3, 'Bob', 'Johnson', 21, 'bobjohnson@university.com', 2022, 'Physics'),
(4, 'Eva', 'White', 23, 'evawhite@univer.com', 2020, 'Biology'),
(5, 'James', 'Taylor', 20, 'jamestaylor@university.com', 2022, 'Chemistry');

-- Данные для таблицы graduates:

INSERT INTO graduates (id, first_name, last_name, age, email, start_year, graduation_year, faculty)
VALUES
(1, 'Mary', 'Brown', 24, 'marybrown@university.com', 2019, 2023, 'Computer Science'),
(2, 'David', 'Wilson', 25, 'davidwilson@university.com', 2018, 2022, 'Mathematics'),
(3, 'Sophia', 'Miller', 26, 'sophiamiller@university.com', 2017, 2021, 'Physics'),
(4, 'Olivia', 'Davis', 24, 'oliviadavis@gmail.com', 2019, 2023, 'Biology'),
(5, 'Liam', 'Moore', 27, 'liammoore@university.com', 2015, 2020, 'Chemistry');

-- 2. Вывести всех студентов и выпускников с их именами, фамилиями, email и факультетом.
select first_name, last_name, email, faculty from students
union all
select first_name, last_name, email, faculty from graduates;

-- 3. Вывести всех студентов и выпускников, добавив поле status, где:
-- 'Student' для студентов
-- 'Graduate' для выпускников.
select first_name, last_name, faculty, 'Student' as status from students
union all
select first_name, last_name, faculty, 'Graduate' as status from graduates;
-- 4. Вывести имена, фамилии, факультет, год начала и окончания учебы студентов и выпускников. 
-- Если для студента не указан год окончания, выведите год начала учебы + 4.
select first_name, last_name, faculty, start_year, start_year + 4 as status from students
union all
select first_name, last_name, faculty, start_year, graduation_year from graduates;
-- 5. Выведите все уникальные факультеты, на которых учились или учатся студенты и выпускники, объединяя данные из обеих таблиц.
select faculty from students
union
select faculty from graduates;
-- 6. Выведите имена, фамилии и год начала учебы студентов и выпускников, где год начала учебы больше 2020.
select first_name, last_name, start_year from students
where start_year > 2020
union
select first_name, last_name, start_year from graduates
where start_year > 2020;
-- 7. Выведите все имена и фамилии студентов и выпускников, где фамилия начинается с буквы "S".
select first_name, last_name from students
where last_name like 'S%'
union
select first_name, last_name from graduates
where last_name like 'S%';
-- 8. Выведите имена, фамилии, факультет и возраст студентов и выпускников. 
-- Добавьте столбец, который будет показывать, если возраст студента или выпускника меньше 23 лет — выводите 'Young', 
-- если 23 и больше — выводите 'Mature'. 
select first_name, last_name, faculty, age,
	case 
		when age < 23 then 'Young'
		else 'Mature'
	end as maturity
from students
union all
select first_name, last_name, faculty, age,
	case 
		when age < 23 then 'Young'
		else 'Mature'
	end as maturity
from graduates;
-- 9. Выведите имена, фамилии и факультет студентов и выпускников. 
-- Добавьте столбец, который будет показывать, на каком факультете находятся студенты: 
-- если факультет — 'Computer Science', выводите 'Tech', если 'Biology' — выводите 'Life Sciences', 
-- для всех других факультетов выводите 'Other'. 
select first_name, last_name,
	case 
		when faculty = 'Computer Science' then 'Tech'
		when faculty = 'Biology' then 'Life Sciences'
		else 'Other'
	end as faculty
from students
union all
select first_name, last_name,
case 
		when faculty = 'Computer Science' then 'Tech'
		when faculty = 'Biology' then 'Life Sciences'
		else 'Other'
	end as faculty
from graduates;
-- 10. Выведите имена, фамилии и email студентов и выпускников. Добавьте столбец, который будет показывать 
-- 'Valid Email' для всех email-ов с доменом "@university.com", и 'Invalid Email' для всех остальных.

select first_name, last_name, email,
	case 
		when right(email, 15) = '@university.com' then 'Valid Email'
		else 'Invalid Email'
	end as email_verification
from students
union all
select first_name, last_name, email,
	case 
		when right(email, 15) = '@university.com' then 'Valid Email'
		else 'Invalid Email'
	end as email_verification
from graduates;

-- 2 вариант
select first_name, last_name, email, if(email like '%@university.com', 'Valid Email', 'Invalid Email') as email_status
from students
union all
select first_name, last_name, email, if(email like '%@university.com', 'Valid Email', 'Invalid Email') as email_status
from graduates;