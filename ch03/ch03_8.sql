drop table if exists borrower;
drop table if exists depositor;
drop table if exists account;
drop table if exists loan;
drop table if exists branch;
drop table if exists customer;

set SQL_SAFE_UPDATES = 0;


create table branch(
`branch_name` varchar(20),
`branch_city` varchar(20),
`assets` double,
primary key(branch_name)
);

create table customer(
`customer_name` varchar(20),
`customer_street` varchar(20),
`customer_city` varchar(20),
primary key(customer_name)
);

create table loan(
`loan_number` int primary key,
`branch_name` varchar(20) not null,
`amount` double,
constraint fk_branch_customer foreign key(branch_name) references branch(branch_name)
);

create table borrower(
`customer_name` varchar(20) not null,
`loan_number` int not null,
primary key(customer_name, loan_number),
constraint fk_borrower_customer foreign key(customer_name) references customer(customer_name),
constraint fk_borrower_loan foreign key(loan_number) references loan(loan_number)
);

create table account(
`account_number` int primary key,
`branch_name` varchar(20) not null,
`balance` double,
constraint fk_account_branch foreign key(branch_name) references branch(branch_name)
);

create table depositor(
`customer_name` varchar(20) not null,
`account_number` int not null,
primary key(customer_name, account_number),
constraint fk_depositor_customer foreign key(customer_name) references customer(customer_name),
constraint fk_depositor_account foreign key(account_number) references account(account_number)
);

delete from branch;
insert into branch(branch_name, branch_city, assets)
values("中国银行", "广州", 1000000),
("建设银行", "广州", 2000000),
("民生银行", "广州", 1000000);

delete from customer;
insert into customer(customer_name, customer_street, customer_city)
values("张三", "天河", "广州"),
("李四", "番禺", "广州"),
("王五", "黄埔", "广州"),
("Smith", "天河", "广州"),
("Ross", "天河", "广州");

delete from account;
insert into account(account_number, branch_name, balance)
values(1, "中国银行", 1000),
(2, "中国银行", 2000),
(3, "建设银行", 3000),
(4, "民生银行", 0);

delete from depositor;
insert into depositor(customer_name, account_number)
values("张三", 1),
("李四", 2),
("王五", 3);

delete from loan;
insert into loan(loan_number, branch_name, amount)
values(1, "中国银行", 1000),
(2, "建设银行", 2000);

delete from borrower;
insert into borrower(customer_name, loan_number)
values("张三", 1),
("李四", 2);

# a，找出银行中所有账户但无贷款的客户
select distinct customer_name 
from depositor
where customer_name not in
(select distinct customer_name from borrower );

# b
select customer_name
from customer
where customer_street = (select customer_street from customer where customer_name = "Smith")
and customer_city = (select customer_city from customer where customer_name = "Smith")
and customer_name != "Smith";

select customer_name
from customer
where (customer_street, customer_city) in (select customer_street, customer_city from customer where customer_name = "Smith")
and customer_name != "Smith";

select c1.customer_name
from customer c1 join customer c2 using(customer_street, customer_city)
where c2.customer_name = "Smith"
and c1.customer_name != "Smith";


# c
select branch_name
from account
where account_number = (
	select account_number
    from depositor
    where customer_name = (
		select customer_name
        from customer
        where customer_street = "天河"
    )
);

select branch_name
from account natural join depositor natural join customer
where customer_street = "天河";