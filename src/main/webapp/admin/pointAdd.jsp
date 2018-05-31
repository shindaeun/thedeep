<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="/css/jquery-ui.css">
<script src="/js/jquery-1.12.4.js"></script>
<script src="/js/jquery-ui.js"></script>


<script>
$(function() {
	$("#btnSubmit").click(function() {
		if($("#userid").val()=="") {
			alert("아이디를 입력해주세요.");
			$("#userid").focus();
			return;
		}
		if($("#content").val()=="") {
			alert("내용을 입력해주세요.");
			$("#content").focus();
			return;
		}
		
		if(confirm("등록하시겠습니까?")) {
			var formData = $("#frm").serialize();//비 동기 전송

			$.ajax({
			     type: "POST",
			     data: formData,
			     url: "/pointAddSave.do",
			     success: function(data) {
			          if(data.result == "ok") {
			               alert("등록하였습니다.");
			               location.href = "<c:url value="/pointAdd.do"/>";
			          } else {
			               alert("등록 실패했습니다. 다시 시도해 주세요.");
			          }
			     },
			     error: function(request,status,error) {
					 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			}); 
		}
	});

</script>

<table class="top">
   <tr class="top">
      <td class="top">포인트적립</td>
   </tr>
</table>

<form id="frm" name="frm">
<table class="board">
	<tr class="board">
		<th width="25%">아이디</th>
		<th width="25%">내용</th>
		<th width="25%">적립금</th>
		<th width="25%">등록</th>
	</tr>
	<tr class="board">
		<th width="25%"><input type="text" name="userid" id="userid" style="width:50%;"></th>
		<th width="25%"><select name="content" id="content">
			<option value="리뷰">리뷰</option>
			<option value="환불">환불</option>
			<option value="취소">취소</option>
			<option value="배송지연">배송지연</option>
			<option value="기타">기타</option>
		</select></th>
		<th width="25%"><input type="text" name="savepoint" id="savepoint" style="width:50%;"></th>
		<th width="25%"><button type="button" id="btnSubmit" class="white">등록</button></th>
	</tr>
</table>
</form>
<br>
<%-- <c:set var="total" value="1"/>
<table class="board">
<tr class="board">
		<th width="25%">번호</th>
		<th width="25%">상품분류코드</th>
		<th width="25%">상품분류명</th>
		<th width="25%">삭제</th>
	</tr>
<c:forEach var="result" items="${resultList}" varStatus="status">
	<tr class="board">
		<th width="25%">${total}</th>
		<th width="25%"><a href="/group.do?gcode=${result.gcode}">${result.gcode}</a></th>
		<th width="25%">${result.gname}</th>
		<th width="25%"><a href="javascript:fnDelete('${result.gcode}')" class="white">&nbsp;del&nbsp;</a></th>
	</tr>
	<c:set var="total" value="${total+1}"/>
</c:forEach>
</table> --%>
