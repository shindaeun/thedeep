<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.io.File"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.awt.Image"%>
<%@page import="javax.swing.ImageIcon"%>
<%
String pageIndex2=request.getParameter("pageIndex2"); 
if(pageIndex2==null)pageIndex2="1";
if(Integer.parseInt(pageIndex2)<0)pageIndex2="1";

String pageIndex=request.getParameter("pageIndex"); 
if(pageIndex==null)pageIndex="1";
if(Integer.parseInt(pageIndex)<0)pageIndex="1";
%>
<c:set var="filename" value="${pvo.filename }" />
<%
	int x = 0, y = 0;
	String filename = (String) pageContext.getAttribute("filename");
	File file = new File(
			"C:/eGovFrameDev-3.7.0-64bit/workspace/thedeep/src/main/webapp/productImages/" + filename);
	if (!filename.equals(null) && !filename.equals("") && file.exists()) {
		BufferedImage img = ImageIO.read(file);
		int imgWidth = img.getWidth(null);
		int imgHeight = img.getHeight(null);

		if (imgWidth > imgHeight) {
			x = 300;
			y = (imgHeight * 300) / imgWidth;
		} else {
			y = 300;
			x = (imgWidth * 300) / imgHeight;
		}
	}
%>
<script language=javascript>
function disableCheck(obj) {
    if (obj[obj.selectedIndex].className=='disabled') {
        alert("다른 상품을 선택해주세요.");
        for (var i=0; obj[i].className=="disabled"; i++); obj.selectedIndex = i; return;
    }/* else if(){//상품목록에 추가되어 있으면../
    	alert($("#alloption"))
    	alert("이미 선택하셨습니다.");
    } */
   	else{
    	addOption($("#selectoption").val());
    	var demodiv = document.getElementById("alloption");
    	
    	if (demodiv.hasChildNodes()){
    		alert("a");
    		var children = demodiv.childNodes;
    	    for(var i=0; i<children.length; i++){
    	        alert("자식노드: " + children[i].getAttribute('id'));////////////?
    	    }
    	}
    	
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
function addOption(opt){
	var p = document.createElement('p');
	
	
	var text = document.createTextNode(opt);
	//alert(text.value);
	//p.id=text;
	$(p).attr("id",text);
	p.appendChild(text);
	var btn = document.createElement('span');
	p.innerHTML+='&nbsp;<input type="text" size="1" name="amount" id="amount" value="1">개&nbsp;';
/* 	p.innerHTML+='<button type="button" name="plus" onclick="fncnt('+',${status.count-1})"class="white">+</button>';
	p.innerHTML+='<button type="button" name="minus" onclick="fncnt('-',${status.count-1})"class="white">-</button>'; */
	p.innerHTML+='<button type="button" class="white" onClick="removeOption(this)">X</button>';
	
	document.getElementById("alloption").appendChild(p);
	
}
function removeOption(obj){
	document.getElementById("alloption").removeChild(obj.parentNode);
}
$("#btnBuy").click(function() {
	$("#frm").attr({method:'post',action:'/order.do'}).submit();

});
$("#btnCart").click(function() {
	$("#frm").attr({method:'post',action:'/addCart.do'}).submit();

});
</script>
<style type="text/css">
	option.disabled {color:lightgrey;}
</style>

<table class="board">
	<tr class="board">
		<td align="center" rowspan="8" width="50%"><img
			src="/productImages/${pvo.filename }"width="<%=x %>" height="<%=y %>" /></td>
		<td>상품명</td>
		<td>${pvo.pname }</td>
	</tr>
	<tr class="board">
		<td>가격</td>
		<td>${pvo.price }</td>
	</tr>
	<tr class="board">
		<td>적립금</td>
		<td>${pvo.point }</td>
	</tr>
	<tr class="board">
		<td>옵션</td>
		<td><select onchange="disableCheck(this)" id="selectoption">
				<option class=disabled>옵션을 선택해주세요.</option>
				<c:forEach var="i" items="${oplist }">
					<option value="${i.seloption }" <c:if test="${i.amount==0 }"> class=disabled</c:if>>${i.seloption }<c:if test="${i.amount==0 }"> 품절</c:if></option>
				</c:forEach>
		</select></td>
	</tr>
	<tr class="board">
		<td>FIT</td>
		<td>100</td>
	</tr>
	<tr class="board">
		<td colspan="2">표</td>
	</tr>
	<tr class="board">
		<td colspan="2"><button type="button" id="btnBuy"
				class="white">buy now</button></td>
	</tr>
	<tr class="board">
		<td colspan="2"><button type="button" id="btnCart"
				class="white">cart</button></td>
	</tr>
</table>
<form id="frm">
<table width="100%">
	<tr>
		<td>선택상품</td>
	</tr>
	<tr align="right">
		<td><div id="alloption"></div></td>
	</tr>
	
</table>
</form>

<table class="board">
	<tr>
		<td style="text-align: center">${vo.content}상품상세사진</td>
	</tr>
</table>

<table>
		<tr>
			<th>qna</th>
		</tr>
    </table>
<table class="line">
    	<tr class="line">
    		<td class="line">
    		</td>
    	</tr>
    </table>
<div>
	<table class="board">
		<tr class="board">
			<th style="width:10%;" >NO</th>
			<th width="50%" >SUBJECT</th>
			<th width="30%" >DATE</th>
			<th width="10%" >HIT</th>
		</tr>
		<c:forEach var="i" items="${qlist }" varStatus="status">
			<tr class="board" align="center">
				<td>${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}</td>
				<td><a href="/boardModify.do?unq=${i.unq}">${i.title}</a></td>
				<td>${i.rdate}</td>
				<td>${i.hit}</td>
			</tr>
		</c:forEach>
	</table>
</div>
<c:set var="pageIndex" value="<%=pageIndex %>"/>
		<c:set var="totalPage" value="${paginationInfo.getTotalPageCount() }"/>
		<table border="0" width="800">
				<tr>
					<td style="border: 0px; text-align: center">
						<div id="paging">
						<c:set var="a" value="${(pageIndex-1)/5-((pageIndex-1)/5%1)}" />
						<fmt:parseNumber var="a" integerOnly="true" value="${a}"/>
						<c:set var="start" value="${a*5+1}"/>
						<c:set var="last" value="${start+4}"/>
						
						<c:if test="${last>paginationInfo.getTotalPageCount() }">
							<c:set var="last" value="${paginationInfo.getTotalPageCount() }"/>
						</c:if>
						
						<fmt:parseNumber var="start2" integerOnly="true" value="${start-1}"/>
						<c:if test="${start2 >0}">
						<a href="/productDetail.do?pageIndex=${start2}&pcode=${pvo.pcode}">before</a>
						</c:if>
						
        				<c:forEach var="i" begin="${ start}" end="${last }">
        					<c:if test="${i ==pageIndex}"><span style="font-size:13px;color:red;">${i }</span></c:if>
        					<c:if test="${i !=pageIndex}">
        					<a href="/productDetail.do?pageIndex=${i}&pcode=${pvo.pcode}">${i}</a></c:if>
        				</c:forEach>
        				
        				<fmt:parseNumber var="last2" integerOnly="true" value="${last+1}"/>
        				<c:if test="${last2 <=paginationInfo.getTotalPageCount()}">
						<a href="/productDetail.do?pageIndex=${last2}&pcode=${pvo.pcode}">next</a>
						</c:if>
					</td>
				</tr>
			</table>
<br>
<br>
<br>
<table>
		<tr>
			<th>review</th>
		</tr>
    </table>
<table class="line">
    	<tr class="line">
    		<td class="line">
    		</td>
    	</tr>
    </table>
<div class="">
	<table class="board">
		<tr class="board">
			<th width="10%" >NO</th>
			<th width="50%" >SUBJECT</th>
			<th width="30%" >DATE</th>
			<th width="10%" >HIT</th>
		</tr>
		<c:forEach var="i" items="${rlist }" varStatus="status">
			<tr class="board" align="center">
				<td>${paginationInfo2.totalRecordCount+1 - ((searchVO.pageIndex2-1) * searchVO.pageSize + status.count)}</td>
				<td><a href="/boardModify.do?unq=${i.unq}">${i.title}</a></td>
				<td>${i.rdate}</td>
				<td>${i.hit}</td>
			</tr>
		</c:forEach>
	</table>
</div>
<br>
<c:set var="pageIndex2" value="<%=pageIndex2 %>"/>
		<c:set var="totalPage" value="${paginationInfo2.getTotalPageCount() }"/>
		<table border="0" width="800">
				<tr>
					<td style="border: 0px; text-align: center">
						<div id="paging">
						<c:set var="a" value="${(pageIndex2-1)/5-((pageIndex2-1)/5%1)}" />
						<fmt:parseNumber var="a" integerOnly="true" value="${a}"/>
						<c:set var="start" value="${a*5+1}"/>
						<c:set var="last" value="${start+4}"/>
						
						<c:if test="${last>paginationInfo2.getTotalPageCount() }">
							<c:set var="last" value="${paginationInfo2.getTotalPageCount() }"/>
						</c:if>
						
						<fmt:parseNumber var="start2" integerOnly="true" value="${start-1}"/>
						<c:if test="${start2 >0}">
						<a href="/productDetail.do?pageIndex2=${start2}&pcode=${pvo.pcode}">before</a>
						</c:if>
						
        				<c:forEach var="i" begin="${ start}" end="${last }">
        					<c:if test="${i ==pageIndex2}"><span style="font-size:13px;color:red;">${i }</span></c:if>
        					<c:if test="${i !=pageIndex2}">
        					<a href="/productDetail.do?pageIndex2=${i}&pcode=${pvo.pcode}">${i}</a></c:if>
        				</c:forEach>
        				
        				<fmt:parseNumber var="last2" integerOnly="true" value="${last+1}"/>
        				<c:if test="${last2 <=paginationInfo2.getTotalPageCount()}">
						<a href="/productDetail.do?pageIndex2=${last2 }&pcode=${pvo.pcode}">next</a>
						</c:if>
					</td>
				</tr>
			</table>
