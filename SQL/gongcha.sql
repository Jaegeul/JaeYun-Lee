create table member(
    mem_id varchar2(50) primary key,
    mem_pwd varchar2(100) not null,
    mem_name varchar2(20) not null,
    email_id varchar2(30) not null,
    email_domain varchar2(30) not null,
    mem_birth varchar2(20) not null,
    mem_gender number(10) not null,
    phone01 varchar2(10) not null,
    phone02 varchar2(30) not null,
    postcode varchar2(20) not null,
    roadaddress varchar2(100) not null,
    jibunaddress varchar2(100),
    extraaddress varchar2(100),
    bank_code varchar2(50),
    bank_num varchar2(100),
    bank_owner varchar2(20),
    cash number(38)
);
commit;
delete from member where mem_id='abcd';
select * from member;
select * from social_match;
select * from stadium;
select * from stadium_match;
select * from recruit;
create table recruit_reply(
    reply_no number(38) primary key,
    mem_id varchar2(50) not null,
    reply_content varchar2(2000) not null,
    recruit_no number(38),
    reply_class number(38),
    reply_order number(38),
    reply_group number(38),
    regi_date date
);

insert into recruit_reply values(reply_no_seq.nextval, 'hong', 'test', 23, 0, 1, 1,sysdate);
insert into recruit_reply values(reply_no_seq.nextval, 'hong', 'test2', 23, 0, 2, 2,sysdate);
insert into recruit_reply values(reply_no_seq.nextval, 'abcd', 'test3', 23, 0, 3, 3,sysdate);

select b.mem_id recruit_mem, a.reply_no, a.mem_id reply_mem, a.reply_content, a.recruit_no, a.reply_class, a.reply_order, a.reply_group, a.regi_date
from recruit_reply a, recruit b where a.recruit_no = b.recruit_no;

alter table recruit_reply add constraint recruit_reply_mem_id_fk
foreign key(mem_id) references member(mem_id);

alter table recruit_reply add constraint recruit_reply_recruit_no_fk
foreign key(recruit_no) references recruit(recruit_no);

create sequence reply_no_seq
start with 1
increment by 1
nocache;

select*from recruit_reply;
select * from recruit;
commit;
create table stadium (
    stadium_name varchar2(50) primary key,
    address varchar2(100) not null,
    city varchar2(50) not null,
    stadium_size varchar2(50) not null,
    shower number not null,
    parking_lot number not null,
    shoes_rental number not null,
    vest_rental number not null,
    etc varchar2(200)
);

create table social_match(
    match_no number(38) primary key,
    price number(38) not null,
    match_date date not null,
    versus_num varchar2(30) not null,
    stadium_name varchar2(50) not null,
    constraint stadium_name_fk
    foreign key (stadium_name)
    references stadium (stadium_name),
    gender number(3) not null,
    shoes varchar2(50) not null,
    player_num number(5) not null,
    match_time varchar2(30) not null,
    match_level varchar2(30) not null,
    current_count number(5) not null
);
SELECT uc.constraint_name, uc.table_name, ucc.column_name, uc.constraint_type, uc.r_constraint_name 
FROM user_constraints uc, user_cons_columns ucc 
WHERE uc.constraint_name = ucc.constraint_name;

select * from social_match m left outer join stadium s
on s.city like '%서울%' and m.stadium_name = s.stadium_name where m.stadium_name like '%tadium%' order by match_date;


select count from social_match sm left outer join stadium s on sm.stadium_name = s.stadium_name where s.city like '%서울%';


create table Stadium_match(
    Stadium_Match_No number(38) primary key,
    Match_Date date,
    Available int,
    Stadium_Name varchar2(50) not null,
    Mem_Id varchar2(50),
    Price int,
    start_time varchar2(50) not null,
    end_time varchar2(50) not null
);

alter table Stadium_Match add constraint Stadium_Match_Stadium_Name_fk
foreign key(Stadium_Name) references Stadium(Stadium_Name);

alter table Stadium_Match add constraint Stadium_Match_Mem_Id_fk
foreign key(Mem_Id) references member(mem_id);

create table cash(
    cash_no number primary key,
    mem_id varchar2(50) not null,
    p_cash number,
    m_cash number,
    regdate date
);

alter table cash add constraint mem_id_fk foreign key(mem_id)
references member(mem_id);

create table recruit(
recruit_no number(38) primary key,
city varchar2(50) not null,
title varchar2(50) not null,
recruit_content varchar2(2000) not null,
mem_id varchar2(50) not null,
stadium_match_no number(38),
regdate date,
match_level number(5) --경기 수준 하(1) 중(2) 상(3) 
);

alter table recruit add constraint recruit_mem_id_fk
foreign key(mem_id) references member(mem_id);

alter table recruit add constraint sm_no_fk
foreign key(stadium_match_no) references Stadium_Match(stadium_match_no);

insert into member values('hong', 'hong', '홍길동',  'hong', 'naver.com', '19980101', '1', 
'010', '99993333', '55555', '서울특별시 강남구 테헤란로', null, null, null, null, null, 0);

insert into stadium values('stadium1', '서울특별시 강남구 테헤란로', '서울특별시',
 '19x41m', '1', '1', '1', '1', '특이사항 : 주차 5시간 무료로 가능'); 

insert into stadium values('stadium2', '경기도 수원시 팔달구', '경기도',
'35x40m', '1', '0', '1', '0', '특이사항 : 유료주차, 조끼렌탈 불가능'); 

insert into stadium values('stadium3', '부산광역시 해운대구 반송동', '부산광역시', 
'15x20m', '1', '1', '1', '0', '특이사항 : 주차 건물 내 지하주차장 사용'); 

create sequence match_no_seq
start with 1
increment by 1
nocache;

