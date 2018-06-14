<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>

<%@ page import="java.io.File" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="java.awt.Image" %>
<%@ page import="javax.swing.ImageIcon" %>

<script>
$(function(){
	$("#btnList").click(function() {
		location.href="/adminBoard.do";
	});
	$("#btnModify").click(function() {
		if(    $("#pwd").val().length < 4 
				|| $("#pwd").val().length > 12 )
			{
				alert("암호를 입력해주세요 (4~12자)");
				$("#pwd").focus();
				return;
			}
 		var formData = $("#frm").serialize();
 		// 비 동기 전송
		$.ajax({
			type: "POST",
			data: formData,
			url: "/qnaRePwdChk.do",
			success: function(data) {
				if(data.result == "ok") {
					location.href="/qnaReModify.do";
					var form = document.frm;
					form.method = "post";
					form.action = "/qnaReModify.do";
					form.submit();
				} else {
					alert("패스워드가 일치하지 않습니다.");	
				}
			},
			error: function () {
				alert("오류발생 ");
			}
		}); 	
	});
	$("#btnDelete").click(function(){
		if(    $("#pwd").val().length < 4 
			|| $("#pwd").val().length > 12 )
		{
			alert("암호를 입력해주세요 (4~12자)");
			$("#pwd").focus();
			return;
		}
		if(confirm("삭제하시겠습니까?")) {		
	 		var formData = $("#frm").serialize();
	 		// 비 동기 전송
			$.ajax({
				type: "POST",
				data: formData,
				url: "/qnaReDelete.do",
				success: function(data) {
					if(data.result == "ok") {
						alert("삭제하였습니다.");
						location.href = "/adminBoard.do";
					} else if(data.result == "1"){
						alert("패스워드가 일치하지 않습니다.");	
					} else {
						alert("삭제에 실패했습니다.");
					}
				},
				error: function () {
					alert("오류발생 ");
				}
			}); 
		}
	});
});
</script>

<table class="top">
	<tr class="top">
		<td class="top">Q&A</td>
	</tr>
</table>

<form name="frm" id="frm">
<input type="hidden" id="unq" name="unq" value="${vo.unq}"/>
<table class="board">
	<tr class="board">
		<th style="height:20%; width:20%;" class="head">title</th>
		<td style="text-align:left; padding:5px;">
		${vo.title}
		</td>
	</tr>
	<tr class="board">
		<th class="head" >name</th>
		<td style="text-align:left; padding:5px;">
		${vo.name}
		</td>
	</tr>
	<c:set var="filenames" value="${vo.filename}"></c:set>

<%
int x=0,y=0,i=0;
String[] filename={};
String filenames = (String)pageContext.getAttribute("filenames");
if(filenames != null && !filenames.equals("")) {
	filename= filenames.split(",");
	for(i=0; i<filename.length; i++) {
		File file = new File("C:/eGovFrameDev-3.7.0-64bit/workspace/thedeep/src/main/webapp/qnaImages/"+filename[i]);
		BufferedImage img = ImageIO.read(file);
		int imgWidth = img.getWidth(null);
		int imgHeight = img.getHeight(null);
		if(imgWidth > imgHeight) {
			x = 400;
			y = (imgHeight * x) / imgWidth;
		} else if(imgWidth < imgHeight) {
			y = 400;
			x = (imgWidth * y) / imgHeight;
		} else {
			x=400;
			y=400;
		}
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
		<th class="head">content</th>
		<td style="text-align:left;height:150px">
		<% 
      	pageContext.setAttribute("newLine","\n"); //Space, Enter
      	pageContext.setAttribute("br", "<br/>"); //br 태그
		%> 
		<div style="width:600x; word-break:break-all;">
		${fn:replace(vo.content,newLine,br)}
		</div>
	</tr>
	<c:if test="${login==1}">
	<tr class="board">
		<th class="head">password</th>
		<td style="text-align:left; padding:5px;">
		 <input type="password" id="pwd" name="pwd" placeholder="관리자ID 비밀번호 입력"/>
		</td>
	</tr>
	</c:if>
</table>
<table style="width:100%">
	<tr>
		<th style="width:90%">
		<button type="button" id="btnList" class="white">목록</button>&nbsp;
		<c:if test="${login==1}">
		<button type="button" id="btnModify" class="white">수정</button>&nbsp;
		<button type="button" id="btnDelete" class="white">삭제</button>
		</c:if>
		</th>
	</tr>
</table>
</form>