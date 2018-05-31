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
	<table class="board">
		<colgroup>
		<col width="33%"/>
		<col width="33%"/>
		<col width="33%"/>
		</colgroup>
		<tr class="board">
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
	
	<table border="3">
		<tr>
			<th>TOTAL&nbsp;&nbsp;:&nbsp;${total}명</th>
		</tr>
		
		<tr>
			<th>TODAY&nbsp;:&nbsp;${today}명</th>
		</tr>
	</table>
	
	<table>
		<c:forEach var="i" items="${visitorlist}">
		<tr height= "40px" width="100%">
			<td>${i.rdate}</td><td><span style="width: ${i.hit/10.0}px; height: 20px; background: skyblue; float: left;"></span>${i.hit}</td>
		</tr>
		</c:forEach>
		
	</table>
	
	
	</div>
</div>




