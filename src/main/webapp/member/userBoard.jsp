<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.io.File" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="java.awt.Image" %>
<%@ page import="javax.swing.ImageIcon" %>
<%
	String pageIndex2 = request.getParameter("pageIndex2");
	if (pageIndex2 == null)
		pageIndex2 = "1";
	if (Integer.parseInt(pageIndex2) < 0)
		pageIndex2 = "1";

	String pageIndex = request.getParameter("pageIndex");
	if (pageIndex == null)
		pageIndex = "1";
	if (Integer.parseInt(pageIndex) < 0)
		pageIndex = "1";
%>
<script>
	$(function() {

		$("#btnSearch1").click(function() {
			if ($("#searchKeyword1").val() == "") {
				alert("검색어를 입력해주세요.");
				$("#searchKeyword1").focus();
				return;
			}
			$("#form1").attr({
				method : 'post',
				action : '/userBoard.do'
			}).submit();
		});
		$("#btnSearch2").click(function() {
			if ($("#searchKeyword2").val() == "") {
				alert("검색어를 입력해주세요.");
				$("#searchKeyword2").focus();
				return;
			}
			$("#form2").attr({
				method : 'post',
				action : '/userBoard.do'
			}).submit();
		});

	});
	$(document).ready(
			function() {
				jQuery(".content").hide();
				//content 클래스를 가진 div를 표시/숨김(토글)
				$(".heading").click(
						function() {
							$(".content").not(
									$(this).next(".content").slideToggle(500))
									.slideUp();
						});
			});
</script>
<style>
.layer1 {
	margin: 0;
	padding: 0;
	width: 500px;
}

p.heading {
	margin: 1px;
	padding: 3px 10px;
	cursor: pointer;
	position: relative;
}

.content {
	padding: 5px 10px;
}

p {
	padding: 5px 0;
}
</style>

<table class="top">
	<tr class="top">
		<td class="top">board</td>
	</tr>
</table>
<form id="form1">
<input style="VISIBILITY: hidden; WIDTH: 0px">

	<input type="hidden" name="searchkind" value="1" />
	<table>
		<tr>
			<td><select name="searchCondition">
					<option value="title">제목</option>
					<option value="content">내용</option>
			</select> <input type="text" name="searchKeyword" id="searchKeyword1">
				<button type="button" id="btnSearch1" class="white">검색</button></td>
		</tr>
	</table>
</form>
<br>
<table>
	<tr>
		<th>qna</th>
	</tr>
</table>
<table class="line">
	<tr class="line">
		<td class="line"></td>
	</tr>
</table>
<div>
	<table class="board">
		<tr class="board">
			<th style="width: 10%;">NO</th>
			<th width="50%">SUBJECT</th>
			<th width="30%">DATE</th>
			<th width="10%">HIT</th>
		</tr>
		<c:forEach var="i" items="${qlist }" varStatus="status">
			<tr class="board" align="center">
				<td>${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}</td>
				<td><p class="heading">${i.title}</p>
					<div class="content">
					
					<c:set var="filenames" value="${i.filename}"></c:set>
							 <%
							int x1=0,y1=0,i1=0;
							String[] filename1={};
							String filenames1 = (String)pageContext.getAttribute("filenames");
							if(filenames1 != null && !filenames1.equals("")) {
								filename1= filenames1.split(",");
								File file1 = new File("C:/eGovFrameDev-3.7.0-64bit/workspace/thedeep/src/main/webapp/qnaImages/"+filename1[i1]);
								BufferedImage img = ImageIO.read(file1);
								int imgWidth = img.getWidth(null);
								int imgHeight = img.getHeight(null);
								if(imgWidth > imgHeight) {
									x1 = 400;
									y1 = (imgHeight * x1) / imgWidth;
								} else if(imgWidth < imgHeight) {
									y1 = 400;
									x1 = (imgWidth * y1) / imgHeight;
								} else {
									x1=400;
									y1=400;
								}
							}
							if(filenames1 != null) {
								for(int i=0; i<filename1.length; i++) {
							%> 
							<img src="/qnaImages/<%=filename1[i]%>" width="<%=x1%>" height="<%=y1%>"><br>
							<%
							 	}
							}  
      				pageContext.setAttribute("newLine","\n"); //Space, Enter
      				pageContext.setAttribute("br", "<br/>"); //br 태그
					%> 
					${fn:replace(i.content,newLine,br)}
					<br><button type="button" class="white" onClick="location.href='/qnaModify.do?unq=${i.unq}'">수정</button></div>
				</td>
				<td>${i.rdate}</td>
				<td>${i.hit}</td>
			</tr>
		</c:forEach>
	</table>
</div>
<c:set var="pageIndex" value="<%=pageIndex%>" />
<c:set var="totalPage" value="${paginationInfo.getTotalPageCount() }" />
<table border="0" width="100%">
	<tr>
		<td style="border: 0px; text-align: center">
			<div id="paging">
				<c:set var="parm1"
					value="searchCondition=${searchVO.getSearchCondition() }" />
				<c:set var="parm2"
					value="searchKeyword=${searchVO.getSearchKeyword()}" />
				<c:set var="a" value="${(pageIndex-1)/5-((pageIndex-1)/5%1)}" />
				<fmt:parseNumber var="a" integerOnly="true" value="${a}" />
				<c:set var="start" value="${a*5+1}" />
				<c:set var="last" value="${start+4}" />

				<c:if test="${last>paginationInfo.getTotalPageCount() }">
					<c:set var="last" value="${paginationInfo.getTotalPageCount() }" />
				</c:if>

				<fmt:parseNumber var="start2" integerOnly="true" value="${start-1}" />
				<c:if test="${start2 >0}">
					<a href="/userBoard.do?pageIndex=${start2}&${parm1}&${ parm2}">before</a>
				</c:if>

				<c:forEach var="i" begin="${ start}" end="${last }">
					<c:if test="${i ==pageIndex}">
						<span style="font-size: 13px; color: #E03968;">${i }</span>
					</c:if>
					<c:if test="${i !=pageIndex}">
						<a href="/userBoard.do?pageIndex=${i}&${parm1}&${ parm2}">${i}</a>
					</c:if>
				</c:forEach>

				<fmt:parseNumber var="last2" integerOnly="true" value="${last+1}" />
				<c:if test="${last2 <=paginationInfo.getTotalPageCount()}">
					<a href="/userBoard.do?pageIndex=${last2}&${parm1}&${ parm2}">next</a>
				</c:if>
		</td>
	</tr>
