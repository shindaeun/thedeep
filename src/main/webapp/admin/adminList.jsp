<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
a:link { text-decoration: none; color: #000000} 
a:visited { text-decoration: none; color: #000000} 
a:active { text-decoration: none; color: #000000}
a:hover {text-decoration:underline; color: #000000}
</style>
<table class="top">
	<tr class="top">
		<td class="top">회원 정보 조회</td>
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
<table border="0" width="100%">
	<tr>
		<td align="center" style="board:0px;">
			<div id="paging">
			<c:set var="parm1" value="searchCondition=${searchVO.getSearchCondition()}"/>
			<c:set var="parm2" value="searchKeyword=${searchVO.getSearchKeyword()}"/>
			<c:forEach var="i" begin="1" end="${paginationInfo.getTotalPageCount()}">
				<a href="/adminList.do?pageIndex=${i}&${parm1}&${parm2}">${i}</a>
			</c:forEach>
			</div>
		</td>
	</tr>
</table>
<br/>
<br/>