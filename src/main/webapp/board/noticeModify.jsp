<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
$(function(){
	$("#btnModify").click(function(){
		location.href="";
	});
	$("#btnList").click(function(){
		location.href="/noticeList.do";
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
		<th class="head" width="20%">글쓴이</th>
		<td>
		<input type="text" name="adminid" id="adminid" value="${vo.name}" style="width:98%;"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">암호</th>
		<td>
		<input type="text" name="pwd" id="pwd" style="width:98%;"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">제목</th>
		<td>
		<input type="text" name="title" id="title" value="${vo.title}" style="width:98%;"/>
		</td>
	</tr>
	
	<tr class="board">
		<th class="head">내용</th>
		<td style="height:150px;">
		<textarea name="content" id="content" style="width:98%;height:95%;">${vo.content}</textarea>
		</td>
	</tr>
	<tr class="board">
        <th class="head">파일</th>
        <td style="text-align:left">
        	<input type="file" name="file1" size="70" /><br/>
        </td>
	</tr>
</table>

<table border="0" style="width:100%;">
	<tr style="text-align:center">
		<th colspan="2" style="text-align:center">
		<button type="button" id="btnModify" class="white">수정</button>
		&nbsp;
		<button type="button" id="btnList" class="white">취소</button>
		</th>
	</tr>
</table>