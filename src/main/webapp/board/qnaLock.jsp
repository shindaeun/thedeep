<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
$(function() {
	   $("#btnSubmit").click(function() {
		   var formData = $("#frm").serialize();
		   var t = $("#t").val();
		   if(t=="답변드립니다") {
			   $.ajax({
					type: "POST",
					data: formData,
					url: "/qnaPwdChk.do",

					success: function(data) {
						if(data.result == "ok") {
							location.href = "/qnaReDetail.do";
							var form = document.frm;
							form.method = "post";
							form.action = "/qnaReDetail.do";
							form.submit();
						} else {
							alert("비밀번호가 일치하지 않습니다");
						}
					},
					error: function () {
						alert("오류발생 ");
					}
				});
		   } else {
			   $.ajax({
					type: "POST",
					data: formData,
					url: "/qnaPwdChk.do",

					success: function(data) {
						if(data.result == "ok") {
							location.href = "/qnaDetail.do";
							var form = document.frm;
							form.method = "post";
							form.action = "/qnaDetail.do";
							form.submit();
						} else {
							alert("비밀번호가 일치하지 않습니다");
						}
					},
					error: function () {
						alert("오류발생 ");
					}
				}); 
		   }
	   });
	   $("#btnCancel").click(function() {
		  location.href="/qnaList.do";
	   });
	});
</script>

<form id="frm" name="frm">
<input type="hidden" id="unq" name="unq" value="${unq}"/>
<input type="hidden" id="t" name="t" value="${t}"/>
<table style="width:100%; heigth:450px;">
	<tr style="text-align:center; height:450px;">
		<td><hr color="#555555" align="center" size="1" width="30%"/>
			<b>비밀번호 입력</b><br/>
			<hr color="#555555" align="center" size="1" width="30%"/>
			password &nbsp;<input type="password" id="pwd" name="pwd" style="border-style:none;" autofocus/>
			<hr color="#ffffff" align="center" size="1" width="30%"/>
			<button type="button" id="btnSubmit" class="white">확인</button>
			<button type="button" id="btnCancel" class="white">취소</button>
		</td>
	</tr>
</table>
</form>