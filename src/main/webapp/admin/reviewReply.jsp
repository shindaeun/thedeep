<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
	$(function() {
		$("#btnSave").click(function() {
			location.href = "/noticeList.do";
		});
		$("#btnModify").click(function() {
			location.href = "";
		});
	});
</script>
<table class="top">
		<tr class="top">
			<td class="top">review 답글등록</td>
		</tr>
    </table>
<table class="board">
	<tr class="board">
		<th class="head" width="20%">이름</th>
		<td>홍수정</td>
	</tr>
	<tr class="board">
		<th class="head">제목</th>
		<td>너무예뻐요</td>
	</tr>
	<tr class="board">
		<th class="head">사이즈</th>
		<td> 키 : 몸무게 : 사이즈 :
		</td>
	</tr>
	<tr class="board">
		<th class="head">사이즈 정도</th>
		<td>보통
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
<table>
	<tr>
		<td>
			<button type="button" id="btnSave" class="white">목록</button><br><br>
		</td>
	</tr>
	<tr valign="center">
	<td><textarea rows="2" cols="100" style="resize: none;"></textarea>
			<button type="button" id="btnModify" class="white">등록</button></td>
	</tr>
	<tr><td>
		관리자A<br>
	
	리뷰 감사합니다.
	적립금 지급되었습니다.
	더욱 만족을 드리도록 노력하겠습니다.
		</td>
	</tr>
</table>