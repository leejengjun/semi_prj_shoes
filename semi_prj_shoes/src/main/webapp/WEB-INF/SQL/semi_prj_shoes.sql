show user;
-- USER이(가) "SEMIORAUSER1"입니다. <-- 요거 나오셔야해요~~ㅎㅎ

select * from tab;

create table tbl_main_i
(imgno           number not null
,imgfilename     varchar2(100) not null
,constraint PK_tbl_main_i primary key(imgno)
);  
-- Table TBL_MAIN_IMAGE이(가) 생성되었습니다.

-- drop sequence seq_main_image2
create sequence seq_main_image1
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;    
-- Sequence SEQ_MAIN_IMAGE이(가) 생성되었습니다

insert into tbl_main_i(imgno, imgfilename) values(seq_main_image1.nextval, 'show1.jpg');  
insert into tbl_main_i(imgno, imgfilename) values(seq_main_image1.nextval, 'show2.jpg'); 
insert into tbl_main_i(imgno, imgfilename) values(seq_main_image1.nextval, 'show3.jpg'); 


commit; -- 커밋 완료.

select imgno, imgfilename
from tbl_main_i 
order by imgno asc;

drop TABLE TBL_MAIN_IMG purge;

commit;

---------------------------------------------------
create table tbl_main_img
(imgno           number not null
,imgfilename     varchar2(100) not null
,constraint PK_tbl_main_img primary key(imgno)
);  

--Table TBL_MAIN_IMG이(가) 생성되었습니다.


create sequence seq_main_image2
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;    
-- Sequence SEQ_MAIN_IMAGE2이(가) 생성되었습니다.

insert into tbl_main_img(imgno, imgfilename) values(seq_main_image2.nextval, 'show5.jpg');  
insert into tbl_main_img(imgno, imgfilename) values(seq_main_image2.nextval, 'show6.jpg'); 
insert into tbl_main_img(imgno, imgfilename) values(seq_main_image2.nextval, 'show7.jpg'); 
insert into tbl_main_img(imgno, imgfilename) values(seq_main_image2.nextval, 'show8.jpg'); 

commit; -- 커밋 완료.

select imgno, imgfilename
from tbl_main_img
order by imgno asc;


select * 
from tab;

select ceil(count(*)/10)
from tbl_product;



