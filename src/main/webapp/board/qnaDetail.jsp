<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.io.File" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="java.awt.Image" %>
<%@ page import="javax.swing.ImageIcon" %>

<%
String unq = request.getParameter("unq");
%>

<script>
$(function(){
	$("#btnList").click(function() {
		location.href="/qnaList.do";
	});
	
	$("#btnModify").click(function() {
		location.href="/qnaModify.do?unq=<%=unq%>";
	});
	
	$("#btnDelete").click(function(){
		if(    $("#pwd").val().length < 4 
			|| $("#pwd").val().length > 12 )
		{
			alert("암호는 4~12자리 사이로 입력해주세요.");
			$("#pwd").focus();
			return;
		}
		if(confirm("삭제하시겠습니까?")) {		
	 		var formData = $("#frm").serialize();
	 		// 비 동기 전송
			$.ajax({
				type: "POST",
				data: formData,
				url: "/pnaDelete.do",
				success: function(data) {
					if(data.result == "1") {
						alert("삭제하였습니다.");
						location.href = "/panList.do";
					} else if(data.result == "0"){
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
	
	/* 답글은 관리자만 허용 */
	$("#btnReboard").click(function() { 
		location.href="/qnaReWrite.do?unq=<%=unq%>";
	}); 
});
</script>

<table class="top">
	<tr class="top">
		<td class="top">Q&A</td>
	</tr>
</table>

<form name="frm" id="frm">
<table class="board">
	<tr class="board">
		<th style="height:30px;" class="head">title</th>
		<td style="text-align:left; padding:5px;">
		${vo.title}
		</td>
	</tr>
	<tr class="board">
		<th class="head" style="height:30px;" >name</th>
		<td style="text-align:left; padding:5px;">
		${vo.name}
		</td>
	</tr>
	<tr class="board">
		<th class="head">content</th>
		<td style="text-align:left; padding:5px; height:200px;">
		<%
      	pageContext.setAttribute("newLine","\n"); //Space, Enter
      	pageContext.setAttribute("br", "<br/>"); //br 태그
		%> 
		${fn:replace(vo.content,newLine,br)}
		</td>
	</tr>
	<tr class="board">
		<th class="head">password</th>
		<td style="text-align:left; padding:5px;">
		 <input type="password" id="pwd"/>
		</td>
	</tr>
</table>
<table style="width:100%">
	<tr>
		<th style="width:90%">
		<button type="button" id="btnList" class="white">목록</button>&nbsp;
		<button type="button" id="btnModify" class="white">수정</button>&nbsp;
		<button type="button" id="btnDelete" class="white">삭제</button>
		</th>
		<td style="text-align:right; width:10%">
		<button type="button" id="btnReboard" class="white">답글</button>
		</td>
	</tr>
</table>
</form>