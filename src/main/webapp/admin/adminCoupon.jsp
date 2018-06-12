<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	String pageIndex2 = request.getParameter("pageIndex2");
	if (pageIndex2 == null)
		pageIndex2 = "1";
	if (Integer.parseInt(pageIndex2) < 0)
		pageIndex2 = "1";

	String pageIndex = request.getParameter("pageIndex");
	if (pageIndex == null)
		pageIndex = "1";
	if (Integer.parseInt(pageIndex) < 0)
		pageIndex = "1";
%>
<script>
$(function(){
	$("#btnCreate").click(function(){
		if($("#ccode").val() == "") {
			alert("코드를 입력해주세요");
			$("#ccode").focus();
			return;
		}
		if($("#cname").val() == "") {
			alert("쿠폰 이름을 입력해주세요");
			$("#cname").focus();
			return;
		}
		if($("#applymoney").val() == "") {
			alert("적용 금액을 입력해주세요");
			$("#applymoney").focus();
			return;
		}
		if($("#discountrate").val() == "") {
			alert("할인률을 입력해주세요");
			$("#discountrate").focus();
			return;
		}
		if($("#maxdiscmoney").val() == "") {
			alert("최대 할인 금액을 입력해주세요");
			$("#maxdiscmoney").focus();
			return;
		}
		var hangle = /(^[a-zA-Z0-9가-힣 ]*$)/;
		var sang = $("#cname").val();
		
		if(!hangle.test(sang)) {
			alert("쿠폰이름에는 특수문자가 올 수 없습니다.");
			$("#cname").focus();
			return;
		}
		var formData = $("#frm").serialize();
	 		// 비 동기 전송
			$.ajax({
				type: "POST",
				data: formData,
				url: "/adminCouponSave.do",

				success: function(data) {
					if(data.result == "ok") {
						alert("등록되었습니다");
						location.href = "/adminCoupon.do";
					} else {
						alert("등록을 실패했습니다");
					}
				},
				error: function () {
					alert("오류발생 ");
				}
			}); 
		});
	$("#btnModify").click(function(){
		if($("#ccode").val() == "") {
			alert("코드를 입력해주세요");
			$("#ccode").focus();
			return;
		}
		if($("#cname").val() == "") {
			alert("쿠폰 이름을 입력해주세요");
			$("#cname").focus();
			return;
		}
		if($("#applymoney").val() == "") {
			alert("적용 금액을 입력해주세요");
			$("#applymoney").focus();
			return;
		}
		if($("#discountrate").val() == "") {
			alert("할인률을 입력해주세요");
			$("#discountrate").focus();
			return;
		}
		if($("#maxdiscmoney").val() == "") {
			alert("최대 할인 금액을 입력해주세요");
			$("#maxdiscmoney").focus();
			return;
		}
		var hangle = /(^[a-zA-Z0-9가-힣 ]*$)/;
		var sang = $("#cname").val();
		
		if(!hangle.test(sang)) {
			alert("쿠폰이름에는 특수문자가 올 수 없습니다.");
			$("#cname").focus();
			return;
		}
		var formData = $("#frm").serialize();
	 		// 비 동기 전송
			$.ajax({
				type: "POST",
				data: formData,
				url: "/adminCouponModify.do",

				success: function(data) {
					if(data.result == "ok") {
						alert("수정되었습니다");
						location.href = "/adminCoupon.do";
					} else {
						alert("수정을 실패했습니다");
					}
				},
				error: function () {
					alert("오류발생 ");
				}
			}); 
		});
	$("#btnBTD").click(function(){
		var param = 'ccode=c002';
	 		// 비 동기 전송
			$.ajax({
				type: "POST",
				data: param,
				url: "/adminBtdCoupon.do",

				success: function(data) {
					if(data.result == "ok") {
						alert("발급되었습니다");
						location.href = "/adminCoupon.do";
					} else if(data.result == "2") {
						alert("생일인 회원이 없습니다");
					} else {
						alert("이미 발급되었습니다");
					}
				},
				error: function (request,status,error) {
	            	  alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	              }
			}); 
		});
	$("#btnCancel").click(function() {
		location.href = "/adminCoupon.do"
	});
	$("#btnList").click(function() {
		location.href = "/adminCoupon.do"
	});
	$("#btnSearch").click(function() {
	      if($("#searchKeyword").val()=="") {
	         alert("검색어를 입력해주세요.");
	         $("#searchKeyword").focus();
	         return;
	      }
	      $("#frm2").attr({
	         action:'/adminCoupon.do',method:'post'
	      }).submit();
	   });
	$("#checkAll").click(function() {
		if($("#checkAll").prop('checked')) {
			$('input[name=check]:checkbox').each(function() {
				$(this).prop('checked',true);
			});
		} else {
			$('input[name=check]:checkbox').each(function() {
				$(this).prop('checked',false);
			});
		}
	});
});
function fnDelete(ccode) {
	if(ccode=="c001" || ccode=="c002") {
		alert("기본 쿠폰은 삭제할 수 없습니다");
		return;
	}
	if(confirm("삭제하시겠습니까?")) {
		// 비 동기 전송
		var param = "ccode=" + ccode;

		$.ajax({
	  	   type: "GET",
	  	   data: param,
	 	    url: "/adminCouponDel.do",
	 	    dataType: "json",
	 	    processData: false,
	 	    contentType: false,
	 	    
	 	    success: function(data) {
	    	      alert(data.result);
	     	     if(data.result == "ok") {
	    	         alert("쿠폰을 삭제했습니다.");
	      	         location.href = "/adminCoupon.do";
	      	    } else {
	      	         alert("삭제에 실패했습니다. 다시 시도해 주세요");
	     	     }
	    	 },
	    	 error: function () {
	    	       alert("오류발생ㅠㅠ");
	     	}
		}); 
	}
}
function fnOut(ccode) {
	if($('input:checkbox[id=check]:checked').length == 0) {
		alert("발급할 회원을 선택해 주세요.");
		return;
	}
	if(confirm("발급하시겠습니까?")) {
		// 비 동기 전송
		$("#ccode1").val(ccode);
		var form = new FormData(document.getElementById('frm2'));

		$.ajax({
	  	   type: "POST",
	  	   data: form,
	 	    url: "/adminCouponOut.do",
	 	    dataType: "json",
	 	    processData: false,
	 	    contentType: false,
	 	    
	 	    success: function(data) {
	    	      alert(data.result);
	     	     if(data.result == "ok") {
	    	         alert("쿠폰이 발급되었습니다.");
	      	         location.href = "/adminCoupon.do";
	      	    } else {
	      	         alert("발급에 실패했습니다. 다시 시도해 주세요");
	     	     }
	    	 },
	    	 error: function () {
	    	       alert("오류발생ㅠㅠ");
	     	}
		}); 
	}
}
</script>

