<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>

<%@ page import="java.io.File" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="java.awt.Image" %>
<%@ page import="javax.swing.ImageIcon" %>
<script>
$(function(){
	$("#btnList").click(function(){
		location.href="/reviewList.do";
	});
	$("#btnModify").click(function(){
		var url = "/pwdCheck.do";
		window.open(url,"비밀번호확인","width=300,height=200");
	});
});
</script>
<table class="top">
		<tr class="top">
			<td class="top">review</td>
		</tr>
    </table>
<table class="board">

	<tr class="board">
		<th class="head" width="20%">name</th>
		<td style="text-align:left">
		${vo.name}
		</td>
	</tr>
	
	<tr class="board">
		<th class="head">subject</th>
		<td style="text-align:left">
		${vo.title}
		</td>
	</tr>
	<tr class="board">
		<th class="head">size</th>
		<td>키:
			<c:if test="${vo.height=='1'}">140-145cm</c:if>
			<c:if test="${vo.height=='2'}">145-150cm</c:if>
			<c:if test="${vo.height=='3'}">150-155cm</c:if>
			<c:if test="${vo.height=='4'}">155-160cm</c:if>
			<c:if test="${vo.height=='5'}">160-165cm</c:if>
			<c:if test="${vo.height=='6'}">165-170cm</c:if>
			<c:if test="${vo.weidth=='7'}">170-175cm</c:if>
		&nbsp;&nbsp;
		몸무게:
			<c:if test="${vo.weidth=='1'}">40-45kg</c:if>
			<c:if test="${vo.weidth=='2'}">45-50kg</c:if>
			<c:if test="${vo.weidth=='3'}">50-55kg</c:if>
			<c:if test="${vo.weidth=='4'}">55-60kg</c:if>
			<c:if test="${vo.weidth=='5'}">60-65kg</c:if>
			<c:if test="${vo.weidth=='6'}">65-70kg</c:if>
			<c:if test="${vo.weidth=='7'}">70-75kg</c:if>
			<c:if test="${vo.weidth=='8'}">75-80kg</c:if>
		&nbsp;&nbsp; 
		사이즈:
			<c:if test="${vo.size=='1'}">S</c:if>
			<c:if test="${vo.size=='2'}">M</c:if>
			<c:if test="${vo.size=='3'}">L</c:if>
			<c:if test="${vo.size=='4'}">free</c:if>
		</td>
	</tr>
	
	<tr class="board">
		<th class="head">fit</th>
		<td>
		<c:if test="${vo.fit=='1'}">매우큼</c:if>
		&nbsp;&nbsp; 
		<c:if test="${vo.fit=='2'}">큼</c:if>
		&nbsp;&nbsp;
		<c:if test="${vo.fit=='3'}">딱맞음</c:if>
		&nbsp;&nbsp; 
		<c:if test="${vo.fit=='4'}">작음</c:if>
		&nbsp;&nbsp; 
		<c:if test="${vo.fit=='5'}">매우작음</c:if>
		</td>
	</tr>

<%-- <c:set var="filepath"><spring:message code="file.upload.path" /></c:set>
<c:set var="filename">${vo.filename}</c:set>
<%

String filepath = (String)pageContext.getAttribute("filepath");
String filename = (String)pageContext.getAttribute("filename");
int x=0,y=0;
if(filename != null && !filename.equals("")) {
	File file = new File(filepath+"/"+filename);
	BufferedImage img = ImageIO.read(file);
	int imgWidth = img.getWidth(null);
	int imgHeight = img.getHeight(null);
	
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
}
/*
 // 1024(넓이)/768(높이)
 // 1024:768 = 100:y
 // int y = 768 * 100 / 1024
 // int y = (imgHeight * 100) / imgWidth
*/
%> --%>
	
	
	<tr class="board">
		<th class="head">content</th>
		<td style="text-align:left;height:150px">
		<%-- <%
		if(filename != null && !filename.equals("")) {
		%>
		<img src="/uploadData/${vo.filename}" width="<%=x%>" height="<%=y%>">
		<%
		}
		%> --%>
		<%
      	pageContext.setAttribute("newLine","\n"); //Space, Enter
      	pageContext.setAttribute("br", "<br/>"); //br 태그
		%> 
		${fn:replace(vo.content,newLine,br)}
		</td>
	</tr>
	
</table>

<table border="0" style="width:100%;">
	<tr style="text-align:center">
		<th style="text-align:center">
		<button type="button" id="btnList" class="white">목록</button>&nbsp;
		<button type="button" id="btnModify" class="white">수정</button>
		</th>
	</tr>
</table>