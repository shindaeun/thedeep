<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
	$(function() {
		$("#btnSave").click(function() {
			if(    $("#pwd").val().length < 4 
				|| $("#pwd").val().length > 12 )
			{
				alert("암호는 4~12자리 사이로 입력해주세요");
				$("#pwd").focus();
				return;
			}
			if($("#content").val() == "") {
				alert("내용을 입력해 주세요");
				$("#content").focus();
				return;
			}
			if(confirm("저장하시겠습니까?")) {		
		 		var formData = $("#frm").serialize();
		 		// 비 동기 전송
				$.ajax({
					type: "POST",
					data: formData,
					url: "/qnaReplySave.do",

					success: function(data) {
						if(data.result == "ok") {
							alert("저장하였습니다.");
							location.href = "/adminBoard.do";
						} else {
							alert("저장 실패했습니다. 다시 시도해 주세요.");
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
<input type="hidden" id="unq" name="unq" value="${unq}">
<table class="top">
		<tr class="top">
			<td class="top">qna reply</td>
		</tr>
    </table>
<table class="board">
	<tr class="board">
		<th class="head" width="20%">name</th>
		<td>관리자</td>
	</tr>
	<tr class="board">
		<th class="head">passwd</th>
		<td><input type="password" id="pwd" name="pwd" value="${pwd}"/></td>
	</tr>
	<tr class="board">
		<th class="head">content</th>
		<td><textarea rows="8" cols="100" style="resize: none;" id="content" name="content"></textarea>
		</td>
	</tr>
</table>
</form>

<table width="100%">
	<tr>
		<th>
			<button type="button" id="btnSave" class="white">등록</button> &nbsp;
			<button type="button" id="btnCancel" class="white">취소</button>
		</th>
	</tr>
</table>