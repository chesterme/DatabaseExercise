# a
update employee
set city = "Newtown"
where employee_name = "employee_name_1";

# b
# error: 不能同时对一张表进行更改和查询
# update works
# set salary = salary * 1.1
# where employee_name in (
#	select employee_name
#    from managers
#    where employee_name in (
#		select employee_name
#        from works
#        where company_name = "company_name_1"
#        and salary < 4000
#    )
#);


update works
set salary = case
	when salary < 4000 then salary * 1.1
    else salary * 1.03 
    end
where employee_name in (
select employee_name
    from managers
    where employee_name in (
		select employee_name
        from (select * from works) temp
        where company_name = "company_name_1"
        and salary < 4000
    )
);
