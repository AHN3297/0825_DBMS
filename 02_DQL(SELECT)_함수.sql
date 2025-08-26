/* 
 *  함수 < Function >
 *  자바로 따지면 메소드
 * 	전달된 값을 가지고 계산된 결과를 반환해준다
 * 
 *  단일행 함수 : N개의 값을 읽어서 N 개의 결과를반환(매행마다 함수결과 반환
 *  그룹 함수(중요) : N개의 값을 읽어서 1개의 결과를 반환(그룹별로 함수결과반환
*/
SELECT 
       SALARY
     , LENGTH(SALARY)
     , SUM(SALARY)
  FROM 
       EMPLOYEE;
-- 단일행 함수와 그룹함수는 함께 사용할 수 없음 결과 행의 개수가 다르기 때문

--------------<단일행 함수>----------------------
/*
< 문자열과 관련된 함수 >
LENGTH / LENGTHB
STR  : 'A문자열' / 문자열이 들어가있는 컬럼

"equals".length(); <-얘랑 같음
- LENGTH(STR) : 전달된 문자열의 글자 수 반환
- LENGTHB(STR) : 전달된 문자열의 바이트 수 반환
결과는 NUMBER타입

한글 : 'ㄱ' , 'ㅏ', '강' => 한 글자당 3Byte
숫자, 영어, 특수문자 => 한글자당 1Byte
*/

SELECT
	   LENGTH('오라클!')
	 , LENGTHB('오라클!')
  FROM 
--       EMPLOYEE;
       DUAL; -- 가상 테이블(DUMMY TABLE)
       
       
SELECT
 	   EMAIL
 	 , LENGTH(EMAIL)
  FROM 
       EMPLOYEE;

/*
 * INSTR
 * 
 * - INSTR(STR) : 문자열로부터 특정 문자의 위치값 반환
 * - INSTR(STR, '특정 문자', 찾을 위치의 시작값, 순번
 * 
 * 결과값은 NUMBER타입으로 반환
 * 찾을 ㅟ치의 시작값과 순번은 생략이 가능
 * 
 * 찾을 우치의 시작값
 * 1 : 앞에서부터 찾겠다.(기본값)
 * -1 : 뒤에서부터 찾겠다.
 */

SELECT
	   INSTR('AABAACAABBAA', 'B')
  FROM
  	   DUAL;
SELECT 
       INSTR('AABAACAABBAA', 'B', -1)
       -- 뒤에서부터 첫 번째 'B'가 앞에서 부터 몇 번째인지
  FROM
       DUAL;

SELECT
	   INSTR('AABAACAABBAA', 'B', 1, 3)
	   -- 앞에서부터 세 번째 'B'가 앞에서부터 몇 번째인지 
  FROM
       DUAL;

SELECT 
	   INSTR(EMAIL, '@') "@의 위치"
  FROM
       EMPLOYEE;

---------------------------------------

/*
 * SUBSTR
 * 
 * - SUBSTR(STR, POSITION, LENGTH) : 문자열로부터 특전 문자열을 추출해서 반환
 * 
 * - STR : '문자열' 또는 문자타입 컬럼 값
 * - POSITUIN : 문자열추출 시작위치값(POSITION번째 문자부터 추출) -> 음수도 가능
 * - LENGTH : 추출할 문자개수(생략 시 끝까지라는 의미)
 */
SELECT 
	   SUBSTR('KH저오교육원', 3)
  FROM
       DUAL;

SELECT 
	   SUBSTR('KH정보교육원', 3, 2)
  FROM
       DUAL;

SELECT 
	   SUBSTR('KH정보교육원', -3, 2)
  FROM 
       DUAL; -- POSITION이 음수일 경우 뒤에서 N번째부터 추출하겠다 라는 의미 
        
-- EMPLOYEE 테이블로부터 사원명과 이메일컬럼과 EMAIL컬럼값 중 아이디값만 추출해서 조회
       
SELECT 
	   EMP_NAME
	 , EMAIL
	 , SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1) 
  FROM 
       EMPLOYEE;


SELECT
	   EMP_NAME
	 , SUBSTR (EMP_NO, 8, 1)
  FROM
  	   EMPLOYEE;
-- 남성사원들만 이름 조회
SELECT
       EMP_NAME
  FROM  
  	   EMPLOYEE
 WHERE
       SUBSTR(EMP_NO, 8, 1) = 1;

