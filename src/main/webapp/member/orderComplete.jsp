<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<br>
<br>
<br>
<div>
	<h4>주문이 정상적으로 완료되었습니다.</h4>
	<table>
		<tr>
			<td>주문번호 : ${result.name}</td>
		</tr>
		<tr>
			<td>주문일자 : ${result.rdate}</td>
		</tr>
		<tr>
			<td>주문목록 : ${result.hit}</td>
		</tr>
		<tr>
			<td>주문금액 : ${result.name}</td>
		</tr>
		<tr>
			<td>결제방법 : ${result.name}</td>
		</tr>
	</table>
	빠른 발송을 위해 힘쓰겠습니다.<br> 저희 쇼핑몰을 이용해주셔서 감사합니다.<br>
</div>