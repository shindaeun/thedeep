<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<table class="top">
		<tr class="top">
			<td class="top">order list</td>
		</tr>
</table>

<c:set var="total" value="1"/>
<table class="board">
	<tr class="board" style="height:30px;">
	 	<th>ORDER CODE</th>
	 	<th>ITEM</th>
	 	<th>DATE</th>
	</tr>
	<c:forEach var="list" items="${list}" varStatus="status">
		<tr class="board" style="height:30px; text-align:center;">
			<td>${list.ocode}</td>
			<td>${list.pname}</td>
			<td>${list.odate}</td>
		</tr>
	</c:forEach>
</table>
