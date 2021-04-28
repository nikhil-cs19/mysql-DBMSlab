create database book_dealer;
use book_dealer;

/*
AUTHOR(author-id: int, name: String, city: String, country: String)
*/
create table author(
		author_id int,
        name varchar(40),
        city varchar(40),
        country varchar(40),
        primary key(author_id)
        );
desc author;
/*
PUBLISHER(publisher-id: int, name: String, city: String, country: String)
*/
 create table PUBLISHER(
		publisher_id int,
        name varchar(40),
        city varchar(40),
        country varchar(40),
        primary key(publisher_id)
        );

/*
CATEGORY(category-id: int, description: String)
*/
 create table CATEGORY(
		category_id int,
        description varchar(100),
        primary key(category_id)
        );
        
/*
CATALOG(book-id: int, title: String, author-id: int, publisher-id: int, category-id: int, year: int, price: int)
*/
create table CATALOG(
		book_id int,
        title varchar(100),
        author_id int,
        publisher_id int,
        category_id int,
        year int,
        price int,
        primary key(book_id),
        foreign key(author_id) references author(author_id),
        foreign key(publisher_id) references publisher(publisher_id),
        foreign key(category_id) references category(category_id)
        );
desc catalog;

/*
ORDER-DETAILS(order-no: int, book-id: int, quantity: int)
*/

create table order_details(
		order_no int,
        book_id int,
        quantity int,
        primary key(order_no),
        foreign key(book_id) references catalog(book_id)
        );
        
show tables;

/*

ii) Enter at least five tuples for each relation.

*/

insert into author values
		(1001,'TERAS CHAN','CA','USA'),
        (1002,'STEVENS','ZOMBI','CANADA'),
        (1003,'M MANO','CAIR','CANADA'),
        (1004,'KARTHIK B P','NEW YORK',' USA'),
        (1005,'WILLIAM STAILINGS','LAS VEGAS',' USA')
        ;

SELECT * FROM AUTHOR;

INSERT INTO PUBLISHER VALUES
		(1,'PEARSON','NEW YORK','USA'),
        (2,'EEE','NEW SOUTH WALES','USA'),
        (3,'PHI','DELHI','INDIA'),
        (4,'WILLEY','BERLIN','GERMANY'),
        (5,'MGH','NEW YORK','USA');
        
SELECT * FROM PUBLISHER;

INSERT INTO CATEGORY VALUES
		(1001,'COMPUTER SCIENCE'),
        (1002,'ALGORITHM DESIGN'),
        (1003,'ELECTRONICS'),
        (1004,'PROGRAMMING'),
        (1005,'OPERATING SYSTEMS');
        
SELECT * FROM CATEGORY;

INSERT INTO CATALOG VALUES
		(11,'Unix System Prg',1001,1,1001,2000,251),
        (12,'Digital Signals',1002,2,1003,2001,425),
        (13,'Logic Design',1003,3,1002,1999,225),
        (14,'Server Prg',1004,4,1002,2001,333),
        (15,'Linux OS',1005,5,1005,2003,326),
        (16,'C++ Bible',1005,5,1001,2000,526),
        (17,'COBOL Handbook',1005,4,1001,2000,658);
        
select * from catalog;

INSERT INTO ORDER_DETAILS VALUES
		(1,11,5),
        (2,12,8),
        (3,13,15),
        (4,14,22),
        (5,15,3),
        (6,17,10);
        
SELECT * FROM ORDER_DETAILS;

/*
iii) Give the details of the authors who have 2 or more books in the catalog and the year of publication is after 2000.
*/
select * from author where author_id in(select author_id from catalog where year>2000 group by author_id having count(author_id)>=2);

#Find the author of the book which has maximum sales.
SELECT A.NAME FROM AUTHOR A,CATALOG C,ORDER_DETAILS O WHERE A.AUTHOR_ID=C.AUTHOR_ID AND C.BOOK_ID=O.BOOK_ID AND O.QUANTITY=(SELECT MAX(QUANTITY) FROM ORDER_DETAILS);

#Demonstrate how you increase the price of books published by a specific publisher by 10%.
select * from catalog;
update catalog set price = price*1.10 where publisher_id = 1;
select * from catalog;
        




