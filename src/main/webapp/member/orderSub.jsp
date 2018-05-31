<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<c:set var="post" value="${post}" />
<%
String po = (String)pageContext.getAttribute("post");
	if(po !=null){
		String[] post = po.split("/");
		pageContext.setAttribute("postnum", post[0]);
		pageContext.setAttribute("arr1", post[1]);
		pageContext.setAttribute("arr2", post[2]);
	}
	
%>

<script>
$( document ).ready(function() {
    console.log( "ready!" );
    var IMP = window.IMP; // 생략가능
    IMP.init('imp73069548'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
});
$(function() {
	IMP.request_pay({
	    pg : 'html5_inicis', // version 1.1.0부터 지원.
	    pay_method : 'card',
	    merchant_uid : $("#ocode").val(),
	    name : '주문명:결제테스트',
	    amount : $("#totalmoney").val(),
	    buyer_email : $("#oemail").val(),
	    buyer_name : $("#name").val(),
	    buyer_tel : $("#phone").val(),
	    buyer_addr : $("#arr1").val() + $("#arr2").val(),
	    buyer_postcode : $("#postnum").val()
	}, function(rsp) {
	    if ( rsp.success ) {
	        var msg = '결제가 완료되었습니다.';
	        msg += '고유ID : ' + rsp.imp_uid;
	        msg += '상점 거래ID : ' + rsp.merchant_uid;
	        msg += '결제 금액 : ' + rsp.paid_amount;
	        msg += '카드 승인번호 : ' + rsp.apply_num;
	        msg += 'pay_method : ' + rsp.pay_method;
	        alert(msg);
	        location.href = "/orderComplete.do?ocode="+$("#ocode").val()+"&paymethod=신용카드";
	    } else {
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	        alert(msg);
	    }
    
    
	});
});
</script>
<body>
<form name="frm" id="frm">
	<input type="hidden" name="ocode" id="ocode" value="${ocode}"/>
	<input type="hidden" name="oemail" id="oemail" value="${oemail}"/>
	<input type="hidden" name="totalmoney" id="totalmoney" value="${totalmoney}" />
	<input type="hidden" name="postnum" id="postnum" value="${postnum}"/>
	<input type="hidden" name="arr1" id="arr1" value="${arr1}"/> 
	<input type="hidden" name="arr2" id="arr2" value="${arr2}"/>
	<input type="hidden" name="phone" id="dphone" value="${phone}"/>
	<input type="hidden" name="name" id="name" value="${name}"/>
</form>
</body>
</html>