/*

    # SELECT �÷��� FROM ���̺��;
    - �����͸� ��ȸ�ϴ� ������
    - �÷��� *�� ���� ���� ��� �÷��� ���Ѵ�.
    - �÷���/���̺���� ��ҹ��ڸ� �������� �ʴ´�
    - �������� ��ҹ��ڸ� ���������ʴ´�
    - �����ʹ� ��ҹ��ڸ� �����Ѵ�(�߿�!)


*/

-- tab, tabs�� � ���̺���� �ִ��� Ȯ���� �� �ִ�
SELECT * FROM tab;
SELECT * FROM tabs;
SELECT table_name FROM tabs;

-- *�� ������ ��� �÷��� ��ȸ�ϰ�, �÷����� ������ �ش� �÷��� ��ȸ�Ѵ�
SELECT * FROM employees;
SELECT first_name FROM employees;
SELECT first_name, salary FROM employees;

/*
    # ������ ���̺� ����
    EMPLOYEES :  ��� ������ ������ ���̺�
    DEPARTMENTS : �μ� ������ ������ ���̺�
    JOBS : ���� ������ ������ ���̺�
    LOCATIONS : ���� ������ ������ ���̺�
    COUNTRIES : ���� ������ ������ ���̺�
    REGIONS : ��� ������ ������ ���̺�

*/

SELECT * FROM departments;
SELECT * FROM locations;
SELECT * FROM jobs;
SELECT * FROM countries;
SELECT * FROM regions;

--���̺� �÷� ���� ����
--  DESC : Ư�� ���̺� � Į���� �ִ��� ������ �������� ��ȸ�ϴ� ��ɾ�
DESC employees;
DESC departments;
DESC countries;
DESC jobs;
DESC regions;

/*
        # NUMBER(n), NUMBER(n,m)
        - ���� �����͸� ������ �� �ִ� �÷�
        - ���ڰ� �ϳ��� ���������� ������ ����, ���ڰ� �ΰ� ���� ������ �Ǽ��� ����
        - NUMBER(10) : 10 �ڸ� ������ �����ϴ� �÷��� �ȴ�
        - NUMBER(10,4) : 6�ڸ� ������ �Ҽ��� 4�ڸ��� �����ϴ� �÷��� �ȴ�
        
        # VARCHAR2(n)
        - ���� ���� ���� �����͸� �����ϴ� �÷� Ÿ��
        -  ����Ǵ� �������� ũ�⿡ ���� �˸��� ������ ����Ѵ�
        -  VARCHAR2(10)���� ������ �÷��� �����ͷ� 2���ڰ� ������ 2����Ʈ�� ����Ѵ�
        - �������� �����͸� ������ ���� �����Ͱ� ������ڸ� ũ�� ����� �ʿ��ϴ�
        
        # CHAR(n)
        - ���� ���� ���� �����͸� �����ϴ� �÷� Ÿ��
        - ������ ���� ���� ���� ���� �����Ͱ� �������� ������ ���̸� ��� �����Ѵ�
        - CHAR(10)���� ������ �÷��� �����ͷ� 2���ڰ� ������ 10 ����Ʈ�� ��� ����Ѵ�
        - �����Ͱ� ����� ���� ������ ũ�� ����� ���� ������ �ӵ��� �� ������
          * �������� �����ʹ� ����, �������� �����ʹ� ĳ���Ͱ� ����
          
        # DATE
        - ��¥ �� �ð��� �����ϴ� �÷� Ÿ��

*/

SELECT * FROM countries;

-- ����1: ��� ����� �����ȣ/�̸�(firstname)/����/�μ���ȣ�� ��ȸ�غ�����

desc employees;

SELECT employee_id as �����ȣ, first_name as �̸�, salary as ����, department_id as �μ���ȣ
FROM employees;


SELECT EMPLOYEE_ID,FIRST_NAME,SALARY,DEPARTMENT_ID FROM EMPLOYEES;

-- AS�� �̿��� ���ϴ� �÷������� ��ȸ�� �� �ִ�
SELECT EMPLOYEE_ID AS �����ȣ,
            FIRST_NAME AS �̸� ,
            SALARY AS ����,
            DEPARTMENT_ID AS �μ���ȣ
FROM 
            EMPLOYEES;

-- ��� �����ڸ� �̿��� ���� �� ����ϱ�
SELECT last_name, salary FROM employees;
SELECT last_name, salary + 500 FROM employees;
SELECT last_name, salary * 2 FROM employees;
SELECT last_name, salary * 0.9 AS �谨�ȿ��� FROM employees;

SELECT * FROM employees;
                                            --���ʽ�
SELECT last_name, salary, commission_pct FROM employees;
SELECT last_name, salary * (1 + commission_pct) as "���ʽ� ����" FROM employees;
                                        --1�� ���ϴ� ������ �����̶� ���ʽ� ���� ���� ���� ��ȸ�ϱ� ����
                                        --0.4�� 40����
                                        
-- �� ���ڿ�( '' )�� NULL�� �ν�
-- null�� ����� �ȵǱ� ������ ��ü ���� �ʿ��ϴ�
-- NVL(�÷���, ��ü��) : �ش� �÷����� Null���� ������ �� ��ü ���� ����Ѵ�
SELECT last_name, salary * (1 +NVL( commission_pct, 0)) AS ���ʽ������� FROM employees;

-- ����2 : ��� ������� ���/�����̸�/������ ����غ�����(salary�� �����Դϴ�. ��Ī ����� ��)
select employee_id as �����ȣ, last_name as �����̸� , salary * 12 as ����, salary * 11 + (salary * (1 + nvl(commission_pct, 0))) as ���ʽ����� from employees;

SELECT employee_id AS �����ȣ, 
            last_name AS �����̸�, 
            job_id,
            salary * 12  * (1 +NVL( commission_pct, 0)) AS ����, 
            salary * 11 + (salary * (1 +NVL( commission_pct, 0))) AS ���ʽ�������  
FROM 
            employees;

--SELECT DISTINCT : �ߺ� �Ǵ� ������ ������ �־ �ѹ��� ��µȴ�

--employees�� �����ϴ� ��� ��å�� ���� ���� ���
SELECT DISTINCT job_id FROM employees;
SELECT DISTINCT department_id FROM employees;
SELECT DISTINCT manager_id FROM employees;

SELECT DISTINCT
    last_name
FROM
    employees;



