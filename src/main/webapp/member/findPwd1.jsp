<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
$(function(){
	$("#btnFind").click(function(){
		if($("name").val()=="") {
			alert("이름을 입력해 주세요");
			$("name").focus();
			return;
		}
		if($("userid").val() == "") {
			alert("아이디를 입력해 주세요");
			$("userid").focus();
			return;
		}
		if($("email").val() == "") {
			alert("이메일을 입력해 주세요");
			$("email").focus();
			return;
		}
		
		var formData = $("#frm").serialize();
		$.ajax({
			type: "POST",
			data: formData,
			url: "/findPwdChk.do",
			
			success: function(data) {
				if(data.result == "ok") {
					location.href = "/findPwd2.do";
					var form = document.frm;
					form.method = "post";
					form.action = "/findPwd2.do";
					form.submit();
				} else {
					alert("일치하는 회원이 없습니다.");
					return;
				}
			},
			error: function(error) {
				alert("오류발생");
			}
		});	
	});
});
</script>

<table class="top">
	<tr class="top">
		<td class="top">비밀번호 찾기</td>
	</tr>
</table>

<form id="frm" name="frm">
<table width="30%" style="margin-left:340px; margin-top:70px;">
	<colgroup>
		<col width="15%" />
		<col width="35%" />
		<col width="15%" />
		<col width="35%" />
	</colgroup>
	<tr>
		<td>NAME</td>
		<td  align="center">
		<input type="text" id="name" name="name" style="border-style:none;" autofocus/>
		</td>
	</tr>
	<tr>
		<td>ID</td>
		<td align="center">
		<input type="text" id="userid" name="userid" style="border-style:none;"/>
		</td>
	</tr>
	<tr>
		<td>E-Mail</td>
		<td align="center">
		<input type="text" id="email" name="email" style="border-style:none;"/>
		</td>
	</tr>
</table>
</form>
<div width="100%" style="margin-left:340px; margin-top:10px;">
<button type="button" id="btnFind" class="white" style="width:260px;">Find</button>
</div>