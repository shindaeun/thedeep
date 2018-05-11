<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <table class="top">
		<tr class="top">
			<td class="top">outer</td>
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


	<table class="product">
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<tr class="product">
			<td width="250" height="300">1<br>2<br>3</td>
			<td width="250" height="300">${status.mainfile}1<br>${status.pname}2<br>${status.price}3</td>
		</tr>
		
		</c:forEach>
	</table>

 	<table>
		<tr>
			<th>outer</th>
		</tr>
    </table>
    <table class="line">
    	<tr class="line">
    		<td class="line">
    		</td>
    	</tr>
    </table>


<table class="product">
	<tr class="product">
		<td>
		</td>
	</tr>
</table>

