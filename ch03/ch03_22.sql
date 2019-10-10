# 在2009年最多开设一次的课程
select T.course_id
from course as T
where 1 >= (
	select count(R.course_id)
    from section as R
    where T.course_id = R.course_id
    and R.year = 2009
);

#a
where 1 >= (
	select count(*)
    from course
    group by title
)
