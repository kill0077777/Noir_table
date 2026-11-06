<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<% request.setCharacterEncoding("UTF-8"); %>

<style>
/* 전체 레이아웃 정리 */
section {
  padding: 60px 20px;
  text-align: center;
  margin-bottom:100px;
}

.section1 {
  width:80%;
  margin-right:auto;
  margin-left:auto;
  position: relative;
  background-image: url('<c:url value="/resources/image/about/background1.png"/>');
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  color: white;
  padding: 100px 30px;
  text-align: center;
  z-index: 1;
  overflow: hidden;
}

/* 어두운 오버레이 */
.section1::before {
  content: '';
  position: absolute;
  top: 0; left: 0; right: 0; bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);  /* 어두운 반투명 오버레이 */
  z-index: 0;
}

.section1 * {
  position: relative;
  z-index: 2;
}

.section2 {
  width:80%;
  margin-right:auto;
  margin-left:auto;
  position: relative;
  background-image: url('<c:url value="/resources/image/about/background2.png"/>');
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  color: white;
  padding: 100px 30px;
  text-align: center;
  z-index: 1;
  overflow: hidden;
}

/* 어두운 오버레이 */
.section2::before {
  content: '';
  position: absolute;
  top: 0; left: 0; right: 0; bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);  /* 어두운 반투명 오버레이 */
  z-index: 0;
}

.section2 * {
  position: relative;
  z-index: 2;
}

.about-header h1 {
  font-size: 2.8rem;
  font-weight: bold;
  margin-bottom: 50px;
  color: white;
}

.about-header p {
  font-size: 1.2rem;
  color: white;
}


.about-team h2,
.about-location h2 {
  font-size: 2rem;
  margin-bottom: 20px;
  color: #2c2c2c; /* 포인트 컬러 */
}

.about-philosophy h2{
  font-size: 2rem;
  margin-bottom: 20px;
  color: whtie; /* 포인트 컬러 */
}

.about-philosophy p {
  font-size: 1.1rem;
  line-height: 1.6;
  max-width: 800px;
  margin: 0 auto;
  color: white;
}

/* 팀 멤버 그리드 */
.team-grid {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 40px;
  margin-top: 40px;
}

.team-member {
  width: 200px;
  text-align: center;
}

.team-member img {
  width: 100%;
  height: auto;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  object-fit: cover;
  filter:grayScale(100%);
  transition: filter 0.7s ease-in;
}

.team-member img:hover {
  filter:grayScale(0%);
  transition: filter 0.3s ease-out;
  cursor:pointer;
}

.team-member h3 {
  margin-top: 12px;
  font-size: 1.2rem;
  color: #333;
}

.team-member p {
  font-size: 0.95rem;
  color: #777;
}

/* 위치 섹션 */
.about-location p {
  font-size: 1rem;
  color: #444;
  line-height: 1.5;
}

#map {
  margin-top: 20px;
  width: 100%;
  height: 300px;
  background-color: #eee;
  border-radius: 8px;
}

.noir-quote2 {
  font-family: 'NanumMiRaeNaMu';
  font-size: 1.8rem;
  color: white;
  text-align: center;
  margin-top: 50px;
  padding: 20px;
  line-height: 1.5;
  letter-spacing: 1px;
  text-shadow: 0 1px 3px rgba(0,0,0,0.4);
}

.noir-quote3 {
  font-family: 'NanumMiRaeNaMu';
  font-size: 1.3rem;
  color: white;
  text-align: center;
  margin-top: 50px;
  padding: 20px;
  line-height: 1.5;
  letter-spacing: 1px;
  text-shadow: 0 1px 3px rgba(0,0,0,0.4);
}
/* 반응형 대응 */
@media (max-width: 768px) {
  .team-grid {
    flex-direction: column;
    align-items: center;
  }

  .team-member {
    width: 80%;
  }
}