insert into social_match values(match_no_seq.nextval,20000,'2022-10-20 12:00','6vs6 2파전'
,'stadium1',1,'ONLY풋살화',12,'1시간 30분 ~ 2시간','모든 수준',0);

insert into social_match values(match_no_seq.nextval,30000,'2022-10-22 16:00','7vs7 2파전'
,'stadium3',1,'ONLY풋살화',14,'2시간 ~ 2시간 30분','초보',7);

insert into social_match values(match_no_seq.nextval,30000,'2022-10-21 12:00','6vs6 3파전'
,'stadium2',1,'풋살화,축구화가능',18,'2시간 30분 ~ 3시간','모든 수준',16);

insert into social_match values(match_no_seq.nextval,30000,'2022-10-27 13:00','6vs6 3파전'
,'stadium3',1,'풋살화,축구화가능',18,'2시간 30분 ~ 3시간','중급',16);

insert into social_match values(match_no_seq.nextval,30000,'2022-10-27 14:00','6vs6 3파전'
,'stadium3',1,'풋살화,축구화가능',18,'2시간 30분 ~ 3시간','중급',16);

insert into social_match values(match_no_seq.nextval,30000,'2022-10-27 18:00','6vs6 3파전'
,'stadium3',1,'풋살화,축구화가능',18,'2시간 30분 ~ 3시간','중급',18);

insert into social_match values(match_no_seq.nextval,30000,'2022-10-28 13:00','6vs6 3파전'
,'stadium3',1,'풋살화,축구화가능',18,'2시간 30분 ~ 3시간','중급',16);

insert into social_match values(match_no_seq.nextval,30000,'2022-10-28 14:00','6vs6 3파전'
,'stadium3',1,'풋살화,축구화가능',18,'2시간 30분 ~ 3시간','중급',16);

insert into social_match values(match_no_seq.nextval,30000,'2022-10-28 18:00','6vs6 3파전'
,'stadium3',1,'풋살화,축구화가능',18,'2시간 30분 ~ 3시간','중급',18);

create sequence cash_no_seq
start with 1
increment by 1
nocache;

insert into cash values(cash_no_seq.nextval,'hong',100000,null,sysdate);

create sequence recruit_no_seq
start with 1
increment by 1
nocache;

create sequence Stadium_Match_No_seq
start with 1
increment by 1
nocache;

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-20 12:00',1,'stadium1','hong',50000);
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-22 16:00',1,'stadium2','hong',60000);
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-21 12:00',1,'stadium3','hong',70000);

