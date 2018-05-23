<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
$(function(){
	$("#btnFind").click(function(){
		if($("#name").val() == "") {
			alert("이름을 입력해주세요");
			$("#name").focus();
			return;
		}
		if($("#email").val() == "") {
			alert("이메일을 입력해주세요");
			$("#email").focus();
			return;
		}
		var formData = $("#frm").serialize();
	 		// 비 동기 전송
			$.ajax({
				type: "POST",
				data: formData,
				url: "/findIdChk.do",

				success: function(data) {
					if(data.result == "ok") {
						location.href = "/findId2.do";
						var form = document.frm;
						form.method = "post";
						form.action = "/findId2.do";
						form.submit();
					} else {
						alert("일치하는 회원이 없습니다");
					}
				},
				error: function () {
					alert("오류발생 ");
				}
			}); 
		});
});
</script>

<table class="top">
	<tr class="top">
		<td class="top">아이디 찾기</td>
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
		<input type="text" name="name" id="name" style="border-style:none;" autofocus/>
		</td>
	</tr>
	<tr>
		<td>E-Mail</td>
		<td align="center">
		<input type="text" name="email" id="email" style="border-style:none;"/>
		</td>
	</tr>
</table>
</form>
<div width="100%" style="margin-left:340px; margin-top:10px;">
<button type="button" id="btnFind" class="white" style="width:260px;">Find</button>
</div>