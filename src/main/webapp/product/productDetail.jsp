<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.io.File"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.awt.Image"%>
<%@page import="javax.swing.ImageIcon"%>
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
<c:set var="mainfile" value="${pvo.mainfile }" />
<%
	int x = 0, y = 0;
	String mainfile = (String) pageContext.getAttribute("mainfile");
	File file = new File(
			"C:/eGovFrameDev-3.7.0-64bit/workspace/thedeep/src/main/webapp/productImages/" + mainfile);
	if (!mainfile.equals(null) && !mainfile.equals("") && file.exists()) {
		BufferedImage img = ImageIO.read(file);
		int imgWidth = img.getWidth(null);
		int imgHeight = img.getHeight(null);

		if (imgWidth > imgHeight) {
			x = 350;
			y = (imgHeight * 350) / imgWidth;
		} else {
			y = 350;
			x = (imgWidth * 350) / imgHeight;
		}
	}
%>
<script>
	var num_rows = 0;
	var new_row_num = 0;
	function add_new_row(obj, cscode,stock) {
		$("#num_rows").val(++num_rows);
		var tag = ""
		tag += "<tr bgcolor=\"#ffffff\" id=\"tr_id" + (new_row_num) + "\">\n";
		tag += "<td align=\"center\">" + (cscode) + "</td>\n";
		tag += "<td>\n";
		tag += "<input type=\"hidden\" name=\"cscode\" id=\"cma_num"
				+ (new_row_num) + "\" value=\"" + (cscode) + "\" />\n";
		tag += "<input type=\"hidden\" name=\"stock\" id=\"stock_num"
				+ (new_row_num) + "\" value=\"" + (stock) + "\" />\n";
		tag += "<input type=\"text\" class=\"ordernum\"name=\"amount\"  size='1' id=\"cma_text"
				+ (new_row_num) + "\" value=\"1\" readonly/>개\n";
		tag += "<button type=\"button\" class=\"white\"name=\"plus\" onclick=\"fncnt('+',"
				+ new_row_num + ")\">+</button>";
		tag += "<button type=\"button\" class=\"white\"name=\"minus\" onclick=\"fncnt('-',"
				+ new_row_num + ")\">-</button>";
		tag += "</td>\n";
		tag += "</td>\n";
		tag += "<td>\n";
		tag += "<button type=\"button\" class='white' onclick=\"deleterow('cma_text[]','cma_num[]','cma_text_value','tr_id',"
				+ (new_row_num) + ");\" >삭제</button>\n";
		tag += "</td>\n";
		tag += "</tr>\n";

		$("#" + obj).append(tag);
		new_row_num++;
	}

	function deleterow(ctext, cnum, tval, obj, n) {
		$("#" + obj + n).remove();
		$("#num_rows").val(--num_rows);
	}
	function disableCheck(obj) {
		if (obj[obj.selectedIndex].className == 'disabled') {
			alert("다른 상품을 선택해주세요.");
			for (var i = 0; obj[i].className == "disabled"; i++)
				;
			obj.selectedIndex = 0;
			return;
		}
		else {
			var cscodes = document.getElementsByName("cscode");
			for(var i=0;i<cscodes.length;i++){
				if(cscodes[i].value==$("#selectoption").val()){
					alert("상품이 이미 추가되어 있습니다.");return;
				}
			}
			var cscode = $("#selectoption").val();
			var stock = document.getElementById(cscode).value;
			add_new_row('table_list', $("#selectoption").val(),stock);
			
			
		}

	}
	function fun1() {
		if ($('#table_list tr').length == 0) {
			alert("상품을 선택해주세요")
		} else {

			$("#frm").attr({
				method : 'post',
				action : '/orderNow.do'
			}).submit();
		}
	}
	function fun2() {
		if ($('#table_list tr').length == 0) {
			alert("상품을 선택해주세요")
		} else {

			var formData = $("#frm").serialize();
			$.ajax({
				type : "POST",
				data: formData,
				url : "/addCart.do",
				success : function(data) {
					if (data.result == "ok") {
						alert("장바구니에 담겼습니다.");
					}
					else {
						alert("장바구니에 담기 실패했습니다. 다시 시도해 주세요.");
					}
				},
				error: function (request,status,error) {
	            	  alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	              }
			});
		}
	}
	function fnSurvey() {
		$("#frm2").attr({
			method : 'post',
			action : '/productDetail.do'
		}).submit();
	}
	$(document).ready(
			function() {
				jQuery(".content").hide();
				//content 클래스를 가진 div를 표시/숨김(토글)
				$(".heading").click(
						function() {
							$(".content").not(
									$(this).next(".content").slideToggle(500))
									.slideUp();
						});
			});
	function fncnt(a, row_num) {
		var now_num = parseInt($("#cma_text" + row_num).val());
		var now_stock = parseInt($("#stock_num" + row_num).val());
		if (a == "+" && now_num <= now_stock) {
			if (now_num == now_stock) {
				alert("재고량보다 많습니다. 재고량["+now_stock+"개]");
			} else {
				$("#cma_text" + row_num).val(now_num + 1);

			}
		} else if (a == "-" && now_num >= 1) {
			if (now_num == 1) {
				alert("1개 이하 구매 불가능합니다.");
			} else {
				$("#cma_text" + row_num).val(now_num - 1);
			}
		}

	}

