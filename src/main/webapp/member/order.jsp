<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
	$(function() {
		$("#btnCoupon").click(function() {
			var url = "/couponPopup.do";
	    	window.open(url,"쿠폰리스트","width=700,height=400,scrollbars=yes");
		});
		$("#btnPostSearch").click(function() {
			var url = "/postPopup.do";
	    	window.open(url,"우편번호찾기","width=600,height=500,scrollbars=yes");
		});
		
	});
</script>
<c:set var="sumprice" value="0"/>
<c:set var="sumpoint" value="0"/>
<c:set var="delprice" value="3000"/>
<div>
	<table class="board">
		<tr class="board">
			<th width="50%" >구입상품명</th>
			<th width="20%" >수량</th>
			<th width="15%">가격</th>
			<th width="15%" >적립</th>
		</tr>
		<c:forEach var="i" items="${olist }" varStatus="status">
		<c:set var="sumprice" value="${sumprice +i.price }"/>
		<c:set var="sumpoint" value="${sumpoint +i.savepoint }"/>
			<tr class="board" align="center">
				<td>${i.pname}</td>
				<td>${i.amount}</td>
				<td>${i.price}</td>
				<td>${i.savepoint}</td>
			</tr>
		</c:forEach>
		<c:if test="${sumprice > 50000 }">
			<c:set var="delprice" value="0"/>
		</c:if>
		<tr class="board" align="right">
			<td colspan="10">결제금액 ${sumprice }원 + 배송비 ${delprice } 원 = ${sumprice + delprice }원(적립금 ${sumpoint }원)</td>
		</tr>
	</table>
</div>
<br>
<h5>> 주문인 정보</h5>
<table class="board">
	<tr class="board">
		<th class="head" width="20%">주문하는 분</th>
		<td>${vo.name }</td>
	</tr>
	<tr class="board">
		<th class="head">전화번호</th>
		<td><select name="phone1">
				<option value="010">010</option>
				<option value="011">011</option>
				<option value="016">016</option>
		</select> -<input type="text" name="phone2" id="phone2" style="width: 50px;">
			-<input type="text" name="phone3" id="phone3" style="width: 50px;"></td>

	</tr>
	<tr class="board">
		<th class="head">이메일</th>
		<td><input type="text" name="email1" id="email1">@ <select
			name="email2" id="email2">
				<option value="naver.com">naver.com</option>
				<option value="hanmail.net">hanmail.net</option>
				<option value="gmail.com">gmail.com</option>
		</select></td>
	</tr>
</table>
<br>
<h5>> 수취인 정보</h5>
<table class="board">
	<tr class="board">
		<th class="head" width="20%">주문인 확인</th>
		<td><input type="checkbox" name="same" id="same" />위 주문정보와 동일</td>
	</tr>
	<tr class="board">
		<th class="head" width="20%">받으시는 분</th>
		<td><input type="text" /></td>
	</tr>
	<tr class="board">
		<th class="head">전화번호</th>
		<td><select name="phone4">
				<option value="010">010</option>
				<option value="011">011</option>
				<option value="016">016</option>
		</select> -<input type="text" name="phone5" id="phone5" style="width: 50px;">
			-<input type="text" name="phone6" id="phone6" style="width: 50px;"></td>

	</tr>
	<tr class="board">
		<th class="head">주소</th>
		<td><input type="text" name="postnum" id="postnum">
			<button type="button" id="btnPostSearch" class="white">우편번호찾기</button> 
			<br> <input type="text" name="addr1" id="addr1" size="50">
			<br> <input type="text" name="addr2" id="addr2" size="50">
	</tr>
	<tr class="board">
		<th class="head" width="20%">주문 메세지</th>
		<td><textarea rows="3" cols="50" size="50" style="resize: none;"></textarea></td>
	</tr>
	<tr class="board">
		<th class="head" width="20%">무통장 임금자명</th>
		<td><input type="text" />(주문자와 같은 경우 생략 가능)</td>
	</tr>
</table>
<h5>> 결제 정보</h5>
<table class="board">
	<tr class="board">
		<th class="head" width="20%">적립금 사용</th>
		<td><input type="text" />원 &nbsp; (사용 가능 적립금) &nbsp;<input
			type="text" />원
			<button type="button" id="" class="white">적용</button></td>
	</tr>
	<tr class="board">
		<th class="head" width="20%">쿠폰 사용</th>
		<td><input type="text" readOnly /> &nbsp;
			<button type="button" id="btnCoupon" class="white">사용</button></td>
	</tr>

</table>
<br>