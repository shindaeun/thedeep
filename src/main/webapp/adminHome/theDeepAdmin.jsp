<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${sessionScope.ThedeepALoginCert.ThedeepAUserId == null}">
<script>
$(function(){
	$("#btnLogin").click(function(){
		if($("#adminid").val() == "") {
			alert("아이디를 입력해주세요.");
			$("#adminid").focus();
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
			url: "/adminLoginCert.do",
			
			success: function(data) {
				if(data.result == "ok") {
					alert("로그인 되었습니다.");
					location.href="/theDeepAdmin.do";
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
a:link { text-decoration: none; color: #000000;text-align:center } 
a:visited { text-decoration: none; color: #000000} 
a:active { text-decoration: none; color: #000000}
a:hover {text-decoration:underline; color: #000000}

</style>

<div class="a">admin login</div>
<form id="frm" name="frm">
<table style="width:30%; margin-left:340px; margin-top:30px;">
	<colgroup>
		<col width="15%" />
		<col width="35%" />
		<col width="15%" />
		<col width="35%" />
	</colgroup>
	<tr class="login">
		<td>ID</td>
		<td  align="center">
		<input type="text" name="adminid" id="adminid" style="border-style:none;" autofocus/>
		</td>
	</tr>
	<tr class="login">
		<td>PASSWORD</td>
		<td align="center">
		<input type="password" name="pwd" id="pwd" style="border-style:none;"/>
		</td>
	</tr>
</table>
</form>
<div style="width:100%; margin-left:340px; margin-top:10px;">
<button type="button" class="white" style="width:280px;" id="btnLogin">Login</button>
</div>
<table style="border:0px; height:80px; width:100%;">
</table>
</c:if>
<c:if test="${sessionScope.ThedeepALoginCert.ThedeepAUserId != null}">
	<table border="3">
		<tr>
			<th>TOTAL&nbsp;&nbsp;:&nbsp;${total}명</th>
		</tr>
		
		<tr>
			<th>TODAY&nbsp;:&nbsp;${today}명</th>
		</tr>
	</table>
	
	<table>
		<c:forEach var="i" items="${visitorlist}">
		<tr height= "40px" width="100%">
			<td>${i.rdate}</td><td><span style="width: ${i.hit/10.0}px; height: 20px; background: #E03968; float: left;"></span>${i.hit}</td>
		</tr>
		</c:forEach>
		
	</table>
</c:if>

