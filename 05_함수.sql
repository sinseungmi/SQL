/*
    # dual 테이블
    - 연습용 테이블
    - 하나의 행만 가지고 있음
    -함수에 대한 쓰임을 알고 싶을때 특정 테이블을 생성할 필요없이 dual 테이블을 이용하여 함수의 값을 리턴(return)받을 수 있다.

*/
SELECT 3 * 2 FROM dual;   --DB에 연결이 살아있나 실행해보는 것
SELECT 1 FROM dual;


--ABS(n) : 절대값
SELECT ABS(-123) FROM dual;

-- FLOOR(d) :  내림
SELECT FLOOR(123.355) FROM dual;

-- ROUND(n) 반올림
SELECT ROUND(123.5555) FROM dual;
SELECT ROUND(123.5555, 31) FROM dual;


-- CEIL(n) : 올림
SELECT CEIL(123.111) FROM dual;

--MOD(n, m) : 나머지 연산
SELECT MOD(13,10) FROM dual;

-- TRUNC(value, m) : 지정한 자리 값 이하를 잘라낸다. TRUNC 함수는 주로 소수점 절사 및 날짜의 시간을 없앨 때 사용한다.
SELECT trunc(123.1234, 3) FROM dual;
SELECT trunc(123.1234, 2) FROM dual;
SELECT trunc(123.1234, 1) FROM dual;
SELECT trunc(123.1234, -1) FROM dual;
SELECT trunc(123.1234, -2) FROM dual;

-- 현재 시간을 구해주는 sysdate

SELECT sysdate FROM dual;

SELECT trunc(sysdate, 'YEAR') FROM dual;
SELECT trunc(sysdate, 'MONTH') FROM dual;
SELECT trunc(sysdate, 'DAY') FROM dual;

--TO_CHAR로 DATE타입 데이터를 원하는 포맷으로 변경하기
SELECT TO_CHAR(sysdate, 'YYYY/MM/DD HH24:MI:SS') FROM dual;
SELECT TO_CHAR(TRUNC(sysdate, 'YEAR'), 'YYYY/MM/DD HH24:MI:SS') FROM dual;
SELECT TO_CHAR(TRUNC(sysdate, 'MONTH'), 'YYYY/MM/DD HH24:MI:SS') FROM dual;
SELECT TO_CHAR(TRUNC(sysdate, 'DAY'), 'YYYY/MM/DD HH24:MI:SS') FROM dual;

SELECT LOWER('ABC') FROM dual;
SELECT UPPER('abc') FROM dual;

SELECT SUBSTR('Hello, world!!', 2, 5) FROM dual; -- 1 base (여기는 인덱스를 1부터 센다, 0부터도 가능)
SELECT SUBSTR('Hello, world!!', 5) FROM dual; -- 숫자를 하나만 적으면 적은 숫자부터 맨 뒤까지 자른다

-- 문자열 길이
SELECT LENGTH('of the people, by the people, for the people,') FROM dual; 


-- LPAD(원본, 길이, 채울문자)
-- RPAD(원본, 길이, 채울문자)
-- ※ 채울 문자가 공백인 경우 생략 가능
SELECT LPAD('title', 10, '#') FROM dual;
SELECT RPAD('title', 10, '#') FROM dual;
SELECT RPAD('title', 10) FROM dual;


-- LTRIM(원본, 제거할 문자)
-- RTRIM(원본, 제거할 문자)
-- ※ 제거할 문자가 공백인 경우 생략 가능
SELECT LTRIM('#####TITLE', '#') FROM dual;
SELECT RTRIM('#####TITLE#####', '#') FROM dual;

SELECT '     TITLE' FROM dual;
SELECT LTRIM('     TITLE') FROM dual;

-- TRIM() : 앞 뒤의 특정 문자를 제거한다
-- ※ 제거할 문자가 공백인 경우 생략 가능
SELECT TRIM('    title  ') FROM dual;
SELECT TRIM('#' FROM '#####title###') FROM dual;


--날짜 연산하기
SELECT
    sysdate -1 AS 어제,
    sysdate  AS 오늘,
     sysdate  +1 AS 내일,
      sysdate +2 AS "내일 모레" --띄어쓰기를 하기 위해선 ""를 해야함
FROM
    dual;

-- 날짜끼리 연산하면 두 날짜 사이의 시간을 구할 수 있다
SELECT last_name, FLOOR(sysdate - hire_date) AS 근무일 FROM employees;
    
-- MONTH_BETWEEN : 두 날짜 사이의 개월 수를 구한다.
SELECT last_name, FLOOR(MONTHS_BETWEEN(sysdate, hire_date)) AS 근무개월 FROM employees;

-- ADD_MONTHS(date, n) : DATE타입 데이터에 원하는 개월 수를 더한다
SELECT ADD_MONTHS(sysdate, 5) FROM dual;

--NEXT_DAY(date, 요일) : DATE타입 데이터를 기준으로 다음 요일을 찾는다
SELECT NEXT_DAY(sysdate, '화요일')FROM dual;
SELECT NEXT_DAY(sysdate, '화')FROM dual;

--LAST_DAY(date) : DATE타입 데이터를 기준으로 해당 달의 마지막 날짜를 반환한다
SELECT LAST_DAY(sysdate) FROM dual;

/*
    # 오라클의 날짜 포맷
     
     CC : 세기
     YYYY :  년도
     YY : 년도 (2자리)
     MM : 월
     MON : 월을 문자로
     DD :  날짜
     DAY : 요일
     DY :요일 (줄임)
     HH, HH12 : 12시
     HH24 : 24시
     MI : 분
     SS : 초
     AM, PM : 오전 오후 표시
     
     # 오라클의 숫자 포맷
     0 : 자릿수를 나타낸다. 숫가자 비면 0으로 채운다
     9 :  자릿수를 나타낸다. 숫자가 비면 빈칸으로 채운다
     L :  각 지역별 통화 기호를 붙인다
     . :  소수점을 출력한다
     , : 천 단위를 구분하는 쉼표를 출력한다
     

*/

-- TO_CHAR : 숫자를 문자로 바꾸거나, 날짜를 문자로 바꾼다. 바꿀 때 형식을 이용할 수 있어서 편리하다
SELECT TO_CHAR(sysdate, 'MON MM MI DY DD') FROM dual;
SELECT TO_CHAR(sysdate, 'CC YYYY MON DD DY HH24:MI:SS PM') FROM dual;

SELECT TO_CHAR(15000000, '999,999,999,999,999L') FROM dual;
SELECT TO_CHAR(15000000, '000,000,000,000,000L') FROM dual;

--TO_NUMBER : 문자를 숫자로 변환, 포맷을 이용해 다시 숫자로 변환할 수 있다
SELECT TO_NUMBER('15,000,000￦', '99,999,999L') FROM dual;
select to_char(1455644, '9999999.99') from dual;
select to_number('55.55555', '99.99999') from dual;





