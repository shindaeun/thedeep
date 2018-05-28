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
$(function() {
	$("#btnModify").click(function(){
		if($("#title").val() == "") {
			alert("제목을 입력해주세요.");
			$("#title").focus();
			return;
		}
		if($("#content").val() == "") {
			alert("내용을 입력해주세요.");
			$("#content").focus();
			return;
		}
		if(confirm("수정하시겠습니까?")) {		
	 		var formData = $("#frm").serialize();
			$.ajax({
				type: "POST",
				data: formData,
				url: "/qnaReModifySave.do",

				success: function(data) {
					if(data.result == "ok") {
						alert("수정하였습니다.");
						location.href = "/qnaList.do";
					} else {
						alert("수정 실패했습니다. 다시 시도해 주세요.");
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
<input type="hidden" name="unq" id="unq" value="${vo.unq}" />
<table class="board">
	<tr class="board">
		<th class="head" style="height:30px; width:20%;">Name</th>
		<td style="text-align:left; padding:5px;">
		 ${vo.name}
		</td>
	</tr>
	<tr class="board">
		<th class="head">Subject</th>
		<td style="text-align:left; padding:5px;">
		 ${vo.title}
		</td>
	</tr>
	<tr class="board">
		<th class="head">Content</th>
		<td style="height:200px;text-align:left; padding:5px;">
		 <textarea id="content" name="content" rows="8" cols="102" style="resize: none;">${vo.content}</textarea>
		</td>
	</tr>
</table>
<table style="width:100%;">
	<tr>
		<td colspan="2" style="text-align:center;">
		 <button type="button" id="btnModify" class="white">등록</button>
		 <button type="button" class="white" onclick="location.href='/qnaList.do'">취소</button>
		</td>
	</tr>
</table>
</form>