<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
$(function(){
	$("#btnSubmit").click(function(){
		location.href="/productAddSave.do";
	});
	$("#btnList").click(function(){
		location.href="/productListView.do";
	});
	
});
function addBox() {
	var color = eval("$('#color').val()");
	alert(color);
	var txt = "&nbsp;&nbsp;<input type='checkbox' name='color' id='color' value='"+color+"'>"+color;
	var area = document.createElement('span');
	area.innerHTML = txt;
	document.getElementById('textBoxArea').appendChild(area);
	//eval("$('#color').val('')");
}
</script>
<table class="top">
		<tr class="top">
			<td class="top">상품등록</td>
		</tr>
    </table>
<form name="frm" id="frm" method="post" enctype="multipart/form-data">
<table class="board">

	<tr class="board">
		<th class="head" width="20%">상품명</th>
		<td>
		<input type="text" name="pname" id="pname" style="width:98%;"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head" width="20%">메인사진</th>
		<td>
		<input type="file" name="file1" size="70" /><br/>
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
		<input type="text" name="price" id="price" style="width:98%;"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">사이즈</th>
		<td>
		<input type="checkbox" name="size" id="size" value="S">
		S &nbsp;&nbsp; 
		<input type="checkbox" name="size" id="size" value="M">
		M &nbsp;&nbsp;
		<input type="checkbox" name="size" id="size" value="L">
		L &nbsp;&nbsp; 
		<input type="checkbox" name="size" id="size" value="free">
		free 
		</td>
	</tr>
	
	<tr class="board">
		<th class="head">컬러</th>
		<td>
		<input type="text" id="color" name="color">
		<button type="button" onclick="addBox()">+</button>
		<span id="textBoxArea" style="text-align:left;"></span>
		</td>
	</tr>
	
	<tr class="board">
		<th class="head">상품분류</th>
		<td>
		<c:forEach var="i" items="${group}" varStatus="status">
			<input type="radio" name="gcode" id="gcode" value="${i.gcode}">${i.gname}&nbsp;&nbsp;
		</c:forEach>
		</td>
	</tr>
	
	<tr class="board">
		<th class="head">wait</th>
		<td>
			<input type="radio" name="wait" id="wait" value="Y">상품대기&nbsp;&nbsp;
			<input type="radio" name="wait" id="wait" value="N">상품업로드&nbsp;&nbsp;
		</td>
	</tr>
	
	<tr class="board">
		<th class="head">sold out</th>
		<td>
			<input type="radio" name="soldout" id="soldout" value="Y">품절&nbsp;&nbsp;
			<input type="radio" name="soldout" id="soldout" value="N">판매&nbsp;&nbsp;
		</td>
	</tr>
</table>
</form>

<table border="0" style="width:100%;">
	<tr style="text-align:center">
		<th colspan="2" style="text-align:center">
		<button type="button" id="btnSubmit" class="white">저장</button>
		&nbsp;
		<button type="button" id="btnList" class="white">취소</button>
		</th>
	</tr>
</table>