/*
    # ������ ���Ἲ
    - �����Ϳ��� ������ ����� �Ѵٴ� ��
    - ��ü ���Ἲ, ���� ���Ἲ,������ ���Ἲ...

    # ��ü ���Ἲ
    - ���̺��� �����ʹ� �ݵ�� �� ���� ������ �� �־���Ѵ�
    - ��ü ���Ἲ�� ��Ű�� ���� ���� �������� PK�� ����Ѵ�
    
    # ���� ���Ἲ
    - ���� ���迡 �ִ� �����ʹ� �׻� �ϰ��� ���� ������ �Ѵ�
        (employees�� department_id�� departments�� department_id�� �����ϴ� ���� ����ؾ��Ѵ�)
    - ���� ���Ἲ�� ��Ű�� ���� ���� �������� FK�� ����Ѵ�
    
    # ������ ���Ἲ
    - �ش� �������� �����ϴ� ��ü���� �׻� Ÿ���� �����ؾ��Ѵ�
    - ���̺��� �÷� Ÿ�� ���� �� check�� ���ؼ� ������ ���Ἲ�� ��Ű�� �ִ�
    
    # ������ ���Ἲ ���� ����
    - not null : �ش� �÷��� null�� ������� �ʴ� ��Ģ
    - unique : �ش� �÷��� �ߺ��Ǵ� ���� ������� �ʴ� ��Ģ. �׻� ������ ���� ������ �Ѵ�
    - primary key : �ش� �÷��� �⺻Ű�� �����Ѵ�. not null+ uniqe. ���̺� �� �ϳ��� ���� ����
    - foreign key : �ش� �÷��� �ܷ�Ű�� �����Ѵ�
    - check : ���ϴ� �������� ������ ���� �����Ͽ� ������ ���Ἲ�� ������ �� �ִ�.

*/

--# ���� ���� ������ ��ųʸ��� ���� ���� ������ ��� ���� ���ǵ��� Ȯ���� �� �ִ�
select * from user_constraints; -- ���� ������ ���� ����
select * from all_constraints;  -- ���� �������� �� �� �ִ� ��� ���� ����

/*
    # ���� ���� ���̺� constraint_type
    P : primary key
    R : foreign key
    C : check / not null
    U : unique

*/

--���� ���� �ѹ��� �߰��غ���
create table fruits(
    fid number(2) primary key,
    fname varchar2(20) not null
);

desc fruits;

--uique 
alter table fruits modify (fname varchar2(20) unique);
--check() ���ο� ���ϴ� ������ �߰�
alter table fruits add(fcolor varchar(20) check(fcolor in ('RED', 'GREEN', 'BLUE'))); 

desc fruits;

insert into fruits values (2, 'Apple', 'RED');
insert into fruits values (3, 'Banana', 'BLUE');

select * from fruits;

/*
    #���̺� �����ϴ� �������� �����ϱ�
    - alter table ���̺�� drop constraint �������Ǹ�;

*/

alter table fruits drop constraint SYS_C0019519;
alter table fruits modify (fcolor varchar(10));


alter table fruits drop constraint SYS_C0019517;


update fruits set fcolor = 'Yellow' where fname = 'Banana';

/*
    # ���̺� �̹� �����ϴ� �÷��� �������� �߰��ϱ�
    - alter table ���̺�� add constraint �������Ǹ�(���� ������� �̸�) ��������(����� �÷�);
    - alter table ���̺�� modify �÷��� (���� ����);
    - not null�� check�� add constraint ��� modify�� �̿��� �߰�/�����Ѵ�
*/

alter table fruits add constraint FRUITS_FID_PK primary key(fid);

select * from user_constraints;
desc fruits;


--���� ���Ǹ��� �ڵ����� �����Ǵ� �̸����� ���� ���� ������ �� �ִ� ���� ���� �̸����� �����ؾ��Ѵ�
insert into fruits values(1, 'Orange', 'Orange');

/*
    # ���������� �߰��ϴ� ���
    
    1. ���̺� ������ ���ÿ� �������� �߰��ϱ�
    
    - �÷��� �÷�Ÿ�� constraint �������Ǹ� ��������Ÿ��
    - �ݵ�� �������� �̸��� �� ��Ģ�� �°� ������ ����
    
    2. ���̺� ���� �� �������� �߰��ϱ�
    
*/

-- #1
create table fruits2 (
    fid     number(4)       
        constraint FRUITS2_FID_PK primary key,
    fname   varchar2(20)    
        constraint FRUITS2_FNAME_NN not null
        constraint FRUITS2_FNAME_UK unique,
    fcolor   varchar2(10)
        constraint FRUITS2_FCOLOR_NN not null,
    fsize     char(1)
        constraint FRUITS2_FSIZE_CHK check (fsize in('L', 'N', 'S'))
);

