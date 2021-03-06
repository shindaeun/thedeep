<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
$(function() {
	$("#btnList").click(function() {
		location.href = "/orderList.do";
	});
	$("#btnWrite").click(function() {
		var form = $("#frm").serialize();
		$.ajax({
			type : "POST",
			data: form,
			url : "/transSave.do",
			success : function(data) {
				if (data.result == "ok") {
					alert("변경하였습니다.");
					location.href = "/orderList.do";
				}
				else {
					alert("변경 실패했습니다. 다시 시도해 주세요.");
				}
			},
			error: function (request,status,error) {
            	  alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
              }
		});
	});
	$("#btnPayChk").click(function() {
		var form = $("#frm").serialize();
		$.ajax({
			type : "POST",
			data: form,
			url : "/payCheck.do",
			success : function(data) {
				if (data.result == "ok") {
					alert("변경하였습니다.");
					location.href = "/orderList.do";
				}
				else {
					alert("변경 실패했습니다. 다시 시도해 주세요.");
				}
			},
			error: function (request,status,error) {
            	  alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
              }
		});
	});
});
$(window).load(function () {
    $(".gubun").each(function () {
        var rows = $(".gubun:contains('" + $(this).text() + "')");
        if (rows.length > 1) {
          rows.eq(0).attr("rowspan", rows.length);
          rows.not(":eq(0)").remove();
        }
    });
});
function iamportCancelPart(ocode, cscode) {
	var param = "ocode=" + ocode + "&cscode=" + cscode;
	$.ajax({
		type : "POST",
		data : param,
		url : "/iamportCancelPart.do",
		success : function(data) {
			if (data.result == "ok") {
				alert("취소하였습니다.");
				location.href = "/orderList.do";
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
function depositCancelPart(ocode, cscode) {
	var param = "ocode=" + ocode + "&cscode=" + cscode;
	$.ajax({
		type : "POST",
		data : param,
		url : "/depositCancelPart.do",
		success : function(data) {
			if (data.result == "ok") {
				alert("취소하였습니다.");
				location.href = "/orderList.do";
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
</script>

<table class="top">
   <tr class="top">
      <td class="top">주문상세조회</td>
   </tr>
</table>

	<table>
		<button type="button" class="white" id="btnList">목록</button>
	</table>

<form name="frm" id="frm">
<table class="board" id="order">
	<tr class="board">
		<th width="10%" >상품명(buy state)</th>
		<th width="15%" >품목코드(개)</th>
		<!-- <th width="10%" >총금액</th> -->
		<th width="10%" >결제방법(입금자명)</th>
		<th width="15%" >사용포인트/적립포인트/쿠폰</th>
		<th width="10%" >배송상태</th>
		<th width="10%" >운송장번호</th>
	</tr>
	<c:forEach var="i" items="${olist }">
		<tr class="board" align="center">
			<td>${i.pname }<br>( ${i.buyconfirm } )<br>
			<c:if test="${i.buyconfirm=='취소요청' }">
				<c:if test="${i.paymethod=='신용카드' }">
				<button type="button"
								onclick="iamportCancelPart('${i.ocode}','${i.cscode}');"
								class="white">부분취소</button>
				</c:if>
				<c:if test="${i.paymethod=='무통장입금' }">
				<button type="button"
								onclick="depositCancelPart('${i.ocode}','${i.cscode}');"
								class="white">부분취소</button>
				</c:if>
			</c:if>
			</td>
			<td>${i.cscode }(${i.amount }개/<fmt:formatNumber value="${i.sum}" type="number"/>원)</td>	
			<td class="gubun">${i.paymethod }
			<c:if test="${i.depositname !=null}">(${i.depositname })</c:if>
			</td>
			<td class="gubun">${i.usepoint }/${i.savepoint }
			<c:if test="${i.usecoupon !=null}">/${i.usecoupon }</c:if>
			</td>
			<td class="gubun">${i.dstate }<c:if test="${i.dstate=='입금전' }"><button type="button" class="white" id="btnPayChk">입금확인</button></c:if></td>
			<td class="gubun">
			<input type="hidden" name="ocode" value="${i.ocode }"/>
			<input type="text" name="transportnum" size="10" value="${i.transportnum }"/>
			<button type="button" class="white" id="btnWrite">입력</button>
			</td>
		</tr>
	</c:forEach>
</table>
<br>
</form>