/*
	* DDL(DATA DERINITION LANGUAGE) : 데이터 정의 언어
	
	구조자체를 정의하는 언어로 주로 db관리자, 설계자가 사용함
	오라클에서 제공하는 객체(OBJECT)를
	새롭게 만들고(CREATE), 구조를 변경하고(ALTER), 구조를 삭제하고(DROP)하는 명령어
	
	DDL : CREATE, ALTER, DROP
	
	오라클의 객체(구조) : 테이블(TAVLE), 사용자(USER), 뷰(VIEW), 시퀀스(SEQUEANCE)
					, 인덱스(INDEX), 패키지(PACKEGE), 트리거(TRIGGER)
	                , 프로시저(PROCEDIRE), 함수(FUNCTION), 동의어(SYNONYM)
	
	DQL : SELECT => 질의
	DML : INSERT /UPDATE/ DELETE =>데이터를 조작
	DDL : CREATE / ALTER / DROP => 구조 조작
*/

 /*
  * < CREATE TABLE >
  * 
  * 테이블이란? : 행(ROW), 열(COLUMN)로구성되는 가장 기본적인 데이터베이스객체
  * 관계형 데이터베이스는 모든 데이터를 테이블 형태로 저장함
  * (데이터를 보관하ㅈ고자 하면 반드시 테이블이 존재해야함)
  * 
  * [ 표현법 ]
  * CREATE TABLE TB_테이블명 (
  * 	컬럼명 자료형,
  * 	컬럼명 자료형,
  *     컬럼명 자료형,
  *		...
  * )
  * 
  *  < 자료형 >
  * -문자(CHAR(크기) / VARCHAR2(크기) / NVARCHAR2(크기)) : 크기는 BYTE단위
  * 												  (NVACHAR는 예외)
  * 								숫자, 영문자, 특수문자 => 1글자당 1BYTE
  * 								한글, 일본어, 중국어  => 1글자당 3BYTE
  * 
  * - CHAR(바이트크기) : 최대 2000BYTE까지 지정가능
  * 				  고정길이(아무리 작은 값이 들어와도 공백으로 패워서 크기유지)
  *                   주로 들어올 값의 글자수가 정해져 있을 경우
  * 					예) 성별 M / F
  * - VARCHAR2(바이트크기) : VAR는 '가변'을 의미 2는 '2배'를 의미
  * 					  CHEO 4000BYTE까지 지정가능
  *                       가변길이(적은 값이 들어오면 맞춰서 크기가 줄어듬)
  * 					 --> CLOB, BLOB
  * - NVARCHAR2(N) : 가변길이, 선언방식(N)  --> N : 최대 문자 수
  *                  다국어 지원이 아주 화끈함 완전 지원
  * 				 VACHAR2보다 성능이 떨어질 수 있음
  * 
  * - 숫자(NUMBER) : 정수 / 실수 상관없이 NUMBER
  * - 날짜(DATE)
  * 
  * 변수명 짓기 힘들면 변수명 짓기 사이트ㄱㄱ
  * 
  */

-->회원의 정보(아이디, 비밀번호, 이름, 회원가입일)를 담기위한 테이블 만들기
-- 키워드는 식별자로 사용할 ㅅ ㅜ없음

CREATE TABLE TB_USER(
    USER_ID VARCHAR2(20),
	USER_PWD VARCHAR2(20),
    USER_NAME NVARCHAR2(30),
    ENROLL_DATE DATE
);
SELECT * FROM TB_USER;
/*
 * 컬럼에 주석달기 == 설명 다는 법
 * COMMENY ON COLUMN 테이블명.컬럼명 IS '설명
 * 
 * 
 */
COMMENT ON COLUMN TB_USER.USER_ID IS '회원아이디';

SELECT * FROM USER_TABLES;
-- 현재 이 계정이 가지고 있는 테이블 들으 ㅣ전반적인 구조를 확인할 수있음
SELECT * FROM USER_TAB_COLUMNS;
-- 현재 이 계정이 가지고 있는 테이블 들의 모든 컬럼의정보를 조회할 수 있음

