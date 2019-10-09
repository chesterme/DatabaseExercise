create table marks(
ID varchar(10) not null primary key,
score double not null
)engine=InnoDB character set=utf8;

create table levels(
ID varchar(10) not null primary key,
level varchar(1) not null
)engine=InnoDB character set=utf8;

insert into marks(ID, score)
values("12345", 30.5),
("12346", 44.5),
("12347", 55),
("12348", 70),
("12349", 85);

set SQL_SAFE_UPDATES = 0;

# a
insert into levels(ID, level)
select ID, (case
when score < 40 then "F"
when score < 60 then "C"
when score < 80 then "B"
else "A" end) as level
from marks;

select * from levels;

# b
select count(ID) as number, level
from levels
group by level



