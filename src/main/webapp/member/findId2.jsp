<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<table class="top">
	<tr class="top">
		<td class="top">아이디 찾기</td>
	</tr>
</table>
<div width="100%" style="text-align:center; margin-top:30px;">
<h3>고객님 아이디 찾기가 완료 되었습니다.</h3> <br/>
고객님의 아이디 찾기가 성공적으로 이루어졌습니다. <br/>
항상 고객님의 즐겁고 편리한 쇼핑을 위해 최선의 
<br/>노력을 다하는 쇼핑몰이 되도록 하겠습니다. <br/>
<br/>
저희 쇼핑몰을 이용해주셔서 감사합니다. <br/>
다음정보로 가입된 아이디가 총 ${vo.cnt}개 있습니다. <br/>
</div>
<form id="frm" name="frm">
<table width="30%" style="margin-left:340px; margin-top:10px;">
	<colgroup>
		<col width="15%" />
		<col width="35%" />
		<col width="15%" />
		<col width="35%" />
	</colgroup>
	<tr>
		<td>NAME</td>
		<td  align="center">
		${vo.name}
		</td>
	</tr>
	<tr style="margin-bottom:10px;">
		<td>E-Mail</td>
		<td align="center">
		${vo.email}
		</td>
	</tr>
	<c:forEach var="result" items="${resultList}" varStatus="status">
	<tr>
		<td>
		<input type="radio" id="userid" value="${result.userid}"/>
		(${vo.rdate}에 가입)
		</td>
	</tr>
	</c:forEach>
</table>
</form>
<div width="100%" style="text-align:center; margin-top:20px;">
고객님 즐거운 쇼핑 하세요!
</div>
<table width="100%" style="margin-top:30px;">
	<tr style="text-align:center;">
		<td>
			<button id="btnLogin" class="white">login</button>
			<button id="btnFindPwd" class="white">Find Password</button>
		</td>
	</tr>
</table>