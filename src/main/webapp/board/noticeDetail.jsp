<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
$(function(){
	$("#btnList").click(function(){
		location.href="/noticeList.do";
	});
	$("#btnModify").click(function(){
		location.href="";
	});
	$("#btnDelete").click(function(){
		location.href="";
	});
});
</script>  

<table class="top">
		<tr class="top">
			<td class="top">notice</td>
		</tr>
    </table>
      
<table class="board">
	<tr class="board">
		<th class="head" width="20%">제목</th>
		<td>
		제목
		</td>
	</tr>
	<tr class="board">
		<th class="head">글쓴이</th>
		<td>
		글쓴이
		</td>
	</tr>
	<tr class="board">
		<th class="head">내용</th>
		<td>
		내용
		<%-- <%
      	pageContext.setAttribute("newLine","\n"); //Space, Enter
      	pageContext.setAttribute("br", "<br/>"); //br 태그
		%> 
		${fn:replace(vo.content,newLine,br)} --%>
		
		</td>
	</tr>
	
</table>
<table width="100%">
<tr>
		<th>
		<button type="button" id="btnList" class="white">목록</button>
		</th>
	</tr>
</table>