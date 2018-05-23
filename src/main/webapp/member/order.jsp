<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script>
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullAddr = ''; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                fullAddr = data.roadAddress;

            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                fullAddr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
            if(data.userSelectedType === 'R'){
                //법정동명이 있을 경우 추가한다.
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                // 건물명이 있을 경우 추가한다.
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('sample6_address').value = fullAddr;

            // 커서를 상세주소 필드로 이동한다.
            document.getElementById('sample6_address2').focus();
        }
    }).open();
}
	$(function() {
		$("#applypoint").click(function() {
			var use=$("#usepoint").val();
			var able=${vo.ablepoint};
			if(parseInt(use)==0||use==""){
				$("#usepoint").val("0");
				document.getElementById("usepointresult").innerHTML="0";
			}
			else if(use > able){
				alert("사용가능 금액보다 많습니다! 다시 시도해주세요.");
				$("#usepoint").val("0");
				document.getElementById("usepointresult").innerHTML="0";
				
			}else{
				document.getElementById("usepointresult").innerHTML=$("#applypoint").val();
				document.getElementById("usepointresult").innerHTML=use;
				alert("적용되었습니다.");
				calcul();
			} 
		});
			
		$("#btnCoupon").click(function() {
			var totalmoney=$("#money1").text();
			url="/couponPopup.do?totalmoney="+totalmoney;
			windowObj = window.open(url,"쿠폰리스트","width=700,height=300");

		});
		
		$("#same").click(function() {
			if($("#same").is(":checked")){
				$("#dname").val("${vo.name}");
				$("#phone4").val("011").prop("selected",true);
				$("#phone5").val($("#phone2").val());
				$("#phone6").val($("#phone3").val());
			}else{
				$("#dname").val("");
				$("#phone4").val("");
				$("#phone5").val("");
				$("#phone6").val("");
			}


		});
		$("#btnBuy").click(function() {
			
		});
		
	});
	function calcul(){
		var point=$("#usepointresult").text();
		totalcalcul();	
	}
	function totalcalcul(){
		var money = $("#money1").text();
		var point = $("#usepointresult").text();
		var coupon = $("#usecouponresult").text();
		$("#money2").text(money-point-coupon);
	}

</script>
<c:set var="phone" value="${vo.phone}"/>
<c:set var="email" value="${vo.email}"/>
<%
String ph = (String)pageContext.getAttribute("phone");
String[] phone = ph.split("-");
pageContext.setAttribute("phone1", phone[0]);
pageContext.setAttribute("phone2", phone[1]);
pageContext.setAttribute("phone3", phone[2]);

String em = (String)pageContext.getAttribute("email");
String[] email = em.split("@");
pageContext.setAttribute("email1", email[0]);
pageContext.setAttribute("email2", email[1]);
%>
<form name="couponForm" id="couponForm">
	<input type="hidden" name="beforemoney"  id="beforemoney"/>
</form>
<c:set var="sumprice" value="0"/>
<c:set var="sumpoint" value="0"/>
<c:set var="delprice" value="3000"/>
<div>
	<table class="board">
		<tr class="board">
			<th width="50%" >구입상품명</th>
			<th width="20%" >수량</th>
			<th width="15%">가격</th>
			<th width="15%" >적립</th>
		</tr>
		<c:forEach var="i" items="${olist }" varStatus="status">
		<c:set var="sumprice" value="${sumprice +i.price }"/>
		<c:set var="sumpoint" value="${sumpoint +i.savepoint }"/>
			<tr class="board" align="center">
				<td>${i.pname}</td>
				<td>${i.amount}</td>
				<td>${i.price}</td>
				<td>${i.savepoint}</td>
			</tr>
		</c:forEach>
		<c:if test="${sumprice > 50000 }">
			<c:set var="delprice" value="0"/>
		</c:if>
		<tr class="board" align="right">
			<td colspan="10">결제금액 ${sumprice }원 + 배송비 ${delprice } 원 = ${sumprice + delprice }원(적립금 ${sumpoint }원)</td>
		</tr>
	</table>
