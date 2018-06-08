<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	 $(window).load(function() {
		$(".gubun").each(function() {
			var rows = $(".gubun:contains('" + $(this).text() + "')");
			//var date = rows.parent().children();
			if (rows.length > 1) {
				rows.eq(0).attr("rowspan", rows.length);
				//var d = date.eq(2).text();
				
				rows.not(":eq(0)").remove();
				/* alert(rows.not(":eq(0)").text());
				date.eq(2).attr("rowspan", rows.length);
		
				date.eq(2).not(":eq(0)").remove();
				alert(date.eq(2).not(":eq(0)").text());
				//date.eq(3).not(":eq(0)").remove(); */
			}
		});
	}); 

	$(function() {
		

	});
	function cancelAlert(ocode) {
		var param = "ocode=" + ocode;
		$.ajax({
			type : "POST",
			data : param,
			url : "/CancelAlert.do",
			success : function(data) {
				if (data.result == "ok") {
					alert("취소요청하였습니다.");
					location.href = "/userOrderList.do";
				} else {
					alert("취소요청실패했습니다. 다시 시도해 주세요.");
				}
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		});
	}
 	function CancelAlert2(ocode, cscode) {
		var param = "ocode=" + ocode + "&cscode=" + cscode;
		$.ajax({
			type : "POST",
			data : param,
			url : "/CancelAlert2.do",
			success : function(data) {
				if (data.result == "ok") {
					alert("취소요청하였습니다.");
					location.href = "/userOrderList.do";
				} else {
					alert("취소요청실패했습니다. 다시 시도해 주세요.");
				}
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		});
	}
	function iamportCancelPart(ocode, cscode) {
		var param = "ocode=" + ocode + "&cscode=" + cscode;
		$.ajax({
			type : "POST",
			data : param,
			url : "/iamportCancelPart.do",
			success : function(data) {
				if (data.result == "ok") {
					alert("취소하였습니다.");
					location.href = "/userOrderList.do";
				} else {
					alert("취소실패했습니다. 다시 시도해 주세요.");
				}
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		});
	}
	function iamportCancel(ocode) {
		var param = "merchant_uid=" + ocode;
		$.ajax({
			type : "POST",
			data : param,
			url : "/iamportCancel.do",
			success : function(data) {
				if (data.result == "ok") {
					alert("취소하였습니다.");
					location.href = "/userOrderList.do";
				} else {
					alert("취소실패했습니다. 다시 시도해 주세요.");
				}
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:"
						+ error);
			}
		});
	}
				
	function deliConfirm(ocode) {
		var param = "dstate=배송완료&ocode=" + ocode;
		$.ajax({
			type : "POST",
			data : param,
			url : "/updateDstate.do",
			success : function(data) {
				if (data.result == "ok") {
					alert("배송완료하였습니다.");
					location.href = "/userOrderList.do";
				} else {
					alert("배송완료 실패했습니다. 다시 시도해 주세요.");
				}
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:"
						+ error);
			}
		});
	}
	function buyConfirm(ocode,pcode) {
		var param = "pcode=" + pcode + "&ocode=" + ocode;
		$.ajax({
			type : "POST",
			data : param,
			url : "/buyConfirm.do",
			success : function(data) {
				if (data.result == "ok") {
					alert("구매확정하였습니다.");
					location.href = "/userOrderList.do";
				} else {
					alert("구매확정실패");
				}
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:"
						+ error);
			}
		});
	}
</script>
<table class="top">
	<tr class="top">
		<td class="top">order list</td>
	</tr>
