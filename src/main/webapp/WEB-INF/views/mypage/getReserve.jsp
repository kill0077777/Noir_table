<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <c:set var="contextPath" value="${pageContext.request.contextPath}" />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 조회</title>
<style>
	.container {
	    width: 1580px;
	    height: 650px;
    	display: flex;
    	margin: 1px 0px 40px 120px;
    	flex-direction: column;
	}
	
	.result {
		width: 1580px;
		height: 620px;
		display: flex;
    		
	}
	.result-left {
		flex: 1;
	    background-image: url("${pageContext.request.contextPath}/resources/image/floor1_1.png");
	    background-size: contain;   
	    background-repeat: no-repeat;
	    background-position: center center; 

	}
	.result-right {
		flex: 1;
	    background-image: url("${pageContext.request.contextPath}/resources/image/floor2.PNG");
	    background-size: contain;   
	    background-repeat: no-repeat;
	    background-position: center center;  	
	}
	.seat-space {
	    position: relative;
	    width: 887px;
	    height: 552px;
	    background-size: cover;
	    background-repeat: no-repeat;
	    border: 1px solid #ccc;
	}

	.seat {
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  position: absolute;
	  background-color: rgba(0, 128, 0, 0.4);
	  cursor: pointer;
	  font-size: 14px;
	  text-align: center;
	  
	  border: 2px solid #fff;
	  transition: background-color 0.2s;
	  border-radius: 0;
	}
	.seat:hover {
	  background-color: rgba(0, 200, 0, 0.8);
	}
	.seat.disabled {
	  cursor: not-allowed;
	  pointer-events: none;
	}
</style>
</head>
<body>
<div class="container">
	<h3>예약 조회</h3>
	<div class="head-container">
		<label>날짜:</label>
		<input type="date" id="reserveDate">
		
		<label>시간:</label>
		<select id="time">
		  <option value="12:00 ~ 13:00">12:00 ~ 13:00</option>
		  <option value="13:00 ~ 14:00">13:00 ~ 14:00</option>
		  <option value="14:00 ~ 15:00">14:00 ~ 15:00</option>
		  <option value="14:00 ~ 15:00">14:00 ~ 15:00</option>
		  <option value="14:00 ~ 15:00">15:00 ~ 16:00</option>
		  <option value="14:00 ~ 15:00">16:00 ~ 17:00</option>
		  <option value="14:00 ~ 15:00">17:00 ~ 18:00</option>
		  <option value="14:00 ~ 15:00">18:00 ~ 19:00</option>
		  <option value="14:00 ~ 15:00">19:00 ~ 20:00</option>
		</select>
		
		<button onclick="searchReserve()">조회</button>
	</div>
	<hr>
	
	<div class="result">
		<div class="result-left">
			<div class="seat-space">
			  <!-- 좌측 상단, 1, 창가 -->
			  <div class="seat disabled" data-seat-id="1" style="top: 295px; left: 40px; width: 84px; height: 88px;" onclick="selectSeat(1)">예약가능</div>
			  <!-- 좌측 아래, 2, 구석  -->
			  <div class="seat disabled" data-seat-id="2" style="top: 507px; left: 45px; width: 136px; height: 40px;" onclick="selectSeat(2)">예약가능</div>
			  <!-- 2열 위, 3, 중앙 -->
			  <div class="seat disabled" data-seat-id="3" style="top: 257px; left: 196px; width: 87px; height: 84px;" onclick="selectSeat(3)">예약가능</div>
			  <!-- 2열 아래, 4, 중앙 -->
			  <div class="seat disabled" data-seat-id="4" style="top: 407px; left: 184px; width: 79px; height: 55px;" onclick="selectSeat(4)">예약가능</div>
			  <!-- 3열, 5, 입구근처 -->
			  <div class="seat disabled" data-seat-id="5" style="top: 327px; left: 368px; width: 135px; height: 85px;" onclick="selectSeat(5)">예약가능</div>
			  <!-- 우측 위, 6, 구석자리 -->
			  <div class="seat disabled" data-seat-id="6" style="top: 78px; left: 678px; width: 82px; height: 62px;" onclick="selectSeat(6)">예약가능</div>
			  <!-- 우측 중앙, 7, 구석자리 -->
			  <div class="seat disabled" data-seat-id="7" style="top: 174px; left: 769px; width: 73px; height: 67px;" onclick="selectSeat(7)">예약가능</div>
			  <!-- 우측 아래, 8, 구석자리 -->
			  <div class="seat disabled" data-seat-id="8" style="top: 302px; left: 732px; width: 68px; height: 70px;" onclick="selectSeat(8)">예약가능</div>
			</div>
		</div>
		<div class="result-right">
			<div class="seat-space">
			    <div class="seat disabled" data-seat-id="9" style="top: 48px; left: 95px; width: 40px; height: 68px;" onclick="selectSeat(9)">예약가능</div>
			    <div class="seat disabled" data-seat-id="10" style="top: 205px; left: 109px; width: 77px; height: 93px;" onclick="selectSeat(10)">예약가능</div>
			    <div class="seat disabled" data-seat-id="11" style="top: 392px; left: 125px; width: 105px; height: 60px;" onclick="selectSeat(11)">예약가능</div>
			    <div class="seat disabled" data-seat-id="12" style="top: 155px; left: 270px; width: 92px; height: 139px;" onclick="selectSeat(12)">예약가능</div>
			    <div class="seat disabled" data-seat-id="13" style="top: 417px; left: 338px; width: 72px; height: 99px;" onclick="selectSeat(13)">예약가능</div>
			    <div class="seat disabled" data-seat-id="14" style="top: 170px; left: 480px; width: 120px; height: 60px;" onclick="selectSeat(14)">예약가능</div>
			    <div class="seat disabled" data-seat-id="15" style="top: 328px; left: 496px; width: 75px; height: 88px;" onclick="selectSeat(15)">예약가능</div>
			    <div class="seat disabled" data-seat-id="16" style="top: 90px; left: 683px; width: 92px; height: 55px;" onclick="selectSeat(16)">예약가능</div>
			    <div class="seat disabled" data-seat-id="17" style="top: 266px; left: 703px; width: 62px; height: 96px;" onclick="selectSeat(17)">예약가능</div>
		  	</div>
		</div>
	</div>
