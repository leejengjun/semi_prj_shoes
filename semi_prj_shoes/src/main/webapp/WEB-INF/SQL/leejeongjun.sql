select * 
from seq;

desc SEQ_CATEGORY_CNUM;

show recyclebin;

purge recyclebin; -- 휴지통 비우기

select *
from TBL_PRODUCT;

desc TBL_PRODUCT;
desc TBL_CATEGORY;

select *
from TBL_CATEGORY
order by registerday desc;


---- *** 제품 테이블 : tbl_product *** ----
-- drop table tbl_product purge; 
create table tbl_product
(pnum           number(8) not null       -- 제품번호(Primary Key)
,pname          varchar2(100) not null   -- 제품명
,fk_cnum        number(8)                -- 카테고리코드(Foreign Key)의 시퀀스번호 참조
,pcompany       varchar2(50)             -- 제조회사명
,pimage         varchar2(100) default 'noimage.png' -- 제품이미지1   이미지파일명
,prdmanual_systemFileName varchar2(200)            -- 파일서버에 업로드되어지는 실제 제품설명서 파일명 (파일명이 중복되는 것을 피하기 위해서 중복된 파일명이 있으면 파일명뒤에 숫자가 자동적으로 붙어 생성됨)
,prdmanual_orginFileName  varchar2(200)            -- 웹클라이언트의 웹브라우저에서 파일을 업로드 할때 올리는 제품설명서 파일명 
,pqty           number(8) default 0      -- 제품 재고량
,price          number(8) default 0      -- 제품 정가
,saleprice      number(8) default 0      -- 제품 판매가(할인해서 팔 것이므로)
,fk_snum        number(8)                -- 'HIT', 'NEW', 'BEST' 에 대한 스펙번호인 시퀀스번호를 참조
,pcontent       varchar2(4000)           -- 제품설명  varchar2는 varchar2(4000) 최대값이므로
                                         --          4000 byte 를 초과하는 경우 clob 를 사용한다.
                                         --          clob 는 최대 4GB 까지 지원한다.
,summary_pcontent   varchar2(4000)       -- 제품요약설명
,psize           varchar2(10)             -- 신발 사이즈

,point          number(8) default 0      -- 포인트 점수                                         
,pinputdate     date default sysdate     -- 제품입고일자
,constraint  PK_tbl_product_pnum primary key(pnum)
,constraint  FK_tbl_product_fk_cnum foreign key(fk_cnum) references tbl_category(cnum)
,constraint  FK_tbl_product_fk_snum foreign key(fk_snum) references tbl_spec(snum)
); -- Table TBL_PRODUCT이(가) 생성되었습니다.

delete from tbl_product;

-- drop sequence seq_tbl_product_pnum;
create sequence seq_tbl_product_pnum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;    -- Sequence SEQ_TBL_PRODUCT_PNUM이(가) 생성되었습니다.

-- 데이터 삽입.
-- 남성용
-- 히트상품 2개
insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage, pqty, price, saleprice, fk_snum, pcontent, summary_pcontent, psize, point)
values(seq_tbl_product_pnum.nextval, '척70 로파이 크래프트 데저트샌드', 1, '컨버스', 'manP01.jpg', 100,99000,79000, 1,'기차 엔지니어와 철도 노동자 워크 웨어에서 처음 등장했던 타이트-니트 스트라이프 패턴의 기원은 미국 노동자들의 헤리티지에 뿌리를 두고 있는데, 이러한 패턴이 1970년대 컨버스 빈티지 아이콘에서 완벽하게 매치됩니다. 컨버스 척70은 클래식 룩을 토대로, 약 50% 재활용 코튼 염직물 소재의 어퍼, 100% 재활용 폴리에스테르 스타 앵클 패치, 신발을 쉽게 신고 벗는데 유용한 100% 재활용 폴리에스테르 힐 루프 등을 더하여 현대적으로 업데이트 됩니다. 오솔라이트 삭 라이너와 윙 텅 스티치가 발을 편안하게 해주고, 유광의 이그리트 컬러 미드솔이 워크 웨어에서 영감을 받은 룩을 세련되게 업그레이드 합니다.', '오래된 철도 노동자 워크 웨어에서 영감을 받은 히커리 스트라이프로, 유행을 타지 않는 패턴을 새롭게 해석한 최고의 척70.','280', 79);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage, pqty, price, saleprice, fk_snum, pcontent, summary_pcontent, psize, point)
values(seq_tbl_product_pnum.nextval, '컨버스 X 조슈아 비데스 웨폰 CX 블랙', 1, '컨버스', 'manP11.jpg', 100,139000,119000, 1,'조슈아 비데스와의 두번째 컬렉션은 동료 크리에이터들에게 영감을 주면서도 기존의 스트릿 아이콘을 새롭게 디자인하기 위해 고안된 예술적인 장인 정신에 대한 찬사를 담았습니다. 이번 컬렉션은 그의 시그니처 컬러 팔레트와 세밀한 디테일로 웨폰 CX에 작업 과정과 공예에 대한 이야기를 전하고 있습니다. 해진 듯한 마감의 캔버스 어퍼, 토 부분의 구멍이 뚫린 듯한 투명 TPU, 쿼터 패널, 혁신적인 CX 쿠셔닝이 특징입니다. 이번 디자인의 힘은 디테일에 있습니다. 스니커즈를 무궁무진한 가능성으로 탈바꿈한 그의 독특하면서도 사려 깊은 터치를 확인해 보세요.', '조슈아 비데스만의 예술적인 감각과 장인 정신 및 크리에이터들의 비주얼 언어가 1980년대 코트의 클래식을 새롭게 탄생시켰습니다.','280', 119);

