
--employees�� �������� �ڽ��� ���� �� �ִ� ���� ����������
--�� �ۼ�Ʈ ������ ������ �ް� �ִ��� ���� ���� ���·� ��ȸ�غ�����(Ŀ�̼ǵ� ����)

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
    
    
    
    
    
    
    
    
    