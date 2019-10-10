# a
update works
set salary = salary * 1.1
where company_name = "First Bank Corporation";

# b
update works
set salary = salary * 1.1
where employee_name = (
	select employee_name
    from (select * from works) as t
    where company_name = "First Bank Corporation"
    and employee_name in (
		select manager_name
        from managers
    )
);

# c
set SQL_SAFE_UPDATES = 0;
delete from managers
where employee_name in (
	select employee_name
    from works
    where company_name = "Small Bank Corporation"
);

delete from works
where company_name = "Small Bank Corporation";