-- 신상품 2개
insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage, pqty, price, saleprice, fk_snum, pcontent, summary_pcontent, psize, point)
values(seq_tbl_product_pnum.nextval, '척테일러 올스타 시즈널 컬러 퍼플', 1, '컨버스', 'manP21.jpg', 100,75000,65000, 2,'새로운 컬러로 돌아온, 편안한 레전드 데일리 스니커즈 입니다. 클래식 캔버스 척은 정장, 캐주얼 어디든 어울리는 옷장 필수템입니다. 여기에 라이닝, 스티치, 솔기를 부드럽게 하여 매일매일 하루 종일 신어도 편안한 착화감을 자랑합니다.', '하이 탑 스타일의 캔버스 스니커즈','270', 65);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage, pqty, price, saleprice, fk_snum, pcontent, summary_pcontent, psize, point)
values(seq_tbl_product_pnum.nextval, '컨버스 X 꼼데가르송 플레이 척 70 블랙', 1, '컨버스', 'manP31.jpg', 100,198000,178000, 2,'패션을 상징하는 두 브랜드인 컨버스와 꼼데가르송의 콜라보레이션. 컨버스의 아이코닉한 척 70 실루엣에 독특한 하트-앤-아이 로고가 더해져 심플하지만 재미있는 스타일의 스니커즈가 탄생했습니다.', '두 패션 아이콘의 콜라보레이션 컨버스 X 꼼데가르송 컬렉션','280', 178);

-- 베스트상품 2개
insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage, pqty, price, saleprice, fk_snum, pcontent, summary_pcontent, psize, point)
values(seq_tbl_product_pnum.nextval, '척 70 유틸리티 - 스트릿 유틸리티 볼드만다린', 1, '컨버스', 'manP41.jpg', 100,155000,145000, 3,'오랜 시간 스타일 아이콘 자리를 지키고 있는 척70은 농구코트부터 런웨이까지 이름을 날렸습니다. 더 길어진, 몰딩 러버 사이드월과 발을 보호하는 반투명 케이지 오버레이로 완전히 새로운 수준의 스타일을 보여줍니다. 투명 러버 미드솔과 아이코닉한 올스타 앵클 패치 등과 같은 헤리티지 요소들이 컨버스의 뿌리를 상기시키고, 프리미엄 오솔라이트 쿠셔닝 덕분에 편안하게 신을 수 있습니다.', '이미 최고인 척70에 물결 모양의 러버 오버레이와 투명한 케이지를 더하여 완성된 내구성이 높은 스타일.','270', 145);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage, pqty, price, saleprice, fk_snum, pcontent, summary_pcontent, psize, point)
values(seq_tbl_product_pnum.nextval, '런스타 모션 시즈널 컬러 스톰핑크', 1, '컨버스', 'manP51.jpg', 100,119000,109000, 3,'컨버스에서 가장 인기 있는 플랫폼 스니커즈의 계속된 변화로 탄생한 새로운 런 스타 모션으로 스타일이 업그레이드 됩니다. 아이코닉한 캔버스 하이탑 스니커즈에 눈에 띄게 커진 2가지 색조의 미드솔과 물결 모양의 미드솔이 만나서 매우 특별한 룩을 완성합니다. 발을 편안하게 해주는 CX 폼 쿠셔닝으로 편안함과 지지력이 향상되고, 확연히 눈에 띄는 올스타 앵클 패치 같은 헤리티지 요소들이 컨버스 레거시를 보여줍니다. ', '긍정적인 기운의 컬러','260', 109);


