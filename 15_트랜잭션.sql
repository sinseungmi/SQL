/*
    # 트랜잭션(Transaction)
    -트랜잭션(Transaction)은 데이터베이스의 상태를 변환시키는 하나의 논리적 기능을 수행하기 위한 작업의 단위 
        또는 한꺼번에 모두 수행되어야 할 일련의 연산들을 의미한다.
    - 데이터 처리의 한 단위
    - 하나의 논리적인 작업이 완전하게 마무리 될때 까지의 절차를 트랜잭션이라 한다.
    - ex : 송금 트랜잭션
            1. 보내는 사람의 통장에서 돈이 줄어든다
            2. 받는 사람의 통장의 돈이 늘어난다
    - 하나의 트랜잭션은 여러 명령어의 집합이다.
    - 트랜잭션의 모든 과정이 정상적으로 완료되는 경우에만 변경 사항을 확정 짓는다
      (all or nothing) (다된다 또는 처리안한다)
    - 트랜잭션을 관리하기 위해 사용되는 TCL(TRANSACTION CONTROL LANGUAGE)로는 
        commit, rollback, savepoint 등이 있다 (트랜잭션을 제어하는 언어)
    -트랜잭션은 마지막으로 실행된 커밋(또는 롤백) 이후 부터 
       새로운 커밋을 실행하는 시점까지 수행하는 모든 DML을 의미한다
    -트랜잭션은 DML만 관리한다
        
        *여기서 create table빼고 나머지는 다 롤백 되는 거임
       commit -> insert1 -> insert2 -> update -> create table -> delete1 -> 문제발생(rollback) -> commit
       
       DDL은 롤백의 대상 아님
      
*/
UPDATE fruits SET fcolor ='GREEN' WHERE fname ='Kiwi';
select * from fruits;
ROLLBACK;

commit;
select * from coffees;

truncate table coffees;  --테이블을 수정하는 DDL. 트랜잭션 관리 대상 아님
    --테이블의 모든 내용을 자른다. drop table과 다르게 구조는 남긴다.
    --create table, drop table, truncate table등의 DDL은 트랜잭션으로 관리할 수 없다

rollback;

--연습1 : coffees 테이블에 원하는 새로운 컬럼을 추가해보세요
--연습2 : 컬럼의 이름도 몇 개 변경해보세요
--연습3 : insert문을  사용해 제대로 된 메뉴를 5개 이상 넣어보세요 

alter table coffees rename column coffee_id to animal_id;
alter table coffees rename column cname to animal_type;
alter table coffees rename column price to animal_name;
alter table coffees modify (animal_name varchar2(30));
alter table zoo add(animal_age number(5));

desc coffees;

rename coffees to zoo;

select * from coffees;

insert into zoo values(1,'포유류','곰',10);
insert into zoo values(2,'파충류','아나콘다',5);
insert into zoo values(3,'포유류','호랑이',2);
insert into zoo values(4,'포유류','코끼리',8);
insert into zoo values(5,'파충류','거북이',20);

select * from tabs;

create table coffees (
    coffee_id number(5),
    cname varchar2(50), 
    price number(5)
);

INSERT INTO coffees(coffee_id, cname, price) VALUES(1, '아메리카노', 2000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(2, '아이스 아메리카노', 2000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(3, '카페라떼', 3000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(4, '아인슈페너', 8000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(5, '카푸치노', 6500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(6, '카페 비엔나', 7000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(7, '에스프레소', 1500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(8, '콜드 브루', 5000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(9, '에스프레소 콘파나', 5000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(10, '카페오레', 4500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(11, '카푸치노', 4500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(12, '비너 멜랑쉬', 7500);

INSERT INTO coffees(coffee_id, cname, price) VALUES(13, '크랜베리아몬드 쿠기', 3500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(14, '모카초코칩 쿠키', 3500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(15, '더블초코칩 쿠키', 3500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(16, '치즈 케이크', 4500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(17, '초코무스 케이크', 4500);

select * from coffees;


alter table coffees add(bitter char(15));
alter table coffees modify(bitter char(15));

update coffees set bitter = '★★★☆☆';  --별은 숫자로 넣는게 좋다. 별찍기는 자바에서 for문 돌리면 됨.DB는 앵간한건 다 숫자로  지정하는게 좋음.

commit;

--insert,update,delete는 DML이기 때문에 rollback으로 다시 되돌릴 수 있다
insert into coffees values(18, '감자탕', 8000, null);
savepoint save01;
-- savepoint : 현재의 트랜젝션을 작게 분할하는 명령어이다.

delete coffees where coffee_id between 3 and 10;
savepoint save02;

update coffees set cname = replace(cname, '아메리', '이탈리');
savepoint save03;

rollback;   --롤백은 커밋 시점으로 돌아간다
rollback to save03;  -- 현재 트랜젝션 내의 특정 SAVEPOINT까지 ROLLBACK 할 수 있게 된다.
rollback to save02;
rollback to save01;
rollback to save02; 
--save01로 돌아가면 save02는 없는 상태이므로 나중에 생성된 세이브 포인트로는 돌아갈 수 없다.

select * from coffees;

--employees의 직원들이 자신이 받을 수 있는 월급 범위내에서
--몇 퍼센트 수준의 월급을 받고 있는지 보기 좋은 형태로 조회해보세요(커미션도 포함)



















