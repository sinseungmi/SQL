--DDL

/*
    # ���������� ���̺� �����ϱ�
    - create table ���̺�� as (��������)�� ���̺��� ������ �� �ִ�

*/
create table copied_coffees as (select * from coffees);

desc copied_coffees;

create table bingsu as (select * from coffees where cname like '%����');

select * from bingsu;


/*
    # ���̺� �� �÷� �߰��ϱ�
    - alter table ���̺��  add (�÷���, �÷�Ÿ��,...)
*/
alter table bingsu add (sirup varchar2(20));


/*
    # ���̺��� �÷� �̸� �����ϱ�
    - alter table ���̺�� rename column �����̸� to �ٲ��̸�;
*/
alter table bingsu rename column sirup to syrup;


/*
    # ���̺� �̸� �����ϱ�
    - rename �������̺�� to �ٲ����̺��;
*/
rename bingsu to bingsoo;
rename copied_coffees to coffees2;

select * from bingsoo;

select * from tabs;


/*
     # �÷��� Ÿ�� �����ϱ�(�̰� Ÿ�Ը� �����ϴ°���.�̸����� �����ϴ� �� �ƴ�)
     - alter table ���̺�� modify (�÷��� �÷�Ÿ��,...);
*/
select * from bingsoo;

alter table bingsoo modify (cname varchar2(30)); 

update bingsoo set cname = '����';

insert into bingsoo values (101, '��Ʈ����ī������ξ��ø������', 7500, '����');


/*
    # �÷� �����ϱ�
     alter table ���̺�� drop column  �÷���;
*/
select * from bingsoo;

alter table bingsoo drop column syrup;




















