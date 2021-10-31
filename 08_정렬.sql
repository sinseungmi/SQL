/*
    #ORDER BY��
    -���ϴ� �÷� �������� �����Ͽ� ��ȸ�� �� �ִ�.
    - ORDER BY �÷��� [ASC/DESC]
    - ASC : ASCENDING ,��������(���� ����)
    -DESC : DESCENDING, ��������

*/
SELECT
    *
FROM employees;  -- �⺻�����δ� PK������ ��ȸ�ȴ�

select * from employees order by salary desc;
select * from employees order by salary asc;
select * from employees order by salary;  -- ������ �����ϸ� �⺻������ asc�� ���ĵȴ�

/*
   # �ش� �÷��� null�� ���ԵǾ� �ִ� ���
    ���� �������� ��ȸ�ϸ� ���� ���߿� �����ϰ�
    ������������ ��ȸ�ϸ� ���� ���� �����Ѵ�.
*/
select * from employees order by commission_pct desc;
select * from employees order by commission_pct asc;

--�������� ���� ������ ������ �� �ִ�(asc�� ��������)
-- ���� ���޼����� �������� ���� ��, ������ ���ٸ� �̸� �������� ����
select * from employees order by job_id asc, first_name desc; 

--����1: ��� ������� �μ���ȣ ���� ������������ ��ȸ�غ�����
--����2: ��� ������� �ֱ� �Ի��� ������� ��ȸ�غ�����
--����3: �̸��� i�� ���ԵǾ� �ִ� ������� ���� ���� ���� �޴� ������� ��ȸ�غ�����
--����4: 80�� �μ��� 50�� �μ��� ������� �μ���ȣ ���� ������������ ��ȸ�ϰ�,
--          �μ���ȣ�� ���ٸ� last_name �������� ���ĺ������� ��ȸ�غ�����


select * from employees order by department_id;
select * from employees order by hire_date desc;
select * from employees where first_name like '%i%' order by salary * (1 + nvl(commission_pct,0)) desc;
select * from employees where department_id in (80,50) order by department_id, last_name;











