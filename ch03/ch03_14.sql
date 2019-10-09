# a
select count(report_number) as accident_number
from participated
where license = (
	select license
	from owns
	where driver_id = (
		select driver_id
		from person
		where name = "John Smith"
	)
);

select count(report_number) as accident_number
from participated natural join owns natural join person
where name = "John Smith";

# b
update participated
set damage_amount = 3000
where report_number = "AR2197"
and license = "AABB2000";