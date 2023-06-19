/*
 1.delete문은 테이블에 저장된 데이터를 삭제하는 쿼리
 문이다.
 2.delete문 문법 형식
   형식)
    delete from 테이블명
    where 조건식;
    
 3.delete문에서 where 절을 사용하지 않을 경우 테이블에
 있는 모든행이 삭제된다.그러므로 신중히 이 문을 사용해
 야 한다.   
*/
조건을 제시하여 특정행만 삭제)
select * from dept01;

delete from dept01 where deptno=40;
/* 40번 부서만 삭제*/

서브 쿼리를 이용한 레코드 삭제)
select * from emp27;

delete from emp27
where deptno=(select deptno from dept01
               where dname='경리부'
              );
/*
 * 경리부의 부서번호를 구해서 부서번호 10에 해당하는
 * 레코드를 emp27테이블로 부터 삭제한다.
 */
              
              
              
              