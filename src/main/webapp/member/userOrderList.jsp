<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
$(window).load(function () {
    $(".gubun").each(function () {
        var rows = $(".gubun:contains('" + $(this).text() + "')");
        if (rows.length > 1) {
          rows.eq(0).attr("rowspan", rows.length);
          rows.not(":eq(0)").remove();
        }
    });
});
</script>

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
			<td class="gubun">${list.ocode}</td>
			<td>${list.pname}</td>
			<td>${list.odate}</td>
		</tr>
	</c:forEach>
</table>
