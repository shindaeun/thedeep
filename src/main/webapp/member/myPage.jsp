<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
td.my {
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
</style>

<div class="one">My Page</div>

<table class="board">
		<tr class="a">
			<td class="a" colspan="5">ORDER STATUS (RECENT 3 MONTHS)</td>
		</tr>
		<tr class="b">
			<td width="10%"></td>
			<td>입금전 0</td>
			<td>배송준비중 0</td>
			<td>배송중 0</td>
			<td>배송완료 0</td>
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
			<td class="my">NAME</td>
			<td></td>
			<td class="my">LEVEL</td>
			<td></td>
		</tr>
		<tr>
			<td class="my">COUPON</td>
			<td></td>
			<td class="my">POINT</td>
			<td></td>
		</tr>
		<tr>
			<td class="my">TOTAL</td>
			<td></td>
			<td class="my">JOINDATE</td>
			<td></td>
		</tr>
	</tbody>
</table>
<br/>
<br/>
<table class="last">
	<tr>
		<td class="last">ORDER</td>
		<td class="last">PROFILE</td>
		<td class="last">BOARD</td>
		<td class="last">CART</td>
		<td class="last">POINT</td>
		<td class="last">COUPON</td>
	</tr>
</table>
<br><br>