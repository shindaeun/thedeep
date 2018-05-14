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
	$("#btnDelete").click(function(){
		location.href="/reviewDelete.do";
	});
	$("#btnModify").click(function(){
		location.href="/reviewModify.do";
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
		<td>
		${vo.name}
		</td>
	</tr>
	
	<tr class="board">
		<th class="head">subject</th>
		<td>
		<input type="text" name="title" id="title" value="${vo.title}" style="width:98%;"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">size</th>
		<td>키:
		<select name="height" id="height">
			<option value="1" <c:if test="${vo.height=='1'}">selected</c:if>>140-145cm</option>
			<option value="2" <c:if test="${vo.height=='2'}">selected</c:if>>145-150cm</option>
			<option value="3" <c:if test="${vo.height=='3'}">selected</c:if>>150-155cm</option>
			<option value="4" <c:if test="${vo.height=='4'}">selected</c:if>>155-160cm</option>
			<option value="5" <c:if test="${vo.height=='5'}">selected</c:if>>160-165cm</option>
			<option value="6" <c:if test="${vo.height=='6'}">selected</c:if>>165-170cm</option>
			<option value="7" <c:if test="${vo.weidth=='7'}">selected</c:if>>170-175cm</option>
		</select>
		&nbsp;&nbsp;
		몸무게:
		<select name="weigth" id="weigth">
			
			<option value="1" <c:if test="${vo.weidth=='1'}">selected</c:if>>40-45kg</option>
			<option value="2" <c:if test="${vo.weidth=='2'}">selected</c:if>>45-50kg</option>
			<option value="3" <c:if test="${vo.weidth=='3'}">selected</c:if>>50-55kg</option>
			<option value="4" <c:if test="${vo.weidth=='4'}">selected</c:if>>55-60kg</option>
			<option value="5" <c:if test="${vo.weidth=='5'}">selected</c:if>>60-65kg</option>
			<option value="6" <c:if test="${vo.weidth=='6'}">selected</c:if>>65-70kg</option>
			<option value="7" <c:if test="${vo.weidth=='7'}">selected</c:if>>70-75kg</option>
			<option value="8" <c:if test="${vo.weidth=='8'}">selected</c:if>>75-80kg</option>
		</select>
		&nbsp;&nbsp; 
		사이즈:
		<select name="size" id="size">
			<option value="1" <c:if test="${vo.size=='1'}">selected</c:if>>S</option>
			<option value="2" <c:if test="${vo.size=='2'}">selected</c:if>>M</option>
			<option value="3" <c:if test="${vo.size=='3'}">selected</c:if>>L</option>
			<option value="4" <c:if test="${vo.size=='4'}">selected</c:if>>free</option>
		</select>
		</td>
	</tr>
	
	<tr class="board">
		<th class="head">fit</th>
		<td>
		<input type="radio" name="size" id="size" value="1" <c:if test="${vo.fit=='1'}">checked</c:if>/>
		매우큼 &nbsp;&nbsp; 
		<input type="radio" name="size" id="size" value="2" <c:if test="${vo.fit=='2'}">checked</c:if>/>
		큼 &nbsp;&nbsp;
		<input type="radio" name="size" id="size" value="3" <c:if test="${vo.fit=='3'}">checked</c:if>/>
		딱맞음 &nbsp;&nbsp; 
		<input type="radio" name="size" id="size" value="4" <c:if test="${vo.fit=='4'}">checked</c:if>/>
		작음 &nbsp;&nbsp; 
		<input type="radio" name="size" id="size" value="5" <c:if test="${vo.fit=='5'}">checked</c:if>/>
		매우작음 
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
		<td style="height:150px">
		
		<textarea id="content" name="content" rows="8" cols="102" style="resize: none;">${vo.content}</textarea>
		</td>
	</tr>
	
	<tr class="board">
        <th class="head">파일</th>
        <td style="text-align:left; padding:5px" >
        	<input type="file" name="file1" size="70" /><br/>
        	<%-- <%
			if(filename != null && !filename.equals("")) {
			%>
			${vo.filename}
			<%
			}
			%> --%>
        </td>
	</tr>
	
	
	
</table>

<table border="0" style="width:100%;">
	<tr style="text-align:center">
		<th style="text-align:center">
		<button type="button" id="btnList" class="white">취소</button>
		&nbsp;
		<button type="button" id="btnDelete" class="white">삭제</button>
		&nbsp;
		<button type="button" id="btnModify" class="white">수정</button>
		</th>
	</tr>
</table>