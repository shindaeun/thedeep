<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
$(function() {
	$("#btnWrite").click(function() {
		location.href = "/orderList.do";
	});
});
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
      <td class="top">주문상세조회</td>
   </tr>
</table>
<form name="frm">
	<table>
		<button type="button" class="white" id="btnWrite">목록</button>
	</table>
</form>
<table class="board" id="order">
	<tr class="board">
		<th width="10%" >주문번호</th>
		<th width="10%" >구매자</th>
		<th width="10%" >상품코드</th>
		<th width="15%" >품목코드</th>
		<th width="15%" >상품명</th>
		<th width="10%" >구매개수</th>
		<th width="10%" >주문일자</th>
		<th width="10%" >배송 상태</th>
		<th width="10%" >운송장번호</th>
	</tr>
	<%-- <c:forEach var="result" items="${resultList }" varStatus="status"> --%>
	<c:forEach var="result" begin="1" end="3">
		<tr class="board">
			
			<td class="gubun">ODR00010</td>
			<td class="gubun">홍길동</td>
			<td class="gubun">P00006</td>
			<td>P00006asd</td>
			<td>도깨비</td>
			<td>3</td>
			<td class="gubun">2048-05</td>
			<td>배송준비중</td>
			<td>
			<input type="text" size="10"/>
			<button type="button" class="white" id="btnWrite">입력</button>
			</td>
		</tr>
	</c:forEach>
</table>
<br>