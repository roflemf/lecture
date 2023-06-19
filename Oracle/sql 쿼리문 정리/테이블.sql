/*
  1.alter table문: 기존 테이블 구조를 변경하기 위한
  쿼리문이다.
  2.기존 테이블에 새로운 컬럼을 추가하기
    alter table 테이블명
    add(추가할 컬럼명 자료형(크기));
*/

실습)
  create table emp21(
    empno number(38) primary key
    ,ename varchar(100)
    ,sal number(38)
  );
  
  desc emp21;
  /* 테이블 구조를 확인 하는 명령어 */
  
   alter table emp21
  add(job varchar2(50));
  /*
   * 1.emp21 테이블에 job필드를 추가
   */
  
  /*
   * 3. 기존 컬럼 속성 변경
   *  alter table 테이블명
   *  modify(필드명 자료형(크기));
   */
  alter table emp21
  modify(job varchar2(30));
  /*
   * job필드 자료형 크기50을 30으로 변경 */
   */
   
   /*
    * 4.기존 컬럼 삭제
    *  alter table 테이블명
    *  drop COLUMN 삭제할 컬럼명;
    */
   alter table emp21
   drop COLUMN job;
   
   /*
    * 5.테이블 삭제
    *  drop table 테이블명;
    * 
    * 6.테이블의 모든 레코드행을 제거
    *   truncate table 테이블명;
    */
   insert into emp21 values(1,'hr',1000);
   insert into emp21 values(2,'scott',2000);
   select *from emp21;
   
   truncate table emp21;
   
   /*
    * 6. 테이블 명 변경
    *  rename 기존테이블명 to 바꿀 테이블명
    */
   rename emp21 to test;
   
   select * from emp21;
   select *from test;
   
   /*
    * 7.현재 접속중인 사용자로 사용할 수 있는 테이블
    * 명을 알고자 할 경우
    * select table_name from user_tables
    * order by table_name desc;
    */
   select table_name from user_tables
   order by table_name desc;
  
  
  