---------------------------------------------
/*
 * LPAD / RPAD
 * 
 * - LPAD / RPAD(STR, 최종적으로 반환할 문자의 길이(바이트), 패딩할 문자)
 * : 인자로 전달한 문자열에 임의의문자를 왼쪽 또는 오른쪽에 덧붙여서 ㅜ길이만큼의 문자열 반환
 * 
 * 결과값은 CHARACTER타입으로 반환
 * 덧붙이고자하는 문자는 생략 가능
 */

SELECT 
       EMAIL
  FROM 
       EMPLOYEE;

SELECT  
       LPAD(EMAIL, 25)
  FROM
       EMPLOYEE;

SELECT 
	   LPAD(EMAIL, 25, '!')
  FROM
       EMPLOYEE;

SELECT 
       RPAD(SUBSTR(EMP_NAME, 1, 1), 4, '*')
     , RPAD(SUBSTR(EMP_NO, 1, 8), 14 ,'*')
  FROM
       EMPLOYEE;
-------------------------------------------


/*
 * LTRIM / RTRIM
 * 
 * - LTRIM / RTRIM(STR, 제거하고자하는 문자
 * : 문자열의 왼쪽 또는 오른쪽에서 제거하고자하는 문자들을 찾아서 제거한 나머지 문자열을 반환
 * 
 * 결과값은 CHARACTER타입으로 반환
 * 
 */
SELECT 
	   LTRIM('		K	H')
  FROM  
       DUAL;

SELECT 
	   LTRIM('1234123KH123','123')
  FROM 
       DUAL;
---------------------------------------
/*
 * TRIM
 * 
 * - TRIM(BOTH / LENDING / TRAILRING '제거하고자하는문자' FROM STR
 *  : 문자열의 앞 / 뒤 / 양쪽에 있는 문자를 제거한 나머지 문자열을 반환
 * 
 * 결과값은 CHARACTER
 * BOTH / LEADING . TRAILRING은 생략 가능 참고로 생략 시 기본값은 BOTH
 */
SELECT 
       TRIM('	K	H	')	
  FROM 
       DUAL; --BOTH
       
SELECT
       TRIM(LEADING 'Z' FROM 'ZZZKHZZZ')
  FROM 
       DUAL;
SELECT 
       TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ')
  FROM
       DUAL;

-----------------------------------------

/*
 * OWER / UPPER / INITCAP
 * 
 * - LOWER(STR)
 * 다 소문자로변경
 * - UPPER(STR)
 * 다 대문자로 변경
 * 
 * INITCAP(STR)
 * 각 단어마다 앞글자만 변경
 * 
 * 결과값은 모두 CHARACTER타입으로 반환
 * 
 */


SELECT
	   LOWER('HELLO WORLD')
  FROM
	   DUAL;

SELECT 
	   UPPER('hello word')
  FROM
       DUAL;
SELECT 
	   INITCAP('hello word')
  FROM 
       DUAL;

------------------------------------

/*
 * CONCAT
 * 
 * - CONCAT(*STR1, STR2)
 * : 전달된 두 개의 인자를 하나로 합친결과를 반환
 * 
 * 반환타입은 CHARACTER
 */
SELECT CONCAT('경길련 하이텔', '정보교육원') FROM DUAL;

-----------------------------------
/*
 * REPLACE
 * 
 * - REPLACE(STR, 찾을문자, 바꿀문자)
 * :STR로부터 찾을문자를 찾아서 박꿀문자로 바꾼 문자열을 반환
 * 결과값은 CHARACTER타입
 * 
 */

SELECT
       REPLACE('서울시 중구 남대문로 120 대일 빌딩', '대일빌딩', '그레이츠 청계')
  FROM 
       DUAL;

SELECT  
       REPLACE(EMAIL, 'kh.or.kr','iei.co.kr')
  FROM
       EMPLOYEE;

----------------------------------------------------

/*
 * MOD
 * 
 * - MOD(NUMBER1, NUMBER2)
 * 나머지값
 * 
 */
SELECT 
       MOD(10,3)
     , MOD(-10, 3)
     , MOD(10.8, 3)
  FROM
       DUAL;

----------------------------
/*
 * ROUND
 * - ROUND(NUMBER, 위치) : 반올림 처리해주는함수
 * 
 * 위치 : 소수점 아래N번째 취치를 지정ㅇ할 수 있음
 * 생갹가능, 생략시 기본값은0
 * 
 */
SELECT 
       ROUND(123.456)
     , ROUND(123.456, 1)
     , ROUND(123.456, 2)
     , ROUND(123.456, -1)
     , ROUND(123.456, -2)
  FROM
       DUAL;
-------------------------------
/*
 * FLOOR
 * 
 * - FLOOR(NUMBER) 소수점 아래의 수를 무조건버림처리해주는 함수
 * 
 * CEIL
 * 
 * - CEIL(NUMBER) 소수점 아래의 수를 무조건 올림처리해주는 함수
 * 
 */

