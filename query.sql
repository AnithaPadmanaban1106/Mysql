CREATE SCHEMA amazon_db;
USE amazon_db;
create database devtask_db;
use devtask_db;

create table user_info
(
user_id int primary key auto_increment,
user_name varchar(20) not null,
started_date date
);

select * from user_info;

insert into user_info(user_name,started_date)values('ram',str_to_date('10/11/2002','%d/%m/%Y'));
insert into user_info(user_name,started_date)values('ravi',str_to_date('10/11/2000','%d/%m/%Y'));
insert into user_info(user_name,started_date)values('ragav',str_to_date('10/11/2001','%d/%m/%Y'));
insert into user_info(user_name,started_date)values('raju',str_to_date('10/11/2004','%d/%m/%Y'));

DELIMITER //
CREATE FUNCTION no_of_years(date1 date) 
RETURNS int DETERMINISTIC
BEGIN
 DECLARE date2 DATE;
  Select current_date()into date2;
  RETURN year(date2)-year(date1);
END 
//
DELIMITER ;

select user_id,user_name,no_of_years(started_date)  from user_info;




create table order_info
(
order_id int primary key auto_increment,
customer_name varchar(20) not null,
customer_address varchar(20) not null,
 product_id int not null,
 order_status varchar(20) not null
);

insert into order_info(customer_name,customer_address,product_id,order_status) values('pavi','tanjore','101','conformed');

create table order_log
(
log_id int primary key auto_increment,
product_id int not null,
order_status varchar(20) not null,
log_date date
);
insert into order_log(product_id,order_status,log_date)values('101','conformed',str_to_date('10/11/2019','%d/%m/%Y'));

select * from order_info;
select * from order_log;

DELIMITER $$

CREATE PROCEDURE callback8()
BEGIN
 DECLARE `_rollback` BOOL DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollback` = 1;
    START TRANSACTION;
 insert into order_info(customer_name,customer_address,product_id,order_status) values('paavai','vellore','105','conformed');
insert into order_log(product_id,order_status,log_date)values('105',str_to_date('12/11/2019','%d/%m/%Y'));

IF `_rollback` THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;
END$$
DELIMITER ;



call callback8;