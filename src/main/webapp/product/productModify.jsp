<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</script>
<table class="top">
		<tr class="top">
			<td class="top">상품수정</td>
		</tr>
    </table>
<table class="board">

	<tr class="board">
		<th class="head" width="20%">상품명</th>
		<td>
		<input type="text" name="pname" id="pname" value="${vo.pname}" style="width:98%;"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">상품상세설명</th>
		<td style="height:150px;">
		<textarea name="content" id="content" style="width:98%;height:95%;">${vo.content}</textarea>
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
		<input type="checkbox" name="size" id="size" value="S" <c:if test="${vo.size=='S'}">checked</c:if>/>
		S &nbsp;&nbsp; 
		<input type="checkbox" name="size" id="size" value="M" <c:if test="${vo.size=='M'}">checked</c:if>/>
		M &nbsp;&nbsp;
		<input type="checkbox" name="size" id="size" value="L" <c:if test="${vo.size=='L'}">checked</c:if>/>
		L &nbsp;&nbsp; 
		<input type="checkbox" name="size" id="size" value="free"<c:if test="${vo.size=='free'}">checked</c:if>/>
		free 
		</td>
	</tr>
	
	<tr class="board">
		<th class="head">컬러</th>
		<td>
		<input type="checkbox" name="color" id="color" value="blue" <c:if test="${vo.size=='blue'}">checked</c:if>/>
		blue &nbsp;&nbsp; 
		<input type="checkbox" name="color" id="color" value="red" <c:if test="${vo.size=='red'}">checked</c:if>/>
		red &nbsp;&nbsp;
		<input type="checkbox" name="color" id="color" value="black" <c:if test="${vo.size=='black'}">checked</c:if>/>
		black &nbsp;&nbsp;
		<input type="checkbox" name="color" id="color" value="ivory" <c:if test="${vo.size=='ivory'}">checked</c:if>/>
		ivory &nbsp;&nbsp; 
		<input type="checkbox" name="color" id="color" value="white" <c:if test="${vo.size=='white'}">checked</c:if>/>
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