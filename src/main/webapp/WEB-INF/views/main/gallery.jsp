<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="uploadPath" value="${pageContext.request.contextPath}/upload/gallery" />
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<% request.setCharacterEncoding("UTF-8"); %>
<link href="https://fonts.googleapis.com/css2?family=Dancing+Script&display=swap" rel="stylesheet">


<div class="gallery-container fade-up">

	<div class="icon_box fade-up" style="margin-top:50px;">
	   <img src="${contextPath}/resources/image/noir_icon.png"/>
	</div>
	
	<div class="gallery-title fade-up">
		Gallery
	</div>
	

   <c:if test="${sessionScope.member.role eq 'ADMIN'}">
     <a href="${contextPath}/gallery/registerForm.do" class="btn-photo">사진 등록</a>
   </c:if>
  
  
  	<!-- 메뉴 섹션 -->
  	<div class="gallery-section fade-up">
  	 <div style="display:flex; justify-content:space-between;">
  	 	<div>
	 		<h2>MENU</h2>
	 	</div>
	 	<c:if test="${fn:length(menuPhotoList) > 12}">
	    	<div class="text-center">
	      		<button class="btn-more" onclick="showToggle('menu-photo', this)">+ 더보기</button>
	    	</div>
	  	</c:if>
	 </div>
	 <hr>
	 <div class="gallery-grid menu-grid fade-up">
	   <c:forEach var="photo" items="${menuPhotoList}" varStatus="status">
	     <c:choose>
	       <c:when test="${fn:startsWith(photo.photo_url, '/resources/')}">
	         <img src="${contextPath}${photo.photo_url}" 
	              class="menu-photo ${status.index >= 12 ? 'hidden' : ''}" onclick="openModal(this)" data-id="${photo.id}"/>
	       </c:when>
	       <c:otherwise>
	         <img src="${uploadPath}/${photo.photo_url}" 
	              class="menu-photo ${status.index >= 12 ? 'hidden' : ''}" onclick="openModal(this)" data-id="${photo.id}"/>
	       </c:otherwise>
	     </c:choose>
	   </c:forEach>
	 </div>
	</div>
	
	<!-- 식당 섹션 -->
	<div class="gallery-section fade-up">
	  <div style="display:flex; justify-content:space-between;">
  	 	<div>
	 		<h2>RESTAURANT</h2>
	 	</div>
	 	<c:if test="${fn:length(restaurantPhotoList) > 12}">
	    	<div class="text-center">
	      		<button class="btn-more" onclick="showToggle('restaurant-photo', this)">+ 더보기</button>
	    	</div>
	  	</c:if>
	 </div>
	 <hr>
	  <div class="gallery-grid fade-up">
	    <c:forEach var="photo" items="${restaurantPhotoList}">
	      <c:choose>
	        <c:when test="${fn:startsWith(photo.photo_url, '/resources/')}">
	          <img src="${contextPath}${photo.photo_url}" 
	               class="restaurant-photo ${status.index >= 12 ? 'hidden' : ''}" onclick="openModal(this)" data-id="${photo.id}"/>
	        </c:when>
	        <c:otherwise>
	          <img src="${uploadPath}/${photo.photo_url}" 
	               class="restaurant-photo ${status.index >= 12 ? 'hidden' : ''}" onclick="openModal(this)" data-id="${photo.id}"/>
	        </c:otherwise>
	      </c:choose>
	    </c:forEach>
	  </div>
	</div>
	
	<!-- 직원 섹션 -->
	<div class="gallery-section fade-up">
	  <div style="display:flex; justify-content:space-between;">
  	 	<div>
	 		<h2>STAFF</h2>
	 	</div>
	 	<c:if test="${fn:length(staffPhotoList) > 12}">
	    	<div class="text-center">
	      		<button class="btn-more" onclick="showToggle('staff-photo', this)">+ 더보기</button>
	    	</div>
	  	</c:if>
	 </div>
	 <hr>
	  <div class="gallery-grid fade-up">
	    <c:forEach var="photo" items="${staffPhotoList}">
	      <c:choose>
	        <c:when test="${fn:startsWith(photo.photo_url, '/resources/')}">
	          <img src="${contextPath}${photo.photo_url}" 
	               class="staff-photo ${status.index >= 12 ? 'hidden' : ''}" onclick="openModal(this)" data-id="${photo.id}"/>
	        </c:when>
	        <c:otherwise>
	          <img src="${uploadPath}/${photo.photo_url}" 
	               class="staff-photo ${status.index >= 12 ? 'hidden' : ''}" onclick="openModal(this)" data-id="${photo.id}"/>
	        </c:otherwise>
	      </c:choose>
	    </c:forEach>
	  </div>
	</div>
	
  <div class="icon_box fade-up" style="margin-top:50px;">
  	<img src="${contextPath}/resources/image/noir_icon.png"/>
  </div>
	
</div>

<div id="imageModal" class="modal" style="display:none;">
  <span class="close-btn" onclick="closeModal()">&times;</span>
  <img class="modal-content" id="modalImage">
  <button class="nav-btn left" onclick="prevImage()">&#10094;</button>
  <button class="nav-btn right" onclick="nextImage()">&#10095;</button>
    <!-- 🔥 삭제 버튼 추가 -->
  <c:if test="${sessionScope.member.role eq 'ADMIN'}">
  	<button class="delete-btn" onclick="deleteImage()">🗑 삭제</button>
  </c:if>