.modal {
  display: none;
  position: fixed;
  z-index: 999;
  left: 0; top: 0; right: 0; bottom: 0;
  background-color: rgba(0, 0, 0, 0.6);
  backdrop-filter: blur(4px);
  justify-content: center;
  align-items: center;
}

.modal-content {
  position: relative;
  background-color: #1c1c1c;
  color: #f5f5f5;
  padding: 30px 40px;
  border-radius: 12px;
  max-width: 500px;
  text-align: center;
  animation: fadeInUp 0.5s ease-out;
  box-shadow: 0 10px 30px rgba(0,0,0,0.6);
}

.close-btn {
  position: absolute;
  top: 20px; right: 30px;
  font-size: 28px;
  color: #fff;
  cursor: pointer;
}

.modal-img {
  width: 180px;
  height: 180px;
  object-fit: cover;
  object-position: top center; /* ⭐ 얼굴이 위에 있다면 이걸로 내려줌 */
  border-radius: 50%;
  margin-bottom: 20px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
  transition: transform 0.3s ease;
}

.modal-img:hover {
  transform: scale(1.05);
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(40px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
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

.section3{
	width:80%;
	margin-right:auto;
	margin-left:auto;
}

</style>
<link href="https://hangeul.pstatic.net/hangeul_static/css/NanumMiRaeNaMu.css" rel="stylesheet">
<section class="about-header section1 fade-up">
  <h1>About NOIR</h1>
  <p>
    NOIR는 1998년, 서울 강남의 조용한 골목 한 켠에서 단 6개의 테이블로 시작되었습니다.<br>
    당시 스물일곱의 젊은 셰프 박세진은, 매일 새벽마다 시장을 돌며 직접 식재료를 고르고, 손님 한 사람 한 사람을 위한 메뉴를 만들었습니다.<br><br>

    그렇게 시작된 NOIR는 오랜 시간 동안 한결같은 철학을 지켜왔습니다. 화려한 기술보다 기본에 충실한 조리, 시선을 사로잡기보다 마음을 움직이는 플레이팅,<br>
    그리고 무엇보다 ‘맛’이 남기는 여운에 집중합니다.<br><br>

    NOIR는 단순한 식사를 넘어, 한 사람의 하루를 위한 가장 조용하고 깊은 쉼표가 되기를 바랍니다.<br>
    당신의 시간이 천천히 흐르는 이곳에서, 미각과 감각, 그리고 기억에 오래 남을 순간을 경험해보세요.
  </p>
</section>

<section class="about-team fade-up">
  <h2>Meet Our Team</h2>
  <div class="team-grid">
    
    <div class="team-member"
    	data-name="박세진"
    	data-role="Executive Chef"
    	data-origin="대한민국 서울"
    	data-education="르 꼬르동 블루 파리"
    	data-career="미쉐린 2스타 레스토랑 L'Ambroisie 수석 셰프, NOIR 총괄 셰프"
    	data-description="훌륭한 맛은 발견되는 것이 아닙니다. 조용히, 그리고 천천히 정제됩니다."
    	data-src="${contextPath}/resources/image/about/박세진 셰프.png">
      <img src="${contextPath}/resources/image/about/박세진 셰프.png" alt="박세진 셰프">
      <h3>박세진</h3>
      <p>Executive Chef</p>
    </div>
    
    <div class="team-member"
        data-name="이도윤"
    	data-role="Chef de Cuisine"
    	data-origin="대한민국 부산"
    	data-education="CIA (Culinary Institute of America)"
    	data-career="뉴욕 Eleven Madison Park, 도쿄 Narisawa"
    	data-description="동양의 향을 서양의 방식으로 풀어내는 것이 저의 미션입니다."
    	data-src="${contextPath}/resources/image/about/이도윤 셰프.png">
      <img src="${contextPath}/resources/image/about/이도윤 셰프.png" alt="이도윤 셰프">
      <h3>이도윤</h3>
      <p>Chef de Cuisine</p>
    </div>
    
    <div class="team-member"
        data-name="클레어 마르탱"
    	data-role="Pastry Chef"
    	data-origin="프랑스 리옹"
    	data-education="Institut Paul Bocuse"
    	data-career="Ladurée, Pierre Hermé Paris"
    	data-description="디저트는 기억에 남는 식사의 마지막 선율이죠."
    	data-src="${contextPath}/resources/image/about/클레어 마르탱 셰프.png">
      <img src="${contextPath}/resources/image/about/클레어 마르탱 셰프.png" alt="클레어 마르탱 셰프">
      <h3>클레어 마르탱</h3>
      <p>Sous Chef</p>
    </div>
    
    <div class="team-member"
        data-name="소피아 밀러"
    	data-role="General Manager"
    	data-origin="독일 베를린"
    	data-education="Business Administration, University of Mannheim, Germany"
    	data-career="베를린 Tim Raue, 런던 Sketch"
    	data-description="식사는 공간, 서비스, 음식이 만들어내는 종합 예술입니다."
    	data-src="${contextPath}/resources/image/about/소피아밀러 총지배인.png">
      <img src="${contextPath}/resources/image/about/소피아밀러 총지배인.png" alt="박세진 셰프">
      <h3>소피아 밀러</h3>
      <p>General Manager</p>
    </div>
    
    <div class="team-member"
        data-name="다니엘 로페즈"
    	data-role="Head Sommelier"
    	data-origin="스페인 바르셀로나"
    	data-education="Court of Master Sommeliers Advanced"
    	data-career="El Celler de Can Roca, The Fat Duck"
    	data-description="좋은 와인은 요리의 이야기와 감정을 확장시키는 연출자입니다."
    	data-src="${contextPath}/resources/image/about/다니엘 로페즈 소믈리에.png">
      <img src="${contextPath}/resources/image/about/다니엘 로페즈 소믈리에.png" alt="박세진 셰프">
      <h3>다니엘 로페즈</h3>
      <p>Head Sommelier</p>
    </div>
  </div>
</section>

<div id="teamModal" class="modal">
  <div class="modal-content">
    <span class="close-btn">&times;</span>
    <img id="modalImg" src="" alt="Team Member" class="modal-img"/>
    <h2 id="modalName"></h2>
    <p id="modalRole"></p>
    <p id="modalOrigin"></p>
    <p id="modalEducation"></p>
    <p id="modalCareer"></p>
    <p id="modalDescription" class="noir-quote3"></p>
  </div>
</div>

<section class="about-philosophy section2 fade-up">

  <h2>Our Philosophy</h2>
  <p>
    NOIR는 요리를 단순한 음식 그 이상으로 여깁니다.<br>
    우리는 매일 새벽, 가장 신선하고 제철에 맞는 식재료를 직접 선별하여 그날의 메뉴를 구성합니다.<br>
    이는 일관된 맛보다는 매 순간 살아 숨 쉬는 ‘오늘’의 요리를 위한 철학입니다.
  </p>
  <br>
  <p>
    각각의 접시는 단순한 플레이팅을 넘어 하나의 이야기이자 감정입니다.<br>
    색과 질감, 온도와 향까지 – 오감을 자극하며, 당신의 기억 속에 오래도록 머무는 한 장면이 되기를 바랍니다.
  </p>
  <br>
  <p>
    우리는 당신의 저녁이 단순히 ‘맛있는’ 시간이 아닌, 느긋하게 삶을 음미하는 시간이 되기를 소망합니다.<br>
    그렇게 한 끼가, 하루를 바꾸는 조용한 울림이 될 수 있도록.
  </p>
  <br>
  <div class="noir-quote2 fade-up">
  	훌륭한 맛은 발견되는 것이 아닙니다. 조용히, 그리고 천천히 정제됩니다. - 셰프 박세진
  </div>
</section>



<section class="about-location section3 fade-up">
  <h2>Location & hour</h2>
  <p>서울특별시 강남구 모던로 123</p><br>
  <p>𝐋𝐮𝐧𝐜𝐡 : 𝟏𝟐:𝟑𝟎 ~ 𝟏𝟒:𝟓𝟎</p>
  <p>𝐛𝐫𝐞𝐚𝐤 : 𝟏𝟒:𝟓𝟎 ~ 𝟏𝟖:𝟑𝟎</p>
  <p>𝐝𝐢𝐧𝐧𝐞𝐫 : 𝟏𝟖:𝟑𝟎 ~ 𝟐𝟐:𝟎𝟎</p>
  
  <div id="map" style="margin-top:50px;">
  	<div id="kakaoMap-bottom">
		<div id="info">
		  <strong>NOIR 누아르</strong><br>
		</div>
		
		<div id="directions">
			<form id="routeForm" action="https://map.kakao.com/" method="get" target="_blank">
			  <input type="hidden" name="sName" value="출발지 입력"> <!-- 출발지 이름 -->
			  <input type="hidden" name="eName" value="강남역">  <!-- 도착지 이름 -->
			  <input type="hidden" name="eX" value="127.027610">  <!-- 도착지 경도 -->
			  <input type="hidden" name="eY" value="37.498095">   <!-- 도착지 위도 -->
			  <button type="submit">길찾기</button>
			</form>
		</div>
	</div>
  </div>
</section>

<!-- 카카오 지도 API -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0daab6c6c751704fe920d4bc06ea282d&libraries=services"></script>
<script>
	var container = document.getElementById('map');
	var options = {
	  center: new kakao.maps.LatLng(37.498095, 127.027610), 
	  level: 3
	};
	// 지도를 해당 좌표 중심으로 생성
	var map = new kakao.maps.Map(container, options);
	
	// 지도/스카이뷰 전환 버튼을 오른쪽 상단에 표시
	var mapTypeControl = new kakao.maps.MapTypeControl();
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
	
	// 줌 인/아웃 버튼을 오른쪽에 표시
	var zoomControl = new kakao.maps.ZoomControl();
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
	
	// 마커 표시
	var marker = new kakao.maps.Marker({
	  position: new kakao.maps.LatLng(37.498095, 127.027610),
	  map: map
	});
	
	// 마커 위에 말풍선처럼 주소 정보를 보여줌
	var infowindow = new kakao.maps.InfoWindow({
	  content: '<div style="margin-left:10px; width:100%; display:flex; justify-content:center; padding:5px;font-size:14px; text-align:center;"><p>누아르 | NOIR</p></div>'
	});
	infowindow.open(map, marker);
</script>

<script>

const modal = document.getElementById('teamModal');
const modalName = document.getElementById('modalName');
const modalRole = document.getElementById('modalRole');
const modalOrigin = document.getElementById('modalOrigin');
const modalEducation = document.getElementById('modalEducation');
const modalCareer = document.getElementById('modalCareer');
const modalDescription = document.getElementById('modalDescription');
const modalImg = document.getElementById('modalImg');
const closeBtn = document.querySelector('.close-btn');

document.querySelectorAll('.team-member').forEach(member => {
  member.addEventListener('click', () => {
    modalName.textContent = member.dataset.name;
    modalRole.textContent = member.dataset.role;
    modalOrigin.textContent = member.dataset.origin;
    modalEducation.textContent = member.dataset.education;
    modalCareer.textContent = member.dataset.career;
    modalDescription.textContent = member.dataset.description;
    modalImg.src = member.dataset.src;  // 여기서 이미지 넣기!
    modal.style.display = 'flex';
  });
});

closeBtn.addEventListener('click', () => {
  modal.style.display = 'none';
});

window.addEventListener('click', (e) => {
  if (e.target === modal) {
    modal.style.display = 'none';
  }
});
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