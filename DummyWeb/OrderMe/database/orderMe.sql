create database orderme;
use orderme;

create table customer
	(TelNo varchar(10) primary key,
    CName varchar(20),
    CPassword varchar(20));
    
create table partner
	(Email varchar(30) primary key,
    RestName varchar(50),
    PPassword varchar(20));

create table recipe
	(recipeID varchar(10) primary key,
    RName varchar(50),
    Price int,
    Email varchar(30) ,
    foreign key(Email) references partner(Email),
    Image blob);

create table  placeOrder
	(OrderId varchar(10) primary key,
    CTelNo varchar(10),
    foreign key(CTelNo) references customer(TelNo),
    Details varchar(50),
    SFD varchar(3),
    placedorder bool);

create table confirmOrder
	(OrderId varchar(10),
    foreign key(OrderId) references placeOrder(OrderId),
    CTelNo varchar(10),
    foreign key(CTelNo) references customer(TelNo),
    deviceId varchar(10));
