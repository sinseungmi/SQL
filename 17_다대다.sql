/*
    # ��ƼƼ���� �ٴ�� ���谡 �߻��ϴ� ��쿡 ���Ͽ�
    
    1. �� ���� 1:�� ���踦 ����� �ذ��Ѵ� (������ �ſ� ���ϵȴ�)
    
    
    �޴�          �մ�                             �޴�           �ֹ�          �մ�
                                                        PK             FK     FK    PK
    ¥���         A                               ¥���        ¥���A       A
    «��            B               =>            «��          «��A           B
    ������         C```````````````````               ������        ������A       C
    «�͹�         D                               «�͹�        ¥��B          D
                       E                                                 «�� B        E
                                                                          ��¥��C
            
    2. �׳� �����ϰ� �� ���̺� �� ���´� (������ �������� �ʴ´�. ������ �뷮�� �� ���� �����Ѵ�)
    
    # ���� DB�� ������ ��ȸ���ֿ���
    
    1. A���� ��Ų ��� �޴��� ��ȸ
    
    2. B���� ��Ų ��� �޴��� ������ ��ȸ
    
    3. ��Ų �޴��� ������ �ѵ��� �Ѵ� �մԵ��� ������ ��ȸ

*/

--check(visit_date btween to_date('2020/01/01', 'YYYY/MM/DD') and  to_date('2021/01/01', 'YYYY/MM/DD'));

create table menu (
    menu_id number(5) 
        constraint menu_menu_id_PK primary key,
    mname varchar2(20) 
        constraint menu_mname_NN not null
        constraint menu_mname_UK unique,
    mprice number(5) default 0,
    mkcal number(5) default 0
);

alter table menu rename column mname to food_name;

create table guest (
    guest_id number(5)
     constraint guest_guest_id_PK primary key,
    temperature number(2) 
        constraint guest_temperature_NN not null,
    visitdate date,
    cardlimit number(20) default 0
);

alter table guest modify(temperature number(3,1));
alter table guest modify (visitdate date constraint guest_visitdate_CHK 
check(visitdate > to_date('2020/01/01', 'YYYY/MM/DD')));
alter table guest add (guest_name varchar2(50));
alter table guest modify (guest_name varchar2(50) default null);

create table menu_order(
    order_sequence number(5),
    food_name varchar2(20) constraint order_food_name_NN not null,
    guest_id number(5),
    
    constraint order_order_sequence_pk primary key(order_sequence),
    constraint order_guest_id_FK foreign key (guest_id) references guest(guest_id)
);

desc menu;
desc guest;
desc menu_order;

--�޴��������� Ǫ����� ����ũ ����
alter table menu_order add constraint food_name_uk unique (food_name);
select * from user_constraints where constraint_name like '%FOOD%';

alter table menu_order drop constraint FOOD_NAME_UK;


alter table menu_order add constraint menu_order_food_name_fk foreign key(food_name) references menu(food_name);

insert into menu values(1,'¥���',3000,800);
insert into menu values(2,'«��',4000,1000);
insert into menu values(3,'������',8000,1200);
insert into menu values(4,'¥���',4000,700);
insert into menu values(5,'A�ڽ�',120000,2000);
insert into menu values(6,'B�ڽ�',150000,2000);
select * from menu;
desc menu;
alter table menu modify (MPRICE NUMBER(10));

update guest set cardlimit = 300000 where guest_name = '������';
insert into guest values(1,36.5,'2021/04/05',500000,'������');
insert into guest (guest_id, temperature,visitdate,guest_name) values(2,35.5,'2021/06/23','ȫ����');
insert into guest  values(3,37,'2020/09/25',300000,'�Ž¹�');
insert into guest  values(4,36.0,'2021/05/29',1500000,'�ֿ���');
select * from guest;

insert into menu_order values(1, '«��', 2);
insert into menu_order values(2, '������', 1);
insert into menu_order values(3, '������', 2);
insert into menu_order values(4, '¥���', 3);
insert into menu_order values(5, 'A�ڽ�', 3);
insert into menu_order values(6, 'B�ڽ�', 3);
insert into menu_order values(7, 'A�ڽ�', 3);
select * from menu_order;
/*
      1. A���� ��Ų ��� �޴��� ��ȸ
    
    2. B���� ��Ų ��� �޴��� ������ ��ȸ
    
    3. ��Ų �޴��� ������ �ѵ��� �Ѵ� �մԵ��� ������ ��ȸ


*/

