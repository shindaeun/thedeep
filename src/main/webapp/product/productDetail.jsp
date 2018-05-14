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
    
<div class="">
	<table class="board">
		<tr class="board">
			<th width="10%" >NO</th>
			<th width="40%" >SUBJECT</th>
			<th width="20%" >WRITER</th>
			<th width="20%" >DATE</th>
			<th width="10%" >HIT</th>
		</tr>
		<c:forEach var="result" items="${resultList }" varStatus="status">
			<tr class="board">
				<td>${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}</td>
				<td><a href="/boardModify.do?unq=${result.unq}">${result.title}</a></td>
				<td>${result.name}</td>
				<td>${result.rdate}</td>
				<td>${result.hit}</td>
			</tr>
		</c:forEach>
	</table>
</div>
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
    
<div>
	<table class="board">
		<tr class="board">
			<th style="width:10%;" >NO</th>
			<th width="40%" >SUBJECT</th>
			<th width="20%" >WRITER</th>
			<th width="20%" >DATE</th>
			<th width="10%" >HIT</th>
		</tr>
		<c:forEach var="result" items="${resultList }" varStatus="status">
			<tr class="board">
				<td>${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}</td>
				<td><a href="/boardModify.do?unq=${result.unq}">${result.title}</a></td>
				<td>${result.name}</td>
				<td>${result.rdate}</td>
				<td>${result.hit}</td>
			</tr>
		</c:forEach>
	</table>
</div>
<br>