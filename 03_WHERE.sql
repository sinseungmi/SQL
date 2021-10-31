/*

# SELECT �÷��� FROM ���̺�� WHERE ������;

    SELECT���� WHERE���� �߰��Ͽ� �ش� ������ �����ϴ� �����͸� ��ȸ�� �� �ִ�

*/

--������ 15000�޷� �̻��� ����鸸 ��ȸ�ϱ�

desc employees;
SELECT
    *
FROM employees;
SELECT
    *
FROM
    employees
WHERE
    salary >= 15000;

/*
    # ����Ŭ�� �� �����ڵ�
    = : ����
    <, >, <=, >= : ��
    != , <>, ^= : �ٸ���
*/

SELECT
    *
FROM
    employees
WHERE
    salary = 17000;

SELECT
    *
FROM
    employees
WHERE
    salary != 17000;

--����Ŭ�� ���ڿ� ���ͷ��� ''�� ����Ѵ�
SELECT
    *
FROM
    employees
WHERE
    first_name = 'Sarah';

SELECT
    *
FROM
    employees
WHERE
    last_name = 'Smith';

--��¥ Ÿ�Ե� ������ �񱳰� �����ϴ�
SELECT
    *
FROM
    employees
WHERE
    hire_date < '2004/01/01';

SELECT
    *
FROM
    employees
WHERE
    hire_date < '2005/01/01';

SELECT
    *
FROM
    employees
WHERE
    hire_date < '2006/01/01';

SELECT
    *
FROM
    employees
WHERE
    hire_date < '2007/01/01';

--and, or, not
SELECT
    *
FROM
    employees
WHERE
        hire_date >= '2005/01/01'
    AND hire_date < '2007/01/01';

SELECT
    *
FROM
    employees
WHERE
    job_id = 'IT_PROG'
    OR job_id = 'ST_CLERK';

/*
    ����1: 2000���� 3000������ ������ �޴� ������� ��� ������ ��ȸ�ϼ���
    
    ����2: �μ���ȣ�� 30���̰ų� 60���̰ų� 90���� ������� 
            �̸�/��å/��ȭ��ȣ/�μ���ȣ�� ��ȸ�ϼ���
*/


SELECT * FROM employees WHERE salary >= 2000 AND salary <= 3000;

SELECT first_name, job_id, phone_number, department_id FROM employees WHERE department_id = 30 OR department_id = 60 OR department_id = 90;

SELECT
    *
FROM
    employees
WHERE
        salary >= 2000
    AND salary <= 3000;

SELECT
    first_name,
    job_id,
    phone_number,
    department_id
FROM
    employees
WHERE
    department_id = 30
    OR department_id = 90
    OR department_id = 60;
    
--����� ¦���� ����� ��ȸ�غ���
--MOD()�� ���� ������ ������ �� �� �ִ�. %�� ����, MOD()�� �����⸦ �ؼ� ������ ���� ���ϴ� ��

SELECT * FROM employees WHERE mod(employee_id,2) = 0;


SELECT
    *
FROM
    employees
WHERE
    mod(employee_id, 2) = 0;    
    
--COLUMN BETWEEN A AND B : �ش� �÷� ���� A�̻� B������ ��� true

SELECT
    *
FROM
    employees
WHERE
    salary BETWEEN 2000 AND 3000;
    
select * from employees where employee_id BETWEEN 150 AND 200;  
    

--COLUMN IN (A,B,C ...) : ()�ȿ� ���뿡 ���� �����ϴ� ��� true
SELECT
    *
FROM
    employees
WHERE
    NOT department_id IN ( 30, 60, 90 );
    
SELECT
    *
FROM
    employees
WHERE
    job_id NOT IN ( 'IT_PROG', 'AD_VP' );
    

--Ŀ�̼� �ۼ�Ʈ�� null�� ����� ��� ��ȸ�غ���
SELECT
    *
FROM
    employees
WHERE
    commission_pct = NULL; --�ƹ��͵� �ȳ���
    
select * from employees where commission_pct IS NOT NULL;
    
-- ���� NULL�� ������ ���鶧�� =NULL�� �ƴ϶� IS NULL�� ����ؾ��Ѵ� (NULL�� ũ�� �񱳰� �Ұ���)
SELECT
    *
FROM
    employees
WHERE
    commission_pct IS NULL;
    
-- NOT�� ��ġ�� ���� �����Ӵ�
SELECT
    *
FROM
    employees
WHERE
    department_id NOT IN ( 30, 60, 90 );

SELECT
    *
FROM
    employees
WHERE
    NOT department_id IN ( 30, 60, 90 );

SELECT
    *
FROM
    employees
WHERE
    commission_pct IS NOT NULL;

SELECT
    *
FROM
    employees
WHERE
    NOT commission_pct IS NULL;

SELECT
    *
FROM
    employees
WHERE
    salary NOT BETWEEN 2000 AND 3000;

SELECT
    *
FROM
    employees
WHERE
    NOT salary BETWEEN 2000 AND 3000;
    
    
/*
    # LIKE
    - �������� �Ϻκ����� ���ϴ� ������ �˻��� �� �ִ�
    - ����Ÿ�԰� ��¥ Ÿ�Կ� ����� �� �ִ�
    -% : ���� ���� ���� �ƹ� ���ڿ��̳� �͵� �Ǵ� ���ϵ� ī�� (������ ���� �͵� ����)
    - _: �ϳ��� ���ڰ� �ݵ�� �;��ϴ� ���ϵ� ī��

*/

-- �̸��� J�� �����ϴ� ��� ����� ��ȸ
SELECT
    first_name
FROM
    employees
WHERE
    first_name LIKE 'J%';

-- �̸��� �ι�° ���ڰ� u�� ��� ����� ��ȸ
SELECT
    first_name
FROM
    employees
WHERE
    first_name LIKE '_u%';

-- �̸��� ����° ���ڰ� e�� ��� ����� ��ȸ
SELECT
    first_name
FROM
    employees
WHERE
    first_name LIKE '__e%';

-- �̸��� x�� ���ԵǾ� �ִ� ��� ����� ��ȸ
SELECT
    first_name
FROM
    employees
WHERE
    first_name LIKE '%x%';

/*
    ����1 : �̸��� �ڿ��� ����° ���ڰ� a�� ��� ����� ��ȸ�غ�����
    
    ����2 : �̸��� e�� �ΰ� �̻� ���Ե� ��� ����� ��ȸ�غ�����
    
    ����3 : �̸��� �ټ������̸鼭 a�� ������ ��� ����� ��ȸ�غ�����
*/


select first_name from employees where first_name like '_i%e%';

SELECT
    *
FROM
    employees
WHERE
    first_name LIKE '%a__';

SELECT
    *
FROM
    employees
WHERE
    first_name LIKE '%e%e%';

SELECT
    *
FROM
    employees
WHERE
    first_name LIKE '____a';