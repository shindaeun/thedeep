<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script>
$(function() {
	$("#btnSubmit").click(function() {
		if($("#name").val() == "") {
			alert("이름을 입력해 주세요");
			$("#name").focus();
			return;
		}
		if($("#title option:selected").val()=="") {
			alert("제목을 선택해 주세요");
			return;
		}
		if($("#pwd").val().length<4
				||$("#pwd").val().length>12) {
			alert("암호는4~12자리 사이로 입력해 주세요");
			$("#pwd").focus();
			return;
		}
		
		if(confirm("저장하시겠습니까?")) {
			// 비 동기 전송
			/* var formData = $("#frm").serialize(); */
			var form = new FormData(document.getElementById('frm'));

			$.ajax({
		  	   type: "POST",
		  	   data: form,
		 	    url: "/qnaWriteSave.do",
		 	    dataType: "json",
		 	    processData: false,
		 	    contentType: false,
		 	    
		 	    success: function(data) {
		    	      alert(data.result);
		     	     if(data.result == "ok") {
		    	           alert(data.cnt + "개의 파일을 저장하였습니다");
		    	           if(data.errCode == "-1") {
		    	        	   alert("첨부파일을 확인해 주세요\n\n [확장명 오류]");
		    	           } else if(data.errCode == "0"){
		    	        	   alert("첨부파일은 이미지 파일만 가능합니다");
		    	           } else if(data.errCode == "1") {
		    	        	   alert("첨부파일은 5M 미만이어야 합니다");
		    	           }
		      	         location.href = "<c:url value='/qnaList.do'/>";
		      	    } else {
		      	         alert("저장 실패했습니다. 다시 시도해 주세요");
		     	     }
		    	 },
		    	 error: function () {
		    	       alert("오류발생ㅠㅠ");
		     	}
			}); 
		}
	});
});
</script>

<table class="top">
	<tr class="top">
		<td class="top">Q&A</td>
	</tr>
</table>

<form id="frm">
<table class="board">
	<tr class="board">
		<th class="head">Name</th>
		<td style="text-align:left; padding:5px;">
		 <input type="text" id="name"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">Password</th>
		<td style="text-align:left; padding:5px;">
		 <input type="password" id="pwd" placeholder="암호 입력 (4~12자리)"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">Subject</th>
		<td style="text-align:left; padding:5px;">
		 <select name="title" id="title">
			<option value="">제목을 선택해 주세요</option>
		 	<option value="베송문의">배송문의</option>
		 	<option value="교환반품문의">교환/반품문의</option>
		 	<option value="상품문의">상품문의</option>
		 	<option value="기타문의">기타문의</option>
		 </select>
		</td>
	</tr>
	<tr class="board">
		<th class="head">Content</th>
		<td style="height:200px;">
		 <textarea name="content" id="content" style="width:98%;height:95%;"></textarea>
		</td>
	</tr>
	<tr class="board">
		<th class="head">첨부파일</th>
		<td style="text-align:left; padding:5px;">
		 <input type="file" name="file" size="70"/><br/>
		</td>
	</tr>
</table>
<table style="width:100%">
	<tr>
		<td style="text-align:center;">
		 <button type="button" id="btnSubmit" class="white">등록</button>
		 <button type="button" class="white" onclick="location.href='/qnaList.do'">취소</button>
		</td>
	</tr>
</table>
</form>