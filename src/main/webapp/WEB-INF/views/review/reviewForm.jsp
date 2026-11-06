<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% request.setCharacterEncoding("UTF-8"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- FontAwesome for stars -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<style>
/* 페이드 인 */
.fade-up {
  opacity: 0;
  transform: translateY(50px);
  transition: opacity 1.2s ease-out, transform 1.2s ease-out;
}
.fade-up.show {
  opacity: 1;
  transform: translateY(0);
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

body {
    font-family: 'Noto Sans KR', sans-serif;
    background: white;
}

form {
    max-width: 600px;
    margin: 40px auto;
    padding: 30px;
    background: white;
    border-radius: 12px;
    box-shadow: 0 0 12px rgba(0,0,0,0.08);
}

form h1 {
    text-align: center;
    margin-bottom: 30px;
}

.form-group {
    margin-bottom: 20px;
}

label {
    font-weight: bold;
}

input[type="text"],
textarea,
select {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 1rem;
}

button[type="submit"] {
    width: 100%;
    padding: 12px;
    background: #333;
    color: white;
    border: none;
    border-radius: 6px;
    font-size: 1.1rem;
    cursor: pointer;
}

.star-rating {
    display: flex;
    gap: 8px;
    font-size: 28px;
    cursor: pointer;
}

.star-rating .fa-star {
    color: #ccc;
    transition: color 0.2s;
}

.star-rating .fa-star.hovered,
.star-rating .fa-star.selected {
    color: #FFD700;
}

.line{
	margin-bottom:20px;
}

#preview img {
    max-width: 100%;
    max-height: 300px;
    border-radius: 8px;
    border: 1px solid #ccc;
    margin-top: 10px;
    display: block;
}
</style>


<div class="icon_box fade-up" style="margin-top:30px; margin-bottom:20px;">
  <img src="${contextPath}/resources/image/noir_icon.png"/>
</div>
<h2 class="fade-up" style="text-align: center;">리뷰 작성</h2>

<form action="${contextPath}/review/write.do" method="post" enctype="multipart/form-data" class="fade-up">
	<!-- 예약 선택 -->
	<!-- 고객 예약 ID -->
	<div class="line">
	    <label for="customer_id">리뷰 작성할 예약 선택</label><br>
	    <select name="customer_id" id="customer_id" required>
	        <option value="">예약을 선택하세요</option>
			<c:set var="today" value="<%= new java.text.SimpleDateFormat(\"yyyy-MM-dd\").format(new java.util.Date()) %>" />
			
			<c:forEach var="reserve" items="${reserveList}">
			  <c:if test="${reserve.status == 'ACTIVE'}">
			    <c:if test="${reserve.reviewAdminVO.reserve_date <= today}">
			      <option value="${reserve.customer_id}">
			        ${reserve.reviewAdminVO.reserve_date} / ${reserve.reviewAdminVO.meal_time} (${reserve.reviewAdminVO.time_slot})
			      </option>
			    </c:if>
			  </c:if>
			</c:forEach>
	    </select>
	</div>

    <!-- 제목 -->
    <div class="line">
        <label for="title">제목</label><br>
        <input type="text" id="title" name="title" required>
    </div>

    <!-- 내용 -->
    <div class="line">
        <label for="content">내용</label><br>
        <textarea id="content" name="content" rows="6" cols="50" required></textarea>
    </div>

	<!-- 별점 -->
	<div class="form-group line">
	    <label>별점</label><br>
	    <div class="star-rating">
	        <i class="fa fa-star" data-value="1"></i>
	        <i class="fa fa-star" data-value="2"></i>
	        <i class="fa fa-star" data-value="3"></i>
	        <i class="fa fa-star" data-value="4"></i>
	        <i class="fa fa-star" data-value="5"></i>
	    </div>
	    <input type="hidden" id="rating" name="rating" value="0" required>
	</div>

	<!-- 이미지 업로드 -->
	<div class="form-group">
	    <label for="photoUrls">사진 첨부</label><br>
		<input type="file" id="photoUrls" name="photoUrls" accept="image/*" onchange="previewImage(this)">
	    <img id="preview" style="display:none; margin-top:10px; max-width:100%; max-height:300px; border-radius:8px; border:1px solid #ccc;">
	    
	</div>

    <!-- 제출 버튼 -->
    <div style="margin-top: 20px;">
        <button type="submit">리뷰 작성</button>
    </div>
</form>

<script>

function previewImage(input) {
  const preview = document.getElementById("preview");
  const file = input.files[0];

  if (file) {
    const reader = new FileReader();
    reader.onload = function(e) {
      preview.src = e.target.result;
      preview.style.display = 'block';
    }
    reader.readAsDataURL(file);
  } else {
    preview.src = '';
    preview.style.display = 'none';
  }
}

document.addEventListener("DOMContentLoaded", function () {
    const stars = document.querySelectorAll(".star-rating .fa-star");
    const ratingInput = document.getElementById("rating");

    stars.forEach(star => {
        star.addEventListener("mouseenter", () => {
            const value = parseInt(star.dataset.value);
            highlightStars(value);
        });

        star.addEventListener("mouseleave", () => {
            resetStars();
        });

        star.addEventListener("click", () => {
            const value = parseInt(star.dataset.value);
            ratingInput.value = value;
            selectStars(value);
        });
    });

    function highlightStars(value) {
        stars.forEach(star => {
            const val = parseInt(star.dataset.value);
            star.classList.toggle("hovered", val <= value);
        });
    }

    function resetStars() {
        stars.forEach(star => star.classList.remove("hovered"));
    }

    function selectStars(value) {
        stars.forEach(star => {
            const val = parseInt(star.dataset.value);
            star.classList.toggle("selected", val <= value);
        });
    }
});

//페이드 인 효과
const observer = new IntersectionObserver(entries => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.classList.add('show');
      observer.unobserve(entry.target);
    }
  });
}, { threshold: 0.2 });

document.querySelectorAll('.fade-up').forEach(section => {
  observer.observe(section);
});

console.log("⭐ 이미지 업로드 스크립트 시작됨");

</script>
