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
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="./resources/editor/js/HuskyEZCreator.js" charset="utf-8"></script>

<script>
$(function(){
	//전역변수
    var obj = [];              
    //스마트에디터 프레임생성
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: obj,
        elPlaceHolder: "editor",
        sSkinURI: "./resources/editor/SmartEditor2Skin.html",
        htParams : {
            // 툴바 사용 여부
            bUseToolbar : true,            
            // 입력창 크기 조절바 사용 여부
            bUseVerticalResizer : true,    
            // 모드 탭(Editor | HTML | TEXT) 사용 여부
            bUseModeChanger : true,
        }
    });
	$("#btnSubmit").click(function(){
		if($("#pname").val() == "") {
			alert("상품명을 입력해주세요.");
			$("#pname").focus();
			return;
		}
		if(document.getElementById('file1').value=="") {
			alert("메인사진을 입력해주세요.");
			return;
		}
		if($("#price").val() == "") {
			alert("가격을 입력해주세요.");
			$("#price").focus();
			return;
		}
		if ($("input#psize:checked").length < 1) {
		   alert("사이즈를 한개 이상 체크주십시오");
		   return false;
		}
		if ($("input#color:checked").length < 1) {
		   alert("색상을 한개 이상 체크주십시오");
		   return false;
		}
		if ($("input#gcode:checked").length < 1) {
		   alert("상품분류를 체크주십시오");
		   return false;
		}
		
		if(confirm("저장하시겠습니까?")) {		
	 		//var formData = $("#frm").serialize();
	 		var form = new FormData(document.getElementById('frm'));
	 		
	 		// 비 동기 전송
			$.ajax({
				type: "POST",
				data: form,
				url: "/productAddSave.do",
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
						document.frm2.pcode.value = data.pcode;
						var pcode= document.frm2.pcode.value
						//alert(pcode);
						
						obj.getById["editor"].exec("UPDATE_CONTENTS_FIELD", []);
						var test = document.getElementById("editor").value;
						//alert(test);
					    var editor= $('#editor').val();
						//alert(editor);
						$.ajax({
								url : '/updateSmartEditor.do',
								type : 'post',
								datatype : 'json',
								data :{
									 "editor" : editor
								   , "pcode" : pcode
								},
								
								success : function(data){
								}
						});
						
						location.href = "<c:url value='/productListView.do'/>";
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
		location.href="/productListView.do";
	});
	
});

function addBox() {
	var color = eval("$('#putcolor').val()");
	
	if(color=="" || color==null) {
		alert("색상을 입력해주세요");
	} else {
		if(document.getElementsByName('color').length==0) {
			var txt = "&nbsp;&nbsp;<input type='checkbox' name='color' id='color' value='"+color+"' checked>"+color;
    		txt += "<input type='button' value='X' onClick='removeBox(this)'>";
    		var area = document.createElement('span');
    		area.innerHTML = txt;
    		document.getElementById('textBoxArea').appendChild(area);
    		
    		//초기화
    		$('#putcolor').val('');
		} else {
			var size = document.getElementsByName('color').length;
			var bool = "N";
		    for(var i = 0; i < size; i++){
		        if(color==document.getElementsByName('color')[i].value) {
		        	bool="Y";
		        	break;
		        } else {
		    		bool="N";
		        }
		    }
		    if(bool=="Y") {
	        	alert("같은 색상이 존재합니다.");
	        	
	        	//초기화
	    		$('#putcolor').val('');
	        } else {
	        	var txt = "&nbsp;&nbsp;<input type='checkbox' name='color' id='color' value='"+color+"' checked>"+color;
	    		txt += "<input type='button' value='X' onClick='removeBox(this)'>";
	    		var area = document.createElement('span');
	    		area.innerHTML = txt;
	    		document.getElementById('textBoxArea').appendChild(area);
	    		
	    		//초기화
	    		$('#putcolor').val('');
	        }
		}
	}
}
function removeBox(obj) {
	document.getElementById('textBoxArea').removeChild(obj.parentNode);
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
		<input type="file" id="file1" name="file1" size="70" /><br/>
		</td>
	</tr>
	
	<tr class="board">
		<th class="head" width="20%">상품가격</th>
		<td>
		<input type="number" name="price" id="price" style="width:98%;"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">사이즈</th>
		<td>
		<input type="checkbox" name="psize" id="psize" value="S">
		S &nbsp;&nbsp; 
		<input type="checkbox" name="psize" id="psize" value="M">
		M &nbsp;&nbsp;
		<input type="checkbox" name="psize" id="psize" value="L">
		L &nbsp;&nbsp; 
		<input type="checkbox" name="psize" id="psize" value="F">
		Free 
		</td>
	</tr>
	
	<tr class="board">
		<th class="head">색상</th>
		<td>
		<input type="text" id="putcolor" name="putcolor">
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
			<input type="radio" name="wait" id="wait" value="N" checked>상품업로드&nbsp;&nbsp;
		</td>
	</tr>
	

</form>

<form id="frm2" name="frm2" enctype="multipart/form-data">
<input type="hidden" name="pcode" id="pcode"/>
	<tr class="board">
		<th class="head">상품상세설명</th>
		<td style="height:150px;">
		<textarea name="editor" id="editor" style="width: 700px; height: 400px;"></textarea>
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