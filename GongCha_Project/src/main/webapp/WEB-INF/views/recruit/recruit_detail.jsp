<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="../include/header.jsp" />
<script>
	function del_check(url){
		var del_text = confirm('게시글을 삭제하시겠습니까?');
		
		if(del_text == true){
			location = url;
		}
	}
	
	function clipBoard(){
		var content = document.getElementById('copy-url1').innerHTML;

		navigator.clipboard.writeText(content).then(() => {
		    alert('주소가 클립보드에 복사되었습니다.')
		}).catch(err => {
		    console.log('Something went wrong', err);
		})
		}
	
	function getList(){
		const recruit_no = $('#recruit_no').val();
		
		$.ajax({
			url : "reply_list",
			type : "get",
			data : {
				"recruit_no" :recruit_no
			},
			contentType : "application/json; charset:UTF-8",
			dataType : "json",
			success : function(data){
				console.log("댓글 리스트 가져오기 성공");
				console.log(data.list);
				
				const count = data.list.length;
				$("#title").html("댓글 "+count+"개");
				//댓글 목록을 html로 담기
				let html = "";
				
				if(data.list.length > 0){
					for(let i = 0; i < data.list.length; i++){
						 let reply_no = data.list[i].reply_no;
			             let recruit_no = data.list[i].recruit_no;
			             let reply_group = data.list[i].reply_group;
			             let reply_order = data.list[i].reply_order;
			             let reply_class = data.list[i].reply_class;
			             let mem_id = data.list[i].mem_id;
			             let reply_content = data.list[i].reply_content;
			             let regi_date = data.list[i].regi_date;
			             
			             html += "<li class='reply_item'>";
			             html += "<div class='reply_area'>";
			             html += "<div class='reply_box'>";
			             html += "<div class='reply_nick'>";
			             html += "<div class='reply_nick_info'>";
			             html += "<div class='reply_nickname'>"+mem_id+"</div></div></div>";
			             html += "<div class='reply_text_box'>";
			             html += "<p class='reply_text_view'>";
			             html += "<span class='text_reply'>"+reply_content+"</span></p></div>";
			             html += "<div class='reply_info_box'>";
			             html += "<span class='reply_info_date'>"+regi_date+"</span>";
			             html += "<a href='#' class='reply_info_button'>"+'답글쓰기'+ "</a></div></div></div></li>";
			             
			             
			         
					}
				}
				$("#reply_list").html(html);
			}
		})
	}
	
	$(document).ready(function(){
		getList();
	});
	
	$(document).on("click", "#c_regi", function(){
		//Json으로 전달할 파라미터 변수선언
		const recruit_no = $('#recruit_no').val();
		const reply_content = $('#reply_content').val();
		
		console.log(reply_content);
	
		if(reply_content == '') {
			alert('내용을 입력하세요');
			$("#reply_content").val('').focus();
		}else{
		
		$.ajax({
			type:'post',
			url:'recruit_reply_ok',
			data: 
				{
					"recruit_no":recruit_no,
					"reply_content":reply_content
				},
			success:function(data){

				if(data === 'Success') {
					console.log('댓글 등록 완료');
   					$('#reply_content').val('');
				} else {
					console.log('댓글 등록 실패');
					alert("다시 로그인해 주세요");
					location='/member/login';
				}
				getList();
			},
			error:function(){
				alert('통신실패');
			}
		});// 댓글 비동기 끝
		}
	});
	
	
</script>
<link rel="stylesheet" type="text/css"
	href="/resources/css/recruit_detail.css" />
<input type="hidden" name="recruit_no" id="recruit_no"
	value="${o.recruit_no}" />
