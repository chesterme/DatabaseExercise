# 3.1 
# 3.1 a
select course_id 
from department as t, course as c
where t.dept_name="Comp. Sci." and t.dept_name = c.dept_name and c.credits = 3;

select course_id
from department natural join course
where department.dept_name = "Comp. Sci." and course.credits = 3;

select course_id
from (select * from department where dept_name = "Comp. Sci.") as d natural join course as c
where c.credits = 3;

select course_id
from course
where dept_name = "Comp. Sci." and credits = 3;

# 3.1 b
select s.name
from student as s
where s.id in (
	select s_id
    from advisor
    where i_id in (
		select i.id
        from instructor as i
        where name = "Einstein"
    )
);

select s.name
from student as s, advisor, instructor as i
where s.ID = advisor.s_ID
and advisor.i_ID = i.ID
and i.name = "Einstein";

# 3.1 c
select max(salary)
from instructor;

# 3.1 f
select name, salary
from instructor
where salary in (
	select max(salary)
    from instructor
);

# 3.1 e
select time_slot_id, count(ID) as takes_number
from takes, section
where takes.year = 2009 and takes.semester = "Fall" 
and takes.course_id = section.course_id
and takes.sec_id = section.sec_id
and takes.semester = section.semester
and takes.year = section.year
group by time_slot_id;

select time_slot_id, count(ID) as takes_number
from takes as t natural join section as s
where t.year = 2009 and t.semester = "Fall"
group by time_slot_id;

select time_slot_id, count(t.ID) as takes_number
from (select * from takes where year = 2009 and semester = "Fall") as t natural join section 
group by time_slot_id;

# 3.1 f
select max(takes_number) as max_take_number
from(
	select time_slot_id, count(t.ID) as takes_number
	from (select * from takes where year = 2009 and semester = "Fall") as t natural join section
	group by time_slot_id
) as temp;

# 3.1 g
select time_slot_id, max(takes_number) as max_take_number
from(
	select time_slot_id, count(t.ID) as takes_number
	from (select * from takes where year = 2009 and semester = "Fall") as t natural join section
	group by time_slot_id
) as temp;