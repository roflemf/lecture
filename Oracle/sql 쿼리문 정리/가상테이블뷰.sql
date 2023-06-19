/*
 가상테이블(뷰:VIEW) 이란?
  1.가상테이블 뷰는 실제 테이블에 근거한 논리적인 가상
  테이블이라 정의할 수 있다.
  2.가상테이블 뷰에는 실제 자료가 저장되지 않는다.마치
  테이블 처럼 동일하게 뷰를 통해 실제 테이블의 레코드를
  볼 수 있다.
  3.가상테이블 뷰를 통해 사용자에게 실제 테이블 사용을
  제한할 수 있다.
*/
실제 테이블중 복제본 부서테이블 생성)
 create table dept81_copy
 as
 select * from dept81;
 
 select * from dept81_copy;
 
 create table emp_copy(
  empno number(38) primary key
  ,ename varchar2(50)
  ,job varchar2(100)
  ,sal number(38)
  ,comm number(38) /*보너스*/
  ,deptno number(38) 
  );
  
  insert into emp_copy values(201,'홍길동','관리사원',
  100,10,101);
  insert into emp_copy values(202,'이순신','개발사원',
  200,20,102);
  
  select * from emp_copy;
  
  /*뷰 생성 문법 형식
   * create view 뷰이름
   * as
   * 서브 쿼리문;
   */
  emp_view30 가상테이블 뷰를 생성)
  create view emp_view30
  as
  select empno,ename,deptno
  from emp_copy
  where deptno=101;
  /*
   * 1.ORA-01031 에러 번호는
   * 해당 사용자로 뷰생성 권한이없다는 뜻.
   * 2.ORA-01031 에러 해결법
   *  가.DBA(데이터베이스 관리자) 계정인 system
   * 으로 sqlplus cmd로 접속한다음
   *  나.SQL>grant create view to night;
   * SQL프롬프트에서 grant권한설정 쿼리문으로 night
   * 사용자 계정에 뷰테이블 생성권한을 설정해야 한다.
   */
  

  뷰를 통해 실제 테이블 레코드 검색)
  select * from emp_view30;
  
  select view_name,text
  from user_views;
  /*
   *  1.view_name 컬럼에는 생성된 가상테이블 뷰이름을
   * 확인할 수 있다.
   *  2.text 컬럼에서는 create view에 의한 뷰생성시
   * as문 다음의 서브 쿼리문이 저장된다. 그러므로
   * 뷰에는 실제 자료가 저장되지 않고,뷰 생성시 작성
   * 한 서브쿼리문이 저장된다는 것을 알 수 있다.
   */

    
  뷰를 통한 레코드 저장)
  insert into emp_view30
  values(203,'신사임당님',102);
 /*
  * 1.뷰테이블을 통해서 insert 저장시 뷰에는 실제 
  * 레코드가 저장되지 않고,실제 테이블 emp_copy
  * 에 레코드가 추가
  * 2.가상 테이블 뷰를 통해서 DML(데이터 조작어:INSERT,
  * update,delete)에 의한 실제 테이블 자료를 추가,
  * 변경,삭제할 수 있다.
  */
  select * from emp_copy;
  
  /*
   * 가상테이블 뷰를 사용하는 이유
   *   1.뷰를 사용하는 이유는 복잡하고 긴 쿼리문을
   * 뷰로 정의하면 접근을 단순화 할 수 있기 때문이다.
   *   2.뷰를 사용하면 특정사용자에게 특정 객체 부분만
   * 접근하게 제한을 할 수 있기 때문에 보안면에서 유리
   * 하다.
   */
  뷰를 통한 특정부서 영업부만 보너스 컬럼 comm
  레코드를 검색하게 제한 실습)
  insert into dept81_copy
  values(103,'영업부','부산');
  
  select * from dept81_copy;
  select * from emp_copy;
  
  insert into emp_copy values(204,'강감찬',
  '영업사원',300,30,103);
  
  영업부를 통한 사원번호,사원명,직종,보너스,부서번호
  를 검색하는 empview_sales 뷰를 생성(영업부만 보너
  스를 검색)
  create view empview_sales
  as
  select empno,ename,job,comm,deptno
  from emp_copy;
  
  select * from empview_sales;
  
  /*
   *  사용자에 의해서 뷰테이블 컬럼을 직접 정의 
   */
  create view emp_view(사원번호,사원명,급여,부서번호)
  as
  select empno,ename,sal,deptno
  from emp_copy;
  
  select * from emp_view;
  

  

  
  
  
  
  
  
  
  
  
  
  
  
  
 
 