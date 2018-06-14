<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ page import="java.io.File" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="java.awt.Image" %>
<%@ page import="javax.swing.ImageIcon" %>

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
      $("form").attr({
         action:'/qnaList.do',method:'post'
      }).submit();
   });
});
function submit(i){
	$("#frm").attr({
		method : 'post',
		action : '/qnaList.do?pageIndex='+i
	}).submit();
}
</script>

<style>
a:link { text-decoration: none; color: #000000;text-align:center} 
a:visited { text-decoration: none; color: #000000} 
a:active { text-decoration: none; color: #000000}
a:hover {text-decoration:underline; color: #000000}
</style>

<table class="top">
	<tr class="top">
		<td class="top">Q&A</td>
	</tr>
</table>

<form name="frm" id="frm">
<table style="width:100%;">
   <tr>
      <td>
         <select name="searchCondition">
            <option value="title">제목</option>
            <option value="name">이름</option>
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


<c:set var="total" value="1"/>
<table class="board">
	<tr class="board" style="height:30px;">
		<th width="10%">NO</th>
		<th width="20%">ITEM</th>
		<th width="20%">SUBJECT</th>
		<th width="20%">WRITER</th>
		<th width="20%">DATE</th>
		<th width="10%">HIT</th>
	</tr>
	<c:forEach var="result" items="${list}" varStatus="status">
	<tr class="board" style="height:30px; text-align:center;">
		<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/></td>
		<c:set var="pcode" value="${result.pcode}"/>
		<c:if test="${pcode!=null}">
       <%
		int x=0,y=0;
		String filename = (String) pageContext.getAttribute("pcode");
		filename=filename + ".jpg"; 
		File file = new File("C:/eGovFrameDev-3.7.0-64bit/workspace/thedeep/src/main/webapp/productImages/" + filename);
		if(!filename.equals(null) &&!filename.equals("")&& file.exists()){
			BufferedImage img = ImageIO.read(file);
			int imgWidth = img.getWidth(null);
			int imgHeight = img.getHeight(null);
			
			if (imgWidth > imgHeight) {
				x =100;
				y =(imgHeight*100)/imgWidth;
			} else {
				y =100;
				x =(imgWidth*100)/imgHeight;
			}
		}
		%>
	    <td style="text-align:center">
	    	<a href="/productDetail.do?pcode=${result.pcode}"><img src="/productImages/${result.pcode}.jpg" width="<%=x %>" height="<%=y %>"/></a>
	    </td>
	    </c:if>
	    <c:if test="${pcode==null}">
	    <td style="text-align:center"></td>
	    </c:if>
		<td>
		<c:if test="${login==1}">
		<c:if test="${result.forder=='aa'}"><a href="/qnaReDetail.do?unq=${result.unq}">└ <img src="/qnaImages/lock.png" width="10px" height="10px"/>[re] ${result.title}</a></c:if>
		<c:if test="${result.forder!='aa'}"><a href="/qnaDetail.do?unq=${result.unq}"><img src="/qnaImages/lock.png" width="10px" height="10px"/>${result.title}</a></c:if>
		</c:if>
		<c:if test="${login!=1}">
		<c:if test="${result.forder=='aa'}">└ <img src="/qnaImages/lock.png" width="10px" height="10px"/>[re] </c:if>
		<img src="/qnaImages/lock.png" width="10px" height="10px"/>
		<a href="/qnaLock.do?unq=${result.unq}">${result.title}</a>
		</c:if>
		</td>
		<td>${result.name}</td>
		<td>${result.rdate}</td>
		<td>${result.hit}</td>
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