</script>

<style type="text/css">
option.disabled {
	color: lightgrey;
}

.layer1 {
	margin: 0;
	padding: 0;
	width: 500px;
}

p.heading {
	margin: 1px;
	padding: 3px 10px;
	cursor: pointer;
	position: relative;
}

.content {
	padding: 5px 10px;
}

p {
	padding: 5px 0;
}
</style>

<table class="board">
	<tr class="board">
		<td align="center" rowspan="8" width="50%"><img
			src="/productImages/${pvo.mainfile }" width="<%=x %>"
			height="<%=y %>" /></td>
		<td>상품명</td>
		<td>${pvo.pname }</td>
	</tr>
	<tr class="board">
		<td>가격</td>
		<td>${pvo.price }</td>
	</tr>
	<tr class="board">
		<td>적립금</td>
		<td>${pvo.point }</td>
	</tr>
	<tr class="board">
		<td>옵션</td>
		<c:forEach var="i" items="${oplist }">
		<input type="hidden" id="${i.seloption }" value="${i.amount }" disabled/> 
		</c:forEach>
		<td><select onchange="disableCheck(this)" id="selectoption">
				<option class=disabled>옵션을 선택해주세요.</option>
				<c:forEach var="i" items="${oplist }">
					<option value="${i.seloption }"
						<c:if test="${i.amount<1 }"> class=disabled</c:if>>${i.seloption }<c:if
							test="${i.amount<1 }"> 품절</c:if></option>
				</c:forEach>
		</select></td>
	</tr>
	<tr class="board">
		<td>FIT</td>
		<td>
			<form id="frm2">
				<input type="hidden" name="pcode" value="${pvo.pcode }" /> <select
					name="height" id="height">
						<option value="140-145"
							<c:if test="${vo.height=='140-145'}">selected</c:if>>140-145cm</option>
						<option value="145-150"
							<c:if test="${rvo.height=='145-150'}">selected</c:if>>145-150cm</option>
						<option value="150-155"
							<c:if test="${rvo.height=='150-155'}">selected</c:if>>150-155cm</option>
						<option value="155-160"
							<c:if test="${rvo.height=='155-160'}">selected</c:if>>155-160cm</option>
						<option value="160-165"
							<c:if test="${rvo.height=='160-165'}">selected</c:if>>160-165cm</option>
						<option value="165-170"
							<c:if test="${rvo.height=='165-170'}">selected</c:if>>165-170cm</option>
						<option value="170-175"
							<c:if test="${rvo.height=='170-175'}">selected</c:if>>170-175cm</option>

				</select> <select name="weight" id="weight">
						<option value="40-45"
							<c:if test="${vo.weight=='40-45'}">selected</c:if>>40-45kg</option>
						<option value="45-50"
							<c:if test="${rvo.weight=='45-50'}">selected</c:if>>45-50kg</option>
						<option value="50-55"
							<c:if test="${rvo.weight=='50-55'}">selected</c:if>>50-55kg</option>
						<option value="55-60"
							<c:if test="${rvo.weight=='55-60'}">selected</c:if>>55-60kg</option>
						<option value="60-65"
							<c:if test="${rvo.weight=='60-65'}">selected</c:if>>60-65kg</option>
						<option value="65-70"
							<c:if test="${rvo.weight=='65-70'}">selected</c:if>>65-70kg</option>
						<option value="70-75"
							<c:if test="${rvo.weight=='70-75'}">selected</c:if>>70-75kg</option>
						<option value="75-80"
							<c:if test="${rvo.weight=='75-80'}">selected</c:if>>75-80kg</option>

				</select> 구매 사이즈 : <select name="psize" id="psize">
					<option value="S" <c:if test="${rvo.psize=='S'}">selected</c:if>>S</option>
					<option value="M" <c:if test="${rvo.psize=='M'}">selected</c:if>>M</option>
					<option value="L" <c:if test="${rvo.psize=='L'}">selected</c:if>>L</option>
					<option value="F" <c:if test="${rvo.psize=='F'}">selected</c:if>>free</option>
				</select>
				<button type="button" id="btnCheck" class="white"
					onclick="fnSurvey()">check</button>
			</form>
		</td>
	</tr>
	<tr class="board">
		<td>설문조사</td>
		<td><c:if test="${surveylist.size()==0 }">리뷰가  없습니다.</c:if> <c:if
				test="${surveylist!=null }">
				<c:forEach var="i" items="${surveylist }">

					<p style="width: 40%;">
						<c:if test="${i.fit=='VB'}">매우큼</c:if>
						<c:if test="${i.fit=='B'}">큼</c:if>
						<c:if test="${i.fit=='F'}">딱맞음</c:if>
						<c:if test="${i.fit=='S'}">작음</c:if>
						<c:if test="${i.fit=='VS'}">매우작음</c:if>
					<div
						style="width: ${100.0*i.cnt/i.total}%; height: 5px; background: skyblue; float: left;"></div>
					<div style="width: 50px;">(${100.0*i.cnt/i.total}%)</div>
				</c:forEach>
			</c:if></td>
	</tr>
	<tr class="board">
		<th colspan="2"><button type="button" style="WIDTH: 100pt"
				id="btnBuy" class="white" onclick="fun1()">buy now</button>
			<button type="button" style="WIDTH: 100pt" " id="btnCart"
				class="white" onclick="fun2()">cart</button></th>
	</tr>