-- 데이터 딕셔너리 : 객체들의 정보를 저장하고 있는 시스템 테이블

--테이블에 데이터를 추가
-- INSERT
INSERT
  INTO
       TB_USER
VALUES
       (
       'USER01'
     , '1234'
     , '관리자'
     , '2025-08-27'
       );
INSERT INTO TB_USER VALUES('USER01', 'PASS01', '이승철', '25/08/27');
INSERT INTO TB_USER VALUES('USER02', 'PASS02', '홍길동', SYSDATE);

SELECT * FROM TB_USER;
--------------------------------------------------------------------

INSERT INTO TB_USER VALUES(NULL, NULL, NULL, SYSDATE);

SELECT * FROM TB_USER;

INSERT INTO TB_USER VALUES('USER02', 'PASS02', '고길동', SYSDATE);
-- 중복된 아이디 값은 존재해선안됨


-- NULL값이나 중독된 아이디 값은 ㄴ유효하지 않은 값들
-- 유효한 데이터값을 유지하기 위해서는 제약조건을 걸어줘야함

SELECT * FROM TB_USER;


----------------------------------------------
/*
 * < 제약 조건 CONSTRAINT >
 * 
 * - 테이블에 유효한 데이터값만 유지하기 위해서 특정컬럼마다 제약== 데이터 무결성보장
 * - 제약조건을 부여하면 데이터를 INSERT / UPDATE할 때마다 제약조건에 위배되지않는지 검사
 *  
 * - 종류 ㅣ NOT NULL, UNIQUE, CHECK, PRIMARY KEU, FOREIGN KEY
 * 
 * 제약조건을 부여하는 방법 : 컬럼 레벨 / 테이블레벨
 */

/*
 * 1. NOT NULL 제약조건
 * 해당 컬럼에 반드시 값이 조재해야할 경우 사용(NULL값을 막는다)
 * INSERT / UPDATE 시 NULL값이 허용하지 않도록 제한
 * 
 * NOT NULL 제약조건은 컬럼레벨을유지할 수 있음 
 */



-- 새로운 테이블을 만들면서 NOT NULL제약조건 달아보기
-- 컬럼레벨방식 : 컬럼명 자료형 제약조건

CREATE TABLE TB_USER_NOTNULL(
	USER_NO NUMBER NOT NULL,
	USER_ID VARCHAR2(20) NOT NULL,
	USER_PWD VARCHAR(20) NOT NULL,
	USER_NAME NVARCHAR2(30),
	GENDER CHAR(3)
);
SELECT * FROM TB_USER_NOTNULL;
INSERT INTO TB_USER_NOTNULL VALUES(1, 'ADMIN', '1234', '관리자', '남');
INSERT INTO TB_USER_NOTNULL VALUES(NULL, NULL, NULL, NULL, SYSDATA);

--NULL을("LEE"."TB_USER_NOTNULL"."USER_NO") 안에 삽입 불가능

INSERT 
  INTO 
       TB_USER_NOTNULL
VALUES
       (
       2
     , 'USER01'
     , 'PASS01'
     , NULL
     , NULL
       ); --NOT NULL제약조건이 달린 컬럼에는 반드시 NULL이 아닌 값이 존재해야함
       
SELECT * FROM TB_USER_NOTNULL;
INSERT
  INTO
       TB_USER_NOTNULL
VALUES
       (
	   3
	 , 'USER01'
	 , 'PASS01'
	 , NULL
	 , NULL
       );
---------------------------------------------------
/*
 * 2. UNIQUE 제약조건
 * 컬럼에 중복ㄱ밧을 제한하는 제약조건
 * INSERT / UPDATE 시 기존 컬럼값 중 종복값이 있을 경우 추가또는 수정할 수없도록 제약
 * 
 * 컬럼레벨 / 테이블 레벨 방식 둘 가 가능
 */

