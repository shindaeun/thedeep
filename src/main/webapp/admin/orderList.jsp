<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table class="top">
   <tr class="top">
      <td class="top">주문목록조회</td>
   </tr>
</table>

<form name="frm">
	<table width="100%">
		<tr>
			<th><select name="searchCondition">
					<option value="title">아이디</option>
					<option value="content">상품명</option>
			</select> <input type="text" name="searchKeyword" id="searchKeyword">
				<button type="button" id="btnSearch" class="white">검색</button></th>
		</tr>
		<tr><td><br></td></tr>
		<tr>
			<th><input type="checkbox" name="dstate" />입금 전&nbsp;&nbsp; <input
				type="checkbox" name="dstate" />상품 준비 중&nbsp;&nbsp; <input type="checkbox"
				name="dstate" />배송 준비 중&nbsp;&nbsp; <input type="checkbox" name="dstate" />배송 중&nbsp;&nbsp;
				<input type="checkbox" name="dstate" />배송완료</th>
		</tr>
	</table>
</form>
<table class="board">
	<tr class="board">
		<th width="5%" >NO</th>
		<th width="15%" >주문번호</th>
		<th width="10%" >구매자</th>
		<th width="15%" >상품코드</th>
		<th width="20%" >상품명</th>
		<th width="10%">구매개수</th>
		<th width="15%" >주문일자</th>
		<th width="10%" >배송 상태</th>
	</tr>
	<c:forEach var="result" items="${resultList }" varStatus="status">
		<tr class="board">
			<td>1${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}</td>
			<td>1<a href="/boardModify.do?unq=${result.unq}">${result.title}</a></td>
			<td>${result.name}1</td>
			<td>${result.rdate}1</td>
			<td><input type="number"/></td>
			<td>${result.name}1</td>
			<td></td>
		</tr>
	</c:forEach>
</table>
<br>
