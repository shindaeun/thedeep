<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	$(window).load(function() {
		$(".gubun").each(function() {
			var rows = $(".gubun:contains('" + $(this).text() + "')");
			if (rows.length > 1) {
				rows.eq(0).attr("rowspan", rows.length);
				rows.not(":eq(0)").remove();
			}
		});
	});
	$(function() {
		$("#btnConfirm").click(
				function() {
					var ocode = $(this).parent().parent().children().eq(0).text();
					alert(ocode);
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
		});
		$("#buyConfirm").click(
				function() {
					var ocode = $(this).parent().parent().parent().children().eq(1).children().eq(0).text();
					alert(ocode);
					var pcode = $(this).parent().children().eq(0).val();
					var param = "pcode="+pcode+"&ocode=" + ocode;
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
		});
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
								location.href = "/iamportList.do";
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
	
</script>

<table class="top">
	<tr class="top">
		<td class="top">order list</td>
	</tr>
</table>

<c:set var="total" value="1" />
<table class="board">
	<tr class="board" style="height: 30px;">
		<th>ORDER CODE</th>
		<th>ITEM</th>
		<th>DATE</th>
		<th>STATE</th>
	</tr>
	<c:forEach var="list" items="${list}" varStatus="status">
		<tr class="board" style="height: 30px; text-align: center;">
			<td class="gubun">${list.ocode}</td>
			<td>${list.pname}</td>
			<td>${list.odate}</td>
			<td>${list.dstate}<c:if test="${list.dstate=='결제완료' }"> &nbsp;&nbsp;
					<c:if test="${list.paymethod=='신용카드' }">
						<button type="button" id="btnCancel" class="white">취소</button>
					</c:if>
				</c:if> <c:if test="${list.dstate=='배송중' }"> &nbsp;&nbsp;
					<button type="button" id="btnConfirm" class="white">배송확인</button>
				</c:if> 
				<c:if test="${list.dstate=='배송완료' }">
					<c:if test="${list.buyconfirm=='N' }"> &nbsp;&nbsp;
						<input type="hidden" value="${list.pcode }" disabled/>
						<button type="button" class="white" id="buyConfirm">구매확정</button>
					</c:if>
					<c:if test="${list.buyconfirm=='Y' }">
						<c:if test="${list.reviewconfirm=='N' }"> &nbsp;&nbsp;
					<button type="button" class="white"
								onclick="location.href='/reviewWrite.do?pcode=${list.pcode}&ocode=${list.ocode }'">리뷰쓰기</button>
						</c:if>
					</c:if>
				</c:if>
				<c:if test="${list.dstate=='구매확정' }">
					<c:if test="${list.reviewconfirm=='N' }"> &nbsp;&nbsp;
					<button type="button" class="white"
								onclick="location.href='/reviewWrite.do?pcode=${list.pcode}&ocode=${list.ocode }'">리뷰쓰기</button>
					</c:if>
				</c:if>

			</td>
		</tr>
	</c:forEach>
</table>
