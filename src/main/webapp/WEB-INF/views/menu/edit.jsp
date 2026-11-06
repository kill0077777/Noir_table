<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<% request.setCharacterEncoding("UTF-8"); %>

<!-- 메뉴 수정 -->
<div class="menu-container fade-up">

  <div class="icon_box fade-up" style="margin-top:30px; margin-bottom:20px;">
	  <img src="${contextPath}/resources/image/noir_icon.png"/>
  </div>  
  
  <div class="menu-header fade-up">
  	<h1>메뉴 관리</h1>
  </div>

  <div class="menu-type-buttons fade-up">
    <button onclick="goEditMenu('lunch')"><strong>LUNCH</strong></button>
    <button onclick="goEditMenu('dinner')"><strong>DINNER</strong></button>
    <button onclick="goEditMenu('vegan')"><strong>VEGAN</strong></button>
    <button onclick="goEditMenu('supplement')"><strong>SUPPLEMENT</strong></button>
  </div>
  <div class="intro-img-box">
  	<img src="${contextPath}/resources/image/edit_intro.png"/>
  </div>
</div>

<script>

</script>

<style>
.intro-img-box{
	width:80%;
	margin-left:auto;
	margin-right:auto;
	filter: grayscale(100%);
	margin-top:30px;
}

.intro-img-box img{
    width:100%;
    height:80%;
    object-fit:cover;
}

.menu-container {
  max-width: 80%;
  margin: 0 auto;
  padding: 60px 20px;
}

.menu-type-buttons {
  display: flex;
  justify-content: center;
  gap: 20px;
  margin-top: 40px;
}

.menu-type-buttons button {
  padding: 10px 24px;
  font-size: 16px;
  border: 1px solid #452160;
  background-color: white;
  color: #452160;
  border-radius: 6px;
  cursor: pointer;
  transition: 0.3s;
}

.menu-type-buttons button:hover {
  background-color: #452160;
  color: white;
}

.menu-header {
  display: flex;
  justify-content: center;
  align-items: center;
  padding-bottom: 10px;
  margin-bottom: 40px;
}

.fade-up {
  opacity: 0;
  transform: translateY(50px);
  transition: opacity 1.2s ease-out, transform 1.2s ease-out;
}

.fade-up.show {
  opacity: 1;
  transform: translateY(0);
}

.icon_box{
  display:flex;
  justify-content:center;
}

.icon_box img{
	width:50px;
	height:50px;
}
</style>

<script>

function goEditMenu(menuType) {
	  location.href = '${contextPath}/menu/editMenu.do?menuType=' + menuType;
}

//메인 페이지 페이드아웃 -> 페이드 인 적용 익명 함수
const observer = new IntersectionObserver(entries => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('show');
        observer.unobserve(entry.target); // 한 번만 실행
      }
    });
  }, { threshold: 0.2 });

  document.querySelectorAll('.fade-up').forEach(section => {
    observer.observe(section);
  });
</script>
