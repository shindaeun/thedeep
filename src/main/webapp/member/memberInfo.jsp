<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">

<script src="/js/jquery-1.12.4.js"></script>
<script src="/js/jquery-ui.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

<script>
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullAddr = ''; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                fullAddr = data.roadAddress;

            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                fullAddr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
            if(data.userSelectedType === 'R'){
                //법정동명이 있을 경우 추가한다.
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                // 건물명이 있을 경우 추가한다.
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('sample6_address').value = fullAddr;

            // 커서를 상세주소 필드로 이동한다.
            document.getElementById('sample6_address2').focus();
        }
    }).open();
}

$(function(){
	$("#idChk").click(function() {
		if($("#userid").val() == "") {
			alert("아이디를 입력해주세요.");
			$("#userid").focus();
			return;
		}
		//var form = new FormData(document.getElementById('frm'));
		var data = "userid=" + $("#userid").val();
		$.ajax({
			type: "POST",
			data: data,
			url: "/memberIdChk.do",
			
			success: function(data) {
				if(data.result == "ok") {
					alert("중복된 아이디가 없습니다");
					var check = "ok";
					$("#check").val(check);
					var form = document.cfrm;
					form.method = "post";
					form.action = "/memberInfo.do";
				} else {
					alert("중복된 아이디가 있습니다 (다시 입력해 주세요)");
				}
			},
			error: function () {
				alert("오류발생ㅠㅠ ");
			}
		});
	});
	$("#btnSubmit").click(function(){
		if($("#name").val() == "") {
			alert("이름을 입력해주세요.");
			$("#name").focus();
			return;
		}
		if($("#userid").val() == "") {
			alert("아이디를 입력해주세요.");
			$("#userid").focus();
			return;
		}
		if(    $("#pwd").val().length < 4 
			|| $("#pwd").val().length > 12 )
		{
			alert("암호는 4~12자리 사이로 입력해주세요");
			$("#pwd").focus();
			return;
		}
		
		var pwdck = /(^[a-zA-Z0-9]*$)/;
		var pwd = $("#pwd").val();
		
		if(!pwdck.test(pwd)) {
			alert("암호는 숫자 혹은 영어만 올 수 있습니다.");
			$("#pwd").focus();
			return;
		}
		
		if($("#pwd").val() != $("#pwd2").val()) {
			alert("암호가 일치하지 않습니다");
			$("#pwd").focus();
			return;
		}
		
		if($("#bir1").val() == "==" || $("#bir2").val() == "==" || $("#bir3").val() == "==") {
			alert("생일을 입력해 주세요.");
			$("#bir1").focus();
			return;
		}
		
		var year = $("#bir1").val();
		var month = $("#bir2").val();
		var day = $("#bir3").val();
		
		var fitstDayOfMonth = [year, month, 1].join('-');
		var date = new Date(fitstDayOfMonth);
		date.setMonth(date.getMonth()+1);
		date.setDate(date.getDate()-1);
		
		var last = date.getDate();
		if(last<day) {
			alert("요일을 잘못 지정하셨습니다.");
			return;
		}
		
		var birthday = $("#bir1").val();
 		if($("#bir2").val()<10) {
 			birthday += "-" + "0" + $("#bir2").val();
 		} else birthday += "-" + $("#bir2").val();
 		if($("#bir3").val()<10) {
 			birthday += "-" + "0" + $("#bir3").val();
 		} else birthday += "-" + $("#bir3").val();
 		
 		$("#birthday").val(birthday);
		
		if($("#birthday").val() == $("#today").val()) {
			alert("생일이 올바르지 않습니다.");
			$("#birthday").focus();
			return;
		}
		
		if($('input:radio[id=gender]:checked').val()==undefined) {
			alert("성별을 입력해주세요.");
			$("#gender").focus();
			return;
		}
		
		if($("#email1").val() == "") {
			alert("이메일을 입력해주세요.");
			$("#email1").focus();
			return;
		}
		if($("#phone2").val() == "" || $("#phone3").val() == "") {
			alert("연락처를 입력해주세요.");
			$("#phone2").focus();
			return;
		}
		if($("#sample6_postcode").val() == "") {
			alert("우편번호를 입력해주세요");
			$("#sample6_postcode").focus();
			return;
		}
		if($("#sample6_address2").val() == "") {
			alert("상세주소를 입력해주세요");
			$("#sample6_address2").focus();
			return;
		}
		
		var hangle = /(^[a-zA-Z0-9가-힣]*$)/;
		var sang = $("#sample6_address2").val();
		
		if(!hangle.test(sang)) {
			alert("상세주소에는 특수문자가 올 수 없습니다.");
			$("#sample6_address2").focus();
			return;
		}
		
		if($('input:radio[id=yackguan]:checked').val()=="n") {
			alert("약관에 동의해 주세요");
			return;
		}
		if($("#check").val()=="") {
			alert("아이디 중복확인을 해주세요");
			return;
		}
		if(confirm("저장하시겠습니까?")) {		
	 		//var formData = $("#frm").serialize();
	 		var phone  = $("#phone1").val();
	 			phone += "-" +  $("#phone2").val(); 
	 			phone += "-" +  $("#phone3").val();
	 		$("#phone").val(phone);
	 		
	 		var post  = $("#sample6_postcode").val();
	 			post += "/" + $("#sample6_address").val();
	 			post += "/" + $("#sample6_address2").val();
	 		$("#post").val(post);
	 		
	 		var email  = $("#email1").val();
	 			email += "@" + $("#email2").val();
	 		$("#email").val(email);
	 		
	 		var formData = $("#frm").serialize();
	 		// 비 동기 전송
			$.ajax({
				type: "POST",
				data: formData,
				url: "/memberInfoSave.do",

				success: function(data) {
					if(data.result == "ok") {
						alert("저장하였습니다.");
						location.href = "/theDeep.do";
					} else if(date.result == "0") {
						alert("쿠폰저장에 실패했습니다");
					} else {
						alert("저장에 실패했습니다 다시 시도해주세요")
					}
				},
				error: function () {
					alert("오류발생 ");
				}
			}); 
		}
	});
});
</script>
<table class="top">
	<tr class="top">
		<td class="top">JOIN</td>
	</tr>
