<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
function fnSubmit() {
	if($.trim($("#userid").val()) == "" 
		|| $.trim($("#pwd").val()) == "") {
		alert("아이디나 패스워드를 확인해주세요.");
		return;
	}
	var form = new FormData(document.getElementById('frm'));
	$.ajax({
		type: "POST",
		data: form,
		url: "/login.do",
		dataType: "json",
		processData: false,
		contentType: false, 
		
		success: function(data) {
			if(data.result == "ok") {
				alert("로그인 되었습니다.");
				location.href="/uploadList.do";
			} else if(data.result == "-1") {
				alert("아이디와 패스워드가 일치하지 않습니다.");
			}
		},
		error: function(error) {
			alert("error : " + error);
		}
	});	
}
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
		<input type="text" id="id"/>
		</td>
	</tr>
	<tr class="login">
		<td>PASSWORD</td>
		<td align="center">
		<input type="password" id="pwd"/>
		</td>
	</tr>
</table>
</form>
<div width="100%" style="margin-left:340px; margin-top:10px;">
<button type="button" class="white" style="width:280px;">Login</button>
</div>
<table width="320px" style="margin-left:340px; margin-top:10px;">
	<tr>
		<td width="10%">join</td>
		<td width="30%"></td>
		<td width="15%">find id</td>
		<td width="5%">/</td>
		<td width="40%">find password</td>
	</tr>
</table>