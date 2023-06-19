/*
  1.서브쿼리문 : 서브 쿼리문 역시 특정 테이블에서 검색
  한 결과를 다른 테이블에 전달하여 새로운 결과를 검색
  하는 경우에 사용한다.
  
  2.서브 쿼리문 구조
    select dname from dept
    where deptno=( select deptno 
                   from dept
                   where ename='scott');
   
     가. 서브쿼리는 하나의 select문장의 절안에 포함된
    또 하나의 select문 절이다. 그렇기 때문에 서브
    쿼리를 포함하고 있는 쿼리문을 메인 쿼리라 하고,
    포함된 또 하나의 쿼리를 서브 쿼리라 한다.
     
     나.서브 쿼리문은 비교 연산자의 오른쪽에 
     기술해야 하고
    반드시 소괄호 안에 넣어야 한다.
    서브 쿼리는 메인 쿼리가 실행되기 전 한번만 실행
    된다.
    
    다. 서브 쿼리는 단일행 서브 쿼리와 다중행 서브 쿼
    리가 있다.      
    
   3.단일 행 서브 쿼리문
     
     가.단일 행 서브쿼리는 수행 결과가 오직 하나의 
     행만 반환하는 서브 쿼리를 뜻한다.
     
     나.단일 행 서브쿼리는 오직 하나의 행으로 반환된
     결과값을 메인 쿼리로 보내는 데 매인 쿼리의 where
     절에는 단일행 비교연산자를 사용한다.
     
     다.단일행 비교연산자 종류
       =(같다),>,>=,<,<=, <>(같지 않다.)                           
*/
단일행 서브 쿼리 실습)
  create table dept15(
   deptno number(10) primary key /*부서번호*/
   ,dname varchar2(100) /*부서명*/
  );
  
  insert into dept15 values(10,'관리부');
  insert into dept15 values(20,'영업부');
  insert into dept15 values(30,'연구부');
  
  select * from dept15 order by  deptno asc;
  
  create table emp15( /*사원테이블*/
    empno number(38) primary key /*사원번호*/
    ,ename varchar2(100) /*사원명*/
    ,job varchar2(100) /*직종*/
    ,sal number(38) /*봉급*/
    ,comm number(38) /*보너스*/
    ,deptno number(10) /*부서번호*/
  );
  
  insert into emp15 
  values(21,'홍길동','관리사원',1500,0,10);
  insert into emp15
  values(22,'이순신','영업사원',1200,100,20);
  insert into emp15
  values(23,'강감찬','영업사원',1500,200,20);
  insert into emp15
  values(24,'세종대왕','연구사원',3000,300,30);
  insert into emp15
  values(25,'신사임당','연구사원',2500,250,30);
  
  select *from emp15 order by empno asc;
  
  select dname from DEPT15
  where deptno=(select deptno 
                from emp15
                where ename='홍길동');
  /*단일행 서브쿼리 실습*/                
  
  select avg(sal) from emp15;
  /*사원들의 급여 평균을 구함*/
  
  select ename,sal from emp15
  where sal>1400;
                
  select ename,sal from emp15
  where sal>(select avg(sal)
             from emp15
            );

 /*
  * 1.다중행 서브쿼리:서브 쿼리에서 반환되는 결과가
  * 하나 이상의 행일때 사용하는 서브 쿼리를 말한다.
  * 
  * 2.다중행 서브 쿼리는 단일행 서브쿼리 연산자(=,>,
  * >=,<,<=,<>)를 사용할 수 없고,다중행 연산자를 
  * 사용해야 한다.
  * 
  * 3.다중행 서브쿼리 연산자 종류
  *   가. IN연산자:메인 쿼리의 비교 조건에서 서브 쿼
  * 리의 출력 결과와 하나라도 일치하면 메인 쿼리의 
  * WHERE 절이 참이 되는 연산자를 뜻함.
  * 
  *   나.>ALL 연산자: 서브 쿼리의 모든 결과값중에서
  * 최대값보다 크면 참이되는 연산을 뜻함.
  * 
  *   다. > ANY 연산:서브 쿼리의 모든 결과값중에서 
  * 최소값보다 더 크면 참이 되는 연산을 뜻함.
  */
            
