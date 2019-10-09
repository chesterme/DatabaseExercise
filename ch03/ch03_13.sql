drop table if exists owns;
drop table if exists participated;
drop table if exists accident;
drop table if exists person;
drop table if exists car;

create table person(
driver_id varchar(20) not null primary key,
name varchar(20) not null,
address varchar(20) not null
);

create table car(
license varchar(20) not null primary key,
model varchar(20) not null,
year int(4)
);

create table accident(
report_number varchar(10) not null primary key,
date date,
location varchar(20)
);

create table owns(
driver_id varchar(20) not null,
license varchar(20),
primary key(driver_id),
constraint fk_owns_driver foreign key(driver_id) references person(driver_id),
constraint fk_owns_car  foreign key(license) references car(license)
);

create table participated(
report_number varchar(10) not null,
license varchar(20) not null,
driver_id varchar(20) not null,
damage_amount double,
primary key(report_number, license),
constraint fk_participated_accident foreign key(report_number) references accident(report_number),
constraint fk_participated_car foreign key(license) references car(license),
constraint fk_participated_person foreign key(driver_id) references person(driver_id)
);