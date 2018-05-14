<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
	$(function() {
		$("#btnBuy").click(function() {
			location.href = "/order.do";
		});

	});
</script>
<table class="top">
		<tr class="top">
			<td class="top">cart</td>
		</tr>
    </table>
<form>
	<input type="checkbox" name="allselect" value="allselect" />전체선택
	<table class="board">
		<tr class="board">
			<th width="10%" >상품코드</th>
			<th width="20%" >품목코드</th>
			<th width="15%" >상품명</th>
			<th width="15%" >상품상세</th>
			<th width="5%" >사이즈</th>
			<th width="5%" >컬러</th>
			<th width="10%" >가격</th>
			<th width="5%" >적립금</th>
			<th width="10%" >개수</th>
			<th width="5%" >삭제</th>
		</tr>
		<c:forEach var="result" items="${resultList }" varStatus="status">
			<tr class="board">
				<td><input type="checkbox" name="" value="" /></td>
				<td><a href="/boardModify.do?unq=${result.unq}">${result.title}</a></td>
				<td>${result.name}</td>
				<td>${result.rdate}</td>
				<td>${result.hit}</td>
				<td>${result.name}</td>
				<td>${result.rdate}</td>
				<td>${result.hit}</td>
				<td><input type="number"></td>
				<td></td>
			</tr>
		</c:forEach>
		<tr class="board" align="right">
			<td colspan="10">1결제금액 123500원 + 배송비 0 월 = 123500원(적립금 64원)</td>
		</tr>

	</table>
	<table width="100%">
		<tr>
			<td align="right"><button type="button" id="btnBuy"
					class="white">구매</button></td>
		</tr>
	</table>

</form>