# a
select name, count(course_id) as course_number
from takes natural join student
group by ID
having course_number > 1
and ID in (
	select distinct ID
	from takes
	where course_id in (
		select course_id 
		from course
		where dept_name = "Comp. Sci. "
	)
);

select ID, count(course_id) as course_number
from student natural join takes
group by ID 
having course_number > 1
and ID in(
	select distinct ID
    from takes natural join course
    where dept_name = "Comp. Sci. "
);

# b
desc section;

select distinct ID, name
from takes natural join student
where course_id not in(
	select course_id
	from section
	where year < 2009
);

# c
select dept_name, max(salary)
from instructor
group by dept_name;

# d
select dept_name, min(max_dept_salary)
from (
	select dept_name, max(salary) as max_dept_salary
	from instructor
	group by dept_name
)as t;
