drop table if exists works;
drop table if exists managers;
drop table if exists company;
drop table if exists employee;


create table employee(
employee_name varchar(20) not null primary key,
street varchar(20),
city varchar(20)
);

create table company(
company_name varchar(20),
city varchar(20) not null,
primary key(company_name, city)
);

create table works(
employee_name varchar(20) not null,
company_name varchar(20) not null,
salary double not null,
primary key(employee_name),
constraint fk_works_employee foreign key(employee_name) references employee(employee_name),
constraint fk_works_company foreign key(company_name) references company(company_name)
);

create table managers(
employee_name varchar(20) not null primary key,
manager_name varchar(20),
constraint fk_managers_employee foreign key(employee_name) references employee(employee_name),
constraint fk_managers_employee foreign key(manager_name) references employee(employee_name)
);