<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.io.File"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.awt.Image"%>
<%@page import="javax.swing.ImageIcon"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>

	$(function() {
		
		$( document ).ready(function() {
			//caltotal();
			var checkbox = $("input[name=ordercheck]:checked");
			var sum=0,point=0;
			checkbox.each(function(i) {
				var tr=checkbox.parent().parent().eq(i);
				var td=tr.children();
				
				sum=parseInt(sum)+parseInt(td.eq(6).children().text().replace(',',''));
				point=parseInt(point)+parseInt(td.eq(7).children().text().replace(',',''));
			});
			if(sum<50000 && sum!=0){
				document.getElementById("sum").innerHTML=numberWithCommas(sum);
				document.getElementById("deli").innerHTML="3,000";
				document.getElementById("total").innerHTML=numberWithCommas(parseInt(sum)+parseInt(3000));
			}else{
				document.getElementById("sum").innerHTML=numberWithCommas(sum);
				document.getElementById("deli").innerHTML="0";
				document.getElementById("total").innerHTML=numberWithCommas(parseInt(sum)+parseInt(3000));
			}
			document.getElementById("point").innerHTML=numberWithCommas(point);

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
			$("#frm").attr({method:'post',action:'/order.do'}).submit();
			
	
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
	 var now_num = parseInt(document.getElementsByName("amount")[index].value);
	 var now_stock = parseInt(document.getElementsByName("stock")[index].value);
	 if(a=="+" && now_num<=now_stock){
		 if (now_num == now_stock) {
			 alert("재고량보다 많습니다. 재고량["+now_stock+"개]");
		} else if(now_num >=10){
			alert("10개 이상 구매 불가능합니다.");
		} else{
			document.getElementsByName("amount")[index].value++;
			var cscode=document.getElementsByName("ordercheck")[index].value;
			var amount=document.getElementsByName("amount")[index].value;
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
		}
	}
	else if(a=="-" && now_num>=1){
		if (now_num == 1) {
			alert("1개 이하 구매 불가능합니다.");
		} else {
			document.getElementsByName("amount")[index].value--;
			var cscode=document.getElementsByName("ordercheck")[index].value;
			var amount=document.getElementsByName("amount")[index].value;
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
		}
	}  
	
}
 	function numberWithCommas(x) {
 	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
 	}

</script> 

<table class="top">
		<tr class="top">
			<td class="top">cart</td>
		</tr>
    </table>

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
				<td style="text-align:center"><input type="checkbox" name="ordercheck" id="ordercheck"value="${i.cscode}" <c:if test="${i.amount>i.stock }">disabled</c:if><c:if test="${i.amount<=i.stock}">checked</c:if>/>&nbsp;${i.pcode }</td>
				<td style="text-align:center">${i.cscode}</td>
				<td style="text-align:center">${i.pname}<c:if test="${i.amount>i.stock }"> [ 품절 ] </c:if></td>
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
						x =100;
						y =(imgHeight*100)/imgWidth;
					} else {
						y =100;
						x =(imgWidth*100)/imgHeight;
					} 
				}
				%>
				<td style="text-align:center"><img src="/productImages/${i.mainfile }" width="<%=x %>" height="<%=y %>"/></td>
				<td style="text-align:center">${i.cssize}</td>
				<td style="text-align:center">${i.cscolor}</td>
				<td style="text-align:center"><span>${i.price}</span>원</td>
				<td style="text-align:center"><span>${i.savepoint}원</span></td>
				<td style="text-align:center"><input type="text" size="1" name="amount" id="amount" value="${i.amount}"readonly>
											<input type="hidden" name="stock" value="${i.stock}" disabled>	
				</td>
				<td style="text-align:center"><button type="button" name="plus" onclick="fncnt('+',${status.count-1})"class="white">+</button>
				<button type="button" name="minus" onclick="fncnt('-',${status.count-1})"class="white">-</button>
				<td style="text-align:center"><button type="button" name="btnDelete" class="white">삭제</button></td>
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