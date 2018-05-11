<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String gname = request.getParameter("gname");
%>
    <table class="top">
		<tr class="top">
			<td class="top"><%=gname%></td>
		</tr>
    </table>

    <table>
		<tr>
			<th>best item</th>
		</tr>
    </table>
    <table class="line">
    	<tr class="line">
    		<td class="line">
    		</td>
    	</tr>
    </table>

	<table class="board">
		<colgroup>
		<col width="33%"/>
		<col width="33%"/>
		<col width="33%"/>
	</colgroup>
		<tr class="board">
			<%-- <c:forEach var="best" items="${bestList}" varStatus="status"> --%>
			<c:forEach var="i" begin="1" end="3">
			<th>${best.mainfile}사진<br>${best.pname}상품명<br>${best.price}가격</th>
			</c:forEach>
		</tr>
	</table>


 	<table>
		<tr>
			<th><%=gname%></th>
		</tr>
    </table>
    <table class="line">
    	<tr class="line">
    		<td class="line">
    		</td>
    	</tr>
    </table>


	<table class="board">
		<colgroup>
		<col width="33%"/>
		<col width="33%"/>
		<col width="33%"/>
		</colgroup>
		<tr class="board">
			<c:set var="filenum" value="0"/>
			<%-- <c:forEach var="product" items="${productList}" varStatus="status"> --%>
			<c:forEach var="i" begin="1" end="15">
			<c:set var="filenum" value="${filenum+1}"/>
			<th>사진<br>상품명<br>가격</th>
			<c:if test="${filenum==3}">
				<c:set var="filenum" value="0"/>
				</tr>
				<tr class="board">
			</c:if>
			</c:forEach>
			
		</tr>
	</table>
	
<table border="0" width="100%">
	<tr>
		<td align="center" style="border:0px">
		<div id="paging">
		<%-- <c:forEach var="i" begin="1" end="${paginationInfo.getTotalPageCount()}"> --%>
		<c:forEach var="i" begin="1" end="5">
       	<a href="/productDetail.do?pageIndex=${i}&gname=<%=gname%>">${i}</a>
		</c:forEach>
       	</div>

		</td>
	</tr>
</table>
