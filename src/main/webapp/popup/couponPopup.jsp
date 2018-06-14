<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <link href="/css/board.css" rel="stylesheet" type="text/css">
    <link href="/css/product.css" rel="stylesheet" type="text/css">
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% String totalmoney = request.getParameter("totalmoney"); %>
<script src="/js/jquery-1.12.4.js"></script>
<script src="/js/jquery-ui.js"></script>
<script type="text/javascript">
function couponApply(cname) {
	
	var tr = $("#list").find("#" + cname).parent();
	var rate = tr.children().eq(3).text();
	rate = rate.substring(0,rate.length-1);
	var maxdiscmoney = tr.children().eq(2).text().replace(',','');
	var applymoney = tr.children().eq(1).text().replace(',','');
	
	 if(cname=="쿠폰선택"){
		document.getElementById("discountmoney").innerHTML ="";
		document.getElementById("discount").innerHTML ="";
	}
	 else{
		var money = parseInt(<%=totalmoney%>);
		if(money < applymoney) {
			alert("사용가능금액보다 적어서 적용 불가합니다.");return;
		}
		var disrate=parseInt(rate);
		var discount = Math.floor(money*disrate/100);
		if(discount > maxdiscmoney) {discount=maxdiscmoney};
		var discountMoney = money-discount;
		
		document.getElementById("discountmoney").innerHTML = numberWithCommas(discountMoney);
		document.getElementById("discount").innerHTML =numberWithCommas(discount);
	}
}
function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
$(function() {
	
	$("#btnCoupon").click(function() {
		opener.document.getElementById("usecouponresult").innerHTML=$("#discount").text();
		var cname = $("#selectcoupon option:selected").text();
		if(cname=="쿠폰선택"){
			alert("쿠폰을 선택해주세요");
		}else{
			
			opener.document.getElementById("usecoupon").value=cname;
			opener.totalcalcul();
			self.close();
		}
		
	});
	$("#btnClose").click(function() {
		self.close();
	});
});	

//드래그 | 오른쪽 마우스 | ctrl+c,v 방지
//기본동작 수행을 금지 Type1
function blockEvent(e){        
   console.log("blockEvent:"+e);
   if(e){ 
        e.preventDefault(); //DOM 레벨 2
   }else{             
        event.keyCode = 0;
        event.returnValue = false; //IE
   }
}

//기본동작 수행을 금지 Type2
function _stopEvent(e) {
  if (window.event) { //IE            
      window.event.cancelBubble = true; //전파 방지
      window.event.returnValue = false; //기본 동작 수행방지
  }
  //DOM 레벨 2
  if (e && e.stopPropagation && e.preventDefault) {
      e.stopPropagation(); //이벤트 전파 중지
      e.preventDefault(); //기본 동작 수행방지
  }
}

//이벤트 등록을 처리해주는 함수 (크로스 브라우징)
function _addEvent(element, eventType, handler) {       
  if (window.addEventListener) {
      element.addEventListener(eventType, handler, false)
  } else {
      if (window.attachEvent) { //IE8이하 버전에서
          element.attachEvent("on" + eventType, handler)
      }
  }
}

//마우스 드래그, 오른쪽 팝업메뉴, 선택 막기
function _addBlockEvent() {
  _addEvent(document, "dragstart", _stopEvent); //마우스 드래그  방지
  _addEvent(document, "selectstart", _stopEvent); //마우스 선택 방지
  _addEvent(document, "contextmenu", _stopEvent); //마우스 오른쪽 클릭 시 팝업메뉴 막기
  if (document.body && document.body.style.MozUserSelect != undefined) { 
      document.body.style.MozUserSelect = "none" //파이어폭스에서 마우스 선택 방지
  }
}


//특정키 사용을 방지
//이 함수는 복사, 붙여넣기의 단축키인 ctrl+c, ctrl+v 키를 막음
document.onkeydown = function(e){

  var code = document.all ? event.keyCode : e.keyCode;
  var ctrl = document.all ? event.ctrlKey : e.ctrlKey;

  if (ctrl && (code==86 || code==67)) {
      blockEvent(e);
  }
}

