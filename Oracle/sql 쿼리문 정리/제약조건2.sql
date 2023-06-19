/*
참조 무결성을 위한 외래키 제약조건 실습
 1.기본키로 설정된 부모테이블 dept71 부터 먼저 만든다.
 2.dept71부터 자료를 먼저 저장한다.
*/
dept71 테이블 생성실습)
  create table dept71(
   deptno number(38) constraint dept71_deptno_pk
   primary key
   ,dname varchar2(100) constraint dept71_dname_nn
   not null
   ,LOC varchar2(150)
  );
  
  insert into dept71 values(10,'관리부','서울');
  insert into dept71 values(20,'영업부','부산');
  insert into dept71 values(30,'개발부','판교');
  
  select * from dept71 order by deptno asc;
  
 
  /* 외래키 제약조건 특징
   * 1.기본키를 포함한 부서테이블의 deptno컬럼을 참조
   * 해야 한다.
   * 2.부서테이블의 deptno컬럼에 저장된 부서번호만
   * 외래키로 설정된 컬럼 자료로 저장할 수 있다.이것이
   * 곧 참조 무결성이라 한다.
   */

  외래키를 포함한 사원테이블 emp71 생성)
  create table emp71(
   empno number(38)
   constraint emp71_empno_pk primary key /*사원번호*/
   ,ename varchar2(100) 
   constraint emp71_ename_nn not null /*사원명*/
   ,job varchar2(100) /*직종*/
   ,deptno number(38)
   constraint emp71_deptno_fk 
   references dept71(deptno)
  );
  
  insert into emp71 values(11,'홍길동','관리원',10);
  insert into emp71 values(12,'이순신','영업사원',
  20);
  
  select * from emp71 order by empno asc;
  
  insert into emp71 values(13,'강감찬','경리원',50);
  /*
   * 1.참조 무결성 제약조건 에러 이유
   *   ; 부서테이블의 기본키 컬럼 deptno에 없는 부서번
   * 호를 emp71테이블 외래키로 설정된 부서번호에 자료를
   * 저장할려고 할 경우 발생하는 에러이다.
   */
  
  select table_name,constraint_type,
  constraint_name,r_constraint_name
  from user_constraints
  where table_name in('DEPT71','EMP71');
  /*
   * 1. table_name컬럼에는 테이블명이 저장
   * 2. constraint_type에는 제약조건 유형 저장
   *    제약조건유형  의미
   *      P           기본키
   *      C           CHECK 또는 NOT NULL
   *      R           외래키
   *      U           UNIQUE
   * 3. constraint_name: constraint 키워드로 정의된
   * 제약조건명
   * 4. r_constraint_name :외래키가 어느 기본키를 참조
   * 했는지 대한 정보를 담고 있다.
   * 5. in연산자의 DEPT71,EMP71 테이블명은 반드시
   * 영문대문자로 해야한다.
   */
  
  ANSI(미국 표준협회) Inner join 실습)
  select * from dept71 inner join emp71
  on dept71.deptno=emp71.deptno;
  
  기본키가 포함된 학과 테이블을 만듬)
  create table depart71(/*학과 테이블*/
    deptcode varchar2(6) 
    constraint depart71_deptcode_pk primary key
    /*학과 코드*/
    ,deptname varchar2(20)
    constraint depart71_deptname_nn not null
  );
  
  insert into depart71 values('a001','영어교육학과');
  insert into depart71 values('a002','수학교육학과');
  
  select * from depart71 order by deptcode asc;
  

  외래키가 포함된 학생테이블 student71 설계)
  create table student71(
    sno number(38)
    constraint student71_sno_pk primary key
    /*학생번호:유일 자료를 가지고,null이 없다.*/
    ,sname varchar2(100)
    constraint student71_sname_nn not null /*학생명*/
    ,gender varchar2(10)
    constraint student71_gender_nn not null /*성별*/
    ,addr varchar2(200) /*주소*/
    ,deptcode varchar2(6)
    constraint student71_deptcode_fk 
    references depart71(deptcode) /*외래키 설정*/
  );
  insert into student71 values(1,'홍길동',
  '남','서울시','a001');
  insert into student71 values(2,'이순신',
  '남','부산시','a002');
  
  select sno,sname,gender,addr,d.deptcode,deptname
  from depart71 d, student71 s
  where d.deptcode=s.deptcode;
  /* 공통 컬럼을 기준으로 조인검색*/
  
  select table_name,constraint_type,
  constraint_name,r_constraint_name
  from user_constraints
  where table_name in('DEPART71','STUDENT71');
 

  /*
   * CHECK 제약조건 이란?
   *  1.check 제약 조건은 조건에 맞는 자료만 저장
   * 되게 한다.
   */
  check제약조건 실습)
   create table emp73(
    empno number(38)
    constraint emp73_empno_pk primary key
    ,ename varchar2(50) 
    constraint emp73_ename_nn not null
    ,sal number(38)
    constraint emp73_sal_ck 
    check(sal between 500 and 5000)
    /* 500부터 5000사이의 급여만 저장되게 한다.*/
    ,gender varchar2(10)
    constraint emp73_gender_ck
    check(gender in('M','F'))
    /* gender컬럼에 남자인 경우는 M,여자인 경우는
     * F 둘 중 하나만 저장되게 한다.*/
   );
   
   insert into EMP73
   values(7501,'신사임당',7000,'F');
   /* 급여가 500에서 5000 범위를 벗어나서 CHECK
    * 제약조건 에러 발생
    */ 
   insert into emp73
   values(7502,'강감찬',3000,'K');
   /*
    * gender 컬럼에 남자인 경우는 M,여자인 경우는
    * F 둘중 하나만 저장되는대 그 범위를 벗어난 K
    * 가 저장안되는 CHECK 제약조건 에러 발생
    */
   

   default 제야조건 실습)
   create table dept73(
    deptno number(38) primary key
    ,dname varchar2(50)
    ,LOC varchar2(50) default '서울'
   );
   insert into dept73 (deptno,dname)
   values(11,'영업부');
   /* LOC 컬럼에 자료를 저장하지 않아도 DEFAULT제약조
    * 건으로 설정된 서울 자료가 기본으로 저장 
    */
   select * from dept73;
 
    /*
    * 제약조건 지정방법
    *  1.컬럼 레벨 지정법:컬럼에 직접 제약조건을 지정
    * 한다.
    * 
    *  2.테이블 레벨 지정법
    *   가.컬럼을 모두 정의하고 나서 테이블 정의를
    * 마무리 짓기 전에 일괄적으로 한꺼번에 제약조건을
    * 지정하는 방법이다.
    * 
    *   나. 하나의 테이블에 2개 이상의 기본키를 설정
    *  하는 것을 복합키라 한다. 이러한 복합키는 반드시
    * 테이블 레벨 지정법으로 정의 해야 한다.
    * 
    *   다. not null은 컬럼 레벨 지정법으로 직접 컬럼
    * 생성시 제약조건을 정의해야 한다.
    */
   컬럼 레벨 지정 방식으로 테이블을 생성)
   create table emp75(
    empno number(20) primary key
    ,ename varchar2(20) not null
    ,job varchar2(20) unique
    ,deptno number(38) references dept71(deptno)
   );
   
   select table_name,constraint_name,constraint_type,
   r_constraint_name 
   from user_constraints
   where table_name ='EMP75';
   
   테이블 레벨 방식으로 제약조건 지정)
   create table emp76(
    empno number(38)
    ,ename varchar2(100) not null
    ,job varchar2(100)
    ,deptno number(38)
    ,primary key(empno)
    ,unique(job)
    ,foreign key(deptno) references dept71(deptno)
   );
   
   select constraint_name,constraint_type,
   table_name,r_constraint_name
   from user_constraints
   where table_name='EMP76';
   
   테이블 지정방식으로 constraint키워드를 사용한
   사용자 정의 제약조건명 명시적 지정 실습)
   create table emp77(
    empno number(20)
    ,ename varchar2(50)
    constraint emp77_ename_nn not null
    ,job varchar2(50)
    ,deptno number(20)
    ,constraint emp77_empno_pk primary key(empno)
    ,constraint emp77_job_uk unique(job)
    ,constraint emp77_deptno_fk 
    foreign key(deptno) references dept71(deptno)
   );
   
   select constraint_name,constraint_type,
          table_name,r_constraint_name
   from user_constraints
   where table_name='EMP77';
  
   

   복합키로 테이블 생성)
   create table member01(
     id varchar2(20)
     ,name varchar2(100)
     ,addr varchar2(200)
     ,phone varchar2(20)
     ,constraint member01_idphone_pk
     primary key(id,phone)
     /* id,phone컬럼에 복합키 설정 */
   );
   
   select owner,constraint_name,
   table_name,column_name
   from user_cons_columns
   where table_name='MEMBER01';
   /*
    * 1.owner컬럼에는 오라클 접속 사용자명이 저장
    * 2.column_name 컬럼에는 컬럼명이 저장
    */
   
   /*
    * 미리 생성된 테이블 컬럼에 제약 조건 추가형식
    *  형식)
    * alter table 테이블명
    * add constraint 사용자정의 제약조건명 
    * 제약조건타입(컬럼명);
    */
   기존 테이블에 제약조건 추가 실습)
   create table emp78(
     empno number(20)
     ,ename varchar2(100)
     ,job varchar2(100)
     ,deptno number(20)
   );
  
 

   select constraint_name,constraint_type,
           table_name,r_constraint_name
   from user_constraints
   where table_name='EMP78';
   
   alter table emp78
   add constraint emp78_empno_pk primary key(empno);
   /*
    * 1.emp78 테이블 empno 컬럼에 기본키를 추가
    */
   alter table emp78
   add constraint emp78_deptno_fk
   foreign key(deptno) references dept71(deptno);
   /*
    * 1.emp78 테이블의 deptno컬럼을 외래키로 설정.
    * 이 외래키는 dept71테이블의 deptno컬럼 기본키를
    * 참조하고 있다.
    */
   
   /*
    * not null 제약조건 추가하기
    *  1.not null 제약조건을 추가하기 위해서는 add
    * 대신 modify문을 사용한다. 이유는
    * null을 허용한 상태에서 not null로 수정한다는
    * 뜻이 있기 때문에 modify문을 사용한다.
    * 
    *   형식)
    *   alter table 테이블명
    *   modify 컬럼명 
    *   constraint 사용자정의 제약조건명 not null
    */
   not null 제약조건 추가 실습)
   alter table emp78
   modify ename 
   constraint emp78_ename_nn not null;
   
   select constraint_name,constraint_type,
          table_name,r_constraint_name
   from user_constraints
   where table_name='EMP78';
   
   /*
    * 제약조건 제거 형식
    *  alter table 테이블명
    *  drop constraint 제약조건명;
    */
   insert into emp78
   values(11,'이순신','관리사원',10);
   
   insert into emp78
   values(12,'홍길동','영업사원',20);
   
   insert into emp78
   values(11,'강감찬','관리사원',10);
   
   기본 제약조건 제거 실습)
   alter table emp78
   drop constraint emp78_empno_pk;
   
   select constraint_name 
   from user_constraints
   where table_name='EMP78';
   
   SELECT * FROM emp78;
   
 
   not null 제약조건 제거 실습)
   insert into emp78 values(13,null,'영업사원',20);
   
   alter table emp78
   drop constraint emp78_ename_nn;
   /* emp78테이블 ename컬럼의 not null을 제거*/
   
   

   /*
    * 제약조건 비활성화 특징
    *  1.제약 조건을 삭제하지 않고 비활성화 하여 잠시
    * 사용을 보류하는 것을 말한다.
    *  
    *  2.제약조건 비활성화 형식
    *   alter table 테이블명
    *   disable constraint  제약조건명;
    */
   참조무결성 외래키로 인한 레코드 삭제가 불가능한
   실습)
   create table dept91(
    deptno number(20)
    constraint dept91_deptno_pk primary key
    ,dname varchar2(50)
    ,LOC varchar2(50)
   );
   
   insert into dept91
   values(10,'경리부','서울');
   insert into dept91
   values(20,'영업부','부산');
   
   select * from dept91;
   
   외래키 포함 테이블 emp91 생성)
   create table emp91(
    empno number(20)
    constraint emp91_empno_pk primary key
    ,ename varchar2(20)
    constraint emp91_ename_nn not null
    ,job varchar2(50)
    ,deptno number(20)
    constraint emp91_deptno_fk
    references dept91(deptno)
    );
    
    insert into emp91 values(11,'홍길동','경리부장',
    10);
    insert into emp91 values(12,'이순신','영업부장',
    20);
    select * from emp91;
    
    delete from dept91 where deptno=10;
    /*참조 무결성 외래키 제약조건 때문에 삭제가 안됨*/
    

    /*
     * 제약조건 비활성화
     */
    alter table emp91
    disable constraint emp91_deptno_fk;
    /* emp91 테이블 외래키를 삭제 하지 않고 잠시 사용
     * 을 보류
     */
    select constraint_name,status
    from user_constraints
    where table_name='EMP91';
    /* status 컬럼값에서 DISABLED는 제약조건 비활성화.
     *  ENABLED는 해당 제약조건이 활성화 되어진 것
     * 이기 때문에 사용할 수 있다.*/
    delete from dept91
    where deptno=10;
    
    select * from dept91;
    
    insert into dept91 values(10,'경리부','서울');

    /*
     * 제약조건 활성화 형식
     *  1.잠시 비활성화 되어져서 사용이 보류된 제약조
     * 건을 다시 사용할려고 활성화 하는 것을 말한다.
     *  2.제약조건 활성화 형식
     *  alter table 테이블명
     *  enable constraint 제약조건명;
     */
    실습)
    alter table emp91
    enable constraint emp91_deptno_fk;
    /* enable constraint 키워드로 외래키 제약조건을
     * 활성화 함.다시 외래키를 사용할 수 있다.
     */
    select constraint_name,status
    from user_constraints
    where table_name='EMP91';
    
    /*
    * CASCADE옵션 특징
    *  1.CASCADE 옵션은 부모 테이블과 자식 테이블 간
    * 에 기본키와 외래키 참조 관계가 설정된 경우
    * 부모 테이블의 기본키 제약조건을 비활성화 시키면
    * 연속적으로 자식 테이블의 외래키 제약조건까지
    * 함께 한번에 비활성화 시키는 법.
    */
    기본키가 있는 부서테이블 생성)
    create table dept81(
     deptno number(38)
     constraint dept81_deptno_pk primary key
     ,dname varchar2(50)
     ,LOC varchar2(100)
    );
    
    insert into dept81
    values(101,'관리부','서울');
    
    insert into dept81
    values(102,'개발부','제주도');
    
    select * from dept81;
    
    외래키가 있는 사원테이블 생성)
    create table emp81(
     empno number(38) constraint emp81_empno_pk
     primary key
     ,ename varchar2(50)
     constraint emp81_ename_nn not null
     ,job varchar(50)
     ,deptno number(38)
     constraint emp81_deptno_fk references 
     dept81(deptno)
    );
    
    insert into emp81 values(7001,'이순신',
    '관리사원',101);
    insert into emp81 values(7002,'강감찬',
    'java 개발자',102);
    
    select * from emp81;
    
    select constraint_name,constraint_type,
    table_name,R_constraint_name,status
    from user_constraints
    where table_name in('DEPT81','EMP81');
    /*
     * 1.status 컬럼은 해당 컬럼 제약조건이 활성화
     * 되었는지,비활성화 되었는지를 알수 있다.
     */
    
    alter table dept81
    disable primary key CASCADE;
    /* cascade 옵션으로 dept81테이블의 기본키 제약조
     * 건을 비활성화하면 emp81테이블의 외래키 제약
     * 조건까지 한꺼번에 비활성화 한다.*/
    
    alter table dept81
    drop primary key;
    /* dept81 테이블 기본키 제약조건을 삭제하면
     * 외래키가 비활성화 되었어도 삭제할 수없다. */
    
    alter table dept81
    drop primary KEY CASCADE;
    /* CASCADE옵션을 사용하면 DEPT81 테이블의 기본키
     * 뿐만 아니라 EMP81 테이블의 외래키 제약조건까지
     * 한꺼번에 삭제된다.
     */
    
    
    
    
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
  
  
  
  
  
  
  
  
  
  
  
  
 