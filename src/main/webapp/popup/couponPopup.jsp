<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link href="/css/board.css" rel="stylesheet" type="text/css">
    <link href="/css/product.css" rel="stylesheet" type="text/css">
<div>

<table class="top">
		<tr class="top">
			<td class="top">보유 쿠폰 내역</td>
		</tr>
    </table>

<table class="board">
		<tr class="board">
			<th width="10%" >쿠폰이름</th>
			<th width="20%" >사용가능금액</th>
			<th width="30%" >최대할인액</th>
			<th width="20%" >할인율</th>
			<th width="20%" >사용기간</th>
		</tr>
		<c:forEach var="result" items="${resultList }" varStatus="status">
			<tr class="board">
				<td>${status.count}</td>
				<td>${result.name}</td>
				<td>${result.rdate}</td>
				<td>${result.hit}</td>
				<td>${result.hit}~${result.hit}</td>
			</tr>
		</c:forEach>
	</table>
	<table class="board">
		<tr class="board">
			<th width="50%" >상품명</th>
			<th width="50%" >가격</th>
		</tr>
		<c:forEach var="result" items="${resultList }" varStatus="status">
			<tr class="board">
				<td>${status.count}</td>
				<td>${result.name}</td>
			</tr>
		</c:forEach>
	</table>
	<table class="board">
		<tr class="board">
			<th width="30%" >쿠폰</th>
			<th width="20%" >총 금액</th>
			<th width="20%" >할인액</th>
			<th width="30%">결제금액</th>
		</tr>
		<tr class="board">
			<td>
			<select name="phone4">
				<option value="쿠폰선택">쿠폰선택</option>
				<option value="쿠폼1">쿠폰1</option>
				<option value="쿠폰2">쿠폰2</option>
		</select>
			</td>
			<td>${result.name}</td>
			<td>${result.rdate}</td>
			<td>${result.hit}</td>
		</tr>
	</table>
	<div align="center">
	<button type="button" id="btnCoupon" class="white">적용</button>&nbsp;
	<button type="button" id="btnCoupon" class="white">취소</button>
	</div>
</div>
<br>