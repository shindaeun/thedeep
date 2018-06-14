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
<script src="/js/jquery-1.12.4.js"></script>
<script src="/js/jquery-ui.js"></script>

<script>
$(function(){
	
$(".mouse").mouseenter(function(){
	$(this).active{background:black;}
});
});

</script>

<script>
/* $(function() {
	if($("#happyBTD").val()!="0") {
		var userid = $("#happyBTD").val();
		var url = "/birthdayPopup.do";
		window.open(url,"생일축하합니다!","width=500,height=500");
	}
});  */
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

<form id="frm" name="frm">
<input type="hidden" id="happyBTD" name="happyBTD" value="${happyBTD}">
</form>

<div class="w-container">
	<div data-delay="4000" data-animation="slide" data-autoplay="1"
		data-duration="500" data-infinite="1" class="slider-3 w-slider">
		<div class="w-slider-mask">
			<div class="slide-6 w-slide"></div>
			<div class="slide-8 w-slide"></div>
			<div class="slide-7 w-slide"></div>
		</div>
		<div class="w-slider-arrow-left">
			<div class="w-icon-slider-left"></div>
		</div>
		<div class="w-slider-arrow-right">
			<div class="w-icon-slider-right"></div>
		</div>
		<div class="w-slider-nav w-round"></div>
	</div>
	<br>
	<div>new arrivals<br>
	<table width="100%" style="border:solid 1px #FFF">
		<colgroup>
		<col width="50%"/>
		<col width="50%"/>
		</colgroup>
		<tr style="border:solid 1px #FFF">
			<c:set var="filenum" value="0"/>
			<c:forEach var="i" items="${nlist}" varStatus="status">
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
						x =350;
						y =(imgHeight*350)/imgWidth;
					} else {
						y =350;
						x =(imgWidth*350)/imgHeight;
					} 
				}
				%>
			<th class="mouse"><a href="/productDetail.do?pcode=${i.pcode }"><img src="/productImages/${i.mainfile }" style="cursur:pointer"width="<%=x %>" height="<%=y %>"/></a><br>${i.pname }<br><fmt:formatNumber value="${i.price}" type="number"/>원</th>
			<c:if test="${filenum==2}">
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
	</div>
</div>




