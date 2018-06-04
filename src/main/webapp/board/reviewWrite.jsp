<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>

<link rel="stylesheet" type="text/css" href="/css/main.css"/>
<script src="/js/jquery-1.12.4.js"></script>
<script src="/js/jquery-ui.js"></script>

<%
	String pcode = request.getParameter("pcode");
	String ocode = request.getParameter("ocode");
%>
<script>
	$(function(){
		$("#btnSubmit").click(function(){
			if($("#name").val() == "") {
				alert("이름을 입력해주세요.");
				$("#name").focus();
				return;
			}
			if($("#pwd").val().length < 4 || $("#pwd").val().length > 12 )
			{
				alert("암호는 4~12자리 사이로 입력해주세요.");
				$("#pwd").focus();
				return;
			}
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
			
			if(confirm("저장하시겠습니까?")) {		
		 		//var formData = $("#frm").serialize();
		 		var form = new FormData(document.getElementById('frm'));
		 		// 비 동기 전송
				$.ajax({
					type: "POST",
					data: form,
					url: "/reviewWriteSave.do",
					dataType: "json",
					processData: false,
					contentType: false, 
					
					success: function(data) {
						if(data.result == "ok") {
							alert("저장하였습니다.\n\n("+data.cnt+")개의 파일 저장");
							if(data.errCode == "-1") {
								alert("첨부파일을 확인해주세요. 확장명 오류");
							} else if(data.errCode == "0") {
								alert("첨부파일 확인, 이미지 파일만 가능합니다.");
							} else if(data.errCode == "1") {
								alert("첨부파일은 5M 미만이어야 합니다.");
							}
							location.href = "<c:url value='/reviewList.do'/>";
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
	$("#btnList").click(function(){
		location.href="/reviewList.do";
	});
	
});
</script>
<table class="top">
		<tr class="top">
			<td class="top">review</td>
		</tr>
    </table>
    
<form name="frm" id="frm" method="post" enctype="multipart/form-data">
<input type="hidden" id="pcode" name="pcode" value="<%=pcode%>">
<input type="hidden" id="ocode" name="ocode" value="<%=ocode%>">
<table class="board">

	<tr class="board">
		<th class="head" width="20%">name</th>
		<td>
		<input type="text" name="name" id="name" style="width:98%;" value="${name}"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">password</th>
		<td>
		<input type="password" name="pwd" id="pwd" style="width:98%;" placeholder="암호 입력 (4~12자리)"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">subject</th>
		<td>
		<input type="text" name="title" id="title" style="width:98%;"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">size</th>
		<td style="text-align:center">키 : 
		<select name="height" id="height">
			<option value="140-145">140-145cm</option>
			<option value="145-150">145-150cm</option>
			<option value="150-155">150-155cm</option>
			<option value="155-160">155-160cm</option>
			<option value="160-165">160-165cm</option>
			<option value="165-170">165-170cm</option>
			<option value="170-175">170-175cm</option>
		</select>
		&nbsp;&nbsp;몸무게 :
		<select name="weight" id="weight">
			<option value="40-45">40-45kg</option>
			<option value="45-50">45-50kg</option>
			<option value="50-55">50-55kg</option>
			<option value="55-60">55-60kg</option>
			<option value="60-65">60-65kg</option>
			<option value="65-70">65-70kg</option>
			<option value="70-75">70-75kg</option>
			<option value="75-80">75-80kg</option>
		</select>
		&nbsp;&nbsp;사이즈 :
		<select name="psize" id="psize">
			<option value="S">S</option>
			<option value="M">M</option>
			<option value="L">L</option>
			<option value="F">free</option>
		</select>
		</td>
	</tr>
	
	<tr class="board">
		<th class="head">fit</th>
		<td style="text-align:center">
		<input type="radio" name="fit" id="fit" value="VB"/>
		매우큼 &nbsp;&nbsp; 
		<input type="radio" name="fit" id="fit" value="B"/>
		큼 &nbsp;&nbsp;
		<input type="radio" name="fit" id="fit" value="F" checked/>
		딱맞음 &nbsp;&nbsp; 
		<input type="radio" name="fit" id="fit" value="S"/>
		작음 &nbsp;&nbsp; 
		<input type="radio" name="fit" id="fit" value="VS"/>
		매우작음 
		</td>
	</tr>
	
	<tr class="board">
		<th class="head">content</th>
		<td style="height:150px;">
		<textarea id="content" name="content" rows="8" cols="102" style="resize: none;"></textarea>
		</td>
	</tr>
	<tr class="board">
        <th class="head">file</th>
        <td style="text-align:left; padding:5px" >
        	<input type="file" name="file1" size="70" /><br/>
        	<input type="file" name="file2" size="70" /><br/>
        	<input type="file" name="file3" size="70" />
        </td>
	</tr>
</table>

<table border="0" style="width:100%;">
	<tr style="text-align:center">
		<th colspan="2" style="text-align:center">
		<button type="button" id="btnSubmit" class="white">등록</button>
		&nbsp;
		<button type="button" id="btnList" class="white">취소</button>
		</th>
	</tr>
</table>
</form>