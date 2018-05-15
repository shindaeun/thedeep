<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.io.File"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.awt.Image"%>
<%@page import="javax.swing.ImageIcon"%>

<script>

	$(function() {
		
		$( document ).ready(function() {
			//caltotal();
			var checkbox = $("input[name=ordercheck]:checked");
			var sum=0,point=0;
			checkbox.each(function(i) {
				var tr=checkbox.parent().parent().eq(i);
				var td=tr.children();
				sum=parseInt(sum)+parseInt(td.eq(6).children().text());
				point=parseInt(point)+parseInt(td.eq(7).children().text());
			});
			if(sum<50000 && sum!=0){
				document.getElementById("sum").innerHTML=sum;
				document.getElementById("deli").innerHTML="3000";
				document.getElementById("total").innerHTML=parseInt(sum)+parseInt(3000);
			}else{
				document.getElementById("sum").innerHTML=sum;
				document.getElementById("deli").innerHTML="0";
				document.getElementById("total").innerHTML=sum;
			}
			document.getElementById("point").innerHTML=point;

		});
		$("input[type=checkbox]").click(function() {
			var checkbox = $("input[name=ordercheck]:checked");
			var sum=0,point=0;
			checkbox.each(function(i) {
				var tr=checkbox.parent().parent().eq(i);
				var td=tr.children();
				sum=parseInt(sum)+parseInt(td.eq(6).children().text());
				point=parseInt(point)+parseInt(td.eq(7).children().text());
			});
			if(sum<50000 && sum!=0){
				document.getElementById("sum").innerHTML=sum;
				document.getElementById("deli").innerHTML="3000";
				document.getElementById("total").innerHTML=parseInt(sum)+parseInt(3000);
			}else{
				document.getElementById("sum").innerHTML=sum;
				document.getElementById("deli").innerHTML="0";
				document.getElementById("total").innerHTML=sum;
			}
			document.getElementById("point").innerHTML=point;
		});
		$("#btnBuy").click(function() {
			/*  var checkbox = $("input[name=ordercheck]:checked");
			checkbox.each(function(i) {
				var tr=checkbox.parent().parent().eq(i);
				var td=tr.children();
				alert(td.eq(1).text());
			});  */
			
			var bool=false;
			 var f=document.frm;
			var len=f.ordercheck.length;
			for(var i=0;i<len;i++){
				if(f.ordercheck[i].checked==true){
					bool=true;
				}
			}
			if(bool==true){
				var formData = $("#frm").serialize();//비 동기 전송
				$.ajax({
					type : "POST",
					data: formData,
					url : "/order.do",
					success : function(data) {
						if (data.result == "ok") {
							alert("성공");
							location.href = "/order.do";
						}
						else {
							alert("실패했습니다. 다시 시도해 주세요.");
						}
					},
					error: function (request,status,error) {
		            	  alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		              }
				});
				
			}else{
				alert("상품을 선택해주세요!");
			}
	
		});
		$("button[name=btnChange]").click(function() {
			var btn=$(this);
			var tr=btn.parent().parent();
			var td=tr.children();
			var cscode=td.eq(1).text();
			var amount=td.eq(8).children().val();
			var param = "cscode="+cscode+"&amount="+amount;
			$.ajax({
				type : "POST",
				data: param,
				url : "/cartUpdate.do",
				success : function(data) {
					if (data.result == "ok") {
						alert("변경하였습니다.");
						location.href = "/cart.do";
					}
					else {
						alert("변경 실패했습니다. 다시 시도해 주세요.");
					}
				},
				error: function (request,status,error) {
	            	  alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	              }
			});
		});
		$("button[name=btnDelete]").click(function() {
			var btn=$(this);
			var tr=btn.parent().parent();
			var td=tr.children();
			var cscode=td.eq(1).text();
			var param = "cscode="+cscode;
			$.ajax({
				type : "POST",
				data: param,
				url : "/cartDelete.do",
				success : function(data) {
					if (data.result == "ok") {
						alert("삭제하였습니다.");
						location.href = "/cart.do";
					}
					else {
						alert("삭제 실패했습니다. 다시 시도해 주세요.");
					}
				},
				error: function (request,status,error) {
	            	  alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	              }
			});
		});

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
	
 	
 	function fncnt(a,index){
 		if(a=="+" && document.frm.amount[index].value<10){
 			document.frm.amount[index].value++;
 		}
 		else if(a=="-" && document.frm.amount[index].value>1){
 			document.frm.amount[index].value--;
 		}
 		
 	}

</script>
<table class="top">
		<tr class="top">
			<td class="top">cart</td>
		</tr>
    </table>
<!--     <form name="frm" id="frm">
    
    <table width="100%">
		<tr>
			<td align="right"><input type="text" name="userid" value="userid1"checked/><button type="button" id="btnBuy"
					class="white">구매</button></td>
		</tr>
	</table>
    </form> -->
<form name="frm" id="frm">
	<input type="checkbox" name="checkall" value="checkall" onclick="checkAll()"checked/>전체선택
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
			<th width="5%" >개수</th>
			<th width="5%" >&nbsp;</th>
			<th width="5%" >삭제</th>
		</tr>
		<c:forEach var="i" items="${List }" varStatus="status">
			<tr class="board">
				<td><input type="checkbox" name="ordercheck" value="${i.cscode}" checked/>&nbsp;${i.pcode }</td>
				<td>${i.cscode}</td>
				<td>${i.pname}</td>
				<c:set var="pcode" value="${i.pcode }"/>
				<%
				int x=0,y=0;
				String filename = (String) pageContext.getAttribute("pcode");
				filename=filename + ".jpg";
				File file = new File("C:/eGovFrameDev-3.7.0-64bit/workspace/thedeep/src/main/webapp/productImages/" + filename);
				if(!filename.equals(null) &&!filename.equals("")&& file.exists()){
					BufferedImage img = ImageIO.read(file);
					int imgWidth = img.getWidth(null);
					int imgHeight = img.getHeight(null);
					
					if (imgWidth > imgHeight) {
						x =100;
						y =(imgHeight*100)/imgWidth;
					} else {
						y =100;
						x =(imgWidth*100)/imgHeight;
					} 
				}
				%>
				<td><img src="/productImages/${i.pcode }.jpg" width="<%=x %>" height="<%=y %>"/></td>
				<td>${i.cssize}</td>
				<td>${i.cscolor}</td>
				<td><span>${i.price}</span>원</td>
				<td><span>${i.savepoint}원</span></td>
				<td><input type="text" size="1" name="amount" id="amount" value="${i.amount}"></td>
				<td><button type="button" name="plus" onclick="fncnt('+',${status.count-1})"class="white">+</button>
				<button type="button" name="minus" onclick="fncnt('-',${status.count-1})"class="white">-</button>
				<button type="button" name="btnChange" class="white">변경</button></td>
				<td><button type="button" name="btnDelete" class="white">삭제</button></td>
			</tr>
		</c:forEach>
		<tr class="board" align="right">
			<td colspan="11">결제금액 <span id="sum">0</span>원 + 배송비 <span id="deli">0</span> 원 = <span id="total">0</span>원(적립금 <span id="point">0</span>원)</td>
		</tr>

	</table>
	<table width="100%">
		<tr>
			<td align="right"><button type="button" id="btnBuy"
					class="white">구매</button></td>
		</tr>
	</table>

</form>