</table>
<br>
<br>
<br>
<form id="form2">
<input style="VISIBILITY: hidden; WIDTH: 0px">
	<input type="hidden" name="searchkind" value="2" />
	<table>
		<tr>
			<td><select name="searchCondition">
					<option value="title">제목</option>
					<option value="content">내용</option>
			</select> <input type="text" name="searchKeyword" id="searchKeyword2">
				<button type="button" id="btnSearch2" class="white">검색</button></td>
		</tr>
	</table>
</form>
<br>
<table>
	<tr>
		<th>review</th>
	</tr>
</table>
<table class="line">
	<tr class="line">
		<td class="line"></td>
	</tr>
</table>
<div class="">
	<table class="board">
		<tr class="board">
			<th width="10%">NO</th>
			<th width="50%">SUBJECT</th>
			<th width="30%">DATE</th>
			<th width="10%">HIT</th>
		</tr>
		<c:forEach var="i" items="${rlist }" varStatus="status">
			<tr class="board" align="center">
				<td>${paginationInfo2.totalRecordCount+1 - ((searchVO.pageIndex2-1) * searchVO.pageSize + status.count)}</td>
				<td><p class="heading">${i.title}</p>
				<div class="content">
				<c:set var="filenames" value="${i.filename}"></c:set>
							<%
							int x=0,y=0,i=0;
							String[] filename={};
							String filenames = (String)pageContext.getAttribute("filenames");
							if(filenames != null && !filenames.equals("")) {
								filename= filenames.split(",");
								File file = new File("C:/eGovFrameDev-3.7.0-64bit/workspace/thedeep/src/main/webapp/reviewImages/"+filename[i]);
								BufferedImage img = ImageIO.read(file);
								int imgWidth = img.getWidth(null);
								int imgHeight = img.getHeight(null);
								if(imgWidth > imgHeight) {
									x = 400;
									y = (imgHeight * x) / imgWidth;
								} else if(imgWidth < imgHeight) {
									y = 400;
									x = (imgWidth * y) / imgHeight;
								} else {
									x=400;
									y=400;
								}
							}
							if(filenames != null) {
								for(i=0; i<filename.length; i++) {
							%>
							<img src="/reviewImages/<%=filename[i]%>" width="<%=x%>" height="<%=y%>"><br>
							<%
								}
							}
							
      				pageContext.setAttribute("newLine","\n"); //Space, Enter
      				pageContext.setAttribute("br", "<br/>"); //br 태그
					%> 
					${fn:replace(i.content,newLine,br)}<br>
					<button type="button" class="white" onClick="location.href='/reviewModify.do?unq=${i.unq}'">수정</button></div>
				</td>
				<td>${i.rdate}</td>
				<td>${i.hit}</td>
			</tr>
		</c:forEach>
	</table>
</div>
<br>
<c:set var="pageIndex2" value="<%=pageIndex2%>" />
<c:set var="totalPage" value="${paginationInfo2.getTotalPageCount() }" />
<table border="0" width="800">
	<tr>
		<td style="border: 0px; text-align: center">
			<div id="paging">
				<c:set var="parm1"
					value="searchCondition=${searchVO.getSearchCondition() }" />
				<c:set var="parm2"
					value="searchKeyword=${searchVO.getSearchKeyword()}" />
				<c:set var="a" value="${(pageIndex2-1)/5-((pageIndex2-1)/5%1)}" />
				<fmt:parseNumber var="a" integerOnly="true" value="${a}" />
				<c:set var="start" value="${a*5+1}" />
				<c:set var="last" value="${start+4}" />

				<c:if test="${last>paginationInfo2.getTotalPageCount() }">
					<c:set var="last" value="${paginationInfo2.getTotalPageCount() }" />
				</c:if>

				<fmt:parseNumber var="start2" integerOnly="true" value="${start-1}" />
				<c:if test="${start2 >0}">
					<a href="/userBoard.do?pageIndex2=${start2}&${parm1}&${ parm2}">before</a>
				</c:if>

				<c:forEach var="i" begin="${ start}" end="${last }">
					<c:if test="${i ==pageIndex2}">
						<span style="font-size: 13px; color: #E03968;">${i }</span>
					</c:if>
					<c:if test="${i !=pageIndex2}">
						<a href="/userBoard.do?pageIndex2=${i}&${parm1}&${ parm2}">${i}</a>
					</c:if>
				</c:forEach>

				<fmt:parseNumber var="last2" integerOnly="true" value="${last+1}" />
				<c:if test="${last2 <=paginationInfo2.getTotalPageCount()}">
					<a href="/userBoard.do?pageIndex2=${last2}&${parm1}&${ parm2}">next</a>
				</c:if>
		</td>
	</tr>
</table>
