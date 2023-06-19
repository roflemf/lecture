/*
  오라클 사용자 생성 문법
   1.형식:
     create user 사용자명
     identified by 비밀번호;
     
  사용자 권한 설정 형식
   1.형식:
     grant 권한 to 사용자명;
     
   2. grant 권한 to 사용자명
      with admin option;
      =>사용자 권한 설정시 부가옵션으로 with admin
      option 권한을 설정하면 권한이 설정이 된 사용자가
      데이터베이스 관리자(DBA)가 아니어도 자신이 부여
      받은 권한을 다른 사용자에게 부여할 수 있는 권한
      도 함께 부여된다.     
      
   3. 오라클 DBA(데이터베이스 관리자)가 설정하는 
   시스템권한 종류
     가.사용자 생성후 grant create session to 사용자;
     로 create session 권한을 설정해야 생성된 사용자가
     오라클에 접속할 수 있다.
     나.grant create table to 사용자; 생성된 사용자에
     create table 즉 테이블 생성권한을 할당해야 한다.
     하지만 테이블 생성권한만 주어서는 테이블 생성을
     할 수 없다.그러므로 각 사용자에게 테이블 사용
     공간인 테이블 스페이스를 할당해야 한다.        
*/

/*
 *  각 객체 즉 테이블을 소유한 사용자가 객체의 모든 권
 * 한을 가지고 있다.
 *  1.객체 권한 설정형식
 *   grant 권한 on 테이블명 to 사용자명;
 */
실습)
 create table nt(
  addr varchar2(100)
 );
 insert into nt values('서울시');
 select addr from nt;
 
 grant select on nt to a01;
 /*
  * 1.a01사용자에게 nt 테이블을 검색할 수 있는 권한을
  * 설정
  */
 
 select grantee,table_name,grantor,privilege
 from user_tab_privs_made;
 /*
  * 1.grantee 컬럼:권한이 할당된 사용자 명
  * 2.table_name:각 객체,가상테이블 뷰 이름
  * 3.grantor 컬럼:권한을 준 사용자명
  * 4.privilege 컬럼:권한 이름(테이블 select 권한..)
  */
 
 /*
  * 사용자에게 부여한 각 객체 권한을 철회하기 위한
  * 명령어 형식
  *  형식)  REVOKE 권한 ON 테이블명 from 사용자명;
  */
 REVOKE select on nt from a01;
 /* a01사용자로 부터 night 계정의 nt테이블 검색권한을
  * 철회시킨다.
  */
 
 /*
  * grant 권한 on 테이블명 to 사용자
  * with grant option;
  * =>사용자에게 객체 권한을 with grant option과 같이
  * 부여하면 부여받은 사용자는 그 권한을 다른 사용자
  * 에게 부여할 수 있는 권한도 함께 주어진다.
  */
 grant select on nt to a02
 with grant option;
 /* a02사용자는 다른사용자에게도 nt테이블 검색권한을
  * 줄수 있다.이유는 with grant option 부가옵션을 
  * 설정 했기 때문이다.
  */
 
 /*
  * 롤(ROLE) 이란?
  *  1.롤은 사용자에게 보다 더 간편하게 권한을 부여할
  * 수 있도록 여려 개의 권한을 묶어 놓은 권한의 집합
  * 을 뜻한다.
  * 
  * 롤(ROLE)의 생성 절차
  *  1.롤을 생성하기 위해서 DBA(system)계정으로 로그
  * 인
  *  2.롤을 생성
  *  형식)create ROLE 롤이름;
  *  3.생성될 롤에 권한을 부여
  *    형식)부여되는 권한이 시스템권한(create session
  * (오라클 연결 권한),create table,create view)
  * 일때는 DBA로 접속에서 부여
  *   grant create session,create table,create 
  * view to 롤이름;
  * 
  *   형식)부여되는 권한이 객체 권한일때는 객체 소유
  * 자로 접속해서 부여.
  *   grant 객체권한 to 롤이름;
  * 
  *   4.사용자에게 생성될 롤을 부여하는 작업(DBA로
  * 접속)
  *   형식)grant 롤이름 to 사용자;
  * 
  *   5. 사용자에게 생성된 롤을 확인 방법
  *   형식)
  *    select username,granted_role 
  *    from user_role_privs;
  *    가.username 컬럼에는 사용자명
  *    나.granted_role 컬럼에는 사용자에게 설정된
  *    롤이름이 저장.
  */
 
 
 /*
  * 롤회수 란?
  *  1.롤(ROLE)회수는 특정 사용자에게 해당 롤을 사용
  * 할 수 없도록 회수하는 것을 말한다.해당롤은 존재하
  * 기 때문에 다른 사용자게 롤을 부여할 수 있다.
  *  2.롤 회수 형식문법 
  * 형식) REVOKE 롤이름 FROM 오라클 사용자명;
  * 
  * 롤 제거란?
  *  1.롤 제거는 롤 자체를 삭제하는 것을 말한다.
  *  2.롤자체가 제거 때문에 다른 사용자에게 롤을 부여
  * 할 수 없다.
  *  3.롤 제거 형식 문법
  *  형식)DROP ROLE 롤이름;
  */
 
 
 
 
 
 
 
 










