/*
  시퀀스 개념
   1.시퀀스는 중복번호가 없고,null이 발생되지 않는다.
   2.시퀀스를 사용할 컬럼은 반드시 기본키 제약조건과
   오라클 정수형 자료형 타입으로 선언해야 한다.
   
   시퀀스 생성 문법
    1.시퀀스 생성: create sequence 시퀀스명;
    2.시퀀스 생성시 부가적인 옵션 명령어:
      가.increment by 1 : 시퀀스 생성시 1씩 증가되는
      시퀀스를 생성
      
      나.start with 1 : 1부터 시작되는 시퀀스를 생성
      하는 부가 옵션
      
      다.nocache : 이 옵션을 사용하면 시퀀스를 임시
      메모리 상에서 사용하지 않겠다는뜻.        
*/

현재 만들어진 시퀀스 이름,증가값을 확인하는 실습)
   select sequence_name,increment_by
   from user_sequences;
   /*
    * 1.sequence_name 컬럼값은 시퀀스 이름을 저장
    * 2.increment_by 컬럼값은 각 시퀀스의 증가값에
    * 대한 정보를 저장하고 있다.
    */
   dept_deptno_seq 시퀀스를 생성)
   create sequence dept_deptno_seq
   increment by 1
   start with 1
   nocache;
   
   /*
    * 1.CURRVAL : 시퀀스로 부터 현재값을 가져온다.
    * 2.nextval : 시퀀스로 부터 다음값을 가져온다.
    */
   select dept_deptno_seq.CURRVAL FROM dual;
   
   /*
    * 1.새로 만든 시퀀스로 nextval을 하지않고 currval
    * 로 현재값을 가져오면 오류가 발생한다. 이유는
    * nextval로 새로운 값을 생성하지 않았기 때문이다.
    */
    select dept_deptno_seq.nextval from dual;
   
    /*
     * 시퀀스를 프로젝트에 적용하는 경우
     *  1.게시판번호,자료실 번호등 중복번호가 없고,
     * null없는 기본키로 설정된 컬럼에 사용.
     */
    /*
     * 시퀀스 삭제:drop sequence 시퀀스명;
     */
    create sequence dept_del_seq;
    
    select sequence_name from user_sequences;
    /*
     * 1.sequence_name컬럼에는 생성된 시퀀스이름이
     * 저장된다.
     */
    drop sequence dept_del_seq;
    
    /*
    1.currval 은 nextval 후에 같은 세션에서만 현재 시퀀스 번호를
    가져오는 것이 가능하다.
    2.nextval 을 사용하고 난 다음에 그 세션이 종료하기 전까지
     currval 로 값을 가져올수 있다.
    3.시퀀스명.currval값은 한 session에서만 존재하는 임시값이다.
      currval값은 세션에서 마지막으로 call한 nextval에 의해 리턴된 값에 
      의해 정의 된다.
     만일 세션에서 nextval값이 아직 call되지 않았다면 
     currval 값은 정의 되지 않는다.
     한 세션에서 nextval을 먼저해야 currval을 할수 있다.
     */  
    
    
   
   
   
   
   
   
   
