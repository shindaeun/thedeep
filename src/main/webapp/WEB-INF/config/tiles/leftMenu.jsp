<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

        <div data-collapse="medium" data-animation="default" data-duration="400" class="w-nav">
          <div class="container-8 w-container">
            <nav role="navigation" class="nav-menu-2 w-nav-menu">
            <a href="/best50List.do" class="nav-link-12 w-nav-link">best50</a>
            <%-- <c:set var="a" value="2"/>
            <c:forEach var="i" items="${group}" varStatus="status">
            <c:set var="a" value="${a+1}"/>
			 <a href="/productList.do?gcode=${i.gcode}" class="nav-link-1${a} w-nav-link">${i.gname}</a>
			</c:forEach> --%>
            <a href="/productList.do?gcode=g001" class="nav-link-13 w-nav-link">outer</a>
            <a href="/productList.do?gcode=g002" class="nav-link-14 w-nav-link">top</a>
            <a href="/productList.do?gcode=g003" class="nav-link-15 w-nav-link">bottom</a>
            <a href="/productList.do?gcode=g004" class="nav-link-16 w-nav-link">dress</a>
            <a href="/productList.do?gcode=g005" class="nav-link-17 w-nav-link">acc</a>
            <a href="/noticeList.do" class="nav-link-20 w-nav-link">notice</a>
            <a href="reviewList.do" class="nav-link-18 w-nav-link">review</a>
            <a href="qnaList.do" class="nav-link-19 w-nav-link">qna</a></nav>
            <div class="w-nav-button">
              <div class="w-icon-nav-menu"></div>
            </div>
          </div>
        </div>
