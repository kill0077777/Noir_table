<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<% request.setCharacterEncoding("UTF-8"); %>

<!-- 메뉴 페이지 -->


<div class="menu-container fade-up">
  <div class="icon_box fade-up" style="margin-top:30px; margin-bottom:20px;">
	 <img src="${contextPath}/resources/image/noir_icon.png"/>
  </div>

  <div class="menu-header fade-up">
    <div class="menu-categories">
      <a class="category-link" href="${contextPath}/menu/list.do?menuType=lunch">lunch</a>
      <a class="category-link" href="${contextPath}/menu/list.do?menuType=dinner">dinner</a>
      <a class="category-link" href="${contextPath}/menu/list.do?menuType=vegan">vegan</a>
      <a class="category-link" href="${contextPath}/menu/wine.do">winelist</a>
    </div>
  </div>
  <c:if test="${sessionScope.member.role eq 'ADMIN'}">
    <a href="${contextPath}/menu/edit.do" class="menu-edit-btn">메뉴 관리</a>
  </c:if>

  <div id="menuList" class="menu-list">
    <c:forEach var="menu" items="${menuList}">
      <div class="menu-item fade-up">${menu.menu_name}</div>
      <div class="menu-item-eng fade-up">${menu.menu_english_name}</div>
    </c:forEach>
  </div>
  
  <div id="menuList" class="menu-list">
  	<div class="menu-item fade-up">
  	   <c:if test="${menuList[0].menu_type eq 'lunch'}">
	     LUNCH  KRW 200,000<br><br>
	   </c:if>
  	   <c:if test="${menuList[0].menu_type eq 'dinner'}">
	     DINNER KRW 250,000<br><br>
	   </c:if>
  	   <c:if test="${menuList[0].menu_type eq 'vegan'}">
	     VEGAN KRW 150,000<br><br>
	   </c:if>
  		1인 1코스 주문은 필수입니다.<br>
  	</div>
  	<div class="menu-item-eng fade-up">
  		Please make sure to order one course per person
  	</div>
  </div>
  
  <div id="menuList" class="menu-list">
  	<div class="menu-item-eng fade-up">
		4 GLASS PAIRING : KRW 150,000<br><br>
		7 GLASS PAIRING : KRW 230,000<br><br>
		premium 5glass pairing : KRW 600,000<br>
  	</div>
  </div>
  
  <div class="icon_box fade-up">
  	<img src="${contextPath}/resources/image/noir_icon.png"/>
  </div>
  
  <div class="menu-list">
  	<div class="menu-item fade-up">SUPPLEMENT</div>
  </div>
  
  <c:if test="${!(menuList[0].menu_type eq 'vegan')}">
  
	  <div class="menu-list">
	  	<div class="menu-item fade-up">Premium À La Carte</div>
	  </div>
	  <c:forEach var="supplement" items="${supplementList}">
	  	<c:if test="${supplement.menu_type eq 'PREMIUM'}">
		  <div id="menuList" class="menu-list">
		      <div class="menu-item fade-up">${supplement.menu_name}</div>
		      <div class="menu-item-choice fade-up">${supplement.menu_english_name}</div>
		      <div class="menu-item-price fade-up">
		      	KRW <fmt:formatNumber value="${supplement.menu_price}" type="number" groupingUsed="true"/>
		      </div>
		  </div>
		</c:if>
	  </c:forEach>
  </c:if>
  
  <div class="menu-list">
  	<div class="menu-item fade-up">Dessert</div>
  </div>
  
  <c:forEach var="supplement" items="${supplementList}">
  	<c:if test="${supplement.menu_type eq 'DESSERT'}">
	  <div id="menuList" class="menu-list">
	      <div class="menu-item fade-up">${supplement.menu_name}</div>
	      <div class="menu-item-choice fade-up">${supplement.menu_english_name}</div>
	      <div class="menu-item-price fade-up">
	      	KRW <fmt:formatNumber value="${supplement.menu_price}" type="number" groupingUsed="true"/>
	      </div>
	  </div>
	</c:if>
  </c:forEach>
  
  <div class="icon_box fade-up" style="margin-top:50px;">
  	<img src="${contextPath}/resources/image/noir_icon.png"/>
  </div>
  
</div>

<style>
.menu-container {
  max-width: 900px;
  margin: 0 auto;
  padding: 60px 20px;
}

.menu-header {
  display: flex;
  justify-content: center;
  align-items: center;
  padding-bottom: 10px;
  margin-bottom: 40px;
}

.menu-categories {
  display: flex;
  gap: 20px;
  margin-bottom:30px;
}

.category-link {
  text-decoration: none;
  color: #452160;
  font-weight: bold;
  font-size: 16px;
  transition: color 0.3s;
}
.category-link:hover {
  color: #000;
}

.menu-edit-btn {
  font-size: 14px;
  color: #f00;
  border: 1px solid #f00;
  padding: 4px 8px;
  text-decoration: none;
  border-radius: 4px;
}

.menu-list {
  margin-top: 30px;
}

.menu-item {
  font-size: 15px;
  padding: 10px 0;
  text-align: center;
  letter-spacing: 1px;
}

.menu-item-eng{
	font-size: 12px;
	color:#444;
	text-align: center;
	margin-bottom:50px;
}

.menu-item-choice{
	font-size: 12px;
	color:#444;
	text-align: center;
	margin-bottom:10px;
}

.menu-item-price{
	color:#444;
    font-size: 12px;
    text-align:center;
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