CREATE TABLE TB_USER_UNIQUE(
	USER_NO NUMBER CONSTRAINT NUM_NOT_NULL NOT NULL, 
	USER_ID VARCHAR2(20) NOT NULL UNIQUE,
	USER_PWD VARCHAR2(20) NOT NULL,
	USER_NAME NVARCHAR2(20),
	GENDER CHAR(3),
	CONSTRAINT ID_UNIQUE UNIQUE(USER_ID) -- 테이블레벨 방식
);
DROP TABLE TB_USER_UNIQUE;
SELECT * FROM TB_USER_UNIQUE;

INSERT INTO TB_USER_UNIQUE VALUES(1, 'admin', '2314', NULL, NULL);
INSERT INTO TB_USER_UNIQUE VALUES(2, 'admin', '1234', NULL, NULL);
INSERT INTO TB_USER_UNIQUE VALUES(1, 'admin', '1234', NULL, NULL);
-- 제약조건명을 달아두면 문제가 생긴 원인을 조금 더 쉽게 유 추할 ㅅ ㅜ있음
INSERT INTO TB_USER_UNIQUE VALUES(3, 'user01', '1234', NULL, NULL);
--gender컬럼은 '남 또는 '여' 라는 값만 들어갈 수 있게 하고 시ㅍ음
-------------------------------------------------
/*
 * 3. CHECK 제약조건
 * 컬럼에 기록 될 수있는 값에대한조건을 설명할 수 있음
 * 
 * CHECK(조건식)
 */
CREATE TABLE TB_USER_CHECK(
	USER_NO NUMBER NOT NULL,
	USER_ID VARCHAR2(20)NOT NULL UNIQUE,
	USER_PWD VARCHAR2(20) NOT NULL,
	GENDER CHAR(3) CHECK(GENDER IN ('남', '여'))
);

INSERT INTO TB_USER_CHECK VALUES(1, 'admin', '1234', '여');
INSERT INTO TB_USER_CHECK VALUES(2, 'USER01', 'PASS01' '밥');
INSERT INTO TB_USER_CHECK VALUES(3, 'USER03', 'PASS02', NULL);

--CHECK를 부여하더라고 NULL값은 INSERT할 ㅅ ㅜ있음 -> NOT NULL로 막아야함

--------------------------------
--QUIZ
-- 특정 컬럼에 기본값을 설정하는방법 ==> 제약조건은아님
CREATE TABLE TB_USER_DEFAULT(
	USER_NO NUMBER NOT NULL,
	USER_ID VARCHAR2(20) NOT NULL UNIQUE,
	USER_PWD VARCHAR2(20) NOT NULL,
	USER_NAME NVARCHAR2(30),
	USER_NICK NVARCHAR2(30) UNIQUE,
	GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
	USER_PHONE VARCHAR2(20),
	USER_EMAIL NVARCHAR2(30),
	USER_ADDRESS NVARCHAR2(30),
	USER_HIRE_DATE DATE DEFAULT SYSDATE NOT NULL
);
DROP TABLE TB_USER_DEFAULT;
SELECT * FROM TB_USER_DEFAULT;


INSERT
  INTO 
       TB_USER_DEFAULT
       (
       USER_NO
     , USER_ID
     , USER_PWD
       ) 
VALUES (
       1
     , 'admin'
     , '1234'
       );
       --(1, 'ASD123', '1234', '박정의', '대통령', '여', '010-1588-1588', NULL, '청와대');
-------------------------------------------------------------------------------------
/*
 * 4. PRIMARY KEY(기본키, PK) 제약조건 ****************중요
 * 테이블에서 각 행들으 ㅣ정보를 유일하게 식별할 용도로 컬럼에 부여하는 제약조건
 * -> 행들을구분하는 식별자의 엵할
 * 
 * =>중복이 발생해선 안되고 ㄱ밧이 꼭 있어야만 하는 식별용 컬럼에 PRIMARY KEY를 부여
 * 
 * 한테이블당 한 번만 사용가능 
 */