insert into recruit values(recruit_no_seq.nextval,'서울특별시','10월 20일 12시 풋살하실 2분 모집','12명 모집될 수 있으며 모집된 인원에 맞춰 로테이션으로 진행될 예정입니다.
<br>풋살화 필참입니다! 댓글로 참여여부 남겨주세요.','hong',3,sysdate,1);


--------------------Stadium_match에 시작시간, 끝나는 시간 컬럼 넣어주려고 데이터 지우고 컬럼 추가해줌-------------
delete from recruit;
delete from stadium_match;

alter table stadium_match add start_time varchar2(50) not null;
alter table stadium_match add end_time varchar2(50) not null;

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-20 12:00',1,'stadium1','hong',50000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-22 16:00',1,'stadium2','hong',60000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-21 12:00',1,'stadium3','hong',70000, '12:00', '14:00');

insert into recruit values(recruit_no_seq.nextval,'서울특별시','10월 20일 12시 풋살하실 2분 모집','12명 모집될 수 있으며 모집된 인원에 맞춰 로테이션으로 진행될 예정입니다.
<br>풋살화 필참입니다! 댓글로 참여여부 남겨주세요.','hong',7,sysdate,1);

-------------------------------------------Stadium_match mem_id 컬럼 null가능하게 바꾸고 insert 늘림-------------------------------
delete from recruit;
delete from stadium_match;

alter table stadium_match modify mem_id null;

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-20 12:00',1,'stadium1',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-20 14:00',0,'stadium1','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-20 16:00',1,'stadium1',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-20 18:00',0,'stadium1','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-20 12:00',1,'stadium2',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-20 14:00',0,'stadium2','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-20 16:00',1,'stadium2',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-20 18:00',0,'stadium2','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-20 12:00',1,'stadium3',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-20 14:00',0,'stadium3','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-20 16:00',1,'stadium3',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-20 18:00',0,'stadium3','hong',40000, '18:00', '20:00');

-------------------------------------------------------------------------------------------------------------------------------

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-21 12:00',1,'stadium1',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-21 14:00',0,'stadium1','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-21 16:00',1,'stadium1',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-21 18:00',0,'stadium1','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-21 12:00',1,'stadium2',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-21 14:00',0,'stadium2','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-21 16:00',1,'stadium2',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-21 18:00',0,'stadium2','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-21 12:00',1,'stadium3',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-21 14:00',0,'stadium3','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-21 16:00',1,'stadium3',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-21 18:00',0,'stadium3','hong',40000, '18:00', '20:00');

-------------------------------------------------------------------------------------------------------------------------------

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-22 12:00',1,'stadium1',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-22 14:00',0,'stadium1','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-22 16:00',1,'stadium1',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-22 18:00',0,'stadium1','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-22 12:00',1,'stadium2',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-22 14:00',0,'stadium2','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-22 16:00',1,'stadium2',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-22 18:00',0,'stadium2','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-22 12:00',1,'stadium3',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-22 14:00',0,'stadium3','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-22 16:00',1,'stadium3',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-22 18:00',0,'stadium3','hong',40000, '18:00', '20:00');

insert into recruit values(recruit_no_seq.nextval,'서울특별시','10월 20일 12시 풋살하실 2분 모집','12명 모집될 수 있으며 모집된 인원에 맞춰 로테이션으로 진행될 예정입니다.
<br>풋살화 필참입니다! 댓글로 참여여부 남겨주세요.','hong',7,sysdate,1);
--------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------- social_match table 수정&컬럼추가 -------------------------------------------------------------------
delete social_match where gender=1;

alter table social_match add match_type varchar2(50) not null;
alter table social_match modify stadium_name INVISIBLE;
alter table social_match modify gender INVISIBLE;
alter table social_match modify shoes INVISIBLE;
alter table social_match modify player_num INVISIBLE;
alter table social_match modify match_time INVISIBLE;
alter table social_match modify match_level INVISIBLE;
alter table social_match modify current_count INVISIBLE;

alter table social_match modify stadium_name VISIBLE;
alter table social_match modify gender VISIBLE;
alter table social_match modify shoes VISIBLE;
alter table social_match modify player_num VISIBLE;
alter table social_match modify match_time VISIBLE;
alter table social_match modify match_level VISIBLE;
alter table social_match modify current_count VISIBLE;

insert into social_match values(match_no_seq.nextval,20000,'2022-10-30 10:00','6vs6','2파전'
,'stadium1',1,'ONLY풋살화',12,'1시간 30분 ~ 2시간','모든수준',0);

insert into social_match values(match_no_seq.nextval,30000,'2022-10-30 11:00','7vs7','2파전'
,'stadium3',1,'ONLY풋살화',14,'2시간 ~ 2시간 30분','초보',7);

insert into social_match values(match_no_seq.nextval,30000,'2022-10-30 12:00','6vs6','3파전'
,'stadium2',1,'풋살화,축구화가능',18,'2시간 ~ 2시간 30분','중급',7);

insert into social_match values(match_no_seq.nextval,30000,'2022-10-30 13:00','7vs7','2파전'
,'stadium1',1,'ONLY풋살화',14,'2시간 ~ 2시간 30분','고급',7);

insert into social_match values(match_no_seq.nextval,30000,'2022-10-30 14:00','7vs7','3파전'
,'stadium3',1,'풋살화,축구화가능',21,'2시간 ~ 2시간 30분','초보',7);

insert into social_match values(match_no_seq.nextval,30000,'2022-10-30 15:00','7vs7','2파전'
,'stadium2',1,'ONLY풋살화',14,'2시간 ~ 2시간 30분','모든수준',7);

insert into social_match values(match_no_seq.nextval,30000,'2022-10-31 11:00','6vs6','3파전'
,'stadium2',1,'풋살화,축구화가능',18,'2시간 30분 ~ 3시간','모든수준',16);

insert into social_match values(match_no_seq.nextval,30000,'2022-10-31 13:00','6vs6','2파전'
,'stadium1',1,'풋살화ONLY',12,'2시간 30분 ~ 3시간','초보',8);

insert into social_match values(match_no_seq.nextval,30000,'2022-10-31 14:00','7vs7','2파전'
,'stadium3',1,'풋살화ONLY',14,'2시간 30분 ~ 3시간','고급',12);

insert into social_match values(match_no_seq.nextval,30000,'2022-10-31 16:00','7vs7','3파전'
,'stadium2',1,'풋살화ONLY',21,'2시간 30분 ~ 3시간','중급',16);

insert into social_match values(match_no_seq.nextval,30000,'2022-10-31 19:00','6vs6','2파전'
,'stadium3',1,'풋살화ONLY',12,'2시간 30분 ~ 3시간','고급',12);

insert into social_match values(match_no_seq.nextval,30000,'2022-11-01 10:00','6vs6', '3파전'
,'stadium1',1,'풋살화,축구화가능',18,'2시간 30분 ~ 3시간','모든수준',18);

insert into social_match values(match_no_seq.nextval,30000,'2022-11-01 14:00','7vs7','2파전'
,'stadium3',1,'ONLY풋살화',14,'2시간 ~ 2시간 30분','초보',7);

insert into social_match values(match_no_seq.nextval,30000,'2022-11-02 12:00','6vs6','3파전'
,'stadium1',1,'풋살화,축구화가능',18,'2시간 30분 ~ 3시간','고급',10);

insert into social_match values(match_no_seq.nextval,30000,'2022-11-02 16:00','7vs7','3파전'
,'stadium3',1,'풋살화,축구화가능',21,'2시간 30분 ~ 3시간','중급',16);

insert into social_match values(match_no_seq.nextval,30000,'2022-11-03 12:00','6vs6','3파전'
,'stadium1',1,'풋살화,축구화가능',18,'2시간 30분 ~ 3시간','고급',10);

insert into social_match values(match_no_seq.nextval,30000,'2022-11-03 16:00','7vs7','2파전'
,'stadium3',1,'ONLY풋살화',14,'2시간 ~ 2시간 30분','초보',7);

insert into social_match values(match_no_seq.nextval,30000,'2022-11-03 18:00','6vs6','2파전'
,'stadium2',1,'ONLY풋살화',12,'2시간 ~ 2시간 30분','모든수준',12);

insert into social_match values(match_no_seq.nextval,30000,'2022-11-03 20:00','7vs7','3파전'
,'stadium1',1,'ONLY풋살화',21,'2시간 ~ 2시간 30분','초보',19);

-----------------------------stadium_match insert(데이터 날짜 최신화해서)---------------------------------------------------------
delete from recruit;
delete from stadium_match;

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-31 12:00',1,'stadium1',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-31 14:00',0,'stadium1','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-31 16:00',1,'stadium1',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-31 18:00',0,'stadium1','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-31 12:00',1,'stadium2',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-31 14:00',0,'stadium2','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-31 16:00',1,'stadium2',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-31 18:00',0,'stadium2','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-31 12:00',1,'stadium3',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-31 14:00',0,'stadium3','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-31 16:00',1,'stadium3',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-10-31 18:00',0,'stadium3','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-01 12:00',1,'stadium1',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-01 14:00',0,'stadium1','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-01 16:00',1,'stadium1',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-01 18:00',0,'stadium1','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-01 12:00',1,'stadium2',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-01 14:00',0,'stadium2','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-01 16:00',1,'stadium2',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-01 18:00',0,'stadium2','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-01 12:00',1,'stadium3',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-01 14:00',0,'stadium3','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-01 16:00',1,'stadium3',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-01 18:00',0,'stadium3','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-02 12:00',1,'stadium1',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-02 14:00',0,'stadium1','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-02 16:00',1,'stadium1',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-02 18:00',0,'stadium1','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-02 12:00',1,'stadium2',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-02 14:00',0,'stadium2','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-02 16:00',1,'stadium2',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-02 18:00',0,'stadium2','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-02 12:00',1,'stadium3',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-02 14:00',0,'stadium3','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-02 16:00',1,'stadium3',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-02 18:00',0,'stadium3','hong',40000, '18:00', '20:00');

insert into recruit values(recruit_no_seq.nextval,'서울특별시','10월 20일 12시 풋살하실 2분 모집','12명 모집될 수 있으며 모집된 인원에 맞춰 로테이션으로 진행될 예정입니다.
<br>풋살화 필참입니다! 댓글로 참여여부 남겨주세요.','hong',115,sysdate,1);


---------------------------------------------------------stadium에 구장 특이사항 컬럼 10개 추가------------------------------------

delete from recruit;

delete from stadium_match;

delete from social_match;

delete from stadium;

alter table stadium drop column etc;

alter table stadium add etc1 varchar2(2000);
alter table stadium add etc2 varchar2(2000);
alter table stadium add etc3 varchar2(2000);
alter table stadium add etc4 varchar2(2000);
alter table stadium add etc5 varchar2(2000);
alter table stadium add etc6 varchar2(2000);
alter table stadium add etc7 varchar2(2000);
alter table stadium add etc8 varchar2(2000);
alter table stadium add etc9 varchar2(2000);
alter table stadium add etc10 varchar2(2000);

--------------------------------------------------------------------------------------------------------------------------------
insert into stadium (STADIUM_NAME, ADDRESS, CITY, STADIUM_SIZE, SHOWER, PARKING_LOT, SHOES_RENTAL, VEST_RENTAL, ETC1, ETC2 ,ETC3,ETC4,ETC5,ETC6) values('stadium1', '서울특별시 강남구 테헤란로', '서울특별시',
 '19x41m', '1', '1', '1', '1', '특이사항 : 주차 5시간 무료로 가능', '특이사항 1-2', '특이사항 1-3', '특이사항 1-4', '특이사항 1-5', '특이사항 1-6'); 

insert into stadium (STADIUM_NAME, ADDRESS, CITY, STADIUM_SIZE, SHOWER, PARKING_LOT, SHOES_RENTAL, VEST_RENTAL, ETC1, ETC2 ,ETC3,ETC4,ETC5,ETC6,ETC7,ETC8) values('stadium2', '경기도 수원시 팔달구', '경기도',
'35x40m', '1', '0', '1', '0', '특이사항 : 유료주차, 조끼렌탈 불가능', '특이사항 2-2', '특이사항 2-3', '특이사항 2-4', '특이사항 2-5', '특이사항 2-6', '특이사항 2-7', '특이사항 2-8'); 

insert into stadium (STADIUM_NAME, ADDRESS, CITY, STADIUM_SIZE, SHOWER, PARKING_LOT, SHOES_RENTAL, VEST_RENTAL, ETC1, ETC2 ,ETC3,ETC4,ETC5) values('stadium3', '부산광역시 해운대구 반송동', '부산광역시', 
'15x20m', '1', '1', '1', '0', '특이사항 : 주차 건물 내 지하주차장 사용', '특이사항 3-2', '특이사항 3-3', '특이사항 3-4', '특이사항 3-5'); 

insert into stadium (STADIUM_NAME, ADDRESS, CITY, STADIUM_SIZE, SHOWER, PARKING_LOT, SHOES_RENTAL, VEST_RENTAL, ETC1, ETC2 ,ETC3,ETC4,ETC5,ETC6) values('stadium1', '서울특별시 강남구 테헤란로', '서울특별시',
 '19x41m', '1', '1', '1', '0', '특이사항 : 주차 5시간 무료로 가능', '특이사항 1-2', '특이사항 1-3', '특이사항 1-4', '특이사항 1-5', '특이사항 1-6'); 

insert into stadium (STADIUM_NAME, ADDRESS, CITY, STADIUM_SIZE, SHOWER, PARKING_LOT, SHOES_RENTAL, VEST_RENTAL, ETC1, ETC2 ,ETC3,ETC4,ETC5,ETC6,ETC7,ETC8) values('stadium2', '경기도 수원시 팔달구', '경기도',
'35x40m', '1', '0', '1', '0', '특이사항 : 유료주차, 조끼렌탈 불가능', '특이사항 2-2', '특이사항 2-3', '특이사항 2-4', '특이사항 2-5', '특이사항 2-6', '특이사항 2-7', '특이사항 2-8'); 

insert into stadium (STADIUM_NAME, ADDRESS, CITY, STADIUM_SIZE, SHOWER, PARKING_LOT, SHOES_RENTAL, VEST_RENTAL, ETC1, ETC2 ,ETC3,ETC4,ETC5) values('stadium3', '부산광역시 해운대구 반송동', '부산광역시', 
'15x20m', '1', '1', '1', '0', '특이사항 : 주차 건물 내 지하주차장 사용', '특이사항 3-2', '특이사항 3-3', '특이사항 3-4', '특이사항 3-5'); 

insert into stadium (STADIUM_NAME, ADDRESS, CITY, STADIUM_SIZE, SHOWER, PARKING_LOT, SHOES_RENTAL, VEST_RENTAL, ETC1, ETC2 ,ETC3,ETC4,ETC5,ETC6) values('stadium4', '서울특별시 강남구 테헤란로', '서울특별시',
 '19x41m', '1', '1', '1', '0', '특이사항 : 주차 5시간 무료로 가능', '특이사항 4-2', '특이사항 4-3', '특이사항 4-4', '특이사항 4-5', '특이사항 4-6'); 

insert into stadium (STADIUM_NAME, ADDRESS, CITY, STADIUM_SIZE, SHOWER, PARKING_LOT, SHOES_RENTAL, VEST_RENTAL, ETC1, ETC2 ,ETC3,ETC4,ETC5,ETC6,ETC7,ETC8) values('stadium5', '경기도 수원시 팔달구', '경기도',
'35x40m', '1', '0', '1', '0', '특이사항 : 유료주차, 조끼렌탈 불가능', '특이사항 5-2', '특이사항 5-3', '특이사항 5-4', '특이사항 5-5', '특이사항 5-6', '특이사항 5-7', '특이사항 2-8'); 

insert into stadium (STADIUM_NAME, ADDRESS, CITY, STADIUM_SIZE, SHOWER, PARKING_LOT, SHOES_RENTAL, VEST_RENTAL, ETC1, ETC2 ,ETC3,ETC4,ETC5) values('stadium6', '부산광역시 해운대구 반송동', '부산광역시', 
'15x20m', '1', '1', '1', '0', '특이사항 : 주차 건물 내 지하주차장 사용', '특이사항 6-2', '특이사항 6-3', '특이사항 6-4', '특이사항 6-5'); 

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 12:00',1,'stadium1',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 14:00',0,'stadium1','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 16:00',1,'stadium1',Null,30000, '16:00', '18:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 12:00',1,'stadium2',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 14:00',0,'stadium2','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 16:00',1,'stadium2',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 18:00',0,'stadium2','hong',40000, '18:00', '20:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 20:00',1,'stadium2',Null,30000, '16:00', '18:00');



insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 12:00',1,'stadium3',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 14:00',0,'stadium3','hong',20000, '14:00', '16:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 12:00',1,'stadium4',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 14:00',0,'stadium4','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 16:00',1,'stadium4',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 18:00',0,'stadium4','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 12:00',1,'stadium5',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 14:00',0,'stadium5','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 16:00',1,'stadium5',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 18:00',0,'stadium5','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 12:00',1,'stadium6',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 14:00',0,'stadium6','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 16:00',1,'stadium6',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 18:00',0,'stadium6','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 12:00',1,'stadium1',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 14:00',0,'stadium1','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 16:00',1,'stadium1',Null,30000, '16:00', '18:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 12:00',1,'stadium2',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 14:00',0,'stadium2','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 16:00',1,'stadium2',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 18:00',0,'stadium2','hong',40000, '18:00', '20:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 20:00',1,'stadium2',Null,30000, '16:00', '18:00');


insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 12:00',1,'stadium3',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 14:00',0,'stadium3','hong',20000, '14:00', '16:00');


insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 12:00',1,'stadium4',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 14:00',0,'stadium4','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 16:00',1,'stadium4',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 18:00',0,'stadium4','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 12:00',1,'stadium5',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 14:00',0,'stadium5','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 16:00',1,'stadium5',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 18:00',0,'stadium5','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 12:00',1,'stadium6',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 14:00',0,'stadium6','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 16:00',1,'stadium6',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 18:00',0,'stadium6','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 12:00',1,'stadium1',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 14:00',0,'stadium1','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 16:00',1,'stadium1',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 18:00',0,'stadium1','hong',40000, '18:00', '20:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 20:00',1,'stadium1',Null,30000, '16:00', '18:00');


insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 12:00',1,'stadium2',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 14:00',0,'stadium2','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 16:00',1,'stadium2',Null,30000, '16:00', '18:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 12:00',1,'stadium3',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 14:00',0,'stadium3','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 16:00',1,'stadium3',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 18:00',0,'stadium3','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 12:00',1,'stadium4',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 14:00',0,'stadium4','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 16:00',1,'stadium4',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 18:00',0,'stadium4','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 12:00',1,'stadium5',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 14:00',0,'stadium5','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 16:00',1,'stadium5',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 18:00',0,'stadium5','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 12:00',1,'stadium6',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 14:00',0,'stadium6','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 16:00',1,'stadium6',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 18:00',0,'stadium6','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-14 12:00',1,'stadium1',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-14 14:00',0,'stadium1','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-14 16:00',1,'stadium1',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-14 18:00',0,'stadium1','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-14 12:00',1,'stadium2',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-14 14:00',0,'stadium2','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-14 16:00',1,'stadium2',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-14 18:00',0,'stadium2','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-14 12:00',1,'stadium3',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-14 14:00',0,'stadium3','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-14 16:00',1,'stadium3',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-14 18:00',0,'stadium3','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-14 12:00',1,'stadium4',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-14 14:00',0,'stadium4','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-14 16:00',1,'stadium4',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-14 18:00',0,'stadium4','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-15 12:00',1,'stadium5',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-15 14:00',0,'stadium5','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-15 16:00',1,'stadium5',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-15 18:00',0,'stadium5','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-15 12:00',1,'stadium6',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-15 14:00',0,'stadium6','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-15 16:00',1,'stadium6',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-15 18:00',0,'stadium6','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-16 12:00',1,'stadium1',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-16 14:00',0,'stadium1','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-16 16:00',1,'stadium1',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-16 18:00',0,'stadium1','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-17 12:00',1,'stadium2',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-17 14:00',0,'stadium2','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-17 16:00',1,'stadium2',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-17 18:00',0,'stadium2','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-17 12:00',1,'stadium3',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-17 14:00',0,'stadium3','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-17 16:00',1,'stadium3',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-17 18:00',0,'stadium3','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-17 12:00',1,'stadium4',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-17 14:00',0,'stadium4','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-17 16:00',1,'stadium4',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-17 18:00',0,'stadium4','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-17 12:00',1,'stadium5',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-17 14:00',0,'stadium5','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-17 16:00',1,'stadium5',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-17 18:00',0,'stadium5','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-17 12:00',1,'stadium6',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-17 14:00',0,'stadium6','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-17 16:00',1,'stadium6',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-17 18:00',0,'stadium6','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-18 12:00',1,'stadium1',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-18 14:00',0,'stadium1','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-18 16:00',1,'stadium1',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-18 18:00',0,'stadium1','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-18 12:00',1,'stadium2',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-18 14:00',0,'stadium2','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-18 16:00',1,'stadium2',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-18 18:00',0,'stadium2','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-18 12:00',1,'stadium3',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-18 14:00',0,'stadium3','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-18 16:00',1,'stadium3',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-18 18:00',0,'stadium3','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-18 12:00',1,'stadium4',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-18 14:00',0,'stadium4','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-18 16:00',1,'stadium4',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-18 18:00',0,'stadium4','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-18 12:00',1,'stadium5',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-18 14:00',0,'stadium5','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-18 16:00',1,'stadium5',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-18 18:00',0,'stadium5','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-18 12:00',1,'stadium6',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-18 14:00',0,'stadium6','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-18 16:00',1,'stadium6',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-18 18:00',0,'stadium6','hong',40000, '18:00', '20:00');


select * from member;

alter member 

commit;

select * from cash;





insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 12:00',1,'stadium1',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 14:00',0,'stadium1','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 16:00',1,'stadium1',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 18:00',0,'stadium1','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 12:00',1,'stadium2',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 14:00',0,'stadium2','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 16:00',1,'stadium2',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 18:00',0,'stadium2','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 12:00',1,'stadium3',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 14:00',0,'stadium3','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 16:00',1,'stadium3',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 18:00',0,'stadium3','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 12:00',1,'stadium4',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 14:00',0,'stadium4','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 16:00',1,'stadium4',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 18:00',0,'stadium4','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 12:00',1,'stadium5',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 14:00',0,'stadium5','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 16:00',1,'stadium5',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 18:00',0,'stadium5','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 12:00',1,'stadium6',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 14:00',0,'stadium6','hong',20000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 16:00',1,'stadium6',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 18:00',0,'stadium6','hong',40000, '18:00', '20:00');


