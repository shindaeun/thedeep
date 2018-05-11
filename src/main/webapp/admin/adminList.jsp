<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>
div.one {
	width:100%;
	height:50px;
	font-size:14pt;
	font-weight: bold;
	color: #646464;	
	text-align: center;
	margin-top:60px;
	margin-bottom:10px;
}
</style>
<table class="top">
	<tr class="top">
		<td class="top">회원 정보 조회</td>
	</tr>
</table>

<div class="one">회원 목록</div>
<form id="frm" name="frm">
<table style="width:100%; text-align:center;">
	<tr>
      <td>
         <select name="searchCondition">
            <option value="id">아이디</option>
            <option value="name">이름</option>
         </select>
         <input type="text" name="searchKeyword" id="searchKeyword">
         <button type="button" id="btnSearch" class="white">검색</button>
      </td>
   </tr>
</table>
<table class="board">
	<tr class="board">
		<th class="head">아이디</th>
		<th class="head">이름</th>
		<th class="head">연락처</th>
		<th class="head">생일</th>
		<th class="head">이메일</th>
		<th class="head">주소</th>
	</tr>
	<c:forEach var="result" items="${resultList}" varStatus="status">
	   <tr class="board">
	      <td width="20%">${result.userid}</td>
	      <td width="10%">${result.name}</td>
	      <td width="15%">${result.phone}</td>
	      <td width="15%">${result.birthday}</td>
	      <td width="20%">${result.email}</td>
	      <td width="20%">${result.addr}</td>
	   </tr>
	</c:forEach>
</table>
</form>