/*
    # 시퀀스
    - 기본키로 사용하기 편하도록 설계된 자동 번호 생성기
    - user_sequences 데이터 딕셔너리로 확인할 수 있다
    
    create sequence 시퀀스명
                                [start with n] - 시퀀스의 시작 번호 설정
                                [increment by n] - 시퀀스의 증가값 설정
                                [maxvalue n | nomaxvalue] - 최대값 설정
                                [minvalue n | nominvalue] - 최소값 설정
                                [cycle | nocycle] - 최대값에 도달 했을 때 순환 여부 설정
                                [cache m | nocache] - 메모리상에 미리 만들어 놓을 시퀀스의 개수 설정
                                
*/

--시퀀스 데이터 딕셔너리
select * from user_sequences;
select * from all_sequences;

create table sodas (
    pid number(4) constraint soda_pid_pk primary key,
    pname varchar2(30) constraint soda_pname_nn not null
);

insert into sodas values(1, '사이다');
insert into sodas values(2, '청포도 에이드');
insert into sodas values(3, '자몽 에이드');

--4부터 시작하고 1씩 증가하는 시퀀스 생성
create sequence sodas_seq start with 4 increment by 1;

select * from user_sequences;

--시퀀스 사용해보기(시퀀스는 중간이 비어도 채울 수 없다, 돌아갈 수 없다)
insert into sodas values(sodas_seq.nextval, '민트초코라떼');
insert into sodas values(sodas_seq.nextval, '환타');
insert into sodas values(sodas_seq.nextval, '밀키스');
insert into sodas values(sodas_seq.nextval, '암바사');

select * from sodas order by pid;
delete from sodas where pid > 3;

create table soda_categories (
    cate_id number(4),
    cate_name varchar2(40),
    constraint sc_id_pk primary key (cate_id)
);


/*
    soda_categories 테이블에서 사용할 시퀀스를 생성해보세요
    
    1. 시작은 10번부터
    2. 10씩 증가할 것
    3. cache 10으로 설정
    4. 순환하지 않을 것
    5. 최대 값은 9000
    
    시퀀스 생성 후 테이블에 데이터도 3개 넣어보세요
*/

create sequence sodas_seq2 start with 10 increment by 10 cache 10 nocycle maxvalue 9000;
insert into soda_categories values(sodas_seq2.nextval, '초코칩');
insert into soda_categories values(sodas_seq2.nextval, '초코쿠키');
insert into soda_categories values(sodas_seq2.nextval, '아메리');

select * from soda_categories order by cate_id;

--해당 시퀀스의 값을 증가
select sodas_seq2.nextval from dual;

-- 현재 몇 번째 번호까지 사용중인지 알고싶을 때
select sodas_seq2.currval from dual; -- 시퀀스.currval

/*
    # 시퀀스 삭제
        drop sequence 시퀀스명
*/

/*
    # 시퀀스 수정
        alter sequence 시퀀스명
        * 수정 옵션은 create sequence와 같음
*/






