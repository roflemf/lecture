
create table dept51(
  deptno number(20) primary key /*부서번호*/
  ,dname  varchar(50) /*부서명*/
);

insert into dept51 values(101,'영업부');
insert into dept51 values(102,'인사부');

select * from dept51 order by deptno asc;

/*
 1.트랜잭션이란?
   가.트랜잭션은 데이터 처리의 한 단위를 의미한다.
   오라클에서 발생하는 여러 개의 sql문을 하나의 논리적
   작업 단위로 처리하는 것을 말한다.
   
 2. commit 이란?
    가.모든 sql문을 정상적으로 처리하겠다는 뜻
    
 3. ROLLBACK 이란?
    가. SQL문 작업을 취소 하겠다는 뜻.       
*/
복제본 테이블 dept52 생성)
  create table dept52
  as
  select * from dept51;
  
  select * from dept52;
  
  /*
   * 4.AUTO COMMIT(자동 커밋) 되는 쿼리문 정리
   *  create(테이블 생성문), alter(테이블 수정문),
   *  drop(테이블 삭제문),rename(테이블 명 변경문),
   * TRUNCATE(테이블 전체행 삭제문)
   * 
   * 5.insert,delete,update을 데이터 조작어라 한다.
   * 데이터 조작어는 auto commit이 아니다. 하지만 
   * delete문을 실행하고 commit을 하지 않아도 auto 
   * 커밋 되는 create 문을 실행시 commit을 사용하지
   * 않아도 delete문까지 오토커밋되어 버린다. 주의
   * 
   * 6.데이터 조작어를 실행하고,auto commit되는 쿼리문
   * 을 실행할때 에러가 발생해도 이전 데이터 조작어에
   * commit이 반영되어 rollback처리가 안된다.
   */


auto commit 실습 복제테이블 생성(dept53)
  
   create table dept53
   as 
   select * from dept51;
   
   select * from dept53;


   /*
    * 1.SAVEPOINT 는 오라클에서 제공하는 기본 트랜잭션
    * 범위를 인위적으로 작게 분할하는 것을 말한다.
    * 
    * 2.세이브 포인트에 의해서 지정한 세이브 포인트명
    * 까지 이동할려면 rollback to 세이브 포인트명으로
    * 처리 할 수 있다.그러면 이동한 세이브 포인트명까지
    * 롤백 측 쿼리문 취소를 할 수 있다.
    * 
    * 3.세이브 포인트명 지정하는 형식
    *   가. SAVEPOINT 세이브포이트명;
    * 
    * 4.세이브 포인트명으로 지정된 곳 까지 이동 즉
    * 되돌아 가는 형식
    *   형식)
    *   ROLLBACK TO 세이브 포인트명;
    */ 
   세이브 포인트 실습)
   insert into dept53 values(102,'관리부');
   insert into dept53 values(103,'인사부');
   insert into dept53 values(104,'경리부');
   
   select * from dept53;
   
   
   



   
   
   
   
   
   
   
   