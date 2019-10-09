select * from account;
insert into account(account_number, branch_name, balance)
values(5, "建设银行", 200000),
(6, "民生银行", 300000);

select * from depositor natural join account;
insert into depositor(customer_name, account_number)
values("张三", 5),
("张三", 6);

delete from depositor
where account_number in (
	select account_number
    from account
    where branch_name = "民生银行"
)and customer_name = "李四";

select * from depositor natural join account;

insert into branch(branch_name, branch_city, assets)
values("branch_name_1", "深圳", 100000),
("branch_name_2", "深圳", 2000000);

update branch
set assets = 9000000000
where branch_name = "branch_name_2";

# a
select customer_name, count(distinct branch_name) as branch_number
from branch natural join account natural join depositor
where branch_city = "广州"
group by customer_name
having branch_number = (
	select count(branch_name)
    from branch
    where branch_city = "广州"
);

# b
select branch_name, sum(amount) as amount_sum
from loan
group by branch_name;

# c
select branch_name, branch_city, assets
from branch
where assets > some (
select assets
from branch
where branch_city = "深圳")
and branch_city != "深圳";