</div>
<br>
<h5>> 주문인 정보</h5>
<table class="board">
	<tr class="board">
		<th class="head" width="20%">주문하는 분</th>
		<td>${vo.name }</td>
	</tr>
	<tr class="board">
		<th class="head">전화번호</th>
		<td><select name="phone1" id="phone1" disabled>
				<option value="010"<c:if test="${phone1==010}">selected</c:if>>010</option>
				<option value="011"<c:if test="${phone1==011}">selected</c:if>>011</option>
		</select> -
		<input type="text" name="phone2" id="phone2" maxlength="4" style="width:10%; IME-MODE: disabled;"readonly value="${phone2}"/> -
		<input type="text" name="phone3" id="phone3" maxlength="4" style="width:10%; IME-MODE: disabled;"readonly value="${phone3}"/>
		</td>

	</tr>
	<tr class="board">
		<th class="head">이메일</th>
		<td><input type="text" readonly name="email1" id="email1" style="width:20%;" value="${email1}"/>
		@
		<select name="email2" id="email2" disabled>
			<option value="naver.com" <c:if test="${email2=='naver.com'}">selected</c:if>>naver.com</option>
			<option value="daum.net" <c:if test="${email2=='daum.net'}">selected</c:if>>daum.com</option>
			<option value="gmail.com" <c:if test="${email2=='gmail.com'}">selected</c:if>>gmail.com</option>
		</select></td>
	</tr>
</table>
<br>
<h5>> 수취인 정보</h5>
<table class="board">
	<tr class="board">
		<th class="head" width="20%">주문인 확인</th>
		<td><input type="checkbox" name="same" id="same"/>위 주문정보와 동일</td>
	</tr>
	<tr class="board">
		<th class="head" width="20%">받으시는 분</th>
		<td><input type="text" name="dname" id="dname"/></td>
	</tr>
	<tr class="board">
		<th class="head">전화번호</th>
		<td><select name="phone4" id="phone4">
				<option value="010">010</option>
				<option value="011">011</option>
		</select> -<input type="text" name="phone5" id="phone5" style="width: 50px;">
			-<input type="text" name="phone6" id="phone6" style="width: 50px;"></td>

	</tr>
	<tr class="board">
		<th class="head">주소</th>
		<td style="text-align: left; padding:5px;">
		<input type="text" id="sample6_postcode" placeholder="우편번호" style="width:30%; margin-top: 1%;" value="${postnum}"/>
		<button type="button" onclick="sample6_execDaumPostcode()"class="white"/>우편번호찾기</button><br/>
		<input type="text" id="sample6_address" placeholder="주소" style="width:70%; margin-top: 1%;"/><br/>
		<input type="text" id="sample6_address2" placeholder="상세주소" style="width:70%; margin-top: 1%; margin-bottom:1%;"/><br/>
		</td>
	</tr>
	<tr class="board">
		<th class="head" width="20%">주문 메세지</th>
		<td><textarea name="message" id="message" rows="3" cols="50" size="50" style="resize: none;"></textarea></td>
	</tr>
	<tr class="board">
		<th class="head" width="20%">무통장 임금자명</th>
		<td><input type="text" name="depositname" id="depositname"/>(주문자와 같은 경우 생략 가능)</td>
	</tr>
</table>
<h5>> 결제 정보</h5>
<table class="board">
	<tr class="board">
		<th class="head" width="20%">적립금 사용</th>
		<td>${vo.ablepoint }원 &nbsp; (사용 가능 적립금) <br><input
			type="text" name="usepoint" id="usepoint" value="0" style = "text-align:right;"/>원
			<button type="button" id="applypoint" class="white">적용</button></td>
	</tr>
	<tr class="board">
		<th class="head" width="20%">쿠폰 사용</th>
		<td><input type="text" id="cname" name="cname" readOnly /> &nbsp;
			<button type="button" id="btnCoupon" class="white">사용</button></td>
	</tr>
	<tr class="board" align="right">
			<td colspan="10">결제금액 <span id="money1">${sumprice + delprice }</span>원 - <span id="usecouponresult">0</span>원(쿠폰) - <span id="usepointresult">0</span>원(적립금) =<span id="money2">${sumprice + delprice }</span>(적립금 ${sumpoint }원)</td>
	</tr>
</table>
<table width="100%">
<tr>
<td align="right"><button type="button" id="btnBuy" class="white">구매</button></td>
</tr>
</table>
<br>