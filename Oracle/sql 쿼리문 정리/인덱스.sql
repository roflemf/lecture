/*
 오라클 인덱스 특징
  1.오라클에서 인덱스를 사용하는 이유는 보다 더 빠른 검
  색을 위해서 사용한다.
  2.기본키 또는 유일키 제약조건으로 지정된 곳은 오라클
  에서 해당 컬럼에 자동으로 인덱스를 생성해 준다.
*/

 create table emp201(
  empno number(38) primary key
  ,ename varchar2(100) 
  ,sal number(38)
 );
 
 insert into emp201 values(11,'홍길동',100);
 insert into emp201 values(12,'이순신',200);
 insert into emp201 values(13,'강감찬',300);
 
 select * from emp201;
 
 select table_name,index_name,column_name
 from user_ind_COLUMNS
 where table_name in('EMP201','EMP202');
 /*
  * 1.table_name 컬럼에는 테이블명이 저장
  * 2.index_name 컬럼에는 인덱스 명이 저장
  * 3.column_name 컬럼에는 해당 컬럼명이 저장
  */
 서브 쿼리로 복사본 테이블 emp202)
 create table emp202
 as
 select * from emp201;
 /* 서브 쿼리로 복제한 EMP202 테이블에는 인덱스가 
  * 존재하지 않는다.
  */
 select * from emp202;
 
 insert into emp202
 select * from emp202;
 /*
  * 1.서브쿼리로 복제본 테이블을 만들면 제약조건은
  * 복제 되지 않는다.
  */
 
 

  검색 용으로 레코드 하나 저장)
  insert into emp202 
  values(14,'검색이름',1000);
 
  /*
   * 1.set timing on : 인덱스에서 검색 속도를 체크할
   * 수 있다.
   * 2.인덱스 생성 문법
   *  형식)
   *   create index 인덱스명
   *   on 테이블명(컬럼명);
   * 
   *  3.인덱스 삭제 문법
   *  형식)
   *   drop index 인덱스명;
   */
  emp202 테이블의 ename컬럼에 인덱스 설정 실습)
  create index idx_emp202_ename
  on emp202(ename);
  
  select table_name,COLUMN_name,index_name
  from user_ind_COLUMNS
  where table_name in('EMP202','EMP201');
  
  create index id_emp202_empno
  on emp202(empno);
  
  drop index id_emp202_empno;
  /* id_emp202_empno 인덱스를 삭제 */
  
  /*
   * 고유 인덱스 특징
   *  1.고유 인덱스는 기본키 또는 유일키 처럼 유일한
   * 값을 갖는 컬럼에 대해서 생성하는 인덱스를 뜻한다.
   *  2.중복자료가 있는 컬럼에는 고유 인덱스를 설정
   * 못함.
   *  3.고유 인덱스 생성 문법
   *   형식)
   *    create unique index 인덱스명
   *    on 테이블명(컬럼명);
   * 
   *  비고유 인덱스 특징
   *  1.중복된 자료가 저장된 컬럼에 대해서 생성하는
   * 인덱스를 비고유 인덱스라 한다.
   *  2.중복자료가 있는 컬럼에는 비고유 인덱스만 설정
   * 가능하다. 
   */
   create table emp203
   as
   select * from emp202 where 1=0;
   /*조건식이 맞지 않기 때문에 레코드는 복제 안되고,
    * 테이블 구조만 복제.
    */
  insert into emp203 values(10,'신사임당',1000);
  insert into emp203 values(20,'세종대왕님',2000);
  insert into emp203 values(30,'신사임당',3000);
  
  select * from emp203;
  
  중복 레코드가 없는 empno 컬럼에 고유 인덱스를 생성)
  create unique index idx_emp203_empno
  on emp203(empno);
  
  중복 레코드가 있는 ename 컬럼에 고유 인덱스를 생성
  해서 에러)
  create unique index idx_emp203_ename
  on emp203(ename);
  
  중복 레코드가 있는 ename 컬럼에 비고유 인덱스를 생성)
  create index idx_emp203_ename
  on emp203(ename);
  
  
  
  
  
 
 
  
  
  