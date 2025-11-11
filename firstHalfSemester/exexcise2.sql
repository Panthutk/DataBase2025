use Admission_6610545421;
drop table if exists College;
drop table if exists Student;
drop table if exists Apply;



create table college (

cname varchar(255),
state varchar(255),
enrollment int,
primary key(cname));

create table student(
sid int,
sname varchar(255),
GPA real,
sizeHS int,
primary key(sid));

create table apply (
sid int,
cname varchar(255),
major varchar(255),
decision varchar(255),
primary key(sid,cname,major));


insert into Student values (123, 'Amy', 3.9, 1000);
insert into Student values (234, 'Bob', 3.6, 1500);
insert into Student values (345, 'Craig', 3.5, 500);
insert into Student values (456, 'Doris', 3.9, 1000);
insert into Student values (567, 'Edward', 2.9, 2000);
insert into Student values (678, 'Fay', 3.8, 200);
insert into Student values (789, 'Gary', 3.4, 800);
insert into Student values (987, 'Helen', 3.7, 800);
insert into Student values (876, 'Irene', 3.9, 400);
insert into Student values (765, 'Jay', 2.9, 1500);
insert into Student values (654, 'Amy', 3.9, 1000);
insert into Student values (543, 'Craig', 3.4, 2000);

insert into College values ('Stanford', 'CA', 15000);
insert into College values ('Berkeley', 'CA', 36000);
insert into College values ('MIT', 'MA', 10000);
insert into College values ('Cornell', 'NY', 21000);

insert into Apply values (123, 'Stanford', 'CS', 'Y');
insert into Apply values (123, 'Stanford', 'EE', 'N');
insert into Apply values (123, 'Berkeley', 'CS', 'Y');
insert into Apply values (123, 'Cornell', 'EE', 'Y');
insert into Apply values (234, 'Berkeley', 'biology', 'N');
insert into Apply values (345, 'MIT', 'bioengineering', 'Y');
insert into Apply values (345, 'Cornell', 'bioengineering', 'N');
insert into Apply values (345, 'Cornell', 'CS', 'Y');
insert into Apply values (345, 'Cornell', 'EE', 'N');
insert into Apply values (678, 'Stanford', 'history', 'Y');
insert into Apply values (987, 'Stanford', 'CS', 'Y');
insert into Apply values (987, 'Berkeley', 'CS', 'Y');
insert into Apply values (876, 'Stanford', 'CS', 'N');
insert into Apply values (876, 'MIT', 'biology', 'Y');
insert into Apply values (876, 'MIT', 'marine biology', 'N');
insert into Apply values (765, 'Stanford', 'history', 'Y');
insert into Apply values (765, 'Cornell', 'history', 'N');
insert into Apply values (765, 'Cornell', 'psychology', 'Y');
insert into Apply values (543, 'MIT', 'CS', 'N');

-- Execise 1
-- select sname , GPA , decision , major
-- from Student ,Apply
-- where Student.sid = Apply.sid and Student.sizeHS < 1000 and Apply.major = "CS" and Apply.cname = "Stanford";

-- EXecise 2
-- select  distinct c.cname 
-- from College c , Apply a
-- where c.cname = a.cname and enrollment > 20000 and a.major = "CS";


-- Execise 3
select min(s.GPA) as Smallest_GPA
from Apply a , Student s 
where a.major = "CS" and s.sid =a.sid;

-- Execise 4
select  distinct s.sname , s.GPA 
from College c , Apply a , Student s
where s.sid = a.sid and c.cname = a.cname and a.major ="CS" and c.enrollment > 20000 and a.decision = "N";


-- Execise 5
select distinct s.sid
from student s ,apply a
where major in ("CS","EE") and s.sid = a.sid


-- Answer from ajan
select distinct a1.sid
from apply a1, apply a2
where a1.sid = a2.sid 
  and a1.major = 'CS' 
  and a2.major = 'EE';
  
  

-- Execise 6
select cname , major , min(GPA) , max(GPA)
from student , apply
where student.sid = apply.sid
group by cname , major

-- Execise 7
select max(mx-mn)
from (select cname, major, min(gpa) as mn, max(gpa) as mx
from student s, apply a
where s.sid = a.sid
group by cname, major) M;