----- 아동신발 데이터 삽입
-- 베스트상품 2개
insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage, pqty, price, saleprice, fk_snum, pcontent, summary_pcontent, psize, point)
values(seq_tbl_product_pnum.nextval, '척테일러 올스타 크래프트 위드 러브 빈티지화이트', 3, '컨버스', 'kid01.jpg', 100,49000,39000, 3,'아이들이 척을 신고 자유롭게 표현하도록 해주세요. 우리 모두가 잘 알고 사랑하는, 확실한 척테일러 특징들에 사랑 넘치는 자수장식 디테일과 프린트 슈레이스가 조합된 하이탑 스니커즈입니다. 아이에 대한 모든 사랑을 담았습니다. 캔버스 하이탑 스니커즈', '하트 자수장식, 러브 프린트 슈레이스, 오버사이즈 하트 모양 앵클 패치로 사랑을 표현해 보세요.','170', 39);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage, pqty, price, saleprice, fk_snum, pcontent, summary_pcontent, psize, point)
values(seq_tbl_product_pnum.nextval, '척테일러 올스타 수퍼플레이 키즈 화이트', 3, '컨버스', 'kid31.jpg', 100,49000,39000, 3,'아이들의 신발을 고를 때에는 편안함이 우선입니다. 경량 코튼 스니커즈인 수퍼플레이 라인은 아이들이 편안하게 뛰어 노는데 필요한 모든 기술과 소재를 갖추고 있습니다. 신축성 있는 신발끈과 쉽게 착용할 수 있게 도와주는 스트랩은 탄탄한 지지력까지 더해주고 클래식한 블랙/화이트의 색상 조합은 어떤 옷에도 잘 어울리는 스타일을 만들어 줍니다.', '조절식 스트랩이 특징한 편안하고 클래식한 키즈 스니커즈','160', 39);

-- 히트상품 2개
insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage, pqty, price, saleprice, fk_snum, pcontent, summary_pcontent, psize, point)
values(seq_tbl_product_pnum.nextval, '척 70 빈티지 캔버스 인펀트 블랙', 3, '컨버스', 'kid11.jpg', 100,55000,45000, 1,'당대 최고의 디테일과 프리미엄 소재를 사용해 흠잡을 데 없는 장인정신으로 제작한 척 70을 인펀트 버전으로 선보입니다. 세련된 스타일의 아이콘으로, 하루종일 편안하고 기분좋은 패션을 완성합니다. 프리미엄 오가닉 캔버스로 정교하게 제작되어 더욱 세련된 스니커즈', '유아를 위한 프리미엄 컴포트 캔버스 스니커즈','140', 45);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage, pqty, price, saleprice, fk_snum, pcontent, summary_pcontent, psize, point)
values(seq_tbl_product_pnum.nextval, '척테일러 올스타 클래식 키즈 레드', 3, '컨버스', 'kid21.jpg', 100,39000,29000, 1,'컨버스의 아이코닉한 디자인의 척테일러가 키즈버전으로 탄생하였습니다. 옥스포드 실루엣의 이 스니커즈는 진정한 스타일의 유산이 될 것입니다. 척테일러와 함께 패션너블한 키즈의 아이콘이 되어보세요. 가볍고 견고한 캔버스 어퍼 시즌리스, 타임리스한 실루엣', '컨버스 아이코닉 스니커즈의 키즈 버전','190', 29);

-- 신상품 2개
insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage, pqty, price, saleprice, fk_snum, pcontent, summary_pcontent, psize, point)
values(seq_tbl_product_pnum.nextval, '척 70 빈티지 캔버스 키즈 선플라워', 3, '컨버스', 'kid41.jpg', 100,65000,45000, 2,'당대 최고의 디테일과 프리미엄 소재를 사용해 흠잡을 데 없는 장인정신으로 제작한 척 70을 키즈버전으로 선보입니다. 세련된 스타일의 아이콘으로, 하루종일 편안하고 기분 좋은 패션을 완성합니다. 내구성 및 높은 프리미엄 캔버스', '어린이를 위한 프리미엄 컴포트 캔버스 스니커즈','170', 45);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage, pqty, price, saleprice, fk_snum, pcontent, summary_pcontent, psize, point)
values(seq_tbl_product_pnum.nextval, '척테일러 올스타 클래식 키즈 블랙', 3, '컨버스', 'kid51.jpg', 100,39000,29000, 2,'컨버스의 아이코닉한 디자인의 척테일러가 키즈버전으로 탄생하였습니다. 하이탑 실루엣의 이 스니커즈는 진정한 스타일의 유산이 될 것입니다. 척테일러와 함께 패션의 아이콘이 되어보세요.', '가벼우면서도 견고한 캔버스 소재 어퍼','150', 29);