</div>	
<script>
	let reservedSeatList = [];

	function searchReserve() {
	    const date = document.getElementById("reserveDate").value;
	    const time = document.getElementById("time").value;
	
	    if (!date || !time) {
	        alert("날짜와 시간을 선택해주세요.");
	        return;
	    }
	
	    const params = new URLSearchParams({ date: date, time: time });
	    const url = "${contextPath}/mypage/adminReserveCheck.do?" + params.toString();
	    
	    fetch(url, { 
	    	method: "GET",
   		    headers: {
   		    	"Content-Type": "application/json"
   			}
	    })
	    .then(response => response.json())  // 응답을 JSON으로 변환
	    .then(data => {
	      reservedSeatList = data;
	      console.log(data);                // 처리할 데이터
	      // 모든 좌석 div 초기화 (예약가능으로)
	      const allSeats = document.querySelectorAll('.seat');
	      
	      allSeats.forEach(seat => {
	          seat.classList.add('disabled');
	          
	          seat.textContent = '예약가능';
	          seat.style.backgroundColor = 'rgba(0, 128, 0, 0.4)';
	      });

	      // 서버에서 받은 예약된 좌석 seatId들을 적용
	      // 예: [{seatId: 1, customerId: 2}, {seatId: 5, customerId: 3}]
	      data.forEach(reserve => {
	          const seatId = reserve.seatId;
	          const seatDiv = document.querySelector(".seat[data-seat-id='"+seatId+"']");
	          if (seatDiv) {
	        	  seatDiv.classList.remove('disabled');
	              seatDiv.textContent = '예약됨';
	              seatDiv.style.backgroundColor = 'rgba(200, 0, 0, 0.6)';
	              seatDiv.style.color = 'white';
	              seatDiv.style.fontWeight = 'bold';
	          }
	      });
	    })
	    .catch(error => {
	      console.error("에러 발생:", error);
	    });
	    
	}
	
</script>
<script>
	function selectSeat(seatId) {
	  console.log("selectSeat 호출됨: seatId =", seatId);
	  reservedSeatList.forEach(item => console.log("seatId:", item.seatId, "customerId:", item.customerId));

	  const seatDiv = document.querySelector(`.seat[data-seat-id="${seatId}"]`);

	  // SweetAlert로 예약자 이름 입력 받기
	  Swal.fire({
	    title: '예약을 취소하시겠습니까?',
	    input: 'text',
	    inputPlaceholder: '사유를 입력해주세요',
	    showCancelButton: true,
	    confirmButtonText: '확인',
	    cancelButtonText: '닫기',
    	inputValidator: (value) => {
    	    if (!value || value.trim() === '') {
   		      return '⚠ 사유를 반드시 입력해주세요!';
   		    }
  		}
	  }).then((result) => {
	    if (result.isConfirmed) {
	      const selected = reservedSeatList.find(item => item.seatId == seatId);
	      const customerId = selected ? selected.customerId : null;
	      const memberId = selected ? selected.memberId : null;

	      // 예약 요청용 폼 생성 및 제출
	      const form = document.createElement("form");
	      form.method = "POST";
	      form.action = "${contextPath}/mypage/adminReserveDelete.do"; 

	      const seatInput = document.createElement("input");
	      seatInput.type = "hidden";
	      seatInput.name = "seatId";
	      seatInput.value = seatId;
	      form.appendChild(seatInput);

	      const nameInput = document.createElement("input");
	      nameInput.type = "hidden";
	      nameInput.name = "customerId";
	      nameInput.value = customerId;
	      form.appendChild(nameInput);
	      
	      const memberInput = document.createElement("input");
	      memberInput.type = "hidden";
	      memberInput.name = "memberId";
	      memberInput.value = memberId;
	      form.appendChild(memberInput);
	      
	      const resultInput = document.createElement("input");
	      resultInput.type = "hidden";
	      resultInput.name = "content";
	      resultInput.value = result.value;
	      form.appendChild(resultInput);

	      const dateInput = document.createElement("input");
	      dateInput.type = "hidden";
	      dateInput.name = "date";
	      dateInput.value = document.getElementById("reserveDate").value;
	      form.appendChild(dateInput);

	      const timeInput = document.createElement("input");
	      timeInput.type = "hidden";
	      timeInput.name = "time";
	      timeInput.value = document.getElementById("time").value;
	      form.appendChild(timeInput);
	      
	      document.body.appendChild(form);
	      form.submit();
	    }
	  });
	}
</script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
</html>