/*

    # SELECT 컬럼명 FROM 테이블명;
    - 데이터를 조회하는 쿼리문
    - 컬럼명에 *를 쓰는 것은 모든 컬럼을 뜻한다.
    - 컬럼명/테이블명은 대소문자를 구분하지 않는다
    - 쿼리문도 대소문자를 구분하지않는다
    - 데이터는 대소문자를 구분한다(중요!)


*/

-- tab, tabs로 어떤 테이블들이 있는지 확인할 수 있다
SELECT * FROM tab;
SELECT * FROM tabs;
SELECT table_name FROM tabs;

-- *를 적으면 모든 컬럼을 조회하고, 컬럼명을 적으면 해당 컬럼만 조회한다
SELECT * FROM employees;
SELECT first_name FROM employees;
SELECT first_name, salary FROM employees;

/*
    # 연습용 테이블 설명
    EMPLOYEES :  사원 정보를 저장한 테이블
    DEPARTMENTS : 부서 정보를 저장한 테이블
    JOBS : 직급 정보를 저장한 테이블
    LOCATIONS : 지역 정보를 저장한 테이블
    COUNTRIES : 국가 정보를 저장한 테이블
    REGIONS : 대륙 정보를 저장한 테이블

*/

SELECT * FROM departments;
SELECT * FROM locations;
SELECT * FROM jobs;
SELECT * FROM countries;
SELECT * FROM regions;

--테이블 컬럼 정보 보기
--  DESC : 특정 테이블에 어떤 칼럼이 있는지 구조가 무엇인지 조회하는 명령어
DESC employees;
DESC departments;
DESC countries;
DESC jobs;
DESC regions;

/*
        # NUMBER(n), NUMBER(n,m)
        - 숫자 데이터만 저장할 수 있는 컬럼
        - 숫자가 하나만 적혀있으면 정수를 저장, 숫자가 두개 적혀 있으면 실수를 저장
        - NUMBER(10) : 10 자리 정수를 저장하는 컬럼이 된다
        - NUMBER(10,4) : 6자리 정수와 소수점 4자리를 저장하는 컬럼이 된다
        
        # VARCHAR2(n)
        - 가변 길이 문자 데이터를 저장하는 컬럼 타입
        -  저장되는 데이터의 크기에 따라 알맞은 공간만 사용한다
        -  VARCHAR2(10)으로 설정된 컬럼의 데이터로 2글자가 들어오면 2바이트만 사용한다
        - 가변적인 데이터를 저장할 때는 데이터가 절약되자만 크기 계산이 필요하다
        
        # CHAR(n)
        - 고정 길이 문자 데이터를 저장하는 컬럼 타입
        - 설정된 길이 보다 적은 양의 데이터가 들어오더라도 설정된 길이를 모두 차지한다
        - CHAR(10)으로 설정된 컬럼의 데이터로 2글자가 들어오면 10 바이트를 모두 사용한다
        - 데이터가 낭비될 수는 있지만 크기 계산이 없기 때문에 속도가 더 빠르다
          * 가변적인 데이터는 바차, 고정적인 데이터는 캐릭터가 좋음
          
        # DATE
        - 날짜 및 시간을 저장하는 컬럼 타입

*/

SELECT * FROM countries;

-- 연습1: 모든 사원의 사원번호/이름(firstname)/월급/부서번호를 조회해보세요

desc employees;

SELECT employee_id as 사원번호, first_name as 이름, salary as 월급, department_id as 부서번호
FROM employees;


SELECT EMPLOYEE_ID,FIRST_NAME,SALARY,DEPARTMENT_ID FROM EMPLOYEES;

-- AS를 이용해 원하는 컬럼명으로 조회할 수 있다
SELECT EMPLOYEE_ID AS 사원번호,
            FIRST_NAME AS 이름 ,
            SALARY AS 월급,
            DEPARTMENT_ID AS 부서번호
FROM 
            EMPLOYEES;

-- 산술 연산자를 이용해 계산된 값 출력하기
SELECT last_name, salary FROM employees;
SELECT last_name, salary + 500 FROM employees;
SELECT last_name, salary * 2 FROM employees;
SELECT last_name, salary * 0.9 AS 삭감된월급 FROM employees;

SELECT * FROM employees;
                                            --보너스
SELECT last_name, salary, commission_pct FROM employees;
SELECT last_name, salary * (1 + commission_pct) as "보너스 월급" FROM employees;
                                        --1을 더하는 이유는 월급이랑 보너스 같이 합한 값을 조회하기 위해
                                        --0.4는 40프로
                                        
-- 빈 문자열( '' )은 NULL로 인식
-- null은 계산이 안되기 때문에 대체 값이 필요하다
-- NVL(컬럼명, 대체값) : 해당 컬럼에서 Null값이 나왔을 때 대체 값을 사용한다
SELECT last_name, salary * (1 +NVL( commission_pct, 0)) AS 보너스적용후 FROM employees;

-- 연습2 : 모든 사원들의 사번/가족이름/연봉을 출력해보세요(salary는 월급입니다. 별칭 사용할 것)
select employee_id as 사원번호, last_name as 가족이름 , salary * 12 as 연봉, salary * 11 + (salary * (1 + nvl(commission_pct, 0))) as 보너스연봉 from employees;

SELECT employee_id AS 사원번호, 
            last_name AS 가족이름, 
            job_id,
            salary * 12  * (1 +NVL( commission_pct, 0)) AS 연봉, 
            salary * 11 + (salary * (1 +NVL( commission_pct, 0))) AS 보너스적용후  
FROM 
            employees;

--SELECT DISTINCT : 중복 되는 내용이 여러개 있어도 한번만 출력된다

--employees에 존재하는 모든 직책을 보고 싶은 경우
SELECT DISTINCT job_id FROM employees;
SELECT DISTINCT department_id FROM employees;
SELECT DISTINCT manager_id FROM employees;

SELECT DISTINCT
    last_name
FROM
    employees;



