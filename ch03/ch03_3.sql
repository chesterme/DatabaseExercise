# a
update instructor
set salary = salary * 1.1
where dept_name = "Com. Sci.";

# b
set SQL_SAFE_UPDATES = 0;

delete from prereq
where course_id in(
	select course_id
	from course
	where course_id not in (
		select course_id
		from section
	)
);

delete from prereq
where prereq_id in(
	select course_id
    from course
    where course_id not in(
		select course_id
        from section
    )
);

delete from course
where course_id not in(
	select course_id
    from section
);

# c
select * 
from student
where tot_cred > 100;

# 使用show create table instructor查看表结构，定位到哪些插入语句违反了完整性约束
insert into instructor(ID, name, dept_name, salary)
select ID, name, dept_name, 30000 as salary
from student
where tot_cred > 120;