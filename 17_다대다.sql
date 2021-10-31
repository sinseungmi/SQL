/*
    # 엔티티간의 다대다 관계가 발생하는 경우에 대하여
    
    1. 두 개의 1:다 관계를 만들어 해결한다 (성능이 매우 저하된다)
    
    
    메뉴          손님                             메뉴           주문          손님
                                                        PK             FK     FK    PK
    짜장면         A                               짜장면        짜장면A       A
    짬뽕            B               =>            짬뽕          짬뽕A           B
    탕수육         C```````````````````               탕수육        탕수육A       C
    짬뽕밥         D                               짬뽕밥        짜장B          D
                       E                                                 짬뽕 B        E
                                                                          탕짜면C
            
    2. 그냥 포기하고 한 테이블에 다 적는다 (성능이 떨어지지 않는다. 물리적 용량을 더 많이 차지한다)
    
    # 만든 DB로 다음을 조회해주에요
    
    1. A씨가 시킨 모든 메뉴를 조회
    
    2. B씨가 시킨 모든 메뉴의 총합을 조회
    
    3. 시킨 메뉴의 총합이 한도를 넘는 손님들의 정보를 조회

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

--메뉴오더에서 푸드네임 유니크 해제
alter table menu_order add constraint food_name_uk unique (food_name);
select * from user_constraints where constraint_name like '%FOOD%';

alter table menu_order drop constraint FOOD_NAME_UK;


alter table menu_order add constraint menu_order_food_name_fk foreign key(food_name) references menu(food_name);

insert into menu values(1,'짜장면',3000,800);
insert into menu values(2,'짬뽕',4000,1000);
insert into menu values(3,'탕수육',8000,1200);
insert into menu values(4,'짜장밥',4000,700);
insert into menu values(5,'A코스',120000,2000);
insert into menu values(6,'B코스',150000,2000);
select * from menu;
desc menu;
alter table menu modify (MPRICE NUMBER(10));

update guest set cardlimit = 300000 where guest_name = '조연주';
insert into guest values(1,36.5,'2021/04/05',500000,'조연주');
insert into guest (guest_id, temperature,visitdate,guest_name) values(2,35.5,'2021/06/23','홍지유');
insert into guest  values(3,37,'2020/09/25',300000,'신승미');
insert into guest  values(4,36.0,'2021/05/29',1500000,'최예슬');
select * from guest;

insert into menu_order values(1, '짬뽕', 2);
insert into menu_order values(2, '탕수육', 1);
insert into menu_order values(3, '탕수육', 2);
insert into menu_order values(4, '짜장밥', 3);
insert into menu_order values(5, 'A코스', 3);
insert into menu_order values(6, 'B코스', 3);
insert into menu_order values(7, 'A코스', 3);
select * from menu_order;
/*
      1. A씨가 시킨 모든 메뉴를 조회
    
    2. B씨가 시킨 모든 메뉴의 총합을 조회
    
    3. 시킨 메뉴의 총합이 한도를 넘는 손님들의 정보를 조회


*/

select guest_name,food_name from guest inner join menu_order using (guest_id) where guest_id = 1; 

select guest_id, guest_name, sum(mprice) 
from menu_order mo 
inner join guest using (guest_id) 
inner join menu m using(food_name)
where guest_id = 2
group by guest_name,guest_id;

    --cardlimit값이 8000보다 적거나 12000 적거나 394000적을 때 참



select sum(mprice) from menu_order          
inner join guest g using(guest_id) 
inner join menu m using(food_name)
group by guest_id;

--any 메인 쿼리의 비교조건이 서브쿼리의 검색 결과와 하나 이상이 일치하면 참이다. (or)

select * from guest;
select * from menu;
select * from menu_order;

/*
    SELECT empno, ename ,dname
    FROM emp e
    JOIN dept d USING (deptno)
    WHERE e.deptno=50;

 위와 같이 쿼리문을 날릴 경우 ORA-25154 에러가 발생한다.
ORA-25154에러는 USING 결합을 할 때 쓰이는 열에 수식을 붙이면 발생한다.
즉, 위의 쿼리문은 USING 결합에 쓰이는 열인 deptno에 WHERE구문에서 emp 테이블의 별명인 e를 붙였기 때문에 에러가 발생하는 것이다.

USING을 사용한 결합에선, 결합 조건의 열 이름에 테이블명이나 테이블의 별명을 지정할 수 없다.
따라서 위의 쿼리문을 바르게 고치면 아래와 같다.

SELECT empno, ename, dname
FROM emp e
JOIN dept d USING (deptno)
WHERE deptno=50;

*/



--  3. 시킨 메뉴의 총합이 한도를 넘는 손님들의 정보를 조회
SELECT
    SUM(mprice) AS 가격,
    MAX(cardlimit) AS 한도,
    guest_name
FROM
         menu_order
    INNER JOIN menu USING ( food_name )
    INNER JOIN guest g USING ( guest_id )
GROUP BY guest_name HAVING SUM(mprice) > MAX(cardlimit);
-- g.guest_id가 안되는 이유는 위에 설명 참조

-- "group by 절의 결과를 토대로 조건을 걸고 싶을 때, having을 사용한다" 라고 생각하고,
-- 모든 조건을 having 절에 사용하면 안된다는거죠!

--guest_name으로 묶은 것은 각 이름으로 묶은 것. 그럼 having은 그 각 이름의 값으로 연산을 하는것
-- 신승미 mprice의 합계와 신승미 max(cardlimit)을 비교. 근데 신승미의 cardlimit는 다 30만원이기 때문에
--min을 하던 max를 하던 똑같다.having은 일반 컬럼 값은 들어가지 못하기 때문에 그룹함수가 들어가야한다

/*
    동명이인이 있는 경우, 만일 이름만 같고 뒤에 정보가 다르다면, 서로 다른 그룹으로 생성되어 괜찮겠지만
    동명이인에 심지어 뒤의 정보까지 같은 경우, 다른 사람이 같은 그룹으로 묶이게되어 없는 사람이 될 수 있습니다.
    
     사원번호  이름                입사일           급여    직책

     1111    Aaron    1980/06/23 00:00:00,   400,    사원
     1112    Aaron     1980/06/23 00:00:00,  400,    사원
     즉, Name 컬럼은 중복 가능하기때문에, 중복이 생길 시 위험한 그룹핑 컬럼입니다.

     그러므로 고유 식별자와 같이 중복될 수 없는 교수번호(profno), 학번, 사원번호와 같은 컬럼를 그룹핑 컬럼으로 지정하는게 좋습니다.

*/


SELECT
    *
FROM
         menu_order
    INNER JOIN menu USING ( food_name )
    INNER JOIN guest USING ( guest_id );









