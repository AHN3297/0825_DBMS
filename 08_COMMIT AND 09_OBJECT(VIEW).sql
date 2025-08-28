/*
	< TCL :TRANSACTION CONTROL LANGUAGE >
	       트랜잭션	   제어	   언어
	       
	       ⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐
	       ⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐
	       ⭐⭐⭐⭐⭐⭐⭐⭐⭐중요함⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐
	       ⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐
	       ⭐⭐⭐⭐⭐⭐⭐⭐생각이 필요한 개념⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐
	       
	* TRANSACTION
	- 작업단위
	- 데이터베이스의 상태를 변화시키는 논리적 연산단위
	- 여러개의 DML구문을 하나로 묶어 처리하는 매커니즘
	- 데이터의 변경사항(DML)들을 하나의 트랜잭션으로 묶어서 관리
	  COMMIT(확정)하기 전까지의 변동하상들을하나의 트랜잭션에 담게됨
	- 트랜잭션의 대상이 되는 SQL : INSERT, UPDATE, DELETE
	
	COMMIT(트랜잭션을 종료 처리 후 확정), ROLLBACK(트랜잭션 취소), SAVEPOINT
	
	* TRANSACTION의 4가지 속성
	ACID
	1. Atomicity(원자성) : 트랜잭션 내의 모든 작업은 전부 수행되거나,
						  전혀 수행되지 않아야한다. 라는 원칙
	2. Consistency(일관성) : 트랜잭션이 성공적으로 완료된 후에도,
						    데이터베이스는 유효한 상태를 유지해야한다는 원칙
	3. Isolation(고립성) : 동시에 실행되는 여러트랜잭션이 상호간에 영향을 끼치지
						 않도록 하는 원칙
	4. Durablity(지속성) : 트랜잭션이 성공적으로 수행되었다면,
	                      시스템에 문제가 발생하더라고 영구적으로 반영이 되어야한다.
*/
CREATE TABLE EMP_COPY
	AS SELECT EMP_ID, EMP_NAME FROM EMPLOYEE;

SELECT * FROM EMP_COPY;


DELETE 
  FROM 
       EMP_COPY
 WHERE
       EMP_ID = 900;

-- 사번이 222번인사람 삭제
DELETE
  FROM
       EMP_COPY
 WHERE
       EMP_ID = 222;
ROLLBACK;

SELECT * FROM EMP_COPY;

DELETE FROM EMP_COPY WHERE EMP_ID = 900; --트랜잭션 생성

UPDATE EMP_COPY SET EMP_NAME = '고길동' WHERE EMP_NAME = '홍길동';


SELECT * FROM EMP_COPY;

COMMIT;
ROLLBACK;
----------------------------------------------------------
-- 사번이 214, 216ㅇ번인사원 삭제
DELETE 
  FROM
       EMP_COPY
 WHERE
       EMP_ID IN (214,216);

-- 2개 행이 삭제된 시점에 SAVEPOINT 지정
SAVEPOINT DELETE2ROWS;

SELECT * FROM EMP_COPY;

DELETE 
  FROM 
       EMP_COPY
 WHERE
       EMP_ID = 222;

ROLLBACK TO DELETE2ROWS; -- 세이브 포인트

SELECT * FROM EMP_COPY;

ROLLBACK;
------------------------------------------------


COMMIT;
DELETE FROM EMP_COPY WHERE EMP_ID = 222;
SELECT * FROM EMP_COPY;
CREATE TABLE HAHA(
	HID NUMBER
);

ROLLBACK;

/*
 * DDL 구문(CREATE, ALTER, DROP)을 수행하는 순간
 * 트랜잭션에 있는 모든 작업사항을 무조건 COMMIT해서 실제 DB에 반영 한 후 DDL을 수행
 * --> DDL을 써야하는데 이전 DDL이 존재한다 ==> COMMIT / RPPLBACK 수정후 처리
 * 
 * 
 * 
 * 
 */

-- Quiz --

SELECT  
	   NATIONAL_NAME  	--NATIONAL
	 , EMP_NAME			--EMPLOYEE
	 , EMP_ID			-- =
	 , DEPT_TITLE 	 	--DEPARTMENT
	 , JOB_NAME			--JOBNAME
  FROM
	   EMPLOYEE
  JOIN
  	   DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  JOIN
       JOB USING (JOB_CODE)
  JOIN
       LOCATION ON (LOCATION_ID = LOCAL_CODE)
  JOIN
       NATIONAL USING(NATIONAL_CODE)
 WHERE
       NATIONAL_NAME = '한국';

/*
 * < VIEW 뷰 > --> 논리적인 가상테이블
 * 
 * SELECT문 저장
 * 
 * 1. VIEW 생성
 * 
 * [ 표현법 ]
 * CREEATE VIEW 뷰이름
 * 		AS 서브쿼리;
 */
CREATE OR REPLACE VIEW VW_EMPLOYEE
 	AS SELECT  
	   		  NATIONAL_NAME  	--NATIONAL
	 		, EMP_NAME			--EMPLOYEE
	 		, EMP_ID			-- =
	 		, DEPT_TITLE 	 	--DEPARTMENT
	 		, JOB_NAME			--JOBNAME
  		 FROM
	   		  EMPLOYEE
  		 JOIN
  	   		  DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  		 JOIN
       		  JOB USING (JOB_CODE)
  		 JOIN
       		  LOCATION ON (LOCATION_ID = LOCAL_CODE)
  		 JOIN
       		  NATIONAL USING(NATIONAL_CODE);

SELECT * FROM VW_EMPLOYEE;

-- 한국에서 근무하는 사원

SELECT 
       *
  FROM 
       VW_EMPLOYEE
 WHERE 
       NATIONAL_NAME ='한국';

SELECT 
       *
  FROM 
       VW_EMPLOYEE
 WHERE 
       NATIONAL_NAME ='일본';

-- 뷰의 장점 : 쿼리문이 엄청긴게 필요할 때 그때그때 작성하면 힘들다
--			 딱 한번 뷰로 만들어주면 그때부터는 뷰를 사용해서 간다하게 조회할 수 있음


SELECT * FROM USER_VIEWS;

-- 뷰는 논리적인 가상테이블 => 실질적으로 데이터를 저장하고 있지않음
--						  (쿼리문을 TEXT 형태로 저장해놓음)
-------------------------------------------------
/*
 * CREATE OR REPLACE CIEW 뷰이름
 * 		AS 서브쿼리;
 * 
 * 뷰 생성 시 기존에 중복된 이름의 뷰가 존재한다면 갱신(변경)해주고
 * 없다면 새로운 뷰를 생성해줌
 */
-- 사원의 사원명, 연봉, 근무년 스를 조회할 수 있는 SELECT문 정의
SELECT 
       EMP_NAME
     , SALARY * 12
     , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
  FROM
      EMPLOYEE;

CREATE OR REPLACE VIEW VW_EMP
 	AS(SELECT
 	          EMP_NAME
 	        , SALARY *12 AS "연봉"
            , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) "근무년수"
         FROM
              EMPLOYEE);
/*
 * 뷰생성 시 SELECT절에 함수 또는 산술 연산식이 기술되어있는 경우 뷰 생성이 불가능하니까
 * 반드시 별칭을 지정해주아야함
 */

SELECT * FROM VW_EMP;

-- 별칭부여 방법 두 번째
CREATE OR REPLACE VIEW VW_EMP(사원명, 연봉, 근무년수)
 	AS(SELECT
 	          EMP_NAME
 	        , SALARY *12 
            , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 
         FROM
              EMPLOYEE);
---------------------------------------------------------------------------------






