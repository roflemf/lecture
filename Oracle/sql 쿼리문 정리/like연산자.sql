/*
	LIKE연산자.sql
*/

/*
	LIKE 연산자와 와일드 카드 문자
	  1. LIKE 연산자는 검색하려는 값을 정확히 모를 경우에도 검색할 수 있도록
	     와일드 카드와 함께 사용하여 원하는 내용을 검색하게 한다.
	     
	  형식) 컬럼명 LIKE 형태;
	  
	  2. 와일드 카드
	     가. %: 하나 이상의 모르는 임의의 문자와 매핑 대응한다.
	     나. _: 단 하나 모르는 문자와 매핑 대응한다.
*/

create table emp7(
	empno number(20),
	ename varchar2(50),
	job varchar2(50),
	sal number(20),
	comm number(20)
)


select * from emp7;


insert into emp7 values(7310, 'smith', 'salesman', 1000, 100);
insert into emp7 (empno, ename, job, sal) values(7311, 'king', 'manager', 2000);
insert into emp7 values(7312, 'clerk', 'salesman', 1500, 150);

select ename from emp7 where ename like 's%';

select ename from emp7 where ename like '%i%';

select ename from emp7 where ename like '_m%';

select ename from emp7 where ename like '__e%';



/*
 * NULL의 의미
 *   1. NULL은 미확정, 알 수 없는 값을 의미
 *   2. NULL값을 = 연산자로 판단할 수 없다.
 *   3. 특정 필드 값이 NULL 값인지를 비교할 경우에는 IS 연산자를 사용 즉 IS NULL로 판단
 *   4. 특정 필드 값이 NULL이 아닌 자료만 추출하기 위해서는 IS NOT NULL 연산자를 사용한다. 
 */

select * from emp7 where comm is not null;

select 24 * 60 from dual;

select sysdate from dual;

/*
 * 숫자 함수
 *   1. ABS함수: 절대값을 구하는 함수이다. 주어진 값이 음수인 경우 양수로 표현된다.
 *   2. FLOOR함수: 소수점 아래를 버리는 함수이다.
 *   3. ROUND함수: 지정한 자릿수 이하에서 반올림한 결과를 구하는 함수이다.
 *     형식) ROUND(대상, 자릿수)
 *   예를 들면
 *     ROUND(34.5678, 2) 하면 두번째 인자값이 2이면 소수점 이하 세번째 자리에서 반올림하여
 *     소수점 이하 두번째 자리까지 표시된다. 
 *   4. TRUNC함수: 지정한 자릿수 이하를 버린 결과를 구하는 함수이다.
 *   예를 들면
 *     TRUNC(34.5678, 2) 하면 두번째 인자값이 2이면 소수점 이하 3번째 자리에서 버림연산을 한 후
 *     소수점 이하 2번째 자리까지 표시된다. 결국 34.56이 구해진다.
 *   5. MOD함수 : 나눗셈을 한 후 몫이 아닌 나머지를 구하는 함수이다.
 */


select abs(-10), -10 from dual;
select 34.5678, FLOOR(34.5678) from dual;
select 34.5678, ROUND(34.5678, 2) from dual;
select TRUNC(34.5678, 2) from dual;
select MOD(27, 2), mod(25, 5), MoD(27, 7) from dual;