-----여성용 신발 데이터 삽입
-- 베스트 2개
insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage, pqty, price, saleprice, fk_snum, pcontent, summary_pcontent, psize, point)
values(seq_tbl_product_pnum.nextval, '척테일러 올스타 익스프레시브 크래프트 스티치 스톰윈드', 2, '컨버스', 'wom01.jpg', 100,79000,69000, 3,'토널 배색의 바느질로 재활용 캔버스의 디테일을 강조한 하이탑 스니커즈입니다. 솔부터 시작된 라운드 스티치는 힐 플레이트까지 전개되면서 어퍼의 깊이와 텍스처를 더 풍부하게 합니다. 지그재그 스티치가 안쪽 아치를 보강하고, 오솔라이트 인솔로 가장 편안하게 신을 수 있습니다. 약 65% 재활용 폴리에스테르와 약 35% 재활용 코튼이 혼합된 100% 재활용 캔버스 어퍼의 하이탑 스니커즈', '프리미엄 캔버스와 토널 배색의 바느질로 미래를 생각하고, 과거를 인정하는 코트의 레전드','240', 69);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage, pqty, price, saleprice, fk_snum, pcontent, summary_pcontent, psize, point)
values(seq_tbl_product_pnum.nextval, '척테일러 올스타 수딩 크래프트 에그렛', 2, '컨버스', 'wom11.jpg', 100,85000,75000, 3,'스플릿-스타일의 재활용 캔버스 어퍼를 사용한 자연스러운 텍스처의 외형에서 노스탤직 분위기를 느낄 수 있는 시즌 척테일러 올스타 하이탑 스니커즈입니다. 느긋한 분위기의 인클루시브 컬러 블로킹 기법을 더 많이 사용한, 정교한 스타일에 탠 러버 스타 앵클 패치가 절묘하게 조화를 이룹니다. 러버 토 캡, 다이아몬드 패턴 토 범퍼, 쿠셔닝을 더한 오솔라이트 삭 라이너 등 척테일러 올스타 디자인 요소로 전체적인 룩이 완성됩니다.', '커트 앤드 소운 기법의 컬러 블로킹 캔버스로 정교한 분위기가 연출된 클래식 척.','250', 75);

-- 히트 2개
insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage, pqty, price, saleprice, fk_snum, pcontent, summary_pcontent, psize, point)
values(seq_tbl_product_pnum.nextval, '척테일러 올스타 무브 모빌리티 에그렛', 2, '컨버스', 'wom21.jpg', 100,85000,75000, 1,'컨버스 하이탑 스니커즈의 캔버스 어퍼, 다이아몬드 패턴 토 범퍼, 스타 앵클 패치는 이미 익숙합니다. 이러한 아이코닉한 디자인에 간결한 변화를 꾀하고, 초경량 EVA 컵솔을 더한 척테일러 올스타 무브입니다. 옴브레 기법이 연상되는 프린트가 더 부드러워진 청록색 어퍼와 텅에 펼쳐지면서, 나의 스프링 컬러를 새롭게 해석합니다. 플랫폼 미드솔과 다이-컷 스마트폼 삭 라이너가 발 아래를 더 많이 받쳐주어, 높이가 높아져도 가볍고 편안하게 신을 수 있습니다.', '옴브레 기법의 얇은 막으로 완성된 산뜻한 룩의 초경량 플랫폼','240', 75);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage, pqty, price, saleprice, fk_snum, pcontent, summary_pcontent, psize, point)
values(seq_tbl_product_pnum.nextval, '척 70 플랜트 러브', 2, '컨버스', 'wom31.jpg', 100,115000,105000, 1,'컨버스의 디자이너들이 새로운 리미티드 에디션 척 70로 긍정의 메시지를 전합니다. 디자이너들의 아이디어를 자유롭게 펼쳐 만들어 낸 이번 컬렉션은 대자연에 대한 초현실적인 찬사를 담고 있으며, 자연에서 영감을 받은 일러스트와 그래픽 콜라주로 두 개의 클래식 캔버스를 뒤덮은 것이 특징입니다. 의인화된 버섯, 유쾌한 개구리, 꽃잎의 컬러를 담은 물방울처럼 재치있는 디테일의 다채로운 이미지들이 패널 전면에 적용되어 있습니다. 대자연을 생생하면서도 재미있게 표현한 플랜트 러브 컬렉션을 만나보세요.', '컨버스 디자인팀이 자연에서 영감을 받은 일러스트와 그래픽을 생동감 넘치게 콜라주하여 아이코닉한 척 70를 선보입니다.','240', 105);