CREATE TABLE TB_USER_PK(
	USER_NO NUMBER CONSTRAINT PK_USER PRIMARY KEY,
	USER_ID  VARCHAR2 (15) NOT NULL UNIQUE, 
	USER_PWD VARCHAR2(20) NOT NULL,
	USER_NAME VARCHAR2(30),
	GENDER CHAR(3) CHECK(GENDER IN('남', '여'))
);

INSERT INTO TB_USER_PK
VALUES(1, 'ADMIN', '1234', NULL, NULL);

INSERT INTO TB_USER_PK
VALUES(1, 'USER01', '231412', NULL, NULL);

SELECT * FROM TB_USER_PK;


CREATE TABLE TB_PRIMARY KEY,
	NO NAME PRIMARY KEY,
	ID CHAR (2) PRIMARY KRY
);
-- 하나의 테이블은 하나의 PRIMARY EKY만 가질 ㅜ수 있다.ALTER 
-- 두 개의 컬럼을 묶어ㅓ 하나의 PRIMARY KEY로 만들 수 있다 -->복합기

CREATE TABLE VIDEO(
	NAME VARCHAR2 (15),
	PRODUCT VARCHAR2(20),
	PRIMARY KEY( NAME, PRODUCT)
);
INSERT INTO VIDEO VALUES('이승철', '자바');
INSERT INTO VIDEO VALUES('이승철', 'DB');
INSERT INTO VIDEO VALUES('홍길동', '자바');

SELECT * FROM VIDEO;

---------------------------------------------------------

-- 회원 등급에 대한 데이터(코드, 등급명) 보관하는 테이블
CREATE TABLE USER_GRADE(
	GRADE_CODE CHAR(2) PRIMARY KEY,
	GEADE_NAME NVARCHAR2(20) NOT NULL
);
INSERT INTO USER_GRADE VALUES('G1', '일반회원');
INSERT INTO USER_GRADE VALUES('G2', '회장님');
INSERT INTO USER_GRADE VALUES('G3', '대통령');

SELECT 
       GRADE_CODE
     , GEADE_NAME
  FROM
	   USER_GRADE;


/*
 * 5. FOREIGN KEY(외래키) 제약조건
 * 
 * 다른 테이블에 존재하는 값만 컬럼에 INSERT하고싶을 때 부여하는 제약조건
 * => 다른 테이블(부모테이블)을 참조한다고 표현
 * 참조하는 테이블에 존재하는 값만 INSERT 할 수 있다.
 * =>FOREAIN KEY(외래키) 제야ㄱ조건
 * 
 * [ 표현법 ]
 * 
 * - 컬럼 레벨 방식
 * 컬럼명 자료형 REFERENCERS 참조할 테이블명(참조할 컬럼명)
 * 
 * -테이블 레벨 방식
 * FOREIGN KEY(컬럼명) REFERENCES참조할테이블명(참조할 컬럼명)
 * 
 * 컬럼명 생략 시 PRIMARY KEY컬럼이 참조할 컬럼이 됨
 * 
 */



CREATE TABLE TB_USER_CHILD (
	USER_NO NUMBER PRIMARY 	KEY,
	USER_ID VARCHAR2(15) NOT NULL UNIQUE,
	USER_PWD VARCHAR(20) NOT NULL,
	GRADE_ID CHAR(2) REFERENCES USER_GRADE,
	--FOREIGN KEY(GRADE_ID) REFERENCES USER_GRADE(GEADE_NAME) --테이블 레벨방식
);

INSERT INTO TB_USER_CHILD VALUES(1, 'user01', 'pass01', 'G1');
INSERT INTO TB_USER_CHILD VALUES(2, 'user02', 'pass01', 'G2');
INSERT INTO TB_USER_CHILD VALUES(3, 'user03', 'pass03', 'G1');
INSERT INTO TB_USER_CHILD VALUES(4, 'user04', 'pass04', NULL);


SELECT * FROM TB_USER_CHILD;


INSERT INTO TB_USER_CHILD VALUES(5,'user05', 'pass05', 'G4');

DROP TABLE TB_USER_CHILD;


