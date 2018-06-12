<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="/css/jquery-ui.css">
<script src="/js/jquery-1.12.4.js"></script>
<script src="/js/jquery-ui.js"></script>

<%
	String pageIndex = request.getParameter("pageIndex");
	if (pageIndex == null)
		pageIndex = "1";
	if (Integer.parseInt(pageIndex) < 0)
		pageIndex = "1";
%>
<script>
$(function() {
	$("#btnSubmit").click(function() {
		if($("#userid").val()=="") {
			alert("아이디를 입력해주세요.");
			$("#userid").focus();
			return;
		}
		if($("#content").val()=="") {
			alert("내용을 입력해주세요.");
			$("#content").focus();
			return;
		}
		
		if(confirm("등록하시겠습니까?")) {
			var formData = $("#frm2").serialize();//비 동기 전송

			$.ajax({
			     type: "POST",
			     data: formData,
			     url: "/pointAddSave.do",
			     success: function(data) {
			          if(data.result == "ok") {
			               alert("등록하였습니다.");
			               location.href = "<c:url value="/pointAdd.do"/>";
			          } else if(data.result=="idchk") {
			        	  alert("존재하지 않는 아이디입니다.");
			          } else {
			              alert("등록 실패했습니다. 다시 시도해 주세요.");
			          }
			     },
			     error: function(request,status,error) {
					 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		}
	});
 
});
 $(function() {
   $("#btnSearch").click(function() {
      if($("#searchKeyword").val()=="") {
         alert("검색어를 입력해주세요.");
         $("#searchKeyword").focus();
         return;
      }
      $("#frm1").attr({
         action:'/pointAdd.do',method:'post'
      }).submit();
   });
   
});
function submit(i){
	$("#frm1").attr({
		method : 'post',
		action : '/pointAdd.do?pageIndex='+i
	}).submit();
} 
</script>

<table class="top">
   <tr class="top">
      <td class="top">포인트적립</td>
   </tr>
</table>

<form name="frm1" id="frm1">
<table style="width:100%">
   <tr>
      <td>
         <select name="searchCondition">
            <option value="userid">아이디</option>
            <option value="content">내용</option>
         </select>
         <input type="text" name="searchKeyword" id="searchKeyword">
         <button type="button" id="btnSearch" class="white">검색</button>
      </td>
   </tr>
</table>
</form>
</br>
<form id="frm2" name="frm2">
<table class="board">
	<tr class="board">
		<th width="25%">아이디</th>
		<th width="25%">내용</th>
		<th width="25%">적립금</th>
		<th width="25%">등록</th>
	</tr>
	<tr class="board">
		<th width="25%"><input type="text" name="userid" id="userid" style="width:50%;"></th>
		<th width="25%"><select name="content" id="content">
			<option value="리뷰">리뷰</option>
			<option value="환불">환불</option>
			<option value="취소">취소</option>
			<option value="배송지연">배송지연</option>
			<option value="기타">기타</option>
		</select></th>
		<th width="25%"><input type="number" name="savepoint" id="savepoint" style="width:50%;"></th>
		<th width="25%"><button type="button" id="btnSubmit" class="white">등록</button></th>
	</tr>
</table>
</form>
<br>

<table class="board">
<tr class="board">
		<th width="20%">아이디</th>
		<th width="20%">내용</th>
		<th width="20%">사용적립금</th>
		<th width="20%">적립적립금</th>
		<th width="20%">사용가능적립금</th>
	</tr>
<c:forEach var="result" items="${resultList}" varStatus="status">
	<tr class="board">
		<th width="20%">${result.userid}</th>
		<th width="20%">${result.content}</th>
		<th width="20%">${result.usepoint}</th>
		<th width="20%">${result.savepoint}</th>
		<th width="20%">${result.ablepoint}</th>
	</tr>

</c:forEach>
</table>
<br>
<c:set var="pageIndex" value="<%=pageIndex%>" />
<c:set var="totalPage" value="${paginationInfo.getTotalPageCount() }" />
<table border="0" width="100%">
	<tr>
		<td align="center" style="board:0px;">
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
						<span style="font-size: 13px; color: #E03968;">${i }</span>
					</c:if>
					<c:if test="${i !=pageIndex}">
						<a href="#" onclick="submit(${i});">${i}</a>
					</c:if>
				</c:forEach>

				<fmt:parseNumber var="last2" integerOnly="true" value="${last+1}" />
				<c:if test="${last2 <=paginationInfo.getTotalPageCount()}">
					<a href="#" onclick="submit(${last2});">next</a>
				</c:if>
			</div>
		</td>
	</tr>
</table>
