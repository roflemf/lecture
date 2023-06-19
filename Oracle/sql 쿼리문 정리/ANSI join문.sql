/*
   미국 표준협회(ANSI)제시한 Join문
   
   1.ANSI Cross Join문
     가.ANSI Cross Join문은 From절 다음에 쉼표없이
     cross join 이라는 명확한 단어를 사용해서 조인을
     하는 방법이다.
*/
실습)
   create table depart11( /*학과 테이블*/
     dept_code varchar2(10) primary key 
     /*강의실 호수 */
     ,dept_name varchar2(100) not null
     /*강의실 담당 샘*/
   );
   insert into depart11 values('601','신사임당샘');
   insert into depart11 values('602','이순신샘');
   
   delete from depart11;
   
   select * from depart11 order by dept_code asc;
   
   create table student11( /*학생테이블*/
    st_no number(38) primary key /*학생번호*/
    ,st_name varchar2(20) /*학생명*/
    ,st_gender varchar2(10) /*성별*/
    ,dept_code varchar2(10) /*강의실 호수*/
   );
   
   drop table student11;
  
   insert into student11 
   values(11,'홍길동','남','601');
   insert into student11
   values(12,'홍길순','여','602');
   insert into student11
   values(13,'강감찬','남','602');
   
   select * from student11 order by st_no asc;
   
   select * from depart11,student11;
   
   select * from depart11 cross join student11;
   /* ANSI 표준협회 Cross join */
   
   /*
    * ANSI Inner join문
    *  1.Ansi Inner join문은 From절 다음에 Inner Join
    * 이라는 명확한 단어를 사용하여 조인할 테이블 명을
    * 명시하고 on절문에 조인 조건을 명시하는 조인
    * 방법이다.
    *  2.이 조인문은 두 테이블의 동일 컬럼을 기준으로
    * 조인한다.
    *  3.using 문을 사용한 조인 조건
    *   가.조인을 정의한 컬럼명이 두 테이블에서 모두
    * 동일하다면 using 절에서 조인할 컬럼을 지정하여 
    * 보다 더 간단히 조인을 할수 있다.
    *   나.using 절문에는 테이블명 또는 테이블 명 별칭
    * 을 사용할 수 없다.
    */
   select * from depart11,student11
   where depart11.dept_code=student11.dept_code;
   
   /*on절 조건문을 사용한 ANSI Inner join기법*/
   select * from depart11 inner join student11
   on depart11.dept_code=student11.dept_code;
   
   select st_no,st_name,st_gender,d.dept_code,
   dept_name from depart11 d,student11 s
   where d.dept_code=s.dept_code
   and s.st_name='홍길동';
   
   /*ANSI Inner Join 기법*/
   select st_no,st_name,st_gender,depart11.dept_code,
   dept_name 
   from depart11 inner join student11
   on depart11.dept_code=student11.dept_code
   and st_name='강감찬';
   
   /*
    * using절문을 이용한 조인 조건
    *  1.조인을 지정할 두 테이블의 컬럼명이 동일하다면
    * using절문에서 조인할 컬럼명만 지정하여 좀더 간단
    * 하게 조인을 표현할 수 있다.
    *  2.using절에는 테이블명 또는 테이블명 별칭을 
    * 사용할 수 없다. 
    */
   /* using절문을 사용한 inner join*/
   select st_no,st_name,st_gender,dept_code,
   dept_name
   from depart11 inner join student11   
   using (dept_code);
   
   /*
    * Natural Join문
    *  1.조건절을 생략하고 Natural Join을 사용하면
    * 자동적으로 모든 컬럼을 대상으로 공통 컬럼을
    * 조사하여 내부 조인을 실행한다.
    */
   select * from depart11 natural join student11;
   
   /*
    * ANSI Outer Join 기법
    *  1.Outer Join은 어느 한쪽 테이블에는 해당하는
    * 데이터가 존재하는데 다른쪽 테이블에는 데이터가
    * 존재하지 않는 경우 그 데이터가 출력되지 않는
    * 문제점을 해결하기 위해 사용하는 조인기법이다.
    * 
    * 2.ANSI Outer Join의 종류:
    *   LEFT Outer join,Right Outer Join,
    * Full Outer join 이 있다.
    * 
    * 3.LEFT Outer Join기법:From 절다음에 테이블명을
    * 기술할때 왼쪽,오른쪽에 기술하는데 오른쪽 테이블
    * 명에 데이터가 없는 경우 사용하는 조인기법이다.
    * 
    * 4.Right Outer Join기법: From 절 다음에 테이블명
    * 을 기술할때 왼쪽,오른쪽에 기술하는데 왼쪽 테이블
    * 에 데이터가 없는 경우 사용하는 조인기법이다.
    * 
    * 5.Full Outer Join기법: Left Outer Join과 Right
    * Outer Join기법을 합한 형태 이다. 
    */
   실습)다양한 Outer Join 실습
    create table dept21(
      deptno number(20) /*부서번호*/
      ,dname varchar2(20) /*부서명*/
    );
   insert into dept21 values(10,'ACCOUNTING');
   insert into dept21 values(20,'RESEARCH');
   
   select * from dept21 order by deptno asc;
   
   create table dept22(
     deptno number(20)
     ,dname varchar2(20)
   );
   insert into dept22 values(10,'ACCOUNTING');
   insert into dept22 values(30,'SALES');
   
   select * from dept22 order by deptno asc;
   
   select * from dept21 LEFT OUTER JOIN dept22
   on dept21.deptno=dept22.deptno;
   /* 1.dept21 테이블에는 해당 자료가 있지만 dept22
    * 테이블에는 20번 부서가 없다. 이런경우 자료가
    * 출력되지 않는 문제점을 해결하기 위해서 오른쪽에
    * 기술된 dept22테이블에 해당 자료가 없을때
    * 를 기준으로 ANSI LEFT OUTER JOIN기법을 사용한다
    * . 
    */
   
   /*
    * 1.Outer Join도 inner join처럼 두 테이블 간의
    * 조인 조건에 사용되는 컬럼명이 같다면 On문 대신
    * Using절문을 사용할 수 있다.물론 이런 경우도
    * 테이블명.컬럼명 형태가 아닌 컬럼명만 명시한다.
    */
   select * from dept21 right outer join dept22
   using (deptno);
   /*
    * 1.right outer join은 오른쪽에 기술된 dept22테이
    * 블의 자료는 있지만 왼쪽에 기술된 dept21테이블에
    * 해당자료가 없는 경우 자료가 출력되지 않는 문제
    * 점을 해결하기 위한 조인기법이다.
    */
   
   /*
    * FULL Outer Join 기법
    *  1.LEFT Outer Join과 Right Outer Join을 합한
    * 형태의 조인 기법이다.
    */
   select * from dept21 full outer join dept22
   using (deptno);
   
   
   
   
   
   
   
   
   