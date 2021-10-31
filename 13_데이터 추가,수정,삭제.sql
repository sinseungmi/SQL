
desc coffees;
select * from coffees;

/*
    # ���̺� ������ �߰�
    - insert into ���̺��(�÷���,,,) values(��,,);  
*/
insert into coffees(coffee_id, cname, price) values(1, '�Ƹ޸�ī��',2000);
insert into coffees(coffee_id, cname, price) values(2, '���̽� �Ƹ޸�ī��',2500);
insert into coffees(coffee_id, cname, price) values(3, 'ī���',3000);

-- �Ϻ� �÷����� ������ �߰��ϱ� (�����͸� �������� �÷��� null�� ��)
insert into coffees( cname, price) values('�Ϻ���',5500);
insert into coffees(cname) values('�������');

--�÷����� �����ϰ� ������ �߰��ϱ� (�ݵ�� ��� �����͸� �÷� ������� �־���� �Ѵ�)
insert into coffees  values(6,'���ɺ���',6500);
insert into coffees  values('�������', 6500);

--�÷����� ��� �����ָ� ������ �������
insert into coffees(price, cname, coffee_id)  values(4000,'ī���ī',8);
insert into coffees(price, coffee_id,cname)  values(4000,6,'ļ��� �����߶�');

--insert into ���̺�� (��������)  :���������� ���̺� insert�� �� �ִ� (���������� �����ͷ� Ȱ�� �� �� �ִ�)
insert into coffees (select * from coffees);  --�ڰ� ���� ���� ����
desc coffees;


select * from coffees order by coffee_id;

/*
     # ���̺� ������ ����
    -update ���̺�� set �÷�=�� where ����;
    - update ������  �������� ������ ��� ���� �����Ѵ�
    - ������ �ִٸ� ������ �����ϴ� ��� ���� �����Ѵ�
    - �ϳ��� ���� ������ �� �ִ� �⺻Ű�� �Բ� ���Ǵ� ��찡 ����
*/
update coffees set price = 1000;

update coffees set price = 2000 where cname like '%�Ƹ޸�ī��%';

update coffees set price = price + 500 where cname like '%���̽�%';

--���� �÷��� ������ ���� ��ǥ�� ����Ѵ�
update coffees set price = 5000, coffee_id = 100 where cname like '%����';

--����1: ������ �ƴϰ�, �Ƹ޸�ī�뵵 �ƴ� ��� ��ǰ���� ������ 3õ������ �����ض�
update coffees set price = 3000 
where cname not like '%�Ƹ޸�ī��%' and cname not like '%����';

select * from coffees;

/*
    # ���̺� ������ �����ϱ�
    - delete from ���̺�� where ����;
    - ���ǿ� �´� ����ü�� �����Ѵ�(Ư�� �÷� ���� �����ϴ� ���� update�� �ش��Ѵ�)
    -  ���� ������  �������� ������ ��� ���� �����Ѵ�
    - ������ �ִٸ� ������ �����ϴ� ��� ���� �����Ѵ�
    - �ϳ��� ���� ������ �� �ִ� �⺻Ű�� �Բ� ���Ǵ� ��찡 ����

*/

/*
    - ��� ������ �������� ����Ǿ��ٸ� ���ݱ��� ������ ��� �۾��� '������' �����϶�� 
        ����� ���� �� �ִµ� �� ���� ����� �ٷ� 'COMMIT' ���
    - ���� �����ͺ��̽��� �����Ϸ��� COMMIT�� �ؾ��Ѵ�.
*/
commit;   --��������� ��Ȳ�� �����ϰڴ�
select * from coffees;

delete from coffees where cname like '%����';

--ROLLBACK�� ���� �� ���������� COMMIT�� �����ߴ� �������� ���ư�
ROLLBACK;








