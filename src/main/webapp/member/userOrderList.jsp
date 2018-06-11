<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	String pageIndex = request.getParameter("pageIndex");
	if (pageIndex == null)
		pageIndex = "1";
	if (Integer.parseInt(pageIndex) < 0)
		pageIndex = "1";
%>

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
	$("#btnCancel").click(
			function() {
				var btn = $(this);
				var tr = btn.parent().parent();
				var td = tr.children();
				var merchant_uid = td.eq(0).text();
				var param = "merchant_uid=" + merchant_uid;

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
			});

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
		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
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
function submit(i){
	$("#frm").attr({
		method : 'post',
		action : '/userOrderList.do?pageIndex='+i
	}).submit();
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
<c:set var="pageIndex" value="<%=pageIndex%>" />
<c:set var="totalPage" value="${paginationInfo.getTotalPageCount() }" />
<table border="0" width="100%">
	<tr>
		<td align="center" style="board:0px;">
			<div id="paging">
				<c:set var="a" value="${(pageIndex-1)/5-((pageIndex-1)/5%1)}" />
				<fmt:parseNumber var="a" integerOnly="true" value="${a}" />
				<c:set var="start" value="${a*5+1}" />
				<c:set var="last" value="${start+4}" />

				<c:if test="${last>paginationInfo.getTotalPageCount() }">
					<c:set var="last" value="${paginationInfo.getTotalPageCount() }" />
				</c:if>

				<fmt:parseNumber var="start2" integerOnly="true" value="${start-1}" />
				<c:if test="${start2 >0}">
					<a href="#" onclick="submit(${start2});">before</a>
				</c:if>

				<c:forEach var="i" begin="${ start}" end="${last }">
					<c:if test="${i ==pageIndex}">
						<span style="font-size: 13px; color: red;">${i }</span>
					</c:if>
					<c:if test="${i !=pageIndex}">
						<a href="#" onclick="submit(${i});">${i}</a>
					</c:if>
				</c:forEach>

				<fmt:parseNumber var="last2" integerOnly="true" value="${last+1}" />
				<c:if test="${last2 <=paginationInfo.getTotalPageCount()}">
					<a href="#" onclick="submit(${last2});">next</a>
				</c:if>
			</div>
		</td>
	</tr>
</table>
