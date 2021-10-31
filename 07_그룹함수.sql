/*
    # �׷� �Լ�

      - ���� ���� ���� Ư�� �÷��� �������� �׷�ȭ �ϴ� �Լ���
      - Ư�� ������ ����, ����, ��� ���� ���� �� �ִ�
      - �׷��� ������ �Ǵ� �÷��� GROUP BY���� ���� �����Ѵ� 
      - �׷� �Լ��� ����� �Ϲ� �÷��� �Բ� ��µ� �� ����.������ �׷��� ������ �Ǵ� �÷��� ����� �����ϴ�
      
      
      �׷쿡 ���� ������ where ���� �ƴ�, having ���� ����ؾ� �մϴ�. 
      avg(height)�� group by ���� ����� ���Ŀ� �����ؾ��ϹǷ�, where ���� ����� �� ���� ������.
      where �� -> group by �� -> having �� �� ������ ����

*/
SELECT SUM(salary) FROM employees;

-- ��å�� �� ����
SELECT job_id, SUM(salary) FROM employees GROUP BY job_id;   --�׷��� ������ �Ǵ� job_id�� �Բ� ��� ����

-- ��å�� ��� ����
SELECT job_id, AVG(salary) FROM employees GROUP BY job_id;

-- SUM(column) : �׷� ���� �ش� �÷��� �� ���� ���Ѵ�
SELECT department_id, sum(salary) FROM employees GROUP BY department_id;

-- AVG(column) : ���
-- MAX(column) : �ִ밪
SELECT department_id, max(salary) FROM employees GROUP BY department_id;

-- MIN(column) : �ּҰ�
-- COUNT(column) : ����
-- COUNT(*) - ��ȸ�� ��ü�� �Ǽ��� ��ȯ�Ѵ�
SELECT department_id, COUNT(*) FROM employees GROUP BY department_id;


-- ����1: �μ����� ���� �ֱٿ� ����� �Ի��� ��¥�� ���� �������� �Ի��� ��¥�� ������ִ� �������� �ۼ�

select department_id,to_char(min(hire_date), 'YYYY/MM/DD') as ���������Ի�,
to_char(max(hire_date), 'YYYY/MM/DD')  as �ֱ��Ի� 
from employees group by department_id;

SELECT
    department_id,
    MAX(hire_date) AS "���� �ֱ�",
    MIN(hire_date) AS "���� ������ �ΰ�"
FROM
    employees
GROUP BY
    department_id;

-- ����2: ���ʽ��� �޴� ����� �� �μ��� �� �� �ִ��� ����� �������� �ۼ�

select department_id, count(*) from employees where COMMISSION_PCT is not null group by department_id;

SELECT
    department_id,
    COUNT(commission_pct)  --null�� �ȼ��� 0.
FROM
    employees
GROUP BY
    department_id;

-- ����3: �� ���޺� ��� ������ ���غ����� (�� ���� �ƴ�, Ŀ�̼� ����, �Ҽ��� ��° �ڸ����� ���)

select job_id, to_char(avg(salary * 11 + (salary * (1 + nvl(commission_pct, 0)))), '999999999.99') as ��տ��� from employees group by job_id;

SELECT
    job_id,
    SUM(salary * 12 *(1 + nvl(commission_pct, 0))) / COUNT(*) AS "JOB�� ��� ����"
FROM
    employees
GROUP BY
    job_id;

-- GROUP BY�� ���� �÷��� ������ ���� �ִ�
SELECT
    job_id, department_id,
    TO_CHAR(AVG(salary * 12 *(1 + nvl(commission_pct, 0))), '999999999.99') AS "JOB�� ��� ����"
FROM
    employees
GROUP BY
    job_id, department_id;

/*
    - GROUP BY�� ������ �׷쿡 ������ �ְ� ���� ���� HAVING���� �̿��Ѵ�
    - WHERE �������� �����Լ��� ��� �� �� ����.(avg(), sum() ���� ��)
    - HAVING ���� �����Լ��� ������ ���Ǻ񱳸� �� �� ����Ѵ�.
     
      
      "group by ���� ����� ���� ������ �ɰ� ���� ��, having�� ����Ѵ�" ��� �����ϰ�,
     ��� ������ having ���� ����ϸ� �ȵȴٴ°���!
     
     */
SELECT job_id, count(*) FROM employees GROUP BY job_id;

-- �� WHERE�� �׷��� �����Ǳ� ���� ��� �࿡ ����Ǵ� �����̴�
SELECT job_id, count(*) FROM employees WHERE salary <= 5000 GROUP BY job_id;
select job_id,salary, count(*) from employees group by job_id,salary having min(salary) <= 5000;

-- ȸ�翡 5�� ���Ϲۿ� ���� ��å�� ��� ���
SELECT job_id, count(*) FROM employees GROUP BY job_id HAVING count(*) <= 5;

-- ȸ�翡 3�� ���Ϲۿ� ���� ��å�� ��� ���
SELECT job_id, count(*) FROM employees GROUP BY job_id HAVING count(*) <= 3;


SELECT
    *
FROM employees;


-- ����1: �μ��� �ִ� �޿��� �ּ� �޿��� ����ϵ� �ִ� �޿��� 5000�̻��� �μ��� ����غ�����

-- ����2: �μ��� ��� �޿��� ����ϵ� �ش� �μ��� �Ҽӵ� ����� 10�� �̻��� �μ��� ����غ�����

SELECT department_id, MAX(salary),MIN(salary) FROM employees GROUP BY department_id HAVING MAX(salary) >= 5000;
SELECT department_id, trunc(AVG(salary), 2), COUNT(*) FROM employees GROUP BY department_id HAVING  COUNT(*) >= 10;












