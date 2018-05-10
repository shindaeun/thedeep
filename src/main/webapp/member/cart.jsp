<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	$(function() {
		$("#btnBuy").click(function() {
			location.href = "/order.do";
		});

	});
</script>
<form>
<input type="checkbox" name="allselect" value="allselect"/>전체선택
<div>
	<table class="board">
		<tr class="board">
			<th width="10%" class="head">상품코드</th>
			<th width="20%" class="head">품목코드</th>
			<th width="15%" class="head">상품명</th>
			<th width="15%" class="head">상품상세</th>
			<th width="5%" class="head">사이즈</th>
			<th width="5%" class="head">컬러</th>
			<th width="10%" class="head">가격</th>
			<th width="5%" class="head">적립금</th>
			<th width="10%" class="head">개수</th>
			<th width="5%" class="head">삭제</th>
		</tr>
		<c:forEach var="result" items="${resultList }" varStatus="status">
			<tr class="board">
				<td><input type="checkbox" name="" value=""/></td>
				<td><a href="/boardModify.do?unq=${result.unq}">${result.title}</a></td>
				<td>${result.name}</td>
				<td>${result.rdate}</td>
				<td>${result.hit}</td>
				<td>${result.name}</td>
				<td>${result.rdate}</td>
				<td>${result.hit}</td>
				<td>${result.name}</td>
				<td></td>
			</tr>
		</c:forEach>
		<tr class="board">
			<td colspan="10">결제금액 123500원 + 배송비 0 월 = 123500원(적립금 64원)</td>
		</tr>
		<tr align="right">
			<td colspan="10"><button type="button" id="btnBuy" class="white">구매</button></td>
		</tr>
	</table>
</div>
</form>