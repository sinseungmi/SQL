/*
    # ��������
    
    - �ϳ��� select�� ���ο� ���Ե� �� �ϳ��� select��
    - ���������� �����ϰ� �ִ� ������ ���� ������� �Ѵ�
    - ���������� ���� ������ ����Ǳ� ���� �ѹ��� ����ȴ�
    - where���� ����ϴ� ��������.
    
    # ���� �� ���� ����
    - ���� ������ ���� ����� �� �ϳ��� �ุ ��ȯ�ϴ� ���� ����
    - =, >, >=, <, <= ���� �� �����ڵ��� �ϳ��� ���� ������ ���ϴ� �������̹Ƿ�
     ������ ���������� �Բ� ����ؾ��Ѵ�.

*/

desc locations;

-- sigal�� ���� �μ��� �ٹ��ϴ� ��� ����� ��ȸ�غ���
select * from employees 
where department_id = 
(select department_id from employees where first_name = 'Sigal');  --��� ��ȯ ����� �� �ϳ�(������ ��������)

-- ���������� ���� ���
select department_id from employees where first_name = 'Sigal';

--����1: EMAIL�� DRAPHEAL�� ������� �޿��� ���� �޴� ������� �̸�/��å/�޿��� ��ȸ�غ�����
--����2: Purchasing �μ����� �ٹ��ϴ� ������� �̸��� ��å�� �μ���ȣ�� ��ȸ�غ�����

select first_name, job_id, department_id from employees e
where e.department_id = (select department_id from departments where department_name = 'Purchasing');

select first_name,job_id,salary 
from employees
where salary > (select salary from employees where email = 'DRAPHEAL');


/*
    # ���� �� ���� ����
    - ���� ������ ���� ����� ��ȯ�Ǵ� ���� 2�� �̻��� ���� ����
    - ���� �� �����ڿ� �Բ� ����ؾ� �Ѵ�
    -IN: ���� ������ �� ������ ���� ������ ��� �߿��� �ϳ��� ��ġ�ϸ� ���̴�.  ���� ���� ã�´�.
    - ANY, SOME : ���� ������ �������� ���������� �˻� ����� �ϳ� �̻��� ��ġ�ϸ� ���̴�. (or)
    - ALL: ���� ������ �� ������ ���������� �˻� ����� ��� ���� ��ġ�ϸ� ���̴�. (and)
    -EXISTS : ���������� ���� ����� �����ϸ� ��, ���� ����� ���ٸ� ����

*/

select * from employees order by salary desc;

select distinct department_id from employees where salary >= 13000;

--�޿��� 13000$ �̻��� ����� �Ҽӵ� �μ����� �ٹ��ϴ� ��� ����� ��ȸ
SELECT
    employee_id,
    first_name,
    department_id
FROM
    employees
WHERE                   --���������� ���� ������ ����Ǳ� ���� �ѹ��� ����Ǵ� ���� ���
                                --���������� �������θ� ���δ�
    department_id IN ( SELECT DISTINCT department_id FROM employees WHERE salary >= 13000)
ORDER BY
    department_id;


--ALL ������
SELECT
    first_name,
    job_title,
    salary
FROM
    employees INNER JOIN jobs USING (job_id)
WHERE
    salary > ALL ( SELECT salary FROM employees  WHERE job_id = 'IT_PROG' );
    
SELECT salary FROM employees  WHERE job_id = 'IT_PROG';


--ANY ������
SELECT
    first_name,
    job_title,
    salary
FROM
    employees INNER JOIN jobs USING (job_id)
WHERE
    salary > ANY( SELECT salary FROM employees  WHERE job_id = 'IT_PROG' );


--SOME ������
SELECT
    first_name,
    job_title,
    salary
FROM
    employees INNER JOIN jobs USING (job_id)
WHERE
    salary > SOME( SELECT salary FROM employees  WHERE job_id = 'IT_PROG' );
    

--EXISTS : �������� ���� ����� 1���̶� �����ϸ� ��
SELECT
    *
FROM
    employees e1          --NOT EXISTS e1.salary > e2.salary : e1�� ������ e2�� ���޺��� ū ���� �����ϸ� �ȵȴ�(����� ���� ���� ��)
WHERE                       --NOT EXISTS e1.salary < e2.salary : e1�� ������ e2�� ���޺��� ���� ���� �����ϸ� �ȵȴ�(����� ���� ū ��)
    NOT EXISTS ( SELECT 1 FROM employees e2 WHERE e1.salary > e2.salary);   --������ ����� true,false�� ����.  
                           --�񱳴� ���������� �ȿ��� ��ü������ �߱� ������ 1�� �־� Ʈ��� ��ȯ �޴� ��
                            --���������� �������θ� �����ִ�.  
                            --e1�ϳ��� ������ e2�� ������ ū���� �����ϴ����� üũ�ϴ� ��. ������ó��
                            --not exists�� �� �����ϱ�

    
