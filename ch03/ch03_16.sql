delete from managers;

insert into employee(employee_name, street, city)
values("employee_name_6", "street_1", "city_1");

show create table managers;
insert into managers(employee_name, manager_name)
values("employee_name_2", "employee_name_1"),
("employee_name_5", "employee_name_1"),
("employee_name_6", "employee_name_1"),
("employee_name_7", "employee_name_1"),
("employee_name_8", "employee_name_4");


# a
select employee_name
from works
where company_name = "company_name_1";

# 选择数据库中所有居住在相同城市和街道的员工信息
select distinct t1.city, t1.street, t1.employee_name
from employee as t1, employee as t2
where t1.city = t2.city
and t1.street = t2.street
and t1.employee_name != t2.employee_name;

select distinct t1.city, t1.street, t1.employee_name
from employee as t1 join employee as t2 using(city, street)
where t1.employee_name != t2.employee_name;

select t1.city, t1.street, t1.employee_name
from employee as t1
where exists(
select t2.city, t2.street, t2.employee_name
from employee as t2
where t1.city = t2.city
and t1.employee_name != t2.employee_name
);

# b
select *
from employee as t1 natural join works as t2 join company as t3 using(company_name)
where t1.city = t3.city;

# c
select t1.employee_name, t1.street, t1.city
from (
	select employee_name, street, city
    from employee natural join managers
	) as t1,
	(
	select employee_name, street, city
	from employee where employee_name in (
		select manager_name
		from managers
	) )as t2
where t1.street = t2.street
and t1.city = t2.city
and t1.employee_name != t2.employee_name;

# d
select employee_name, company_name, salary, salary_avg
from works natural join(
	select company_name, avg(salary) as salary_avg
	from works
	group by company_name) as t
where salary > salary_avg;

# e
select company_name, sum(salary) salary_sum
from works
group by company_name
having salary_sum = (
	select min(salary_sum) as salary_sum_min
	from (
	select sum(salary) as salary_sum
	from works
	group by company_name) as t
);


