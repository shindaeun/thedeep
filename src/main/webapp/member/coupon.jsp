<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		<c:forEach var="i" items="${List }" varStatus="status">
			<tr class="board" align="center">
				<td>${status.count}</td>
				<td>${i.coupon}</td>
				<td>${i.subject1}<br>${i.subject2}</td>
				<td>${i.usedate}</td>
			</tr>
		</c:forEach>
	</table>
</div>
<br>