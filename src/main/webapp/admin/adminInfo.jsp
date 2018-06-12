<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>

<script src="/js/jquery-1.12.4.js"></script>
<script src="/js/jquery-ui.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

<script>
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullAddr = ''; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                fullAddr = data.roadAddress;

            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                fullAddr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
            if(data.userSelectedType === 'R'){
                //법정동명이 있을 경우 추가한다.
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                // 건물명이 있을 경우 추가한다.
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('sample6_address').value = fullAddr;

            // 커서를 상세주소 필드로 이동한다.
            document.getElementById('sample6_address2').focus();
        }
    }).open();
}
$(function(){
	$("#idChk").click(function() {
		if($("#adminid").val() == "") {
			alert("아이디를 입력해주세요.");
			$("#adminid").focus();
			return;
		}
		//var form = new FormData(document.getElementById('frm'));
		var data = "adminid="+$("#adminid").val();
		$.ajax({
			type: "POST",
			data: data,
			url: "/adminIdChk.do",
			dataType: "json",
			processData: false,
			contentType: false, 
			
			success: function(data) {
				if(data.result == "ok") {
					alert("중복된 아이디가 없습니다");
				} else {
					alert("중복된 아이디가 있습니다 (다시 입력해 주세요)");
				}
			},
			error: function () {
				alert("오류발생ㅠㅠ ");
			}
		});
	});
	$("#btnSubmit").click(function(){
		if($("#name").val() == "") {
			alert("이름을 입력해주세요.");
			$("#name").focus();
			return;
		}
		if($("#userid").val() == "") {
			alert("아이디를 입력해주세요.");
			$("#userid").focus();
			return;
		}
		if(    $("#pwd").val().length < 4 
			|| $("#pwd").val().length > 12 )
		{
			alert("암호는 4~12자리 사이로 입력해주세요");
			$("#pwd").focus();
			return;
		}
		if($("#pwd").val() != $("#pwd2").val()) {
			alert("암호가 일치하지 않습니다");
			$("#pwd").focus();
			return;
		}
		var hangle = /(^[a-zA-Z0-9가-힣 ]*$)/;
		var sang = $("#sample6_address2").val();
		
		if(!hangle.test(sang)) {
			alert("상세주소에는 특수문자가 올 수 없습니다.");
			$("#sample6_address2").focus();
			return;
		}
		if(confirm("저장하시겠습니까?")) {		
	 		//var formData = $("#frm").serialize();
	 		var phone  = $("#phone1").val();
	 			phone += "-" +  $("#phone2").val(); 
	 			phone += "-" +  $("#phone3").val();
	 		$("#phone").val(phone);
	 		
	 		var post  = $("#sample6_postcode").val();
	 			post += "/" + $("#sample6_address").val();
	 			post += "/" + $("#sample6_address2").val();
	 		$("#post").val(post);
	 		
	 		var email  = $("#email1").val();
	 			email += "@" + $("#email2").val();
	 		$("#email").val(email);
	 		
	 		var formData = $("#frm").serialize();
	 		// 비 동기 전송
			$.ajax({
				type: "POST",
				data: formData,
				url: "/adminInfoSave.do",

				success: function(data) {
					if(data.result == "ok") {
						alert("저장하였습니다.");
						location.href = "/adminLogin.do";
					} else {
						alert("저장 실패했습니다. 다시 시도해 주세요.");
					}
				},
				error: function () {
					alert("오류발생 ");
				}
			}); 
		}
	});
});
</script>

<table class="top">
	<tr class="top">
		<td class="top">admin join</td>
	</tr>
</table>


<form name="frm" id="frm">

<input type="hidden" name="phone" id="phone">
<input type="hidden" name="post" id="post">
<input type="hidden" name="email" id="email">

<table class="board">
	<tr class="board">
		<th class="head">이름</th>
		<td align="left" style="padding:5px;">
		<input type="text" name="name" id="name" style="width:15%;" autofocus/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">ID</th>
		<td align="left" style="padding:5px;">
		<input type="text" name="adminid" id="adminid" 
							placeholder="ID 입력" style="width: 15%;"/>
		<button type="button" id="idChk" class="white">중복확인</button>
		</td>
	</tr>
	<tr class="board">
		<th class="head">비밀번호</th>
		<td align="left" style="padding:5px;">
		<input type="password" name="pwd" id="pwd" style="width:25%;" placeholder="비밀번호 입력 (4~12자리)"/>
		(4~12자리)
		</td>
	</tr>
	<tr class="board">
		<th class="head">비밀번호 확인</th>
		<td align="left" style="padding:5px;">
		<input type="password" name="pwd2" id="pwd2" style="width:25%;" placeholder="동일하게 입력해 주세요"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">이메일</th>
		<td align="left" style="padding:5px;">
		<input type="text" name="email1" id="email1" style="width:20%;"/>
		@
		<select name="email2" id="email2">
			<option value="naver.com">naver.com</option>
			<option value="daum.net">daum.com</option>
			<option value="gmail.com">gmail.com</option>
		</select>
		</td>
	</tr>
	<tr class="board">
		<th class="head">생일</th>
		<td align="left" style="padding:5px;">
		<input type="text" name="birthday" id="birthday" style="width:20%"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">성별</th>
		<td align="left" style="padding:5px;">
		<input type="radio" name="gender" id="gender" value="W"/>WOMAN
		<input type="radio" name="gender" id="gender" value="M"/>MAN
		</td>
	</tr>
	<tr class="board">
		<th class="head">연락처</th>
		<td align="left" style="padding:5px;">
		<select name="phone1" id="phone1">
				<option value="010">010</option>
				<option value="011">011</option>
		</select> -
		<input type="text" name="phone2" id="phone2" maxlength="4" style="width:10%; IME-MODE: disabled;"/> -
		<input type="text" name="phone3" id="phone3" maxlength="4" style="width:10%; IME-MODE: disabled;"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">주소</th>
		<td style="text-align: left; padding:5px;">
		<input type="text" id="sample6_postcode" placeholder="우편번호" style="width:30%; margin-top: 1%;"readonly/>
		<button type="button" onclick="sample6_execDaumPostcode()" class="white">우편번호 찾기</button><br/>
		<input type="text" id="sample6_address" placeholder="주소" style="width:50%; margin-top: 1%;"readonly><br/>
		<input type="text" id="sample6_address2" placeholder="상세주소" style="width:70%; margin-top: 1%; margin-bottom:1%;"><br/>
		</td>
	</tr>
</table>
<table style="width:100%;">
	<tr>
		<th style="align:center;">
		<button type="button" id="btnSubmit" class="white">관리자 등록</button>&nbsp;
		<button type="button" class="white" onclick="location.href= '/theDeepAdmin.do'">취소</button>
		</th>
	</tr>
</table>
</form>