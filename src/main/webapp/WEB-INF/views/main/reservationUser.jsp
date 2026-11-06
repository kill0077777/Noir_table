<%@ page contentType="text/html; charset=UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd" var="today"/>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>예약 관련 선택</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
  <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
  <script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
  <style>
body {
  font-family: 'Noto Sans KR', sans-serif;
  margin: 0;
  background-color: #ffffff;
  color: #111;
}

.container {
  width: 1017px;
  height: 745px;
  display: flex;
  margin: 10px auto 20px;
}

/* 왼쪽 단계 메뉴 */
.step-menu {
  height: 736px;
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

/* 오른쪽 메인 */
.main-container {
  width: 887px;
  display: flex;
  flex-direction: column;
  background-color: #fff;
  border: 1px solid #ccc;
}

.main-container > div:first-child {
  width: 827px;
  padding: 30px;
  font-size: 30px;
  color: #000;
  text-align: left;
  background-color: #fff;
  border-bottom: 2px solid #111;
  font-weight: bold;
}

.top-row {
  display: flex;
  justify-content: space-between;
}

/* 구역 선택 영역 */
.area-select {
  height: 260px;
  display: flex;
  gap: 20px;
  background: #fff;
  border-right: 1px solid #ccc;
  flex: 6;
  padding: 10px;
}

.floor, .location {
  flex: 1;
}

.headCount-select {
  background: #fff;
  border-right: 1px solid #ccc;
  flex: 6;
  padding: 10px;
}

h4 {
  font-size: 1rem;
  color: #000;
  margin-bottom: 10px;
}

/* 선택 항목 스타일 */
.floor-option,
.location-option,
.headCount-option,
.time-slot {
  padding: 10px;
  margin: 6px 0;
  cursor: pointer;
  border-radius: 6px;
  border: 1px solid #ccc;
  background-color: #fafafa;
  transition: background-color 0.2s, color 0.2s;
}

.floor-option:hover,
.location-option:hover,
.headCount-option:hover,
.time-slot:hover {
  background-color: #eee;
}

.selected {
  background-color: #111 !important;
  color: white !important;
  border-color: #111 !important;
}

/* 스케줄 영역 */
.schedule-block {
  height: 310px;
  padding: 20px;
}

.date-label {
  margin-bottom: 20px;
}

input[type="text"] {
  padding: 8px;
  border-radius: 4px;
  border: 1px solid #ccc;
  width: 180px;
}

/* 시간 목록 */
.time-container {
  height: 200px;
}

.time-list {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.time-slot {
  flex: 0 0 25%;
  padding: 12px;
  margin-bottom: 10px;
  text-align: center;
}

/* 버튼 */
.next-btn {
  margin-top: 30px;
  padding: 12px 60px;
  font-size: 16px;
  background-color: #111;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: not-allowed;
  opacity: 0.6;
  transition: opacity 0.2s ease, background-color 0.2s ease;
}

.next-btn.enabled {
  cursor: pointer;
  opacity: 1;
}

.next-btn:hover:enabled {
  background-color: #000;
}
  </style>
</head>
<body>

<div class="container">
  <div class="step-menu">
    <div class="active">01 에약하기</div>
    <div>02 인원/좌석</div>
    <div>03 결제</div>
    <div>04 결제완료</div>
  </div>

  <form id="reserveForm" method="post" action="">
    <div class="main-container">
      <div style="width: 827px; padding: 30px; font-size: 30px; 
	       color: #1a4f7a; text-align: left; background-color: white;
	       border-bottom: 2px solid #3180c3;">
	  		예약 하기
	  </div>
      <div class="top-row">
        <!-- 장소 -->
        <div class="area-select">
          <div class="floor">
            <h4>장소</h4>
            <div class="floor-option" onclick="selectItem(this, 'floor')">1층</div>
            <div class="floor-option" onclick="selectItem(this, 'floor')">2층</div>
          </div>
          <div class="location">
            <h4>위치</h4>
            <div class="sub-area-select" id="sub-firstfloor" style="display:none">
              <div class="location-option" onclick="selectItem(this, 'location')">창가자리</div>
              <div class="location-option" onclick="selectItem(this, 'location')">입구근처</div>
              <div class="location-option" onclick="selectItem(this, 'location')">중앙</div>
              <div class="location-option" onclick="selectItem(this, 'location')">구석자리</div>
            </div>
            <div class="sub-area-select" id="sub-secondfloor" style="display:none">
              <div class="location-option" onclick="selectItem(this, 'location')">창가자리</div>
              <div class="location-option" onclick="selectItem(this, 'location')">중앙</div>
              <div class="location-option" onclick="selectItem(this, 'location')">구석자리</div>
            </div>
          </div>
        </div>

        <!-- 인원수 -->
        <div class="headCount-select">
          <h4>인원수</h4>
          <div class="headCount-option" style="display:none" onclick="selectItem(this, 'headCount')">2명</div>
          <div class="headCount-option" style="display:none" onclick="selectItem(this, 'headCount')">4명</div>
          <div class="headCount-option" style="display:none" onclick="selectItem(this, 'headCount')">6명</div>
          <div class="headCount-option" style="display:none" onclick="selectItem(this, 'headCount')">8명</div>
        </div>
      </div>

      <!-- 시간 선택 -->
      <div class="schedule-block">
        <div class="date-label">
	        <label>날짜 선택:
	          <input type="text" id="datePicker" value="${today}" required>
	        </label>
        </div>
		<div class="time-container">
	        <div class="time-list" id="timeList"></div>
		</div>
		
        <!-- Hidden Inputs -->
        <input type="hidden" name="floor" id="input-floor">
        <input type="hidden" name="location" id="input-location">
        <input type="hidden" name="headCount" id="input-headCount">
        <input type="hidden" name="date" id="input-date" value="${today}">
        <input type="hidden" name="time" id="input-time">
        <input type="hidden" name="reserveId" id="input-reserveId">
        
        <div class="btn-area" style="text-align: center;">
        	<button type="submit" class="next-btn" id="nextBtn" disabled>다음 단계</button>
      	</div>
      </div>
    </div>
  </form>
</div>

<script>
  let selected = { floor: null, location: null, headCount: null, date: null, time: null };

  function selectItem(element, type) {
	// 선택된 항목의 'selected' 클래스를 모두 제거 (이전에 선택된 항목 초기화)
    document.querySelectorAll("." + type + "-option, ." + type + "-slot").forEach(el => {
      el.classList?.remove("selected");
    });
    // 현재 선택된 항목에 'selected' 클래스 추가
    element.classList.add("selected");
    // selected 객체에 해당 type의 값을 저장 (floor, location, headCount 등)
    selected[type] = element.innerText;
     // 폼에서 해당 타입의 값을 입력 필드에 반영
    document.getElementById("input-" + type).value = selected[type];

    const form = document.getElementById("reserveForm");

    if (type === "floor") {
      showSubArea(selected.floor === "1층" ? "firstfloor" : "secondfloor");
      form.action = selected.floor === "1층" ?
        "${contextPath}/reservationUser/customerReserveFirstFloor.do" :
        "${contextPath}/reservationUser/customerReserveSecondFloor.do";
        
      selected.location = null;
      selected.headCount = null;
      document.getElementById("input-location").value = "";
      document.getElementById("input-headCount").value = "";
      // 선택된 위치와 인원수 항목의 'selected' 클래스 제거
      document.querySelectorAll(".location-option").forEach(el => {
        el.classList.remove("selected");
      });
      document.querySelectorAll(".headCount-option").forEach(el => {
        el.classList.remove("selected");
      });
    }

    if (type === "location") {
      const floor = selected.floor;
      const location = element.innerText;

      // location이 바뀔 때마다 headCount 값 초기화
      selected.headCount = null;
      document.getElementById("input-headCount").value = "";  // 인원수 초기화
      document.querySelectorAll(".headCount-option").forEach(el => {
          el.classList.remove("selected");
      });
      
      if (floor === "1층") {
        if (location === "창가자리") showHeadCounts(["4명"]);
        else if (location === "입구근처") showHeadCounts(["6명"]);
        else if (location === "중앙") showHeadCounts(["2명", "4명"]);
        else if (location === "구석자리") showHeadCounts(["2명", "4명"]);
      } else if (floor === "2층") {
        if (location === "창가자리") showHeadCounts(["4명", "6명"]);
        else if (location === "중앙") showHeadCounts(["4명", "8명"]);
        else if (location === "구석자리") showHeadCounts(["2명"]);
      }
    }

    validateForm();
  }

  function showSubArea(areaId) {
    document.querySelectorAll(".sub-area-select").forEach(el => el.style.display = "none");
    document.getElementById("sub-" + areaId).style.display = "block";
  }

  function showHeadCounts(allowedList) {
    document.querySelectorAll(".headCount-option").forEach(el => {
      if (allowedList.includes(el.innerText)) {
        el.style.display = "block";
      } else {
        el.style.display = "none";
        el.classList.remove("selected");
      }
    });
  }

  function validateForm() {
    const btn = document.getElementById("nextBtn");
    btn.classList.toggle("enabled", Object.values(selected).every(v => v));
    btn.disabled = !Object.values(selected).every(v => v);
  }
</script>

<script>
  const reserveList = [
    <c:forEach var="vo" items="${reserveList}" varStatus="status">
      {
        reserveId: '${vo.reserve_Id}',
        date: '<fmt:formatDate value="${vo.reserve_Date}" pattern="yyyy-MM-dd"/>',
        time: '${vo.time_Slot}'
      }<c:if test="${!status.last}">,</c:if>
    </c:forEach>
  ];

  function updateTimeSlots(selectedDate) {
    const timeListDiv = document.getElementById("timeList");
    timeListDiv.innerHTML = "";
    const filtered = reserveList.filter(item => item.date === selectedDate);
    if (filtered.length === 0) {
      timeListDiv.innerHTML = "<div>예약 가능한 시간이 없습니다.</div>";
      return;
    }
    filtered.forEach(item => {
      const div = document.createElement("div");
      div.className = "time-slot";
      div.innerText = item.time;
      div.onclick = () => {
        selectItem(div, 'time');
        document.getElementById("input-reserveId").value = item.reserveId;
      };
      timeListDiv.appendChild(div);
    });
  }

  window.onload = () => updateTimeSlots(document.getElementById("input-date").value);

  flatpickr("#datePicker", {
    dateFormat: "Y-m-d",
    locale: "ko",
    minDate: "today",
    maxDate: new Date().fp_incr(7),
    onChange: (selectedDates, dateStr) => {
      document.getElementById("input-date").value = dateStr;
      selected.date = dateStr;
      updateTimeSlots(dateStr);
    }
  });
</script>

</body>
</html>
