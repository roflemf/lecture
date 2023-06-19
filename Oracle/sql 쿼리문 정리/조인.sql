/*
  1.조인이란? 하나이상의 테이블을 서로 합쳐서 데이터를
  조회하기 위해서 사용되는 것을 조인(join)이라 한다.
  
  2.cross join이란?
    가.2개 이상의 테이블이 조인될 때 where절에 의한
    공통되는 컬럼에 의한 결합이 발생하지 않는 경우를
    뜻한다.
    나.cross join을 하면 테이블 전체 행에 대한 컬럼이
    조인된다.
*/
조인 실습)
  /* 부서 테이블*/
  create table dept05(
    deptno number(38) primary key /*부서번호*/
    ,dname varchar2(100) /*부서명*/
  );
  
  insert into dept05 values(10,'관리부');
  insert into dept05 values(20,'영업부');
  insert into dept05 values(30,'연구부');
  
  select * from dept05 order by deptno asc;
  
  /*사원테이블*/
  create table emp05(
    empno number(38) primary key /*사원번호*/
    ,ename varchar2(100) /*사원명*/
    ,job varchar2(100) /*직종*/
    ,sal number(38) /*급여*/
    ,comm number(38) /*보너스*/
    ,deptno number(38) /*부서번호*/
  );
  
  insert into emp05 
  values(7001,'홍길동','관리사원',1500,0,10);
  insert into emp05
  values(7002,'이순신','영업사원',1200,100,20);
  insert into emp05
  values(7003,'강감찬','영업사원',1300,130,20);
  insert into emp05
  values(7004,'홍길순','연구원',2000,20,30);
  
  select * from emp05 order by empno;
  /* 사원번호를 기준으로 오름차순 정렬 */
  
  /* cross join 실습 */
  select * from dept05, emp05;
  
  
  /*
   * 강의실 호수와 샘
   */
  create table room(
    roomno number(38) primary key /*강의실 호수*/
    ,roomname varchar2(100) /*강의실 담당 샘*/    
  ); 
 
  insert into room values(601,'홍길동 샘');
  insert into room values(602,'이순신 샘');
  select * from room order by roomno asc;
  
  /*학생테이블*/
  create table st03(
    stno number(38) primary key /*학생번호*/
    ,stname varchar2(100) /*학생명*/
    ,roomno number(38) /*강의실 호수*/
  );
  insert into st03 values(1,'홍길순 학생',601);
  insert into st03 values(2,'강감찬 학생',602);
  insert into st03 values(3,'신사임당 학생',602);
  
  select *from st03 order by stno asc;
  
  /* cross join 검색 */
  select * from room,st03;
  
  /*
   * Equi JOIN 특징
   *  1.Equi Join은 가장 많이 사용하는 조인 방법으로
   * 조인 대상이 되는 두 테이블에서 공통적으로 존재하
   * 는 컬럼의 값이 일치되는 행을 연결하여 결과를 생성
   * 하는 조인 기법이다.
   *  2.두 테이블을 조인하려면 일치되는 공통 컬럼을 
   * 사용해야 한다.컬럼의 이름이 같으면 혼동이 오기 때
   * 문에 컬럼 이름앞에 테이블명을 명시해야 한다.
   */
  /*
   * room,st03 두 테이블 Equi join 검색
   */
  select * from room,st03
  where room.roomno = st03.roomno;
  
  select stno,stname,room.roomno,roomname
  from room,st03
  where room.roomno =st03.roomno
  and stname='신사임당 학생';
  
  select stno,stname,room.roomno,roomname
  from room,st03
  where room.roomno=st03.roomno
  and stname like '%길%';
  /*
   * 1. like는 검색 연산자로 정확한 값을 모를 때 사용
   * 한다.
   * 2.%는 와일드 카드로서 하나이상의 임의의 문자와 
   * 매핑 대응한다.
   */
  
  select stno,stname,r.roomno,roomname
  from room r,st03 s
  where r.roomno=s.roomno
  and s.stname like '신%';
  /*
   * 1.테이블 명의 별칭을 접두어 r,s로 지칭함.
   */
  select * from emp05;
  
   /*
   * Non Equi Join 특징
   *  1.조인 조건의 특정 범위 내에 있는지를 조사하기
   * 위해 where 조인 조건으로 =연산자 이외의 비교 연산
   * 자를 사용한다.
   * 
   *  2.where 절의 특정 범위를 급여등급으로 하는
   * SALGRADE테이블을 생성한다.
grade필드(급여등급) LOSAL(최소급여) HISAL(최대급여)
  1                   700           1200
  2                   1201          1400
  3                   1401          2000  
   */
  실습)급여등급 테이블 SALGRADE 생성
  create table SALGRADE(
    grade number(38) primary key /*급여등급*/
    ,LOSAL number(38) /*최소급여*/
    ,HISAL number(38) /*최대급여*/
  );
  insert into SALGRADE values(1,700,1200);
  insert into SALGRADE values(2,1201,1400);
  insert into SALGRADE values(3,1401,2000);
  
  select * from SALGRADE order by grade asc;
  
  select * from emp05 order by empno asc;
  
  select ename,sal,grade
  from emp05,SALGRADE
  where sal between LOSAL AND HISAL;
  /*
   * 1.WHERE 조건절에서 특정범위내의 조인 조건으로
   * 검색하는 기법을 NON EQUI JOIN이라 한다.
   */
  select e.ename,e.sal,s.grade
  from emp05 e,salgrade s
  where e.sal >= s.LOSAL AND e.sal<=s.HISAL;
  
  /*
   * 1.사원 테이블 emp05,부서 테이블 dept05,
   * 급여 등급 테이블 SALGRADE 3개 테이블을 조인
   * 검색
   * 2.EQUI JOIN+NON EQUI JOIN
   */
  select e.ename,e.sal,s.grade,d.dname
  from emp05 e,SALGRADE s,dept05 d
  where e.deptno=d.deptno
  and e.sal between s.LOSAL AND S.HISAL;
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  