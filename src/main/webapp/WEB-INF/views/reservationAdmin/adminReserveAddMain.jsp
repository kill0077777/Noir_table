<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>예약 등록</title>
<style>
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
	
  body {
    font-family: 'Noto Sans KR', sans-serif;
    margin: 0;
    background-color: #f7f7f7;
  }

  .main-container {
    width: 500px;
    margin: 60px auto;
    background-color: #fff;
    padding: 40px 30px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
    border: 1px solid #eee;
  }

  h2 {
    text-align: center;
    margin-bottom: 30px;
    font-weight: 600;
    color: #111;
    font-size: 1.8rem;
    border-bottom: 2px solid #ddd;
    padding-bottom: 15px;
  }

  .form-group {
    margin-bottom: 25px;
    display: flex;
    align-items: center;
  }

  label {
    width: 110px;
    font-weight: 500;
    color: #333;
  }

  input[type="date"],
  select {
    flex: 1;
    padding: 10px 12px;
    font-size: 1rem;
    border: 1px solid #ccc;
    border-radius: 6px;
    background-color: #fff;
    color: #111;
  }

  .radio-group {
    display: flex;
    align-items: center;
  }

  .radio-group label {
    width: auto;
    margin-right: 20px;
    font-weight: 400;
  }

  input[type="radio"] {
    margin-right: 6px;
  }

  button[type="submit"] {
    width: 100%;
    padding: 12px 0;
    background-color: #111;
    color: white;
    border: none;
    border-radius: 6px;
    font-size: 1.1rem;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s ease;
  }

  button[type="submit"]:hover {
    background-color: #333;
  }
</style>

</head>
<body>
	<div class="icon_box fade-up" style="margin-top:30px; margin-bottom:20px;">
		<img src="${contextPath}/resources/image/noir_icon.png"/>
	</div>
	

<div class="main-container fade-up">
  <h2>예약 등록</h2>
  <form id="reserveForm" action="/restaurant/admin/addReserve.do" method="POST">
    <!-- 식사 타임 -->
    <div class="form-group radio-group">
      <label>식사 타임:</label>
      <label><input type="radio" name="mealTime" value="lunch" checked> 런치</label>
      <label><input type="radio" name="mealTime" value="dinner"> 디너</label>
    </div>

    <!-- 예약 날짜 -->
    <div class="form-group">
      <label>예약 날짜:</label>
      <input type="date" id="reserveDate" name="reserveDate">
    </div>

    <!-- 시간대 -->
    <div class="form-group">
      <label>시간 선택:</label>
      <select id="timeSlot" name="timeSlot">
        <!-- JavaScript로 채워짐 -->
      </select>
    </div>


    <!-- 제출 버튼 -->
    <div class="form-group">
      <button type="submit">예약</button>
    </div>
  </form>
</div>
  <script>
    const timeSlot = document.getElementById('timeSlot');
    const mealRadios = document.querySelectorAll('input[name="mealTime"]');

    function updateTimeSlots(meal) {
      let options = "";
      if (meal === 'lunch') {
        for (let hour = 12; hour < 16; hour++) {
	        hour = parseInt(hour);
	        options += "<option>"+hour+":00 ~ "+(hour+1)+":00</option>";
        }
      } else if (meal === 'dinner') {
        for (let hour = 16; hour < 20; hour++) {
        	hour = parseInt(hour); 
        	options += "<option>"+hour+":00 ~ "+(hour + 1)+":00</option>";
        }
      }
      timeSlot.innerHTML = options;
    }

    // 초기 로딩 시
    updateTimeSlots('lunch');

    // 라디오 버튼 변경 감지
    mealRadios.forEach(radio => {
      radio.addEventListener('change', () => {
        updateTimeSlots(radio.value);
      });
    });
  </script>

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
</body>
</html>
