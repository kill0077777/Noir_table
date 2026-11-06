<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% request.setCharacterEncoding("UTF-8"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<style>
body {
  font-family: 'Noto Sans KR', sans-serif;
  background-color: #ffffff;
  color: #111111;
  margin: 0;
  padding: 0;
}

.container {
  max-width: 1000px;
  margin: 60px auto;
  padding: 20px;
}

h2 {
  text-align: center;
  margin-bottom: 30px;
  color: #111;
}

/* 테이블 스타일 */
.reservation-table {
  width: 100%;
  border-collapse: collapse;
  font-family: 'Noto Sans KR', sans-serif;
  box-shadow: 0 0 15px rgba(0, 0, 0, 0.05);
  border-radius: 8px;
  overflow: hidden;
}

.reservation-table th, .reservation-table td {
  padding: 14px;
  border-bottom: 1px solid #ddd;
  text-align: center;
  vertical-align: middle;
}

.reservation-table thead {
  background-color: #000;
  color: white;
}

.empty-message {
  text-align: center;
  color: #777;
  font-style: italic;
  padding: 30px 0;
}
/* 상단 아이콘 */
.icon_box {
  display: flex;
  justify-content: center;
}
.icon_box img {
  width: 50px;
  height: 50px;
}
</style>

<div class="container">
<div class="icon_box fade-up" style="margin-top:30px; margin-bottom:20px;">
  <img src="${contextPath}/resources/image/noir_icon.png"/>
</div>
  <h2>내 예약 현황</h2>

  <table class="reservation-table fade-up">
    <thead>
      <tr>
        <th>예약번호</th>
        <th>회원명</th>
        <th>좌석번호</th>
        <th>위치</th>
        <th>인원수</th>
        <th>예약일</th>
        <th>시간대</th>
        <th>상태</th>
      </tr>
    </thead>
    <tbody>
      <c:choose>
        <c:when test="${not empty customerReservationList}">
          <c:forEach var="res" items="${customerReservationList}">
            <tr>
              <td>${res.customerId}</td>
              <td>${res.memberName}</td>
              <td>${res.seatId}</td>
              <td>${res.location}</td>
              <td>${res.headCount}</td>
              <td>${res.reserveDate}</td>
              <td>${res.timeSlot}</td>
              <td>${res.status}</td>
            </tr>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <tr>
            <td colspan="8" class="empty-message">예약 내역이 없습니다.</td>
          </tr>
        </c:otherwise>
      </c:choose>
    </tbody>
  </table>
</div>

<script>
// 페이드업 애니메이션
const observer = new IntersectionObserver(entries => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.classList.add('show');
      observer.unobserve(entry.target);
    }
  });
}, { threshold: 0.1 });

document.querySelectorAll('.fade-up').forEach(el => observer.observe(el));
</script>