SELECT 
       FLOOR(123.45 *10 ) /10
  FROM 
       DUAL;
SELECT CEIL(123.456) FROM DUAL;


-- 각 직원별로 고용일로부터 오늘까지의 근무 일 수 조회 + 이름 조회
SELECT 
       EMP_NAME
     , CONCAT(FLOOR(SYSDATE - HIRE_DATE), '일')"근무일자"
  FROM
       EMPLOYEE
  WHERE
        FLOOR(SYSDATE - HIRE_DATE) > 365 *17;

---------------------------
/*
 *TRUNC
 *- TRUNC(NUMBER, 위치) : 위치지정이 가능한 절삭 처리 함수
 * 
 * 
 */

SELECT 
       TRUNC(123.456, 2)
  FROM
        DUAL;

------------------------------------
/*
 * 날짜 관련 함수
 * DATE 타입 : 년, 월, 일, 시, 분, 초를 모두 포함한 자료형
 * INITPSRANO <- 얘는 나중에
 * 
 * 
 */
SELECT 
       SYSDATE
     , SYSTIMESTAMP;
  FROM
       DUAL;


-- MONTHIS_BETWEEB(DATE1, DATE2)  두 날짜 사이의 개월 수 반환(NUMBER코드)
-- EMPLOYEE 테이블로부터 사원 사원명, 고용일로부터 근무 일수, 근무개월 수 조회

SELECT
       EMP_NAME
     ,FLOOR(SYSDATE - HIRE_DATE) || '일' AS "근무일수"
     ,FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) ||'개월'AS "개월수"
  FROM
       EMPLOYEE;
-- ADD_MONTHS(DATE,NUMBER) : 특정날짜에 해당 숫자만큼의 개울수를 더한 날짜

SELECT 
	   ADD_MONTHS(SYSDATE, 4)
  FROM
       DUAL;
----------------------------------
--NEXT_DAY(DATE, 요일) : 특정날짜에서 가장 가까운 요일을 찾아 그낭짜를 반환
SELECT 
	   NEXT_DAY(SYSDATE, '금요일')
	 , NEXT_DAY(SYSDATE, '금')
	 , NEXT_DAY(SYSDATE, 6) -- 1: 일요일...
 FROM
      DUAL;

-- 언어변경 ALTERSESSION SET NLS_LANGUAGE = AMERICAN; // KORIAN
-- LAST_DATE(DATE)날짜를 받아서 해당 날짜가 있는 달의 마지막 날짜를 반환
SELECT
  	   LAST_DAY(SYSDATE)
  FROM
       DUAL;
-----------------------------------
/*
 * - EXTRACT : 년도 또는 월 또는 일정보를 추출해서 반환(NUMBER타입)
 * - EXTRACT(YEAR FROM DATE) : 년도만 추출
 * - EXTRACT(MONTH FROM DATE) : 월만추출
 * - EXTRACT(DAY FROM DATE) : 일만추출
 * 
 */
-- EMPLOYEE테이블에서 사원명 입사년도 입사월 입사일

SELECT
       EMP_NAME
     , EXTRACT(YEAR FROM HIRE_DATE) AS"년도"
     , EXTRACT(MONTH FROM HIRE_DATE) AS "월"
     , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) "일"
  FROM
       EMPLOYEE
 ORDER
    BY
       "년도", "월", "일";


--------------------
/*
 * < 형변환>
 * 
 * NUMBER / DATE =>CHARACTER
 * 
 * - TO _CHAR(NUMBER/DATE, 포맷) : 숫자ㅣ 또는 날짜 데이터를 문자데이터타입으로 반환 
 */
SELECT
	   1234
	 , TO_CHAR(1234)
	 , TO_CHAR(1234, '000000') -- 자리수보다 큰공간을 0으로 채
	 , TO_CHAR(1234, '99999') -- 자리수보다 큰 공간을 공백문자로 채움
	 , TO_CHAR(1234, 'L00000') -- 설정된 나라(LOCAL)의 회폐단위 
	 , TO_CHAR(1234, '$99999') 
	 , TO_CHAR(12341234, 'ㅣ999,999,999,999')
  FROM
       DUAL;

--------------------------------------
--DATE(년월일시분초) => CHARACTER

SELECT
       SYSDATE
     , TO_CHAR(SYSDATE)
     , TO_CHAR(SYSDATE, 'YYYY-MM-DD')
     , TO_CHAR(SYSDATE, 'PM HH:MI:SS') --PM 오전 / 오후출력
     , TO_CHAR(SYSDATE, 'HH24:MI:SS') -- 24시간 표기혀요ㅣㅅ
     , TO_CHAR(SYSDATE, 'MON DY, YYYY')
  FROM
       DUAL;

