<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.io.File"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.awt.Image"%>
<%@page import="javax.swing.ImageIcon"%>
<%
String pageIndex=request.getParameter("pageIndex"); 
if(pageIndex==null)pageIndex="1";
if(Integer.parseInt(pageIndex)<0)pageIndex="1";
%>
    <table class="top">
		<tr class="top">
			<td class="top">${gvo.gname }</td>
		</tr>
    </table>

    <table>
		<tr>
			<th>best item</th>
		</tr>
    </table>
    <table class="line">
    	<tr class="line">
    		<td class="line">
    		</td>
    	</tr>
    </table>

	<table class="board">
		<colgroup>
		<col width="33%"/>
		<col width="33%"/>
		<col width="33%"/>
	</colgroup>
		<tr class="board">
			<c:forEach var="i" items="${blist}" varStatus="status">
			<c:set var="filename" value="${i.filename }"/>
				<%
				int x=0,y=0;
				String filename = (String) pageContext.getAttribute("filename");
				File file = new File("C:/eGovFrameDev-3.7.0-64bit/workspace/thedeep/src/main/webapp/productImages/" + filename);
				if(!filename.equals(null) &&!filename.equals("")&& file.exists()){
					BufferedImage img = ImageIO.read(file);
					int imgWidth = img.getWidth(null);
					int imgHeight = img.getHeight(null);
					
					if (imgWidth > imgHeight) {
						x =200;
						y =(imgHeight*200)/imgWidth;
					} else {
						y =200;
						x =(imgWidth*200)/imgHeight;
					} 
				}
				%>
			<th><img src="/productImages/${i.filename }" width="<%=x %>" height="<%=y %>"/><br>${i.pname}상품명<br>${i.price}가격</th>
			</c:forEach>
		</tr>
	</table>


 	<table>
		<tr>
			<th>${gvo.gname }</th>
		</tr>
    </table>
    <table class="line">
    	<tr class="line">
    		<td class="line">
    		</td>
    	</tr>
    </table>


	<table class="board">
		<colgroup>
		<col width="33%"/>
		<col width="33%"/>
		<col width="33%"/>
		</colgroup>
		<tr class="board">
			<c:set var="filenum" value="0"/>
			<c:forEach var="i" items="${plist}" varStatus="status">
			<c:set var="filenum" value="${filenum+1}"/>
			<c:set var="filename" value="${i.filename }"/>
				<%
				int x=0,y=0;
				String filename = (String) pageContext.getAttribute("filename");
				File file = new File("C:/eGovFrameDev-3.7.0-64bit/workspace/thedeep/src/main/webapp/productImages/" + filename);
				if(!filename.equals(null) &&!filename.equals("")&& file.exists()){
					BufferedImage img = ImageIO.read(file);
					int imgWidth = img.getWidth(null);
					int imgHeight = img.getHeight(null);
					
					if (imgWidth > imgHeight) {
						x =200;
						y =(imgHeight*200)/imgWidth;
					} else {
						y =200;
						x =(imgWidth*200)/imgHeight;
					} 
				}
				%>
			<th><a href="/home.do"><img src="/productImages/${i.filename }" width="<%=x %>" height="<%=y %>"/></a><br>${i.pname }<br>${i.price }</th>
			<c:if test="${filenum==3}">
				<c:set var="filenum" value="0"/>
				</tr>
				<tr class="board">
			</c:if>
			</c:forEach>
			<c:if test="${filenum!=0}">
			<c:forEach var="i" begin="${filenum }" end="3">
				<th></th>
			</c:forEach>
			</c:if>
		</tr>
	</table>
	
<c:set var="pageIndex" value="<%=pageIndex %>"/>
		<c:set var="totalPage" value="${paginationInfo.getTotalPageCount() }"/>
		<table border="0" width="100%">
				<tr>
					<td style="border: 0px; text-align: center">
						<div id="paging">
						<c:set var="parm1"
							value="searchCondition=${searchVO.getSearchCondition() }"/>
						<c:set var="parm2"
							value="searchKeyword=${searchVO.getSearchKeyword()}"/>
						<c:set var="a" value="${(pageIndex-1)/5-((pageIndex-1)/5%1)}" />
						<fmt:parseNumber var="a" integerOnly="true" value="${a}"/>
						<c:set var="start" value="${a*5+1}"/>
						<c:set var="last" value="${start+4}"/>
						
						<c:if test="${last>paginationInfo.getTotalPageCount() }">
							<c:set var="last" value="${paginationInfo.getTotalPageCount() }"/>
						</c:if>
						
						<fmt:parseNumber var="start2" integerOnly="true" value="${start-1}"/>
						<c:if test="${start2 >0}">
						<a href="/productList.do?pageIndex=${start2}&${parm1}&${ parm2}">before</a>
						</c:if>
						
        				<c:forEach var="i" begin="${ start}" end="${last }">
        					<c:if test="${i ==pageIndex}"><span style="font-size:13px;color:red;">${i }</span></c:if>
        					<c:if test="${i !=pageIndex}">
        					<a href="/productList.do?pageIndex=${i}&${parm1}&${ parm2}">${i}</a></c:if>
        				</c:forEach>
        				
        				<fmt:parseNumber var="last2" integerOnly="true" value="${last+1}"/>
        				<c:if test="${last2 <=paginationInfo.getTotalPageCount()}">
						<a href="/productList.do?pageIndex=${last2}&${parm1}&${ parm2}">next</a>
						</c:if>
					</td>
				</tr>
			</table>
