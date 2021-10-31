/*
    # dual ���̺�
    - ������ ���̺�
    - �ϳ��� �ุ ������ ����
    -�Լ��� ���� ������ �˰� ������ Ư�� ���̺��� ������ �ʿ���� dual ���̺��� �̿��Ͽ� �Լ��� ���� ����(return)���� �� �ִ�.

*/
SELECT 3 * 2 FROM dual;   --DB�� ������ ����ֳ� �����غ��� ��
SELECT 1 FROM dual;


--ABS(n) : ���밪
SELECT ABS(-123) FROM dual;

-- FLOOR(d) :  ����
SELECT FLOOR(123.355) FROM dual;

-- ROUND(n) �ݿø�
SELECT ROUND(123.5555) FROM dual;
SELECT ROUND(123.5555, 31) FROM dual;


-- CEIL(n) : �ø�
SELECT CEIL(123.111) FROM dual;

--MOD(n, m) : ������ ����
SELECT MOD(13,10) FROM dual;

-- TRUNC(value, m) : ������ �ڸ� �� ���ϸ� �߶󳽴�. TRUNC �Լ��� �ַ� �Ҽ��� ���� �� ��¥�� �ð��� ���� �� ����Ѵ�.
SELECT trunc(123.1234, 3) FROM dual;
SELECT trunc(123.1234, 2) FROM dual;
SELECT trunc(123.1234, 1) FROM dual;
SELECT trunc(123.1234, -1) FROM dual;
SELECT trunc(123.1234, -2) FROM dual;

-- ���� �ð��� �����ִ� sysdate

SELECT sysdate FROM dual;

SELECT trunc(sysdate, 'YEAR') FROM dual;
SELECT trunc(sysdate, 'MONTH') FROM dual;
SELECT trunc(sysdate, 'DAY') FROM dual;

--TO_CHAR�� DATEŸ�� �����͸� ���ϴ� �������� �����ϱ�
SELECT TO_CHAR(sysdate, 'YYYY/MM/DD HH24:MI:SS') FROM dual;
SELECT TO_CHAR(TRUNC(sysdate, 'YEAR'), 'YYYY/MM/DD HH24:MI:SS') FROM dual;
SELECT TO_CHAR(TRUNC(sysdate, 'MONTH'), 'YYYY/MM/DD HH24:MI:SS') FROM dual;
SELECT TO_CHAR(TRUNC(sysdate, 'DAY'), 'YYYY/MM/DD HH24:MI:SS') FROM dual;

SELECT LOWER('ABC') FROM dual;
SELECT UPPER('abc') FROM dual;

SELECT SUBSTR('Hello, world!!', 2, 5) FROM dual; -- 1 base (����� �ε����� 1���� ����, 0���͵� ����)
SELECT SUBSTR('Hello, world!!', 5) FROM dual; -- ���ڸ� �ϳ��� ������ ���� ���ں��� �� �ڱ��� �ڸ���

-- ���ڿ� ����
SELECT LENGTH('of the people, by the people, for the people,') FROM dual; 


-- LPAD(����, ����, ä�﹮��)
-- RPAD(����, ����, ä�﹮��)
-- �� ä�� ���ڰ� ������ ��� ���� ����
SELECT LPAD('title', 10, '#') FROM dual;
SELECT RPAD('title', 10, '#') FROM dual;
SELECT RPAD('title', 10) FROM dual;


-- LTRIM(����, ������ ����)
-- RTRIM(����, ������ ����)
-- �� ������ ���ڰ� ������ ��� ���� ����
SELECT LTRIM('#####TITLE', '#') FROM dual;
SELECT RTRIM('#####TITLE#####', '#') FROM dual;

SELECT '     TITLE' FROM dual;
SELECT LTRIM('     TITLE') FROM dual;

-- TRIM() : �� ���� Ư�� ���ڸ� �����Ѵ�
-- �� ������ ���ڰ� ������ ��� ���� ����
SELECT TRIM('    title  ') FROM dual;
SELECT TRIM('#' FROM '#####title###') FROM dual;


--��¥ �����ϱ�
SELECT
    sysdate -1 AS ����,
    sysdate  AS ����,
     sysdate  +1 AS ����,
      sysdate +2 AS "���� ��" --���⸦ �ϱ� ���ؼ� ""�� �ؾ���
FROM
    dual;

-- ��¥���� �����ϸ� �� ��¥ ������ �ð��� ���� �� �ִ�
SELECT last_name, FLOOR(sysdate - hire_date) AS �ٹ��� FROM employees;
    
-- MONTH_BETWEEN : �� ��¥ ������ ���� ���� ���Ѵ�.
SELECT last_name, FLOOR(MONTHS_BETWEEN(sysdate, hire_date)) AS �ٹ����� FROM employees;

-- ADD_MONTHS(date, n) : DATEŸ�� �����Ϳ� ���ϴ� ���� ���� ���Ѵ�
SELECT ADD_MONTHS(sysdate, 5) FROM dual;

--NEXT_DAY(date, ����) : DATEŸ�� �����͸� �������� ���� ������ ã�´�
SELECT NEXT_DAY(sysdate, 'ȭ����')FROM dual;
SELECT NEXT_DAY(sysdate, 'ȭ')FROM dual;

--LAST_DAY(date) : DATEŸ�� �����͸� �������� �ش� ���� ������ ��¥�� ��ȯ�Ѵ�
SELECT LAST_DAY(sysdate) FROM dual;

/*
    # ����Ŭ�� ��¥ ����
     
     CC : ����
     YYYY :  �⵵
     YY : �⵵ (2�ڸ�)
     MM : ��
     MON : ���� ���ڷ�
     DD :  ��¥
     DAY : ����
     DY :���� (����)
     HH, HH12 : 12��
     HH24 : 24��
     MI : ��
     SS : ��
     AM, PM : ���� ���� ǥ��
     
     # ����Ŭ�� ���� ����
     0 : �ڸ����� ��Ÿ����. ������ ��� 0���� ä���
     9 :  �ڸ����� ��Ÿ����. ���ڰ� ��� ��ĭ���� ä���
     L :  �� ������ ��ȭ ��ȣ�� ���δ�
     . :  �Ҽ����� ����Ѵ�
     , : õ ������ �����ϴ� ��ǥ�� ����Ѵ�
     

*/

-- TO_CHAR : ���ڸ� ���ڷ� �ٲٰų�, ��¥�� ���ڷ� �ٲ۴�. �ٲ� �� ������ �̿��� �� �־ ���ϴ�
SELECT TO_CHAR(sysdate, 'MON MM MI DY DD') FROM dual;
SELECT TO_CHAR(sysdate, 'CC YYYY MON DD DY HH24:MI:SS PM') FROM dual;

SELECT TO_CHAR(15000000, '999,999,999,999,999L') FROM dual;
SELECT TO_CHAR(15000000, '000,000,000,000,000L') FROM dual;

--TO_NUMBER : ���ڸ� ���ڷ� ��ȯ, ������ �̿��� �ٽ� ���ڷ� ��ȯ�� �� �ִ�
SELECT TO_NUMBER('15,000,000��', '99,999,999L') FROM dual;
select to_char(1455644, '9999999.99') from dual;
select to_number('55.55555', '99.99999') from dual;





