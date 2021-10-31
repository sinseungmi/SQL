
desc coffees;
select * from coffees;

/*
    # 테이블 데이터 추가
    - insert into 테이블명(컬럼명,,,) values(값,,);  
*/
insert into coffees(coffee_id, cname, price) values(1, '아메리카노',2000);
insert into coffees(coffee_id, cname, price) values(2, '아이스 아메리카노',2500);
insert into coffees(coffee_id, cname, price) values(3, '카페라떼',3000);

-- 일부 컬럼에만 데이터 추가하기 (데이터를 넣지않은 컬럼은 null이 됨)
insert into coffees( cname, price) values('팥빙수',5500);
insert into coffees(cname) values('망고빙수');

--컬럼명을 생략하고 데이터 추가하기 (반드시 모든 데이터를 컬럼 순서대로 넣어줘야 한다)
insert into coffees  values(6,'눈꽃빙수',6500);
insert into coffees  values('딸기빙수', 6500);

--컬럼명을 모두 적어주면 순서는 상관없다
insert into coffees(price, cname, coffee_id)  values(4000,'카페모카',8);
insert into coffees(price, coffee_id,cname)  values(4000,6,'캬라멜 마끼야또');

--insert into 테이블명 (서브쿼리)  :서브쿼리를 테이블에 insert할 수 있다 (서브쿼리를 데이터로 활용 할 수 있다)
insert into coffees (select * from coffees);  --자가 복제 같은 느낌
desc coffees;


select * from coffees order by coffee_id;

/*
     # 테이블 데이터 수정
    -update 테이블명 set 컬럼=값 where 조건;
    - update 조건을  설정하지 않으면 모든 행을 수정한다
    - 조건이 있다면 조건을 만족하는 모든 행을 수정한다
    - 하나의 행을 구분할 수 있는 기본키와 함께 사용되는 경우가 많다
*/
update coffees set price = 1000;

update coffees set price = 2000 where cname like '%아메리카노%';

update coffees set price = price + 500 where cname like '%아이스%';

--여러 컬럼을 수정할 때는 쉼표를 사용한다
update coffees set price = 5000, coffee_id = 100 where cname like '%빙수';

--연습1: 빙수도 아니고, 아메리카노도 아닌 모든 제품들의 가격을 3천원으로 수정해라
update coffees set price = 3000 
where cname not like '%아메리카노%' and cname not like '%빙수';

select * from coffees;

/*
    # 테이블 데이터 삭제하기
    - delete from 테이블명 where 조건;
    - 조건에 맞는 행전체를 삭제한다(특정 컬럼 값만 삭제하는 것은 update에 해당한다)
    -  삭제 조건을  설정하지 않으면 모든 행을 삭제한다
    - 조건이 있다면 조건을 만족하는 모든 행을 삭제한다
    - 하나의 행을 구분할 수 있는 기본키와 함께 사용되는 경우가 많다

*/

/*
    - 모든 과정이 오류없이 수행되었다면 지금까지 실행한 모든 작업을 '실제로' 수행하라는 
        명령을 내릴 수 있는데 이 때의 명령이 바로 'COMMIT' 명령
    - 실제 데이터베이스에 적용하려면 COMMIT을 해야한다.
*/
commit;   --현재까지의 상황을 보존하겠다
select * from coffees;

delete from coffees where cname like '%빙수';

--ROLLBACK을 수행 시 마지막으로 COMMIT을 수행했던 내용으로 돌아감
ROLLBACK;








