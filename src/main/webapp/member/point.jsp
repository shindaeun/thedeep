<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String pageIndex = request.getParameter("pageIndex");
	if (pageIndex == null)
		pageIndex = "1";
	if (Integer.parseInt(pageIndex) < 0)
		pageIndex = "1";
%>
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
				<td>${i.rdate}</td>
				<td>${i.content}</td>
				<td><fmt:formatNumber value="${i.point}" type="number"/>원</td>
			</tr>
		</c:forEach>
	</table>
</div>
<c:set var="pageIndex" value="<%=pageIndex%>" />
<c:set var="totalPage" value="${paginationInfo.getTotalPageCount() }" />
<table border="0" width="100%">
	<tr>
		<td style="border: 0px; text-align: center">
			<div id="paging">
				<c:set var="a" value="${(pageIndex-1)/5-((pageIndex-1)/5%1)}" />
				<fmt:parseNumber var="a" integerOnly="true" value="${a}" />
				<c:set var="start" value="${a*5+1}" />
				<c:set var="last" value="${start+4}" />

				<c:if test="${last>paginationInfo.getTotalPageCount() }">
					<c:set var="last" value="${paginationInfo.getTotalPageCount() }" />
				</c:if>

				<fmt:parseNumber var="start2" integerOnly="true" value="${start-1}" />
				<c:if test="${start2 >0}">
					<a href="/point.do?pageIndex=${start2}">before</a>
				</c:if>

				<c:forEach var="i" begin="${ start}" end="${last }">
					<c:if test="${i ==pageIndex}">
						<span style="font-size: 13px; color: #E03968;">${i }</span>
					</c:if>
					<c:if test="${i !=pageIndex}">
						<a href="/point.do?pageIndex=${i}">${i}</a>
					</c:if>
				</c:forEach>

				<fmt:parseNumber var="last2" integerOnly="true" value="${last+1}" />
				<c:if test="${last2 <=paginationInfo.getTotalPageCount()}">
					<a href="/point.do?pageIndex=${last2}">next</a>
				</c:if>
			</div>
		</td>
	</tr>
</table>
<br>