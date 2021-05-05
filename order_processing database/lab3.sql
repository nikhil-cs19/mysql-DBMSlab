create database order_processing;
use order_processing;
create table customer(
		cust_no int,
        cname varchar(20),
        city varchar(20),
        primary key(cust_no));
desc customer;

create table order_table(
		order_no int,
        odate date,
        cust_no int,
        order_amt int,
        primary key(order_no),
        foreign key(cust_no) references customer(cust_no) on delete cascade
        );
        
desc order_table;

create table item(
		item_no int,
        unit_price int,
        primary key(item_no)
        );
        
desc item;

create table order_item(
		order_no int,
        item_no int,
        qty int,
        foreign key(order_no) references order_table(order_no) on delete cascade,
        foreign key(item_no) references item(item_no) on delete cascade
        );

desc order_item;

create table warehouse(
		warehouse_no int,
        city varchar(20),
        primary key(warehouse_no)
        );
desc warehouse;

create table shipment(
		order_no int,
        warehouse_no int,
        ship_date date,
        foreign key(order_no) references order_table(order_no) on delete cascade,
        foreign key(warehouse_no) references warehouse(warehouse_no) on delete cascade
        );
        
desc shipment;

INSERT INTO CUSTOMER VALUES
		(771,'PUSHPA K','BANGALORE'),
		(772,'SUMAN','MUMBAI'),
		(773,'SOURAV','CALICUT'),
		(774,'LAILA','HYDERABAD'),
		(775,'FAIZAL','BANGALORE');
        
SELECT * FROM CUSTOMER;

INSERT INTO ORDER_TABLE VALUES
		(111,'2002-1-22',771,18000),
		(112,'2002-7-30',774,6000),
		(113,'2003-4-3',775,9000),
		(114,'2003-11-3',775,29000),
		(115,'2003-12-10',773,29000),
		(116,'2004-8-19',772,56000),
		(117,'2004-9-10',771,20000),
		(118,'2004-11-20',775,29000),
		(119,'2005-2-13',774,29000),
		(120,'2005-10-13',775,29000);
SELECT * FROM ORDER_TABLE;

INSERT INTO ITEM VALUES
		(5001,503),
		(5002,750),
		(5003,150),
		(5004,600),
		(5005,890);
SELECT * FROM ITEM;

INSERT INTO ORDER_ITEM VALUES
		(111,5001,50),
		(112,5003,20),
		(113,5002,50),
		(114,5005,60),
		(115,5004,90),
		(116,5001,10),
		(117,5003,80),
		(118,5005,50),
		(119,5002,10),
		(120,5004,45);
SELECT * FROM ORDER_ITEM;

INSERT INTO WAREHOUSE VALUES
		(1,'DELHI'),
		(2,'BOMBAY'),
		(3,'CHENNAI'),
		(4,'BANGALORE'),
		(5,'BANGALORE'),
		(6,'DELHI'),
		(7,'BOMBAY'),
		(8,'CHENNAI'),
		(9,'DELHI'),
		(10,'BANGALORE');
SELECT * FROM WAREHOUSE;

INSERT INTO SHIPMENT VALUES
		(111,1,'2002-2-10'),
		(112,5,'2002-9-10'),
		(113,8,'2003-2-10'),
		(114,3,'2003-12-10'),
		(115,9,'2004-1-19'),
		(116,1,'2004-9-20'),
		(117,5,'2004-9-10'),
		(118,7,'2004-11-30'),
		(119,7,'2005-4-30'),
		(120,6,'2005-12-21');
SELECT * FROM SHIPMENT;
/*Produce a listing: CUSTNAME, #oforders, AVG_ORDER_AMT, where the middle column
is the total
numbers of orders by the customer and the last column is the average order amount for that
customer.
*/

SELECT C.CUST_NO,C.CNAME,count(O.CUST_NO) AS NO_OF_ORDERS,AVG(O.ORDER_AMT) AS AVERAGE FROM CUSTOMER C,ORDER_TABLE O
			WHERE C.CUST_NO = O.CUST_NO group by O.CUST_NO;
            
            
/*List the order# for orders that were shipped from all warehouses that the company has in a
specific city.*/

SELECT S.ORDER_NO,W.CITY FROM SHIPMENT S,WAREHOUSE W 
		WHERE W.WAREHOUSE_NO = S.WAREHOUSE_NO	
		group by W.CITY;
        
        
/* iv) List the order# for orders that were shipped from all warehouses that the company has in a
 specific city.*/
SELECT S.ORDER_NO FROM SHIPMENT S,WAREHOUSE W WHERE S.WAREHOUSE_NO=W.WAREHOUSE_NO AND W.CITY="BANGALORE";

/* v) Demonstrate how you delete item# 10 from the ITEM table and make that field null in the
 ORDER_ITEM table.*/
DELETE FROM ITEM WHERE ITEM_NO=5005;
SELECT * FROM ORDER_ITEM;


