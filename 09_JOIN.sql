/*
    # �⺻Ű(primary key, PK)
    
    -�� ���̺��� �ϳ��� ������ �����ϰ� ������ �� �ִ� �÷�(�ߺ� ���� ������Ѵ�)
    -�� ���̺� �� �ϳ� �ۿ� ������ �� ����.
    - �⺻Ű�� �� �� �ִ� �÷������� �⺻Ű�� ������������ �÷��� �ĺ�Ű(Candidate Key)��� �Ѵ�
    - �⺻Ű �÷����� �ߺ��� ���� ������ϰ�, nul(�� ��)�� ������� �ʴ´�.
    
    
    # �ܷ�Ű(Foreign Key, FK)
    
    - �ٸ� ���̺����� �⺻Ű �Ǵ� �ĺ�Ű ������ �ش� ���̺����� �ߺ� �Ǵ� ���� �÷�
    ex : employeesd�� department_id�� departments�� �⺻ Ű�̰�, employees�� �����ͼ� Ȱ��ǰ� �ִ�
    - �ܷ�Ű�� ������ ���̺� ������ ���谡 �����ȴ�.
    - �ܷ�Ű�� ������ �÷��� �ݵ�� �����ϴ� ���̺��� �⺻Ű�� �̹� �����ϴ� ���� �߰��� �� �ִ�.

*/

SELECT * FROM employees ORDER BY first_name;  
--employees������ �μ�id,��id�� �ܷ�Ű�̴�.

SELECT * FROM departments;   --departments������ �μ� id�� �⺻Ű
SELECT  * FROM jobs;

/*
    �ǻ�Ȱ���� 1 : n����� ������ �� �ִ� ��ʸ� �����غ�����
    
     ���� �ҼӼ���, �������� ��� ����, �Ҵ���� �д��, ��ǰ�� ����ȸ��
*/

/*
    # ���̺� JOIN
    -�⺻Ű�� �ܷ�Ű�� ���谡 �����Ǿ� �ִ� ���̺���� ������ �����Ͽ� ��ȸ�ϴ� ��
    
    # CROSS JOIN
    -���ο� ���Ǵ� ���̺��� �����͸� �����Ͽ� ���� �� �ִ� ��� ��츦 ����ϴ� JOIN
    -�׳� ��� ��츦 ����ϴ� ������� ����
    
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
SELECT * FROM employees, departments;  --��� ����� ���� �ϴ� ��ȸ 107 * 27 rows

/*
    # EQUI JOIN
    - �� ���̺� ���� ���� ������ ���� ���� �÷�(�⺻Ű�� �ܷ�Ű)�� �̿��Ͽ�
       CROSS JOIN�� ������� �ǹ��ִ� �����͸� �ɷ����� JOIN

*/

SELECT * FROM employees, departments
WHERE employees.department_id = departments.department_id;
                             --   FK                                                 PK

--����1 : first_name�� Valli�� ����� ���/Ǯ����/�μ����� ��ȸ�غ�����
--����2 : job_id�� IT_PROG�� ������� �̸�/�μ���ȣ/�μ����� ��ȸ�غ�����
--����3 : �þ�Ʋ���� �ٹ��ϴ� ��� ����� �̸��� ��å�� �޿��� ����غ�����(Hint: locations ���̺�)

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
ORDER BY  --���� �����ϰ� ���� �� ��,,
        employee_id;

SELECT
    first_name,
    nvl(departments.department_id,employees.department_id), --���� ���̺� ��ο� ���� �̸��� ���� �÷��� �ִ� ��� ������� ������ ��Ȯ�ϰ� ����ؾ��Ѵ� /employees.department_id�ص���
    department_name
FROM
    employees,
    departments
WHERE
       job_id = 'IT_PROG' AND employees.department_id = departments.department_id;
       
--���̺� ���� ���� ����ؾ� �ϴ� ��� ��Ī�� ����� �� �ִ�
SELECT
    e.first_name,
    job_id,
    e.salary
FROM
    departments  d,   --��Ī��밡��
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
    - �ϳ��� ���̺� ������ �ڱ� �ڽŰ� JOIN�Ͽ� ���ϴ� �����͸� ���� ���� ���
    ex : manager_id�� �ڱ��ڽ� ���̺��� employee_id�� �����ϱ� ������ �̹� �����ϴ� employee_id�� ���� �־���Ѵ�

*/
SELECT
    e1.employee_id,
    e1.first_name,
    e1.job_id,
    e1.manager_id,
    e2.first_name AS "MANAGER NAME"
FROM
    employees  e1,
    employees  e2  --SELF JOIN�� ���̺� ��Ī�� ����� �� �ۿ� ����.
WHERE
    e1.manager_id = e2.employee_id
ORDER BY
    e1.employee_id;

-- ����1: �Ŵ��� �̸��� Nancy�� ������� ���/�̸�/job_title�� ��ȸ�غ�����
-- ����2: Curtis�� ������ ��å�� ���� ������� ��� ������ ��ȸ�غ�����

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
    - join ������ �������� ���ؼ� �������� ���ߴ� ����� Ȯ���� �� ����ϴ� join
    - (+)�� �������� �÷��� null�� �߰��ؼ�, �������� ���ߴ� ����� Ȯ���� �� �ִ�.
 
 */   
    
SELECT
    employee_id,
    first_name,
    e.department_id,
    d.department_id
FROM
    employees    e,
    departments  d
WHERE                      -- ������ ���� ��� (+)�� null�̶� �־ ������ �����
    e.department_id(+) = d.department_id;
   -- e.department_id = d.department_id (+);
    --��ü ��ȸ  =  ��Ī�Ǵ� ���� ���� �� null�߰�
  
   
   select * from employees;
    
 -- ������ ���� �������� ���� ��(+)�� ���ʿ� ���̴� ��� ��ȸ�Ǵ� �������� �ǹ̿� 
 --(+)�� �����ʿ� ���̴� ��� ��ȸ�Ǵ� �������� �ǹ̸� ���� �����Ͻÿ�
 --��(���� ������ ����)
SELECT
    e1.*,
    e2.first_name
FROM
    employees  e1,
    employees  e2
WHERE
    e1.manager_id = e2.employee_id(+);    
    
    /*
        ������ (+) : e1.manager_id�� ������, e2�� ��ġ�ϴ°� ��� ��µ��� ���� ���� ���
            => manager_id�� �߸��� ���, null, �Ŵ����� �������� ���� ��찡 ��µ�
        
        ���� (+) : e2.employee_id�� ������, e1.manager_id�� ��ġ�ϴ°� ��� ��µ��� ���� ����
           ���
           => ���������� ���������� ���� ��찡 ��µ�
    
    */

select * from employees where department_id is null;
select * from employees where manager_id is null;
    
--����1: �����/�μ���ȣ/�μ��̸��� ����ϵ� ����� �Ѹ� ������ ���� �μ��� ��ȸ�غ�����

--����2: �����/��åID/��å���� ����ϵ� ����� �Ѹ� ���������� ��å�� �Բ� ��ȸ�غ�����

--����3: �μ���/�ּ�/���ø��� ����ϵ� �Ҽӵ� �μ��� ���� ���õ� �Բ� ��ȸ�غ���

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
    
    
    
    














