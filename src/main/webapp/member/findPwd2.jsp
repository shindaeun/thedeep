<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<table class="top">
	<tr class="top">
		<td class="top">비밀번호 찾기</td>
	</tr>
</table>

<div width="100%" style="text-align:center; margin-top:30px;">
<h3>임시비밀번호가 고객님 메일로 발송되었습니다!</h3> <br/>
고객님의 비밀번호가 성공적으로 발송되었습니다.<br/>
항상 고객님의 즐겁고 편리한 쇼핑을 위해 최선의 <br/>
노력을 다하는 쇼핑몰이 되도록 하겠습니다.
<br/>
저희 쇼핑몰을 이용해주셔서 감사합니다. <br/>
<b>${vo.userid} 회원님</b>의 패스워드를 <br/>
<b>{vo.email}</b>으로 보내드렸습니다.<br/>
<br/>
고객님 즐거운 쇼핑 하세요!
<br/>
</div>
<table width="100%" style="margin-top:30px;">
	<tr style="text-align:center;">
		<td>
			<button id="btnLogin" class="white">login</button>
		</td>
	</tr>
</table>