-------------------------------------------------------------------------------------------------------------------

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-08 12:00',1,'stadium1',Null,30000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-08 14:00',1,'stadium1',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-08 16:00',1,'stadium1',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-08 18:00',0,'stadium1','hong',30000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-08 12:00',1,'stadium2',Null,30000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-08 14:00',1,'stadium2',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-08 16:00',1,'stadium2',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-08 18:00',0,'stadium2','hong',30000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-08 12:00',1,'stadium3',Null,30000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-08 14:00',1,'stadium3',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-08 16:00',1,'stadium3',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-08 18:00',0,'stadium3','hong',30000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-08 12:00',1,'stadium4',Null,30000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-08 14:00',1,'stadium4',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-08 16:00',1,'stadium4',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-08 18:00',0,'stadium4','hong',30000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-08 12:00',1,'stadium5',Null,30000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-08 14:00',1,'stadium5',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-08 16:00',1,'stadium5',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-08 18:00',0,'stadium5','hong',30000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-08 12:00',1,'stadium6',Null,30000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-08 14:00',1,'stadium6',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-08 16:00',1,'stadium6',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-08 18:00',0,'stadium6','hong',30000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 12:00',1,'stadium1',Null,30000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 14:00',1,'stadium1',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 16:00',1,'stadium1',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 18:00',0,'stadium1','hong',30000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 12:00',1,'stadium2',Null,30000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 14:00',1,'stadium2',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 16:00',1,'stadium2',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 18:00',0,'stadium2','hong',30000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 12:00',1,'stadium3',Null,30000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 14:00',1,'stadium3',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 16:00',1,'stadium3',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 18:00',0,'stadium3','hong',30000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 12:00',1,'stadium4',Null,30000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 14:00',1,'stadium4',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 16:00',1,'stadium4',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 18:00',0,'stadium4','hong',30000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 12:00',1,'stadium5',Null,30000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 14:00',1,'stadium5',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 16:00',1,'stadium5',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 18:00',0,'stadium5','hong',30000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 12:00',1,'stadium6',Null,30000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 14:00',1,'stadium6',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 16:00',1,'stadium6',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-09 18:00',0,'stadium6','hong',30000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-10 12:00',1,'stadium1',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-10 14:00',1,'stadium1',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-10 16:00',1,'stadium1',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-10 18:00',0,'stadium1','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-10 12:00',1,'stadium2',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-10 14:00',1,'stadium2',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-10 16:00',1,'stadium2',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-10 18:00',0,'stadium2','hong',40000, '18:00', '20:00');


insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-10 12:00',1,'stadium3',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-10 14:00',1,'stadium3',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-10 16:00',1,'stadium3',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-10 18:00',0,'stadium3','hong',40000, '18:00', '20:00');


insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-10 12:00',1,'stadium4',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-10 14:00',1,'stadium4',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-10 16:00',1,'stadium4',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-10 18:00',0,'stadium4','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-10 12:00',1,'stadium5',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-10 14:00',1,'stadium5',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-10 16:00',1,'stadium5',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-10 18:00',0,'stadium5','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-10 12:00',1,'stadium6',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-10 14:00',1,'stadium6',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-10 16:00',1,'stadium6',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-10 18:00',0,'stadium6','hong',40000, '18:00', '20:00');


insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 12:00',1,'stadium1',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 14:00',1,'stadium1',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 16:00',1,'stadium1',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 18:00',0,'stadium1','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 12:00',1,'stadium2',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 14:00',1,'stadium2',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 16:00',1,'stadium2',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 18:00',0,'stadium2','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 12:00',1,'stadium3',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 14:00',1,'stadium3',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 16:00',1,'stadium3',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 18:00',0,'stadium3','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 12:00',1,'stadium4',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 14:00',1,'stadium4',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 16:00',1,'stadium4',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 18:00',0,'stadium4','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 12:00',1,'stadium5',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 14:00',1,'stadium5',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 16:00',1,'stadium5',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 18:00',0,'stadium5','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 12:00',1,'stadium6',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 14:00',1,'stadium6',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 16:00',1,'stadium6',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-11 18:00',0,'stadium6','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 12:00',1,'stadium1',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 14:00',1,'stadium1',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 16:00',1,'stadium1',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 18:00',0,'stadium1','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 12:00',1,'stadium2',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 14:00',1,'stadium2',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 16:00',1,'stadium2',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 18:00',0,'stadium2','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 12:00',1,'stadium3',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 14:00',1,'stadium3',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 16:00',1,'stadium3',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 18:00',0,'stadium3','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 12:00',1,'stadium4',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 14:00',1,'stadium4',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 16:00',1,'stadium4',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 18:00',0,'stadium4','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 12:00',1,'stadium5',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 14:00',1,'stadium5',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 16:00',1,'stadium5',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 18:00',0,'stadium5','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 12:00',1,'stadium6',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 14:00',1,'stadium6',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 16:00',1,'stadium6',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-12 18:00',0,'stadium6','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 12:00',1,'stadium1',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 14:00',1,'stadium1',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 16:00',1,'stadium1',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 18:00',0,'stadium1','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 12:00',1,'stadium2',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 14:00',1,'stadium2',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 16:00',1,'stadium2',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 18:00',0,'stadium2','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 12:00',1,'stadium3',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 14:00',1,'stadium3',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 16:00',1,'stadium3',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 18:00',0,'stadium3','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 12:00',1,'stadium4',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 14:00',1,'stadium4',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 16:00',1,'stadium4',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 18:00',0,'stadium4','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 12:00',1,'stadium5',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 14:00',1,'stadium5',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 16:00',1,'stadium5',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 18:00',0,'stadium5','hong',40000, '18:00', '20:00');

insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 12:00',1,'stadium6',Null,10000, '12:00', '14:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 14:00',1,'stadium6',Null,30000, '14:00', '16:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 16:00',1,'stadium6',Null,30000, '16:00', '18:00');
insert into Stadium_match values(Stadium_Match_No_seq.nextval,'2022-11-13 18:00',0,'stadium6','hong',40000, '18:00', '20:00');
commit;

alter table social_match add manager varchar2(50);

insert into social_match values(match_no_seq.nextval,20000,'2022-11-11 10:00','6vs6','2파전'
,'stadium1',1,'ONLY풋살화',12,'2시간','모든수준',0, '홍길동', '10:00', );

insert into social_match values(match_no_seq.nextval,30000,'2022-11-11 11:00','7vs7','2파전'
,'stadium3',1,'ONLY풋살화',14,'2시간 ~ 2시간 30분','초보',7, '홍길동');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-11 12:00','6vs6','3파전'
,'stadium2',1,'풋살화,축구화가능',18,'2시간 ~ 2시간 30분','중급',7, '홍길동');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-11 13:00','7vs7','2파전'
,'stadium1',1,'ONLY풋살화',14,'2시간 ~ 2시간 30분','고급',7, '홍길동');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-11 14:00','7vs7','3파전'
,'stadium3',1,'풋살화,축구화가능',21,'2시간 ~ 2시간 30분','초보',7, '홍길동');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-11 15:00','7vs7','2파전'
,'stadium2',1,'ONLY풋살화',14,'2시간 ~ 2시간 30분','모든수준',7, '홍길동');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-12 11:00','6vs6','3파전'
,'stadium2',1,'풋살화,축구화가능',18,'2시간 30분 ~ 3시간','모든수준',16, '홍길동');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-12 13:00','6vs6','2파전'
,'stadium1',1,'풋살화ONLY',12,'2시간 30분 ~ 3시간','초보',8, '홍길동');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-12 14:00','7vs7','2파전'
,'stadium3',1,'풋살화ONLY',14,'2시간 30분 ~ 3시간','고급',12, '홍길동');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-12 16:00','7vs7','3파전'
,'stadium2',1,'풋살화ONLY',21,'2시간 30분 ~ 3시간','중급',16, '홍길동');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-12 19:00','6vs6','2파전'
,'stadium3',1,'풋살화ONLY',12,'2시간 30분 ~ 3시간','고급',12, '홍길동');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-13 10:00','6vs6', '3파전'
,'stadium1',1,'풋살화,축구화가능',18,'2시간 30분 ~ 3시간','모든수준',18, '홍길동');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-13 14:00','7vs7','2파전'
,'stadium3',1,'ONLY풋살화',14,'2시간 ~ 2시간 30분','초보',7, '홍길동');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-13 12:00','6vs6','3파전'
,'stadium1',1,'풋살화,축구화가능',18,'2시간 30분 ~ 3시간','고급',10, '홍길동');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-13 16:00','7vs7','3파전'
,'stadium3',1,'풋살화,축구화가능',21,'2시간 30분 ~ 3시간','중급',16, '홍길동');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-08 12:00','6vs6','3파전'
,'stadium1',1,'풋살화,축구화가능',18,'2시간 30분 ~ 3시간','고급',10, '홍길동');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-08 16:00','7vs7','2파전'
,'stadium3',1,'ONLY풋살화',14,'2시간 ~ 2시간 30분','초보',7, '홍길동');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-08 18:00','6vs6','2파전'
,'stadium2',1,'ONLY풋살화',12,'2시간 ~ 2시간 30분','모든수준',12, '홍길동');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-08 20:00','7vs7','3파전'
,'stadium1',1,'ONLY풋살화',21,'2시간 ~ 2시간 30분','초보',19, '홍길동');

