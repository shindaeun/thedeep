<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<table class="top">
		<tr class="top">
			<td class="top">board</td>
		</tr>
    </table>
<form>
	<table>
		<tr>
			<td><select name="searchCondition">
					<option value="title">제목</option>
					<option value="content">내용</option>
			</select> <input type="text" name="searchKeyword" id="searchKeyword">
					<button type="button" id="btnSearch" class="white">검색</button>
				</td>
		</tr>
	</table>
</form>
<br>
<table>
		<tr>
			<th>qna</th>
		</tr>
    </table>
<table class="line">
    	<tr class="line">
    		<td class="line">
    		</td>
    	</tr>
    </table>
<div>
	<table class="board">
		<tr class="board">
			<th style="width:10%;" >NO</th>
			<th width="40%" >SUBJECT</th>
			<th width="20%" >WRITER</th>
			<th width="20%" >DATE</th>
			<th width="10%" >HIT</th>
		</tr>
		<c:forEach var="result" items="${resultList }" varStatus="status">
			<tr class="board">
				<td>${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}</td>
				<td><a href="/boardModify.do?unq=${result.unq}">${result.title}</a></td>
				<td>${result.name}</td>
				<td>${result.rdate}</td>
				<td>${result.hit}</td>
			</tr>
		</c:forEach>
	</table>
</div>
<br>
<br>
<br>
<form name="frm">
	<table>
		<tr>
			<td><select name="searchCondition">
					<option value="title">제목</option>
					<option value="content">내용</option>
			</select> <input type="text" name="searchKeyword" id="searchKeyword">
				<button type="button" id="btnSearch2" class="white">검색</button></td>
		</tr>
	</table>
</form>
<br>
<table>
		<tr>
			<th>review</th>
		</tr>
    </table>
<table class="line">
    	<tr class="line">
    		<td class="line">
    		</td>
    	</tr>
    </table>
<div class="">
	<table class="board">
		<tr class="board">
			<th width="10%" >NO</th>
			<th width="40%" >SUBJECT</th>
			<th width="20%" >WRITER</th>
			<th width="20%" >DATE</th>
			<th width="10%" >HIT</th>
		</tr>
		<c:forEach var="result" items="${resultList }" varStatus="status">
			<tr class="board">
				<td>${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}</td>
				<td><a href="/boardModify.do?unq=${result.unq}">${result.title}</a></td>
				<td>${result.name}</td>
				<td>${result.rdate}</td>
				<td>${result.hit}</td>
			</tr>
		</c:forEach>
	</table>
</div>
<br>
