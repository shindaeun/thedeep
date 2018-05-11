<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div>
	<table class="board">
		<tr class="board">
			<th width="10%" class="head">NO</th>
			<th width="20%" class="head">쿠폰</th>
			<th width="40%" class="head">사용방법</th>
			<th width="20%" class="head">기한</th>
		</tr>
		<c:forEach var="result" items="${resultList }" varStatus="status">
			<tr class="board">
				<td>${status.count}</td>
				<td>${result.name}</td>
				<td>${result.rdate}</td>
				<td>${result.hit}</td>
			</tr>
		</c:forEach>
	</table>
</div>
<br>