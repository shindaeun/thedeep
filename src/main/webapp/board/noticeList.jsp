<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
$(function() {
   $("#btnSearch").click(function() {
      if($("#searchKeyword").val()=="") {
         alert("검색어를 입력해주세요.");
         $("#searchKeyword").focus();
         return;
      }
      $("form").attr({
         action:'/noticeList.do',method:'post'
      }).submit();
   });
});
</script>

<table class="top">
		<tr class="top">
			<td class="top">notice</td>
		</tr>
    </table>
    
<form name="frm" id="frm">
<table style="width:100%">
   <tr>
      <td>
         <select name="searchCondition">
            <option value="title">제목</option>
            <option value="name">이름</option>
         </select>
         <input type="text" name="searchKeyword" id="searchKeyword">
         <button type="button" id="btnSearch" class="white">검색</button>
      </td>
   </tr>
</table>
</form>

<div>
	<table class="board">
		<tr class="board">
			<th width="10%">NO</th>
			<th width="40%" >SUBJECT</th>
			<th width="20%" >WRITER</th>
			<th width="20%" >DATE</th>
			<th width="10%" >HIT</th>
		</tr>
		<c:forEach var="result" items="${resultList }" varStatus="status">
			<tr class="board" style="height:30px;">
				<td style="text-align:center">${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}</td>
				<td style="text-align:center"><a href="/noticeDetail.do?unq=${result.unq}">${result.title}</a></td>
				<td style="text-align:center">${result.name}</td>
				<td style="text-align:center">${result.rdate}</td>
				<td style="text-align:center">${result.hit}</td>
			</tr>
		</c:forEach>
	</table>
</div>
<br>
<table border="0" width="100%;">
   <tr>
      <td align="center" style="board:0px;">
         <div id="paging">
         <c:set var="parm1" value="searchCondition=${searchVO.getSearchCondition()}"/>
         <c:set var="parm2" value="searchKeyword=${searchVO.getSearchKeyword()}"/>
         <c:forEach var="i" begin="1" end="${paginationInfo.getTotalPageCount()}">
            <a href="/noticeList.do?pageIndex=${i}&${parm1}&${parm2}">${i}</a>
         </c:forEach>
         </div>
      </td>
   </tr>
</table>
