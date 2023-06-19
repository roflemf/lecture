/*
 1.데이터 무결성 제약 조건이란 테이블 컬럼에 부적절한
 자료가 저장되는 것을 방지하기 위해서 테이블 생성시
 각 컬럼에 대해서 정의하는 여러가지 규칙을 말한다.
 
 2. 제약조건 종류
    가.기본키(primary key): 중복 자료를 금지하고,
    null이 저장되는 것을 방지한다. 유일한 값을 가지고,
    반드시 자료를 입력해야 한다는 제약조건이다.
    
    나.not null 제약조건:컬럼에 반드시 값을 저장해야 한
    다. 즉 null이 저장되는 것을 방지한다.
*/
기본키와 not null 제약조건 실습)
   create table dept60(
    deptno number(38) primary key /*부서번호*/
    ,dname varchar2(50) not null /*부서명*/
    ,LOC varchar2(100) /*지역*/
   );
   
   insert into dept60
   values(10,'영업부','서울');
   
   insert into dept60
   values(10,'영업부','부산');
   /*
    * deptno 컬럼은 기본키로 설정되었기 때문에 중복
    * 부서 번호를 저장할 수 없다.
    */
   insert into dept60
   values(20,null,'서울');
   /*
    * dname 은 not null로 설정되어서 null을 저장할 수
    * 없다.
    */

   /*
    * 제약조건명, 제약 조건의 유형, 제약조건이 속한
    * 테이블명을 확인하는 쿼리문
    * select constraint_name,constraint_type,
    * table_name from user_constraints;
    * 
    *  1.constraint_name 컬럼에는 제약조건명
    *  2.constraint_type에는 제약 조건 유형
    *  3. 제약조건 유형  의미
    *       P            기본키(Primary key)
    *       C            not null+check제약조건
    *       U            unique(중복값이 없고,null
    *                    을 허용하는 제약조건)
    *       R            외래키(Foreign key)
    *  4. table_name은 제약조건이 속한 테이블명
    */
   실습)
   select constraint_name,constraint_type,table_name
   from user_constraints
   where table_name in('DEPT60');
   /*
    * 1.where 조건식의 in연산자의 테이블명 DEPT60은 
    * 반드시 영문 대문자로 해서 검색해야 검색된다.
    * 영문 소문자로 테이블명을 지정해서 검색하면
    * 검색 안된다.
    * 2.DEPT60테이블의 제약조건명,제약조건 유형,
    * 테이블명을 검색하게 한다.
    * 3.제약조건명으로 검색되는 SYS_C번호형태로 검색되
    * 는 제약조건명은 오라클이 기본으로 만들어서 제공
    * 하는 제약조건명이다.
    */
   
   /*
    * 1.not null 제약조건 특징
    *  가.특정컬럼에 반드시 자료를 입력해야 한다.
    *  나.null이 저장되는 것이 금지된다.
    */
   실습)
    create table emp101(
      empno number(38) /*사원번호 컬럼.제약조건 유형을
      생략하면 기본으로 null제약조건*/
      ,ename varchar2(50) /*사원명*/
      ,job varchar(20) /*직종*/
      ,deptno number(38) /*부서번호*/
    );
    
    select * from emp101;
    
    insert into emp101 values(null,null,'영업부',
    20);
    
    create table emp102(
     empno number(20) not null
     ,ename varchar(20) not null
     ,job varchar(20)
     ,deptno number(20)
    );
    
    insert into emp102
    values(null,null,'관리부',10);
    
    insert into emp102 values(501,'이순신','관리부',
    10);
    select * from emp102;
    
    /*
     * unique 제약조건 특징
     *  1.특정 컬럼에 자료가 중복 되지 않게 한다.
     *  2.null 저장되는 것은 허용한다.
     *  3. 중복 자료에서 null은 체크하지 않는다. 즉
     * null은 중복을 허용하는 특징이 있다. 
     */
    unique 제약조건 실습)
    create table emp103(
     empno number(10) unique
     ,ename varchar2(20) not null
     ,job varchar2(30)
     ,deptno number(38)
    );
    insert into emp103 values(502,'홍길동',
    '인사부',40);
    
    insert into emp103 values(502,'이순신','영업부',
    30);
    /* 사원번호 컬럼은 unique제약조건으로 설정됨.
     * 그러므로 중복 사원번호를 저장할 수 없다.
     */

    insert into emp103 values(null,'강감찬','관리부',
    50);
    insert into emp103 values(null,'신사임당',
    '개발부',60);
    /*
     * 1.unique 제약조건은 null저장은 허용하고,null
     * 중복 저장도 허용한다.
     */
    
    /*
     * CONSTRAINT 키워드로 정의하는 사용자 정의
     * 제약조건명 설정법 
     *  1.오라클은 컬럼 설계시 제약조건 유형을 설정
     * 하면 기본으로 제공하는 제약조건명을 자동으로
     * 부여한다. 
     *  기본 제약조건명 형식) SYS_숫자번호형식
     * 
     *  2.사용자 직접 constraint 키워드로 사용자 정의
     * 제약조건명을 설정할 수 있다.
     * 
     *  3.사용자 정의 제약조건명 설정 형식
     *   형식)
     *   컬럼명 자료형(크기) constraint 
     *   사용자정의 제약조건명 제약조건유형(not null)
     * 
     *  4.사용자 정의 제약조건명 명명 규칙
     *    형식) 
     *    테이블명_컬럼명_제약조건유형
     */
    Constraint 키워드로 제약조건명 만들기
    실습)
    create table emp105(
     empno number(20) constraint emp105_empno_uk
     unique
     ,ename varchar2(100) constraint
      emp105_ename_nn not null
      ,job varchar2(20)
      ,deptno number(20)
    );
    /*
     * 사용자 정의 제약조건명:
     *  emp105_empno_uk,emp105_ename_nn
     */
    
    select table_name,constraint_name
    from user_constraints
    where table_name in('EMP105');
    /*
     * 1.EMP105 테이블의 테이블명과 생성된 제약조건명
     * 을 알수 있다.
     * 2.table_name컬럼에는 테이블명이 저장되어 있고,
     * constraint_name컬럼에는 제약조건이름이 저장
     * 되어 있다.
     * 3.in연산 안의 작은 따옴표의 테이블명은 반드시
     * 영문 대문자로 해야 검색된다.
     */
  insert into emp105 values(101,'james','sales',10);
  insert into emp105 values(101,'smith',
  'management',20);
  
  /*
   * primary key(기본키) 제약조건의 특징
   *  1.테이블내에서 식별 기능을 갖는 컬럼은 유일하면
   * 서 null을 허용하지 말아야 한다. 이러한 컬럼에는
   * 주로 primary key 제약조건을 설정한다.
   *  2.기본키 제약조건을 설정한 컬럼은 중복 레코드가
   * 없고,null 저장이 금지된다.
   */
  사원번호를 기본키로 가지는 테이블 만들기)
   create table emp106(
    empno number(20) constraint emp106_empno_pk
    primary key
    ,ename varchar2(50) constraint
    emp106_ename_nn not null
    ,job varchar2(30)
    ,deptno number(20)
   );
   
   insert into emp106 values(201,'강감찬','관리부',
   10);
   insert into emp106 values(201,'이순신','영업부',
   20);
   
   
  
    
    
    
    
    
    
    
   
   
   
   
   
   
   
   
   
   
   
   
   

