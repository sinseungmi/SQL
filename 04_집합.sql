select * from departments;

--UNION : 합집합(중복은 알아서 제거됨)
 SELECT
    *
FROM
    departments
WHERE
    department_id BETWEEN 10 AND 40
UNION
SELECT
    *
FROM
    departments
WHERE
    department_id BETWEEN 30 AND 50;
    
SELECT department_id FROM employees WHERE job_id = 'IT_PROG'
UNION
SELECT department_id FROM departments  WHERE department_id BETWEEN 30 AND 50;
    
  --UNION ALL : 합집합(중복 제거 안함)
 SELECT
    *
FROM
    departments
WHERE
    department_id BETWEEN 10 AND 40
UNION ALL
SELECT
    *
FROM
    departments
WHERE
    department_id BETWEEN 30 AND 50;
    
--INTERSECT : 교집합
 SELECT
    *
FROM
    departments
WHERE
    department_id BETWEEN 10 AND 40
INTERSECT
SELECT
    *
FROM
    departments
WHERE
    department_id BETWEEN 30 AND 50;
    
    --MINUS : 차집합
 SELECT
    *
FROM
    departments
WHERE
    department_id BETWEEN 10 AND 40
MINUS
SELECT
    *
FROM
    departments
WHERE
    department_id BETWEEN 30 AND 50;

SELECT
    *
FROM
    departments
WHERE
    department_id BETWEEN 30 AND 50
MINUS
SELECT
    *
FROM
    departments
WHERE
    department_id BETWEEN 10 AND 40;
    
    
    
    
    
    
    