</table>
<form id="frm">
	<input type="hidden" name="pcode" value="${pvo.pcode }" />
	<table width="100%" id="table_list">
		<tbody>
		</tbody>
	</table>
</form>

<table class="board">
	<tr>
		<td style="text-align: center">${pvo.editor}</td>
	</tr>
</table>

<table>
	<tr>
		<th>qna</th>
	</tr>
</table>
<table class="line">
	<tr class="line">
		<td class="line"></td>
	</tr>
</table>
<div>
	<br>
	<table style="width: 100%">
		<tr>
			<td style="border: 0px; text-align: right;">
				<button type="button" class="white"
					onClick="location.href='/qnaWrite.do'">Write</button>
			</td>
		</tr>
	</table>
	<table class="board">
		<tr class="board">
			<th style="width: 10%;">NO</th>
			<th width="50%">SUBJECT</th>
			<th width="30%">DATE</th>
			<th width="10%">HIT</th>
		</tr>
		<c:forEach var="i" items="${qlist }" varStatus="status">
			<tr class="board" align="center">
				<td>${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}</td>
				<td><p class="heading">${i.title}</p>
					<div class="content">
						<%
							pageContext.setAttribute("newLine", "\n"); //Space, Enter
								pageContext.setAttribute("br", "<br/>"); //br 태그
						%>
						${fn:replace(i.content,newLine,br)} <br>
						<button type="button" class="white"
							onClick="location.href='/qnaModify.do?unq=${i.unq}'">수정</button>
					</div></td>
				<td>${i.rdate}</td>
				<td>${i.hit}</td>
			</tr>
		</c:forEach>
	</table>
