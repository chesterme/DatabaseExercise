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
constraint fk_managers_employee foreign key(employee_name) references employee(employee_name)
);

set SQL_SAFE_UPDATES = 0;

insert into employee(employee_name, street, city)
values ("employee_name_1", "street_1", "city_1"),
("employee_name_2", "street_2", "city_2"),
("employee_name_3", "street_1", "city_1"),
("employee_name_4", "street_3", "city_1"),
("employee_name_5", "street_4", "city_3"),
("employee_name_7", "street_4", "city_3"),
("employee_name_8", "street_4", "city_3"),
("employee_name_9", "street_4", "city_3"),
("employee_name_10", "street_4", "city_3");

insert into company(company_name, city)
values ("company_name_1", "city_1"),
("company_name_2", "city_1"),
("company_name_3", "city_2"),
("company_name_4", "city_3"),
("company_name_4", "city_4"),
("company_name_4", "city_5"),
("company_name_4", "city_6");

insert into works(employee_name, company_name, salary)
values ("employee_name_1", "company_name_1", 3000),
("employee_name_2", "company_name_2", 4000),
("employee_name_3", "company_name_3", 9000),
("employee_name_4", "company_name_2", 8000),
("employee_name_5", "company_name_1", 7000),
("employee_name_7", "company_name_1", 7000),
("employee_name_8", "company_name_1", 7000),
("employee_name_9", "company_name_2", 7000),
("employee_name_10", "company_name_2", 7000);


insert into managers(employee_name, manager_name)
values("employee_name_1", "manager_name_1"),
("employee_name_2", "manager_name_2"),
("employee_name_3", "manager_name_3"),
("employee_name_4", "manager_name_4"),
("employee_name_5", "manager_name_5");

# a
select employee_name, city
from employee
where employee_name in (
	select employee_name
    from works
    where company_name = "company_name_1"
);

select employee_name, city
from employee natural join works
where company_name = "company_name_1";

# b
select employee_name, street, city
from employee
where employee_name in (
	select employee_name
    from works
    where company_name = "company_name_1"
    and salary > 3000
);

# c
select employee_name
from works
where company_name not in (
	select employee_name
    from works
    where company_name = "company_name_1"
);

select employee_name
from works
where company_name != "company_name_1";

# d
select employee_name, salary
from works
where salary > all (
	select salary
	from works
	where company_name = "company_name_1"
);

select employee_name, salary
from works
where salary > (
	select max(salary)
    from works
    where company_name = "company_name_1"
);

# e
select company_name
from company
where city in (
	select city
    from company
    where company_name = "company_name_1"
);

# f
# error, 当使用max聚集函数时，如果出现两个相同大小的元素，只返回其中的一个
#select company_name, max(employee_number)
#from (
#select company_name, count(employee_name) as employee_number
#from works
#group by company_name) as t;


select company_name, count(employee_name) as employee_number
from works
group by company_name
having count(employee_name) = (
	select max(employee_number)
	from (
	select company_name, count(employee_name) as employee_number
	from works
	group by company_name) as t
);

# g
select company_name, avg(salary) as salary_avg
from works
group by company_name
having salary_avg > all(
	select avg(salary) as salary_avg
	from works
	where company_name = "company_name_1"
);