---------------------------------------------------
--년도로 ㅆ끌 수 있는 포맷
SELECT
	   TO_CHAR(SYSDATE,'YYYY')
	 , TO_CHAR(SYSDATE, 'RRRR')
	 , TO_CHAR(TO_dATE('26-95', 'DD-YY'), 'YYYY')
	 , TO_CHAR(TO_DATE('26-95', 'DD-RR'), 'YYYY')
  FROM 
       DUAL;
--월에 쓸 수 있는포맷

SELECT
       TO_CHAR(SYSDATE,'MM')
     , TO_CHAR(SYSDATE,'MM')
     , TO_CHAR(SYSDATE,'MONTH')
     , TO_CHAR(SYSDATE,'RM')
  FROM
       DUAL;



--일에 쓸 ㅅ ㅜ있는포캣

SELECT 
       TO_CHAR(SYSDATE, 'DD')
     , TO_CHAR(SYSDATE, 'D')
     , TO_CHAR(SYSDATE, 'DDD')
  FROM
	   DUAL;

--DD : 한달기준
-- D : 일주일 기준(일요일부터)
--DDD : 일년 기준(1월1일부터) 

SELECT 
	   TO_CHAR(SYSDATE,'DAY')
	 , TO_CHAR(SYSDATE, 'DY')
  FROM
       DUAL;

SELECT 
       EMP_NAME
     ,TO_CHAR( HIRE_DATE, 'YYYY"년" MM"월" DD"일 (DY)')
  FROM
       EMPLOYEE;
-- 한글이 쓰고 싶다? " "로 묵어주어야한다.
--------------------------------
/*
 * NUMBER / CHARACTER => DATE
 * 
 * - TO_DATE(NUMBERM CHARACTER, 포맷) : 숫자/ 문자를 날짜로 변환(DATE로반환)
 * 
 */

SELECT
       TO_DATE(20250826)
     , TO_DATE('001212')
     , TO_DATE('980607', 'YYMMDD')
  FROM 
 	   DUAL;
----------------------------------------
/*
 * CHARACTER => NUMBER
 * 
 * -TO_NUMBER(CHARACTER, 포맷) : 문자를 숫자형으로 변환(NUMBER 로 반환)
 * 
 */

SELECT
	   TO_NUMBER('01234')
  FROM
       DUAL;

SELECT
	   '1234' + '456'
  FROM 
       DUAL;

SELECT 
       '11,000' + '20,000'
  FROM 
       DUAL; -- 이건 불가능
       
SELECT 
	   TO_NUMBER('44,000', '99,999') + TO_NUMBER('20,000',  '99,999')
  FROM DUAL;
     
	   
----------------------------------------
/*
 * < NULL 처리 함수 >
 * 
 * NVL( 컬럼명, 해당 컬럼값이NULKL값일 경우 반환할 결과값)
 * 
 */
-- EMPLOYEE 테이블로 부터 사원명, 보너스
SELECT 	
       EMP_NAME
     , BONUS
     , NVL(BONUS, 0)
  FROM
	   EMPLOYEE;

-- 보너스 포함 연봉 조회
SELECT
	   EMP_NAME
	 , (SALARY + SALARY * NVL(BONUS,0)) *12
	 ,NVL(DEPT_CODE,'부서 없음')
  FROM
       EMPLOYEE;
	   
	   
-- NVL2(컬럼명, 결과값1, 결과값2)
-- 해당 컬럼에 값이 존재할 경우 결과값 1을 반환
-- 햐덩 콜롬에 값이 NULL값일 경우 결과값 2를 반환

SELECT 
       EMP_NAME
     , DEPT_CODE
     , NVL2(DEPT_CODE, '부서 배치 완료', '부서없음')
  FROM
       EMPLOYEE;


--NUKKIF(비교대상1, 비교대상2)
-- 두 개의 값이 동일할 ㅅ경우 NULL을 반환
 -- 두 개의 값이 동일하지 않을 경우 비교대상1을 반환
SELECT
	   NULLIF('1', '2')
  FROM 
       DUAL;
-----------------------------------
/*
 * < 선택함수>
 * 
 * DECODE(비교대상(컬럼명/ 산술연산/ 함수식), 조건값1, 결과값1, 조건값2, 결과값3....결과값)
 * - 자바에서의 SWITCH문과 유사
 *  switch(비교대상){
 *  case 조건값1 : 결과값1;
 *  case 조건값2 : 결과값2;
 *  default : 결과값
 * } 
 */

