select * 
from tab;

create table tbl_prdimg_kje
(imgno number not null
,imgfilename varchar2(100) not null
,constraint PK_tbl_prdimg_kje primary key (imgno)
);
-- Table TBL_PRDIMG_KJE이(가) 생성되었습니다.

create sequence seq_kje_image
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into tbl_prdimg_kje(imgno, imgfilename) values(seq_kje_image.nextval, 'noimage.png');  
commit;



create table tbl_category
(cnum number(8) not null
,code varchar2(20) not null
,cname varchar2(100) not null
,constraint PK_tbl_category_cnum primary key(cnum)
,constraint UK_tbl_category_code unique(code)
);

insert into tbl_category(cnum, code, cname)
values(1, 'running', '운동화');

create table tbl_spec
(snum number(8) not null
,sname varchar2(100) not null 
,constraint PK_tbl_spec_snum primary key(snum)
,constraint UQ_tbl_spec_sname unique(sname)
);

insert into tbl_spec(snum, sname)
values(23, 'ex');

create table tbl_color
(ccode VARCHAR2(20) not null
,cname varchar2(20) 
,constraint PK_tbl_color_ccode primary key(ccode)
);

create table tbl_size
(psize number(8) not null
,constraint PK_tbl_size_size primary key(psize)
);

 drop table tbl_cart purge;

create table tbl_product
(pnum number(8) not null
,pname varchar2(100) not null
,fk_cnum number(8) not null
,pcompany varchar2(50)
,pimage1 varchar2(100) default 'noimage.png' 
,pimage2 varchar2(100) default 'noimage.png'
,pqty number(8) default 0
,price number(8) default 0
,saleprice number(8) default 0
,fk_snum number(8)
,pcontent varchar2(400)
,point number(8) default 0
,pinputdate date default sysdate
,fk_ccode varchar2(20) not null
,fk_psize number(8) not null
,constraint PK_tbl_product_pnum primary key(pnum)
,constraint fk_tbl_product_fk_cnum foreign key(fk_cnum) references tbl_category(cnum)
,constraint fk_tbl_product_fk_snum foreign key(fk_snum) references tbl_spec(snum)
,constraint fk_tbl_product_fk_ccode foreign key(fk_ccode) references tbl_color(ccode)
,constraint fk_tbl_product_fk_psize foreign key(fk_psize) references tbl_size(psize)
);


create table tbl_order
(odrcode  varchar2(20) not null
,fk_userid varchar2(20) not null
,odrtotalprice number not null
,odrtotalpoint number not null
,odrdate date default sysdate not null
,constraint PK_tbl_order_odrcode primary key(odrcode)
,constraint fk_tbl_order_fk_userid foreign key(fk_userid) references tbl_member(userid)
)

create table tbl_orderdetail
(odrseqnum number not null
,fk_odrcode varchar2(20) not null
,fk_pnum number(8) not null
,oqty number not null
,odrprice number not null
,deliverstaus number(1) default 1 not null
,deliverdate date
,constraint PK_tbl_orderdetail_odrseqnume primary key(odrseqnum)
,constraint fk_tbl_orderdetail_fk_odrcode foreign key(fk_odrcode) references tbl_order(odrcode)
,constraint fk_tbl_orderdetail_fk_pnum foreign key(fk_pnum) references tbl_product(pnum)
);

select *
from tbl_product;


delete from tbl_size;


commit;

select pnum, pname, pimage1, price
from tbl_product;

drop table tbl_color purge;

create table tbl_cart
(cartno number not null
,fk_userid varchar2(20) not null
,fk_pnum number(8) not null
,oqty number(4) default 0
,fk_pimage1 varchar2(100) default 'noimage.png'
,fk_ccode VARCHAR2(20) not null
,fk_psize number(8) not null
,fk_price number(8) default 0
,registerday date default sysdate
,constraint PK_tbl_cart_cartno primary key(cartno)
,constraint FK_tbl_cart_fk_userid foreign key(fk_userid) references tbl_member(userid)
,constraint FK_tbl_cart_fk_pnum foreign key(fk_pnum) references tbl_product(pnum)
,constraint Fk_tbl_cart_fk_ccode foreign key(fk_ccode) references tbl_color(ccode)
);

drop table tbl_product purge;

