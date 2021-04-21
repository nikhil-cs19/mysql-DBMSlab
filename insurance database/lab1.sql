
show databases;
use insurance;

create table person(driver_id varchar(15),name varchar(20),address varchar(30),primary key(driver_id));
create table car(regno varchar(10),Model varchar(20),Year date,Primary key(Regno));
create table Accident(report_no int,ADATE DATE,Location varchar(15),Primary
key(report_no));

create table owns(driver_id varchar(10),regno varchar(10),primary key(driver_id,regno),
foreign key(driver_id) references person(driver_id) on delete cascade,
foreign key(regno) references car(regno) on delete cascade);
CREATE TABLE PARTICIPATED(driver_id varchar(10),regno varchar(10),report_no int,
damage_amt float, foreign key (driver_id,regno) references OWNS(driver_id,regno)
ON DELETE CASCADE,
foreign key (REPORT_NO) references ACCIDENT(REPORT_NO) ON DELETE CASCADE);

insert into person values(1111,"ramu","k s layout");
insert into person values(2222,"john","indiranagar");
insert into person values(3333,"priya","jayanagar");
insert into person values(4444,"gopal","whitefield");
insert into person values(5555,"latha","vijaynagar");

insert into car values("KA04Q2301","MARUTHI-DX",'2000-10-10');
insert into car values("KA05P1000","FORDICON",'2000-10-10');
insert into car values("KA03L1234","ZEN-VXI",'2000-10-10');
insert into car values("KA03L9999","MARUTHI-DX",'2000-10-10');
insert into car values("KA01P4020","INDICA-VX",'2000-10-10');
desc accident;
insert into accident values(12,'2002-06-01','m g road');
insert into accident values(200,'2002-12-10','doubleroad');
insert into accident values(300,'1999-07-23','m g road');
insert into accident values(25000,'2000-06-11','residency road');
insert into accident values(26500,'2001-10-01','richmond road');

select * from accident;

insert into owns values(1111,"KA04Q2301");
insert into owns values(1111,"KA05P1000");
insert into owns values(2222,"KA03L1234");
insert into owns values(3333,"KA03L9999");
insert into owns values(4444,"KA01P4020");
 
 select * from owns;

insert into participated values(1111,"KA04Q2301",12,20000);
insert into participated values(2222,"KA03L1234",200,500);
insert into participated values(3333,"KA03L9999",300,10000);
insert into participated values(4444,"KA01P4020",25000,2375);
insert into participated values(1111,"KA05P1000",26500,70000);

select * from participated;
/*
a. Update the damage amount for the car with a specific Regno in the accident with report number 12 to
25000.
*/
update participated set damage_amt = 25000 where report_no = 12 and regno = 'KA04Q2301';
select * from participated;

/*
b. Add a new accident to the database
*/
insert into accident values (1001,'2008-10-10','ring road');
select * from accident;

/*
iv. Find the total number of people who owned cars that involved in accidents in 2008
*/
select count(*) from accident where year(ADATE)=2008;

/*
 Find the number of accidents in which cars belonging to a specific model were involved
*/
SELECT COUNT(A.REPORT_NO) FROM ACCIDENT A, PARTICIPATED P, CAR C
 WHERE A.REPORT_NO=P.REPORT_NO AND
 P.REGNO=C.REGNO AND C.MODEL='MARUTHI-DX';