desc fruits2;
select * from user_constraints where table_name = 'FRUITS2';

--# 2
create table fruits3 (
    fid     number(4)   ,   
    fname   varchar2(20) ,   
    fcolor   varchar2(10),
    fsize     char(1)
);

-- not null�� check�� add constraint ��� modify�� �̿��� �߰�/�����Ѵ�
alter table fruits3 add constraint FRUITS3_FID_PK primary key(fid);
alter table fruits3 add constraint FRUITS3_FNAME_UK unique(fname);
alter table fruits3 modify (fname varchar2(20) constraint FRUITS3_FNAME_NN not null);
alter table fruits3 modify (fcolor varchar2(10) constraint FRUITS3_FCOLOR_NN not null);
alter table fruits3 modify (fsize char(1) constraint FRUITS3_FSIZE_CHK check (fsize in('L','N','S')));


/*
    # default ���� ����
    - �ش� �÷��� �⺻���� �����س��� ���� ����
    - default�� ������ �÷��� �� �߰��� ���� ���� ������ 
        null ��� default�� ������ ���� �߰��ȴ�

*/
alter table fruits3 add (fprice number(7) default 0);
alter table fruits3 modify (fprice number(7) default 10);

select * from user_constraints where table_name = 'FRUITS3';  
desc fruits3;

/*
    # Foreign Key ���� ����
    - ���������� ������ �� � ���̺��� � �÷��� �������� �ݵ�� �����ؾ��Ѵ�
    - �ٸ� ���̺��� PK �Ǵ� UK���� ������ �ɸ� �÷��� ������ �� �ִ�
    
    
    # ���̺� ���� �� ���� - ���̺� �����ÿ� ������ ���� ���� �������� �����ؾ��Ѵ�
    CONSTRAINTS �ܷ�Ű �̸� FOREIGN KEY(�÷���) 
    REFERENCES ���� ���̺��(�����÷�)
    
    ex : 
    CREATE TABLE topics(
        user varchar2(20) NOT NULL,
        title VARCHAR2(255) NOT NULL,
        lecturekey VARCHAR2(100) NOT NULL,
        CONSTRAINT FK_TOPICS FOREIGN KEY(lecturekey)
        REFERENCES LECTURE(LID)
    );
    
    
    # ���̺� ���� �� ����
    ALTER TABLE ���̺�� 
    ADD CONSTRAINTS �ܷ�Ű �̸� FOREIGN KEY (�����÷�) 
    REFERENCES ���� ���̺��(�����÷�)
    
*/
create table fruit_locations (
    lid number(2),
    addr varchar2(200),
    city varchar2(40)

);

insert into fruit_locations values(10, '��û�ϵ� û�ֽ�', 'û��' );
insert into fruit_locations values(20, '���ϵ� �ȵ���', '�ȵ�');
insert into fruit_locations values(30, '���󳲵� ���ﱺ', '����');
insert into fruit_locations values(40, '��û���� ����', '���');

--unique �Ǵ� primary key ���� ������ �ɸ��� ���� �÷��� �ܷ�Ű�� ������ �� ����
alter table fruit_locations add constraint FLO_LIO_UK unique(lid);
alter table fruits3 add(lid number(2) constraint FRUITS3_LID_FK references fruit_locations(lid));

select * from user_constraints where constraint_name like 'FRUITS3%';  

insert into fruits3(fid, fname, fcolor, fsize, lid) values (1, 'Apple', 'Red', 'L', 10);
insert into fruits3(fid, fname, fcolor, fsize, lid) values (2, 'Banana', 'Yellow', 'N', 20);

select * from fruits3 inner join fruit_locations using(lid);
select * from fruits3;

/*
    # �������� �߰��ϴ� ���3(���̺� ������ �߰��ϱ�)
    - �÷��� ��� ������ create table�� �ڿ� ���� ���������� �����ϴ� ���
    - default�� not null�� ���̺� ���� ������� ������ �� ����

*/
create table fruits4(
    fid      number(4),
    fname varchar2(20)  constraint F4_FNAME_NN not null,  --not null�� �Ʒ��� ���� �ȵ�
    fcolor   varchar2(10) constraint F4_FCOLOR_NN not null,
    fsize     char(1),
    fprice   number(7) default 123,
    lid     number(2),
    constraint F4_FID_PK primary key(fid),
    constraint F4_FNAME_UK unique(fname),
    constraint F4_FSIZE_CHK check(fsize in ('L', 'N', 'S')),
    constraint F4_LID_FK foreign key (lid) references fruit_locations(lid)
);

select * from user_constraints where table_name = 'FRUITS4';

/*
    # 1:N ���踦 ������ �� ���̺��� ������ �� �����غ�����

    * ���±��� ��� ��� ���� ������ �ּ� �ѹ� �̻� ����� ��. �� ���̺� ������ 3���� �־ ��
    
*/

