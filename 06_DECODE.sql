/*
    # DECODE
    
      - 특정 컬럼의 값을 통해 표시할 데이터를 선택한다
      DECODE 함수는 프로그래밍에서의  if else 와 비슷한 기능을 수행한다.
    예) DECODE(컬럼, 조건1, 결과1, 조건2, 결과2, 조건3, 결과3..........) 
      - switch case 같은 역할을 한다
*/
SELECT * FROM employees;

SELECT
    last_name,
    department_id,
    DECODE(department_id, 
        90, 'Executive',
        100, 'Finance',
        60, '바보',
        30, 3 + 5,
        '안녕'
    ) AS department_name
FROM
    employees;
    
/*
    연습1 : 직급에 따라 급여를 다르게 인상하여 출력해보세요 
    
        IT_PROG : 15% 인상
        FI_ACCOUNT : 10% 인상
        모든 종류의 CLERK : 5% 인상
        
    원래의 급여는 before_slary로, 인상된 급여는 after_salary로 이름과 함께 출력
*/

select job_id, salary as before_slary, nvl(decode(job_id,'IT_PROG',salary * 1.15, 'FI_ACCOUNT', salary * 1.1), salary) as after_salary  
from employees where job_id not like '%CLERK%'
union
select job_id, salary as before_slary, salary * 1.05 as after_salary from employees where job_id like '%CLERK%';

select DISTINCT job_id FROM employees;

SELECT * FROM employees;

SELECT  job_id, salary AS before_salary, salary * 1.15 AS after_salary FROM employees WHERE job_id = 'IT_PROG'
UNION
SELECT  job_id, salary AS before_salary, salary * 1.1 AS after_salary FROM employees WHERE job_id = 'FI_ACCOUNT'
UNION 
SELECT  job_id, salary AS before_salary, salary * 1.05 AS after_salary FROM employees WHERE job_id LIKE '___CLERK';

/*
    # DECODE는 해당 컬럼의 값과 정확하게 일치하는 값만 이용할 수 있지만
    CASE문은 조건을 사용할 수 있다

*/
SELECT DISTINCT job_id FROM employees WHERE job_id LIKE '%CLERK%';

SELECT
    last_name,
    job_id,
    salary AS before_salary,
    nvl (
        decode(
            job_id,
            'IT_PROG', salary * 1.15, 
            'FI_ACCOUNT', salary * 1.1,
            'PU_CLERK',salary * 1.05,
             'ST_CLERK', salary * 1.05,
             'SH_CLERK',salary * 1.05
             ),
             salary
             )AS after_salary
FROM
        employees;
        
SELECT
    last_name,
    job_id,
    salary        AS before_salary,
    nvl(decode(job_id, 'IT_PROG', salary * 1.15, 'FI_ACCOUNT', salary * 1.1), salary)             AS ater_salary
FROM
    employees
WHERE
    job_id NOT LIKE '%CLERK%'
UNION
SELECT
    last_name,
    job_id,
    salary           AS before_salary,
    salary * 1.05   AS after_salary
FROM
    employees
WHERE
    job_id LIKE '%CLERK%';


/*
    # DECODE는 해당 컬럼의 값과 정확하게 일치하는 값만 이용할 수 있지만
        CASE문은 조건을 사용할 수 있다.
        CASE 표현식에서 ELSE 부분은 생략이 가능하며, 만족하는 조건이 없으면 NULL을 리턴한다.
        DECODE 함수를 대체할 수 있는 기능이 CASE 표현식이며 가독성이 좋고 더 많은 기능을 제공한다. 
*/
SELECT
    last_name,
    job_id,
    salary  AS before_salary,
    CASE
        WHEN job_id = 'IT_PROG'     THEN
            salary * 1.15
        WHEN job_id = 'FI_ACCOUNT'  THEN
            salary * 1.1
        WHEN job_id LIKE '%CLERK%' THEN
            salary * 1.05
        ELSE
            salary
    END     AS ater_salary
FROM
    employees;