-- 신상 2개
insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage, pqty, price, saleprice, fk_snum, pcontent, summary_pcontent, psize, point)
values(seq_tbl_product_pnum.nextval, '척테일러 올스타 러기드 플랫폼 러버 에그렛', 2, '컨버스', 'wom41.jpg', 100,89000,79000, 2,'러버를 입힌 어퍼로 멋진 유니폼 룩 연출, 발을 편안하게 해주는 오솔라이트, 부츠를 연상시키는 스타일의 러기드 아웃솔', '러기드 솔의 플랫폼 하이탑 스니커즈','250', 79);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage, pqty, price, saleprice, fk_snum, pcontent, summary_pcontent, psize, point)
values(seq_tbl_product_pnum.nextval, '척테일러 올스타 무브 시즈널 컬러 바이올렛', 2, '컨버스', 'wom51.jpg', 100,85000,75000, 2,'컨버스 하이탑 스니커즈의 캔버스 어퍼, 다이아몬드 패턴 아웃솔, 스타 앵클 패치는 이미 익숙합니다. 이러한 아이코닉한 디자인에 간결한 변화를 꾀하고, 초경량 EVA 컵솔을 더한 척테일러 올스타 무브입니다. 50% 캔버스와 50% 재활용 코튼 캔버스가 혼합된 어퍼로 더욱 자연스러운 룩에 봄이 연상되도록 재해석된 색조의 인클루시브 컬러를 더 많이 사용하여 변화를 꾀합니다. 우아한 디자인 라인의 플랫폼 미드솔로 스타일이 레벨업 되고, 발을 편안하게 해주는 스마트폼 삭 라이너로 스타일이 완성됩니다.', '새로운 스프링 컬러로 산뜻하게 업데이트 된 초경량 플랫폼.','250', 75);


COMMIT;

select *
from TBL_PRODUCT;



select rno, pnum, pname, fk_cnum, fk_snum
from
(
select rownum AS rno, pnum, pname, fk_cnum, fk_snum
    from
    (
        select pnum, pname, fk_cnum, fk_snum
        from tbl_product
        where pname like '%'||'로파이'||'%'
    ) V
) T
where rno between 1 and 5;  -- 1 페이지(한 페이지당 5개를 보여줄 때)


select *
from tbl_product
where pname like '%'||'로파이'||'%';

select pnum, pname, fk_cnum, fk_snum 
	from 
 (
select rownum AS rno, pnum, pname, fk_cnum, fk_snum 
 from 
( 
 select pnum, pname, fk_cnum, fk_snum 
from tbl_product 
where pname like '%'|| '에그렛' ||'%'
    ) V 
) T 
 where rno between 1 and 5;
 
 
 --------------------------------------
 
 ----- >>> 하나의 제품속에 여러개의 이미지 파일 넣어주기 <<< ------ 
select *
from tbl_product
order by pnum;  

-- drop table tbl_product_addimagefile purge;
create table tbl_product_addimagefile
(imgfileno     number         not null   -- 시퀀스로 입력받음.
,fk_pnum       number(8)      not null   -- 제품번호(foreign key)
,imgfilename   varchar2(100)  not null   -- 제품이미지파일명
,constraint PK_tbl_product_addimagefile primary key(imgfileno)
,constraint FK_tbl_product_addimagefile foreign key(fk_pnum) references tbl_product(pnum) on delete cascade -- 제품 삭세시 그 제품과 관련된 추가이미지는 필요없기에 해당 제품 삭제시 같이 삭제되도록 cascade 설정.
); -- Table TBL_PRODUCT_ADDIMAGEFILE이(가) 생성되었습니다.

-- drop sequence seq_addImgfileno;

create sequence seq_addImgfileno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;    -- Sequence SEQ_ADDIMGFILENO이(가) 생성되었습니다.

select *
from tab;

desc ;

select imgfileno, fk_pnum, imgfilename
from tbl_product_addimagefile
order by imgfileno desc;

----------------------------------------
-- 재고량 0개인 상품 인서트(테스트용)
insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage, pqty, price, saleprice, fk_snum, pcontent, summary_pcontent, psize, point)
values(seq_tbl_product_pnum.nextval, '척테일러 올스타 무브 슬레이트 세이지', 2, '컨버스', 'wom61.jpg', 0,85000,75000, 3,'컨버스 하이탑 스니커즈의 캔버스 어퍼, 다이아몬드 패턴 아웃솔, 아이코닉한 스타 앵클 패치는 이미 익숙합니다. 이러한 클래식 실루엣에 간결한 변화를 꾀하고, 스포츠에서 영감을 받은 우아한 라인과 초경량 EVA 컵솔을 더한 척테일러 올스타 무브입니다. 화사한 여름 컬러와 최소 50% 재활용 코튼 캔버스 소재의 어퍼를 사용하여 시즌용 디자인을 신중하게 업데이트 합니다. 편안함과 높이 모두 향상됩니다.', '산뜻한 컬러와 검 러버 아웃솔로 돌아온 초경량 플랫폼.','240', 75);

