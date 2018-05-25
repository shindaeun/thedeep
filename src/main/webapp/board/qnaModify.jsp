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
function fnaction(a) {
	var unq = document.frm.unq.value;
	var filename = document.frm.filename.value;
	var test = eval("document.frm.rfilename"+a+".value");
	var delfilename = test;
	alert(filename);
	alert(delfilename);

	var param = "filename="+filename+"&delfilename="+delfilename+",&unq="+unq;
	alert(param);
	$.ajax({
		type : "POST",
		data : param,
		url : "/qnaFileDelete.do",
		success: function(data) {
			if(data.result == "1") {
				alert("삭제하였습니다.");
			    var head = document.getElementsByName('btnDel');
				head[a].innerHTML ="<input type='file' name='file"+a+"' size='70' />";
			  } else {
				alert("삭제 실패했습니다. 다시 시도해 주세요.");
			}
		},
		error: function () {
			alert("오류발생 ");
		}
	}); 
		
}

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
	 		//var formData = $("#frm").serialize();
	 		var form = new FormData(document.getElementById('frm'));
	 		// 비 동기 전송
			$.ajax({
				type: "POST",
				data: form,
				url: "/qnaModifySave.do",
				dataType: "json",
				processData: false,
				contentType: false, 
				
				success: function(data) {
					if(data.result == "ok") {
						alert("수정하였습니다.");
						if(data.errCode == "-1") {
							alert("첨부파일을 확인해주세요. [확장명 오류]");
						} else if(data.errCode == "0") {
							alert("첨부파일 확인, 이미지 파일만 가능합니다.");
						} else if(data.errCode == "1") {
							alert("첨부파일은 5M 미만이어야 합니다.");
						}
						location.href = "<c:url value='/qnaList.do'/>";
					} else {
						alert("저장 실패했습니다. 다시 시도해 주세요.");
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

<form form name="frm" id="frm" method="post" enctype="multipart/form-data">
<input type="hidden" name="unq" id="unq" value="${vo.unq}" />
<input type="hidden" name="filename" id="filename" value="${vo.filename}" />

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
		 <select name="title" id="title">
			<option value="">제목을 선택해 주세요</option>
		 	<option value="배송문의" <c:if test="${vo.title=='배송문의'}">selected</c:if>>배송문의</option>
		 	<option value="교환반품문의" <c:if test="${vo.title=='교환반품문의'}">selected</c:if>>교환/반품문의</option>
		 	<option value="상품문의" <c:if test="${vo.title=='상품문의'}">selected</c:if>>상품문의</option>
		 	<option value="기타문의" <c:if test="${vo.title=='기타문의'}">selected</c:if>>기타문의</option>
		 </select>
		</td>
	</tr>
	<tr class="board">
		<th class="head">Content</th>
		<td style="height:200px;text-align:left; padding:5px;">
		 <textarea id="content" name="content" rows="8" cols="102" style="resize: none;">${vo.content}</textarea>
		</td>
	</tr>
	
<c:set var="filenames" value="${vo.filename}"></c:set>

<%
int x=0,y=0,i=0,j=0;
String[] rfilename={};
String filenames = (String)pageContext.getAttribute("filenames");
if(filenames != null && !filenames.equals("")) {
	rfilename= filenames.split(",");
	for(i=0; i<rfilename.length; i++) {
		File file = new File("C:/Users/acorn/workspace/thedeep/src/main/webapp/qnaImages/"+rfilename[i]);
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

}
/*
 // 1024(넓이)/768(높이)
 // 1024:768 = 100:y
 // int y = 768 * 100 / 1024
 // int y = (imgHeight * 100) / imgWidth
*/
%>

	<tr class="board">
        <th class="head">file</th>
        <td style="text-align:left; padding:5px" >
        	<%
			if(rfilename != null && !rfilename.equals("")) {
				for(i=0; i<rfilename.length; i++) {
				%>
					<span name="btnDel">
					<img src="/qnaImages/<%=rfilename[i]%>" width="<%=x%>" height="<%=y%>"><%=rfilename[i]%>&nbsp;
					<button type="button" id="rfilename<%=i%>" name="rfilename<%=i%>" value="<%=rfilename[i]%>" onclick="fnaction('<%=i%>')" class="white">x</button>
					</span><br/>
				<%
				}
				for(j=i; j<3; j++) {
				%>
					<input type="file" name="file<%=j%>" size="70"/><br/>
				<%
				}
        	}
			%>
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