</table>
<c:set var="total" value="1" />
<c:set var="index" value="0" />
<table class="board">
	<tr class="board" style="height: 30px;">
		<th>DATE</th>
		<th>ORDER CODE</th>
		<th>ITEM</th>
		<th>STATE</th>
	</tr>
	<c:forEach var="list" items="${list}" varStatus="status">
		<tr class="board" style="height: 30px; text-align: center;">
			<td  class="gubun">${list.odate}</td>
			<td class="gubun"> 
			${list.ocode}
			<c:if test="${list.dstate=='결제완료' }"> &nbsp;&nbsp;
				<c:if test="${clist.get(index).cnt<1  }">
					<c:if test="${list.paymethod=='신용카드' }">
						<br>
						<button type="button" onclick="iamportCancel('${list.ocode}');" class="white">취소</button>
					</c:if>
					<c:if test="${list.paymethod=='무통장입금' }">
						<c:if test="${list.adminmemo!='취소요청' }">
							<br>
							<button type="button" class="white" onclick="cancelAlert('${list.ocode}');"
								>취소요청하기</button>
						</c:if>
						<c:if test="${list.adminmemo=='취소요청' }">
							<br>
						(취소 대기 중)
					</c:if>
					</c:if>
				</c:if>
			</c:if>
			</td>
			<td>${list.pname}</td>
			<td>${list.dstate}
			<c:if test="${list.dstate=='결제완료' }"> &nbsp;&nbsp;
					<c:if test="${list.paymethod=='신용카드' }">
						<c:if test="${list.buyconfirm!='C' }">
							<button type="button"
								onclick="iamportCancelPart('${list.ocode}','${list.cscode}');"
								class="white">부분취소</button>
						</c:if>
					</c:if>
					<c:if test="${list.paymethod=='무통장입금' }">
						<c:if test="${list.buyconfirm!='C' }">
						<c:if test="${list.buyconfirm!='취소요청' }">
							<button type="button"
								onclick="CancelAlert2('${list.ocode}','${list.cscode}');"
								class="white">부분취소요청</button>
						</c:if>
						</c:if>
					</c:if>


				</c:if> <c:if test="${list.dstate=='배송중' }"> &nbsp;&nbsp;
					<c:if test="${list.buyconfirm!='C' }">
					<button type="button" onclick="deliConfirm('${list.ocode}')" class="white">배송확인</button>
					</c:if>
				</c:if> 
				<c:if test="${list.dstate=='배송완료' }">
					<c:if test="${list.buyconfirm=='N' }"> &nbsp;&nbsp;
						<input type="hidden" value="${list.pcode }" disabled />
						<button type="button" class="white" onclick="buyConfirm('${list.ocode}','${list.pcode}')">구매확정</button>
						<button type="button"
								onclick="CancelAlert2('${list.ocode}','${list.cscode}');"
								class="white">부분취소요청</button>
					</c:if>
					
					<c:if test="${list.buyconfirm=='Y' }">
						<c:if test="${list.reviewconfirm=='N' }"> &nbsp;&nbsp;
						<button type="button" class="white"
								onclick="location.href='/reviewWrite.do?pcode=${list.pcode}&ocode=${list.ocode }'">리뷰쓰기</button>
						</c:if>
					</c:if>
				</c:if> 
				
				<c:if test="${list.dstate=='구매확정' }">
					<c:if test="${list.buyconfirm=='Y' }">
						<c:if test="${list.reviewconfirm=='N' }"> &nbsp;&nbsp;
					<button type="button" class="white"
								onclick="location.href='/reviewWrite.do?pcode=${list.pcode}&ocode=${list.ocode }'">리뷰쓰기</button>
						</c:if>
					</c:if>
				</c:if>
			<c:if test="${list.buyconfirm=='취소요청' }">
						( 취소 대기 중 )
						</c:if>
						<c:if test="${list.buyconfirm=='C' }">
						( 부분취소완료 )
						</c:if>
			<c:set var="index" value="${index+1 }" />
			</td>
		</tr>
	</c:forEach>
</table>
<table border="0" width="100%">
	<tr>
		<td align="center" style="board:0px;">
			<div id="paging">
			<c:set var="parm1" value="searchCondition=${searchVO.getSearchCondition()}"/>
			<c:set var="parm2" value="searchKeyword=${searchVO.getSearchKeyword()}"/>
			<c:forEach var="i" begin="1" end="${paginationInfo.getTotalPageCount()}">
				<a href="/userOrderList.do?pageIndex=${i}&${parm1}&${parm2}">${i}</a>
			</c:forEach>
			</div>
		</td>
	</tr>
</table>
