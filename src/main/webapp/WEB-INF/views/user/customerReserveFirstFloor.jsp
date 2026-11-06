<%@ page contentType="text/html; charset=UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좌석 선택</title>
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
  border-bottom: 1px solid rgba(255,255,255,0.1);
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

.info-space {
  width: 887px;
  height: 70px;
  background-color: #f3f3f3;
  border: 1px solid #ddd;
  padding: 15px 20px;
  box-sizing: border-box;
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 15px;
  color: #111;
}

.info-box {
  font-weight: bold;
  padding: 10px 15px;
  display: flex;
  flex-direction: column;
  gap: 5px;
}

/* 좌석 배치 */
.seat-space {
  position: relative;
  width: 887px;
  height: 552px;
  background-image: url("${pageContext.request.contextPath}/resources/image/floor1.PNG");
  background-size: cover;
  background-repeat: no-repeat;
  border: 1px solid #ccc;
}

/* 좌석 스타일 */
.seat {
  display: flex;
  justify-content: center;
  align-items: center;
  position: absolute;
  background-color: rgba(0, 0, 0, 0.1);
  cursor: pointer;
  font-size: 14px;
  text-align: center;
  border: 2px solid #444;
  color: #000;
  transition: all 0.2s;
  border-radius: 6px;
  font-weight: 500;
}
.seat:hover {
  background-color: rgba(0, 0, 0, 0.3);
  color: #fff;
}
.seat.disabled {
  background-color: rgba(150, 150, 150, 0.4);
  cursor: not-allowed;
  pointer-events: none;
  border: 2px dashed #999;
  color: #555;
}
.seat.disabled[data-reserved="true"] {
  background-color: rgba(200, 0, 0, 0.7);
  color: white;
  font-weight: bold;
  border: 2px solid #900;
}

/* 다음 버튼 */
.next-btn {
  position: absolute;
  bottom: 10px;
  right: 10px;
  padding: 12px 28px;
  background-color: #111;
  color: white;
  border: none;
  border-radius: 6px;
  font-size: 1rem;
  cursor: pointer;
  transition: background-color 0.2s ease;
}
.next-btn:hover {
  background-color: #000;
}
</style>
</head>
<body>
<div class="main-container">
	<div class="side-container">
	    <div class="step-menu">
	      <div>01 에약하기</div>
	      <div class="active">02 인원/좌석</div>
	      <div>03 결제</div>
	      <div>04 결제완료</div>
	    </div>
    </div>
	<div class="container">
	    <!-- 정보 출력 영역 -->
	    <div style="width: 827px; padding: 30px; font-size: 30px; 
	         color: #1a4f7a; text-align: left;
	         border-bottom: 2px solid #3180c3;">
	  		좌석 선택
		</div>
		<div class="info-space">
		  <div class="info-box">층 : ${floor}</div>
		  <div class="info-box">위치 : ${location}</div>
		  <div class="info-box">인원수 : ${headCount}</div>
		  <div class="info-box">날짜 : ${date}</div>
		  <div class="info-box">시간 : ${time}</div>
		</div>
	
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
</div>
<form id="seatSubmitForm" action="${contextPath}/reservationUser/customerReserveThird.do" method="post">
  <input type="hidden" name="seatId" id="seatIdInput">
  <input type="hidden" name="floor" value="${floor}">
  <input type="hidden" name="location" value="${location}">
  <input type="hidden" name="headCount" value="${headCount}">
  <input type="hidden" name="date" value="${date}">
  <input type="hidden" name="time" value="${time}">
  <input type="hidden" name="reserveId" value="${reserveId}">
