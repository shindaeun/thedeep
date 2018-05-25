<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>

<link rel="stylesheet" type="text/css" href="/css/main.css"/>
<script src="/js/jquery-1.12.4.js"></script>
<script src="/js/jquery-ui.js"></script>


<script>
$(function() {
	$("#btnSubmit").click(function() {
		if($("#name").val() == "") {
			alert("이름을 입력해 주세요");
			$("#name").focus();
			return;
		}
		if($("#title option:selected").val()=="") {
			alert("제목을 선택해 주세요");
			return;
		}
		if($("#pwd").val().length<4
				||$("#pwd").val().length>12) {
			alert("암호는4~12자리 사이로 입력해 주세요");
			$("#pwd").focus();
			return;
		}
		
		if(confirm("저장하시겠습니까?")) {		
	 		//var formData = $("#frm").serialize();
	 		var form = new FormData(document.getElementById('frm'));
	 		// 비 동기 전송
			$.ajax({
				type: "POST",
				data: form,
				url: "/qnaWriteSave.do",
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
						location.href = "<c:url value='/qnaList.do'/>";
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
});
</script>

<table class="top">
	<tr class="top">
		<td class="top">Q&A</td>
	</tr>
</table>

<form id="frm" name="frm" method="post" enctype="multipart/form-data">
<table class="board">
	<tr class="board">
		<th class="head" width="20%">Name</th>
		<td style="text-align:left; padding:5px;" >
		 <input type="text" id="name" name="name" value="${name}"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">Password</th>
		<td style="text-align:left; padding:5px;">
		 <input type="password" id="pwd"  name="pwd" placeholder="암호 입력 (4~12자리)"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">Subject</th>
		<td style="text-align:left; padding:5px;">
		 <select name="title" id="title">
			<option value="">제목을 선택해 주세요</option>
		 	<option value="배송문의">배송문의</option>
		 	<option value="교환반품문의">교환/반품문의</option>
		 	<option value="상품문의">상품문의</option>
		 	<option value="기타문의">기타문의</option>
		 </select>
		</td>
	</tr>
	<tr class="board">
		<th class="head">Content</th>
		<td style="height:200px;">
		 <textarea id="content" name="content" rows="8" cols="102" style="resize: none;"></textarea>
		</td>
	</tr>
	<tr class="board">
        <th class="head">file</th>
        <td style="text-align:left; padding:5px" >
        	<input type="file" name="file1" size="70" /><br/>
        	<input type="file" name="file2" size="70" /><br/>
        	<input type="file" name="file3" size="70" />
        </td>
	</tr>
</table>
<table style="width:100%">
	<tr>
		<td style="text-align:center;">
		 <button type="button" id="btnSubmit" class="white">등록</button>
		 <button type="button" class="white" onclick="location.href='/qnaList.do'">취소</button>
		</td>
	</tr>
</table>
</form>