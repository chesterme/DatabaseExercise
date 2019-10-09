# a
# 没有办法创建该课程，因为违反了约束条件，学分不能为0
show create table course;

# 修改约束条件
alter table course 
drop check course_chk_1;

alter table course
add constraint course_chk_1 check(credits >= 0);

insert into course(course_id, title, dept_name, credits)
values("CS - 001", "Weekly Seminar", "Comp. Sci. ", 0);

# b
desc section;
select * from section;

insert into section(course_id, sec_id, semester, year)
values("CS - 001", 1, "Fall", 2009);

# c
insert into takes(ID, course_id, sec_id, semester, year)
(
select ID, course_id, sec_id, semester, year
from
(select ID
from student
where dept_name = "Comp. Sci.") t1,
(select course_id, sec_id, semester, year
from section
where course_id = "CS - 001") t2
);

# d
delete from takes
where ID = (
	select ID
    from student
    where name = "Chavez"
);

# e
select * 
from takes
where course_id = "CS - 001";
delete from section
where course_id = "CS - 001";
delete from takes
where course_id = "CS - 001";
delete from course
where course_id = "CS - 001";

# f
delete from takes
where course_id in (
	select course_id
    from course natural join section
    where title like '%database%'
);