--<QUIZ>

SELECT 
	   USER_NO
	 , USER_ID
  FROM
       TB_USER_CHILD
  LEFT
  JOIN
       USER_GRADE ON (GRADE_CODE = GRADE_ID);
--조인을 하기위해서 꼭 외래키 제약조건을 달아야하는건아님

--부모테이블(USER_GRADE)에서 데이터를 삭제
-- GRADE_CODE가 G1인 행 삭제

DELETE
  FROM 
       USER_GRADE
 WHERE 
       GRADE_CODE = 'G1';

SELECT * FROM  USER_GRADE;

ROLLBACK;

--------------------------------------------------
/*
 * 자식 테이블 생성 시 외래키 제약조건을 부여하면 
 * 부모테이블의 데이터를 삭제할 때 자식테이블에서는 처리를 어떻게 할 것인지 옵션 지정 가능
 * 
 * 기본 설정은 ON DELETE RESTIRCTED(삭제제한)이 설정됨
 */
-- 1) ON DELETE SET NULL == 부모 데이터 삭제 시 자식 레코드도 NULL값으로 변경

CREATE TABLE TB_USER_ODSN(
	USER_NO NUMBER PRIMARY KEY,
	GRADE_ID CHAR(2),
	FOREIGN KEY(GRADE_ID) REFERENCES USER_GRADE ON DELETE SET NULL
);

INSERT INTO TB_USER_ODSN VALUES(1, 'G1');
INSERT INTO TB_USER_ODSN VALUES(2, 'G2');
INSERT INTO TB_USER_ODSN VALUES(3, 'G1');

SELECT * FROM TB_USER_ODSN;

DELETE FROM USER_GRADE WHERE GRADE_CODE ='G3';

DROP TABLE TB_USER_CHILD;

ROLLBACK;

--부모테이블의 GRADE_CODE가 G1인 행 삭제
DELETE FROM USER_GRADE WHERE GRADE_CODE = 'G1';
ROLLBACK;

-- 2) ON DELETE CASCADE : 부모데이터 삭제 시 데이터를 사용하는 자식데이터도 같이  삭제

CREATE TABLE TB_USER_ODV(
	USER_NO NUMBER PRIMARY KEY,
	GRADE_ID CHAR(2),
	FOREIGN KEY(GRADE_ID) REFERENCES USER_GRADE ON DELETE CASCADE
);
INSERT INTO TB_USER_ODV VALUES(1, 'G1');

SELECT * FROM TB_USER_ODV;

DELETE FROM USER_GRADE WHERE GRADE_CODE = 'G1';


------------------------------------------------------
/*
 * 2. ALTER
 * 
 * 객체 구조를 수정하는 구문
 * 
 * < 테이블 수정 >
 * 
 * ALTER TABLE 테이블 명 수정할 내용;
 * - 수정할 내용
 * 1) 컬럼 추가 / 컬럼 수정 / 컬럼 삭제
 * 2) 제약조건 추가 / 삭제 => 제약조건 수정은 x
 * 3) 테이블명 / 컬럼명 / 제약조건명
 */

CREATE TABLE  JOB_COPY
	AS SELECT * FROM JOB;
-- 컬럼들 조회결과의 데이터값들 제약조건은 NOT NULL만 복사가된다.

SELECT * FROM JOB_COPY;

-- 1) 컬럼추가 / 수정 / 삭제
-- 1_1) 추가(ADD) : ADD 추가할 컬럼명 자료형 DEFAULT기본값(DEFAULT 생략 가능)

-- LOCATION
ALTER TABLE JOB_COPY ADD LOCATION VARCHAR2(10);
ALTER TABLE JOB_COPY ADD LOCATION_NAME VARCHAR2(20) DEFAULT '한국';
-- NULL값이 아닌 DEFAULT 값으로 채워진다.

-- 1_2) 컬럼수정(MODIFY)
-- 자료형 수정 : ALTER TABLE 테이블 MODIFY컬럼명 바꿀 데이터타입;
-- DEFAULT 값 수정 : ALTER TABLE 테이블명 MODIFY컬럼명 DEFAULT 기본값;

