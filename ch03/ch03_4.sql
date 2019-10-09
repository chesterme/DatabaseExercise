drop table if exists person;
drop table if exists car;
drop table if exists accident;
drop table if exists owns;
drop table if exists participated;

create table person(
driver_id varchar(10) not null,
name varchar(10) not null,
address varchar(30),
primary key(driver_id)
)engine=InnoDB charset=utf8;

create table car(
license varchar(20) not null,
model varchar(20),
year varchar(4),
primary key(license)
)engine=InnoDB charset=utf8;

create table accident(
report_number varchar(20) not null,
date date,
location varchar(30),
primary key(report_number)
)engine=InnoDB charset=utf8;

create table owns(
driver_id varchar(20) not null,
license varchar(20) not null,
primary key(driver_id, license),
foreign key(driver_id) references person(driver_id),
foreign key(license) references car(license)
)engine=InnoDB charset=utf8;

create table participated(
report_number varchar(20) not null,
license varchar(20) not null,
driver_id varchar(20) not null,
damage_amount double,
primary key(report_number, license),
foreign key(license) references car(license),
foreign key(driver_id) references person(driver_id),
foreign key(report_number) references accident(report_number)
)engine=InnoDB charset=utf8;


insert into person(driver_id, name, address)
values("1234567890", "dervier_1", "address_1"),
("1234567891", "dervier_2", "address_2"),
("1234567892", "dervier_3", "address_3"),
("1234567893", "dervier_4", "address_4"),
("1234567894", "dervier_5", "address_5"),
("1234567895", "dervier_6", "address_6"),
("1234567896", "dervier_7", "address_7");

insert into car(license, model, year)
values ("0987654321", "model_1", "2019"),
("0987654322", "model_1", "2019"),
("0987654323", "model_2", "2017"),
("0987654324", "model_1", "2019"),
("0987654325", "model_3", "2018"),
("0987654326", "model_1", "2019"),
("0987654327", "model_4", "2013"),
("0987654328", "model_1", "2019"),
("0987654329", "model_5", "2016");

insert into accident(report_number, date, location)
values("9087654321", "2019-01-01", "location_1"),
("9087654322", "2019-01-01", "location_1"),
("9087654323", "2019-02-01", "location_1"),
("9087654324", "2019-03-01", "location_1"),
("9087654325", "2019-04-01", "location_1"),
("9087654326", "2019-05-01", "location_1"),
("9087654327", "2019-01-01", "location_1");

insert into owns(driver_id, license)
values("1234567890", "0987654321"),
("1234567890", "0987654322"),
("1234567895", "0987654323"),
("1234567894", "0987654324"),
("1234567893", "0987654325"),
("1234567892", "0987654326"),
("1234567891", "0987654327"),
("1234567891", "0987654328");

delete from participated;
insert into participated(report_number, license, driver_id, damage_amount)
values("9087654321", "0987654321", "1234567890", 10000),
("9087654322", "0987654322", "1234567890", 12000),
("9087654323", "0987654323", "1234567895", 10400),
("9087654324", "0987654323", "1234567895", 30000),
("9087654325", "0987654328", "1234567891", 15000),
("9087654326", "0987654326", "1234567892", 40000),
("9087654327", "0987654327", "1234567891", 17000);


# a
select count(driver_id) as counter
from participated natural join accident
where date between "2019-01-01" and "2019-12-31";

# b
insert into accident(report_number, date, location)
values("9876543219", "2018-01-10", "location_2");

# c
delete from car
where model = "model_1"
and license in (
	select license
    from owns
    where driver_id = (
		select driver_id
        from person
        where name = "deriver_1"
    )
);

delete from car
where model = "model_1"
and license in (
	select license
    from owns natural join person
    where name = "deriver_1"
);