create table romand (
    romand_id   number(2) 
        constraint ROMAND_ROMID_PK primary key,
    cossort    varchar2(20),
    cosform   varchar2(20),
    usedparts   varchar2(20) default '����'
);

create table cosmetic (
    cosmetic_id number(5) 
        constraint COSMETIC_COSID_PK primary key,
    cosmetic_name varchar2(30) 
        constraint COSMETIC_COSNAME_NN not null 
        constraint COSMETIC_COSNAME_UK unique,
    expiration_date date
        constraint COSMETIC_EXPIRATION_CHK check (to_date(expiration_date,'YYYY/MM/DD') >  '2021/01/01'),
    manufacture_date varchar2(15)

);
alter table cosmetic add constraint COSMETIC_MANUFACTURE_CHK check (expiration_date like '____/__/__');
alter table cosmetic modify(expiration_date varchar2(20));
alter table cosmetic add constraint COSMETIC_EXPIRATION_CHK check (expiration_date like '____/__/__');
alter table cosmetic drop constraint  COSMETIC_EXPIRATION_CHK;

alter table romand modify (cossort varchar2(20) constraint ROMAND_COSSORT_NN not null);

select * from user_constraints;
select * from cosmetic;
desc cosmetic;

insert into romand values(1,'makeup','solid','face');
insert into romand values(2,'skincare','liquid','face');
insert into romand values(3,'bodycare','watery','hand');
insert into romand(romand_id, cossort, cosform) values(4,'haircare','watery');

select * from romand;
desc romand;

alter table cosmetic modify (COSMETIC_NAME  VARCHAR2(100));
insert into cosmetic values(1,'�Ҿ����κ���ƾƮ��Ƽ������','2023/07/23','2020/01/22');
insert into cosmetic values(2,'�������� ���� ���� AI �ٵ�μ�','2023/06/23','2021/02/23');
insert into cosmetic values(3,'���左 1025 ���� ���','2023/07/05','2020/01/24');
insert into cosmetic values(4,'����Ʈ ���� ��������','2024/06/13','2020/06/25');

alter table cosmetic add(romand_id number(2) constraint COSMETIC_ROMAND_ID_FK  references romand(romand_id)); 
update cosmetic set romand_id = 1 where cosmetic_name like '%ƾƮ%';
update cosmetic set romand_id = 2 where cosmetic_name like '%���%';
update cosmetic set romand_id = 3 where cosmetic_name like '%�ٵ�%';
update cosmetic set romand_id = 4 where cosmetic_name like '%����%';

-- �ٸ� ���̺��� FK�� �����Ǵ� ���̺��� ���� �ƹ��������� �����ϸ� ���Ἲ�� ��ĥ ������ ����
select * from fruits3;
select * from fruit_locations;

insert into fruits3(fid, fname, fcolor, fsize, lid) values (3, 'Kiwi', 'Olive', 'S', 10);

commit;

delete from fruit_locations where lid = 30;  --�ڽ� ���ڵ尡 ���� �ÿ� ��� �ش�

rollback;

/*
    #ON DELETE ���� ����
    -FK(�ڽķ��ڵ�)�� �����ϰ� �ִ� PK(�θ� ���ڵ�)�� ������ ���� ��å�� ������ �� �ִ�
    - CASCADE, SET NULL, RESTRICT
    
    # ON DELETE CASCADE
    -�θ��ڵ带 �����ϸ� �ڽ� ���ڵ带 ����Բ� �����Ѵ�
    
    # ON DELETE SET NULL
    - �θ� ���ڵ带 �����ϸ� �����ϴ� �ڽ� ���ڵ��� ���� null�� �����Ѵ�
    
    # RESTRICT(�⺻ ��)
    - �ڽ� ���ڵ尡 ������ �θ� ���ڵ带 ������ �� �����Ѵ�
    - on delete�� �������� ������ �ȴ�


*/
show user;

-- #CASCADE TEST

select * from user_constraints where table_name = 'FRUITS3';

alter table fruits3 drop constraint fr3_lid_fk;
alter table fruits3 add constraint  fr3_lid_fk foreign key (lid) 
references fruit_locations (lid) on delete cascade;

select * from fruits3;
select * from fruit_locations;

delete from fruit_locations where lid = 10;

--# SET NULL TEST
ALTER TABLE fruits3 DROP CONSTRAINT fr3_lid_fk;

ALTER TABLE fruits3
    ADD CONSTRAINT fr3_lid_fk FOREIGN KEY ( lid )
        REFERENCES fruit_locations ( lid )
            ON DELETE SET NULL;

DELETE FROM fruit_locations WHERE lid = 10;

ROLLBACK;









