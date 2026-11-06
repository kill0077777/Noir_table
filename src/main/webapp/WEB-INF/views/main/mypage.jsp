<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<% request.setCharacterEncoding("UTF-8"); %>

<style>
.mypage-btn-wrap {
  display: flex;
  flex-wrap: wrap;
  gap: 14px;
  justify-content: center;
  margin-top: 40px;
}

.noir-btn {
  padding: 12px 24px;
  font-size: 1rem;
  font-weight: 500;
  border: 2px solid #452160;
  color: #452160;
  background-color: transparent;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
  min-width: 160px;
}

.mypage-title{
	margin-right:auto;
	margin-left:auto;
	font-size: 30px;
	text-align: center;       /* 가운데 정렬 */
    font-size: 28px;          /* 글자 크기 */
    color: #111;              /* 글자 색상 */
    letter-spacing: 2px;      /* 자간 */
    margin-bottom:30px;
  	font-family: 'Georgia', 'Times New Roman', serif;
  	font-style: italic;
}

.mypage-grade{
	margin-right:auto;
	margin-left:auto;
	font-size: 30px;
	text-align: center;       /* 가운데 정렬 */
    font-size: 28px;          /* 글자 크기 */
    color: #111;              /* 글자 색상 */
    letter-spacing: 2px;      /* 자간 */
    margin-bottom:30px;
}


.noir-btn:hover {
  background-color: #452160;
  color: white;
}

.noir-btn-accent {
  border-color: #d4af37; /* 골드 포인트 */
  color: #d4af37;
}

.noir-btn-accent:hover {
  background-color: #d4af37;
  color: #1c1c1c;
}

.book-shelf {
  display: flex;
  justify-content: center;
  gap: 12px;
  padding: 30px 0;
  overflow-x: auto;
  scroll-behavior: smooth;
}

.book-item {
  width: 100px;
  height: 240px;
  object-fit: cover;
  border-radius: 8px;
  box-shadow: 0 4px 10px rgba(0,0,0,0.3);
  transition: transform 0.5s ease-in, box-shadow 0.5s ease-in,filter 0.5s ease-in; /* 내려올 때는 느리게 */
  filter:grayscale(100%);
}

.book-item:hover {
  transform: translateY(-20px);
  box-shadow: 0 10px 20px rgba(0,0,0,0.5);
  transition: transform 0.05s ease-out, box-shadow 0.05s ease-out,filter 0.05s ease-out; /* 올라갈 때는 빠르게 */
  filter:grayscale(0%);
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

<div class="icon_box fade-up" style="margin-top:30px; margin-bottom:20px;">
	<img src="${contextPath}/resources/image/noir_icon.png"/>
</div>

<div class="mypage-title fade-up">
	My page
</div>

<c:if test="${sessionScope.member.role eq 'USER'}">
<div class="mypage-grade fade-up">
	고객님의 현재 등급은 <span style="font-family: 'Georgia', 'Times New Roman', serif;
  	font-style: italic;">${sessionScope.memberProfile.grade}</span> 입니다.
</div>
</c:if>
<div class="mypage-btn-wrap fade-up">
  <!-- ADMIN 전용 -->
  <c:if test="${sessionScope.member.role eq 'ADMIN'}">
    <button class="noir-btn" onclick="location.href='${contextPath}/mypage/getReserve.do'">예약 현황</button>
    <button class="noir-btn" onclick="location.href='${contextPath}/member/memberlist.do'">고객 관리</button>
  </c:if>

  <!-- USER 공통 -->
  <c:if test="${sessionScope.member.role eq 'USER'}">
    <button class="noir-btn" onclick="location.href='${contextPath}/mypage/getReserveCustomer.do'">내 예약 보기</button>
    <button class="noir-btn" onclick="location.href='${contextPath}/review/myreview.do'">내 리뷰 보기</button>
    <button class="noir-btn" onclick="location.href='${contextPath}/member/editPage.do'">개인정보 수정</button>

    <!-- 소셜 미연동 회원 -->
    <c:if test="${sessionScope.member.social_type eq null}">
      <button class="noir-btn" onclick="location.href='${contextPath}/member/snslink.do'">소셜 연동하기</button>
    </c:if>
  </c:if>
</div>

<div style="margin-top:50px; margin-bottom:150px;">
<c:if test="${sessionScope.member.role eq 'ADMIN'}">
  <div class="book-shelf">
	<img src="${contextPath}/resources/image/staff/staff1.png" alt="관리자" class="book-item"/>
	<img src="${contextPath}/resources/image/staff/staff2.png" alt="관리자" class="book-item"/>
	<img src="${contextPath}/resources/image/staff/staff3.png" alt="관리자" class="book-item"/>
	<img src="${contextPath}/resources/image/staff/staff4.png" alt="관리자" class="book-item"/>
	<img src="${contextPath}/resources/image/staff/staff5.png" alt="관리자" class="book-item"/>
	<img src="${contextPath}/resources/image/staff/staff6.png" alt="관리자" class="book-item"/>
	<img src="${contextPath}/resources/image/staff/staff7.png" alt="관리자" class="book-item"/>
	<img src="${contextPath}/resources/image/restaurant/restaurant1.png" alt="관리자" class="book-item"/>
	<img src="${contextPath}/resources/image/restaurant/restaurant2.png" alt="관리자" class="book-item"/>
	<img src="${contextPath}/resources/image/restaurant/restaurant3.png" alt="관리자" class="book-item"/>
	<img src="${contextPath}/resources/image/restaurant/restaurant4.png" alt="관리자" class="book-item"/>
	<img src="${contextPath}/resources/image/restaurant/restaurant5.png" alt="관리자" class="book-item"/>
  </div>
</c:if>

<c:if test="${sessionScope.member.role eq 'USER'}">
  <div class="book-shelf">
    <img src="${contextPath}/resources/image/mypage2.png" alt="고객" class="book-item"/>
    <img src="${contextPath}/resources/image/mypage3.png" alt="고객" class="book-item"/>
    <img src="${contextPath}/resources/image/mypage4.png" alt="고객" class="book-item"/>
    <img src="${contextPath}/resources/image/mypage5.png" alt="고객" class="book-item"/>
    <img src="${contextPath}/resources/image/mypage6.png" alt="고객" class="book-item"/>
    <img src="${contextPath}/resources/image/mypage7.png" alt="고객" class="book-item"/>
    <img src="${contextPath}/resources/image/mypage8.png" alt="고객" class="book-item"/>
    <img src="${contextPath}/resources/image/mypage9.png" alt="고객" class="book-item"/>
    <img src="${contextPath}/resources/image/mypage10.png" alt="고객" class="book-item"/>
    <img src="${contextPath}/resources/image/mypage11.png" alt="고객" class="book-item"/>
    <img src="${contextPath}/resources/image/mypage12.png" alt="고객" class="book-item"/>
    <!-- 필요한 만큼 이미지 추가 -->
  </div>
</c:if>
</div>


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