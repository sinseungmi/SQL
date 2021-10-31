/*
    # 그룹 함수

      - 여러 행의 값을 특정 컬럼을 기준으로 그룹화 하는 함수들
      - 특정 집단의 총합, 개수, 평균 등을 구할 수 있다
      - 그룹의 기준이 되는 컬럼은 GROUP BY절을 통해 선택한다 
      - 그룹 함수의 결과는 일반 컬럼과 함께 출력될 수 없다.하지만 그룹의 기준이 되는 컬럼은 출력이 가능하다
      
      
      그룹에 대한 조건은 where 절이 아닌, having 절에 사용해야 합니다. 
      avg(height)는 group by 절이 수행된 이후에 수행해야하므로, where 절에 사용할 수 없는 것이죠.
      where 절 -> group by 절 -> having 절 이 순서로 동작

*/
SELECT SUM(salary) FROM employees;

-- 직책별 총 월급
SELECT job_id, SUM(salary) FROM employees GROUP BY job_id;   --그룹의 기준이 되는 job_id는 함께 출력 가능

-- 직책별 평균 월급
SELECT job_id, AVG(salary) FROM employees GROUP BY job_id;

-- SUM(column) : 그룹 별로 해당 컬럼의 총 합을 구한다
SELECT department_id, sum(salary) FROM employees GROUP BY department_id;

-- AVG(column) : 평균
-- MAX(column) : 최대값
SELECT department_id, max(salary) FROM employees GROUP BY department_id;

-- MIN(column) : 최소값
-- COUNT(column) : 개수
-- COUNT(*) - 조회된 전체행 건수를 반환한다
SELECT department_id, COUNT(*) FROM employees GROUP BY department_id;


-- 연습1: 부서별로 가장 최근에 사원이 입사한 날짜와 가장 오래전에 입사한 날짜를 출력해주는 쿼리문을 작성

select department_id,to_char(min(hire_date), 'YYYY/MM/DD') as 오래전에입사,
to_char(max(hire_date), 'YYYY/MM/DD')  as 최근입사 
from employees group by department_id;

SELECT
    department_id,
    MAX(hire_date) AS "가장 최근",
    MIN(hire_date) AS "가장 오래된 인간"
FROM
    employees
GROUP BY
    department_id;

-- 연습2: 보너스를 받는 사원이 각 부서에 몇 명 있는지 세어보는 쿼리문을 작성

select department_id, count(*) from employees where COMMISSION_PCT is not null group by department_id;

SELECT
    department_id,
    COUNT(commission_pct)  --null은 안세서 0.
FROM
    employees
GROUP BY
    department_id;

-- 연습3: 각 직급별 평균 연봉을 구해보세요 (※ 월급 아님, 커미션 적용, 소수점 둘째 자리까지 출력)

select job_id, to_char(avg(salary * 11 + (salary * (1 + nvl(commission_pct, 0)))), '999999999.99') as 평균연봉 from employees group by job_id;

SELECT
    job_id,
    SUM(salary * 12 *(1 + nvl(commission_pct, 0))) / COUNT(*) AS "JOB별 평균 연봉"
FROM
    employees
GROUP BY
    job_id;

-- GROUP BY에 여러 컬럼을 설정할 수도 있다
SELECT
    job_id, department_id,
    TO_CHAR(AVG(salary * 12 *(1 + nvl(commission_pct, 0))), '999999999.99') AS "JOB별 평균 연봉"
FROM
    employees
GROUP BY
    job_id, department_id;

/*
    - GROUP BY로 나눠진 그룹에 조건을 주고 싶을 때는 HAVING절을 이용한다
    - WHERE 절에서는 집계함수를 사용 할 수 없다.(avg(), sum() 같은 것)
    - HAVING 절은 집계함수를 가지고 조건비교를 할 때 사용한다.
     
      
      "group by 절의 결과를 토대로 조건을 걸고 싶을 때, having을 사용한다" 라고 생각하고,
     모든 조건을 having 절에 사용하면 안된다는거죠!
     
     */
SELECT job_id, count(*) FROM employees GROUP BY job_id;

-- ※ WHERE는 그룹이 생성되기 전에 모든 행에 적용되는 조건이다
SELECT job_id, count(*) FROM employees WHERE salary <= 5000 GROUP BY job_id;
select job_id,salary, count(*) from employees group by job_id,salary having min(salary) <= 5000;

-- 회사에 5명 이하밖에 없는 직책을 모두 출력
SELECT job_id, count(*) FROM employees GROUP BY job_id HAVING count(*) <= 5;

-- 회사에 3명 이하밖에 없는 직책을 모두 출력
SELECT job_id, count(*) FROM employees GROUP BY job_id HAVING count(*) <= 3;


SELECT
    *
FROM employees;


-- 연습1: 부서별 최대 급여와 최소 급여를 출력하되 최대 급여가 5000이상인 부서만 출력해보세요

-- 연습2: 부서별 평균 급여를 출력하되 해당 부서에 소속된 사원이 10명 이상인 부서만 출력해보세요

SELECT department_id, MAX(salary),MIN(salary) FROM employees GROUP BY department_id HAVING MAX(salary) >= 5000;
SELECT department_id, trunc(AVG(salary), 2), COUNT(*) FROM employees GROUP BY department_id HAVING  COUNT(*) >= 10;












