/*
    #ORDER BY절
    -원하는 컬럼 기준으로 정렬하여 조회할 수 있다.
    - ORDER BY 컬럼명 [ASC/DESC]
    - ASC : ASCENDING ,오름차순(생략 가능)
    -DESC : DESCENDING, 내림차순

*/
SELECT
    *
FROM employees;  -- 기본적으로는 PK순서로 조회된다

select * from employees order by salary desc;
select * from employees order by salary asc;
select * from employees order by salary;  -- 차순을 생략하면 기본적으로 asc로 정렬된다

/*
   # 해당 컬럼에 null이 포함되어 있는 경우
    오름 차순으로 조회하면 가장 나중에 등장하고
    내림차순으로 조회하면 가장 먼저 등장한다.
*/
select * from employees order by commission_pct desc;
select * from employees order by commission_pct asc;

--여러개의 정렬 기준을 적용할 수 있다(asc는 생략가능)
-- 먼저 직급순으로 오름차순 정렬 후, 직급이 같다면 이름 내림차순 정렬
select * from employees order by job_id asc, first_name desc; 

--연습1: 모든 사원들을 부서번호 기준 오름차순으로 조회해보세요
--연습2: 모든 사원들을 최근 입사한 순서대로 조회해보세요
--연습3: 이름에 i가 포함되어 있는 사원들을 돈을 가장 많이 받는 순서대로 조회해보세요
--연습4: 80번 부서와 50번 부서의 사원들을 부서번호 기준 오름차순으로 조회하고,
--          부서번호가 같다면 last_name 기준으로 알파벳순으로 조회해보세요


select * from employees order by department_id;
select * from employees order by hire_date desc;
select * from employees where first_name like '%i%' order by salary * (1 + nvl(commission_pct,0)) desc;
select * from employees where department_id in (80,50) order by department_id, last_name;











