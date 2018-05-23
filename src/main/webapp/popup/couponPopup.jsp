<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <link href="/css/board.css" rel="stylesheet" type="text/css">
    <link href="/css/product.css" rel="stylesheet" type="text/css">
<% String totalmoney = request.getParameter("totalmoney"); %>
<script src="/js/jquery-1.12.4.js"></script>
<script src="/js/jquery-ui.js"></script>
<script type="text/javascript">
function couponApply(rate) {
	
	if(isNaN(rate)){
		document.getElementById("discountmoney").innerHTML ="";
		document.getElementById("discount").innerHTML ="";
	}else{
		
	var money = parseInt(<%=totalmoney%>);
	var disrate=parseInt(rate);
	var discountMoney = money*(100-disrate)/100;
	document.getElementById("discountmoney").innerHTML = discountMoney;
	document.getElementById("discount").innerHTML =money*disrate/100;
	}
}
$(function() {
	
	$("#btnCoupon").click(function() {
		opener.document.getElementById("usecouponresult").innerHTML=$("#discount").text();
		var cname = $("#selectcoupon option:selected").text();
		if(cname=="쿠폰선택"){
			alert("쿠폰을 선택해주세요");
		}else{
			opener.document.getElementById("cname").value=cname;
			opener.totalcalcul();
			self.close();
		}
		
	});
	$("#btnClose").click(function() {
		alert("a");
		self.close();
	});
});	
</script>
<div>
<
<table class="top">
		<tr class="top">
			<td class="top">보유 쿠폰 내역</td>
		</tr>
    </table>

<table class="board">
		<tr class="board">
			<th width="20%" >쿠폰이름</th>
			<th width="20%" >사용가능금액</th>
			<th width="20%" >최대할인액</th>
			<th width="10%" >할인율</th>
			<th width="30%" >사용기간</th>
		</tr>
		<c:forEach var="i" items="${clist }">
			<tr class="board" align="center">
				<td>
				${i.cname}</td>
				<td>${i.applymoney}</td>
				<td>${i.maxdiscmoney}</td>
				<td>${i.discountrate}%</td>
				<td>${i.sdate}~${i.edate}</td>
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
		<tr class="board" align="center">
			<td>
			<select name="selectcoupon" id="selectcoupon" onchange="couponApply(this.value)">
				<option value="쿠폰선택">쿠폰선택</option>
				<c:forEach var="i" items="${clist }">
					<option value="${i.discountrate }">${i.cname }</option>
				</c:forEach>
			</select>
			</td>
			<td><%=totalmoney %></td>
			<td><span id= "discount"></span></td>
			<td><span id= "discountmoney"></span></td>
		</tr>
	</table>
	<div align="center">
	<button type="button" id="btnCoupon" class="white">적용</button>&nbsp;
	<button type="button" id="btnClose" class="white">취소</button>
	</div>
</div>
<br>