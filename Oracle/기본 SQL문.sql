/* 사용 용도에 따른 SQL문 종류)
     1. 데이터 정의어(DDL문) : 데이터베이스 관리자가 데이터베이스의 논리적 구조를 정의할 때 사용하는 언어이다. 
         create , alter(테이블 수정문), drop(테이블 삭제,데이터베이스 삭제), rename(테이블명 변경), truncate(레코드 삭제)

    2. 데이터 조작어(DML문) : 테이블 컬럼에 저장된 한행의 자료 집합인 레코드를 다룰 때 사용하는 언어이다. INSERT(레코드 추가문),
    UPDATE(레코드 수정문), delete(레코드 삭제문)
    
    3. 데이터 제어어(DCL문) : 접근 권한 부여 또는 취소할 때 사용하는 언어이다.
       GRANT(접근 권한 부여), REVOKE(권한 취소)
       
    4.트랜잭션 처리어 : commit(정상적인 쿼리문 성공 반영), rollback(쿼리문 실행 취소)
    
    5.데이터 질의어(검색문) : select문
*/

--ddl문을 사용한 dept01 부서테이블 생성
create table dept01(
  deptno number(38) primary key --부서번호
  , dname varchar2(50) --부서명
  , LOC varchar2(20) --부서지역
  );
  
  --테이블 구조 확인 명령어, desc는 describe의 약어이다.
  desc dept01;
  describe dept01;
  
  -- DNAME컬럼크기를 20에서 30으로 변경
  alter table dept01 modify(dname varchar2(30));
  
  --레코드 하나 저장
  insert into dept01 values(50,'총무부','서울');
  
  --레코드 검색
  select * from dept02;
  
  --50번 부서의 지역을 서울에서 부산으로 변경
  update dept01 set dname='총무부',LOC='부산' where deptno=50;
  
  --50번 레코드 삭제
  delete from dept01 where deptno=50;
  
  --dept01 테이블명을 detp02로 변경
  rename dept01 to dept02;
  
  --10부서 저장
  insert into dept02 values(10,'개발부','판교');
  
  --잘 사용은 안되지만 truncate문으로 전체레코드를 삭제
  truncate table dept02;
  
  --dept02 테이블 삭제
  drop table dept02;
  
  --night사용자로 사용가능한 테이블 정보를 확인
  select * from tab; --tab는 table의 약어이다.
  
  /* 산술연산자 종류)
     +(덧셈), -(뺄셈), *(곱셈), /(나눗셈)
     
     sysdate: 오라클날짜함수
  */
  --오늘날짜 확인
  select sysdate as "오늘날짜" from dual;
  
  -- 산술 연산 확인
  select 10+10 as "덧셈결과" , 10*10 as "곱셈결과값" , 10/3 as "나눗셈결과" from dual;
  
  --emp라는 사원테이블 생성
  create table emp(
    empno int primary key --사원번호, 원래 오라클에서는 int라는 자료형이 없지만 int타입으로 하면 number(38)타입으로 만들어 진다.
    ,ename varchar2(20) --사원명
    ,sal number(38) --급여
    ,comm number(38) --보너스
    ,deptno number(38) --부서번호
    );
  
  insert into emp values(11,'홍길동',1000,100,10);
  insert into emp (empno,ename,sal,deptno) values(12,'이순신',1500,20);
  
  --사원번호를 기준으로 내림차순 정렬
  select * from emp order by empno desc;
  
  --년봉을 계산
  select ename,sal,comm, sal*12+comm as "연봉" from emp; --이순신 사원은 보너스가 null이라서 sal*12+comm=null로 나오는 심각한
  --연봉 오류가 발생한다.
  
  --보너스가 null이라서 제대로 된 연봉을 계산 못하면 nvl()함수를 사용해서 보너스 null을 0으로 변경한 다음 연봉을 계산하면 된다.
  select ename,sal,nvl(comm,0), sal*12+NVL(COMM,0) AS "연봉" from emp;
  
  /* 
    distinct 예약어는 중복 레코드를 한번만 나오게 한다.
  */
  insert into emp values(13,'신사임당님',2000,200,10);
  select deptno from emp;
  select distinct deptno from emp; --distinct 예약어로 중복부서번호를 한번만 나오게 한다.