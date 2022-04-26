show user;


select * from tab;


---- *** 게시판 공지사항 테이블 생성하기 *** ----
create table tbl_board_notice
(notice_no            number         not null          -- 글번호
,userid               varchar2(20)   not null          -- 작성자아이디
,notice_title         varchar2(100)  not null          -- 글제목
,notice_contents      varchar2(5000) not null          -- 글내용
,notice_date    date default sysdate not null          -- 작성일자
,notice_file          varchar2(100)                    -- 첨부파일
-- 참조할 테이블이 아직 없어서 빨간줄이 떠요
,constraint PK_tbl_board_notice primary key(notice_no)
,constraint FK_tbl_board_notice foreign key(userid) references -- 참조할_테이블 (참조할_컬럼), 멤버 테이블!!
);

create sequence notice_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

---- *** 게시판 이벤트 생성하기 *** ----
create table tbl_board_event
(event_no              number         not null          -- 글번호
,userid                varchar2(20)   not null          -- 작성자아이디
,event_title           varchar2(100)  not null          -- 글제목
,event_contents        varchar2(5000) not null          -- 글내용
,event_date      date default sysdate not null          -- 작성일자
,event_file            varchar2(100)                    -- 첨부파일
-- 참조할 테이블이 아직 없어서 빨간줄이 떠요
,constraint PK_tbl_board_event primary key(event_no)
,constraint FK_tbl_board_event foreign key(userid) references -- 참조할_테이블 (참조할_컬럼), 멤버 테이블!!
);

create sequence event_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;



-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

---- *** 게시판 리뷰 생성하기 *** ----
create table tbl_board_review
(review_no     number        not null                   -- 글번호
,userid     varchar2(20)  not null                      -- 작성자아이디
,pnum           number(8)   not null 
,review_title       varchar2(100) not null               -- 글제목
,review_contents      varchar2(5000) not null           -- 글내용
,review_date      date default sysdate not null         -- 작성일자
,review_file          VARCHAR2(100) not null            -- 첨부파일
-- 참조할 테이블이 아직 없어서 빨간줄이 떠요
,constraint PK_tbl_board_review primary key(review_no)
,constraint FK_tbl_board_review foreign key(userid) references -- 참조할_테이블 (참조할_컬럼), 멤버 테이블!!
);

create sequence review_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
