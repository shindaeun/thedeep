<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<table class="top">
		<tr class="top">
			<td class="top">coupon</td>
		</tr>
    </table>
<div>
	<table class="board">
		<tr class="board">
			<th width="10%" >NO</th>
			<th width="20%" >쿠폰</th>
			<th width="40%" >사용방법</th>
			<th width="20%" >기한</th>
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