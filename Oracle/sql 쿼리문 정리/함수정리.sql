/*
  DECODE 함수 특징
   1.DECODE 함수는 프로그램 언어에서 가장 많이 사용하는
   switch case 문과 같은 기능을 한다. 즉 여러 가지
   경우에 선택할 수 있게 한다.
   
   사용하는 형식)
     DECODE (표현식,조건1,결과1,
                    조건2,결과2,
                    조건3,결과3,
                    기본결과n
            )     
                    
*/
실습)
  create table emp01(
    deptno number(10) /*부서번호*/
    ,ename varchar2(30) /*사원명*/
  );
  
  insert into emp01 values(10,'MILLER');
  insert into emp01 values(20,'smith');
  insert into emp01 values(20,'jones');
  insert into emp01 values(30,'allen');
  
  select * from emp01;
  
  select ename,deptno,decode(deptno,10,'ACCOUNTING',
                                    20,'RESEARCH',
                                    30,'SALES')
                                    AS DNAME
 FROM emp01;                                    
  
/*
 * CASE 함수
 *  1.CASE 함수 역시 여러가지 경우에서 하나를 선택하는
 * 함수이다.
 *  2.CASE 함수는 프로그램 언어의 if else if else
 * 다중 조건문과 같은 기능을 한다.
 * 
 * 형식)
 *   CASE WHEN 조건1 THEN 결과1
 *        WHEN 조건2 THEN 결과2
 *        WHEN 조건3 THEN 결과3
 *        ELSE 결과N
 *   END
 */  
 실습)
   select ename,deptno,
          case when deptno=10 then 'ACCOUNTING'
               when deptno=20 then 'RESEARCH'
               when deptno=30 then 'SALES'
          end as dname
  from emp01;
  
  /*
   * 그룹함수 종류
   *  1.SUM(합계),AVG(평균),COUNT(총레코드 개수),
   *    MAX(최대값),MIN(최소값),STDDEV(표준편차),
   *    VARIANCE(분산)
   */
  실습)
   create table emp02(
    dept_no number(38)
    ,ename varchar2(20)
    ,sal number(38) 
    ,comm number(38) /*보너스*/
    ,job varchar2(20) /*업무부서*/
   );
   
  
   insert into emp02 values(10,'scott',1000,100,
   'salesman');
   insert into emp02 values(10,'tiger',1500,150,
   'salesman');
   insert into emp02 (dept_no,ename,sal,job)
   values(20,'james',2000,'manager');
   insert into emp02 (dept_no,ename,sal,job)
   values(20,'king',2500,'manager');
   
   select * from emp02;
   
   /*
    * 전체 사원의 총 급여 합
    */
   select sum(sal) from emp02;
   
   select sum(comm) from emp02;
   /*
    * 1.그룹함수를 사용하면 comm 필드 보너스 총합을
    * 구해도 다른 연산자와 달리 null을 제외하고 총합
    * 을 구한다. 즉 그룹함수는 null값을 제외한다.
    */
   select avg(sal) from emp02;
   /*
    * 사원들의 급여 평균을 구함.
    */
   select max(sal),min(sal) from emp02;
   /* 최대 급여와 최소 급여를 구함 */
   
   select count(comm) from emp02;
   /*
    * count 함수 사용시 주의 사항
    *  1.count함수는 null값에 대한 개수를 세지 않는다.
    */
   select count(*) from emp02;
   /* 전체 레코드 수를 구함 */


   select count(job) from emp02;
   
   select count(distinct job) from emp02;
   /* 중복 레코드를 제거하고 개수를 카운터 할려면
    * distinct키워드를 사용한다.
    */
   
   /*
    * group by 문
    *  1.어떤 특정 컬럼 값을 기준으로 그룹함수를 
    * 사용하고자 할 경우 select 문 다음에 group by
    * 문을 추가하고 해당 컬럼을 기술한다.
    *   예)부서별 급여 평균을 구하는 경우 사용.
    */
   select dept_no,avg(sal)
   from emp02
   group by dept_no;
   /* 부서별로 그룹화 시켜서 부서별 급여 평균을 구함*/
   
   select dept_no,sum(sal),avg(sal)
   from emp02
   group by dept_no;
   /*부서별 급여 총합과 급여 평균을 구함*/
   
   select dept_no,max(sal),min(sal)
   from emp02
   group by dept_no;
   /*부서별 최대 급여와 최소 급여를 구함*/
   
   select dept_no,count(*),count(comm)
   from emp02
   group by dept_no;
   /* 부서별 사원수와 보너스를 받는 사원수를 구함*/
   
   /*
    * where 조건식과 having 조건식 비교
    *  1.where 조건식
    *   가.where 절은 테이블에서 데이터를 가져올 때
    * 특정 조건에 맞는 자료만을 검색할 때 사용한다.
    *  2.having 조건식
    *   가.그룹함수 사용 후 나온 결과값 중에서 원하는
    * 조건에 맞는 자료만 추출하고자 할때 사용한다.
    *   나.having 문에는 그룹함수를 적용한 컬럼이 조건
    * 식으로 온다. 
    */
   select dept_no,avg(sal)
   from emp02
   group by dept_no;
   /*부서별 평균 급여를 구함.*/
   
   select dept_no,avg(sal)
   from emp02
   group by dept_no
   having avg(sal) >= 2000;
   /* 부서별 평균 급여가 2000 이상인 경우만 부서번호,
    * 부서별 평균 급여를 구함*/
   
   select dept_no,max(sal),min(sal)
   from emp02
   group by dept_no
   having max(sal) > 2000;
   /* 부서별 최대 급여가 2000을 초과한 경우에 맞는
    * 부서별 번호,부서별 최대값,최소값을 구함.*/
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
  
  
  
  
  
  
  
  
  
  
          
  
  
  
  
  
  
  
  
  
