/*
    # 데이터 무결성
    - 데이터에는 결점이 없어야 한다는 뜻
    - 개체 무결성, 참조 무결성,도메인 무결성...

    # 개체 무결성
    - 테이블의 데이터는 반드시 한 행을 구분할 수 있어야한다
    - 개체 무결성을 지키기 위한 제약 조건으로 PK를 사용한다
    
    # 참조 무결성
    - 참조 관계에 있는 데이터는 항상 일관된 값을 가져야 한다
        (employees의 department_id는 departments의 department_id에 존재하는 값만 사용해야한다)
    - 참조 무결성을 지키기 위한 제약 조건으로 FK를 사용한다
    
    # 도메인 무결성
    - 해당 도메인을 구성하는 개체들은 항상 타입이 일정해야한다
    - 테이블의 컬럼 타입 설정 및 check를 통해서 도메인 무결성을 지키고 있다
    
    # 데이터 무결성 제약 조건
    - not null : 해당 컬럼에 null을 허용하지 않는 규칙
    - unique : 해당 컬럼에 중복되는 값을 허용하지 않는 규칙. 항상 유일한 값을 갖도록 한다
    - primary key : 해당 컬럼을 기본키로 설정한다. not null+ uniqe. 테이블 당 하나만 설정 가능
    - foreign key : 해당 컬럼을 외래키로 설정한다
    - check : 원하는 데이터의 조건을 직접 지정하여 도메인 무결성을 유지할 수 있다.

*/

--# 제약 조건 데이터 딕셔너리를 통해 현재 계정의 모든 제약 조건들을 확인할 수 있다
select * from user_constraints; -- 현재 계정의 제약 조건
select * from all_constraints;  -- 현재 계정으로 볼 수 있는 모든 제약 조건

/*
    # 제약 조건 테이블 constraint_type
    P : primary key
    R : foreign key
    C : check / not null
    U : unique

*/

--제약 조건 한번씩 추가해보기
create table fruits(
    fid number(2) primary key,
    fname varchar2(20) not null
);

desc fruits;

--uique 
alter table fruits modify (fname varchar2(20) unique);
--check() 내부에 원하는 조건을 추가
alter table fruits add(fcolor varchar(20) check(fcolor in ('RED', 'GREEN', 'BLUE'))); 

desc fruits;

insert into fruits values (2, 'Apple', 'RED');
insert into fruits values (3, 'Banana', 'BLUE');

select * from fruits;

/*
    #테이블에 존재하는 제약조건 제거하기
    - alter table 테이블명 drop constraint 제약조건명;

*/

alter table fruits drop constraint SYS_C0019519;
alter table fruits modify (fcolor varchar(10));


alter table fruits drop constraint SYS_C0019517;


update fruits set fcolor = 'Yellow' where fname = 'Banana';

/*
    # 테이블에 이미 존재하는 컬럼에 제약조건 추가하기
    - alter table 테이블명 add constraint 제약조건명(내가 적고싶은 이름) 제약조건(적용될 컬럼);
    - alter table 테이블명 modify 컬럼명 (새로 설정);
    - not null과 check는 add constraint 대신 modify를 이용해 추가/수정한다
*/

alter table fruits add constraint FRUITS_FID_PK primary key(fid);

select * from user_constraints;
desc fruits;


--제약 조건명은 자동으로 생성되는 이름보다 내가 직접 구분할 수 있는 보기 좋은 이름으로 설정해야한다
insert into fruits values(1, 'Orange', 'Orange');

/*
    # 제약조건을 추가하는 방법
    
    1. 테이블 생성과 동시에 제약조건 추가하기
    
    - 컬럼명 컬럼타입 constraint 제약조건명 제약조건타입
    - 반드시 제약조건 이름을 팀 규칙에 맞게 짓도록 하자
    
    2. 테이블 생성 후 제약조건 추가하기
    
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

-- not null과 check는 add constraint 대신 modify를 이용해 추가/수정한다
alter table fruits3 add constraint FRUITS3_FID_PK primary key(fid);
alter table fruits3 add constraint FRUITS3_FNAME_UK unique(fname);
alter table fruits3 modify (fname varchar2(20) constraint FRUITS3_FNAME_NN not null);
alter table fruits3 modify (fcolor varchar2(10) constraint FRUITS3_FCOLOR_NN not null);
alter table fruits3 modify (fsize char(1) constraint FRUITS3_FSIZE_CHK check (fsize in('L','N','S')));


/*
    # default 제약 조건
    - 해당 컬럼에 기본값을 설정해놓은 제약 조건
    - default가 설정된 컬럼은 행 추가시 값을 넣지 않으면 
        null 대신 default로 설정한 값이 추가된다

*/
alter table fruits3 add (fprice number(7) default 0);
alter table fruits3 modify (fprice number(7) default 10);

select * from user_constraints where table_name = 'FRUITS3';  
desc fruits3;