commit;
---------------------------------------------------------------
-- 제품 삭제 테스트용 인서트

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage, pqty, price, saleprice, fk_snum, pcontent, summary_pcontent, psize, point)
values(seq_tbl_product_pnum.nextval, '곧 삭제될 상품', 2, '컨버스', 'wom61.jpg', 0,85000,75000, 3,'컨버스 하이탑 스니커즈의 캔버스 어퍼, 다이아몬드 패턴 아웃솔, 아이코닉한 스타 앵클 패치는 이미 익숙합니다. 이러한 클래식 실루엣에 간결한 변화를 꾀하고, 스포츠에서 영감을 받은 우아한 라인과 초경량 EVA 컵솔을 더한 척테일러 올스타 무브입니다. 화사한 여름 컬러와 최소 50% 재활용 코튼 캔버스 소재의 어퍼를 사용하여 시즌용 디자인을 신중하게 업데이트 합니다. 편안함과 높이 모두 향상됩니다.', '산뜻한 컬러와 검 러버 아웃솔로 돌아온 초경량 플랫폼.','240', 75);

commit;

select *
from tbl_product
order by pnum desc;  

delete from tbl_product 
where pnum = 21;


-------- **** 장바구니 테이블 생성하기 **** ----------
 desc tbl_member;
 desc tbl_product;

 create table tbl_cart
 (cartno        number               not null   --  장바구니 번호             
 ,fk_userid     varchar2(20)         not null   --  사용자ID            
 ,fk_pnum       number(8)            not null   --  제품번호                
 ,oqty          number(8) default 0  not null   --  주문량                   
 ,registerday   date default sysdate            --  장바구니 입력날짜
 ,constraint PK_shopping_cart_cartno primary key(cartno)
 ,constraint FK_shopping_cart_fk_userid foreign key(fk_userid) references tbl_member(userid) 
 ,constraint FK_shopping_cart_fk_pnum foreign key(fk_pnum) references tbl_product(pnum)
 ); --Table TBL_CART이(가) 생성되었습니다.

 create sequence seq_tbl_cart_cartno
 start with 1
 increment by 1
 nomaxvalue
 nominvalue
 nocycle
 nocache;   -- Sequence SEQ_TBL_CART_CARTNO이(가) 생성되었습니다.

 comment on table tbl_cart
 is '장바구니 테이블';

 comment on column tbl_cart.cartno
 is '장바구니번호(시퀀스명 : seq_tbl_cart_cartno)';

 comment on column tbl_cart.fk_userid
 is '회원ID  tbl_member 테이블의 userid 컬럼을 참조한다.';

 comment on column tbl_cart.fk_pnum
 is '제품번호 tbl_product 테이블의 pnum 컬럼을 참조한다.';

 comment on column tbl_cart.oqty
 is '장바구니에 담을 제품의 주문량';

 comment on column tbl_cart.registerday
 is '장바구니에 담은 날짜. 기본값 sysdate';
 
 select *
 from user_tab_comments;

 select column_name, comments
 from user_col_comments
 where table_name = 'TBL_CART';
 
 select cartno, fk_userid, fk_pnum, oqty, registerday 
 from tbl_cart
 order by cartno asc;

select A.cartno, A.fk_userid, A.fk_pnum,
       B.pname, B.pimage, B.price, B.saleprice, B.point, A.oqty
from tbl_cart A join tbl_product B 
on A.fk_pnum = B.pnum
where A.fk_userid = 'ljj0791'
order by A.cartno desc;

--------------------------------------------------
-- drop table TBL_ORDER purge;

select *
from tab;

------------------ >>> 주문관련 테이블 <<< -----------------------------
-- [1] 주문 테이블    : tbl_order
-- [2] 주문상세 테이블 : tbl_orderdetail


-- *** "주문" 테이블 *** --
create table tbl_order
(odrcode        varchar2(20) not null          -- 주문코드(명세서번호)  주문코드 형식 : s+날짜+sequence ==> s20220411-1 , s20220411-2 , s20220411-3
                                               --                                                      s20220412-4 , s20220412-5 , s20220412-6
,fk_userid      varchar2(20) not null          -- 사용자ID
,odrtotalPrice  number       not null          -- 주문총액
,odrtotalPoint  number       not null          -- 주문총포인트
,odrdate        date default sysdate not null  -- 주문일자
,constraint PK_tbl_order_odrcode primary key(odrcode)
,constraint FK_tbl_order_fk_userid foreign key(fk_userid) references tbl_member(userid)
);  -- Table TBL_ORDER이(가) 생성되었습니다.


-- "주문코드(명세서번호) 시퀀스" 생성
create sequence seq_tbl_order
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;    -- Sequence SEQ_TBL_ORDER이(가) 생성되었습니다.

