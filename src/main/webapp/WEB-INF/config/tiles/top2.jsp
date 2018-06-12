<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
$(function() { 

	$("#btnAdminLogout").click(function() { 
		if(confirm("로그아웃하시겠습니까?")) {
			$.ajax({
				type:'POST',
				data:'',
				url:"/adminLogout.do",
				dataType:"json",
				success:function(data) {
					alert("로그아웃 처리 완료");
					location.href="/theDeepAdmin.do";
				},
				error:function(error) {
					alert("error:"+error);
				}
			});
		}
	});
});

</script>
<style>
a:link { text-decoration: none; color: #000000; text-align: center} 
a:visited { text-decoration: none; color: #000000} 
a:active { text-decoration: none; color: #000000}
a:hover {text-decoration:underline; color: #000000}
</style>
<div>
    <div class="w-row">
      <div class="column-4 w-col w-col-3">
       <!--  <a href="/theDeepAdmin.do"><h1 class="heading">TheDeep</h1></a> -->
      </div>
      <div class="w-col w-col-9">
        <div data-collapse="medium" data-animation="default" data-duration="400" class="navbar w-nav">
          <div class="container w-container">
            <nav role="navigation" class="w-nav-menu">
            <c:if test="${sessionScope.ThedeepALoginCert.ThedeepAUserId != null}">
            <a href="#" class="w-nav-link2"><span id="btnAdminLogout">Logout</span></a>
            <a href="/adminInfo.do" class="w-nav-link2">Join</a>
            <a href="/adminModify.do" class="w-nav-link2">Profile</a>
            </c:if>
            <c:if test="${sessionScope.ThedeepALoginCert.ThedeepAUserId == null}">
            <!-- <a href="/adminLogin.do" class="w-nav-link">Login</a> -->
            <!-- <a href="/adminInfo.do" class="w-nav-link">Join</a> -->
            </c:if>
            </nav>

            <div class="w-nav-button">
              <div class="w-icon-nav-menu"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>