commit;

delete from social_match;
alter table social_match add start_time varchar2(50) not null;
alter table social_match add end_time varchar2(50) not null;

insert into social_match values(match_no_seq.nextval,20000,'2022-11-11 10:00','6vs6','2파전'
,'stadium1',1,'ONLY풋살화',12,'2시간','모든수준',0, 'hong', '10:00', '12:00');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-11 11:00','7vs7','2파전'
,'stadium3',1,'ONLY풋살화',14,'2시간','초보',7, 'hong', '11:00', '13:00');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-11 12:00','6vs6','3파전'
,'stadium2',1,'풋살화,축구화가능',18,'2시간','중급',7, 'hong', '12:00', '14:00');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-11 13:00','7vs7','2파전'
,'stadium1',1,'ONLY풋살화',14,'2시간','고급',7, 'hong', '13:00', '15:00');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-11 14:00','7vs7','3파전'
,'stadium3',1,'풋살화,축구화가능',21,'2시간','초보',7, 'hong', '14:00', '16:00');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-11 15:00','7vs7','2파전'
,'stadium2',1,'ONLY풋살화',14,'2시간','모든수준',7, 'hong', '15:00', '17:00');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-12 11:00','6vs6','3파전'
,'stadium2',1,'풋살화,축구화가능',18,'2시간','모든수준',16, 'hong', '11:00', '13:00');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-12 13:00','6vs6','2파전'
,'stadium1',1,'풋살화ONLY',12,'2시간','초보',8, 'hong', '13:00', '15:00');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-12 14:00','7vs7','2파전'
,'stadium3',1,'풋살화ONLY',14,'2시간 30분','고급',12, 'hong', '14:00', '16:30');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-12 16:00','7vs7','3파전'
,'stadium2',1,'풋살화ONLY',21,'2시간 30분','중급',16, 'hong', '16:00', '18:30');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-12 19:00','6vs6','2파전'
,'stadium3',1,'풋살화ONLY',12,'2시간 30분','고급',12, 'hong', '19:00', '21:30');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-13 10:00','6vs6', '3파전'
,'stadium1',1,'풋살화,축구화가능',18,'2시간 30분','모든수준',18, 'hong', '10:00', '12:30');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-13 14:00','7vs7','2파전'
,'stadium3',1,'ONLY풋살화',14,'2시간 30분','초보',7, 'hong', '14:00', '16:30');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-14 12:00','6vs6','3파전'
,'stadium1',1,'풋살화,축구화가능',18,'2시간 30분간','고급',10, 'hong', '12:00', '14:30');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-14 16:00','7vs7','3파전'
,'stadium3',1,'풋살화,축구화가능',21,'2시간 30분','중급',16, 'hong', '16:00', '18:30');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-15 12:00','6vs6','3파전'
,'stadium1',1,'풋살화,축구화가능',18,'2시간 30분','고급',10, 'hong', '12:00', '14:30');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-15 16:00','7vs7','2파전'
,'stadium3',1,'ONLY풋살화',14,'2시간 30분','초보',7, 'hong', '16:00', '18:30');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-15 18:00','6vs6','2파전'
,'stadium2',1,'ONLY풋살화',12,'2시간 30분','모든수준',12, 'hong', '18:00', '20:30');

