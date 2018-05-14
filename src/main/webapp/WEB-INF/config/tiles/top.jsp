<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
$(function() { 
	$("#btnLogout").click(function() { 
		$.ajax({
			type:'POST',
			data:'',
			url:"/logout.do",
			dataType:"json",
			success:function(data) {
				alert("로그아웃 처리 완료");
				location.href="/home.do";
			},
			error:function(error) {
				alert("error:"+error);
			}
		});
	});
});

</script>

<div>
    <div class="w-row">
      <div class="column-4 w-col w-col-3">
        <h1 class="heading">TheDeep</h1>
      </div>
      <div class="w-col w-col-9">
        <div data-collapse="medium" data-animation="default" data-duration="400" class="navbar w-nav">
          <div class="container w-container">
            <nav role="navigation" class="w-nav-menu">
            <c:if test="${sessionScope.AconLoginCert.AconUserId == null}">	
            <a href="/login.do" class="w-nav-link">Login</a>
            <a href="/memberInfo.do" class="w-nav-link">Join</a>
            </c:if>
            <c:if test="${sessionScope.AconLoginCert.AconUserId != null}">
            <a href="#" class="w-nav-link"><span id="btnLogout">Logout</span></a>
            </c:if>
            <a href="#" class="w-nav-link">Cart</a>
            <a href="/myPage.do" class="w-nav-link">My Page</a></nav>
            <div class="w-nav-button">
              <div class="w-icon-nav-menu"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>