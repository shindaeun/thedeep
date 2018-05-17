<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.io.File"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.awt.Image"%>
<%@page import="javax.swing.ImageIcon"%>
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
	p.id=text;
	var text = document.createTextNode(opt);
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
		<td colspan="2"><button type="button" id="btnSearch1"
				class="white">buy now</button></td>
	</tr>
	<tr class="board">
		<td colspan="2"><button type="button" id="btnSearch1"
				class="white">cart</button></td>
	</tr>
</table>
<table width="100%">
	<tr>
		<td>선택상품</td>
	</tr>
	<tr align="right">
		<td><div id="alloption"></div></td>
	</tr>
	
</table>


<table class="board">
	<tr>
		<td style="text-align: center">${vo.content}상품상세사진</td>
	</tr>
</table>

<table>
	<tr>
		<th>review</th>
	</tr>
</table>
<table class="line">
	<tr class="line">
		<td class="line"></td>
	</tr>
</table>

<div class="">
	<table class="board">
		<tr class="board">
			<th width="10%">NO</th>
			<th width="40%">SUBJECT</th>
			<th width="20%">WRITER</th>
			<th width="20%">DATE</th>
			<th width="10%">HIT</th>
		</tr>
		<c:forEach var="result" items="${resultList }" varStatus="status">
			<tr class="board">
				<td>${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}</td>
				<td><a href="/boardModify.do?unq=${result.unq}">${result.title}</a></td>
				<td>${result.name}</td>
				<td>${result.rdate}</td>
				<td>${result.hit}</td>
			</tr>
		</c:forEach>
	</table>
</div>
<br>

<table>
	<tr>
		<th>qna</th>
	</tr>
</table>
<table class="line">
	<tr class="line">
		<td class="line"></td>
	</tr>
</table>

<div>
	<table class="board">
		<tr class="board">
			<th style="width: 10%;">NO</th>
			<th width="40%">SUBJECT</th>
			<th width="20%">WRITER</th>
			<th width="20%">DATE</th>
			<th width="10%">HIT</th>
		</tr>
		<c:forEach var="result" items="${resultList }" varStatus="status">
			<tr class="board">
				<td>${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}</td>
				<td><a href="/boardModify.do?unq=${result.unq}">${result.title}</a></td>
				<td>${result.name}</td>
				<td>${result.rdate}</td>
				<td>${result.hit}</td>
			</tr>
		</c:forEach>
	</table>
</div>
<br>