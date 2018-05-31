<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String pageIndex = request.getParameter("pageIndex");
	if (pageIndex == null)
		pageIndex = "1";
	if (Integer.parseInt(pageIndex) < 0)
		pageIndex = "1";
%>
<script>

$(function() {
	$(document).ready(function(){
		
			if('${search.dstate1}' == "입금전") $("input:checkbox[name='dstate1']").prop("checked", true);
			if('${search.dstate2}' == "결제완료") $("input:checkbox[name='dstate2']").prop("checked", true);
			if('${search.dstate3}' == "배송준비중") $("input:checkbox[name='dstate3']").prop("checked", true);
			if('${search.dstate4}' == "배송중") $("input:checkbox[name='dstate4']").prop("checked", true);
			if('${search.dstate5}' == "배송완료") $("input:checkbox[name='dstate5']").prop("checked", true);
			if('${search.dstate6}' == "취소") $("input:checkbox[name='dstate6']").prop("checked", true);
	});
	
	$("#btnSearch").click(function() {
		if ( $("input:checkbox[class=chk]:checked").length<1 ) {
		      alert("1개 이상 체크해주세요.");
		      return;
		}
		$("#frm").attr({
			method : 'post',
			action : '/orderList.do?pageIndex=1'
		}).submit();
		
	});
	$("#btnIamport").click(function() {
		location.href="/iamportList.do";
	});
	
});
function submit(i){
	$("#frm").attr({
		method : 'post',
		action : '/orderList.do?pageIndex='+i
	}).submit();
}
function checkAll(){
	var chk=document.getElementsByClassName("chk");
	var len=chk.length;
	var all=document.getElementById("checkall");
	var bool=false;
	if(all.checked==true){
		bool=true;
	}
	for(var i=0;i<len;i++){
		chk[i].checked=bool;
	}	
}
</script>
<table class="top">
   <tr class="top">
      <td class="top">주문목록조회</td>
   </tr>
</table>
<div width="100%" align="right">
		<button type="button" id="btnIamport" class="white">카드결제정보</button>
	</div>
<form name="frm" id="frm">
<input style="VISIBILITY: hidden; WIDTH: 0px">

<input type="hidden" name="pageIndex" value="<%=pageIndex %>"/>
	<table width="100%">
		<tr>
			<th><select name="searchCondition">
					<option value="userid" <c:if test="${search.searchCondition=='userid'}">selected</c:if>>아이디</option>
					<option value="pname" <c:if test="${search.searchCondition=='pname'}">selected</c:if>>상품명</option>
			</select> <input type="text" name="searchKeyword" id="searchKeyword" value="${search.searchKeyword }">
				<button type="button" id="btnSearch" class="white">검색</button></th>
		</tr>
		<tr><td><br></td></tr>
		<tr>
			<th><input type="checkbox" class="chk"name="dstate1" value="입금전"/>입금전&nbsp;&nbsp; 
			<input type="checkbox" class="chk"name="dstate2" value="결제완료"/>결제완료&nbsp;&nbsp;
			<input type="checkbox"class="chk" name="dstate3" value="배송준비중"/>배송준비중&nbsp;&nbsp; 
			<input type="checkbox" class="chk" name="dstate4" value="배송중"/>배송중&nbsp;&nbsp;
			<input type="checkbox" class="chk" name="dstate5" value="배송완료" />배송완료&nbsp;&nbsp;
			<input type="checkbox" class="chk" name="dstate6" value="취소" />취소&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="checkbox" id="checkall" value="checkall" onclick="checkAll()"checked/>전체선택</th>
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
		<th width="10%" >배송상태</th>
	</tr>
	<c:forEach var="i" items="${olist }" varStatus="status">
		<tr class="board" align="center">
			<td>${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}</td>
			<td><a href="/orderDetail.do?ocode=${i.ocode}">${i.ocode}</a></td>
			<td>${i.userid}</td>
			<td>${i.pcode}</td>
			<td>${i.pname}</td>
			<td>${i.amount}</td>
			<td>${i.odate} </td>
			<td>${i.dstate}</td>
		</tr>
	</c:forEach>
</table>
<br>
<c:set var="pageIndex" value="<%=pageIndex%>" />
<c:set var="totalPage" value="${paginationInfo.getTotalPageCount() }" />
<table border="0" width="800">
	<tr>
		<td style="border: 0px; text-align: center">
			<div id="paging">
				<c:set var="a" value="${(pageIndex-1)/5-((pageIndex-1)/5%1)}" />
				<fmt:parseNumber var="a" integerOnly="true" value="${a}" />
				<c:set var="start" value="${a*5+1}" />
				<c:set var="last" value="${start+4}" />

				<c:if test="${last>paginationInfo.getTotalPageCount() }">
					<c:set var="last" value="${paginationInfo.getTotalPageCount() }" />
				</c:if>

				<fmt:parseNumber var="start2" integerOnly="true" value="${start-1}" />
				<c:if test="${start2 >0}">
					<a href="#" onclick="submit(${start2});">before</a>
				</c:if>

				<c:forEach var="i" begin="${ start}" end="${last }">
					<c:if test="${i ==pageIndex}">
						<span style="font-size: 13px; color: red;">${i }</span>
					</c:if>
					<c:if test="${i !=pageIndex}">
						<a href="#" onclick="submit(${i});">${i}</a>
					</c:if>
				</c:forEach>

				<fmt:parseNumber var="last2" integerOnly="true" value="${last+1}" />
				<c:if test="${last2 <=paginationInfo.getTotalPageCount()}">
					<a href="#" onclick="submit(${last2});">next</a>
				</c:if>
		</td>
	</tr>
</table>