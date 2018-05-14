<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- 달력 활성화가 안 됨 -->
 <script>
 $( function() {
   $( "#birthday" ).datepicker({
     showOn: "button",
     buttonImage: "images/calendar.gif",
     buttonImageOnly: true,
     buttonText: "Select date"
   });
 } );
 </script>

<script>
$(function(){
	$("#btnPostSearch").click(function(){ 
		var url = "/post1.do";
		window.open(url,"주소찾기","width=500,height=400");
	});
	
	$("#btnSubmit").click(function(){
		if(    $("#pwd").val().length < 4 
			|| $("#pwd").val().length > 12 )
		{
			alert("암호는 4~12자리 사이로 입력해주세요");
			$("#pwd").focus();
			return;
		}
		if($("#pwd").val()!=$("#pwd").val()) {
			alert("암호가 일치하지 않습니다");
			return;
		}
		if(confirm("저장하시겠습니까?")) {		
	 		//var formData = $("#frm").serialize();
	 		var phone  = $("#phone1").val();
	 			phone += "-" +  $("#phone2").val(); 
	 			phone += "-" +  $("#phone3").val();
	 		$("#phone").val(phone);
	 		
	 		var address  = $("#postnum").val();
	 		    address += " " + $("#addr1").val();
	 		    address += " " + $("#addr2").val();
	 		$("#address").val(address);
	 		
	 		var email  = $("#email1").val();
	 			email += "@" + $("#email2").val();
	 		$("#email").val(email);
	 			
	 		var form = new FormData(document.getElementById('frm'));
	 		// 비 동기 전송
			$.ajax({
				type: "POST",
				data: form,
				url: "/memberModifySave.do",
				dataType: "json",
				processData: false,
				contentType: false, 
				
				success: function(data) {
					if(data.result == "ok") {
						alert("저장하였습니다.");
						location.href = "/home.do";
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
		<td class="top">PROFILE</td>
	</tr>
</table>


<form name="frm" id="frm">

<input type="hidden" name="phone" id="phone">
<input type="hidden" name="address" id="address">
<input type="hidden" name="userid" id="userid">
<input type="hidden" name="pwd" id="pwd">
<input type="hidden" name="name" id="name">

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
		${vo.id}
		</td>
	</tr>
	<tr class="board">
		<th class="head">이메일</th>
		<td align="left" style="padding:5px;">
		<input type="text" name="email1" id="email1" style="width:20%;" value="${vo.email}"/>
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
		<input type="text" name="birthday" id="birthday" style="width:20%" value="${vo.birthday}"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">성별</th>
		<td align="left" style="padding:5px;">
		<input type="radio" name="gender" id="gender" value="1" <c:if test="${vo.gender==1}">checked</c:if>/>WOMAN
		<input type="radio" name="gender" id="gender" value="2"<c:if test="${vo.gender==2}">checked</c:if>/>MAN
		</td>
	</tr>
	<tr class="board">
		<th class="head">연락처</th>
		<td align="left" style="padding:5px;">
		<select name="phone1" id="phone1">
				<option value="010" <c:if test="${vo.gender==010}">selected</c:if>>010</option>
				<option value="011" <c:if test="${vo.gender==011}">selected</c:if>>011</option>
		</select> -
		<input type="text" name="phone2" id="phone2" maxlength="4" style="width:10%; IME-MODE: disabled;"/> -
		<input type="text" name="phone3" id="phone3" maxlength="4" style="width:10%; IME-MODE: disabled;"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">주소</th>
		<td style="text-align: left; padding:5px;">
		<input type="text" name="postnum" id="postnum" style="width:30%; margin-top: 1%;"/>
		<button type="button" id="btnPostSearch" class="white">우편번호찾기</button><br/>
		<input type="text" name="addr1" id="addr1" style="width:50%; margin-top: 1%;"/><br/>
		<input type="text" name="addr2" id="addr2" style="width:70%; margin-top: 1%; margin-bottom:1%;" placeholder="상세주소 입력"/><br/>
		</td>
	</tr>
</table>
<table style="width:100%;">
	<tr>
		<th style="align:center;">
		<button type="button" id="btnSubmit" class="white">수정</button>&nbsp;
		<button type="button" class="white" onclick="location.href= '/home.do'">취소</button>
		</th>
	</tr>
</table>
</form>