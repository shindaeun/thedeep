<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><tiles:insertAttribute name="title" /></title>
<meta content="width=device-width, initial-scale=1" name="viewport">
<meta content="Webflow" name="generator">
<link href="/css/normalize.css" rel="stylesheet" type="text/css">
<link href="/css/webflow.css" rel="stylesheet" type="text/css">
<link href="/css/home.css" rel="stylesheet" type="text/css">
<link href="/css/product.css" rel="stylesheet" type="text/css">
<link href="/css/board.css" rel="stylesheet" type="text/css">

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="/js/jquery-1.12.4.js"></script>
<script src="/js/jquery-ui.js"></script>
<script type="text/javascript">
$( document ).ready(function() {
	var values = [];
    $.ajax({
		type : "POST",
		url : "/Group.do",
		success : function(data) {
			if (data.result == "ok") {
				values = data.glist;
				$.each(values, function( index, value ) {
					document.getElementById('pgnav').innerHTML += '<a href="/productList.do?gcode='+value.gcode+'" class="nav-link-14 w-nav-link">'+value.gname+'</a>';
	              });
			}
			else {
				alert("실패했습니다. 다시 시도해 주세요.");
			}
		},
		error: function (request,status,error) {
        	  alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
          }
	});
    
});
	 !function(o, c) {
		var n = c.documentElement, t = " w-mod-";
		n.className += t + "js", ("ontouchstart" in o || o.DocumentTouch
				&& c instanceof DocumentTouch)
				&& (n.className += t + "touch")
	}(window, document); 

//드래그 | 오른쪽 마우스 | ctrl+c,v 방지
//기본동작 수행을 금지 Type1
function blockEvent(e){        
     console.log("blockEvent:"+e);
     if(e){ 
          e.preventDefault(); //DOM 레벨 2
     }else{             
          event.keyCode = 0;
          event.returnValue = false; //IE
     }
}

//기본동작 수행을 금지 Type2
function _stopEvent(e) {
    if (window.event) { //IE            
        window.event.cancelBubble = true; //전파 방지
        window.event.returnValue = false; //기본 동작 수행방지
    }
    //DOM 레벨 2
    if (e && e.stopPropagation && e.preventDefault) {
        e.stopPropagation(); //이벤트 전파 중지
        e.preventDefault(); //기본 동작 수행방지
    }
}

//이벤트 등록을 처리해주는 함수 (크로스 브라우징)
function _addEvent(element, eventType, handler) {       
    if (window.addEventListener) {
        element.addEventListener(eventType, handler, false)
    } else {
        if (window.attachEvent) { //IE8이하 버전에서
            element.attachEvent("on" + eventType, handler)
        }
    }
}

//마우스 드래그, 오른쪽 팝업메뉴, 선택 막기
function _addBlockEvent() {
    _addEvent(document, "dragstart", _stopEvent); //마우스 드래그  방지
    _addEvent(document, "selectstart", _stopEvent); //마우스 선택 방지
    _addEvent(document, "contextmenu", _stopEvent); //마우스 오른쪽 클릭 시 팝업메뉴 막기
    if (document.body && document.body.style.MozUserSelect != undefined) { 
        document.body.style.MozUserSelect = "none" //파이어폭스에서 마우스 선택 방지
    }
}


//특정키 사용을 방지
//이 함수는 복사, 붙여넣기의 단축키인 ctrl+c, ctrl+v 키를 막음
document.onkeydown = function(e){

    var code = document.all ? event.keyCode : e.keyCode;
    var ctrl = document.all ? event.ctrlKey : e.ctrlKey;

    if (ctrl && (code==86 || code==67)) {
        blockEvent(e);
    }
}

//JavaScript 오른쪽 마우스 사용금지 함수 (IE용)

function clickIE4(){
    //console.log("e:"+event+"event.button="+event.button);
    //event.button == 0 : 마우스 왼쪽 버튼
    //event.button == 1 : 마우스 가운데 버튼(휠버튼)
    //event.button == 2 : 마우스 오른쪽 버튼

    if (event.button==2 ){
        event.keyCode = 0;
           event.returnValue = false; //IE

        //alert("오른쪽 마우스 사용을 허용하지 않습니다.");
        //blockEvent();
        
        return false;
    }    
}

//JavaScript 오른쪽 마우스 사용금지 함수 
function clickNS4(e){

    if (document.layers||document.getElementById&&!document.all){
        if (e.which==2||e.which==3){
            blockEvent(e);
            return false;
        }
    }
}

//JavaScript 오른쪽 마우스 사용금지 함수 (크로스 브라우징 처리)
function rightbutton(e)
{
    if (navigator.appName == 'Netscape' &&  (e.which == 3 || e.which == 2))
        return false;
    else if (navigator.appName == 'Microsoft Internet Explorer' 
                                && (event.button == 2 || event.button == 3))
    {
        alert("오른쪽 마우스 사용을 허용하지 않습니다.");
        return false;
    }
    return true;
}


//마우스 드래그, 오른쪽 팝업메뉴, 선택 막기 함수 실행.
_addBlockEvent();


//document.oncontextmenu=new Function("return false")
//document.oncontextmenu= function(e) { _stopEvent(e); };
//document.onmousedown=_stopEvent;

// -->
</script>
<link href="https://daks2k3a4ib2z.cloudfront.net/img/favicon.ico"
	rel="shortcut icon" type="image/x-icon">
<link href="https://daks2k3a4ib2z.cloudfront.net/img/webclip.png"
	rel="apple-touch-icon">
</head>


<body class="body">

	<tiles:insertAttribute name="topMenu" />
	<header class="section"></header>
	<div>
		<div class="w-row">
			<div class="w-col w-col-1"></div>
			<div class="w-col w-col-2">
				<tiles:insertAttribute name="leftMenu" />
			</div>
			<div class="w-col w-col-7">
				<tiles:insertAttribute name="content" />
			</div>
			<div class="w-col w-col-2"></div>
		</div>
	</div>

	<div>

		<div class="w-row">
			
				<tiles:insertAttribute name="footer" />
			
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.3.1.min.js"
		type="text/javascript"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous"></script>
	<script src="js/webflow.js" type="text/javascript"></script>
	<!-- [if lte IE 9]><script src="https://cdnjs.cloudflare.com/ajax/libs/placeholders/3.0.2/placeholders.min.js"></script><![endif] -->
</body>


</html>