/*
    # Foreign Key 제약 조건
    - 제약조건을 설정할 때 어떤 테이블의 어떤 컬럼을 참조할지 반드시 지정해야한다
    - 다른 테이블의 PK 또는 UK제약 조건이 걸린 컬럼만 지정할 수 있다
    
    
    # 테이블 생성 시 설정 - 테이블 생성시에 설정할 때는 제일 마지막에 정의해야한다
    CONSTRAINTS 외래키 이름 FOREIGN KEY(컬럼명) 
    REFERENCES 참조 테이블명(참조컬럼)
    
    ex : 
    CREATE TABLE topics(
        user varchar2(20) NOT NULL,
        title VARCHAR2(255) NOT NULL,
        lecturekey VARCHAR2(100) NOT NULL,
        CONSTRAINT FK_TOPICS FOREIGN KEY(lecturekey)
        REFERENCES LECTURE(LID)
    );
    
    
    # 테이블 생성 후 설정
    ALTER TABLE 테이블명 
    ADD CONSTRAINTS 외래키 이름 FOREIGN KEY (참조컬럼) 
    REFERENCES 참조 테이블명(참조컬럼)
    
*/
create table fruit_locations (
    lid number(2),
    addr varchar2(200),
    city varchar2(40)

);

insert into fruit_locations values(10, '충청북도 청주시', '청주' );
insert into fruit_locations values(20, '경상북도 안동시', '안동');
insert into fruit_locations values(30, '전라남도 고흥군', '고흥');
insert into fruit_locations values(40, '충청남도 논산시', '논산');

--unique 또는 primary key 제약 조건이 걸리지 않은 컬럼은 외래키로 참조될 수 없다
alter table fruit_locations add constraint FLO_LIO_UK unique(lid);
alter table fruits3 add(lid number(2) constraint FRUITS3_LID_FK references fruit_locations(lid));

select * from user_constraints where constraint_name like 'FRUITS3%';  

insert into fruits3(fid, fname, fcolor, fsize, lid) values (1, 'Apple', 'Red', 'L', 10);
insert into fruits3(fid, fname, fcolor, fsize, lid) values (2, 'Banana', 'Yellow', 'N', 20);

select * from fruits3 inner join fruit_locations using(lid);
select * from fruits3;

/*
    # 제약조건 추가하는 방법3(테이블 레벨로 추가하기)
    - 컬럼을 모두 정의한 create table의 뒤에 따로 제약조건을 지정하는 방식
    - default와 not null은 테이블 레벨 방식으로 정의할 수 없다

*/
create table fruits4(
    fid      number(4),
    fname varchar2(20)  constraint F4_FNAME_NN not null,  --not null은 아래서 정의 안됨
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
    # 1:N 관계를 가지는 두 테이블을 생성한 후 연결해보세요

    * 여태까지 배운 모든 제약 조건을 최소 한번 이상 사용할 것. 각 테이블에 데이터 3개씩 넣어볼 것
    
*/

create table romand (
    romand_id   number(2) 
        constraint ROMAND_ROMID_PK primary key,
    cossort    varchar2(20),
    cosform   varchar2(20),
    usedparts   varchar2(20) default '미정'
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
insert into cosmetic values(1,'롬앤제로벨벳틴트빈티지필터','2023/07/23','2020/01/22');
insert into cosmetic values(2,'피지오겔 레드 수딩 AI 바디로션','2023/06/23','2021/02/23');
insert into cosmetic values(3,'라운드랩 1025 독도 토너','2023/07/05','2020/01/24');
insert into cosmetic values(4,'퍼펙트 세럼 오리지널','2024/06/13','2020/06/25');

alter table cosmetic add(romand_id number(2) constraint COSMETIC_ROMAND_ID_FK  references romand(romand_id)); 
update cosmetic set romand_id = 1 where cosmetic_name like '%틴트%';
update cosmetic set romand_id = 2 where cosmetic_name like '%토너%';
update cosmetic set romand_id = 3 where cosmetic_name like '%바디%';
update cosmetic set romand_id = 4 where cosmetic_name like '%세럼%';

-- 다른 테이블에서 FK로 참조되는 테이블의 행을 아무생각없이 삭제하면 무결성을 헤칠 위험이 있음
select * from fruits3;
select * from fruit_locations;

insert into fruits3(fid, fname, fcolor, fsize, lid) values (3, 'Kiwi', 'Olive', 'S', 10);

commit;

delete from fruit_locations where lid = 30;  --자식 레코드가 있을 시에 경고를 준다

rollback;

/*
    #ON DELETE 제약 조건
    -FK(자식레코드)가 참조하고 있는 PK(부모 레코드)를 삭제할 때의 정책을 결정할 수 있다
    - CASCADE, SET NULL, RESTRICT
    
    # ON DELETE CASCADE
    -부모레코드를 삭제하면 자식 레코드를 모두함께 삭제한다
    
    # ON DELETE SET NULL
    - 부모 레코드를 삭제하면 참조하던 자식 레코드의 값을 null로 변경한다
    
    # RESTRICT(기본 값)
    - 자식 레코드가 있으면 부모 레코드를 삭제할 수 없게한다
    - on delete를 설정하지 않으면 된다


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









