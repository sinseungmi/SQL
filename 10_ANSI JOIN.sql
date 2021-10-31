/*
    # ANSI JOIN
    
      - ANSI (American National Standards Institute) : �������� ǥ���� �����ϴ� �ΰ� ��ü
      - �̱� ���� ǥ�� ��ȸ���� ���� ǥ���� ������ JOIN���� 
      - �ٸ� RDBMS���� �� ������ �����Ѵ�
*/

-- ANSI CROSS JOIN
SELECT * FROM employees CROSS JOIN departments;

-- ANSI INNER JOIN : ���ǿ� �´� �ุ �����ϴ� JOIN
-- (�޸�)�� �����ϰ� INNER JOIN�� �߰��ϰ�, WHERE�� ��� ON���� ����ϸ� �ȴ�.
-- ���̺� A�� ���̺� B ��ο� �����ϴ� �ڵ带 ��ȸ�Ѵ�.(������ �����ϱ�)
-- ON : �����̺� ����������ϴ� �÷�.�̸��� �ٸ� ���
SELECT
    *
FROM
         employees e
    INNER JOIN departments d ON e.department_id = d.department_id;
select * from employees;

-- ANSI OUTER JOIN : ���ǿ� ���� �ʴ� �൵ �����ϴ� JOIN. LEFT/RIGHT/FULL�� �����ؾ� �Ѵ�.
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
    
-- LEFT OUTER JOIN  : ������ ������ �ƿ��� ����, �� �����ʿ� (+)�� ���ΰͰ� ����
--                              ���ι��� ���ʿ� �ִ� ���̺��� ��� ����� ���� �� �� ������ ���̺��� 
--                               �����͸� ��Ī�ϰ�, ��Ī�Ǵ� �����Ͱ� ���� ��� NULL�� ǥ���Ѵ�.
-- RIGHT OUTER JOIN : �������� ������ �ƿ��� ����, �� ���ʿ� (+)�� ���ΰͰ� ����
--                                 ���ι��� �����ʿ� �ִ� ���̺��� ��� ����� ������ �� ������ ���̺��� 
--                                 �����͸� ��Ī�ϰ�, ��Ī�Ǵ� �����Ͱ� ���� ��� NULL�� ǥ���Ѵ�.
-- FULL OUTER JOIN  : ������ ��� ������ �ƿ��� ����, ���� (+)�� ���ΰͰ� ����
    
-- JOIN ���ǿ� �̿�Ǵ� �÷����� ���� ��� USING�� �̿��� �������� ����ȭ �� �� �ִ�
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
    INNER JOIN departments USING ( department_id )  --USING �� �� ���̺� �÷��̸��� �������
    INNER JOIN jobs USING (job_id)
    RIGHT OUTER JOIN locations USING (location_id);

select * from locations;
desc departments;
--WHERE
--    department_id <= 40;
    
--ANSI JOIN�� ����ϸ� ���� ���ǰ� WHERE �������� �����Ͽ� ����� �� �ְ�
-- USING�� ���� �÷��� ��� ���̺��� �÷����� ����� �ʿ䰡 ��������


-- ANSI JOIN�� �̿��� ���� �������� Ǯ����� 

-- ����1 : first_name�� Valli�� ����� �����ȣ/Ǯ����/�μ����� ��ȸ�غ�����

-- ����2 : job_id�� IT_PROG�� ������� �̸�/�μ���ȣ/�μ����� ��ȸ�غ�����

-- ����3 : �þ�Ʋ���� �ٹ��ϴ� ��� ����� �̸��� ��å�� �޿��� ����غ�����

-- ����4 : �����/�μ���ȣ/�μ��̸��� ����ϵ� ����� �Ѹ� ������ ���� �μ��� ��ȸ�غ�����

-- ����5 : �μ���/�ּ�/���ø��� ����ϵ� �Ҽӵ� �μ��� ���� ���õ� �Բ� ��ȸ�غ�����

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




    










    

