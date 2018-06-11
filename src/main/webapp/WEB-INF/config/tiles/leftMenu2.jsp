<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

        <div data-collapse="medium" data-animation="default" data-duration="400" class="w-nav">
          <div class="container-8 w-container">
            <nav role="navigation" class="nav-menu-2 w-nav-menu">
   			<a href="/theDeepAdmin.do"><img src="/images/deep-logo.png"/></a><br>
   			<c:if test="${sessionScope.ThedeepALoginCert.ThedeepAUserId != null}">
   			<!-- <a href="#" class="nav-link-12 w-nav-link">메인사진관리</a> -->
            <a href="/adminList.do" class="nav-link-14 w-nav-link">회원관리</a>
            <a href="/orderList.do" class="nav-link-14 w-nav-link">주문관리</a>
            <a href="/productListView.do" class="nav-link-14 w-nav-link">상품관리</a>
            <a href="/group.do" class="nav-link-14 w-nav-link">상품그룹관리</a>
            <a href="/adminBoard.do" class="nav-link-14 w-nav-link">게시판관리</a>
            <a href="/adminNoticeList.do" class="nav-link-14 w-nav-link">공지사항</a>
            <br>
            <a href="/pointAdd.do" class="nav-link-18 w-nav-link">포인트관리</a>
            <a href="/adminCoupon.do" class="nav-link-18 w-nav-link">쿠폰관리</a>
            </c:if>
            <c:if test="${sessionScope.ThedeepALoginCert.ThedeepAUserId == null}">
            </c:if>
            </nav>
            <div class="w-nav-button">
              <div class="w-icon-nav-menu"></div>
            </div>
          </div>
        </div>