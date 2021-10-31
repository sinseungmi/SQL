/*
    # 서브쿼리
    
    - 하나의 select문 내부에 포함된 또 하나의 select문
    - 서브쿼리를 포함하고 있는 쿼리를 메인 쿼리라고 한다
    - 서브쿼리는 메인 쿼리가 실행되기 전에 한번만 실행된다
    - where절에 사용하는 서브쿼리.
    
    # 단일 행 서브 쿼리
    - 서브 쿼리의 수행 결과가 단 하나의 행만 반환하는 서브 쿼리
    - =, >, >=, <, <= 등의 비교 연산자들은 하나의 단일 값끼리 비교하는 연산자이므로
     단일행 서브쿼리와 함께 사용해야한다.

*/

desc locations;

-- sigal과 같은 부서에 근무하는 모든 사원을 조회해보기
select * from employees 
where department_id = 
(select department_id from employees where first_name = 'Sigal');  --얘는 반환 결과가 딱 하나(단일행 서브쿼리)

-- 서브쿼리의 실행 결과
select department_id from employees where first_name = 'Sigal';

--연습1: EMAIL이 DRAPHEAL인 사원보다 급여를 많이 받는 사원들의 이름/직책/급여를 조회해보세요
--연습2: Purchasing 부서에서 근무하는 사원들의 이름과 직책과 부서번호를 조회해보세요

select first_name, job_id, department_id from employees e
where e.department_id = (select department_id from departments where department_name = 'Purchasing');

select first_name,job_id,salary 
from employees
where salary > (select salary from employees where email = 'DRAPHEAL');


/*
    # 다중 행 서브 쿼리
    - 서브 쿼리의 실행 결과로 반환되는 행이 2줄 이상인 서브 쿼리
    - 다중 행 연산자와 함께 사용해야 한다
    -IN: 메인 쿼리의 비교 조건이 서브 쿼리의 결과 중에서 하나라도 일치하면 참이다.  같은 값을 찾는다.
    - ANY, SOME : 메인 쿼리의 비교조건이 서브쿼리의 검색 결과와 하나 이상이 일치하면 참이다. (or)
    - ALL: 메인 쿼리의 비교 조건이 서브쿼리의 검색 결과와 모든 값이 일치하면 참이다. (and)
    -EXISTS : 서브쿼리의 실행 결과가 존재하면 참, 실행 결과가 없다면 거짓

*/

select * from employees order by salary desc;

select distinct department_id from employees where salary >= 13000;

--급여가 13000$ 이상인 사원이 소속된 부서에서 근무하는 모든 사원을 조회
SELECT
    employee_id,
    first_name,
    department_id
FROM
    employees
WHERE                   --서브쿼리는 메인 쿼리가 실행되기 전에 한번만 실행되는 것을 기억
                                --서브쿼리는 조건으로만 쓰인다
    department_id IN ( SELECT DISTINCT department_id FROM employees WHERE salary >= 13000)
ORDER BY
    department_id;


--ALL 연산자
SELECT
    first_name,
    job_title,
    salary
FROM
    employees INNER JOIN jobs USING (job_id)
WHERE
    salary > ALL ( SELECT salary FROM employees  WHERE job_id = 'IT_PROG' );
    
SELECT salary FROM employees  WHERE job_id = 'IT_PROG';


--ANY 연산자
SELECT
    first_name,
    job_title,
    salary
FROM
    employees INNER JOIN jobs USING (job_id)
WHERE
    salary > ANY( SELECT salary FROM employees  WHERE job_id = 'IT_PROG' );


--SOME 연산자
SELECT
    first_name,
    job_title,
    salary
FROM
    employees INNER JOIN jobs USING (job_id)
WHERE
    salary > SOME( SELECT salary FROM employees  WHERE job_id = 'IT_PROG' );
    

--EXISTS : 서브쿼리 실행 결과가 1행이라도 존재하면 참
SELECT
    *
FROM
    employees e1          --NOT EXISTS e1.salary > e2.salary : e1의 월급이 e2의 월급보다 큰 값이 존재하면 안된다(결과는 제일 작은 값)
WHERE                       --NOT EXISTS e1.salary < e2.salary : e1의 월급이 e2의 월급보다 직은 값이 존재하면 안된다(결과는 제일 큰 값)
    NOT EXISTS ( SELECT 1 FROM employees e2 WHERE e1.salary > e2.salary);   --조건의 결과를 true,false로 적용.  
                           --비교는 서브쿼리문 안에서 자체적으로 했기 때문에 1을 넣어 트루면 반환 받는 것
                            --서브쿼리는 조건으로만 쓰고있다.  
                            --e1하나의 값으로 e2에 나보다 큰값이 존재하는지를 체크하는 것. 구구단처럼
                            --not exists를 잘 생각하기

    