create table tbl_product
(pnum number(8) not null
,pname varchar2(100) not null
,fk_cnum number(8) not null
,pcompany varchar2(50)
,pimage1 varchar2(100) default 'noimage.png' 
,pimage2 varchar2(100) default 'noimage.png'
,pqty number(8) default 0
,price number(8) default 0
,saleprice number(8) default 0
,fk_snum number(8)
,pcontent varchar2(400)
,point number(8) default 0
,pinputdate date default sysdate
,constraint PK_tbl_product_pnum primary key(pnum)
,constraint fk_tbl_product_fk_cnum foreign key(fk_cnum) references tbl_category(cnum)
,constraint fk_tbl_product_fk_snum foreign key(fk_snum) references tbl_spec(snum)
);


delete from tbl_spec;

select *
from tbl_color;


insert into tbl_category (cnum, code, cname)
values(234, 'v-1', 'ex');
insert into tbl_spec (snum, sname)
values (45, '예시');


 
 
 /*
    on delete cascade 를 해주었으므로 부모테이블인 tbl_sangpum 테이블에서 행을 delete 를 할 때 
    먼저 자식테이블인 tbl_sangpum_review_2 테이블에서 자식레코드(행)를 먼저 delete를 해준다.
    즉, 아래의 DML 문이 먼저 자동적으로 실행되어진다. 
    delete from tbl_sangpum_review_2
    where fk_sangpum_code = 'swk';
    -- 2개 행 이(가) 삭제되었습니다.
 */

insert into tbl_color (ccode, cname)
values ('red', '빨강');
insert into tbl_color (ccode, cname)
values ('navy', '네이비');

insert into tbl_size(psize)
values(240);

commit;

insert into tbl_product(pnum,pname,fk_cnum,pcompany,pimage1,pimage2,pqty,price,saleprice,fk_snum,pcontent)
values(1, '척70', 1, '제조사', 'kjshoes1.PNG', 'kjshoes1.PNG', 566, 400000, 40000, 23, '신발입니다예시롤백할것');
insert into tbl_product(pnum,pname,fk_cnum,pcompany,pimage1,pimage2,pqty,price,saleprice,fk_snum,pcontent)
values(2, '척70', 1, '제조사', 'kjshoes2.PNG', 'kjshoes1.PNG', 566, 400000, 40000, 23, '신발입니다예시롤백할것');
insert into tbl_product(pnum,pname,fk_cnum,pcompany,pimage1,pimage2,pqty,price,saleprice,fk_snum,pcontent)
values(3, '척70', 1, '제조사', 'kjshoes3.PNG', 'kjshoes1.PNG', 566, 400000, 40000, 23, '신발입니다예시롤백할것');
insert into tbl_product(pnum,pname,fk_cnum,pcompany,pimage1,pimage2,pqty,price,saleprice,fk_snum,pcontent)
values(4, '척70', 1, '제조사', 'kjshoes4.PNG', 'kjshoes1.PNG', 566, 400000, 40000, 23, '신발입니다예시롤백할것');
insert into tbl_product(pnum,pname,fk_cnum,pcompany,pimage1,pimage2,pqty,price,saleprice,fk_snum,pcontent)
values(5, '척70', 1, '제조사', 'kjshoes5.PNG', 'kjshoes1.PNG', 566, 400000, 40000, 23, '신발입니다예시롤백할것');
insert into tbl_product(pnum,pname,fk_cnum,pcompany,pimage1,pimage2,pqty,price,saleprice,fk_snum,pcontent)
values(6, '척70', 1, '제조사', 'kjshoes3.PNG', 'kjshoes1.PNG', 566, 400000, 40000, 23, '신발입니다예시롤백할것');
insert into tbl_product(pnum,pname,fk_cnum,pcompany,pimage1,pimage2,pqty,price,saleprice,fk_snum,pcontent)
values(7, '척70', 1, '제조사', 'kjshoes2.PNG', 'kjshoes1.PNG', 566, 400000, 40000, 23, '신발입니다예시롤백할것');
insert into tbl_product(pnum,pname,fk_cnum,pcompany,pimage1,pimage2,pqty,price,saleprice,fk_snum,pcontent)
values(8, '척70', 1, '제조사', 'kjshoes1.PNG', 'kjshoes1.PNG', 566, 400000, 40000, 23, '신발입니다예시롤백할것');


commit;
DROP TABLE tbl_product CASCADE CONSTRAINTS;


select *
from tbl_main_img;