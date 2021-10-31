
--employees의 직원들이 자신이 받을 수 있는 월급 범위내에서
--몇 퍼센트 수준의 월급을 받고 있는지 보기 좋은 형태로 조회해보세요(커미션도 포함)

SELECT
    employee_id,
    first_name,
    salary,
    commission_pct,
    round((salary *(1 + nvl(commission_pct, 0)) - min_salary) /(max_salary - min_salary), 2) * 100 AS "Salary Percentage"
FROM
         employees
    INNER JOIN jobs USING ( job_id )
ORDER BY
    "Salary Percentage" DESC;
    
    
SELECT
    employee_id,
    first_name,
    salary,
    commission_pct,
    trunc((salary *(1 + nvl(commission_pct, 0)) - min_salary) /(max_salary - min_salary), 4) * 100 AS "Salary Percentage"
FROM
         employees
    INNER JOIN jobs USING ( job_id )
ORDER BY
    "Salary Percentage" DESC;
    
    
SELECT
    employee_id,
    first_name,
    salary,
    commission_pct,
    to_char((salary *(1 + nvl(commission_pct, 0)) - min_salary) /(max_salary - min_salary) * 100, '999.99') AS "Salary Percentage"
FROM
         employees
    INNER JOIN jobs USING ( job_id )
ORDER BY
    "Salary Percentage" DESC;
    
    
    
    
    
    
    
    
    