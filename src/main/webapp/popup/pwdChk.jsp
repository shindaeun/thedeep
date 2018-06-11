<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>비밀번호 확인</title>
<meta content="width=device-width, initial-scale=1" name="viewport">
<meta content="Webflow" name="generator">
<link href="/css/normalize.css" rel="stylesheet" type="text/css">
<link href="/css/webflow.css" rel="stylesheet" type="text/css">
<link href="/css/home.css" rel="stylesheet" type="text/css">
<link href="/css/product.css" rel="stylesheet" type="text/css">
<link href="/css/board.css" rel="stylesheet" type="text/css">
<script src="/js/jquery-1.12.4.js"></script>
<script src="js/jquery-ui.js"></script>
<script>
$(function(){
	$("#btnPwdAction").click(function(){ 
		var formData = $("#frm").serialize();
 		// 비 동기 전송
		$.ajax({
			type: "POST",
			data: formData,
			url: "/pwdChkSave.do",

			success: function(data) {
				if(data.result == "ok") {
					alert("기존 비밀번호와 일치합니다.");
					var check = "1";
					var npwd = $("#npwd").val();
					npwd = $.trim(npwd);
					opener.document.frm.check.value = check;
					opener.document.frm.opwd.value = npwd;
			 		//var formData = $("#frm").serialize();
			 		var formData = $("#frmp").serialize();
			 		// 비 동기 전송
					$.ajax({
						type: "POST",
						data: formData,
						url: "/memberModifySave.do",

						success: function(data) {
							if(data.result == "ok") {
								alert("저장하였습니다.");
								self.close();
								opener.location.href = "/myPage.do";
							} else {
								alert("저장 실패했습니다. 다시 시도해 주세요.");
							}
						},
						error: function () {
							alert("오류발생 ");
						}
					}); 

				} else {
					alert("기존 비밀번호와 일치하지 않습니다. 다시 시도해 주세요.");
					return;
				}
			},
			error: function () {
				alert("오류발생 ");
			}
		}); 
 		
	});
	$("#btnClose").click(function() {
		self.close();
	});
}); 
function processKey() {
	if((event.ctrlKey == true && (event.keyCode==78 || event.keyCode==82)) || 
			(event.keyCode>=112 && event.keyCode<=123) || event.keyCode ==8) {
		event.keyCode=0;
		event.cancelBubble = true;
		event.returnValue = false;
	}
}
document.onkeydown = processKey;
</script>
</head>
<body>

<table class="top">
	<tr class="top">
		<td class="top">비밀번호 확인</td>
	</tr>
</table>
<form name="frmp" id="frmp">
<input type="hidden" name="userid" id="userid" value="${vo.userid}">
<input type="hidden" name="pwd" id="pwd" value="${vo.pwd}">
<input type="hidden" name="gender" id="gender" value="${vo.gender}">
<input type="hidden" name="post" id="post" value="${vo.post}">
<input type="hidden" name="phone" id="phone" value="${vo.phone}">
<input type="hidden" name="email" id="email" value="${vo.email}">
<input type="hidden" name="emailreceive" id="emailreceive" value="${vo.emailreceive}">
<input type="hidden" name="phonereceive" id="phonereceive" value="${vo.phonereceive}">
</form>
<form name="frm" id="frm">
<input type="hidden" name="userid" id="userid" value="${vo.userid}">
<input type="hidden" name="npwd" id="npwd" value="${vo.pwd}">
	<table style="width: 500px; height:20%; margin-top:50px;">
		<colgroup>
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<td align="center">현재 비밀번호를 입력해 주세요.</td>
			</tr>
			<tr>
				<td height="100" align="center">
					<input type="password" name="pwd" id="pwd" style="width: 70%;">
				</td>
			</tr>
		</tbody>
	</table>
</form>
<div style="text-align:center; width:500px;">
<button type="button" class="white" id="btnPwdAction">적용</button>&nbsp;
<button type="button" class="white" id="btnClose" >취소</button>
</div>
</body>
</html>