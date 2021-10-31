/*
    # Ʈ�����(Transaction)
    -Ʈ�����(Transaction)�� �����ͺ��̽��� ���¸� ��ȯ��Ű�� �ϳ��� ���� ����� �����ϱ� ���� �۾��� ���� 
        �Ǵ� �Ѳ����� ��� ����Ǿ�� �� �Ϸ��� ������� �ǹ��Ѵ�.
    - ������ ó���� �� ����
    - �ϳ��� ������ �۾��� �����ϰ� ������ �ɶ� ������ ������ Ʈ������̶� �Ѵ�.
    - ex : �۱� Ʈ�����
            1. ������ ����� ���忡�� ���� �پ���
            2. �޴� ����� ������ ���� �þ��
    - �ϳ��� Ʈ������� ���� ��ɾ��� �����̴�.
    - Ʈ������� ��� ������ ���������� �Ϸ�Ǵ� ��쿡�� ���� ������ Ȯ�� ���´�
      (all or nothing) (�ٵȴ� �Ǵ� ó�����Ѵ�)
    - Ʈ������� �����ϱ� ���� ���Ǵ� TCL(TRANSACTION CONTROL LANGUAGE)�δ� 
        commit, rollback, savepoint ���� �ִ� (Ʈ������� �����ϴ� ���)
    -Ʈ������� ���������� ����� Ŀ��(�Ǵ� �ѹ�) ���� ���� 
       ���ο� Ŀ���� �����ϴ� �������� �����ϴ� ��� DML�� �ǹ��Ѵ�
    -Ʈ������� DML�� �����Ѵ�
        
        *���⼭ create table���� �������� �� �ѹ� �Ǵ� ����
       commit -> insert1 -> insert2 -> update -> create table -> delete1 -> �����߻�(rollback) -> commit
       
       DDL�� �ѹ��� ��� �ƴ�
      
*/
UPDATE fruits SET fcolor ='GREEN' WHERE fname ='Kiwi';
select * from fruits;
ROLLBACK;

commit;
select * from coffees;

truncate table coffees;  --���̺��� �����ϴ� DDL. Ʈ����� ���� ��� �ƴ�
    --���̺��� ��� ������ �ڸ���. drop table�� �ٸ��� ������ �����.
    --create table, drop table, truncate table���� DDL�� Ʈ��������� ������ �� ����

rollback;

--����1 : coffees ���̺� ���ϴ� ���ο� �÷��� �߰��غ�����
--����2 : �÷��� �̸��� �� �� �����غ�����
--����3 : insert����  ����� ����� �� �޴��� 5�� �̻� �־���� 

alter table coffees rename column coffee_id to animal_id;
alter table coffees rename column cname to animal_type;
alter table coffees rename column price to animal_name;
alter table coffees modify (animal_name varchar2(30));
alter table zoo add(animal_age number(5));

desc coffees;

rename coffees to zoo;

select * from coffees;

insert into zoo values(1,'������','��',10);
insert into zoo values(2,'�����','�Ƴ��ܴ�',5);
insert into zoo values(3,'������','ȣ����',2);
insert into zoo values(4,'������','�ڳ���',8);
insert into zoo values(5,'�����','�ź���',20);

select * from tabs;

create table coffees (
    coffee_id number(5),
    cname varchar2(50), 
    price number(5)
);

INSERT INTO coffees(coffee_id, cname, price) VALUES(1, '�Ƹ޸�ī��', 2000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(2, '���̽� �Ƹ޸�ī��', 2000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(3, 'ī���', 3000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(4, '���ν����', 8000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(5, 'īǪġ��', 6500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(6, 'ī�� �񿣳�', 7000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(7, '����������', 1500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(8, '�ݵ� ���', 5000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(9, '���������� ���ĳ�', 5000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(10, 'ī�����', 4500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(11, 'īǪġ��', 4500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(12, '��� �����', 7500);

INSERT INTO coffees(coffee_id, cname, price) VALUES(13, 'ũ�������Ƹ�� ���', 3500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(14, '��ī����Ĩ ��Ű', 3500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(15, '��������Ĩ ��Ű', 3500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(16, 'ġ�� ����ũ', 4500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(17, '���ڹ��� ����ũ', 4500);

select * from coffees;


alter table coffees add(bitter char(15));
alter table coffees modify(bitter char(15));

update coffees set bitter = '�ڡڡڡ١�';  --���� ���ڷ� �ִ°� ����. ������ �ڹٿ��� for�� ������ ��.DB�� �ް��Ѱ� �� ���ڷ�  �����ϴ°� ����.

commit;

--insert,update,delete�� DML�̱� ������ rollback���� �ٽ� �ǵ��� �� �ִ�
insert into coffees values(18, '������', 8000, null);
savepoint save01;
-- savepoint : ������ Ʈ�������� �۰� �����ϴ� ��ɾ��̴�.

delete coffees where coffee_id between 3 and 10;
savepoint save02;

update coffees set cname = replace(cname, '�Ƹ޸�', '��Ż��');
savepoint save03;

rollback;   --�ѹ��� Ŀ�� �������� ���ư���
rollback to save03;  -- ���� Ʈ������ ���� Ư�� SAVEPOINT���� ROLLBACK �� �� �ְ� �ȴ�.
rollback to save02;
rollback to save01;
rollback to save02; 
--save01�� ���ư��� save02�� ���� �����̹Ƿ� ���߿� ������ ���̺� ����Ʈ�δ� ���ư� �� ����.

select * from coffees;

--employees�� �������� �ڽ��� ���� �� �ִ� ���� ����������
--�� �ۼ�Ʈ ������ ������ �ް� �ִ��� ���� ���� ���·� ��ȸ�غ�����(Ŀ�̼ǵ� ����)



















