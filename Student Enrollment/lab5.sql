create database Student_enrollment;
use Student_enrollment;

CREATE TABLE STUDENT(
regno varchar(10) primary key,
name varchar(25),
major varchar(4),
bdate date
);
desc student;
insert into student values
('CS01','RAM','DS','1986-3-12'),
('IS02','SMITH','USP','1987-12-23'),
('EC03','AHMED','SNS','1985-4-17'),
('CS03','SNEHA','DBMS','1987-1-1'),
('TC05','AKHILA','EC','1986-10-6');

CREATE TABLE COURSE(
course_no int primary key,
cname varchar(4),
dept varchar(4)
);
desc course;
insert into course values
(11,'DS','CS'),
(22,'USP','IS'),
(33,'SNS','EC'),
(44,'DBMS','CS'),
(55,'EC','TC');
SELECT * FROM COURSE;


CREATE TABLE ENROLL(
regno varchar(10),
course_no int,
marks int,
Sem int,
foreign key(regno) references student(regno) on delete cascade,
foreign key(course_no) references course(course_no) on delete cascade
);
desc enroll;
insert into enroll values
('CS01',11,4,85),
('IS02',22,6,80),
('EC03',33,2,80),
('CS03',44,6,75),
('TC05',55,2,8);
select * from enroll;

CREATE TABLE text(
bookisbn int primary key,
booktitle varchar(45),
publisher varchar(25),
Author varchar(30)
);
desc text;
insert into text values
(1,'DS and C','Princeton','Padma Reddy'),
(2,'Fundamentals of DS','Princeton','Godse'),
(3,'Fundamentals of DBMS','Princeton','Navathe'),
(4,'SQL','Princeton','Foley'),
(5,'Electronic circuits','TMH','Elmasri'),
(6,'Adv unix prog','TMH','Stevens');
select * from text;

create table book_adoption(
course_no int,
sem int,
bookisbn int,
foreign key(course_no) references course(course_no) on delete cascade,
foreign key(bookisbn) references text(bookisbn) on delete cascade
);
desc book_adoption;

insert into book_adoption values
(11,4,1),
(11,4,2),
(44,6,3),
(44,6,4),
(55,2,5),
(22,6,6);
select * from book_adoption;


/*Demonstrate how you add a new text book to the database and make this book be
adopted by some department.*/
insert into text values (7,'Introduction to Algorithm','Princeton','Thomas');
insert into book_adoption values(55,2,7);
select * from text;

/*Produce a list of text books (include Course #, Book-ISBN, Book-title) in the
alphabetical order for courses offered by the ‘CS’ department that use more than two
books.*/
SELECT C.COURSE_NO,T.BOOKISBN,T.BOOKTITLE FROM TEXT T,COURSE C,BOOK_ADOPTION B 
WHERE T.BOOKISBN=B.BOOKISBN AND B.COURSE_NO=C.COURSE_NO AND C.DEPT="CS" AND
 (SELECT COUNT(B.BOOKISBN) FROM BOOK_ADOPTION B WHERE C.COURSE_NO=B.COURSE_NO)>=2 ORDER BY T.BOOKTITLE;        
/*List any department that has all its adopted books published by a specific publisher.*/
SELECT DISTINCT C.DEPT FROM COURSE C WHERE C.DEPT IN
     ( SELECT C.DEPT FROM COURSE C,BOOK_ADOPTION B,TEXT T WHERE C.COURSE_NO=B.COURSE_NO
     AND T.BOOKISBN=B.BOOKISBN AND T.PUBLISHER='Princeton') AND C.DEPT NOT IN
     (SELECT C.DEPT FROM COURSE C,BOOK_ADOPTION B,TEXT T WHERE C.COURSE_NO=B.COURSE_NO
     AND T.BOOKISBN=B.BOOKISBN AND T.PUBLISHER != 'Princeton');