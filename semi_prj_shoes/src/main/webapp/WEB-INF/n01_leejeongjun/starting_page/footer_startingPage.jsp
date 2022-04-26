<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
	

</div>

	<!-- 풋터 시작 -->
	<div id="foorter" class=" footer mx-auto" style="margin-top: 100px; width: 70%; height: 100px;">
		<div class="row">
			<div class="col-md-8" id="first">
				<p style="margin-top: 10px;">	  (유)신발쇼핑몰  |  대표 홍길동  |  개인정보책임 홍길동  |  사업자등록번호 123-45-67890 </p>
				<p>	  통신판매업 신고번호 제2022-서울강남-00478호  |  통신판매업자 </p>
				<p>	  주소 서울특별시 강남구 테헤란로 152(역삼동) 강남파이낸스센트 32층 </p>
				<p>	  고객상담팀 : 080-123-4567(상담시간 월-금: AM 09:00 - PM 05:30 주말/공휴일 휴무) </p>
				<p>	  <a href="mailto:youngwoo4215@naver.com">youngwoo4215@naver.com</a>(24시간 접수 가능) </p>
			</div>
			
			<div class="col-md-4" id="second">
				<p style="margin-top: 10px;">		
					<a href="#" data-toggle="modal" data-target="#myModal_Terms_of_Use">사이트 이용 약관</a> 
				</p>
				<p>		
					<a href="#" data-toggle="modal" data-target="#myModal_privacy_policy">개인정보취급방침</a> 
				</p>
				<p>		이니시스 구매안전 서비스</p>
				<p>		결제대금예치업 등록번호 02-006-12345</p>
				
			</div>
		</div>
		
		<div class="text-center">&copy; Company 2022 </div>
	</div>
	<!-- 풋터 끝 -->
</div>

<%-- 사이트 이용약관 모달창 부분 --%>
<div class="modal" id="myModal_Terms_of_Use" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content bg-white">
            <div class="modal-header">
                <h5 class="modal-title text-black" style="font-size: 17pt; font-weight: bold;"> 사이트 이용약관</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body text-black">
            	<iframe src="/semi_prj_shoes/n01_leejungjun/terms_of_use/Terms_of_Use.jsp" width="100%;" height="500px" class="box"></iframe>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal" style="font-weight: bold; ">확인</button>
            </div>
        </div>
    </div>
</div>
<%-- 사이트 이용약관 모달창 부분 끝--%>

<%-- 개인정보 처리방침 모달창 부분 --%>
<div class="modal" id="myModal_privacy_policy" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content bg-white">
            <div class="modal-header">
                <h5 class="modal-title text-black" style="text-align:center; font-size: 17pt; font-weight: bold;"> 개인정보 취급방침</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body text-black">
            	<iframe src="/semi_prj_shoes/n01_leejungjun/privacy_policy/privacy_policy.jsp" width="100%;" height="500px" class="box"></iframe>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal" style="font-weight: bold; ">확인</button>
            </div>
        </div>
    </div>
</div>
<%-- 개인정보 처리방침 모달창 부분 끝--%>

</body>
</html>