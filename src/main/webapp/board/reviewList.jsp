<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.io.File" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="java.awt.Image" %>
<%@ page import="javax.swing.ImageIcon" %>

<script>
$(function() {
   $("#btnSearch").click(function() {
      if($("#searchKeyword").val()=="") {
         alert("검색어를 입력해주세요.");
         $("#searchKeyword").focus();
         return;
      }
      $("form").attr({
         action:'/reviewList.do',method:'post'
      }).submit();
   });
});
</script>

<style>
a:link { text-decoration: none; color: #000000} 
a:visited { text-decoration: none; color: #000000} 
a:active { text-decoration: none; color: #000000}
a:hover {text-decoration:underline; color: #000000}
</style>

<table class="top">
   <tr class="top">
      <td class="top">review</td>
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
      <td style="border:0px; text-align:right;">
         <button type="button" class="white" onClick="location.href='/userOrderList.do'">Write</button>
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
   <c:forEach var="result" items="${resultList}" varStatus="status">
   <tr class="board" style="height:30px;">
      <td style="text-align:center"><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/></td>
       <c:set var="pcode" value="${result.pcode }"/>
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
	  <td style="text-align:center"><a href="/productDetail.do?pcode=${result.pcode}"><img src="/productImages/${result.pcode }.jpg" width="<%=x %>" height="<%=y %>"/></a></td>
      <td style="text-align:center"><a href="/reviewDetail.do?unq=${result.unq}">
      								${result.title}&nbsp;
      								<c:if test="${result.filename!='0'}">
      								<img src="/icon/photo.JPG" width="23" height="18"/>
      								</c:if>
      								<c:if test="${result.cnt!='0'}">
      								[${result.cnt}]
      								</c:if>
      								</a></td>
      <td style="text-align:center">${result.name}</td>
      <td style="text-align:center">${result.rdate}</td>
      <td style="text-align:center">${result.hit}</td>
    </tr>
   </c:forEach>
</table>
<br>

<table border="0" width="100%;">
   <tr>
      <td align="center" style="board:0px;">
         <div id="paging">
         <c:set var="parm1" value="searchCondition=${searchVO.getSearchCondition()}"/>
         <c:set var="parm2" value="searchKeyword=${searchVO.getSearchKeyword()}"/>
         <c:forEach var="i" begin="1" end="${paginationInfo.getTotalPageCount()}">
            <a href="/reviewList.do?pageIndex=${i}&${parm1}&${parm2}">${i}</a>
         </c:forEach>
         </div>
      </td>
   </tr>
</table>