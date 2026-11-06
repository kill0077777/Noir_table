<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="startHour" value="${fn:substring(time, 0, 2)}" />
<c:set var="pricePerPerson" value="0" />

<c:choose>
  <c:when test="${startHour >= 12 and startHour <= 15}">
    <c:set var="pricePerPerson" value="100000" />
    <c:set var="mealType" value="런치" />
  </c:when>
  <c:when test="${startHour >= 16 and startHour <= 19}">
    <c:set var="pricePerPerson" value="150000" />
    <c:set var="mealType" value="디너" />
  </c:when>
</c:choose>
<c:set var="headCountReplace" value="${fn:replace(headCount, '명', '')}" />
<c:set var="totalPrice" value="${headCountReplace * pricePerPerson}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
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
  font-size: 14px;
  text-align: center;
}
.step-menu div.active {
  background-color: #333;
  font-weight: bold;
}

.container {
  width: 887px;
  display: flex;
  flex-direction: column;
  margin: 5px auto 0;
  border: 1px solid #ccc;
  background-color: #fff;
}

.container > div:first-child {
  width: 827px;
  padding: 30px;
  font-size: 30px;
  color: #000;
  text-align: left;
  background-color: #fff;
  border-bottom: 2px solid #111;
  font-weight: bold;
}

.main-reservation {
  display: flex;
  flex-wrap: wrap;
  gap: 30px;
  padding: 24px;
}

.left-main, .right-main {
  flex: 1 1 400px;
  box-sizing: border-box;
}

.reservation-box {
  background-color: #f3f3f3;
  border: 1px solid #ccc;
  border-radius: 8px;
  padding: 20px;
  margin-bottom:20px;
}

.reservation-box .title {
  font-size: 20px;
  font-weight: bold;
  margin-bottom: 12px;
  color: #000;
  text-align: center;
}

.order-title {
  font-size: 20px;
  margin-bottom: 16px;
  color: #000;
  font-weight: bold;
}

.order-table {
  width: 100%;
  border-collapse: collapse;
}
.order-table th, .order-table td {
  padding: 12px;
  border: 1px solid #ccc;
  text-align: center;
  font-size: 14px;
}
.order-table th {
  background-color: #eee;
}

.order-summary {
  margin-top: 20px;
  background-color: #f9f9f9;
  border: 1px solid #ddd;
  padding: 15px;
  display: flex;
  justify-content: space-between;
  font-size: 15px;
  color: #111;
}

.highlight {
  color: #c00;
  font-weight: bold;
}

.pay-btn {
  margin: 30px auto;
  display: block;
  width: 240px;
  padding: 14px;
  font-size: 16px;
  background-color: #111;
  color: #fff;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}
.pay-btn:hover {
  background-color: #000;
}
</style>

<body>
<div class="main-container">
	<div class="side-container">
	    <div class="step-menu">
	      <div>01 에약하기</div>
	      <div>02 인원/좌석</div>
	      <div class="active">03 결제</div>
	      <div>04 결제완료</div>
	    </div>
    </div>
	<div class="container">
	    <div style="width: 827px; padding: 30px; font-size: 30px; 
		    color: #1a4f7a; text-align: left;
		    border-bottom: 2px solid #3180c3;">
	  		결제하기
		</div>		
		<div class="main-reservation">
		    <div class="left-main">
			    <div class="reservation-box">
			        <table>
			            <tr>
			                <td class="title" colspan="2">Noir식당 점심예약</td>
			            </tr>
			            <tr>
			                <td class="label">일정</td>
			                <td class="value">${date}&nbsp${time}</td>
			            </tr>
			            <tr>
			                <td class="label">선택</td>
			                <td class="value">${headCount}</td>
			            </tr>
			        </table>
			    </div>
			    <div class="reservation-box">
			        <table>
			            <tr>
			                <td class="title" colspan="2">좌석정보</td>
			            </tr>
			            <tr>
			                <td class="label">좌석</td>
			                <td class="value">${seatId}</td>
			            </tr>
			            <tr>
			                <td class="label">층</td>
			                <td class="value">${floor}</td>
			            </tr>
			            <tr>
			                <td class="label">장소</td>
			                <td class="value">${location}</td>
			            </tr>
			        </table>
			    </div>
			</div> <!-- left-main  -->
			<div class="right-main">
				<h2 class="order-title">주문정보를 확인해 주세요</h2>
				<div class="table-outbox">
					<table class="order-table">
					    <thead>
					        <tr>
					            <th class="table-header product">상품명</th>
					            <th class="table-header quantity">수량</th>
					            <th class="table-header price">가격</th>
					        </tr>
					    </thead>
					    <tbody>
					    	<tr>
				                <td class="product-name">${mealType}</td>
				                <td class="product-quantity">${headCount}</td>
				                <td class="product-price">
				                	<fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true"/>원
				                </td>
			                </tr>
					    </tbody>
					</table>
				</div>
				<div class="order-summary">
				    <div class="total-quantity">총 수량 :&nbsp<span class="highlight">${headCountReplace}개</span></div>
				    <div class="total-price">총 결제금액 :&nbsp<span class="highlight">
            			<fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true"/>원
          			</span></div>
				</div>
			</div><!-- right-main  -->
		</div><!-- main-reservation  -->
		<form id="paymentForm" action="${contextPath}/reservationUser/customerReservePay.do" method="post">
		  <input type="hidden" name="seatId" value="${seatId}">
		  <input type="hidden" name="reserveId" value="${reserveId}">
		  <input type="hidden" name="totalPrice" value="${totalPrice}">
		  <div style="text-align: center;">
		  	<button class="pay-btn" >결제하기</button>
		  </div>
		</form>
	</div>
</div>
</body>
</html>