<div class="contai">
	<div id="recruit_wrapper">

		<div id="body">
			<div id="map"></div>

			<div class="contents-box">
				<div class="conten">
					<div class="date">${fn:substring(o.match_date,0,16)}~
						${o.end_time }</div>


					<span class="edit"> <c:if test="${t.mem_id eq id}">
							<a href="/recruit/recruit_edit?recruit_no=${o.recruit_no}">수정</a> · <a
								href="/recruit/recruit_del?recruit_no=${o.recruit_no}"
								onclick="del_check('recruit_del')">삭제</a>
						</c:if>
					</span>


					<div class="location">${o.stadium_name}</div>
					<div class="address">
						<span id="copy-url1">${o.address}</span> <span> <c:if
								test="${o.match_level == 1}">초보</c:if> <c:if
								test="${o.match_level == 2}">중급</c:if> <c:if
								test="${o.match_level == 3}">상급</c:if>
						</span> <span>${o.price}원</span>
					</div>
					<div class="address_buttons">
						<a pf-active="false" class="copy_address_button"> <span
							class="text" onclick="clipBoard()">주소 복사하기</span></a>

					</div>
					<div class="user">
						<p id="mem_id">${o.mem_id}</p>
					</div>
					<p style="font-size: 13px;">${fn:substring(o.regdate,0,16) }</p>

					<div class="contents">
						<div>${cont}</div>
					</div>

					<div class="comment">
						<div class="pre_head">
							<div class="title" id="title"></div>
						</div>
						<ul class="reply_list" id="reply_list">
							<!-- 댓글 리스트 -->
							<!-- 						<li class="reply_item"> -->
							<!-- 							<div class="reply_area"> -->
							<!-- 								<div class="reply_box"> -->
							<!-- 									<div class="reply_nick"> -->
							<!-- 										<div class="reply_nick_info"> -->
							<!-- 											<div class="reply_nickname"> -->
							<!-- 												재그리입니다만 -->
							<!-- 											</div> -->
							<!-- 										</div> -->
							<!-- 									</div> -->
							<!-- 									<div class="reply_text_box"> -->
							<!-- 										<p class="reply_text_view"> -->
							<!-- 											<span class="text_reply">아아아 테스트요오오오오</span> -->
							<!-- 										</p> -->
							<!-- 									</div> -->
							<!-- 									<div class="reply_info_box"> -->
							<!-- 										<span class="reply_info_date">2023.00.00 00:00</span> -->
							<!-- 										<a href="#" class="reply_info_button"> 답글쓰기 </a> -->
							<!-- 									</div> -->
							<!-- 								</div> -->
							<!-- 							</div> -->
							<!-- 						</li> -->

							<!-- 대댓글 박스 -->
							<!-- 						<li class="reply_item"> -->
							<!-- 							<div class="re_reply_area"> -->
							<!-- 								<div class="reply_box"> -->
							<!-- 									<div class="reply_nick"> -->
							<!-- 										<div class="reply_nick_info"> -->
							<!-- 											<div class="reply_nickname"> -->
							<!-- 												대댓글아이디요 -->
							<!-- 											</div> -->
							<!-- 										</div> -->
							<!-- 									</div> -->
							<!-- 									<div class="reply_text_box"> -->
							<!-- 										<p class="reply_text_view"> -->
							<!-- 											<span class="text_reply">대댓글 찍</span> -->
							<!-- 										</p> -->
							<!-- 									</div> -->
							<!-- 									<div class="reply_info_box"> -->
							<!-- 										<span class="reply_info_date">2023.00.00 00:00</span> -->
							<!-- 										<a href="#" class="reply_info_button"> 답글쓰기 </a> -->
							<!-- 									</div> -->
							<!-- 								</div> -->
							<!-- 							</div> -->
							<!-- 						</li> -->

							<!-- 답글 박스 -->
							<!-- 						<li class="comment_item_reply"> -->
							<!-- 							<div class="commentWriter"> -->
							<!-- 					  <div class="comment_inbox"> -->
							<%-- 					    <em class="name">${o.mem_id}</em> --%>
							<!-- 					    <textarea class="inbox_text" placeholder="답글을 남겨보세요" rows="1" oninput='this.style.height = ""; this.style.height = this.scrollHeight + "px"' -->
							<!-- 					     style="overflow: hidden;overflow-wrap: break-word; height: 17px;"></textarea> -->

							<!-- 					    <div class="comment_regi"> -->
							<!-- 					    <a href="#" role="button" class="c_regi">등록</a> -->
							<!-- 					  </div> -->
							<!-- 					  </div> -->

							<!-- 					</div> -->
							<!-- 						</li> -->

						</ul>
					</div>
					<!--<form action="/recruit/recruit_reply_ok" method="post"> -->
					<div class="commentWriter">
						<div class="comment_inbox">
							<em class="name">${o.mem_id}</em>
							<textarea class="inbox_text" id="reply_content"
								placeholder="댓글을 남겨보세요" rows="1"
								oninput='this.style.height = ""; this.style.height = this.scrollHeight + "px"'
								style="overflow: hidden; overflow-wrap: break-word; height: 17px;"></textarea>

							<div class="comment_regi">
								<button id="c_regi" class="c_regi">등록</button>
							</div>
						</div>
					</div>
					<!--</form> -->
				</div>
			</div>
		</div>


	</div>
</div>
<!-- 카카오맵 api -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c1e91324cb846f49c6af089e52a7498a"></script>

<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(37.31180981633277, 126.8289844683709), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(37.31180981633277, 126.8289844683709); 

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
// marker.setMap(null);    
</script>

<jsp:include page="../include/footer.jsp" />
</body>
</html>