<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>jQuery UI Spinner - Overflow</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="/js/jquery-1.12.4.js"></script>
<script src="js/jquery-ui.js"></script>
</head>
<script type="text/javascript">
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
		$("#btnNext").click(function() {

			var nex = ${next };
			if (nex==0) {
				alert("마지막페이지입니다.");	
				
			} else {
				location.href = "/iamportList.do?page=${next }";
				
			}
		});
		$("#btnBefore").click(function() {
			var bef = ${previous};

			if (bef == 0) {
				alert("마지막페이지입니다.");
			} else {

				location.href = "/iamportList.do?page=${previous}";
			}

		});
	});
</script>
<body>
	<div width="100%" align="right">
		<button type="button" id="btnBefore" class="white" value="${previous}">이전</button>
		&nbsp;
		<button type="button" id="btnNext" class="white" value="${next }">다음</button>
	</div>
	전체 개수 : ${total }
	<table class="board">
		<tr class="board">
			<th>주문번호</th>
			<th>구매자</th>
			<th>우편번호</th>
			<th>주소</th>
			<th>상태</th>
			<th>취소</th>
		</tr>
		<c:forEach var="i" items="${result}" varStatus="status">
			<tr class="board" align="center">
				<td>${i.merchant_uid }</td>
				<td>${i.buyer_name }</td>
				<td>${i.buyer_postcode }</td>
				<td>${i.buyer_addr }</td>
				<td>${i.status }</td>
				<td><c:if test="${i.status=='paid' }">
						<button type="button" id="btnCancel" class="white">취소</button>
					</c:if></td>
			</tr>
		</c:forEach>
	</table>

</body>
</html>