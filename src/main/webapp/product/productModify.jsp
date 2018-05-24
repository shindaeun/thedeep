<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.io.File" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="java.awt.Image" %>
<%@ page import="javax.swing.ImageIcon" %>

<script>
$(function(){
	$("#btnModify").click(function(){
		location.href="/productModifySave.do";
	});
	$("#btnDelete").click(function(){
		location.href="/productDelete.do";
	});
	$("#btnList").click(function(){
		location.href="/productListView.do";
	});
	
});
function fnaction() {
	var mainfile = document.frm.mainfile.value;
	var pcode = document.frm.pcode.value;

	var param = "mainfile="+mainfile+"&pcode="+pcode;
	$.ajax({
		type : "POST",
		data : param,
		url : "/productFileDelete.do",
		success: function(data) {
			if(data.result == "1") {
				alert("삭제하였습니다.");
			    var head = document.getElementById('btnDel');
				head.innerHTML ="<input type='file' name='file1' size='70' />";
			} else {
				alert("삭제 실패했습니다. 다시 시도해 주세요.");
			}
		},
		error: function () {
			alert("오류발생 ");
		}
	});		
}

function addBox() {
	var color = eval("$('#putcolor').val()");
	var txt = "&nbsp;&nbsp;<input type='checkbox' name='color' id='color' value='"+color+"'>"+color;
		txt += "<input type='button' value='X' onClick='removeBox(this)'>";
	var area = document.createElement('span');
	area.innerHTML = txt;
	document.getElementById('textBoxArea').appendChild(area);
}
function removeBox(obj) {
	document.getElementById('textBoxArea').removeChild(obj.parentNode);
}
</script>
<table class="top">
		<tr class="top">
			<td class="top">상품수정</td>
		</tr>
    </table>
    
<form name="frm" id="frm" method="post" enctype="multipart/form-data">
<input type="hidden" id="mainfile" name="mainfile" value="${vo.mainfile}">
<input type="hidden" id="pcode" name="pcode" value="${vo.pcode}">
<table class="board">

	<tr class="board">
		<th class="head" width="20%">상품명</th>
		<td>
		<input type="text" name="pname" id="pname" value="${vo.pname}" style="width:98%;"/>
		</td>
	</tr>

<c:set var="mainfile" value="${vo.mainfile}"></c:set>

<%
int x=0,y=0;
String mainfile = (String)pageContext.getAttribute("mainfile");
if(mainfile != null && !mainfile.equals("")) {
	File file = new File("C:/eGovFrameDev-3.7.0-64bit/workspace/thedeep/src/main/webapp/productImages/"+mainfile);
	BufferedImage img = ImageIO.read(file);
	int imgWidth = img.getWidth(null);
	int imgHeight = img.getHeight(null);
	if(imgWidth > imgHeight) {
		x = 100;
		y = (imgHeight * x) / imgWidth;
	} else if(imgWidth < imgHeight) {
		y = 100;
		x = (imgWidth * y) / imgHeight;
	} else {
		x=100;
		y=100;
	}

}
/*
 // 1024(넓이)/768(높이)
 // 1024:768 = 100:y
 // int y = 768 * 100 / 1024
 // int y = (imgHeight * 100) / imgWidth
*/
%>
	<tr class="board">
		<th class="head" width="20%">메인사진</th>
		<td>
		<span id="btnDel">
				<img src="/productImages/<%=mainfile%>" width="<%=x%>" height="<%=y%>"><%=mainfile%>&nbsp;
				<button type="button" value="mainfile" onclick="fnaction()" class="white">x</button>
		</span><br/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">상품상세설명</th>
		<td style="height:150px;">
		<textarea name="content" id="content" style="width:98%;height:95%;"></textarea>
		</td>
	</tr>
	<tr class="board">
		<th class="head" width="20%">상품가격</th>
		<td>
		<input type="text" name="price" id="price" value="${vo.price}" style="width:98%;"/>
		</td>
	</tr>
	
	<tr class="board">
		<th class="head">사이즈</th>
		<td>
		<input type="checkbox" name="psize" id="psize" value="S">
		S &nbsp;&nbsp; 
		<input type="checkbox" name="psize" id="psize" value="M">
		M &nbsp;&nbsp;
		<input type="checkbox" name="psize" id="psize" value="L">
		L &nbsp;&nbsp; 
		<input type="checkbox" name="psize" id="psize" value="F">
		Free 
		</td>
	</tr>
	
	<tr class="board">
		<th class="head">컬러</th>
		<td>
		<input type="text" id="putcolor" name="putcolor">
		<button type="button" onclick="addBox()">+</button>
		<span id="textBoxArea" style="text-align:left;"></span>
		</td>
	</tr>
	
	<tr class="board">
		<th class="head">상품분류</th>
		<td>
		<c:forEach var="i" items="${group}" varStatus="status">
			<input type="radio" name="gcode" id="gcode" value="${i.gcode}" <c:if test="${vo.gcode==i.gcode}">checked</c:if>/>${i.gname}&nbsp;&nbsp;
		</c:forEach>
	
		</td>
	</tr>
	<tr class="board">
		<th class="head">wait 여부</th>
		<td>
			<input type="radio" name="wait" id="wait" value="Y" <c:if test="${vo.wait=='Y'}">checked</c:if>/>wait&nbsp;&nbsp;
			<input type="radio" name="wait" id="wait" value="N" <c:if test="${vo.wait=='N'}">checked</c:if>/>show&nbsp;&nbsp;
		</td>
	</tr>
	<tr class="board">
		<th class="head">품절 여부</th>
		<td>
			<input type="radio" name="soldout" id="soldout" value="Y" <c:if test="${vo.soldout=='Y'}">checked</c:if>/>품절&nbsp;&nbsp;
			<input type="radio" name="soldout" id="soldout" value="N" <c:if test="${vo.soldout=='N'}">checked</c:if>/>판매&nbsp;&nbsp;
		</td>
	</tr>
</table>
</form>

<table border="0" style="width:100%;">
	<tr style="text-align:center">
		<th colspan="2" style="text-align:center">
		<button type="button" id="btnModify" class="white">수정</button>
		&nbsp;
		<button type="button" id="btnDelete" class="white">삭제</button>
		&nbsp;
		<button type="button" id="btnList" class="white">취소</button>
		</th>
	</tr>
</table>