select 's'||to_char(sysdate,'yyyymmdd')||'-'||seq_tbl_order.nextval AS odrcode
from dual;
-- s20220411-1

select odrcode, fk_userid, 
       odrtotalPrice, odrtotalPoint,
       to_char(odrdate, 'yyyy-mm-dd hh24:mi:ss') as odrdate
from tbl_order
order by odrcode desc;


-- *** "주문상세" 테이블 *** --
create table tbl_orderdetail
(odrseqnum      number               not null   -- 주문상세 일련번호
,fk_odrcode     varchar2(20)         not null   -- 주문코드(명세서번호)
,fk_pnum        number(8)            not null   -- 제품번호
,oqty           number               not null   -- 주문량
,odrprice       number               not null   -- "주문할 그때 그당시의 실제 판매가격" ==> insert 시 tbl_product 테이블에서 해당제품의 saleprice 컬럼값을 읽어다가 넣어주어야 한다.
,deliverStatus  number(1) default 1  not null   -- 배송상태( 1 : 주문만 받음,  2 : 배송중,  3 : 배송완료)
,deliverDate    date                            -- 배송완료일자  default 는 null 로 함.
,constraint PK_tbl_orderdetail_odrseqnum  primary key(odrseqnum)
,constraint FK_tbl_orderdetail_fk_odrcode foreign key(fk_odrcode) references tbl_order(odrcode) on delete cascade
,constraint FK_tbl_orderdetail_fk_pnum foreign key(fk_pnum) references tbl_product(pnum)
,constraint CK_tbl_orderdetail check( deliverStatus in(1, 2, 3) )
);  -- Table TBL_ORDERDETAIL이(가) 생성되었습니다.


-- "주문상세 일련번호 시퀀스" 생성
create sequence seq_tbl_orderdetail
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;    -- Sequence SEQ_TBL_ORDERDETAIL이(가) 생성되었습니다.


select *
from tbl_order
order by odrcode desc;

select *
from tbl_orderdetail
order by odrseqnum desc;

select A.cartno, A.fk_userid, A.fk_pnum,
       B.pname, B.pimage, B.price, B.saleprice, B.point, A.oqty
from tbl_cart A join tbl_product B 
on A.fk_pnum = B.pnum
where A.fk_userid = 'abc'
order by A.cartno desc;


select *
from tbl_order A JOIN tbl_orderdetail B
on A.odrcode = B.fk_odrcode;

select *
from tbl_order A JOIN tbl_orderdetail B
on A.odrcode = B.fk_odrcode
where A.fk_userid = 'abc';



select odrcode, fk_userid, odrdate, odrseqnum, fk_pnum, oqty, odrprice, deliverstatus,
       pname, pimage, price, saleprice, point
from
(
select row_number() over (order by B.fk_odrcode desc, B.odrseqnum desc) AS RNO 
      , A.odrcode, A.fk_userid 
      , to_char(A.odrdate, 'yyyy-mm-dd hh24:mi:ss') AS odrdate 
      , B.odrseqnum, B.fk_pnum, B.oqty, B.odrprice 
      , case B.deliverstatus 
        when 1 then '주문완료' 
        when 2 then '배송중' 
        when 3 then '배송완료' 
        end AS deliverstatus 
    , C.pname, C.pimage, C.price, C.saleprice, C.point 
from tbl_order A join tbl_orderdetail B 
on A.odrcode = B.fk_odrcode 
join tbl_product C 
on B.fk_pnum = C.pnum
) V
where RNO between 1 and 3;


select odrcode, fk_userid, odrdate, odrseqnum, fk_pnum, oqty, odrprice, deliverstatus,
       pname, pimage, price, saleprice, point
from 
(
select row_number() over (order by B.fk_odrcode desc, B.odrseqnum desc) AS RNO 
      , A.odrcode, A.fk_userid 
      , to_char(A.odrdate, 'yyyy-mm-dd hh24:mi:ss') AS odrdate 
      , B.odrseqnum, B.fk_pnum, B.oqty, B.odrprice 
      , case B.deliverstatus 
        when 1 then '주문완료' 
        when 2 then '배송중' 
        when 3 then '배송완료' 
        end AS deliverstatus 
    , C.pname, C.pimage, C.price, C.saleprice, C.point 
from tbl_order A join tbl_orderdetail B 
on A.odrcode = B.fk_odrcode 
join tbl_product C 
on B.fk_pnum = C.pnum
where A.fk_userid = 'abc'
) V
where RNO between 1 and 3;

