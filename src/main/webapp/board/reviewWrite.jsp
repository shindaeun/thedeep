<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
$(function(){
	$("#btnSubmit").click(function(){
		location.href="/reviewList.do";
	});
	$("#btnList").click(function(){
		location.href="/reviewList.do";
	});
	
});
</script>
<table class="top">
		<tr class="top">
			<td class="top">review</td>
		</tr>
    </table>
<table class="board">

	<tr class="board">
		<th class="head" width="20%">name</th>
		<td>
		<input type="text" name="userid" id="userid" style="width:98%;"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">password</th>
		<td>
		<input type="text" name="pwd" id="pwd" style="width:98%;"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">subject</th>
		<td>
		<input type="text" name="title" id="title" style="width:98%;"/>
		</td>
	</tr>
	<tr class="board">
		<th class="head">size</th>
		<td>
		<select name="height" id="height">
			<option value="1">140-145cm</option>
			<option value="2">145-150cm</option>
			<option value="3">150-155cm</option>
			<option value="4">155-160cm</option>
			<option value="5">160-165cm</option>
			<option value="6">165-170cm</option>
			<option value="7">170-175cm</option>
		</select>
		&nbsp;&nbsp; 
		<select name="weigth" id="weigth">
			<option value="1">40-45kg</option>
			<option value="2">45-50kg</option>
			<option value="3">50-55kg</option>
			<option value="4">55-60kg</option>
			<option value="5">60-65kg</option>
			<option value="6">65-70kg</option>
			<option value="7">70-75kg</option>
			<option value="8">75-80kg</option>
		</select>
		&nbsp;&nbsp; 
		<select name="size" id="size">
			<option value="1">S</option>
			<option value="2">M</option>
			<option value="3">L</option>
			<option value="4">free</option>
		</select>
		</td>
	</tr>
	
	<tr class="board">
		<th class="head">fit</th>
		<td>
		<input type="radio" name="fit" id="fit" value="1" checked>
		매우큼 &nbsp;&nbsp; 
		<input type="radio" name="fit" id="fit" value="2">
		큼 &nbsp;&nbsp;
		<input type="radio" name="fit" id="fit" value="3">
		딱맞음 &nbsp;&nbsp; 
		<input type="radio" name="fit" id="fit" value="4">
		작음 &nbsp;&nbsp; 
		<input type="radio" name="fit" id="fit" value="5">
		매우작음 
		</td>
	</tr>
	
	<tr class="board">
		<th class="head">content</th>
		<td style="height:150px;">
		<textarea name="content" id="content" style="width:98%;height:95%;"></textarea>
		</td>
	</tr>
	<tr class="board">
        <th class="head">file</th>
        <td style="text-align:left">
        	<input type="file" name="file1" size="70" /><br/>
        </td>
	</tr>
</table>

<table border="0" style="width:100%;">
	<tr style="text-align:center">
		<th colspan="2" style="text-align:center">
		<button type="button" id="btnSubmit" class="white">등록</button>
		&nbsp;
		<button type="button" id="btnList" class="white">취소</button>
		</th>
	</tr>
</table>