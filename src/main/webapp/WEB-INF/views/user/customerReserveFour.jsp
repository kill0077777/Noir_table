<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제정보</title>
<style>
 body {
  font-family: 'Noto Sans KR', sans-serif;
  margin: 0;
  background-color: #fff;
  color: #111;
}

.main-container {
  width: 1017px;
  display: flex;
  margin: 10px auto 20px;
}

.side-container {
  margin-top: 5px;
  width: 130px;
}

.step-menu {
  background-color: #111;
  color: white;
  flex: 1;
  display: flex;
  flex-direction: column;
}
.step-menu div {
  padding: 79.4px 17px;
  cursor: pointer;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}
.step-menu div.active {
  background-color: #333;
}

.container {
  width: 887px;
  display: flex;
  flex-direction: column;
  margin: 5px auto 0;
  border: 1px solid #ccc;
  background-color: #fff;
}

.header {
  width: 827px;
  padding: 30px;
  font-size: 30px;
  color: #000;
  text-align: left;
  border-bottom: 2px solid #111;
  margin: 0 auto;
  font-weight: bold;
}

.content {
  display: flex;
  margin-top: 40px;
  padding: 30px 40px;
  flex: 1;
}

.info-box {
  flex: 1;
  margin-right: 20px;
}

.info-title {
  font-size: 20px;
  color: #000;
  border-bottom: 2px solid #ccc;
  margin-bottom: 15px;
  padding-bottom: 5px;
  font-weight: bold;
}

.info-list {
  font-size: 16px;
  line-height: 1.8;
  color: #333;
  padding-left: 10px;
}

.summary-box {
  flex: 1;
  padding-left: 30px;
  border-left: 1px solid #ddd;
}

.summary-table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 20px;
  font-size: 15px;
}

.summary-table th {
  background-color: #f3f3f3;
  color: #000;
  padding: 12px;
  border-bottom: 1px solid #ccc;
}

.summary-table td {
  padding: 12px;
  border-bottom: 1px solid #eee;
  text-align: center;
  color: #222;
}

.total-price {
  font-size: 18px;
  text-align: right;
  margin-top: 10px;
  font-weight: bold;
  color: #111;
}

.highlight {
  color: #000;
  font-weight: bold;
}
</style>
</head>
<body>
<div class="main-container">
  <div class="side-container">
    <div class="step-menu">
      <div>01 에약하기</div>
      <div>02 인원/좌석</div>
      <div>03 결제</div>
      <div class="active">04 결제완료</div>
    </div>
  </div>
  <div class="container">
    <div class="header">결제정보</div>

    <div class="content">
      <!-- 좌측 정보 영역 -->
      <div class="info-box">
        <div class="info-title">예약 정보</div>
        <div class="info-list">
          날짜: <span class="highlight"><fmt:formatDate value="${info.reserveDate}" pattern="yyyy-MM-dd"/></span><br>
          시간대: <span class="highlight">${info.timeSlot}</span><br>
          식사시간: <span class="highlight">${info.mealTime}</span><br>
          층수: <span class="highlight">${info.seatFloor}</span>
        </div>

        <div class="info-title" style="margin-top: 30px;">좌석 정보</div>
        <div class="info-list">
          좌석 ID: <span class="highlight">${info.seatId}</span><br>
          위치: <span class="highlight">${info.location}</span><br>
          수용 인원: <span class="highlight">${info.headCount}명</span><br>
          층수: <span class="highlight">${info.seatFloor}</span>
        </div>
      </div>

      <!-- 우측 결제 요약 영역 -->
      <div class="summary-box">
        <div class="info-title">결제 내역</div>
        <table class="summary-table">
          <thead>
            <tr>
              <th>상품명</th>
              <th>수량</th>
              <th>단가</th>
              <th>합계</th>
            </tr>
          </thead>
          
          <c:set var="pricePerPerson" value="${info.mealTime == 'lunch' ? 100000 : 150000}" />
		  <c:set var="totalPrice" value="${pricePerPerson * info.headCount}" />
          <tbody>
            <tr>
              <td>${info.mealTime == 'lunch' ? '런치' : '디너'}</td>
              <td>${info.headCount}</td>
              <td>
                <c:choose>
                  <c:when test="${info.mealTime == 'lunch'}">100,000원</c:when>
                  <c:otherwise>150,000원</c:otherwise>
                </c:choose>
              </td>
              <td><fmt:formatNumber value="${totalPrice}" type="number" />원</td>
            </tr>
          </tbody>
        </table>
        <div class="total-price">
          총 결제금액: <fmt:formatNumber value="${totalPrice}" type="number" />원
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