--JOB_CODE컬럼 데이터 타입을 CHAR(3)로 변경
ALTER TABLE JOB_COPY MODIFY JOB_CODE CHAR(3);

--ALTER TABLE JOB_COPY MODIFY JOB_CODE NUMBER;
--ALTER TABLE JOB_COPYMODIFY JOB_CODE CHAR(1);
--현재 변경하려고 하는 컬럼의값과 완전히 다른 타입이거나 작은 크기로는 변경이 불가능함!
-- 문자 -> 숫자(X) / 사이즈축소(X) / 확대 (O)
SELECT * FROM JOB_COPY;

-- JOB_NAM 컬럼데이터타입을NVARCHAR2(40)
-- LOCATION컬럼 데이터 타입을 NVARCHAR2(40)
-- LOCATION_NAME 컬럼 기본값을 '미국'

ALTER TABLE JOB_COPY
MODIFY JOB_NAME NVARCHAR2(40)
MODIFY LOCATION NVARCHAR2(40)
MODIFY LOCATION_NAME DEFAULT '미국';

--1_3) 컬럼 삭제(DROP COLUMN ) : DROP COLUMN 컬럼명

CREATE TABLE JOB_COPY2
	AS SELECT * FROM JOB;

ALTER TABLE JOB_COPY2 DROP COLUMN JOB_CODE;
SELECT * FROM JOB_COPY2;

CREATE TABLE ABC(

);
-- 테이블은 최소 한 개의 컬럼은 가지고 있어야함
--------------------------------------------------------------
--2) 제약조건추가 / 삭제

/*
 * 테이블을 생성한 후 제약조건을 추가 (ADD)
 * 
 * - PRIMARY KEY : ADD PRIMARY KEY(컬럼명);
 * - FOREIGN KEY : ADD FOREIGN KEY (컬럼명) REFERENCERS 부모테이블명
 * - CHECK : ADD CHECK(컬럼명);
 * - UNIQUE : ADD UNIQUE(컬럼명);
 * 
 * - NOT NULL : MODIFY 컬럼명 NOT NULL;
 * 
 * 제약조건 달려있는걸 삭제
 * PRIMARY KET ,FOREIGN KEY, UNIQUE, CHECK : DROP CONSTRAINT 제약조건명
 * 
 * - NOT NULL : MODIFY 컬럼명 NULL;
 */

ALTER TABLE JOB_COPY
	ADD CONSTRAINT JOB_UQ UNIQUE(JOB_NAME);

ALTER TABLE JOB_COPY
DROP CONSTRAINT JOB_UQ;
--------------------------------------------------------------
--3) 컬럼명 / 제약조건명 / 테이블병 변경(RENAME)
-- 3_1) 컬럼명 바꾸기 : ALTER TABLE 테이블명 RENAME COLUMN 원래컬럼명 TO 바꿀컬럼명
ALTER TABLE JOB_COPY RENAME COLUMN LOCATION TO LNAME;

--3_2) 테이블 명 변경 : ALTER TABLE 테이블명 RENAME 기존 테이블명 TO 바꿀 테이블명
ALTER TABLE JOB_COPY2 RENAME T JOB_COPY3;

/*
 * 3. DROP
 * 객체 삭제하기
 */
CREATE TABLE PARENT_TABLE(
	NO NUMBER PRIMARY KEY
);

CREATE TABLE CHILD_TABLE(
	NO NUMBER REFERENCES PARENT_TABLE
);

INSERT INTO PARENT_TABLE VALUES(1);
INSERT INTO CHILD_TABLE VALUES (1);

SELECT * FROM PARENT_TABLE;
SELECT * FROM CHILD_TABLE;

DROP TABLE PARENT_TABLE;
-- 1. 자식테이블을 DROP한 후 부모테이블을 DROP

--2. CASCADE CONSTRAINT

DROP TABLE PARENT_TABLE CASCADE CONSTRAINT;





















