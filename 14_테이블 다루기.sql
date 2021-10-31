--DDL

/*
    # 서브쿼리로 테이블 생성하기
    - create table 테이블명 as (서브쿼리)로 테이블을 생성할 수 있다

*/
create table copied_coffees as (select * from coffees);

desc copied_coffees;

create table bingsu as (select * from coffees where cname like '%빙수');

select * from bingsu;


/*
    # 테이블에 새 컬럼 추가하기
    - alter table 테이블명  add (컬럼명, 컬럼타입,...)
*/
alter table bingsu add (sirup varchar2(20));


/*
    # 테이블의 컬럼 이름 변경하기
    - alter table 테이블명 rename column 현재이름 to 바꿀이름;
*/
alter table bingsu rename column sirup to syrup;


/*
    # 테이블 이름 변경하기
    - rename 현재테이블명 to 바꿀테이블명;
*/
rename bingsu to bingsoo;
rename copied_coffees to coffees2;

select * from bingsoo;

select * from tabs;


/*
     # 컬럼의 타입 변경하기(이건 타입만 변경하는거임.이름까지 변경하는 거 아님)
     - alter table 테이블명 modify (컬럼명 컬럼타입,...);
*/
select * from bingsoo;

alter table bingsoo modify (cname varchar2(30)); 

update bingsoo set cname = '빙수';

insert into bingsoo values (101, '민트초코카페라떼파인애플마라빙수', 7500, '딸기');


/*
    # 컬럼 삭제하기
     alter table 테이블명 drop column  컬럼명;
*/
select * from bingsoo;

alter table bingsoo drop column syrup;




















