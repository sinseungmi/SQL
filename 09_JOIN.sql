/*
    # 기본키(primary key, PK)
    
    -한 테이블에서 하나의 행을을 유일하게 구분할 수 있는 컬럼(중복 값이 없어야한다)
    -한 테이블 당 하나 밖에 설정할 수 없다.
    - 기본키가 될 수 있는 컬럼이지만 기본키로 설정되지않은 컬럼은 후보키(Candidate Key)라고 한다
    - 기본키 컬럼에는 중복된 값이 없어야하고, nul(빈 값)도 허용하지 않는다.
    
    
    # 외래키(Foreign Key, FK)
    
    - 다른 테이블에서는 기본키 또는 후보키 이지만 해당 테이블에서는 중복 되는 값인 컬럼
    ex : employeesd의 department_id는 departments의 기본 키이고, employees에 가져와서 활용되고 있다
    - 외래키가 설정된 테이블 간에는 관계가 형성된다.
    - 외래키로 설정된 컬럼은 반드시 참조하는 테이블의 기본키로 이미 존재하는 값만 추가할 수 있다.

*/

SELECT * FROM employees ORDER BY first_name;  
--employees에서는 부서id,잡id는 외래키이다.

SELECT * FROM departments;   --departments에서는 부서 id가 기본키
SELECT  * FROM jobs;

/*
    실생활에서 1 : n관계로 설정할 수 있는 사례를 생각해보세요
    
     팀과 소속선수, 수강생과 담당 상담원, 소대장과 분대원, 제품과 제조회사
*/

/*
    # 테이블 JOIN
    -기본키와 외래키로 관계가 형성되어 있는 테이블들의 정보를 종합하여 조회하는 것
    
    # CROSS JOIN
    -조인에 사용되는 테이블의 데이터를 조합하여 나올 수 있는 모든 경우를 출력하는 JOIN
    -그냥 모든 경우를 출력하는 쓸모없는 정보
    
    107         27
    a              1
    b              2
    c              3
    d
    
    a1 ~ z1
    a2 ~ z2
    ...
    a27 ~ z27
    
*/
SELECT employee_id, first_name, department_name FROM employees, departments;

SELECT * FROM employees;  --107 rows
SELECT * FROM departments;  --27 rows
SELECT * FROM employees, departments;  --모든 경우의 수를 싹다 조회 107 * 27 rows

/*
    # EQUI JOIN
    - 두 테이블 간에 서로 동일한 값을 지닌 컬럼(기본키와 외래키)을 이용하여
       CROSS JOIN의 결과에서 의미있는 데이터만 걸러내는 JOIN

*/

SELECT * FROM employees, departments
WHERE employees.department_id = departments.department_id;
                             --   FK                                                 PK

--연습1 : first_name이 Valli인 사람의 사번/풀네임/부서명을 조회해보세요
--연습2 : job_id가 IT_PROG인 사원들의 이름/부서번호/부서명을 조회해보세요
--연습3 : 시애틀에서 근무하는 모든 사원의 이름과 직책과 급여를 출력해보세요(Hint: locations 테이블)

SELECT
    employee_id,
    first_name,
    last_name,
    department_name
FROM
    employees,
    departments
WHERE
        departments.department_id = employees.department_id
    AND first_name = 'Valli'
ORDER BY  --순서 정렬하고 싶을 때 써,,
        employee_id;

SELECT
    first_name,
    nvl(departments.department_id,employees.department_id), --양쪽 테이블 모두에 같은 이름을 지닌 컬럼이 있는 경우 어느쪽의 것인지 명확하게 명시해야한다 /employees.department_id해도됨
    department_name
FROM
    employees,
    departments
WHERE
       job_id = 'IT_PROG' AND employees.department_id = departments.department_id;
       
--테이블 명을 자주 사용해야 하는 경우 별칭을 사용할 수 있다
SELECT
    e.first_name,
    job_id,
    e.salary
FROM
    departments  d,   --별칭사용가능
    employees    e,
    locations    l
