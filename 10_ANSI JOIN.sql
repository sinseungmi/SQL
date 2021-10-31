/*
    # ANSI JOIN
    
      - ANSI (American National Standards Institute) : 여러가지 표준을 재정하는 민간 단체
      - 미국 국가 표준 협회에서 정한 표준을 따르는 JOIN문법 
      - 다른 RDBMS에도 이 문법이 존재한다
*/

-- ANSI CROSS JOIN
SELECT * FROM employees CROSS JOIN departments;

-- ANSI INNER JOIN : 조건에 맞는 행만 등장하는 JOIN
-- (콤마)를 생략하고 INNER JOIN을 추가하고, WHERE절 대신 ON절을 사용하면 된다.
-- 테이블 A와 테이블 B 모두에 존재하는 코드를 조회한다.(교집합 생각하기)
-- ON : 두테이블간 조인해줘야하는 컬럼.이름이 다른 경우
SELECT
    *
FROM
         employees e
    INNER JOIN departments d ON e.department_id = d.department_id;
select * from employees;

-- ANSI OUTER JOIN : 조건에 맞지 않는 행도 등장하는 JOIN. LEFT/RIGHT/FULL을 선택해야 한다.
SELECT
    e1.employee_id,
    e1.first_name,
    e2.employee_id AS manager_id,
    e2.first_name
FROM
        employees  e1
    FULL OUTER JOIN employees e2 ON e1.manager_id = e2.employee_id
ORDER BY
    e1.employee_id;
    
-- LEFT OUTER JOIN  : 왼쪽이 나오는 아우터 조인, 즉 오른쪽에 (+)를 붙인것과 같다
--                              조인문의 왼쪽에 있는 테이블의 모든 결과를 가져 온 후 오른쪽 테이블의 
--                               데이터를 매칭하고, 매칭되는 데이터가 없는 경우 NULL로 표시한다.
-- RIGHT OUTER JOIN : 오른쪽이 나오는 아우터 조인, 즉 왼쪽에 (+)를 붙인것과 같다
--                                 조인문의 오른쪽에 있는 테이블의 모든 결과를 가져온 후 왼쪽의 테이블의 
--                                 데이터를 매칭하고, 매칭되는 데이터가 없는 경우 NULL을 표시한다.
-- FULL OUTER JOIN  : 양쪽이 모두 나오는 아우터 조인, 양쪽 (+)를 붙인것과 같다
    
-- JOIN 조건에 이용되는 컬럼명이 같은 경우 USING을 이용해 쿼리문을 간소화 할 수 있다
SELECT
    first_name,
    department_id,
    department_name,
    job_id,
    job_title,
    location_id,
    city
FROM
         employees
    INNER JOIN departments USING ( department_id )  --USING 은 두 테이블간 컬럼이름이 같은경우
    INNER JOIN jobs USING (job_id)
    RIGHT OUTER JOIN locations USING (location_id);

select * from locations;
desc departments;
--WHERE
--    department_id <= 40;
    
--ANSI JOIN을 사용하면 조인 조건과 WHERE 조건절을 구분하여 사용할 수 있고
-- USING에 사용된 컬럼을 어느 테이블의 컬럼인지 명시할 필요가 없어진다


-- ANSI JOIN을 이용해 다음 문제들을 풀어보세요 

-- 연습1 : first_name이 Valli인 사람의 사원번호/풀네임/부서명을 조회해보세요

-- 연습2 : job_id가 IT_PROG인 사원들의 이름/부서번호/부서명을 조회해보세요

-- 연습3 : 시애틀에서 근무하는 모든 사원의 이름과 직책과 급여를 출력해보세요

-- 연습4 : 사원명/부서번호/부서이름을 출력하되 사원이 한명도 속하지 않은 부서도 조회해보세요

-- 연습5 : 부서명/주소/도시명을 출력하되 소속된 부서가 없는 도시도 함께 조회해보세요

select employee_id,first_name,last_name,department_name
from employees inner join departments using (department_id) 
where first_name = 'Valli';

select first_name,department_id,department_name
from employees inner join departments 
using (department_id)
where job_id = 'IT_PROG' order by first_name;

select first_name,job_id,salary 
from employees inner join departments using(department_id)
inner join locations using (location_id)
where city = 'Seattle';

select first_name, department_id, department_name 
from employees right outer join departments 
using (department_id);

select department_name, street_address, city 
from departments right outer join locations
using (location_id)
order by department_name;

desc locations;
desc departments;




    










    

