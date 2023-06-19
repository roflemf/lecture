/*
  TRUNCATE와 delete문의 차이점
   1.TRUNCATE 문의 특징
    가.TRUNCATE문은 AUTO COMMIT 문이다.즉 트랜잭션에
    의한 커밋을 처리하지 않아도 삭제 쿼리문이 반영
    된다.
    나.삭제후 롤백에 의한 자료 복구가 불가능하다.
    다.전체 행 레코드는 삭제할 수 있지만 WHERE 조건절
    에 의한 조건에 맞는 레코드만 삭제하는 것을 불가능
    하다.
    
   2.delete문의 특징
    가.delete문 실행후 반드시 커밋 또는 롤백에 의한 
    트랜잭션 처리를 해야한다.
    나.롤백에 의한 데이터 복구가 가능하다.
    다.전체 행 레코드 삭제도 가능하고,where조건절에 
    의한 조건에 맞는 레코드만 삭제하는 것도 가능하다.  
*/
TRUNCATE와 DELETE문 실습 복제테이블 DEPT56생성)

  create table dept56
  as
  select * from dept;
  
  select * from dept56;
  
  create table dept57
  as
  select * from dept;
  
  select * from dept57;
  
  
  
  
  
  