</form>
<script>
  /* 이전 단계에서 선택한 값  */
  const selectedLocation = '${location}';
  console.log("이전 단계에서 선택한 장소 : " + selectedLocation);
  const selectedHeadCount = '${headCount}';
  console.log("이전 단계에서 선택한 장소 : " + selectedHeadCount);
  
  // 예약한 좌석 id 번호들
  const reservedSeatsId = [
	  <c:forEach var="id" items="${reservedSeatsId}" varStatus="status">
	    ${id}<c:if test="${!status.last}">,</c:if>
	  </c:forEach>
  ];
  
  // JSP의 seatList를 JS에서 쓸 수 있도록 객체 배열로
  const seatList = [
    <c:forEach var="seat" items="${seatList}" varStatus="status">
      {
        seatId: ${seat.seat_Id},
        location: '${seat.location}',
        headCount: ${seat.head_Count},
        floor: ${seat.floor}
      }
      <c:if test='${!status.last}'>,</c:if>
    </c:forEach>
  ];
  console.log("서버에서 받아온 seatList:", seatList);
  
    //클라이언트에서 선택한 위치와 인원수 일치시 선택가능하게
	window.onload = function () {
      // 1층에 있는 좌석들만
	  seatList.forEach(seat => {
	    const seatDiv = document.querySelector(".seat[data-seat-id='" + seat.seatId + "']");
	    if (seatDiv) {
	      const isReserved = reservedSeatsId.includes(seat.seatId);
	      const selectedIntHeadCount = parseInt(selectedHeadCount);
	
	      if (isReserved) {
	        seatDiv.classList.add('disabled');
	        seatDiv.textContent = '예약됨';
	        
	        // 예약됨일 경우 배경색 따로 적용
	        seatDiv.style.backgroundColor = 'rgba(200, 0, 0, 0.6)';
	        seatDiv.style.color = 'white';
	        seatDiv.style.fontWeight = 'bold';
	      
	      } else if ((seat.location === selectedLocation) && (seat.headCount === selectedIntHeadCount)) {
	        seatDiv.classList.remove('disabled');
	        seatDiv.textContent = '예약가능';
	      }
	    }
	  });
	};

  function selectSeat(seatId) {
	  const selectedSeat = seatList.find(seat => Number(seat.seatId) === Number(seatId));
	  console.log("선택한 좌석 : " + selectedSeat);
	  
	  if (selectedSeat) {
		  Swal.fire({
			  title: '예약하기',
			  html: `
				<div style="margin: 0 auto; width: fit-content; text-align: left;">
			      <p><strong>선택된 좌석 정보</strong></p>
			      <table>
			        <tr>
			          <td style="padding-right: 20px;">ID&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp:</td>
			          <td>\${selectedSeat.seatId}</td>
			        </tr>
			        <tr>
			          <td style="padding-right: 20px;">위치&nbsp&nbsp&nbsp&nbsp&nbsp:</td>
			          <td>\${selectedSeat.location}</td>
			        </tr>
			        <tr>
			          <td style="padding-right: 20px;">인원수 &nbsp:</td>
			          <td>\${selectedSeat.headCount}</td>
			        </tr>
			        <tr>
			          <td style="padding-right: 20px;">층수&nbsp&nbsp&nbsp&nbsp&nbsp:</td>
			          <td>\${selectedSeat.floor}</td>
			        </tr>
			      </table>
			      <br>
			      <strong>이 좌석으로 예약하시겠습니까?</strong>
			    </div>
			  `,
	      icon: 'question',
	      showCancelButton: true,
	      confirmButtonText: '확인',
	      cancelButtonText: '취소'
	    }).then((result) => {
	      if (result.isConfirmed) {
	        console.log("✅ 예약 확정:", selectedSeat);
	        document.getElementById("seatIdInput").value = selectedSeat.seatId;
	        document.getElementById("seatSubmitForm").submit();
	      } else {
	        console.log("❌ 예약 취소");
	      }
	    });
	  } else {
	    Swal.fire("오류", "좌석 정보를 찾을 수 없습니다.", "error");
	  }
	}

</script>
<!-- SweetAlert2 CDN 추가 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
</html>
