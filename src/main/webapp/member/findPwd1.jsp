<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<table class="top">
	<tr class="top">
		<td class="top">비밀번호 찾기</td>
	</tr>
</table>

<form id="frm" name="frm">
<table width="30%" style="margin-left:340px; margin-top:70px;">
	<colgroup>
		<col width="15%" />
		<col width="35%" />
		<col width="15%" />
		<col width="35%" />
	</colgroup>
	<tr>
		<td>NAME</td>
		<td  align="center">
		<input type="text" id="name" name="name" style="border-style:none;" autofocus/>
		</td>
	</tr>
	<tr>
		<td>ID</td>
		<td align="center">
		<input type="text" id="id" name="id" style="border-style:none;"/>
		</td>
	</tr>
	<tr>
		<td>E-Mail</td>
		<td align="center">
		<input type="text" id="email" name="email" style="border-style:none;"/>
		</td>
	</tr>
</table>
</form>
<div width="100%" style="margin-left:340px; margin-top:10px;">
<button type="button" id="btnFind" class="white" style="width:260px;">Find</button>
</div>