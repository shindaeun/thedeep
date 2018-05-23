<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
					location.href="/home.do";
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
a:link { text-decoration: none; color: #000000} 
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
<table style="width:320px; margin-left:340px; margin-top:10px; vlink:black;">
	<tr>
		<td width="10%"><a href="/adminInfo.do">join</a></td>
		<td width="30%"></td>
		<td width="15%"><a href="/AdminfindId1.do">find id</a></td>
		<td width="5%">/</td>
		<td width="40%"><a href="/AdminfindPwd1.do">find password</a></td>
	</tr>
</table>