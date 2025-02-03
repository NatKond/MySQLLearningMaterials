use homeworks;

create table workers(
worker_id int primary key auto_increment,
fname varchar(128) not null,
last_name varchar(128) not null,
email varchar(128) not null,
phone varchar(128) not null
);

alter table workers
add column salary decimal(9,2);

alter table workers
modify column salary int;

alter table workers 
rename column fname to first_name;

alter table workers
drop column phone;

alter table workers
add column department varchar(128) not null after last_name;

insert into workers (first_name, last_name, department, email, salary) 
values ('John', 'Smith', 'Engineering', 'john.smith@example.com', 75000);

insert into workers (first_name, last_name, department, email, salary) 
values ('Emma', 'Johnson', 'Marketing', 'emma.johnson@example.com', 68000);

insert into workers (first_name, last_name, department, email, salary) 
values ('Michael', 'Brown', 'Sales', 'michael.brown@example.com', 72000);

insert into workers (first_name, last_name, department, email, salary) 
values ('Sophia', 'Davis', 'HR', 'sophia.davis@example.com', 65000);

insert into workers (first_name, last_name, department, email, salary) 
values ('William', 'Miller', 'Finance', 'william.miller@example.com', 80000);

insert into workers (first_name, last_name, department, email, salary) 
values ('Olivia', 'Wilson', 'IT', 'olivia.wilson@example.com', 90000);

insert into workers (first_name, last_name, department, email, salary) 
values ('James', 'Anderson', 'Support', 'james.anderson@example.com', 60000);

select *
from workers;