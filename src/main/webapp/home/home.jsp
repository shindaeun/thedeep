<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>

<script src="/js/jquery-1.12.4.js"></script>
<script src="/js/jquery-ui.js"></script>

<script>
$(function() {
	if($("#happyBTD").val()!="0") {
		var userid = $("#happyBTD").val();
		alert(userid + " 님! 생일 축하드립니다! 쿠폰을 발급해드렸으니 확인해 주세요!");
	}
});
</script>

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
	
	<div>new items</div>
</div>