insert into social_match values(match_no_seq.nextval,30000,'2022-11-15 20:00','7vs7','3파전'
,'stadium1',1,'ONLY풋살화',21,'2시간 30분','초보',19, 'hong', '20:00', '22:30');
select * from stadium;

delete from social_history;
delete from



delete from social_match;

commit;

create table social_history(
 social_history_no number primary key,
 mem_id,
match_no,
 constraint socialhistory_memid_fk foreign key(mem_id) references member(mem_id),
constraint socialhistory_matchno_fk foreign key(match_no) references social_match(match_no)
);

alter table member modify cash default 0;

update member set cash = 0;



create sequence social_history_seq
start with 1
increment by 1
nocache;

select * from social_history;

delete from cash;
commit;

alter table cash add note varchar2(100);
update cash set note='충전' where m_cash is null;
update cash set note='결제' where p_cash is null;




select * from stadium;
select a.recruit_no, a.stadium_name, a.title, a.recruit_content, a.mem_id ,a.regdate, a.match_level, b.stadium_match_no, b.match_date,
		b.price, b.start_time, b.end_time, c.address from recruit a, stadium_match b, stadium c where a.stadium_match_no = b.stadium_match_no 
		and b.stadium_name = c.stadium_name and c.city like '서울특별시';
        
alter table social_history modify mem_id not null;
alter table social_history modify MATCH_NO not null;