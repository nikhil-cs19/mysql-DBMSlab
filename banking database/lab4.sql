create database banking;
USE BANKING;
SHOW TABLES;
create table branch(
	branchname varchar(30),
	branchcity varchar(30),
	assets real,
	primary key(branchname)
);
DESC BRANCH;
INSERT INTO BRANCH VALUES
	('SBI PD NAGAR','BANGALORE',200000),
	('SBI RAJAJI NAGAR','BANGALORE',500000),
	('SBI JAYANAGAR','BANGALORE',660000),
	('SBI VIJAY NAGAR','BANGALORE',870000),
	('SBI HOSAKEREHALLI','BANGALORE',550000);
    
    INSERT INTO BRANCH VALUES
	('SBI MA ROAD','MUMBAI',20000);
SELECT * FROM BRANCH;

CREATE TABLE ACCOUNTS(
ACCNO INT,
BRANCHNAME VARCHAR(30),
BALANCE REAL,
primary key(ACCNO),
foreign key(BRANCHNAME) references BRANCH(BRANCHNAME) ON DELETE CASCADE
);
DESC ACCOUNTS;
INSERT INTO ACCOUNTS VALUES
	(1234602,'SBI HOSAKEREHALLI',5000),
	(1234603,'SBI VIJAY NAGAR',5000),
	(1234604,'SBI JAYANAGAR',5000),
	(1234605,'SBI RAJAJI NAGAR',5000),
	(1234503,'SBI VIJAY NAGAR',5000),
	(1234504,'SBI PD NAGAR',5000);
    
    INSERT INTO ACCOUNTS VALUES
	(1234606,'SBI JAYANAGAR',5000),
	(1234607,'SBI JAYANAGAR',5000),
	(1234608,'SBI JAYANAGAR',5000),
	(1234609,'SBI JAYANAGAR',5000);
    
     INSERT INTO ACCOUNTS VALUES
	(1234610,'SBI PD NAGAR',5000),
    (1234611,'SBI RAJAJI NAGAR',5000),
    (1234612,'SBI VIJAY NAGAR',5000);
SELECT * FROM ACCOUNTS;

CREATE TABLE CUSTOMER(
	CUSTOMERNAME VARCHAR(30),
	STREET VARCHAR(30),
	CITY VARCHAR(30),
	primary key(CUSTOMERNAME)
);
DESC CUSTOMER;
INSERT INTO CUSTOMER VALUES
('KEZAR','M G ROAD','BANGALORE'),
('LAL KRISHNA','ST MKS ROAD','BANGALORE'),
('RAHUL','AUGSTEN ROAD','BANGALORE'),
('LALLU','V S ROAD','BANGALORE'),
('FAIZAL','RESEDENCY ROAD','BANGALORE'),
('RAJEEV','DICKNSN ROAD','BANGALORE');
SELECT * FROM CUSTOMER;


CREATE TABLE DEPOSITER(
CUSTOMERNAME VARCHAR(30),
ACCNO INT,
foreign key(CUSTOMERNAME) REFERENCES CUSTOMER(CUSTOMERNAME) ON DELETE CASCADE,
foreign key(ACCNO) references ACCOUNTS(ACCNO) ON DELETE CASCADE
);
DESC DEPOSITER;

insert into depositer values
('KEZAR',1234602),
('KEZAR',1234606),
('KEZAR',1234607),
('LAL KRISHNA',1234603),
('RAHUL',1234604),
('RAHUL',1234608),
('LALLU',1234605),
('LALLU',1234609),
('FAIZAL',1234503),
('RAJEEV',1234504);

insert into depositer values
('KEZAR',1234610),
('KEZAR',1234611),
('KEZAR',1234612);
select * FROM DEPOSITER;


CREATE TABLE LOAN(
LOANNUMBER INT,
BRANCHNAME VARCHAR(30),
AMOUNT REAL,
PRIMARY KEY(LOANNUMBER),
foreign key(BRANCHNAME) references BRANCH(BRANCHNAME) ON DELETE CASCADE
);
DESC LOAN;
INSERT INTO LOAN VALUES
(10011,'SBI JAYANAGAR',10000),
(10012,'SBI VIJAY NAGAR',5000),
(10013,'SBI HOSAKEREHALLI',20000),
(10014,'SBI PD NAGAR',15000),
(10015,'SBI RAJAJI NAGAR',25000);
SELECT * FROM LOAN;

CREATE TABLE BORROWER(
CUSTOMERNAME VARCHAR(30),
LOANNUMBER INT,
foreign key(CUSTOMERNAME) references CUSTOMER(CUSTOMERNAME) ON DELETE CASCADE,
foreign key(LOANNUMBER) references LOAN(LOANNUMBER) ON DELETE CASCADE
);
DESC BORROWER;
INSERT INTO BORROWER VALUES
('KEZAR',10011),
('LAL KRISHNA',10012),
('RAHUL',10013),
('LALLU',10014),
('LAL KRISHNA',10015);
SELECT * FROM BORROWER;

-- Find all the customers who have at least two accounts at
-- the Main branch.
select d.customername from depositer d,accounts a where  d.accno = a.accno and a.branchname = 'SBI JAYANAGAR' 
 group by d.customername having count(d.customername)>1; 
 
 -- Find all the customers who have an account at all the
-- branches located in a specific city.
-- select d.customername from depositer d,accounts a, branch b where d.accno = a.accno  and b.branchname = a.branchname
-- group by d.customername having count(distinct(b.branchname) = 
-- (select count(branchname) from branch where b.city = 'BANGALORE') ;


select customername from depositer
join accounts on accounts.accno = depositer.accno join branch on branch.branchname = accounts.branchname
where branch.branchcity = "BANGALORE" GROUP BY depositer.customername
having count(DISTINCT branch.branchname) = (SELECT COUNT(branchname) FROM branch
WHERE branchcity = 'BANGALORE');


-- Demonstrate how you delete all account tuples at every
-- branch located in a specific city.
delete from accounts where branchname in (select branchname from branch where branchcity = 'MUMBAI');