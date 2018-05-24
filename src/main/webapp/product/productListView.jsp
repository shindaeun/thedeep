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
      $("#frm1").attr({
         action:'/productListView.do',method:'post'
      }).submit();
   });
   
});
function fnAdd(cscode,num) {
	if(confirm("저장하시겠습니까?")) {
		var amount = document.frm2.amount[num].value;
		//var amount = document.getElementsByName("amount");
		//alert(amount[num].value);
 		var param = "cscode="+cscode+"&amount="+amount;

		$.ajax({
			type: "get",
			data: param,
			url: "/productAmountAdd.do",
			dataType: "json",
			processData: false,
			contentType: false, 
			
			success: function(data) {
				if(data.result == "1") {
					alert("저장하였습니다.");
					location.href="/productListView.do";
				} else {
					alert("저장 실패하였습니다. 다시 시도해 주세요.");
				}
					
			},
			error: function(request,status,error) {
				 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
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

<form name="frm1" id="frm1">
<table style="width:100%">
   <tr>
      <td>
         <select name="searchCondition">
            <option value="p.pname">상품명</option>
            <option value="p.pcode">상품코드</option>
         </select>
         <input type="text" name="searchKeyword" id="searchKeyword">
         <button type="button" id="btnSearch" class="white">검색</button>
      </td>
   </tr>
</table>
</form>

<form name="frm2" id="frm2">
<c:set var="total" value="1"/>
<table class="board">
   <tr class="board" style="height:30px;">
       <th width="7%">NO</th>
       <th width="7%">상품분류</th>
       <th width="12%">상품코드</th>
       <th width="12%">품목코드</th>
       <th width="12%">상품명</th>
       <th width="10%">판매가</th>
       <th width="5%">품절</th>
       <th width="5%">대기</th>
       <th width="10%">재고수량</th>
       <th width="12%">입고/출고</th>
       <th width="5%">삭제</th>
   </tr>
   <c:forEach var="result" items="${resultList}" varStatus="status">
   <tr class="board" style="height:30px;">
      <td style="text-align:center"><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/></td>
      <td style="text-align:center">${result.gname}</td>
      <td style="text-align:center"><a href="/productModify.do?pcode=${result.pcode}">${result.pcode}</td>
      <td style="text-align:center">${result.cscode}</td>
      <td style="text-align:center">${result.pname}</td>
      <td style="text-align:center">${result.price}</td>
      <td style="text-align:center">${result.soldout}</td>
      <td style="text-align:center">${result.wait}</td>
      <td style="text-align:center">${result.amount}</td>
      <td style="text-align:center"><input type="text" name="amount" id="amount" size="4"><a href="javascript:fnAdd('${result.cscode}','${status.count-1}')" class="white">&nbsp;저장&nbsp;</a></td>
      <td style="text-align:center"><a href="javascript:fnDel('${result.cscode}')" class="white">&nbsp;삭제&nbsp;</a></td>
    </tr>
   </c:forEach>
</table>
</form>

<br>

<table border="0" width="100%;">
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