create database salesmanagement;
use salesmanagement;

create table product (
    product_id char(5) primary key,
    product_name char(100) not null,
    manufacturer char(100) not null,
    price decimal(15,2) not null check (price > 0),
    stock int default 0 check (stock >= 0)
);

create table customer (
    customer_id char(5) primary key,
    full_name char(100) not null,
    email char(100) unique,
    phone char(10),
    address char(255)
);

create table `order` (
    order_id char(5) primary key,
    order_date date not null,
    total_amount decimal(15,2) check (total_amount >= 0),
    customer_id char(5),
    foreign key (customer_id) references customer(customer_id)
);

create table order_detail (
    order_id char(5),
    product_id char(5),
    quantity int not null check (quantity > 0),
    price_at_time decimal(15,2) not null check (price_at_time > 0),
    primary key (order_id, product_id),
    foreign key (order_id) references `order`(order_id),
    foreign key (product_id) references product(product_id)
);

alter table `order`
add note text;

alter table product
change manufacturer nha_san_xuat varchar(100);

insert into product values
('p001','macbook air m2','apple',25000000,10),
('p002','iphone 15','apple',20000000,15),
('p003','dell xps 13','dell',22000000,8),
('p004','asus rog','asus',18000000,5),
('p005','logitech mouse','logitech',500000,50);

insert into customer values
('c001','nguyen van a','a@gmail.com','090114124','hcm'),
('c002','tran thi b','b@gmail.com',null,'hn'),
('c003','le van c','c@gmail.com','0903123456','dn'),
('c004','pham thi d','d@gmail.com','0904123456','ct'),
('c005','hoang van e','e@gmail.com',null,'hp');

insert into `order` values
('dh001','2026-04-01',45000000,'c001',null),
('dh002','2026-04-02',20000000,'c003',null),
('dh003','2026-04-03',18000000,'c004',null),
('dh004','2026-04-04',500000,'c001',null),
('dh005','2026-04-05',22000000,'c003',null);

insert into order_detail values
('dh001','p001',1,25000000),
('dh001','p002',1,20000000),
('dh002','p002',1,20000000),
('dh003','p004',1,18000000),
('dh004','p005',1,500000);

set sql_safe_updates = 0;
update product
set price = price * 1.1
where nha_san_xuat = 'apple';


delete from customer
where phone is null;

select *
from product
where price between 10000000 and 20000000;

select p.product_name
from product p
join order_detail od on p.product_id = od.product_id
where od.order_id = 'dh001';

select distinct c.*
from customer c
join `order` o on c.customer_id = o.customer_id
join order_detail od on o.order_id = od.order_id
join product p on od.product_id = p.product_id
where p.product_name = 'macbook air m2';