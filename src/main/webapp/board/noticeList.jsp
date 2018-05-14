<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
	$(function() {
		$("#btnWrite").click(function() {
			location.href = "/noticeWrite.do";
		});
		$("#btnSearch").click(function() {
			location.href = "";
		});
	});
</script>

<table class="top">
		<tr class="top">
			<td class="top">notice</td>
		</tr>
    </table>
    
<form name="frm" id="frm">
<table style="width:100%;">
   <tr>
      <td>
         <select name="searchCondition">
            <option value="title">제목</option>
            <option value="content">내용</option>
         </select>
         <input type="text" name="searchKeyword" id="searchKeyword">
         <button type="button" id="btnSearch" class="white">검색</button>
      </td>
      <td style="border:0px; text-align:right;">
         <button type="button" class="white" onClick="location.href='/qnaWrite.do'">Write</button>
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