WHERE
        l.location_id = d.location_id
    AND e.department_id = d.department_id
    AND city = 'Seattle';

select distinct  city from locations;
select * from locations;


/*
    # SELF JOIN
    - 하나의 테이블 내에서 자기 자신과 JOIN하여 원하는 데이터를 얻어내는 조인 방식
    ex : manager_id는 자기자신 테이블의 employee_id를 참조하기 때문에 이미 존재하는 employee_id의 값을 넣어야한다

*/
SELECT
    e1.employee_id,
    e1.first_name,
    e1.job_id,
    e1.manager_id,
    e2.first_name AS "MANAGER NAME"
FROM
    employees  e1,
    employees  e2  --SELF JOIN은 테이블 별칭을 사용할 수 밖에 없다.
WHERE
    e1.manager_id = e2.employee_id
ORDER BY
    e1.employee_id;

-- 연습1: 매니저 이름이 Nancy인 사원들의 사번/이름/job_title을 조회해보세요
-- 연습2: Curtis와 동일한 직책을 가진 사원들의 모든 정보를 조회해보세요

SELECT
    e1.employee_id,
    e1.first_name,
    job_title
FROM
    employees  e1,
    employees  e2,
    jobs       j
WHERE
        e1.job_id = j.job_id
    AND e2.first_name = 'Nancy'
    AND e1.manager_id = e2.employee_id;
  

SELECT
    e1.*
FROM
    employees  e1,
    employees  e2
WHERE
        e2.first_name = 'Curtis'
    AND e1.job_id = e2.job_id;
    
 /*
    #OUTER JOIN
    - join 조건을 만족하지 못해서 등장하지 못했던 행들을 확인할 때 사용하는 join
    - (+)를 붙인쪽의 컬럼에 null을 추가해서, 등장하지 못했던 행들을 확인할 수 있다.
 
 */   
    
SELECT
    employee_id,
    first_name,
    e.department_id,
    d.department_id
FROM
    employees    e,
    departments  d
WHERE                      -- 맞춰줄 값이 없어서 (+)로 null이라도 넣어서 나오게 만든다
    e.department_id(+) = d.department_id;
   -- e.department_id = d.department_id (+);
    --전체 조회  =  매칭되는 값이 없을 때 null추가
  
   
   select * from employees;
    
 -- 다음과 같은 쿼리문이 있을 때(+)를 왼쪽에 불이는 경우 조회되는 데이터의 의미와 
 --(+)를 오른쪽에 붙이는 경우 조회되는 데이터의 의미를 각각 서술하시오
 --★(시험 문제로 나옴)
SELECT
    e1.*,
    e2.first_name
FROM
    employees  e1,
    employees  e2
WHERE
    e1.manager_id = e2.employee_id(+);    
    
    /*
        오른쪽 (+) : e1.manager_id는 있지만, e2에 일치하는게 없어서 출력되지 못한 행을 출력
            => manager_id가 잘못된 경우, null, 매니저가 설정되지 않은 경우가 출력됨
        
        왼쪽 (+) : e2.employee_id는 있지만, e1.manager_id에 일치하는게 없어서 출력되지 못한 행을
           출력
           => 직원이지만 부하직원은 없는 경우가 출력됨
    
    */

select * from employees where department_id is null;
select * from employees where manager_id is null;
    
--연습1: 사원명/부서번호/부서이름을 출력하되 사원이 한명도 속하지 않은 부서도 조회해보세요

--연습2: 사원명/직책ID/직책명을 출력하되 사원이 한명도 속하지않은 직책도 함께 조회해보세요

--연습3: 부서명/주소/도시명을 출력하되 소속된 부서가 없는 도시도 함께 조회해봐라

select first_name, d.department_id, department_name
from employees e, departments d
where e.department_id(+) = d.department_id;

select first_name, j.job_id, job_title
from employees e, jobs j
where e.job_id(+) = j.job_id;

select department_name,street_address,city 
from locations l, departments d
where d.location_id(+) = l.location_id
order by d.department_name desc;

select * from locations;
    
    
    
    














