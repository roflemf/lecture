/*
테이블 합병*/
--원본 테이블 emp만들기
create table emp(
 empno number(38) primary key
 ,ename varchar2(100)
 ,job varchar2(50)
 ,sal int
 ,deptno int
);
insert into emp values(101,'홍길동','개발부',5000,10);
insert into emp values(102,'이순신','개발부',5000,10);
insert into emp values(103,'강감찬','디자인부',3000,20);

select * from emp;

create table emp01
as 
select * from emp;


create table emp02
as
select * from emp where job='개발부';

select * from emp01;
select * from emp02;

update emp02 set job='test';
insert into emp02 values(104,'을지문덕','top',2000,30);

--테이블 병합
merge into emp01
using emp02
on(emp01.empno=emp02.empno)
when matched then
 update set
  emp01.ename=emp02.ename,
  emp01.job=emp02.job,
  emp01.sal=emp02.sal,
  emp01.deptno=emp02.deptno
  
when not matched then
  insert values(emp02.empno,emp02.ename,emp02.job,emp02.sal,emp02.deptno);
  










