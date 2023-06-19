/*
 1.update 문은 테이블에 저장된 자료를 수정하기 위해
 사용하는 쿼리문이다.
 
 2.update 문 문법구조
   형식)  update 테이블명
          set 필드명=변경값,필드명=변경값, 중략
          where 조건식;
      조건식 맞는 레코드 만 수정
      
  3.update문에서 where 조건식을 주지 않으면 모든 행
  레코드가 수정된다.            
*/
  조건을 주지 않은 모든 행 레코드 수정)
   create table emp35
   as
   select * from emp27;
   /* emp27테이블의 모든 필드 구조와 레코드를 복제 */
  select * from emp35;
  
  update emp35
  set deptno=30;
  /* 모든 사원의 부서번호가 30으로 수정 */
  
  update emp35
  set deptno=20
  where empno=101;
  /* 101번 사원의 부서번호를 20으로 변경 */
  
  /*
    서브 쿼리를 사용한 데이터 수정하기
     1.update 수정문의 set절에 서브 쿼리문을 기술하여
     수행한 결과로 자료를 변경한다. 이러한 방법으로
     다른 테이블에 저장된 레코드를 이용하여 해당 컬럼
     값을 수정할 수 있다.
     2. 문법 형식)
       update 테이블명
       set (컬럼명,컬럼명,...중략) =(서브 쿼리)
       where 조건식;  
  */
  실습)
   create table dept(
     deptno number(38) primary key /*부서번호 */
     ,dname varchar2(100) /*부서명*/
     ,LOC varchar2(100) /*지역명*/
   );
   insert into dept values(10,'경리부','서울');
   insert into dept values(20,'영업부','부산');
   insert into dept values(30,'관리부','인천');
   insert into dept values(40,'연구부','대전');
   
    
   create table dept01
   as
   select * from dept;
   
   select * from dept order by deptno asc;
   select * from dept01 order by deptno asc;
   
   서브 쿼리 검색을 통한 데이터 수정 실습)
   update dept01
   set (dname,LOC)=(select dname,LOC from dept
                     where deptno=40 
                   )
   where deptno=20;
   /*
    * 1.dept 테이블의 40번 부서의 부서명과 부서 지역을
    * 검색해서 dept01 테이블의 20번 부서명과 부서 지역
    * 을 변경하는 실습
    */
   
   
  
  
  
  