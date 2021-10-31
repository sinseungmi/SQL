/*
    # ������
    - �⺻Ű�� ����ϱ� ���ϵ��� ����� �ڵ� ��ȣ ������
    - user_sequences ������ ��ųʸ��� Ȯ���� �� �ִ�
    
    create sequence ��������
                                [start with n] - �������� ���� ��ȣ ����
                                [increment by n] - �������� ������ ����
                                [maxvalue n | nomaxvalue] - �ִ밪 ����
                                [minvalue n | nominvalue] - �ּҰ� ����
                                [cycle | nocycle] - �ִ밪�� ���� ���� �� ��ȯ ���� ����
                                [cache m | nocache] - �޸𸮻� �̸� ����� ���� �������� ���� ����
                                
*/

--������ ������ ��ųʸ�
select * from user_sequences;
select * from all_sequences;

create table sodas (
    pid number(4) constraint soda_pid_pk primary key,
    pname varchar2(30) constraint soda_pname_nn not null
);

insert into sodas values(1, '���̴�');
insert into sodas values(2, 'û���� ���̵�');
insert into sodas values(3, '�ڸ� ���̵�');

--4���� �����ϰ� 1�� �����ϴ� ������ ����
create sequence sodas_seq start with 4 increment by 1;

select * from user_sequences;

--������ ����غ���(�������� �߰��� �� ä�� �� ����, ���ư� �� ����)
insert into sodas values(sodas_seq.nextval, '��Ʈ���ڶ�');
insert into sodas values(sodas_seq.nextval, 'ȯŸ');
insert into sodas values(sodas_seq.nextval, '��Ű��');
insert into sodas values(sodas_seq.nextval, '�Ϲٻ�');

select * from sodas order by pid;
delete from sodas where pid > 3;

create table soda_categories (
    cate_id number(4),
    cate_name varchar2(40),
    constraint sc_id_pk primary key (cate_id)
);


/*
    soda_categories ���̺��� ����� �������� �����غ�����
    
    1. ������ 10������
    2. 10�� ������ ��
    3. cache 10���� ����
    4. ��ȯ���� ���� ��
    5. �ִ� ���� 9000
    
    ������ ���� �� ���̺� �����͵� 3�� �־����
*/

create sequence sodas_seq2 start with 10 increment by 10 cache 10 nocycle maxvalue 9000;
insert into soda_categories values(sodas_seq2.nextval, '����Ĩ');
insert into soda_categories values(sodas_seq2.nextval, '������Ű');
insert into soda_categories values(sodas_seq2.nextval, '�Ƹ޸�');

select * from soda_categories order by cate_id;

--�ش� �������� ���� ����
select sodas_seq2.nextval from dual;

-- ���� �� ��° ��ȣ���� ��������� �˰���� ��
select sodas_seq2.currval from dual; -- ������.currval

/*
    # ������ ����
        drop sequence ��������
*/

/*
    # ������ ����
        alter sequence ��������
        * ���� �ɼ��� create sequence�� ����
*/






