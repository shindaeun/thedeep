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
<title>우편번호조회</title>
<meta content="width=device-width, initial-scale=1" name="viewport">
<meta content="Webflow" name="generator">
<link href="/css/normalize.css" rel="stylesheet" type="text/css">
<link href="/css/webflow.css" rel="stylesheet" type="text/css">
<link href="/css/home.css" rel="stylesheet" type="text/css">
<link href="/css/product.css" rel="stylesheet" type="text/css">
<link href="/css/board.css" rel="stylesheet" type="text/css">
<script src="/js/jquery-1.12.4.js"></script>
<script src="js/jquery-ui.js"></script>
</head>
<style>
td {
	font-size: 9pt;
	width: 50%;
	height: 50%;
	text-align: center;
	vertical-align: bottom;
}
div{
	width: 500px;
	border-top:1px solid #000000;
	border-bottom: 1px solid #000000;
	text-align: center;
	font-size: 9pt;
	font-weight:bold;
	margin-top:10px;
	margin-bottom:10px;
	padding:5px;
}
</style>
<script>
$(function(){
	$("#btnPostAction").click(function(){ 
		var addr = $("#addr").val();
		addr = $.trim(addr);
		var post = addr.substring(0,6);
		var address = addr.substring(7);
		opener.document.frm.postnum.value = post;
		opener.document.frm.addr1.value = address;
		self.close();
	});
}); 
</script>
<body>
	<table class="top">
		<tr class="top">
			<td class="top">우편번호 찾기</td>
		</tr>
	</table>
	<form name="frm" method="post" action="/post1.do">
		<table style="width: 500px; height:20%; padding-bottom:10px;">
			<colgroup>
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<td align="center">읍/면/동을 입력해주세요.</td>
				</tr>
				<tr>
					<td height="100">
						<input type="text" name="dong" style="width: 70%;">
						<button type="submit">조회</button> <br>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	<div>검색결과</div>
	<table style="width:500px; height:50%; overflow: scroll;">
		<colgroup>
				<col width="*" />
		</colgroup>
		<tbody>
		<c:forEach var="i" items="${resultList}">
			<tr>
				<td style="width:20%;">${i.postnum}</td>
				<td style="width:60%;">${i.sido} ${i.gungu} ${i.dong} ${i.ri} ${i.bunji} ${i.other}</td>
				<td style="width:20%;">
				<button type="button" id="btnPostAction" class="white">적용</button>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>