</div>
<c:set var="pageIndex" value="<%=pageIndex%>" />
<c:set var="totalPage" value="${paginationInfo.getTotalPageCount() }" />
<table border="0" width="800">
	<tr>
		<td style="border: 0px; text-align: center">
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
					<a href="/productDetail.do?pageIndex=${start2}&pcode=${pvo.pcode}">before</a>
				</c:if>

				<c:forEach var="i" begin="${ start}" end="${last }">
					<c:if test="${i ==pageIndex}">
						<span style="font-size: 13px; color: red;">${i }</span>
					</c:if>
					<c:if test="${i !=pageIndex}">
						<a href="/productDetail.do?pageIndex=${i}&pcode=${pvo.pcode}">${i}</a>
					</c:if>
				</c:forEach>

				<fmt:parseNumber var="last2" integerOnly="true" value="${last+1}" />
				<c:if test="${last2 <=paginationInfo.getTotalPageCount()}">
					<a href="/productDetail.do?pageIndex=${last2}&pcode=${pvo.pcode}">next</a>
				</c:if>
		</td>
	</tr>
</table>
<br>
<br>
<br>
<table>
	<tr>
		<th>review</th>
	</tr>
</table>
<table class="line">
	<tr class="line">
		<td class="line"></td>
	</tr>
</table>
<br>
<table style="width: 100%">
	<tr>
		<td style="border: 0px; text-align: right;">
			<button type="button" class="white"
				onClick="location.href='/userOrderList.do'">Write</button>
		</td>
	</tr>
</table>
<div class="">
	<table class="board">
		<tr class="board">
			<th width="10%">NO</th>
			<th width="50%">SUBJECT</th>
			<th width="30%">DATE</th>
			<th width="10%">HIT</th>
		</tr>
		<c:forEach var="i" items="${rlist }" varStatus="status">
			<tr class="board" align="center">
				<td>${paginationInfo2.totalRecordCount+1 - ((searchVO.pageIndex2-1) * searchVO.pageSize + status.count)}</td>
				<td><p class="heading">${i.title}</p>
					<div class="content">
						<%
							pageContext.setAttribute("newLine", "\n"); //Space, Enter
								pageContext.setAttribute("br", "<br/>"); //br 태그
						%>
						${fn:replace(i.content,newLine,br)}<br>
						<button type="button" class="white"
							onClick="location.href='/reviewModify.do?unq=${i.unq}'">수정</button>
					</div></td>
				<td>${i.rdate}</td>
				<td>${i.hit}</td>
			</tr>
		</c:forEach>
	</table>
</div>
<br>
<c:set var="pageIndex2" value="<%=pageIndex2%>" />
<c:set var="totalPage" value="${paginationInfo2.getTotalPageCount() }" />
<table border="0" width="800">
	<tr>
		<td style="border: 0px; text-align: center">
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
					<a href="/productDetail.do?pageIndex2=${start2}&pcode=${pvo.pcode}">before</a>
				</c:if>

				<c:forEach var="i" begin="${ start}" end="${last }">
					<c:if test="${i ==pageIndex2}">
						<span style="font-size: 13px; color: red;">${i }</span>
					</c:if>
					<c:if test="${i !=pageIndex2}">
						<a href="/productDetail.do?pageIndex2=${i}&pcode=${pvo.pcode}">${i}</a>
					</c:if>
				</c:forEach>

				<fmt:parseNumber var="last2" integerOnly="true" value="${last+1}" />
				<c:if test="${last2 <=paginationInfo2.getTotalPageCount()}">
					<a href="/productDetail.do?pageIndex2=${last2 }&pcode=${pvo.pcode}">next</a>
				</c:if>
		</td>
	</tr>
</table>
