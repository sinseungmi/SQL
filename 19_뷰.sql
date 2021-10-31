/*
    # �� (View)
    
    - �������� �⺻ ���̺���� �̿��� ������ ������ ������ ���̺�
    - �⺻ ���̺��� �Ļ��� DB ��ü
    - �並 ���� �����(������)�� �⺻ ���̺���� ���������� ����ϰԲ� �� �� �ִ�
        
    create [or replace] view ���̸� 
        as �������� 
            [with check option| with read only];
        
    - create or replace : �̹� �����ϴ� ���� ������ �Ѵ�. ���ٸ� �����Ѵ�
    - with check option : �ش� �並 ���� update�� insert�� ���������� (�������� DML)
        with check option�� view�� ���� �� �ش� �������� �ȿ����� ����,����,������ �����ϴٴ� ���Դϴ�.

    - with read only : �ش� ��� select�� ���������� (DML ����)
*/

-- �� ������ ��ųʸ�
select * from user_views;
select * from all_views;

SELECT first_name,department_id,department_name,city FROM DEPARTMENTS INNER JOIN EMPLOYEES 
USING(department_id) INNER JOIN locations USING(location_id) WHERE first_name LIKE '%en%';

--�⺻ �ɼ� ��
CREATE OR replace view dept30_view as
    SELECT
        employees.*
    FROM
        employees
    WHERE
        department_id = 30;
    
select * from dept30_view;

--�⺻ �ɼ� �並 ���ؼ��� �����ο� insert�� �����ϴ� (�����ڰ� insert�� ������ �� �ִ�)(�並 ���ؼ� ���̺� �ٲ�)
insert into dept30_view values
(1, 'Gildong', 'Hong', 'Ghong', '515.127.4444', sysdate, 'IT_PROG', 1000, null, 100, 70); 

select * from employees;


--�б� ���� ��
CREATE OR replace view dept50_view_readonly as
    SELECT
        employees.*
    FROM
        employees
    WHERE
        department_id = 50;
with read only;

select * from dept50_view_readonly;


--�б� ���� �並 ���ؼ��� DML �۾��� ������ �� ����
insert into dept50_view_readonly values
(1, 'Gildong', 'Hong', 'Ghong', '515.127.4444', sysdate, 'IT_PROG', 1000, null, 100, 70); 


select * from employees;
rollback;


--üũ �ɼ� ��
CREATE OR replace view dept80_view_check as
    SELECT
        employees.*
    FROM
        employees
    WHERE
        department_id = 80;
with check option;
    
select * from dept80_view_check;

--80�� �μ� ����鸸 ��ȸ�ϴ� ���̱� ������, 80�� �μ��� ���õ� DML�� ����� �� �ְ� �ȴ�.
insert into dept80_view_check values
(4, 'Jaedong', 'Hong', 'HJaedong', '515.127.4446', sysdate, 'IT_PROG', 1000, null, 100, 30); 

--80�� �μ����� DML�� �����ϴ�
insert into dept80_view_check values
(2, 'Jaedong', 'Hong', 'Haedong', '515.127.4446', sysdate, 'IT_PROG', 1000, null, 100, 80); 

select * from user_constraints where constraint_name ='EMP_EMAIL_UK';

/*
    # ����
    - drop view ��name
    ��� �ٸ� ���̺��� ������ �ϰ� ���� ���̹Ƿ� �並 �����ϴ��� 
    ���� �䰡 �����ϰ��ִ� ���̺� �ִ� �����ʹ� �������� �ʽ��ϴ�. 
*/


drop view dept80_view_check;

delete from employees where employee_id in (1,2,4,3);










