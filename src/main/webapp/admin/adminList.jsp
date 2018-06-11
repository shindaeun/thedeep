<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
   $("#btnSearch").click(function() {
      if($("#searchKeyword").val()=="") {
         alert("검색어를 입력해주세요.");
         $("#searchKeyword").focus();
         return;
      }
      $("#frm").attr({
         action:'/adminList.do',method:'post'
      }).submit();
   });
});
function submit(i){
	$("#frm").attr({
		method : 'post',
		action : '/adminList.do?pageIndex='+i
	}).submit();
}
</script>

<style>
div.one {
	width:100%;
	height:50px;
	font-size:14pt;
	font-weight: bold;
	color: #646464;	
	text-align: center;
	margin-top:60px;
	margin-bottom:10px;
}
a:link { text-decoration: none; color: #000000;text-align:center } 
a:visited { text-decoration: none; color: #000000} 
a:active { text-decoration: none; color: #000000}
a:hover {text-decoration:underline; color: #000000}
</style>
<table class="top">
	<tr class="top">
		<td class="top">회원목록조회</td>
	</tr>
</table>

<form id="frm" name="frm">
<table style="width:100%; text-align:center;">
	<tr>
      <td style="font-weight: bold;">
         <select name="searchCondition">
            <option value="userid">아이디</option>
            <option value="name">이름</option>
         </select>
         <input type="text" name="searchKeyword" id="searchKeyword">
         <button type="button" id="btnSearch" class="white">검색</button>
      </td>
   </tr>
</table>
<table class="board">
	<tr class="board" style="height:35px;">
		<th width="20%"> 아이디</th>
		<th width="10%">이름</th>
		<th width="15%">연락처</th>
		<th width="15%">생일</th>
		<th width="25%">이메일</th>
		<th width="15%">가입일</th>
	</tr>
	<c:forEach var="result" items="${list}" varStatus="status">
	<tr class="board" style="height:30px; text-align:center;">
		<td>${result.userid}</td>
		<td>${result.name}</td>
		<td>${result.phone}</td>
		<td>${result.birthday}</td>
		<td>${result.email}</td>
		<td >${result.joindate}</td>
	 </tr>
	</c:forEach>
</table>
</form>
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
			</div>
		</td>
	</tr>
</table>
<br/>
<br/>