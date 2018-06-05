<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<br>
<br>
<br>
<div style="text-align:center">
	<h4>주문이 정상적으로 완료되었습니다.</h4><br>

		주문번호 : ${ovo.ocode}<br>
		주문일자 : ${ovo.odate}<br>
		주문목록 : ${olist}<br>
		주문금액 : ${ovo.totalmoney}원<br>
		결제방법 : ${ovo.paymethod}<br><br>


	빠른 발송을 위해 힘쓰겠습니다.<br> 저희 쇼핑몰을 이용해주셔서 감사합니다.<br>
</div>