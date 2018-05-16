<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<table class="top">
	<tr class="top">
		<td class="top">point</td>
	</tr>
</table>
<div style="border: 1px dashed; padding: 10px;">
	<table width="100%">
		<tr align="center">
			<td >총 적립금 ${allpoint }원</td>
		</tr>
		<tr align="center">
			<td>사용 가능 적립금 ${ablepoint }원</td>
		</tr>
	</table>
</div>
<br><br><br>
<div>
	<table>
		<tr>
			<th>point list</th>
		</tr>
	</table>
	<table class="board">
		<tr class="board">
			<th width="20%" class="head">날짜</th>
			<th width="50%" class="head">내용</th>
			<th width="30%" class="head">적립금</th>
		</tr>
		<c:forEach var="i" items="${List }" varStatus="status">
			<tr class="board" align="center">
				<td>${i.odate}</td>
				<td>${i.pname}</td>
				<td>${i.point}원</td>
			</tr>
		</c:forEach>
	</table>
</div>
<br>