----- *** 좋아요, 싫어요 (투표) 테이블 생성하기 *** ----- 
create table tbl_product_like
(fk_userid   varchar2(40) not null 
,fk_pnum     number(8) not null
,constraint  PK_tbl_product_like primary key(fk_userid,fk_pnum)
,constraint  FK_tbl_product_like_userid foreign key(fk_userid) references tbl_member(userid)
,constraint  FK_tbl_product_like_pnum foreign key(fk_pnum) references tbl_product(pnum) on delete cascade
); -- Table TBL_PRODUCT_LIKE이(가) 생성되었습니다.

create table tbl_product_dislike
(fk_userid   varchar2(40) not null 
,fk_pnum     number(8) not null
,constraint  PK_tbl_product_dislike primary key(fk_userid,fk_pnum)
,constraint  FK_tbl_product_dislike_userid foreign key(fk_userid) references tbl_member(userid)
,constraint  FK_tbl_product_dislike_pnum foreign key(fk_pnum) references tbl_product(pnum) on delete cascade
); -- Table TBL_PRODUCT_DISLIKE이(가) 생성되었습니다.
----------------------------------------------------------------------------------------------------------------------------

select O.odrcode
from tbl_order O JOIN tbl_orderdetail D
on O.odrcode = D.fk_odrcode
where O.fk_userid = 'ljj0791' and D.fk_pnum = 62;

select O.odrcode
from tbl_order O JOIN tbl_orderdetail D
on O.odrcode = D.fk_odrcode
where O.fk_userid = 'ljj0791' and D.fk_pnum = 20;


--- ljj0791 이라는 사용자가 제품번호 58 제품을 좋아한다에 투표를 한다.
--- 먼저 ljj0791 이라는 사용자가 제품번호 58 제품을 싫어한다에 투표를 했을 수도 있다.
--- 그러므로 먼저 tbl_product_dislike 테이블에서 ljj0791 이라는 사용자가 제품번호 58 제품이 insert 되어진 것을 delete 해야 한다.

delete from tbl_product_dislike
where fk_userid = 'ljj0791' and fk_pnum = 62;

insert into tbl_product_like(fk_userid, fk_pnum)
values('ljj0791', 62);

select *
from tbl_product_like
where fk_pnum = 62;

rollback;

--- ljj0791 이라는 사용자가 제품번호 58 제품을 싫어한다에 투표를 한다.
--- 먼저 ljj0791 이라는 사용자가 제품번호 58 제품을 좋아한다에 투표를 했을 수도 있다.
--- 그러므로 먼저 tbl_product_like 테이블에서 ljj0791 이라는 사용자가 제품번호 58 제품이 insert 되어진 것을 delete 해야 한다.

delete from tbl_product_like
where fk_userid = 'ljj0791' and fk_pnum = 62;

insert into tbl_product_dislike(fk_userid, fk_pnum)
values('ljj0791', 62);

select *
from tbl_product_dislike
where fk_pnum = 62;

rollback;


-- 특정 제품에 대한 좋아요, 싫어요의 투표결과(select)
select count(*)
from tbl_product_like
where fk_pnum = 62;

select count(*)
from tbl_product_dislike
where fk_pnum = 62;

select
(select count(*)
from tbl_product_like
where fk_pnum = 62) AS LIKECNT
,
(select count(*)
from tbl_product_dislike
where fk_pnum = 62) AS DISLIKECNT
from dual;



-------- **** 상품구매 후기 테이블 생성하기 **** ----------
create table tbl_purchase_reviews
(review_seq          number 
,fk_userid           varchar2(20)   not null   -- 사용자ID       
,fk_pnum             number(8)      not null   -- 제품번호(foreign key)
,contents            varchar2(4000) not null
,writeDate           date default sysdate
,constraint PK_purchase_reviews primary key(review_seq)
,constraint UQ_tbl_purchase_reviews unique(fk_userid, fk_pnum)
-- 로그인하여 실제 해당 제품을 구매했을 때만 딱 1번만 작성할 수 있는 것. 제품후기를 삭제했을 경우에는 다시 작성할 수 있는 것임.
,constraint FK_purchase_reviews_userid foreign key(fk_userid) references tbl_member(userid) on delete cascade 
,constraint FK_purchase_reviews_pnum foreign key(fk_pnum) references tbl_product(pnum) on delete cascade
);  -- Table TBL_PURCHASE_REVIEWS이(가) 생성되었습니다.


create sequence seq_purchase_reviews
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;    -- Sequence SEQ_PURCHASE_REVIEWS이(가) 생성되었습니다.

select *
from tbl_purchase_reviews
order by review_seq desc;


select review_seq, name, fk_pnum, contents, to_char(writeDate, 'yyyy-mm-dd hh24:mi:ss') AS writeDate
from tbl_purchase_reviews R join tbl_member M
on R.fk_userid = M.userid 
where R.fk_pnum = 3
order by review_seq desc;





























