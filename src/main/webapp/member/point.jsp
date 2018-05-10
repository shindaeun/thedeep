<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div style="border: 1px dashed; padding: 10px;">
	<table>
		<tr>
			<td align="center">총 적립금 100원</td>
		</tr>
		<tr>
			<td align="center">사용 가능 적립금 0원</td>
		</tr>
	</table>
</div>
<br><br><br>
<div>
	<h4>적립금</h4>
	<table class="board">
		<tr class="board">
			<th width="20%" class="head">날짜</th>
			<th width="50%" class="head">내용</th>
			<th width="30%" class="head">적립금</th>
		</tr>
		<c:forEach var="result" items="${resultList }" varStatus="status">
			<tr class="board">
				<td>${status.count}</td>
				<td>${result.name}</td>
				<td>${result.rdate}</td>
			</tr>
		</c:forEach>
	</table>
</div>
<br>