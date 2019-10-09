drop table if exists grade_points;
create table grade_points(
grade character(2) not null,
points numeric(3,1) not null,
primary key(grade)
)engine=InnoDB character set=utf8;

insert into grade_points(grade, points)
values("A+", 4),
("A", 3.8),
("A-", 3.6),
("B+", 3.3),
("B", 3),
("B-", 2.8),
("C+", 2.6),
("C", 2.4),
("C-", 2);

# a
select sum(points) as total_point
from takes, grade_points
where takes.ID = 10033
and takes.grade = grade_points.grade;

select sum(points) as total_point
from (select * from takes where ID = 10033) as t natural join grade_points;

# b
select (
	select sum(points) as total_point
	from (select * from takes where ID = 10033) as t natural join grade_points
) /  ( 
	select sum(credits) as total_credits
	from takes, course
	where takes.ID = 10033
	and takes.course_id = course.course_id
) as gpa;


select (
	select sum(points) as total_point
	from (select * from takes where ID = 10033) as t natural join grade_points
) / (
	select sum(credits) as total_credits
    from (select * from takes where ID = 10033) as tm natural join course
) as gpa;

select ID, sum(points) / sum(credits)
from (select * from takes where ID = 10033) as t natural join grade_points natural join course;

# c
select ID, sum(points) as total_point
from takes as t natural join grade_points
group by ID;

select ID, sum(credits) as total_credits
from takes as t natural join course
group by ID;

select ID, sum(points) / sum(credits) as gpa
from takes as t natural join grade_points natural join course
group by ID;


