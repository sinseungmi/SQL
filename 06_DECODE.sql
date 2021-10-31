/*
    # DECODE
    
      - Ư�� �÷��� ���� ���� ǥ���� �����͸� �����Ѵ�
      DECODE �Լ��� ���α׷��ֿ�����  if else �� ����� ����� �����Ѵ�.
    ��) DECODE(�÷�, ����1, ���1, ����2, ���2, ����3, ���3..........) 
      - switch case ���� ������ �Ѵ�
*/
SELECT * FROM employees;

SELECT
    last_name,
    department_id,
    DECODE(department_id, 
        90, 'Executive',
        100, 'Finance',
        60, '�ٺ�',
        30, 3 + 5,
        '�ȳ�'
    ) AS department_name
FROM
    employees;
    
/*
    ����1 : ���޿� ���� �޿��� �ٸ��� �λ��Ͽ� ����غ����� 
    
        IT_PROG : 15% �λ�
        FI_ACCOUNT : 10% �λ�
        ��� ������ CLERK : 5% �λ�
        
    ������ �޿��� before_slary��, �λ�� �޿��� after_salary�� �̸��� �Բ� ���
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
    # DECODE�� �ش� �÷��� ���� ��Ȯ�ϰ� ��ġ�ϴ� ���� �̿��� �� ������
    CASE���� ������ ����� �� �ִ�

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
    # DECODE�� �ش� �÷��� ���� ��Ȯ�ϰ� ��ġ�ϴ� ���� �̿��� �� ������
        CASE���� ������ ����� �� �ִ�.
        CASE ǥ���Ŀ��� ELSE �κ��� ������ �����ϸ�, �����ϴ� ������ ������ NULL�� �����Ѵ�.
        DECODE �Լ��� ��ü�� �� �ִ� ����� CASE ǥ�����̸� �������� ���� �� ���� ����� �����Ѵ�. 
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




