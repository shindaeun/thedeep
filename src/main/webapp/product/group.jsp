<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="/css/jquery-ui.css">
<script src="/js/jquery-1.12.4.js"></script>
<script src="/js/jquery-ui.js"></script>


<script>
$(function() {
	$("#btnSubmit").click(function() {
		if($("#gcode").val()=="") {
			alert("상품분류코드를 입력해주세요.");
			$("#gcode").focus();
			return;
		}
		if($("#gname").val()=="") {
			alert("상품분류명을 입력해주세요.");
			$("#gname").focus();
			return;
		}
		
		if(confirm("등록하시겠습니까?")) {
			var formData = $("#frm").serialize();//비 동기 전송

			$.ajax({
			     type: "POST",
			     data: formData,
			     url: "/groupSave.do",
			     success: function(data) {
			          if(data.result == "ok") {
			               alert("등록하였습니다.");
			               location.href = "<c:url value="/group.do"/>";
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
	$("#btnModify").click(function() {
		if($("#gname").val()=="") {
			alert("상품분류명을 입력해주세요.");
			$("#gname").focus();
			return;
		}
		
		if(confirm("수정하시겠습니까?")) {
			var formData = $("#frm").serialize();//비 동기 전송

			$.ajax({
			     type: "POST",
			     data: formData,
			     url: "/groupModify.do",
			     success: function(data) {
			          if(data.result == "1") {
			               alert("수정하였습니다.");
			               location.href = "<c:url value="/group.do"/>";
			          } else {
			               alert("수정 실패했습니다. 다시 시도해 주세요.");
			          }
			     },
			     error: function(request,status,error) {
					 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			}); 
		}
	});
});
	function fnDelete(gcode) {
		if(confirm("삭제하시겠습니까?")) {		
	 		
	 		var param = "gcode="+gcode;
	 		
			$.ajax({
				type: "get",
				data: param,
				url: "/groupDelete.do",
				dataType: "json",
				processData: false,
				contentType: false, 
				
				success: function(data) {
					if(data.result == "1") {
						alert("삭제하였습니다.");
						location.href="/group.do";
					} else {
						alert("삭제 실패하였습니다. 다시 시도해 주세요.");
					}
						
				},
				error: function () {
					alert("오류발생 ");
				}
			}); 
		}
}

</script>

<table class="top">
   <tr class="top">
      <td class="top">상품분류조회</td>
   </tr>
</table>



<!-- 본문의 시작 -->
<form id="frm" name="frm">
<table class="board">
<c:if test="${group.gcode == null}">
	<tr class="board">
		<th width="33%">상품분류코드</th>
		<th width="33%">상품분류명</th>
		<th width="33%">등록/수정</th>
	</tr>
	<tr class="board">
		<th width="33%"><input type="text" name="gcode" id="gcode" style="width:50%;"></th>
		<th width="33%"><input type="text" name="gname" id="gname" style="width:50%;"></th>
		<th width="33%"><button type="button" id="btnSubmit" class="white">등록</button></th>
	</tr>
	</c:if>
	
	<c:if test="${group.gcode != null}">
	<tr class="board">
		<th width="33%">상품분류코드</th>
		<th width="33%">상품분류명</th>
		<th width="33%">등록/수정</th>
	</tr>
	<tr class="board">
	<input type="hidden" name="gcode" id="gcode" value="${group.gcode}">
		<th width="33%">${group.gcode}</th>
		<th width="33%"><input type="text" name="gname" id="gname" style="width:50%;" value="${group.gname}"></th>
		<th width="33%"><button type="button" id="btnModify" class="white">수정</button></th>
	</tr>
	</c:if>
</table>
</form>
<br>
<c:set var="total" value="1"/>
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
		<th width="25%"><a href="javascript:fnDelete('${result.gcode}')" class="white">[del]</a></th>
	</tr>
	<c:set var="total" value="${total+1}"/>
</c:forEach>


<!-- 본문의 끝 -->

</table>
