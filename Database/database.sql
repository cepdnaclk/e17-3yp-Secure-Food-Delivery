ALTER USER '<mysql_host_address>' IDENTIFIED WITH mysql_native_password BY '<mysql_password>';
flush privileges;

drop database if exists sfd_db;
create database sfd_db;
use sfd_db;

/*	Customer relation	*/
create table reg_customer
	(mobNo varchar(10) primary key,
    cName varchar(20),
    cAddress varchar(50),
    email varchar(50),
    rfid varchar(10));
    
    
/* Device relation	*/
create table reg_device
	(deviceID varchar(10) primary key,
    mqttID varchar(10) not null);
 

/* Orders relation	*/
create table orders
	(orderID varchar(10) primary key,
    cTelNo varchar(10) not null,
    deviceID varchar(10) not null,
    foreign key (deviceID) references reg_device(deviceID),
    address varchar(75) not null);

    
/* Rider relation	*/
create table reg_rider
	(mobNo varchar(10) primary key,
    rName varchar(20),
    deviceID varchar(10),
    rpassword varchar(100),
    foreign key (deviceID) references reg_device(deviceID));


/*	Order-Handle relation	*/
create table order_handle 
	(orderID varchar(10) not null,
    foreign key(orderID) references orders(orderID),
	deviceID varchar(10) not null,
    foreign key(deviceID) references reg_device(deviceID),
    mobNo varchar(10) not null,
    unique (orderID, mobNo),
    rfidCode varchar(10),
    state varchar(10) not null,
    address varchar(75) not null);
 

 /* 
	Trigger to auto insert order_handle table
	By checking whether the customer has registered and then take the corresponding RFID value
*/
delimiter $$
create trigger after_orders_insert after insert on orders for each row
begin
	insert into order_handle(orderID, deviceID, mobNo, rfidCode, state, address)
	values (new.orderID, new.deviceID, new.cTelNo, (select rfid from reg_customer where new.cTelNo = reg_customer.mobNo), 'on-going', new.address);
end$$
delimiter ;


/* Stored procedures to list currnet orders in carrier values	*/
delimiter $$
create procedure viewCurrentOrders (in deviceID varchar(10))
begin
	select orderID, mobNo, address from order_handle
    where order_handle.deviceID = deviceID and order_handle.state = 'on-going';
end$$
delimiter ;


/*	Stored procedures to update perticular order delivery state	*/
delimiter $$
create procedure delivery_cancelled(in orderID varchar(10))
begin
	update order_handle set order_handle.state = 'cancelled' where order_handle.orderID = orderID;
end$$
delimiter ;


delimiter $$
create procedure delivery_done(in orderID varchar(10))
begin
	update order_handle set order_handle.state = 'done' where order_handle.orderID = orderID;
end$$
delimiter ;


/* Stored procedure to view mqttID of a device */
delimiter $$
create procedure device_mqtt(in deviceID varchar(10))
begin
	select mqttID from reg_device where reg_device.deviceID = deviceID;
end$$
delimiter ;