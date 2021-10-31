/*

# SELECT 컬럼명 FROM 테이블명 WHERE 조건절;

    SELECT문에 WHERE절을 추가하여 해당 조건을 만족하는 데이터만 조회할 수 있다

*/

--월급이 15000달러 이상인 사원들만 조회하기

desc employees;
SELECT
    *
FROM employees;
SELECT
    *
FROM
    employees
WHERE
    salary >= 15000;

/*
    # 오라클의 비교 연산자들
    = : 같다
    <, >, <=, >= : 비교
    != , <>, ^= : 다르다
*/

SELECT
    *
FROM
    employees
WHERE
    salary = 17000;

SELECT
    *
FROM
    employees
WHERE
    salary != 17000;

--오라클의 문자열 리터럴은 ''만 사용한다
SELECT
    *
FROM
    employees
WHERE
    first_name = 'Sarah';

SELECT
    *
FROM
    employees
WHERE
    last_name = 'Smith';

--날짜 타입도 가볍게 비교가 가능하다
SELECT
    *
FROM
    employees
WHERE
    hire_date < '2004/01/01';

SELECT
    *
FROM
    employees
WHERE
    hire_date < '2005/01/01';

SELECT
    *
FROM
    employees
WHERE
    hire_date < '2006/01/01';

SELECT
    *
FROM
    employees
WHERE
    hire_date < '2007/01/01';

--and, or, not
SELECT
    *
FROM
    employees
WHERE
        hire_date >= '2005/01/01'
    AND hire_date < '2007/01/01';

SELECT
    *
FROM
    employees
WHERE
    job_id = 'IT_PROG'
    OR job_id = 'ST_CLERK';

/*
    연습1: 2000에서 3000사이의 월급을 받는 사원들의 모든 정보를 조회하세요
    
    연습2: 부서번호가 30번이거나 60번이거나 90번인 사원들의 
            이름/직책/전화번호/부서번호를 조회하세요
*/


SELECT * FROM employees WHERE salary >= 2000 AND salary <= 3000;

SELECT first_name, job_id, phone_number, department_id FROM employees WHERE department_id = 30 OR department_id = 60 OR department_id = 90;

SELECT
    *
FROM
    employees
WHERE
        salary >= 2000
    AND salary <= 3000;

SELECT
    first_name,
    job_id,
    phone_number,
    department_id
FROM
    employees
WHERE
    department_id = 30
    OR department_id = 90
    OR department_id = 60;
    
--사번이 짝수인 사원만 조회해보기
--MOD()를 통해 나머지 연산을 할 수 있다. %는 못함, MOD()는 나누기를 해서 나머지 값을 구하는 것

SELECT * FROM employees WHERE mod(employee_id,2) = 0;


SELECT
    *
FROM
    employees
WHERE
    mod(employee_id, 2) = 0;    
    
--COLUMN BETWEEN A AND B : 해당 컬럼 값이 A이상 B이하인 경우 true

SELECT
    *
FROM
    employees
WHERE
    salary BETWEEN 2000 AND 3000;
    
select * from employees where employee_id BETWEEN 150 AND 200;  
    

--COLUMN IN (A,B,C ...) : ()안에 내용에 값이 존재하는 경우 true
SELECT
    *
FROM
    employees
WHERE
    NOT department_id IN ( 30, 60, 90 );
    
SELECT
    *
FROM
    employees
WHERE
    job_id NOT IN ( 'IT_PROG', 'AD_VP' );
    

--커미션 퍼센트가 null인 사원을 모두 조회해보기
SELECT
    *
FROM
    employees
WHERE
    commission_pct = NULL; --아무것도 안나옴
    
select * from employees where commission_pct IS NOT NULL;
    
-- 값이 NULL인 조건을 만들때는 =NULL이 아니라 IS NULL을 사용해야한다 (NULL은 크기 비교가 불가능)
SELECT
    *
FROM
    employees
WHERE
    commission_pct IS NULL;
    
-- NOT은 위치가 비교적 자유롭다
SELECT
    *
FROM
    employees
WHERE
    department_id NOT IN ( 30, 60, 90 );

SELECT
    *
FROM
    employees
WHERE
    NOT department_id IN ( 30, 60, 90 );

SELECT
    *
FROM
    employees
WHERE
    commission_pct IS NOT NULL;

SELECT
    *
FROM
    employees
WHERE
    NOT commission_pct IS NULL;

SELECT
    *
FROM
    employees
WHERE
    salary NOT BETWEEN 2000 AND 3000;

SELECT
    *
FROM
    employees
WHERE
    NOT salary BETWEEN 2000 AND 3000;
    
    
/*
    # LIKE
    - 데이터의 일부분으로 원하는 내용을 검색할 수 있다
    - 문자타입과 날짜 타입에 사용할 수 있다
    -% : 길이 제한 없이 아무 문자열이나 와도 되는 와일드 카드 (심지어 없는 것도 가능)
    - _: 하나의 문자가 반드시 와야하는 와일드 카드

*/

-- 이름이 J로 시작하는 모든 사원을 조회
SELECT
    first_name
FROM
    employees
WHERE
    first_name LIKE 'J%';

-- 이름의 두번째 글자가 u인 모든 사원을 조회
SELECT
    first_name
FROM
    employees
WHERE
    first_name LIKE '_u%';

-- 이름의 세번째 글자가 e인 모든 사원을 조회
SELECT
    first_name
FROM
    employees
WHERE
    first_name LIKE '__e%';

-- 이름에 x가 포함되어 있는 모든 사원을 조회
SELECT
    first_name
FROM
    employees
WHERE
    first_name LIKE '%x%';

/*
    연습1 : 이름의 뒤에서 세번째 글자가 a인 모든 사원을 조회해보세요
    
    연습2 : 이름에 e가 두개 이상 포함된 모든 사원을 조회해보세요
    
    연습3 : 이름이 다섯글자이면서 a로 끝나는 모든 사원을 조회해보세요
*/


select first_name from employees where first_name like '_i%e%';

SELECT
    *
FROM
    employees
WHERE
    first_name LIKE '%a__';

SELECT
    *
FROM
    employees
WHERE
    first_name LIKE '%e%e%';

SELECT
    *
FROM
    employees
WHERE
    first_name LIKE '____a';