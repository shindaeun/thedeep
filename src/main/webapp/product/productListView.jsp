<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
$(function() {
   $("#btnSearch").click(function() {
      if($("#searchKeyword").val()=="") {
         alert("검색어를 입력해주세요.");
         $("#searchKeyword").focus();
         return;
      }
      $("form").attr({
         action:'/productListView.do',method:'post'
      }).submit();
   });
});
</script>
<script>
function fnAdd(cscode) {
	if(confirm("입고하시겠습니까?")) {			
	 	var param = "cscode="+cscode;	
		$.ajax({
			type: "get",
			data: param,
			url: "/productAdd.do",
			dataType: "json",
			processData: false,
			contentType: false, 
			
			success: function(data) {
				if(data.result == "1") {
					alert("입고하였습니다.");
					location.href="/productListView.do";
				} else {
					alert("입고 실패하였습니다. 다시 시도해 주세요.");
				}
					
			},
			error: function () {
				alert("오류발생 ");
			}
		}); 
	}
}

</script>

<table class="top">
   <tr class="top">
      <td class="top">상품목록조회</td>
   </tr>
</table>

<form name="frm" id="frm">
<table style="width:100%">
   <tr>
      <td>
         <select name="searchCondition">
            <option value="pname">상품명</option>
            <option value="pcode">상품코드</option>
         </select>
         <input type="text" name="searchKeyword" id="searchKeyword">
         <button type="button" id="btnSearch" class="white">검색</button>
      </td>
   </tr>
</table>
</form>


<form id="frm1" name="frm1">
<c:set var="total" value="1"/>
<table class="board">
   <tr class="board" style="height:30px;">
       <th>NO</th>
       <th>상품분류</th>
       <th>상품코드</th>
       <th>품목코드</th>
       <th>상품명</th>
       <th>판매가</th>
       <th>재고수량</th>
       <th>SHOW</th>
       <th>입고</th>
   </tr>
   <c:forEach var="result" items="${list}" varStatus="status">
   <tr class="board" style="height:30px;">
      <td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/></td>
      <td>${result.gname}</td>
      <td>${result.pcode}</td>
      <td>${result.cscode}</td>
      <td>${result.pname}</td>
      <td>${result.price}</td>
      <td>${result.amount}</td>
      <td>${result.wait}</td>
      <td><input type="text" name="qty" id="qty"><a href="javascript:fnAdd('${result.cscode}')" class="white">입고</a></td>
    </tr>
   </c:forEach>
</table>
</form>
<br>

<table border="0" width="600px;">
   <tr>
      <td align="center" style="board:0px;">
         <div id="paging">
         <c:set var="parm1" value="searchCondition=${searchVO.getSearchCondition()}"/>
         <c:set var="parm2" value="searchKeyword=${searchVO.getSearchKeyword()}"/>
         <c:forEach var="i" begin="1" end="${paginationInfo.getTotalPageCount()}">
            <a href="productListView.do?pageIndex=${i}&${parm1}&${parm2}">${i}</a>
         </c:forEach>
         </div>
      </td>
   </tr>
</table>