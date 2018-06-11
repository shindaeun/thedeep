<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script>
$(function(){
	$("#btnLogin").click(function(){
		if($("#userid").val() == "") {
			alert("아이디를 입력해주세요.");
			$("#userid").focus();
			return;
		}
		if($("#pwd").val() == "") {
			alert("비밀번호를 입력해주세요.");
			$("#pwd").focus();
			return;
		}
		var formData = $("#frm").serialize();
		$.ajax({
			type: "POST",
			data: formData,
			url: "/loginCert.do",
			
			success: function(data) {
				if(data.result == "ok") {
					alert("로그인 되었습니다.");
					location.href="/theDeep.do";
				} else if(data.result == "-1") {
					alert("아이디와 패스워드가 일치하지 않습니다.");
				}
			},
			error: function(error) {
				alert("error : " + error);
			}
		});	
	});
});
</script>

<style>
div.a {
	font-size:13pt;
	font-weight: bold;
	color: #646464;	
	text-align: center;
	margin-top: 100px;
}
tr.login {
	border-bottom: 2px solid #808080;
	margin-top: 5px;
}
a:link { text-decoration: none; color: #000000 ;text-align:center} 
a:visited { text-decoration: none; color: #000000} 
a:active { text-decoration: none; color: #000000}
a:hover {text-decoration:underline; color: #000000}

</style>

<div class="a">login</div>
<form id="frm" name="frm">
<table width="30%" style="margin-left:340px; margin-top:30px;">
	<colgroup>
		<col width="15%" />
		<col width="35%" />
		<col width="15%" />
		<col width="35%" />
	</colgroup>
	
	<tr class="login">
		<td>ID</td>
		<td  align="center">
		<input type="text" name="userid" id="userid" style="border-style:none; ime-mode:inactive;" 
			<c:if test="${useridIn!=null}">value="${useridIn}"</c:if>
			<c:if test="${useridIn==null}">autofocus</c:if> />
		</td>
	</tr>
	<tr class="login">
		<td>PASSWORD</td>
		<td align="center">
		<input type="password" name="pwd" id="pwd" style="border-style:none;  ime-mode:inactive;" 
			<c:if test="${useridIn!=null}">autofocus</c:if>/>
		</td>
	</tr>
</table>
</form>
<div width="100%" style="margin-left:340px; margin-top:10px;">
<button type="button" class="white" style="width:280px;" id="btnLogin">Login</button>
</div>
<table width="320px" style="margin-left:340px; margin-top:10px; vlink:black;">
	<tr>
		<td width="10%"><a href="/memberInfo.do">join</a></td>
		<td width="30%"></td>
		<td width="15%"><a href="/findId1.do">find id</a></td>
		<td width="5%">/</td>
		<td width="40%"><a href="/findPwd1.do">find password</a></td>
	</tr>
</table>