</table>


<form name="cfrm" id="cfrm">
<input type="hidden" name="check" id="check"/>
</form>
<form name="frm" id="frm">

<input type="hidden" name="phone" id="phone"/>
<input type="hidden" name="post" id="post"/>
<input type="hidden" name="email" id="email"/>
<input type="hidden" name="birthday" id="birthday"/>
<input type="hidden" name="today" id="today" value="${today}"/>

<table class="board">
	<tr class="board">
		<th class="head" width="20%">이름</th>
		<td align="left" style="padding:5px;">
		<input type="text" name="name" id="name" style="width:15%;" autofocus/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">ID</th>
		<td align="left" style="padding:5px;">
		<input type="text" name="userid" id="userid" 
					placeholder="ID 입력" style="width: 15%; ime-mode:inactive;"/>
		<button type="button" id="idChk" class="white">중복확인</button>
		</td>
	</tr>
	<tr class="board">
		<th class="head">비밀번호</th>
		<td align="left" style="padding:5px;">
		<input type="password" name="pwd" id="pwd" style="width:25%; ime-mode:inactive;" placeholder="비밀번호 입력 (4~12자리)"/>
		(4~12자리)
		</td>
	</tr>
	<tr class="board">
		<th class="head">비밀번호 확인</th>
		<td align="left" style="padding:5px;">
		<input type="password" name="pwd2" id="pwd2" style="width:25%; ime-mode:inactive;" placeholder="동일하게 입력해 주세요"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">이메일</th>
		<td align="left" style="padding:5px;">
		<input type="text" name="email1" id="email1" style="width:20%; ime-mode:inactive;"/>
		@
		<select name="email2" id="email2">
			<option value="naver.com">naver.com</option>
			<option value="daum.net">daum.com</option>
			<option value="gmail.com">gmail.com</option>
		</select>
		</td>
	</tr>
	<tr class="board">
		<th class="head">생일</th>
		<td align="left" style="padding:5px;">
		<select name="bir1" id="bir1">
			<option value="==">년도</option>
			<c:forEach var="i" begin="1970" end="2017">
			<option value="${i}">${i}</option>
			</c:forEach>
		</select>
		<select name="bir2" id="bir2">
			<option value="==">월</option>
			<c:forEach var="i" begin="1" end="12">
			<option value="${i}">${i}</option>
			</c:forEach>
		</select>
		<select name="bir3" id="bir3">
			<option value="==">일</option>
			<c:forEach var="i" begin="1" end="31">
			<option value="${i}">${i}</option>
			</c:forEach>
		</select>
		</td>
	</tr>
	<tr class="board">
		<th class="head">성별</th>
		<td align="left" style="padding:5px;">
		<input type="radio" name="gender" id="gender" value="W"/>WOMAN
		<input type="radio" name="gender" id="gender" value="M"/>MAN
		</td>
	</tr>
	<tr class="board">
		<th class="head">연락처</th>
		<td align="left" style="padding:5px;">
		<select name="phone1" id="phone1">
				<option value="010">010</option>
				<option value="011">011</option>
		</select> -
		<input type="text" name="phone2" id="phone2" maxlength="4" style="width:10%; IME-MODE: disabled;"/> -
		<input type="text" name="phone3" id="phone3" maxlength="4" style="width:10%; IME-MODE: disabled;"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">주소</th>
		<td style="text-align: left; padding:5px;">
		<input type="text" name="sample6_postcode" id="sample6_postcode" placeholder="우편번호" style="width:30%; margin-top: 1%;"/>
		<button type="button" onclick="sample6_execDaumPostcode()" class="white">우편번호 찾기</button><br/>
		<input type="text" name="sample6_address" id="sample6_address" placeholder="주소" style="width:50%; margin-top: 1%;"><br/>
		<input type="text" name="sample6_address2" id="sample6_address2" placeholder="상세주소" style="width:70%; margin-top: 1%; margin-bottom:1%;"><br/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">이메일 수신</th>
		<td>
		<input type="radio" name="emailreceive" id="emailreceive" value="y"/>받습니다
		<input type="radio" name="emailreceive" id="emailreceive" value="n" checked/>받지 않습니다
		</td>
	</tr>
	<tr class="board">
		<th class="head">문자 수신</th>
		<td>
		<input type="radio" name="phonereceive" id="phonereceive" value="y"/>받습니다
		<input type="radio" name="phonereceive" id="phonereceive" value="n" checked/>받지 않습니다
		</td>
	</tr>
