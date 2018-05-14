<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="/js/jquery-1.12.4.js"></script>
<script src="js/jquery-ui.js"></script>
<script>
	$(function() {
		$("#btnBuy").click(function() {
			var bool=false;
			var f=document.frm;
			var len=f.ordercheck.length;
			for(var i=0;i<len;i++){
				if(f.ordercheck[i].checked==true){
					location.href = "/order.do"; return;
				}
			}
			alert("상품을 선택해주세요!"); 
		});
		$("button[name=btnChange]").click(function() {
			var tr=$(this);
			var td=tr.children();
			alert(tr.text());
			alert(td.eq(0).text());
			alert("qqq"); 
		});
	/* 	$("#btnChange").click(function() {
			var form = new FormData(document.getElementById('frm'));
			$.ajax({
				type : "POST",
				data : form,
				url : "/adminLogin.do",
				dataType : "json",
				processData : false,
				contentType : false,

				success : function(data) {
					if (data.result == "ok") {
						alert("로그인하였습니다.");
						location.href = "/ammList.do";
					
					}else if(data.result == "-1"){
						alert("패스워드 불일치! 다시 시도해 주세요.");
					}
					else {
						alert("로그인 실패했습니다. 다시 시도해 주세요.");
					}
				},
				error: function (request,status,error) {
	            	  alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

	                    //alert("오류발생 ");
	              }
			});
		});
		*/

	}); 
	
	function checkAll(){
			var f=document.frm;
			var len=f.ordercheck.length;
			var bool=false;
			if(f.checkall.checked==true){
				bool=true;
			}
			for(var i=0;i<len;i++){
				f.ordercheck[i].checked=bool;
			}	
	}
 	function caltotal(){
		var f=document.frm;
		var len=f.ordercheck.length;
		var sum=0;
		
		for(var i=0;i<len;i++){
			if(f.ordercheck[i].checked==true){
				sum=parseInt(sum)+parseInt(f.ordercheck[i].value);
			}
		}
		if(sum<50000 && sum!=0){
			document.getElementById("sum").innerHTML=sum;
			document.getElementById("deli").innerHTML="3000";
			document.getElementById("total").innerHTML=parseInt(sum)+parseInt(3000);
		}else{
			document.getElementById("sum").innerHTML=sum;
			document.getElementById("deli").innerHTML="0";
			document.getElementById("total").innerHTML=sum;
		}
		document.getElementById("point").innerHTML=Math.floor(eval("0.001*sum"));
	} 
 	function fncnt(a,index){
 		if(a=="+" && document.frm.cnt[index].value<10){
 			document.frm.cnt[index].value++;
 		}
 		else if(a=="-" && document.frm.cnt[index].value>1){
 			document.frm.cnt[index].value--;
 		}
 		
 	}
/*  	 function fnChange(cscode){
		//alert(num);
		alert("a");
		alert(cscode);
		//alert(cscode);

	}  */
</script>
<table class="top">
		<tr class="top">
			<td class="top">cart</td>
		</tr>
    </table>
<form name="frm">
	<input type="checkbox" name="checkall" value="checkall" onclick="checkAll();caltotal();"/>전체선택
	<table class="board">
		<tr class="board">
			<th width="10%" >상품코드</th>
			<th width="20%" >품목코드</th>
			<th width="15%" >상품명</th>
			<th width="15%" >상품상세</th>
			<th width="5%" >사이즈</th>
			<th width="5%" >컬러</th>
			<th width="10%" >가격</th>
			<th width="5%" >적립금</th>
			<th width="10%" >개수</th>
			<th width="5%" >삭제</th>
		</tr>
		<c:forEach var="i" items="${List }" varStatus="status">
			<tr class="board">
				<td><input type="checkbox" name="ordercheck" value="${i.price}" onclick="caltotal();"/>&nbsp;${i.pcode }</td>
				<td>${i.cscode}</td>
				<td>${i.pname}</td>
				<td>사진</td>
				<td>${i.cssize}</td>
				<td>${i.cscolor}</td>
				<td>${i.price}원</td>
				<td>${i.savepoint}원</td>
				<td><input type="text" size="1" name="cnt" value="${i.amount}">
				<input type="button" name="plus" value="+" onclick="fncnt('+',${status.count-1})">
				<input type="button" name="minus" value="-" onclick="fncnt('-',${status.count-1})">
				<button type="button" name="btnChange" class="white" onclick="fnChange(${i.cscode })">변경</button></td>
				<td>del</td>
			</tr>
		</c:forEach>
		<tr class="board" align="right">
			<td colspan="10">결제금액 <span id="sum">0</span>원 + 배송비 <span id="deli">0</span> 원 = <span id="total">0</span>원(적립금 <span id="point">0</span>원)</td>
		</tr>

	</table>
	<table width="100%">
		<tr>
			<td align="right"><button type="button" id="btnBuy"
					class="white">구매</button></td>
		</tr>
	</table>

</form>