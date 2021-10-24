drop database orderme;

create database orderme;
use orderme;

create table customer
	(TelNo varchar(10) primary key,
    CName varchar(20),
    CPassword varchar(20));
    
create table partner
	(Email varchar(30) primary key,
    RestName varchar(50),
    id varchar(4),
    PPassword varchar(20));

create table  placeOrder
	(OrderId varchar(10) primary key,
    CTelNo varchar(10),
    foreign key(CTelNo) references customer(TelNo),
    Details varchar(50),
    address varchar(100),
    _date varchar(8),
    SFD varchar(3),
    placedorder bool,
    restaurent varchar(50));

create table confirmOrder
	(OrderId varchar(10),
    foreign key(OrderId) references placeOrder(OrderId),
    CTelNo varchar(10),
    foreign key(CTelNo) references customer(TelNo),
    deviceId varchar(10),
    restaurent varchar(50));
