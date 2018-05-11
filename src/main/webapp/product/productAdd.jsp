<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
$(function(){
	$("#btnSubmit").click(function(){
		location.href="/productAddSave.do";
	});
	$("#btnList").click(function(){
		location.href="/productListView.do";
	});
	
});
</script>
<table class="top">
		<tr class="top">
			<td class="top">상품등록</td>
		</tr>
    </table>
<table class="board">

	<tr class="board">
		<th class="head" width="20%">상품명</th>
		<td>
		<input type="text" name="pname" id="pname" style="width:98%;"/>
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
		<input type="checkbox" name="color" id="color" value="blue">
		blue &nbsp;&nbsp; 
		<input type="checkbox" name="color" id="color" value="red">
		red &nbsp;&nbsp;
		<input type="checkbox" name="color" id="color" value="black">
		black &nbsp;&nbsp;
		<input type="checkbox" name="color" id="color" value="ivory">
		ivory &nbsp;&nbsp; 
		<input type="checkbox" name="color" id="color" value="white">
		white
		</td>
	</tr>
	
	<tr class="board">
		<th class="head">상품분류</th>
		<td>
		<c:set var="num" value="0"/>
		<c:forEach var="result" items="${group}" varStatus="status">
			<input type="radio" name="gcode" id="gcode" value="<c:set var=\"num\" value=\"${num+1}\"/>">${result.gname}&nbsp;&nbsp;
		</c:forEach>
	
		</td>
	</tr>
	<tr class="board">
		<th class="head">wait 여부</th>
		<td>
			<input type="radio" name="wait" id="wait" value="Y">wait&nbsp;&nbsp;
			<input type="radio" name="wait" id="wait" value="N">show&nbsp;&nbsp;
		</td>
	</tr>
	
	
</table>

<table border="0" style="width:100%;">
	<tr style="text-align:center">
		<th colspan="2" style="text-align:center">
		<button type="button" id="btnSubmit" class="white">저장</button>
		&nbsp;
		<button type="button" id="btnList" class="white">취소</button>
		</th>
	</tr>
</table>