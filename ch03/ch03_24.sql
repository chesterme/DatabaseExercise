select t1.dept_name, t1.value as t1_value, t2.value as t2_value
from (select dept_name, sum(salary) as value
	 from instructor
     group by dept_name) as t1,
     (select avg(value) as value
     from (
		select dept_name, sum(salary) as value
		 from instructor
		 group by dept_name) as t
	 ) as t2
where t1.value >= t2.value;