</table>
<div style="border:1px solid; width:100%; height:100px; overflow: auto; font-size:9pt;">
인터넷 쇼핑몰 『주식회사 The Deep 사이버 몰』회원 약관 <br/>
<br/> 제1조(목적)<br/><br/> 이 약관은 주식회사 The Deep 회사(전자상거래 사업자)가 운영하는 주식회사 The Deep 사이버 몰(이하 “몰”이라 한다)에서 제공하는 인터넷 관련 서비스(이하 “서비스”라 한다)를 이용함에 있어 사이버 몰과 이용자의 권리·의무 및 책임사항을 규정함을 목적으로 합니다.
<br/> ※「PC통신, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는 한 이 약관을 준용합니다.」<br/><br/>제2조(정의)<br/><br/>
① “몰”이란 주식회사 The Deep 회사가 재화 또는 용역(이하 “재화 등”이라 함)을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 등을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 사이버몰을 운영하는 사업자의 의미로도 사용합니다.
<br/>② “이용자”란 “몰”에 접속하여 이 약관에 따라 “몰”이 제공하는 서비스를 받는 회원 및 비회원을 말합니다.
<br/>③ ‘회원’이라 함은 “몰”에 회원등록을 한 자로서, 계속적으로 “몰”이 제공하는 서비스를 이용할 수 있는 자를 말합니다.
<br/>④ ‘비회원’이라 함은 회원에 가입하지 않고 “몰”이 제공하는 서비스를 이용하는 자를 말합니다.
<br/><br/>제3조 (약관 등의 명시와 설명 및 개정) <br/><br/>
① “몰”은 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호·모사전송번호·전자우편주소, 사업자등록번호, 통신판매업 신고번호, 개인정보보호책임자 등을 이용자가 쉽게 알 수 있도록 주식회사 The Deep 사이버몰의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.
<br/>② “몰은 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회·배송책임·환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.
<br/>③ “몰”은 「전자상거래 등에서의 소비자보호에 관한 법률」, 「약관의 규제에 관한 법률」, 「전자문서 및 전자거래기본법」, 「전자금융거래법」, 「전자서명법」, 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」, 「방문판매 등에 관한 법률」, 「소비자기본법」 등 관련 법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.
<br/>④ “몰”이 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 몰의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다.  이 경우 "몰“은 개정 전 내용과 개정 후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다. 
<br/>⑤ “몰”이 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정 전의 약관조항이 그대로 적용됩니다. 다만 이미 계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의 공지기간 내에 “몰”에 송신하여 “몰”의 동의를 받은 경우에는 개정약관 조항이 적용됩니다.
<br/>⑥ 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제 등에 관한 법률, 공정거래위원회가 정하는 「전자상거래 등에서의 소비자 보호지침」 및 관계법령 또는 상관례에 따릅니다.
</div>
<table style="width:100%; margin:5px;">
	<tr>
	<td> 위 약관에 동의합니까? 
	<input type="radio" name="yackguan" id="yackguan" value="y"/>동의합니다
	<input type="radio" name="yackguan" id="yackguan" value="n" checked/>동의하지 않습니다
	</td>
	</tr>
</table>
<table style="width:100%;">
	<tr>
		<th style="align:center;">
		<button type="button" id="btnSubmit" class="white">회원가입</button>&nbsp;
		<button type="button" class="white" onclick="location.href= '/theDeep.do'">취소</button>
		</th>
	</tr>
</table>
</form>
