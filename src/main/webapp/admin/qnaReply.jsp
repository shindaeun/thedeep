<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
	$(function() {
		$("#btnSave").click(function() {
			location.href = "/noticeList.do";
		});
		$("#btnModify").click(function() {
			location.href = "";
		});
	});
</script>
<table class="board">
	<tr class="board">
		<th class="head" width="20%">이름</th>
		<td><input type="text"></td>
	</tr>
	<tr class="board">
		<th class="head">암호</th>
		<td><input type="password"></td>
	</tr>
	<tr class="board">
		<th class="head">내용</th>
		<td><textarea rows="8" cols="100" style="resize: none;"></textarea>
		</td>
	</tr>
</table>

<table width="100%">
	<tr>
		<th>
			<button type="button" id="btnSave" class="white">등록</button> &nbsp;
			<button type="button" id="btnModify" class="white">취소</button>
		</th>
	</tr>
</table>