<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />

<script type="text/javascript">

</script>

<style>
.slim-header {
  background-color: white;
  border-bottom: 1px solid #ddd;
  padding: 10px 30px;
}

.slim-nav-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.slim-nav a {
  margin-right: 20px;
  color: #333;
  text-decoration: none;
  font-size: 0.95rem;
  letter-spacing: 1px;
  transition: color 0.3s;
}

.slim-nav a:hover {
  color: #5A2A7C;
}

.slim-brand {
  display: flex;
  align-items: center;
}

.slim-brand-icon {
  width: 24px;
  height: 24px;
  margin-right: 8px;
}

.slim-brand-name {
  font-size: 1.1rem;
  font-weight: bold;
  letter-spacing: 1px;
  color: #222;
}

.main_title{
	text-decoration:none;
	color: black;
	margin-right:100px;
}

.main_title:hover{
	color: black;
}

.profile-wrapper {
    width: 30px;
    height: 30px;
    border: 3px solid #444;
    border-radius: 50%;
    overflow: hidden;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: white; /* 이미지 없는 경우 대비 */
}

.profile-wrapper img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
}

.header-link {
    color: black;
    text-decoration: none;
    font-size: 1rem;
}
</style>
<body>


<header class="slim-header">
  <div class="slim-nav-container">
  	
  	<!-- 왼쪽 브랜드 -->
    <div class="slim-brand">
      <img class="slim-brand-icon" src="${contextPath}/resources/image/noir_icon.png" alt="NOIR Icon">
      <span class="slim-brand-name"><a href="${contextPath}/main.do" class="main_title">NOIR</a></span>
    </div>
  
    <!-- 오른쪽 메뉴 -->
    <nav class="slim-nav">
      <a href="<c:url value='/about.do'/>">ABOUT</a>
      <a href="<c:url value='/menu/list.do?menuType='/>">MENU</a>
      <c:if test="${not empty sessionScope.member}">
      	<a href="<c:url value='/reservationUser.do'/>">RESERVATION</a>
      </c:if>
      <a href="<c:url value='/gallery.do'/>">GALLERY</a>
      <c:if test="${not empty sessionScope.member}">
		<a href="<c:url value='/mypage.do'/>">MYPAGE</a>
	  </c:if>
      <a href="<c:url value='/review/list.do'/>">REVIEW</a>
    </nav>
    
	<c:choose>
		<c:when test="${not empty sessionScope.member}">
		  <div style="display: flex; align-items: center; gap: 10px;">
		    <div class="profile-wrapper">
		        <c:choose>
		          <c:when test="${fn:startsWith(sessionScope.member.profileImage, 'http')}">
		            <img src="${sessionScope.member.profileImage}" alt="프로필 이미지">
		          </c:when>
		          <c:when test="${empty sessionScope.member.profileImage}">
		          	<img src="${contextPath}/resources/image/noir_icon.png" alt="프로필 이미지">
		          </c:when>
		          <c:otherwise>
		            <img src="${contextPath}/upload/profile/${sessionScope.member.profileImage}" alt="프로필 이미지">
		          </c:otherwise>
		        </c:choose>
		    </div>
		    <span style="font-weight: bold;">${sessionScope.member.name} 님</span>
		    <a href="<c:url value='/member/logout.do'/>" class="header-link">로그아웃</a>
		  </div>
		</c:when>
	  <c:otherwise>
	  	<div style="display: flex; align-items: center; gap: 10px;">
		    <a href="<c:url value='/member/loginForm.do'/>" class="header-link">로그인</a>
		    <a href="<c:url value='/member/registerForm.do'/>" class="header-link">회원가입</a>
	    </div>
	  </c:otherwise>
	</c:choose>

  </div>
</header>


</body>
</html>






