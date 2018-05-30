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
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.0.min.js" ></script>
<script>
$(function(){
	
$(".mouse").mouseenter(function(){
	$(this).active{background:black;}
});
});

</script>
<style>
.mouse {
background: white;
}
.mouse:hover {
  background: #dcdcdc;
  background: -webkit-gradient(linear, left top, left bottom, from(#dcdcdc), to(#dcdcdc));
  background: -moz-linear-gradient(top,  #dcdcdc,  #dcdcdc); 
}
</style>
    <table class="top">
		<tr class="top">
			<td class="top">best50</td>
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
			<c:forEach var="i" items="${blist}" varStatus="status">
			<c:set var="filenum" value="${filenum+1}"/>
			<c:set var="mainfile" value="${i.mainfile }"/>
				<%
				int x=0,y=0;
				String mainfile = (String) pageContext.getAttribute("mainfile");
				File file = new File("C:/eGovFrameDev-3.7.0-64bit/workspace/thedeep/src/main/webapp/productImages/" + mainfile);
				if(!mainfile.equals(null) &&!mainfile.equals("")&& file.exists()){
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
			<th class="mouse"><a href="/productDetail.do?pcode=${i.pcode }"><img src="/productImages/${i.mainfile }" style="cursur:pointer"width="<%=x %>" height="<%=y %>"/></a><br>${i.pname }<br>${i.price }원</th>
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