<style>
hr.coupon {
    border: none;
    border-top: 1px dashed #555555;
    color: #fff;
    background-color: #fff;
    height: 1px;
    width:	100%;
}
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
a:link { text-decoration: none; color: #000000;text-align:center} 
a:visited { text-decoration: none; color: #000000} 
a:active { text-decoration: none; color: #000000}
a:hover {text-decoration:underline; color: #000000}
</style>

<table class="top">
	<tr class="top">
		<td class="top">admin coupon</td>
	</tr>
</table>

<form id="frm" name="frm">
<c:if test="${vo.ccode==null}">
<table style="width:100%; height:45px; border-top: 1px solid #555555; border-bottom: 1px solid #555555;">
	<tr>
		<th width="10%" style="background-color: #dcdcdc;">등록</th>
		<th width="6%">
		</th>
		<th width="20%">
			name <input type="text" id="cname" name="cname" style="width:70%"/>
		</th>
		<th width="17%">
			app <input type="text" id="applymoney" name="applymoney" style="width:60%"/>
		</th>
		<th width="10%">
			dis <input type="text" id="discountrate" name="discountrate" style="width:60%"/>
		</th>
		<th width="18%">
			maxdis <input type="text" id="maxdiscmoney" name="maxdiscmoney" style="width:60%"/>
		</th>
		<th width="6%">
		</th>
		<th width="13%">
			<button type="button" id="btnCreate" class="white">등록</button>
		</th>
	</tr>
</table>
</c:if>
<c:if test="${vo.ccode!=null}">
<table style="width:100%; height:45px; border-top: 1px solid #555555; border-bottom: 1px solid #555555;">
	<tr>
		<th width="10%" style="background-color: #dcdcdc;">수정</th>
		<th width="15%">
			${vo.ccode} <input type="hidden" id="ccode" name="ccode" value="${vo.ccode}"/>
		</th>
		<th width="20%">
			name <input type="text" id="cname" name="cname" style="width:70%" value="${vo.cname}"/>
		</th>
		<th width="17%">
			app <input type="text" id="applymoney" name="applymoney" style="width:60%" value="${vo.applymoney}"/>
		</th>
		<th width="10%">
			dis <input type="text" id="discountrate" name="discountrate" style="width:60%" value="${vo.discountrate}"/>
		</th>
		<th width="18%">
			maxdis <input type="text" id="maxdiscmoney" name="maxdiscmoney" style="width:60%" value="${vo.maxdiscmoney}"/>
		</th>
		<th width="10%">
			<button type="button" id="btnModify" class="white">수정</button>
			<button type="button" id="btnCancel" class="white">취소</button>
		</th>
	</tr>
</table>
</c:if>

<table class="board" style="margin-top:10px;">
	<tr class="board">
		<th class="head" style="width:5%">NO</th>
		<th class="head" style="width:10%">CODE</th>
		<th class="head" style="width:20%">COUPON NAME</th>
		<th class="head" style="width:20%">APPLYMONEY</th>
		<th class="head" style="width:10%">DISCOUNTRATE</th>
		<th class="head" style="width:20%">MAXDISCMONEY</th>
		<th class="head" style="width:8%;"></th>
		<th class="head" style="width:8%; border-left: 1px solid #555555;">&nbsp;</th>
	</tr>
	<c:forEach var="list" items="${list}" varStatus="status">
	<tr class="board" style="text-align:center;">
		<th>${status.count}</th>
		<td>${list.ccode}</td>
		<td><a href="/adminCoupon.do?ccode=${list.ccode}">${list.cname}</a></td>
		<td>${list.applymoney}</td>
		<td>${list.discountrate}</td>
		<td>${list.maxdiscmoney}</td>
		<th>
			<button type="button" class="white" onclick="javascript:fnDelete('${list.ccode}')">삭제</button>
		</th>
		<c:if test="${list.ccode=='c001'}">
		<th style="border-left: 1px solid #555555;">
		</th>
		</c:if>
		<c:if test="${list.ccode=='c002'}">
		<th style="border-left: 1px solid #555555;">
			<button type="button" id="btnBTD" class="white">발급</button>
		</th>
		</c:if>
		<c:if test="${list.ccode!='c002' && list.ccode!='c001'}">
		<td style="border-left: 1px solid #555555;">
			<button type="button" class="white" onclick="javascript:fnOut('${list.ccode}')">발급</button>
		</td>
		</c:if>
	</tr>
	</c:forEach>
</table>
</form>
<c:set var="pageIndex2" value="<%=pageIndex2%>" />
<c:set var="totalPage" value="${paginationInfo2.getTotalPageCount() }" />
<table border="0" width="100%">
	<tr>
		<td align="center" style="board:0px;">
			<div id="paging">
				<c:set var="a" value="${(pageIndex2-1)/5-((pageIndex2-1)/5%1)}" />
				<fmt:parseNumber var="a" integerOnly="true" value="${a}" />
				<c:set var="start" value="${a*5+1}" />
				<c:set var="last" value="${start+4}" />

				<c:if test="${last>paginationInfo2.getTotalPageCount() }">
					<c:set var="last" value="${paginationInfo2.getTotalPageCount() }" />
				</c:if>

				<fmt:parseNumber var="start2" integerOnly="true" value="${start-1}" />
				<c:if test="${start2 >0}">
					<a href="/adminCoupon.do?pageIndex2=${start2}&${parm1}&${ parm2}">before</a>
				</c:if>

				<c:forEach var="i" begin="${ start}" end="${last }">
					<c:if test="${i ==pageIndex2}">
						<span style="font-size: 13px; color: #E03968;">${i }</span>
					</c:if>
					<c:if test="${i !=pageIndex2}">
						<a href="/adminCoupon.do?pageIndex2=${i}&${parm1}&${ parm2}">${i}</a>
					</c:if>
				</c:forEach>

				<fmt:parseNumber var="last2" integerOnly="true" value="${last+1}" />
				<c:if test="${last2 <=paginationInfo2.getTotalPageCount()}">
					<a href="/adminCoupon.do?pageIndex2=${last2}&${parm1}&${ parm2}">next</a>
				</c:if>
			</div>
		</td>
	</tr>
</table>

<hr class="coupon"/>
<br/>
<form id="frm2" name="frm2">
<input type="hidden" name="ccode1" id="ccode1"/>
<table style="width:100%;">
	<tr>
		<td style="text-align:left;">
			<button type="button" id="btnList" class="white">목록</button>
		</td>
		<td style="font-weight: bold; text-align:right;">
         <select name="searchCondition">
            <option value="userid">아이디</option>
            <option value="name">이름</option>
         </select>
         <input type="text" name="searchKeyword" id="searchKeyword">
         <button type="button" id="btnSearch" class="white">검색</button>
      </td>
   </tr>
</table>
<table class="board" style="margin-top:5px;">
	<tr class="board" style="height:30px;">
		<td width="5%" class="head" style="text-align:center;"><input type="checkbox" id="checkAll"></td>
		<th width="15%" class="head">ID</th>
		<th width="10%" class="head">NAME</th>
		<th width="15%" class="head">PHONE</th>
		<th width="15%" class="head">BIRTHDAY</th>
		<th width="25%" class="head">E-MAIL</th>
		<th width="15%" class="head">J-DATE</th>
	</tr>
	<c:forEach var="result" items="${list2}" varStatus="status">
	<tr class="board" style="height:30px; text-align:center;">
		<td><input type="checkbox" name="check" id="check" class="check" value="${result.userid}"/></td>
		<td>${result.userid}</td>
		<td>${result.name}</td>
		<td>${result.phone}</td>
		<td>${result.birthday}</td>
		<td>${result.email}</td>
		<td >${result.joindate}</td>
	 </tr>
	</c:forEach>
</table>
</form>
<br>
<c:set var="pageIndex" value="<%=pageIndex%>" />
<c:set var="totalPage" value="${paginationInfo.getTotalPageCount() }" />
<table border="0" width="100%">
	<tr>
		<td align="center" style="board:0px;">
			<div id="paging">
				<c:set var="parm1"
					value="searchCondition=${searchVO.getSearchCondition() }" />
				<c:set var="parm2"
					value="searchKeyword=${searchVO.getSearchKeyword()}" />
				<c:set var="a" value="${(pageIndex-1)/5-((pageIndex-1)/5%1)}" />
				<fmt:parseNumber var="a" integerOnly="true" value="${a}" />
				<c:set var="start" value="${a*5+1}" />
				<c:set var="last" value="${start+4}" />

				<c:if test="${last>paginationInfo.getTotalPageCount() }">
					<c:set var="last" value="${paginationInfo.getTotalPageCount() }" />
				</c:if>

				<fmt:parseNumber var="start2" integerOnly="true" value="${start-1}" />
				<c:if test="${start2 >0}">
					<a href="/adminCoupon.do?pageIndex=${start2}&${parm1}&${ parm2}">before</a>
				</c:if>

				<c:forEach var="i" begin="${ start}" end="${last }">
					<c:if test="${i ==pageIndex}">
						<span style="font-size: 13px; color: #E03968;">${i }</span>
					</c:if>
					<c:if test="${i !=pageIndex}">
						<a href="/adminCoupon.do?pageIndex=${i}&${parm1}&${ parm2}">${i}</a>
					</c:if>
				</c:forEach>

				<fmt:parseNumber var="last2" integerOnly="true" value="${last+1}" />
				<c:if test="${last2 <=paginationInfo.getTotalPageCount()}">
					<a href="/adminCoupon.do?pageIndex=${last2}&${parm1}&${ parm2}">next</a>
				</c:if>
			</div>
		</td>
	</tr>
</table>

<div style="height:100px;">
</div>
