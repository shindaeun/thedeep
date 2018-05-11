<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<table class="board">
	<tr class="board">
		<td rowspan="9" width="50%">사진</td><td>상품명</td><td>블라우스</td>
	</tr>
	<tr class="board">
		<td>가격</td><td>16000</td>
	</tr>
	<tr class="board">
		<td>적립금</td><td>100</td>
	</tr>
	<tr class="board">
		<td>사이즈</td><td>100</td>
	</tr>
	<tr class="board">
		<td>컬러</td><td>100</td>
	</tr>
	<tr class="board">
		<td>FIT</td><td>100</td>
	</tr>
	<tr class="board">
		<td colspan="2">표</td>
	</tr>
	<tr class="board">
		<td colspan="2">buy</td>
	</tr>
	<tr class="board">
		<td colspan="2">cart</td>
	</tr>
</table>

<table class="board">
	<tr>
		<td style="text-align:center">
		${vo.content}상품상세사진
		</td>
	</tr>
</table>

<table>
		<tr>
			<th>review</th>
		</tr>
    </table>
    <table class="line">
    	<tr class="line">
    		<td class="line">
    		</td>
    	</tr>
    </table>
    
<c:set var="total" value="1"/>
<table class="board">
   <tr class="board" style="height:30px;">
       <th>SUBJECT</th>
       <th>WRITER</th>
       <th>DATE</th>
       <th>HIT</th>
   </tr>
   <c:forEach var="result" items="${list}" varStatus="status">
   <tr class="board" style="height:30px;">
      <td><a href="/reviewDetail.do?unq=${result.unq}">${result.title}</a></td>
      <td>${result.name}</td>
      <td>${result.date}</td>
      <td>${result.hit}</td>
    </tr>
   </c:forEach>
</table>
<br>

<table>
		<tr>
			<th>qna</th>
		</tr>
    </table>
    <table class="line">
    	<tr class="line">
    		<td class="line">
    		</td>
    	</tr>
    </table>
    
<c:set var="total" value="1"/>
<table class="board">
   <tr class="board" style="height:30px;">
       <th>SUBJECT</th>
       <th>WRITER</th>
       <th>DATE</th>
       <th>HIT</th>
   </tr>
   <c:forEach var="result" items="${list}" varStatus="status">
   <tr class="board" style="height:30px;">
      <td><a href="/pnaDetail.do?unq=${result.unq}">${result.title}</a></td>
      <td>${result.name}</td>
      <td>${result.date}</td>
      <td>${result.hit}</td>
    </tr>
   </c:forEach>
</table>
<br>