/*
 1.insert문: 테이블에 새로운 데이터를 저장하기 위해서
 사용하는 데이터 조작 쿼리문이다.
   형식)
     insert into  테이블명
     (컬럼명,컬럼명,....)
     values(값,값,...);
    
     가.테이블명 다음에 기술한 컬럼 목록 순서대로 
     values 에 지정한 값들이 차례로 저장된다.
     나.테이블 명 다음에 컬럼명을 생략하면 테이블 
     생성시(create table) 지정한 컬럼명 순서대로 
     값들이 저장된다.
     다.테이블명 다음의 컬럼 목록 개수와 values 다음
     의 값의 개수가 일치해야 한다. 
*/
insert 실습)
  create table emp26(
    empno number(38) primary key /*사원번호*/
    ,ename varchar2(100) /*사원명*/
    ,LOC varchar2(100) /*사는 지역*/
  );  
  
  첫째 table명 다음에 컬럼명 명시하는 경우)
  insert into emp26
  (LOC,ENAME,EMPNO)
  values('서울','홍길동',12);
  
  select * from emp26;
  
  둘째 table명 다음에 컬럼명을 생략하는 경우)
  insert into emp26
  values(13,'이순신','부산');
  /*
   * 테이블명 다음에 컬럼명 목록을 생략하면 테이블 생성
   * 시 지정한 컬럼명 순서대로 값이 저장.
   * 컬럼명이 생략되는 경우는 반드시 테이블 생성시 컬럼
   * 개수와 values 다음의 값의 개수를 일치시켜야 한다.
   */
  
  
  /*
   * 1.insert ALL문: 서브 쿼리의 결과를 조건없이
   * 여러 테이블에 동시에 저장할 경우 사용한다.
   */
  Insert ALL문 실습)
   create table emp27(
    empno number(20) primary key /*사원 번호*/
    ,ename varchar(30) /*사원명*/
    ,sal number(38) /*급여*/
    ,LOC VARCHAR2(100) /*사는 지역 */
    ,deptno number(38) /*부서번호*/
   );
   insert into emp27
   values(101,'강감찬',1000,'서울시 마포구',10);
   insert into emp27
   values(102,'이순신',1500,'서울시 서대문구',20);
   insert into emp27
   values(103,'세종대왕',2000,'서울시 양천구',20);
   
   select * from emp27 order by empno asc;
   
   emp28 테이블 복제)
   create table emp28
   as
   select empno,ename,sal 
   from emp27 where 1=0;
   /*
    *  조건을 거짓으로 해서 사원번호,사원명,급여를 
    * 테이블 구조만 복제한 emp28테이블을 생성
    */
   select * from emp28;
  
  emp29 복제테이블 생성)
  create table emp29
  as
  select empno,ename,LOC
  from emp27 where 1=0;
  /*
   * where 조건식을 거짓으로 해서 사원번호,사원명,
   * 사는 지역 필드만 복제한 emp29 테이블 생성
   */
  select * from emp29;
  
  하나이상 테이블에 다중행 레코드 저장실습)
  insert all
  into emp28 values(empno,ename,sal)
  into emp29 values(empno,ename,LOC)
  select empno,ename,sal,LOC 
  from emp27
  where deptno=20;
  /*
   * emp27테이블의 부서번호 20번 해당하는 사원번호,
   * 사원명,급여,사는 지역을 검색해서 emp28테이블에
   * 는 사원번호,사원명,급여를 저장하고,emp29테이블에
   * 사원번호,사원명,사는 지역을 동시 저장한다.
   */
  select * from emp28 order by empno asc;
  select * from emp29 order by empno asc;
  
  /*
   * insert all when 조건식 then문:
   * 복수개의 테이블에 다중행 레코드를 저장할 때
   * when 조건식에 지정한 조건에 맞는 자료만 저장
   * 시킴.
   */
  emp30 복제테이블 생성)
  create table emp30
  as
  select empno,ename,deptno from emp27
  where 1=0;
  /*
   * 조건식을 거짓으로 주고 emp27테이블의 사원번호,
   * 사원명,부서번호 필드 구조만 복제한 
   * emp30 테이블 생성
   */
  select * from emp30;
  
  emp31 복제테이블 생성)
  create table emp31
  as
  select empno,ename,sal from emp27
  where 1=0;
  /*
   * where 조건식을 거짓으로 해서 emp27 테이블의
   * 사원번호,사원명,급여 필드 구조만 복제한 
   * emp31 테이블 생성
   */
  select * from emp31;
  select empno,ename,sal,deptno from emp27;


  조건에 맞는 레코드만 복수개의 테이블에 다중행
  저장 실습)
  insert all
  when sal>=1000 then
  /*급여가 1000이상인 경우 다중행 저장*/
  into emp31 values(empno,ename,sal)
  when deptno=20 then
  /*부서번호가 20번 인경우만 다중행 저장*/
  into emp30 values(empno,ename,deptno)
  select empno,ename,sal,deptno from emp27;
  
  select * from emp31 order by empno asc;
  select * from emp30 order by empno asc;
  
  
  
  
  



