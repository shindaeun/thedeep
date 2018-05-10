<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
	$(function() {
		$("#btnWrite").click(function() {
			location.href = "/noticeWrite.do";
		});
		$("#btnSearch").click(function() {
			location.href = "";
		});
	});
</script>
<form name="frm">
	<table>
		<tr>
			<td><select name="searchCondition">
					<option value="title">제목</option>
					<option value="content">내용</option>
			</select> <input type="text" name="searchKeyword" id="searchKeyword">
				<button type="button" id="btnSearch" class="white">검색</button></td>
			<td>
				<button type="button" class="white" id="btnWrite">WRITE</button>
			</td>
		</tr>
	</table>
</form>
<br>
<div>
	<table class="board">
		<tr class="board">
			<th width="10%" class="head">NO</th>
			<th width="40%" class="head">SUBJECT</th>
			<th width="20%" class="head">WRITER</th>
			<th width="20%" class="head">DATE</th>
			<th width="10%" class="head">HIT</th>
		</tr>
		<c:forEach var="result" items="${resultList }" varStatus="status">
			<tr class="board">
				<td>${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}</td>
				<td><a href="/boardModify.do?unq=${result.unq}">${result.title}</a></td>
				<td>${result.name}</td>
				<td>${result.rdate}</td>
				<td>${result.hit}</td>
			</tr>
		</c:forEach>
	</table>
</div>
<br>

