drop table if exists members;
drop table if exists book;
drop table if exists borrowed;

create table members(
memb_no varchar(10) not null primary key,
name varchar(20) not null,
age int(3)
);

create table book(
isbn varchar(20) not null primary key,
authors varchar(20) not null,
publisher varchar(20)
);

create table borrowed(
memb_no varchar(10) not null,
isbn varchar(20) not null,
date date,
primary key(memb_no, isbn),
constraint fk_borrowed_members foreign key(memb_no) references members(memb_no),
constraint fk_borrowed_book foreign key(isbn) references book(isbn)
);

# a
select name
from members natural join borrowed natural join book
where publisher = "McGraw-Hill";

# b
select name
from members natural join borrowed natural join book
where publisher = "McGraw-Hill"
and count(distinct isbn) = (
	select count(distinct isbn)
	from book
	where publisher = "McGraw-Hill");
    
# c
select name
from book natural join borrowed natural join members
group by publisher
having count(distinct isbn) > 5;

# d
select avg(isbn)
from members natural join borrowed 
group by memb_no;
