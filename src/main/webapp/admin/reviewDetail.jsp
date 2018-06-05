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
	$("#btnNext").click(function(){
		var nex = ${vo.nexInt};
		if(nex == 0) {
			alert("마지막 페이지 입니다.");
		} else {
			location.href="/reviewDetailAdmin.do?unq=${vo.nexInt}";
		}
	});
	$("#btnBefore").click(function(){ 
		var bef = ${vo.befInt};
		if( bef == 0) {
			alert("마지막 페이지 입니다.");
		} else {
			location.href="/reviewDetailAdmin.do?unq=${vo.befInt}";
		}
	});
	$("#btnList").click(function(){
		location.href="/adminBoard.do";
	});
	$("#btnSubmit").click(function(){
		$("#content").val($("#admin").val()+"\n\n" +$("#reply").val());
		var form = $("#rform").serialize();
		$.ajax({
			type : "POST",
			data: form,
			url : "/reviewReply.do",
			success : function(data) {
				if (data.result == "ok") {
					alert("저장하였습니다.");
					location.href = "/reviewDetailAdmin.do?unq=${vo.unq}";
				}
				else {
					alert("저장 실패했습니다. 다시 시도해 주세요.");
				}
			},
			error: function (request,status,error) {
            	  alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
              }
		});
		
	});
});
function fnDelete(unq){
	var param = "unq="+unq;
	$.ajax({
		type : "POST",
		data: param,
		url : "/reviewReplyDelete.do",
		success : function(data) {
			if (data.result == "ok") {
				alert("삭제하였습니다.");
				location.href = "/reviewDetailAdmin.do?unq=${vo.unq}";
			}
			else {
				alert("삭제 실패했습니다. 다시 시도해 주세요.");
			}
		},
		error: function (request,status,error) {
        	  alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
          }
	});
	
}
</script>
<table class="top">
		<tr class="top">
			<td class="top">review</td>
		</tr>
    </table>
<div style="width:100%;padding:5px;text-align:right">

		<button type="button" id="btnBefore">이전</button>
		&nbsp;
		<button type="button" id="btnNext">다음</button>
</div>
<table class="board">

	<tr class="board">
		<th class="head" width="20%">name</th>
		<td style="text-align:left">
		${vo.name}
		</td>
	</tr>
	
	<tr class="board">
		<th class="head">subject</th>
		<td style="text-align:left">
		${vo.title}
		</td>
	</tr>
	<tr class="board">
		<th class="head">size</th>
		<td>키:${vo.height}cm
		&nbsp;&nbsp;
		몸무게:${vo.weight}kg
		&nbsp;&nbsp; 
		사이즈:${vo.psize}
		</td>
	</tr>
	
	<tr class="board">
		<th class="head">fit</th>
		<td>
		<c:if test="${vo.fit=='VB'}">매우큼</c:if>
		<c:if test="${vo.fit=='B'}">큼</c:if>
		<c:if test="${vo.fit=='F'}">딱맞음</c:if>
		<c:if test="${vo.fit=='S'}">작음</c:if>
		<c:if test="${vo.fit=='VS'}">매우작음</c:if>
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
		File file = new File("C:/eGovFrameDev-3.7.0-64bit/workspace/thedeep/src/main/webapp/reviewImages/"+filename[i]);
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
		if(filenames != null && !filenames.equals("")) {
			for(i=0; i<filename.length; i++) {
		%>
		<img src="/reviewImages/<%=filename[i]%>" width="<%=x%>" height="<%=y%>"><br>
		<%
			}
		}
		%>
		<br>
		<% 
      	pageContext.setAttribute("newLine","\n"); //Space, Enter
      	pageContext.setAttribute("br", "<br/>"); //br 태그
		%> 
		${fn:replace(vo.content,newLine,br)}
		</td>
	</tr>
	
</table>

<table border="0" style="width:100%;">
	<tr style="text-align:center">
		<th style="text-align:center">
		<button type="button" id="btnList" class="white">목록</button>
		</th>
	</tr>
	<tr><td>
	<c:forEach var="i" items="${rlist}" varStatus="status">
			<tr class="board">
				<td>${fn:replace(i.content,newLine,br)}<br><br>
					<button type="button" class="white" onclick="fnDelete(${i.unq})">삭제</button>
				</td>
			</tr>
	</c:forEach>
	</td></tr>
</table>
<br>
<c:if test="${sessionScope.ThedeepALoginCert.ThedeepAUserId != null}">
<form id="rform">
<table style="width:100%;"> 
<tr valign="center">
	<td>
		<input type="hidden" name="content" id="content"/>
		<input type="hidden" id="fid" name="fid" value="${vo.unq }">
		이름<input type="text" id="admin"/>
	</td>
	</tr>
	<tr>
	<td>
	<textarea rows="2" id="reply" cols="80%" style="resize: none;"></textarea>
	<button type="button" id="btnSubmit" class="white" >등록</button>
	</td>
	</tr>
</table>
</form>
</c:if>