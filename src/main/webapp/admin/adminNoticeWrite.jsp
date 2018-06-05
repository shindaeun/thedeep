<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	$(function(){
		$("#btnSubmit").click(function(){
			if($("#name").val() == "") {
				alert("이름을 입력해주세요.");
				$("#name").focus();
				return;
			}
			if($("#pwd").val().length < 4 || $("#pwd").val().length > 12 )
			{
				alert("암호는 4~12자리 사이로 입력해주세요.");
				$("#pwd").focus();
				return;
			}
			if($("#title").val() == "") {
				alert("제목을 입력해주세요.");
				$("#title").focus();
				return;
			}
			if($("#content").val() == "") {
				alert("내용을 입력해주세요.");
				$("#content").focus();
				return;
			}
			
			if(confirm("저장하시겠습니까?")) {		
		 		//var formData = $("#frm").serialize();
		 		var form = new FormData(document.getElementById('frm'));
		 		// 비 동기 전송
				$.ajax({
					type: "POST",
					data: form,
					url: "/adminNoticeWriteSave.do",
					dataType: "json",
					processData: false,
					contentType: false, 
					
					success: function(data) {
						if(data.result == "ok") {
							alert("저장하였습니다.\n\n("+data.cnt+")개의 파일 저장");
							if(data.errCode == "-1") {
								alert("첨부파일을 확인해주세요. 확장명 오류");
							} else if(data.errCode == "0") {
								alert("첨부파일 확인, 이미지 파일만 가능합니다.");
							} else if(data.errCode == "1") {
								alert("첨부파일은 5M 미만이어야 합니다.");
							}
							location.href="/adminNoticeList.do";
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
	$("#btnList").click(function(){
		location.href="/adminNoticeList.do";
	});
	
});
</script>
<table class="top">
		<tr class="top">
			<td class="top">notice</td>
		</tr>
    </table>

<form name="frm" id="frm" method="post" enctype="multipart/form-data">  
<table class="board">

	<tr class="board">
		<th class="head" width="20%">글쓴이</th>
		<td>
		<input type="text" name="name" id="name" style="width:98%;"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">암호</th>
		<td>
		<input type="password" name="pwd" id="pwd" style="width:98%;" placeholder="암호 입력 (4~12자리)"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">제목</th>
		<td>
		<input type="text" name="title" id="title" style="width:98%;"/>
		</td>
	</tr>
	
	<tr class="board">
		<th class="head">내용</th>
		<td style="height:150px;">
		<textarea name="content" id="content" style="width:98%;height:95%;"></textarea>
		</td>
	</tr>
	<tr class="board">
        <th class="head">파일</th>
        <td style="text-align:left">
        	<input type="file" name="file1" size="70" /><br/>
        	<input type="file" name="file2" size="70" /><br/>
        	<input type="file" name="file3" size="70" />
        </td>
	</tr>
</table>
</form>

<table border="0" style="width:100%;">
	<tr style="text-align:center">
		<th colspan="2" style="text-align:center">
		<button type="button" id="btnSubmit" class="white">등록</button>
		&nbsp;
		<button type="button" id="btnList" class="white">취소</button>
		</th>
	</tr>
</table>