//JavaScript 오른쪽 마우스 사용금지 함수 (IE용)

function clickIE4(){
  //console.log("e:"+event+"event.button="+event.button);
  //event.button == 0 : 마우스 왼쪽 버튼
  //event.button == 1 : 마우스 가운데 버튼(휠버튼)
  //event.button == 2 : 마우스 오른쪽 버튼

  if (event.button==2 ){
      event.keyCode = 0;
         event.returnValue = false; //IE

      //alert("오른쪽 마우스 사용을 허용하지 않습니다.");
      //blockEvent();
      
      return false;
  }    
}

//JavaScript 오른쪽 마우스 사용금지 함수 
function clickNS4(e){

  if (document.layers||document.getElementById&&!document.all){
      if (e.which==2||e.which==3){
          blockEvent(e);
          return false;
      }
  }
}

//JavaScript 오른쪽 마우스 사용금지 함수 (크로스 브라우징 처리)
function rightbutton(e)
{
  if (navigator.appName == 'Netscape' &&  (e.which == 3 || e.which == 2))
      return false;
  else if (navigator.appName == 'Microsoft Internet Explorer' 
                              && (event.button == 2 || event.button == 3))
  {
      alert("오른쪽 마우스 사용을 허용하지 않습니다.");
      return false;
  }
  return true;
}


//마우스 드래그, 오른쪽 팝업메뉴, 선택 막기 함수 실행.
_addBlockEvent();


//document.oncontextmenu=new Function("return false")
//document.oncontextmenu= function(e) { _stopEvent(e); };
//document.onmousedown=_stopEvent;

//-->

function processKey() {
	if((event.ctrlKey == true && (event.keyCode==78 || event.keyCode==82)) || 
			(event.keyCode>=112 && event.keyCode<=123) || event.keyCode ==8) {
		event.keyCode=0;
		event.cancelBubble = true;
		event.returnValue = false;
	}
}
document.onkeydown = processKey;
</script>
<div>
<table class="top">
		<tr class="top">
			<td class="top">보유 쿠폰 내역</td>
		</tr>
    </table>

<table class="board" id="list">
		<tr class="board">
			<th width="20%" >쿠폰이름</th>
			<th width="20%" >사용가능금액</th>
			<th width="20%" >최대할인액</th>
			<th width="10%" >할인율</th>
			<th width="30%" >사용기간</th>
		</tr>
		<c:forEach var="i" items="${clist }">
			<tr class="board" align="center">
				<td id="${ i.cname}">
				${i.cname}</td>
				<td><fmt:formatNumber value="${i.applymoney}" type="number"/></td>
				<td><fmt:formatNumber value="${i.maxdiscmoney}" type="number"/></td>
				<td>${i.discountrate}%</td>
				<td>${i.sdate}~${i.edate}</td>
			</tr>
		</c:forEach>
	</table>
	<table class="board">
		<tr class="board">
			<th width="30%" >쿠폰</th>
			<th width="20%" >총 금액</th>
			<th width="20%" >할인액</th>
			<th width="30%">결제금액</th>
		</tr>
		<tr class="board" align="center">
			<td>
			<select name="selectcoupon" id="selectcoupon" onchange="couponApply(this.value)">
				<option value="쿠폰선택">쿠폰선택</option>
				<c:forEach var="i" items="${clist }">
					<option value="${i.cname }">${i.cname }</option>
				</c:forEach>
			</select>
			</td>
			<td><fmt:formatNumber value="<%=totalmoney %>" type="number"/></td>
			<td><span id= "discount"></span></td>
			<td><span id= "discountmoney"></span></td>
		</tr>
	</table>
	<div align="center">
	<button type="button" id="btnCoupon" class="white">적용</button>&nbsp;
	<button type="button" id="btnClose" class="white">취소</button>
	</div>
</div>
<br>