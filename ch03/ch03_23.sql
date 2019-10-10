# 2009年重修课程的平均分
select course_id, semester, year, sec_id, avg(tot_cred)
from takes natural join student
where year = 2009
group by course_id, semester, year, sec_id
having count(ID) >= 2;

# section表中的主键(course_id, semester, year, sec_id)完全来自takes表，它的其他属性只起到附加额外说明的作用 
select course_id, semester, year, sec_id, avg(tot_cred)
from takes natural join student natural join section
where year = 2009
group by course_id, semester, year, sec_id
having count(ID) >= 2;