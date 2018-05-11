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
         <button type="button" class="white" onClick="location.href='/reviewWrite.do'">Write</button>
      </td>
   </tr>
</table>
</form>

<%-- <c:set var="filepath"><spring:message code="file.upload.path" /></c:set>
<c:set var="filename">${vo.filename}</c:set>
<%
String filepath = (String)pageContext.getAttribute("filepath");
String filename = (String)pageContext.getAttribute("filename");

File file = new File(filepath+"/"+filename);
BufferedImage img = ImageIO.read(file);
int imgWidth = img.getWidth(null);
int imgHeight = img.getHeight(null);
int x,y;
if(imgWidth > imgHeight) {
   x = 100;
   y = (imgHeight * x) / imgWidth;
} else if(imgWidth < imgHeight) {
   y = 100;
   x = (imgWidth * y) / imgHeight;
} else {
   x=100;
   y=100;
}
/*
 // 1024(넓이)/768(높이)
 // 1024:768 = 100:y
 // int y = 768 * 100 / 1024
 // int y = (imgHeight * 100) / imgWidth
*/


%>
 --%>

<c:set var="total" value="1"/>
<table class="board">
   <tr class="board" style="height:30px;">
       <th>NO</th>
       <th>ITEM</th>
       <th>SUBJECT</th>
       <th>WRITER</th>
       <th>DATE</th>
       <th>HIT</th>
   </tr>
   <c:forEach var="result" items="${list}" varStatus="status">
   <tr class="board" style="height:30px;">
      <td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/></td>
      <td><%-- <img src="/uploadData/${vo.filename}" width="<%=x%>" height="<%=y%>"> --%></td>
      <td><a href="/reviewDetail.do?unq=${result.unq}">${result.title}</a></td>
      <td>${result.name}</td>
      <td>${result.date}</td>
      <td>${result.hit}</td>
    </tr>
   </c:forEach>
</table>
<br>

<table border="0" width="600px;">
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