<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<br><br>
<form name="frm">
	<table>
		<tr>
			<td><select name="searchCondition">
					<option value="title">아이디</option>
					<option value="content">상품명</option>
			</select> <input type="text" name="searchKeyword" id="searchKeyword">
				<button type="button" id="btnSearch" class="white">검색</button></td>
		</tr>
		<tr>
			<td><input type="checkbox" name="dstate" />입금 전&nbsp;&nbsp; <input
				type="checkbox" name="dstate" />상품 준비 중&nbsp;&nbsp; <input type="checkbox"
				name="dstate" />배송 준비 중&nbsp;&nbsp; <input type="checkbox" name="dstate" />배송 중&nbsp;&nbsp;
				<input type="checkbox" name="dstate" />배송완료</td>
		</tr>
	</table>
</form>
<table class="board">
	<tr class="board">
		<th width="5%" class="head">NO</th>
		<th width="15%" class="head">주문번호</th>
		<th width="10%" class="head">구매자</th>
		<th width="15%" class="head">상품코드</th>
		<th width="20%" class="head">상품명</th>
		<th width="10%" class="head">구매개수</th>
		<th width="15%" class="head">주문일자</th>
		<th width="10%" class="head">배송 상태</th>
	</tr>
	<c:forEach var="result" items="${resultList }" varStatus="status">
		<tr class="board">
			<td>${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}</td>
			<td><a href="/boardModify.do?unq=${result.unq}">${result.title}</a></td>
			<td>${result.name}</td>
			<td>${result.rdate}</td>
			<td>${result.hit}</td>
			<td>${result.name}</td>
			<td>${result.rdate}</td>
		</tr>
	</c:forEach>
</table>
<br>