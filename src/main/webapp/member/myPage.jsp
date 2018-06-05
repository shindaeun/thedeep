<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
div.one {
	width:100%;
	height:50px;
	font-size:16pt;
	font-weight: bold;
	color: #646464;	
	text-align: center;
	margin-top:40px;
	margin-bottom:10px;
}
tr.a {
	padding:10px;
	height:50px;
}
td.a {
	font-size:9pt;
	font-weight: bold;
	text-align: left;
	padding-left:20px;
}
tr.b {
	padding:10px;
	height: 50px;
	text-align: center;
	font-size: 9pt;
	border-bottom: 1px solid #808080;
}
th.my,td.my {
	border-right: 1px solid #808080;
	height: 30px;
	font-size: 9pt;
	text-align: right;
	padding-right:8px;
}
table.last {
	width: 100%;
	border: 1px solid #808080;
	border-bottom: 3px solid #808080;
	margin-top:15px;
}
td.last{
	width: 16%;
	border-right: 1px solid #808080;
	height: 60px;
	text-align: left;
	font-size:9pt;
	padding-left: 8px;
}
a:link { text-decoration: none; color: #000000} 
a:visited { text-decoration: none; color: #000000} 
a:active { text-decoration: none; color: #000000}
a:hover {text-decoration:underline; color: #000000}
</style>

<div class="one">My Page</div>

<table class="board">
		<tr class="a">
			<td class="a" colspan="6">ORDER STATUS (RECENT 3 MONTHS)</td>
		</tr>
		<tr class="b">
			<td width="10%"></td>
			<td>입금전 ${inMoney}</td>
			<td>결제완료 ${onMoney}</td>
			<td>배송준비중 ${preparing}</td>
			<td>배송중 ${deliver}</td>
			<td>배송완료 ${complete}</td>
		</tr>
</table>
<br/>
<br/>
<table style="width:100%;">
	<colgroup>
		<col width="15%" />
		<col width="35%" />
		<col width="15%" />
		<col width="35%" />
	</colgroup>
	<tbody>
		<tr>
			<th class="my">NAME</th>
			<td style="font-size:9pt;">${vo.name}</td>
			<th></th>
			<td></td>
		</tr>
		<tr>
			<th class="my">COUPON</th>
			<td style="font-size:9pt;"><a href="/coupon.do">${coupon}</a></td>
			<th class="my">POINT</th>
			<td style="font-size:9pt;">${point}</td>
		</tr>
		<tr>
			<th class="my">TOTAL</th>
			<td style="font-size:9pt;">${total}</td>
			<th class="my">JOINDATE</th>
			<td style="font-size:9pt;">${vo.joindate}</td>
		</tr>
	</tbody>
</table>
<br/>
<br/>
<table class="last">
	<tr>
		<td class="last"><a href="/userOrderList.do">ORDER</a></td>
		<td class="last"><a href="/memberModify.do">PROFILE</a></td>
		<td class="last"><a href="/userBoard.do">BOARD</a></td>
		<td class="last"><a href="/cart.do">CART</a></td>
		<td class="last"><a href="/point.do">POINT</a></td>
		<td class="last"><a href="/coupon.do">COUPON</a></td>
	</tr>
</table>
<br><br>