select guest_name,food_name from guest inner join menu_order using (guest_id) where guest_id = 1; 

select guest_id, guest_name, sum(mprice) 
from menu_order mo 
inner join guest using (guest_id) 
inner join menu m using(food_name)
where guest_id = 2
group by guest_name,guest_id;

    --cardlimit���� 8000���� ���ų� 12000 ���ų� 394000���� �� ��



select sum(mprice) from menu_order          
inner join guest g using(guest_id) 
inner join menu m using(food_name)
group by guest_id;

--any ���� ������ �������� ���������� �˻� ����� �ϳ� �̻��� ��ġ�ϸ� ���̴�. (or)

select * from guest;
select * from menu;
select * from menu_order;

/*
    SELECT empno, ename ,dname
    FROM emp e
    JOIN dept d USING (deptno)
    WHERE e.deptno=50;

 ���� ���� �������� ���� ��� ORA-25154 ������ �߻��Ѵ�.
ORA-25154������ USING ������ �� �� ���̴� ���� ������ ���̸� �߻��Ѵ�.
��, ���� �������� USING ���տ� ���̴� ���� deptno�� WHERE�������� emp ���̺��� ������ e�� �ٿ��� ������ ������ �߻��ϴ� ���̴�.

USING�� ����� ���տ���, ���� ������ �� �̸��� ���̺���̳� ���̺��� ������ ������ �� ����.
���� ���� �������� �ٸ��� ��ġ�� �Ʒ��� ����.

SELECT empno, ename, dname
FROM emp e
JOIN dept d USING (deptno)
WHERE deptno=50;

*/



--  3. ��Ų �޴��� ������ �ѵ��� �Ѵ� �մԵ��� ������ ��ȸ
SELECT
    SUM(mprice) AS ����,
    MAX(cardlimit) AS �ѵ�,
    guest_name
FROM
         menu_order
    INNER JOIN menu USING ( food_name )
    INNER JOIN guest g USING ( guest_id )
GROUP BY guest_name HAVING SUM(mprice) > MAX(cardlimit);
-- g.guest_id�� �ȵǴ� ������ ���� ���� ����

-- "group by ���� ����� ���� ������ �ɰ� ���� ��, having�� ����Ѵ�" ��� �����ϰ�,
-- ��� ������ having ���� ����ϸ� �ȵȴٴ°���!

--guest_name���� ���� ���� �� �̸����� ���� ��. �׷� having�� �� �� �̸��� ������ ������ �ϴ°�
-- �Ž¹� mprice�� �հ�� �Ž¹� max(cardlimit)�� ��. �ٵ� �Ž¹��� cardlimit�� �� 30�����̱� ������
--min�� �ϴ� max�� �ϴ� �Ȱ���.having�� �Ϲ� �÷� ���� ���� ���ϱ� ������ �׷��Լ��� �����Ѵ�

/*
    ���������� �ִ� ���, ���� �̸��� ���� �ڿ� ������ �ٸ��ٸ�, ���� �ٸ� �׷����� �����Ǿ� ����������
    �������ο� ������ ���� �������� ���� ���, �ٸ� ����� ���� �׷����� ���̰ԵǾ� ���� ����� �� �� �ֽ��ϴ�.
    
     �����ȣ  �̸�                �Ի���           �޿�    ��å

     1111    Aaron    1980/06/23 00:00:00,   400,    ���
     1112    Aaron     1980/06/23 00:00:00,  400,    ���
     ��, Name �÷��� �ߺ� �����ϱ⶧����, �ߺ��� ���� �� ������ �׷��� �÷��Դϴ�.

     �׷��Ƿ� ���� �ĺ��ڿ� ���� �ߺ��� �� ���� ������ȣ(profno), �й�, �����ȣ�� ���� �÷��� �׷��� �÷����� �����ϴ°� �����ϴ�.

*/


SELECT
    *
FROM
         menu_order
    INNER JOIN menu USING ( food_name )
    INNER JOIN guest USING ( guest_id );









