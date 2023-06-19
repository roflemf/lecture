오라클 저장프로시저
 1. 복잡한 쿼리문을 매번 사용할때 다시 입력할 필요 없이 간단하게 저장프로시저로 정의해 놓고
 호출해서 복잡한 쿼리문에 대한 실행 결과를 얻을려고 할때 주로 사용한다.
 
 2. 저장프로시저를 사용하면 성능도 향상되고, 호환성 문제도 해결된다.
 
 3. 저장프로시저 사용 문법
     create or replace procedure sel_board13
     --> or replace 는 같은 이름의 저장프로시저를 생성할 경우 기존 프로시저를 삭제
     -->하고 새롭게 기술한 내용으로 재생성 하는 옵션
     -->sel_board13 은 저장프로시저 이름
     ( vname out board13.name%TYPE,
       vtitle out board13.title%TYPE,
       vcont out board13.cont%type,
       vnum in board13.num%type
     )
     -->mode 매개변수라고 한다. mode 매개변수의 종류는 3가지가 있다.
     -->in은 값을 전달받을때 사용,out는 디비 레코드값을 되돌려 받을때 사용한다. 즉
     -->출력 결과물을 받을때 사용한다. inout는 두가지 목적에 모두 사용할 경우 사용한다.
     is
     begin
       select name,title,cont into vname,vtitle,vcont
       from board13
       where num=vnum;
     end;
     /
     -->begin 과 end 사이에 실제 실행할 쿼리문 문장이 들어가면 된다.
     
 4. 저장프로시저 만드는 순서
    가. sqlplus로 접속
    나. sql프롬프트>ed 저장프로시저로 작성할 sql 스크립트 파일명 fun02 로 입력
    다. 메모장이 열리면 저장프로시저 생성 쿼리문을 입력한다.
    라. @fun02 를 입력해서 저장 프로시저를 생성
    마. sql>execute 저장프로시저이름(전달될값); 으로 실행한다. 이전 실행명령어를
    취소하고 싶으면 트랜잭션의 rollback; 하면 쿼리문이 실행이 취소된다. 반대로 commit;
  하면 저장프로시저 실행이 성공적으로 완료된다.
                          