</div>

<style>
.modal {
  display: none;
  position: fixed;
  z-index: 999;
  padding-top: 60px;
  left: 0; top: 0;
  width: 100%; height: 100%;
  background-color: rgba(0, 0, 0, 0.9);
  text-align: center;
}

.modal-content {
  max-width: 80%;
  max-height: 80%;
  border-radius: 10px;
  box-shadow: 0 0 20px #000;
}

.close-btn {
  position: absolute;
  top: 30px;
  right: 40px;
  color: #fff;
  font-size: 36px;
  font-weight: bold;
  cursor: pointer;
}

.nav-btn {
  position: absolute;
  top: 50%;
  font-size: 40px;
  color: white;
  background: none;
  border: none;
  cursor: pointer;
  transform: translateY(-50%);
  padding: 20px;
}

.nav-btn.left {
  left: 20px;
}
.nav-btn.right {
  right: 20px;
}

.delete-btn {
  position: absolute;
  bottom: 100px;
  left: 50%;
  transform: translateX(-50%);
  background-color: #d9534f;
  color: white;
  border: none;
  padding: 10px 18px;
  font-size: 14px;
  border-radius: 5px;
  cursor: pointer;
  transition: background 0.3s;
}

.delete-btn:hover {
  background-color: #c9302c;
}


.gallery-title{
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

.btn-photo {
  font-size: 14px;
  color: #f00;
  border: 1px solid #f00;
  padding: 4px 8px;
  text-decoration: none;
  border-radius: 4px;
}

.btn-photo:hover {
  color:#fff;
  background-color:#f00;
}

.hidden {
  display: none;
}

.text-center {
  text-align: center;
  margin-top: 20px;
}

.btn-more {
  background: none;
  border: 1px solid #452160;
  color: #452160;
  padding: 6px 14px;
  border-radius: 4px;
  cursor: pointer;
  transition: 0.3s;
}
.btn-more:hover {
  background: #452160;
  color: #fff;
}

.gallery-container{
	width:80%;
	margin-right:auto;
	margin-left:auto;
}

.gallery-section {
  margin-bottom: 50px;
}
.gallery-section h2 {
  font-size: 22px;
  margin-bottom: 10px;
  padding-bottom: 5px;
}
.gallery-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
  gap: 20px;
}
.gallery-grid img {
  width: 100%;
  aspect-ratio: 3 / 4;
  object-fit: cover;
  background-color: #f9f9f9;
  border-radius: 10px;
  padding: 6px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
  filter: grayscale(100%);
  transition: 0.5s;
}
.gallery-grid img:hover {
  transform: scale(1.05);
  filter: grayscale(0%);
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
  margin-bottom:50px;
}

.icon_box img{
	width:50px;
	height:50px;
}
</style>

<script>
function showToggle(className, button) {
	  const allItems = document.querySelectorAll('.'+className);
	  const isExpanded = !allItems[12]?.classList.contains('hidden'); // 13번째가 보이면 접힌 상태 아님

	  allItems.forEach((item, index) => {
	    if (index >= 12) {
	      item.classList.toggle('hidden', isExpanded); // 더보기면 보여주고, 접기면 숨기기
	    }
	  });

	  button.textContent = isExpanded ? '+ 더보기' : '접기';
	}

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
  
  
  //화면클릭 이미지
  let currentImageIndex = 0;
  let imageList = [];

  function openModal(clickedImg) {
    imageList = Array.from(document.querySelectorAll('.gallery-grid img'));
    currentImageIndex = imageList.indexOf(clickedImg);

    document.getElementById('modalImage').src = clickedImg.src;
    document.getElementById('imageModal').style.display = "block";
  }

  function closeModal() {
    document.getElementById('imageModal').style.display = "none";
  }

  function prevImage() {
    if (imageList.length === 0) return;
    currentImageIndex = (currentImageIndex - 1 + imageList.length) % imageList.length;
    document.getElementById('modalImage').src = imageList[currentImageIndex].src;
  }

  function nextImage() {
    if (imageList.length === 0) return;
    currentImageIndex = (currentImageIndex + 1) % imageList.length;
    document.getElementById('modalImage').src = imageList[currentImageIndex].src;
  }
  
  function deleteImage() {
	  if (!confirm('이 사진을 삭제하시겠습니까?')) return;

	  const img = imageList[currentImageIndex];
	  const photoId = img.dataset.id; // data-id에서 값 가져오기
	  
	  // 여기서 서버로 AJAX 요청을 보내야 함
	  fetch('${contextPath}/gallery/deletePhoto', {
	    method: 'POST',
	    headers: {
	      'Content-Type': 'application/json'
	    },
	    body: JSON.stringify({ photoId: photoId })
	  })
	  .then(res => res.json())
	  .then(data => {
	    if (data.success) {
	      alert('삭제되었습니다.');
	      img.remove(); // DOM에서 제거
	      closeModal();
	    } else {
	      alert('삭제에 실패했습니다.');
	    }
	  })
	  .catch(err => {
	    console.error(err);
	    alert('오류가 발생했습니다.');
	  });
	}

</script>