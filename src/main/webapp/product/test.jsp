<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>에디터</title>
 
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="./resources/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
 
</head>
<script type="text/javascript">
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
        //전송버튼
        $("#insertBoard").click(function(){
        	var form = new FormData(document.getElementById('frm'));
        	obj.getById["editor"].exec("UPDATE_CONTENTS_FIELD", []);
			var test = document.getElementById("editor").value;
			alert(test);
            var editor= $('#editor').val();
            var cscode= $('#cscode').val();
            var file1= $('#file1').val();
        	alert(editor);
        	alert(cscode);
        	alert(file1);
        	
       		$.ajax({
       			url : '/insertBoard.do',
       			type : 'post',
       			datatype : 'json',
       			data :{
       				"editor" : editor,
       				"cscode" : cscode,
       				"mainfile" : file1
       			},
       			
       			success : function(data){
       				if(data=="ok"){
       					location.href="/insertBoard.do";
       				}
       			}
       		});
        	
        });

    });
</script>
<body>
 
    <form id="frm" name="frm" enctype="multipart/form-data">
        <textarea name="editor" id="editor" style="width: 700px; height: 400px;"></textarea>
        <input type="text" id="cscode" name="cscode"/>
        <input type="file" id="file1" name="file1" size="70" /><br/>
        <input type="button" id="insertBoard" value="등록" />
    </form>
 
</body>
</html>

<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>에디터</title>
 
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="./resources/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
 
</head>

<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef : oEditors,
	elPlaceHolder : "editor",
	//SmartEditor2Skin.html 파일이 존재하는 경로
	sSkinURI : "./resources/editor/SmartEditor2Skin.html",
	htParams : {
		// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseToolbar : true,
		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseVerticalResizer : true,
		// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		bUseModeChanger : true,
		fOnBeforeUnload : function() {
		}
	},
});


//네이버 에디터 작성 데이터 전송하기 

$("#submitBoardBtn").click(function()
	var editor= $('#editor').val();
	if(boardSubject.trim().length < 4){
		alert("4글자 이상 입력하세요.");
		$('#boardSubject').focus();
	} else{
		$.ajax({
			url : '/insertBoard.do',
			type : 'post',
			datatype : 'json',
			data : {
				"editor" : editor
			},
			success : function(data){
				if(data=="ok"){
					location.href="/insertBoard.do";
				}
			}
		});
	}
});


</script>

<body>
 
    <form method="post" id="frm" name="frm" enctype="multipart/form-data">
        <textarea name="editor" id="editor" style="width: 700px; height: 400px;"></textarea>
        <input type="button" id="submitBoardBtn" value="등록" />
    </form>
 
</body> --%>




