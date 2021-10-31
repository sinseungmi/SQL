/*
    # 뷰 (View)
    
    - 물리적인 기본 테이블들을 이용해 생성한 논리적인 가상의 테이블
    - 기본 테이블에서 파생된 DB 객체
    - 뷰를 통해 사용자(개발자)가 기본 테이블들을 제한적으로 사용하게끔 할 수 있다
        
    create [or replace] view 뷰이름 
        as 서브쿼리 
            [with check option| with read only];
        
    - create or replace : 이미 존재하는 뷰라면 수정을 한다. 없다면 생성한다
    - with check option : 해당 뷰를 통해 update와 insert가 가능해진다 (제한적인 DML)
        with check option은 view를 만들 때 해당 제약조건 안에서만 삽입,삭제,수정이 가능하다는 것입니다.

    - with read only : 해당 뷰는 select만 가능해진다 (DML 금지)
*/

-- 뷰 데이터 딕셔너리
select * from user_views;
select * from all_views;

SELECT first_name,department_id,department_name,city FROM DEPARTMENTS INNER JOIN EMPLOYEES 
USING(department_id) INNER JOIN locations USING(location_id) WHERE first_name LIKE '%en%';

--기본 옵션 뷰
CREATE OR replace view dept30_view as
    SELECT
        employees.*
    FROM
        employees
    WHERE
        department_id = 30;
    
select * from dept30_view;

--기본 옵션 뷰를 통해서는 자유로운 insert가 가능하다 (개발자가 insert를 진행할 수 있다)(뷰를 통해서 테이블 바꿈)
insert into dept30_view values
(1, 'Gildong', 'Hong', 'Ghong', '515.127.4444', sysdate, 'IT_PROG', 1000, null, 100, 70); 

select * from employees;


--읽기 전용 뷰
CREATE OR replace view dept50_view_readonly as
    SELECT
        employees.*
    FROM
        employees
    WHERE
        department_id = 50;
with read only;

select * from dept50_view_readonly;


--읽기 전용 뷰를 통해서는 DML 작업을 수행할 수 없다
insert into dept50_view_readonly values
(1, 'Gildong', 'Hong', 'Ghong', '515.127.4444', sysdate, 'IT_PROG', 1000, null, 100, 70); 


select * from employees;
rollback;


--체크 옵션 뷰
CREATE OR replace view dept80_view_check as
    SELECT
        employees.*
    FROM
        employees
    WHERE
        department_id = 80;
with check option;
    
select * from dept80_view_check;

--80번 부서 사람들만 조회하는 뷰이기 때문에, 80번 부서와 관련된 DML만 사용할 수 있게 된다.
insert into dept80_view_check values
(4, 'Jaedong', 'Hong', 'HJaedong', '515.127.4446', sysdate, 'IT_PROG', 1000, null, 100, 30); 

--80번 부서에만 DML이 가능하다
insert into dept80_view_check values
(2, 'Jaedong', 'Hong', 'Haedong', '515.127.4446', sysdate, 'IT_PROG', 1000, null, 100, 80); 

select * from user_constraints where constraint_name ='EMP_EMAIL_UK';

/*
    # 삭제
    - drop view 뷰name
    뷰는 다른 테이블을 참조만 하고 있을 뿐이므로 뷰를 삭제하더라도 
    실제 뷰가 참조하고있는 테이블에 있는 데이터는 삭제되지 않습니다. 
*/


drop view dept80_view_check;

delete from employees where employee_id in (1,2,4,3);










