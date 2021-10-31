/*
    # CREATE TABLE
    
    # DML (Date Manipulation Language, 데이터 조작어)  * DB의 CRUD
    
    - select : 테이블의 데이터 조회
    - insert : 테이블의 데이터 생성
    - delete : 테이블의 데이터 삭제
    - update : 테이블의 데이터 수정
    
    * CRUD - create, read, update, deledte. 모든 프로그램에는 CRUD가 다양한 형태로 존재한다
    
    
    # DDL (Date Definition Language, 데이터 정의어)
    - 테이블,시퀀스,뷰 ... 등 DB에서 사용하는 오브젝트 구조를 생성할 때 사용하는 명령어
    - create : DB 오브젝트 생성
    - drop : DB 오브젝트 삭제
    - alter : DB 오브젝트 수정
    - truncate : DB 오브젝트 완전 삭제
    - DROP TABLE은 테이블의 존재 자체가 없어져 구조가 남지않는 반면 
        TRUNCATE TABLE은 테이블은 존재하면서 데이터의 내용만 제거하기 때문에 구조가 남아있다.
    
    
    # DCL (Date Control Language, 데이터 제어 명령어)
   -DB의 사용자들을 관리하는 명령어
   - grant : 사용자에게 권한을 부여
   - revoke : 사용자의 권한을 회수

    
*/
--  # create table 테이블명 (컬럼이름1, 컬럼 타입1,컬럼이름2, 컬럼 타입2,,,,);  * 테이블 생성
create table coffees (
    coffee_id number(5),
    cname varchar2(50), --한글이 한글자 당 2,3바이트 정도임.
    price number(5)
);

select * from tabs;

 desc coffees;
 
 -- # drop table 테이블명;  * 테이블 삭제
 drop table coffees;
 
-- 삭제한 테이블은 휴지통(recyclebin)에 담겨있다
show  recyclebin;
select * from recyclebin;
 
 -- 휴지통 복구하기
 flashback table coffees to before drop;
 select * from coffees;
 
 --휴지통 비우기
 purge recyclebin;
 
 /*
    # 데이터 딕셔너리 
    - 데이터에 대한 데이터(메타 데이터)
    - DB는 우리가 추가한 데이터를 알아서 관리한다
    - 현재 상태는 DB의 데이터 딕셔너리를 통해서만 알 수 있다
    - 사용자가 직접 데이터 딕셔너리를 수정할 수 는 없다
    - 데이터베이스 자원을 효율적으로 관리하기 위한 다양한 정보를 저장하는 시스템 테이블이다.
 
    # 데이터 딕셔너리 뷰
    - 데이터 딕셔너리 뷰는 기본 테이블의 정보를 더 유용하게 보여주기 위해서 기본 테이블을 요약한 형태이다. 
    (뷰란 기본 테이블의 내용을 보여주는 하나의 방식으로, 사용자는 뷰를 마치 테이블처럼 사용할 수 있다.)
    - 데이터 딕셔너리를 사용자가 확인하기 편리한 형태로 제공하는 뷰(뷰는 수정을 못하고 구경만 할 수 있다)
    - user_가 붙으면 해당 계정의 데이터 딕셔너리임을 나타낸다
    - all_가 붙으면 모든 계정의 데이터 딕셔너리임을 나타낸다 (정말 모~든 계정의 데이터를 싹다 보고싶으면 system(관리자)계정으로 들어가서 봐야한다)
 */
 
 select * from tabs;
 select * from user_tables;
  select * from all_tables;
 
 
 
 
 
 
 
 
 
 
 
 