<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.io.File" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="java.awt.Image" %>
<%@ page import="javax.swing.ImageIcon" %>

<script src="https://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="./resources/editor/js/HuskyEZCreator.js" charset="utf-8"></script>

<c:set var="mainfile" value="${vo.mainfile}"></c:set>

<%
int x=0,y=0;
String mainfile = (String)pageContext.getAttribute("mainfile");
if(mainfile != null && !mainfile.equals("")) {
	File file = new File("C:/eGovFrameDev-3.7.0-64bit/workspace/thedeep/src/main/webapp/productImages/"+mainfile);
	BufferedImage img = ImageIO.read(file);
	int imgWidth = img.getWidth(null);
	int imgHeight = img.getHeight(null);
	if(imgWidth > imgHeight) {
		x = 100;
		y = (imgHeight * x) / imgWidth;
	} else if(imgWidth < imgHeight) {
		y = 100;
		x = (imgWidth * y) / imgHeight;
	} else {
		x=100;
		y=100;
	}

}
/*
 // 1024(넓이)/768(높이)
 // 1024:768 = 100:y
 // int y = 768 * 100 / 1024
 // int y = (imgHeight * 100) / imgWidth
*/
%>
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

	$("#btnModify").click(function(){
		if($("#pname").val() == "") {
			alert("상품명을 입력해주세요.");
			$("#pname").focus();
			return;
		}
		<%if(mainfile == null) { %>
		if(document.getElementById('file1').value=="") {
			alert("메인사진을 입력해주세요.");
			return;
		}
		<%}%> 
		if($("#content").val() == "") {
			alert("내용을 입력해주세요.");
			$("#content").focus();
			return;
		}
		if($("#price").val() == "") {
			alert("가격을 입력해주세요.");
			$("#price").focus();
			return;
		}
		
		if(confirm("수정하시겠습니까?")) {		
	 		//var formData = $("#frm").serialize();
	 		var form = new FormData(document.getElementById('frm'));
	 		// 비 동기 전송
			$.ajax({
				type: "POST",
				data: form,
				url: "/productModifySave.do",
				dataType: "json",
				processData: false,
				contentType: false, 
				
				success: function(data) {
					if(data.result == "ok") {
						alert("수정하였습니다.\n\n("+data.cnt+")개의 파일 저장");
						if(data.errCode == "-1") {
							alert("첨부파일을 확인해주세요. 확장명 오류");
						} else if(data.errCode == "0") {
							alert("첨부파일 확인, 이미지 파일만 가능합니다.");
						} else if(data.errCode == "1") {
							alert("첨부파일은 5M 미만이어야 합니다.");
						}
						
						var pcode= document.frm.pcode.value
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
	$("#btnDelete").click(function(){
		if(confirm("삭제하시겠습니까?")) {		
	 		//var formData = $("#frm").serialize();
	 		var form = new FormData(document.getElementById('frm'));
	 		// 비 동기 전송
			$.ajax({
				type: "POST",
				data: form,
				url: "/productDelete.do",
				dataType: "json",
				processData: false,
				contentType: false, 
				
				success: function(data) {
					if(data.result == "ok") {
						alert("삭제하였습니다.\n\n("+data.cnt+")개의 파일 삭제");
						location.href = "<c:url value='/productListView.do'/>";
					} else {
						alert("삭제 실패했습니다. 다시 시도해 주세요.");
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
function fnaction() {
	var mainfile = document.frm.mainfile.value;
	var pcode = document.frm.pcode.value;

	var param = "mainfile="+mainfile+"&pcode="+pcode;
	$.ajax({
		type : "POST",
		data : param,
		url : "/productFileDelete.do",
		success: function(data) {
			if(data.result == "1") {
				alert("삭제하였습니다.");
			    var head = document.getElementById('btnDel');
				head.innerHTML ="<input type='file' name='file1' size='70' />";
				location.href="/productModify.do?pcode="+pcode;
			} else {
				alert("삭제 실패했습니다. 다시 시도해 주세요.");
			}
		},
		error: function () {
			alert("오류발생 ");
		}
	});		
}

function addBox() {
	var color = eval("$('#putcolor').val()");
	if(color=="" || color==null) {
		alert("색상을 입력해주세요");
	} else {
		var txt = "&nbsp;&nbsp;<input type='checkbox' name='color' id='color' value='"+color+"' checked>"+color;
		txt += "<input type='button' value='X' onClick='removeBox(this)'>";
		var area = document.createElement('span');
		area.innerHTML = txt;
		document.getElementById('textBoxArea').appendChild(area);
	}
}
function removeBox(obj) {
	document.getElementById('textBoxArea').removeChild(obj.parentNode);
}
</script>
<table class="top">
		<tr class="top">
			<td class="top">상품수정</td>
		</tr>
    </table>
    
<form name="frm" id="frm" method="post" enctype="multipart/form-data">
<input type="hidden" id="mainfile" name="mainfile" value="${vo.mainfile}">
<input type="hidden" id="pcode" name="pcode" value="${vo.pcode}">
<table class="board">

	<tr class="board">
		<th class="head" width="20%">상품명</th>
		<td>
		<input type="text" name="pname" id="pname" value="${vo.pname}" style="width:98%;"/>
		</td>
	</tr>


	<tr class="board">
		<th class="head" width="20%">메인사진</th>
		<td>
		<%if(mainfile != null) { %>
			<span id="btnDel">
					<img src="/productImages/<%=mainfile%>" width="<%=x%>" height="<%=y%>"><%=mainfile%>&nbsp;
					<button type="button" value="mainfile" onclick="fnaction()" class="white">x</button>
			</span><br/>
		<% } else {%>
			<input type="file" id="file1" name="file1" size="70" /><br/>
		<% } %>
		</td>
	</tr>
	
	<tr class="board">
		<th class="head" width="20%">상품가격</th>
		<td>
		<input type="text" name="price" id="price" value="${vo.price}" style="width:98%;"/>
		</td>
	</tr>
	
	<tr class="board">
		<th class="head" width="20%">현재 사이즈 및 색상</th>
		<td>
		<c:forEach var="i" items="${cs}" varStatus="status">
		색상:${i.color}&nbsp;사이즈:${i.psize } <br/>
		</c:forEach>
		</td>
	</tr>
	
	<tr class="board">
		<th class="head">사이즈 추가</th>
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
		<th class="head">색상 추가</th>
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
			<input type="radio" name="gcode" id="gcode" value="${i.gcode}" <c:if test="${vo.gcode==i.gcode}">checked</c:if>/>${i.gname}&nbsp;&nbsp;
		</c:forEach>
	
		</td>
	</tr>
	<tr class="board">
		<th class="head">wait</th>
		<td>
			<input type="radio" name="wait" id="wait" value="Y" <c:if test="${vo.wait=='Y'}">checked</c:if>/>상품대기&nbsp;&nbsp;
			<input type="radio" name="wait" id="wait" value="N" <c:if test="${vo.wait=='N'}">checked</c:if>/>상품업로드&nbsp;&nbsp;
		</td>
	</tr>

</form>

<form id="frm2" name="frm2" enctype="multipart/form-data">
	<tr class="board">
		<th class="head">상품상세설명</th>
		<td style="height:150px;">
		<textarea name="editor" id="editor" style="width: 700px; height: 400px;">${vo.editor}</textarea>
		</td>
	</tr>
</table>
</form>

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