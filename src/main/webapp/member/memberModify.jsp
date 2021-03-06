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
		
		var idck = /(^[a-zA-Z0-9]*$)/;
		var id = $("#userid").val();
		
		if(!idck.test(id)) {
			alert("아이디에는 숫자 혹은 영어만 올 수 있습니다.");
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
		
		var pwdck = /(^[a-zA-Z0-9]*$)/;
		var pwd = $("#pwd").val();
		
		if(!pwdck.test(pwd)) {
			alert("암호는 숫자 혹은 영어만 올 수 있습니다.");
			$("#pwd").focus();
			return;
		}
		
		if($("#pwd").val() != $("#pwd2").val()) {
			alert("암호가 일치하지 않습니다");
			$("#npwd").focus();
			return;
		}
		
		if($('input:radio[id=gender]:checked').val()==undefined) {
			alert("성별을 입력해주세요.");
			$("#gender").focus();
			return;
		}
		
		if($("#email1").val() == "") {
			alert("이메일을 입력해주세요.");
			$("#email1").focus();
			return;
		}
		if($("#phone2").val() == "" || $("#phone3").val() == "") {
			alert("연락처를 입력해주세요.");
			$("#phone2").focus();
			return;
		}
		if($("#sample6_postcode").val() == "") {
			alert("우편번호를 입력해주세요");
			$("#sample6_postcode").focus();
			return;
		}
		if($("#sample6_address2").val() == "") {
			alert("상세주소를 입력해주세요");
			$("#sample6_address2").focus();
			return;
		}
		
		var hangle = /(^[a-zA-Z0-9가-힣 ]*$)/;
		var sang = $("#sample6_address2").val();
		
		if(!hangle.test(sang)) {
			alert("상세주소에는 특수문자가 올 수 없습니다.");
			$("#sample6_address2").focus();
			return;
		}
		
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
		
		if($("#pwd").val() != $("#opwd").val()) {

			var f = document.frm;
			window.open("","pwd check","width=500,height=400");
			f.target = "pwd check";
			f.method = "post";
			f.action = "/pwdChk.do";
			f.submit();
			return;
		}
		
		if(confirm("저장하시겠습니까?")) {		
	 		//var formData = $("#frm").serialize();
	 		var formData = $("#frm").serialize();
	 		// 비 동기 전송
	 		$.ajax({
				type: "POST",
				data: formData,
				url: "/memberModifySave.do",

				success: function(data) {
					if(data.result == "ok") {
						alert("저장하였습니다.");
						location.href = "/myPage.do";
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
	$("#btnOut").click(function(){
		
		if($("#pwd").val()=="" || $("#pwd2").val()=="") {
			alert("비밀번호를 입력해 주세요.");
			return;
		}
		
		if($("#pwd").val() != $("#pwd2").val()) {
			alert("암호가 일치하지 않습니다");
			$("#npwd").focus();
			return;
		}
		
		if($("#pwd").val() != $("#opwd").val()) {
			alert("비밀번호가 맞지 않습니다.");
			return;
		}
		
		if(confirm("정말 탈퇴하시겠습니까?")) {		
	 		//var formData = $("#frm").serialize();
	 		var formData = $("#frm").serialize();
	 		// 비 동기 전송
			$.ajax({
				type: "POST",
				data: formData,
				url: "/memberDstate.do",

				success: function(data) {
					if(data.result == "ok") {
						$.ajax({
							type: "POST",
							data: formData,
							url: "/memberDelete.do",

							success: function(data) {
								if(data.result == "ok") {
									alert("탈퇴되셨습니다. 그동안 이용해 주셔서 감사합니다. ^^*");
									$.ajax({
										type:'POST',
										data:'',
										url:"/logout.do",
										dataType:"json",
										success:function(data) {
											location.href="/theDeep.do";
										},
										error:function(error) {
											alert("error:"+error);
										}
									});
								} else {
									alert("탈퇴에 실패했습니다. QNA에 문의해 주시기 바랍니다.");
								}
							},
							error: function () {
								alert("오류발생 ");
							}
						}); 
					} else if(data.result == '1'){
						if(confirm("입금 전인 상품이 있습니다. 취소하시고 탈퇴하시겠습니까?")) {
							$.ajax({
								type: "POST",
								data: formData,
								url: "/memberDelete.do",

								success: function(data) {
									if(data.result == "ok") {
										alert("탈퇴되셨습니다. 그동안 이용해 주셔서 감사합니다. ^^*");
										$.ajax({
											type:'POST',
											data:'',
											url:"/logout.do",
											dataType:"json",
											success:function(data) {
												location.href="/theDeep.do";
											},
											error:function(error) {
												alert("error:"+error);
											}
										});
									} else {
										alert("탈퇴에 실패했습니다. QNA에 문의해 주시기 바랍니다.");
									}
								},
								error: function () {
									alert("오류발생 ");
								}
							});
						}
					} else {
						alert("배송 진행 중인 상품이 있어 탈퇴하실 수 없습니다. QNA에 문의해 주시기 바랍니다.");
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

<c:set var="phone" value="${vo.phone}"/>
<c:set var="post" value="${vo.post}"/>
<c:set var="email" value="${vo.email}"/>

<%
String ph = (String)pageContext.getAttribute("phone");
String[] phone = ph.split("-");
pageContext.setAttribute("phone1", phone[0]);
pageContext.setAttribute("phone2", phone[1]);
pageContext.setAttribute("phone3", phone[2]);

String po = (String)pageContext.getAttribute("post");
String[] post = po.split("/");
pageContext.setAttribute("postnum", post[0]);
pageContext.setAttribute("arr1", post[1]);
pageContext.setAttribute("arr2", post[2]);

String em = (String)pageContext.getAttribute("email");
String[] email = em.split("@");
pageContext.setAttribute("email1", email[0]);
pageContext.setAttribute("email2", email[1]);
%>

<table class="top">
	<tr class="top">
		<td class="top">profile</td>
	</tr>
</table>

<form name="frm" id="frm">

<input type="hidden" name="userid" id="userid" value="${vo.userid}"/>
<input type="hidden" name="opwd" id="opwd" value="${vo.pwd}"/>
<input type="hidden" name="phone" id="phone"/>
<input type="hidden" name="post" id="post"/>
<input type="hidden" name="email" id="email"/>
<input type="hidden" name="check" id="check" value="0"/>

<table class="board">
	<tr class="board">
		<th class="head" width="20%">이름</th>
		<td align="left" style="padding:5px;">
		${vo.name}
		</td>
	</tr>
	<tr class="board">
		<th class="head">ID</th>
		<td align="left" style="padding:5px;">
		${vo.userid}
		</td>
	</tr>
	<tr class="board">
		<th class="head">비밀번호</th>
		<td align="left" style="padding:5px;">
		<input type="password" name="pwd" id="pwd" style="width:25%;" placeholder="비밀번호 입력 (4~12자리)"/>
		  ** 비밀번호 변경 시 변경할 비밀번호를 입력해 주세요**
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
		<input type="text" name="email1" id="email1" style="width:20%;" value="${email1}"/>
		@
		<select name="email2" id="email2">
			<option value="naver.com" <c:if test="${email2=='naver.com'}">selected</c:if>>naver.com</option>
			<option value="daum.net" <c:if test="${email2=='daum.net'}">selected</c:if>>daum.com</option>
			<option value="gmail.com" <c:if test="${email2=='gmail.com'}">selected</c:if>>gmail.com</option>
		</select>
		</td>
	</tr>
	<tr class="board">
		<th class="head">생일</th>
		<td align="left" style="padding:5px;">
			${vo.birthday}
		</td>
	</tr>
	<tr class="board">
		<th class="head">성별</th>
		<td align="left" style="padding:5px;">
		<input type="radio" name="gender" id="gender" value="W" <c:if test="${vo.gender=='W'}">checked</c:if>/>WOMAN
		<input type="radio" name="gender" id="gender" value="M" <c:if test="${vo.gender=='M'}">checked</c:if>/>MAN
		</td>
	</tr>
	<tr class="board">
		<th class="head">연락처</th>
		<td align="left" style="padding:5px;">
		<select name="phone1" id="phone1">
				<option value="010"<c:if test="${phone1==010}">selected</c:if>>010</option>
				<option value="011"<c:if test="${phone1==011}">selected</c:if>>011</option>
		</select> -
		<input type="text" name="phone2" id="phone2" maxlength="4" style="width:10%; IME-MODE: disabled;" value="${phone2}"/> -
		<input type="text" name="phone3" id="phone3" maxlength="4" style="width:10%; IME-MODE: disabled;" value="${phone3}"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">주소</th>
		<td style="text-align: left; padding:5px;">
		<input type="text" id="sample6_postcode" placeholder="우편번호" style="width:30%; margin-top: 1%;" value="${postnum}"readonly/>
		<button type="button" onclick="sample6_execDaumPostcode()" class="white">우편번호 찾기</button><br/>
		<input type="text" id="sample6_address" placeholder="주소" style="width:50%; margin-top: 1%;" value="${arr1}"readonly/><br/>
		<input type="text" id="sample6_address2" placeholder="상세주소" style="width:70%; margin-top: 1%; margin-bottom:1%;" value="${arr2}"/><br/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">이메일 수신</th>
		<td>
		<input type="radio" name="emailreceive" id="emailreceive" value="y" <c:if test="${vo.emailreceive=='y'}">checked</c:if>/>받습니다
		<input type="radio" name="emailreceive" id="emailreceive" value="n" <c:if test="${vo.emailreceive=='n'}">checked</c:if>/>받지 않습니다
		</td>
	</tr>
	<tr class="board">
		<th class="head">문자 수신</th>
		<td>
		<input type="radio" name="phonereceive" id="phonereceive" value="y" <c:if test="${vo.phonereceive=='y'}">checked</c:if>/>받습니다
		<input type="radio" name="phonereceive" id="phonereceive" value="n" <c:if test="${vo.phonereceive=='n'}">checked</c:if>/>받지 않습니다
		</td>
	</tr>
</table>
<table style="width:100%;">
	<tr>
		<th style="text-align:right; width:55%;">
		<button type="button" id="btnSubmit" class="white">수정</button>&nbsp;
		<button type="button" class="white" onclick="location.href= '/myPage.do'">취소</button>
		</th>
		<th style="text-align:right;">
		<button type="button" id="btnOut" class="white">탈퇴</button>&nbsp;
		</th>
	</tr>
</table>
</form>