-- EMPLOYEE 테이블 사원명, 성별
SELECT
       EMP_NAME
     , DECODE(SUBSTR(EMP_NO, 8, 1)
              1, '남성',
              2, '여성',
              '성별 선택 안함') AS "성별"
  FROM
       EMPLOYEE;

--직원들의 급여를 ㅇ니상시켜서 조회
-- 직급코드(JOB_CODE)가 'J7'인사원들의 급여는 15%인상해서 조회
-- 직급코드가 'J6'인 사원들의 급여는 20%인상
-- 직급코드가 'J5'인사원들의 급여는 30% 인상
-- 나머지 직급인 사원들의 급여는 5%인상

SELECT
       EMP_NAME
     , SALARY
     , JOB_CODE
     , DECODE(JOB_CODE, 'J7', (SALARY + SALARY * 0.15)
                      , 'J6', (SALARY + SALARY * 0.2)
                      , 'J5', (SALARY + SALARY * 0.3)
                      , (SALARY + SALARY * 0.05))"인상 수 급여"
  FROM
       EMPLOYEE;
	   
-----------------------------------------------
/*
 * CASE WHEN THEN 구문
 * 
 * - DECODE랑 비교했을 때 DECODE는 동등비교만 수행
 * 	 CASE WHEN RHEN 다양한 조건식을 기술 가능
 * 
 * [ 표현법 ]
 * CASE
 *      WHEN 조건식1 THEN 결과값1
 *      WHEN 조건식2 THEN 결과값2
 * 		...
 * 		ELSE 결과값
 * END
 * 
 */

SELECT 
       EMP_NAME
     , CASE
	     WHEN SUBSTR(EMP_NO, 8, 1) = '1' THEN '남성'
	     WHEN SUBSTR(EMP_NO, 8, 1) = '2' THEN '여성'
	     ELSE '성별선택안함'
       END "성별"
  FROM 
       EMPLOYEE;
     



-----------------------------------------------
-------------------<***그룹합수***>--------------------

/*
 * N개의 값을 읽어서 1개의 결과를 반환(하나의 그룹별로 함수 실행 결과를 반환)
 * 
 */
SELECT
       SALARY
  FROM
       EMPLOYEE;
-- 1. SUM(숫자타입) : 해당 컬럼값들의 총 합계를 반환해주는 함수
-- 전체 사원의총 급여합계

SELECT 
       SUM(SALARY)
  FROM 
       EMPLOYEE;


SELECT
       SUM(SALARY)
  FROM
       EMPLOYEE;
WHERE EMAIL LIKE %0%


----------------------------------------------
--2. AVG(숫자타입) : 해당 컬럼값들의 평균값을 구해서 반환
-- 전체사원들의 급여 평균 구하기
SELECT  
       ROUN(AVG(SALARY))
  FROM 
       EMPLOYEE;
--3. MIN (ANY) : 해당 컬럼값들 중 작은 갑 반환
SELECT 
       MIN(SALARY) " WPDLF WKRDSM RMQDU"
     , MIN(EMP_NAME ) " 제일 이름이 빠른사람"
       
  FROM
       EMPLOYEE;

-- 4. MAX(ANY) : 해당 컬럼값들 중 가장 큰 값 반환
  
  SELECT 
  	     MAX(SALARY)"가장 높은 급여"
  	   , MAX(EMP_NAME) " 가장 느린 이름"
  	   , MAX(HIRE_DATE) " 가장 느린입사일"
    FROM
         EMPLOYEE;
  
  
  -- 5. COUNT(*/ 컬럼명 / DISTINCT 컬럼명) : GOD ROTN TPTJ QKSGHKS
 SELECT * FROM EMPLOYEE;
 SELECT 
        COUNT(*)
   FROM
        EMPLOYEE;
  
  
  -- 보너스를 받는 사원의 수
  -- COUNT(컬럼명) : 제시한 컬럼값이 NULL이 아닌 행만 개수르 세서 반환
  SELECT 
  	     COUNT(BONUS)
    FROM 
         EMPLOYEE;
  
  SELECT
         COUNT(*)
    FROM
         EMPLOYEE;
   WHERE
         BONUS IS NOT NULL;
  
  
  -- 현재 사원들이 속해있는 부서 개수
  -- COUNT(DISTINCT 컬럼명) : 제시한 해당 컬럼값이 중복값이 존재할 경우 하나롬나 세서반환
  
  SELECT
         COUNT(DISTINCT DEPT_CODE)
    FROM    
         EMPLOYEE;
       
  
  
  
  
  
  
  
  
  
  
  
  
  