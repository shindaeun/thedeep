<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>
<%
String unq = request.getParameter("unq");
%>
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
		$("#btnSubmit").click(function(){
		 		var form = new FormData(document.getElementById('frm'));
		 		// 비 동기 전송
				$.ajax({
					type: "POST",
					data: form,
					url: "/noticePwdCheck2.do",
					dataType: "json",
					processData: false,
					contentType: false, 
					
					success: function(data) {
						if(data.result == "1") {
							opener.location.href="/adminNoticeModify.do?unq=<%=unq%>";
							window.close();
						} else {
							alert("비밀번호가 일치하지 않습니다. 다시 시도해 주세요.");
						}
					},
					error: function () {
						alert("오류발생 ");
					}
				}); 
		});
	$("#btnCancle").click(function(){
		self.close();
	});
	
});
</script>
</head>
<body>

<table class="top">
	<tr class="top">
		<td class="top">비밀번호 확인</td>
	</tr>
</table>
<form name="frm" id="frm">
<input type="hidden" name="unq" id="unq" value="<%=unq%>"/>
	<table style="width: 500px; height:20%; margin-top:50px;">
		<colgroup>
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<td align="center">비밀번호를 입력해 주세요.</td>
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
<button type="submit" id="btnSubmit" class="white">확인</button>&nbsp;
<button type="button" id="btnCancle" class="white">취소</button>
</div>
</body>
</html>