select distinct deptno from emp15
where sal>=1200;
/*
 * 1.distinct 키워드는 중복 레코드를 제거
 */
         
select ename,sal,deptno
from emp15
where deptno=(select distinct deptno
              from emp15
              where sal>=1200
             );
/* 1. 서브쿼리가 검색 결과가 복수개 인 경우는 다중행
 * 연산자를 사용해야 한다.단일행 연산자(=,>,>=,<,<=,
 * <>)는 사용할 수 없다.
 */
             
 select ename,sal,deptno
 from emp15
 where deptno IN (select distinct deptno
                 from emp15
                 where sal>=1200
                );
/* IN 다중행 서브쿼리 연산자는 서브쿼리문 검색 결과값
 * 중 하나라도 일치하면 참이된다.
 */                
                
select max(sal)
from emp15
group by deptno
having deptno=20;
/*
 * 1.20번 부서 영업부의 최대 급여을 구함.
 */

select ename,sal,deptno
from emp15
where sal > (select max(sal)
              from emp15
              group by deptno
              having deptno=20
            );
/*
 * 1. 단일 행 서브쿼리이다.20번 영업부서의 최대 급여
 * 보다 큰 사원명과 봉급,부서번호를 검색
 */
 
select sal from EMP15
where deptno=20;
/* 20번 영업부서의 급여를 검색*/

select ename,sal,deptno
from emp15
where sal>(select sal from emp15
           where deptno=20
          );
 /* 다중행 서브쿼리에서는 단일행 서브쿼리 연산자 >
  * 를 사용할수 없다.
  */         
          
 select ename,sal,deptno
 from emp15
 where sal >ALL (select SAL
                 from emp15
                 where deptno=20
                );
 /*
  * 1. >ALL 다중 행 서브쿼리 연산은 20번 영업부서 사원
  * 의 급여중 최대 급여보다 크면(>) 참값을 반환
  * 한다.즉 영업부 사원의 최대 급여 보다 큰 사원명,
  * 급여,부서번호를 검색하게 해주는 다중행 서브쿼리
  * 이다.
  */        
                
select * from emp15;                
          
select min(sal)
from EMP15
group by deptno
having deptno=20;
            
select ename,sal
from emp15
where sal>(select min(sal) from emp15
           group by deptno
           having deptno=20
          );
/* 
 * 20번 영업부서 사원 급여중 최소급여 보다 큰 사원명,
 * 급여를 검색(단일행 서브 쿼리)
 */          
          
select ename,sal
from emp15
where sal> ANY (select sal from EMP15
                where deptno=20   
               );
/*
 * 1.>ANY 다중행 서브 쿼리 연산
 *  가.20번 영업부 사원의 급여중 최소값 보다 크면
 * 참이 되는 연산이다.
 *  나.그러므로 영업부 사원의 최소 급여 보다 큰 
 * 사원명,급여를 검색하게 한다.
 *  다. 서브 쿼리 검색 값이 하나 이상 인 경우는 반
 * 드시 다중행 서브쿼리 연산을 사용해야 한다.
 */               
          
select * from emp15;               
                
select * from emp16;            
            
create table emp16
as
select * from emp15;
/*
 * 1.서브쿼리를 이용하여 이미 존재하는 emp15 
 * 테이블과 동일한 구조와 레코드값을 가지는 새로운
 * 테이블 emp16을 만들고 있다.
 */

create table emp17
as
select empno,ename,sal,deptno
from emp15;
/*
 * 1. emp15테이블의 원하는 컬럼만 선택적으로 복사해서
 * 복제 테이블 emp17을 생성한다. 물론 선택된 필드 
 * 레코드도 함께 복제된다.
 */
select * from emp17;
select * from emp15;


create table emp18
as
select * from EMP15
where deptno=30;
/*
 * 1.30번 부서 즉 연구부서만 레코드행이 선택적으로 
 * 복제된다. 물론 테이블 레코드도 일부 복제된다.
 */
select * from emp18;

create table emp19
as
select * from emp15
where 1=0;
/*
 * 1.기존 테이블 구조만 복제하고 레코드는 복제하지 않
 * 을려면 where 조건식을 거짓으로 만들면 된다.
 */
select *from emp19;











            
                
                
                
  
