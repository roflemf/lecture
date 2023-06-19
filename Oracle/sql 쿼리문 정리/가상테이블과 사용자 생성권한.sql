/*
 가상 뷰테이블을 사용하는 이유
  1.복잡하고 자주 사용하는 쿼리문을 보다 쉽게 간단하게
  사용하기 위해서 뷰를 이용한다.
*/
기본키가 있는 부모테이블 dept86를 생성)
  create table dept86(
   deptno number(38)
   constraint dept86_deptno_pk primary key/*부서번호*/
   ,dname varchar2(100)
   constraint dept86_dname_nn not null /*부서명*/
   ,LOC VARCHAR2(50)/*부서지역*/
  );
  
  insert into dept86 values(10,'영업부','서울');
  insert into dept86 values(20,'인사부','인천 송도');
  
  외래키가 있는 자식테이블 emp86을 생성)
  create table emp86(
   empno number(38)
   constraint emp86_empno_pk primary key /*사원번호*/
   ,ename varchar2(50)
   constraint emp86_ename_nn not null /*사원명*/
   ,sal number(38) /*급여*/
   ,job varchar2(100) /*직종*/
   ,comm number(38) /*보너스*/
   ,deptno number(38)
   constraint emp86_deptno_fk 
   references dept86(deptno) /*외래키 설정*/
   );
   
   insert into emp86
   values(101,'이순신',3000,'영업사원',300,10);
   insert into emp86
   values(102,'강감찬',6000,'영업과장',600,10);
   insert into emp86
   values(103,'신사임당',6000,'인사과장',0,20);
   
   select empno,ename,job,sal,comm,d.deptno,dname
   from dept86 d,emp86 e
   where d.deptno=e.deptno and e.deptno=10
   order by empno asc;
   
  
   복잡한 조인된 쿼리문을 뷰를 통해 단순화 실습)
   create view join_view
   as
   select empno,ename,job,sal,comm,d.deptno,dname
   from dept86 d,emp86 e
   where d.deptno=e.deptno and e.deptno=10
   order by empno asc;
   
   뷰를 통한 조인 검색)
   select * from join_view;
   
   각 부서별 오라클 사용자 권한을 통한 뷰검색)
   /*
    * 오라클 사용자 생성법
    *  1.오라클 DB 사용자를 만들려면 dba 즉 system
    * 관리자로 접속
    *  2.SQL>CREATE USER 사용자명
    *        identified by 비밀번호;
    *  사용자와 비번을 생성한다.
    *  3.사용자만 생성해서는 오라클에 접속할 수 없다.
    *  4.오라클 접속권한
    *    가.grant create session to 사용자명
    *      :오라클에 접속할수 있는 권한을 설정
    *  5.테이블 또는 가상 뷰테이블 검색권한 설정
    *    가.grant select on 테이블명(가상뷰테이블명)
    *       to 사용자명; 
    */
   
  
   /*
    * 가상테이블 뷰 삭제 문법
    *  1.형식) drop view 뷰이름;
    */
   삭제할 DEL_VIEW 생성)
    create view DEL_VIEW
    as
    select empno,ename from emp86;
    
    select * from DEL_VIEW;
    
    select view_name from user_Views;
    /*
     * 1.view_name 컬럼:생성한 가상테이블 뷰이름이
     * 저장 되어 있다.
     */
    drop view DEL_VIEW;
    /* DEL_VIEW 뷰를 삭제 */
    

    /*
     * 가상테이블 뷰 생성 옵션 문법
     *  1.create or replace view 뷰이름;
     *  or replace옵션은 존재하지 않는 뷰생성시
     * 새로운 뷰를 만들게 하고,기존에 존재하는 뷰인
     * 경우는 내용을 수정하게 한다.
     * 
     *  2.create or replace FORCE view 뷰이름;
     *  가.FORCE옵션은 기존 테이블이 존재하지 않아도
     * 뷰를 생성하게 한다.
     *  나.이 옵션을 생략하면 기본값이 NOFORCE가된다.
     * NOFORCE 옵션은 반드시 기존 테이블이 있어야
     * 가상테이블 뷰를 생성할 수 있다.
     */
    select view_name from user_views;
    
    select * from emp86;
    
    create view re_view
    as 
    select empno,ename
    from emp86;
    
    select * from re_view;
    
    create or replace view re_view
    as
    select empno,ename,sal
    from emp86;
    /* or replace옵션을 사용하면 기존 뷰내용을 
     * 삭제하지 않아도 수정할 수 있다.
     */
    select * from re_view;
    
    create or replace force view for_view
    as
    select empno,ename
    from abc;
    /* force 옵션을 사용하면 abc테이블이 없어도
     * for_view 가상뷰를 생성하게 한다.
     */
    select view_name from user_views;
    
    /*
     * 가상 뷰 생성시 사용하는 with check option
     *  1.뷰를 생성할 때 조건 제시에 사용된 컬럼값을
     * 변경 못하게 한다.
     */
    select * from emp86;
   -- 조건에 제시된 20번 부서를 수정못하게 하는
    -- with check option 실습)
    create or replace view view_check
    as
    select empno,ename,deptno
    from emp86
    where deptno=20 with check option;
    
    update view_check
    set deptno=10
    where empno=103;
    /* 20번 부서는 with check option에 의해서 뷰 생성
     * 시 조건제시에 사용되었기 때문에 뷰를 통한 20번
     * 부서번호는 수정못함.
     */
    
    /*
     * with read only 옵션
     *  1.이 옵션을 사용해서 뷰를 만들면 가상테이블
     * 뷰를 통한 기존 테이블의 어떤 컬럼 레코드값도
     * 수정 못하게 한다.
     */
    
    create or replace view only_view
    as
    select empno,ename,sal,comm,deptno
    from emp86
    where deptno=20 with read only;
    
    select * from only_view;
    
    update only_view
    set comm=100
    where deptno=20;
    /*
     * 1.only_view 가상 뷰테이블은 with read only
     * 옵션을 사용하여 뷰를 만들었기 때문에 기존 테이
     * 블의 모든 컬럼값을 뷰를 통한 수정은 할 수 없다.
     */
    
    /*
     * 오라클에서 내부적으로 제공하는 ROWNUM
     * 컬럼의 특징
     *  1.ROWNUM 컬럼은 오라클에서 내부적으로 제공하는
     * 컬럼명이다.
     *  2.ROWNUM 컬럼은 테이블에 레코드 저장시 저장된
     * 순서에 따라 1부터 1씩증가되는 일련의 번호값이
     * 차례대로 저장된다. 이 컬럼값은 자료가 입력되는
     * 시점에 결정되기 때문에 정렬 검색 할때 
     * 바뀌지 않는다.
     *  3.ORDER BY 정렬에 의해서 다시 정렬된 순서대로
     * ROWNUM컬럼값을 변경하고자 할 경우는 새로운 테이
     * 블에서 다시 작업을 해야한다. 이런 경우는 테이블
     * 의 저장 공간이 필요하기 때문에 가상 뷰테이블을
     * 사용하면 효과적이다.이유는 가상 뷰테이블은 
     * 저장 공간이 필요 없기 때문이다.
     */
    emp92테이블 생성)
     create table emp92(
      empno number(38) primary key
      ,ename varchar2(50)
      ,sal number(38)
     );
     
     insert into emp92 values(1,'홍길동',1000);
     insert into emp92 values(2,'이순신',2000);
     insert into emp92 values(3,'강감찬',3000);
     
     select rownum ,empno,ename,sal
     from emp92
     order by empno asc;
     
     select rownum,empno,ename,sal
     from emp92
     order by empno desc;
     
    create or replace view row_view
    as
    select empno,ename,sal
    from emp92 
    order by empno desc;
     
     delete from emp92 where empno=2;
     
     select rownum,empno,ename,sal from row_view;
     
     select rownum ,empno,ename,sal
     from row_view
     where rownum <= 1;
     
     /*
      * 인라인 뷰란?
      *  1.인라인 뷰는 sql문에서 사용하는 서브 쿼리문
      * 의 일종으로 from 절다음에 위치하여 마치 
      * 테이블 처럼 사용된다.
      *  2.인라인 뷰는 메인 쿼리문의 select 문 from
      * 절 다음에 사용되는 서브 쿼리문을 말한다.
      *  3.사용문법 형식
      *   select ...
      *   from ..(select .. )
      *   where 조건식;
      */
     실습 예)
      select rownum,empno,ename,sal
      from (select empno,ename,sal from emp92
            order by empno desc)
      where rownum<=1;
      
    
     
     
    
    
    
    
    
    
    
    
    
    
    
    
   
   
   
   
   
   
   
   

  
  
  
  
  