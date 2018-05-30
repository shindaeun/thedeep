<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
		var param = 'ccode=c01';
	 		// 비 동기 전송
			$.ajax({
				type: "POST",
				data: param,
				url: "/adminBtdCoupon.do",

				success: function(data) {
					if(data.result == "ok") {
						alert("발급되었습니다");
						location.href = "/adminCoupon.do";
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
});
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

a:link { text-decoration: none; color: #000000} 
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
		<th width="15%">
			code <input type="text" id="ccode" name="ccode" style="width:50%"/>
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
		<th width="10%">
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
			code <input type="text" id="ccode" name="ccode" style="width:50%" value="${vo.ccode}"/>
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

<table class="board">
	<tr class="board">
		<th class="head" style="width:5%">NO</th>
		<th class="head" style="width:10%">CODE</th>
		<th class="head" style="width:20%">COUPON NAME</th>
		<th class="head" style="width:20%">APPLYMONEY</th>
		<th class="head" style="width:10%">DISCOUNTRATE</th>
		<th class="head" style="width:20%">MAXDISCMONEY</th>
		<th class="head" style="width:8%;"></th>
		<th class="head" style="width:8%; border-left: 1px solid #555555;">////</th>
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
			<button type="button" id="btnDelete" class="white" >삭제</button>
		</th>
		<c:if test="${list.ccode=='c002'}">
		<th style="border-left: 1px solid #555555;">
			<button type="button" id="btnBTD" class="white" >발급</button>
		</th>
		</c:if>
		<c:if test="${list.ccode!='c002'}">
		<td style="border-left: 1px solid #555555;">
		</td>
		</c:if>
	</tr>
	</c:forEach>
</table>
</form>

<hr class="coupon"/>

<div style="height:100px;">
</div>
