<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% request.setCharacterEncoding("UTF-8"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

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
        background-color: #fefefe;
        color: #111;
        font-family: 'Noto Sans KR', sans-serif;
    }

    .icon_box img {
        width: 60px;
        height: 60px;
        filter: grayscale(100%);
    }

    h2 {
        font-weight: 600;
        letter-spacing: 1px;
        color: #111;
    }

    .review-container {
        max-width: 820px;
        margin: 50px auto;
        padding: 40px;
        background-color: #fff;
        border: 1px solid #e0e0e0;
        border-radius: 12px;
        box-shadow: 0 0 20px rgba(0,0,0,0.05);
        color: #111;
    }

    .review-header {
        border-bottom: 1px solid #ddd;
        padding-bottom: 20px;
        margin-bottom: 30px;
    }

    .review-header h2 {
        color: #000;
        margin-bottom: 10px;
    }

    .review-header p {
        margin: 6px 0;
        font-size: 0.95rem;
        color: #333;
    }

    .review-photo {
        margin-bottom: 30px;
    }

    .review-photo img {
        width: 160px;
        height: auto;
        margin: 10px;
        border-radius: 8px;
        border: 1px solid #ddd;
        transition: transform 0.3s ease;
    }

    .review-photo img:hover {
        transform: scale(1.05);
    }

    .review-content label {
        font-weight: bold;
        display: block;
        margin-bottom: 8px;
        color: #000;
    }

    .review-content textarea {
        width: 100%;
        height: 200px;
        resize: none;
        padding: 15px;
        background-color: #f9f9f9;
        color: #111;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 1rem;
        line-height: 1.6;
    }

    .review-buttons {
        display: flex;
        justify-content: space-between;
        margin-top: 30px;
    }

    .left-buttons form,
    .right-button form {
        display: inline-block;
    }

    .left-buttons button,
    .right-button button {
        padding: 10px 22px;
        border: 1px solid #111;
        border-radius: 6px;
        background-color: white;
        color: #111;
        font-weight: bold;
        font-size: 0.95rem;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .left-buttons button:hover,
    .right-button button:hover {
        background-color: #111;
        color: #fff;
    }
	
	.star-rating {
	  display: inline-block;
	}
	.star-rating span {
	  font-size: 1.2rem;
	  color: #ccc;
	}
	.star-rating .filled {
	  color: #000; /* Noir 느낌이면 #111 또는 #FFD700 골드로도 변경 가능 */
	}
	.star-rating .fa-star {
    font-size: 1.5rem;
    color: #ccc;
    cursor: pointer;
    transition: color 0.2s;
}

.star-rating .fa-star.selected {
    color: #FFD700;
}
</style>

<form action="${contextPath}/review/update.do" method="post" enctype="multipart/form-data">
    <input type="hidden" name="reviewId" value="${review.reviewId}" />

    <div class="icon_box fade-up" style="margin-top:30px; margin-bottom:20px;">
        <img src="${contextPath}/resources/image/noir_icon.png"/>
    </div>
    <h2 class="fade-up" style="text-align: center;">리뷰 수정</h2>

    <div class="review-container fade-up">
    
		<div style="display: flex; align-items: center; margin-bottom: 30px;">
		    <label style="min-width: 70px; font-weight: bold;">제목:</label>
		    <input type="text" name="title" value="${review.title}" 
		           style="flex: 1; font-size: 1.1rem; font-weight: bold; padding: 8px 10px; border: 1px solid #ccc; border-radius: 6px; outline: none;" />
		</div>

        <div class="review-header" style="display: flex; gap: 30px; flex-wrap: wrap;">
			<!-- 별점 -->
			<label>별점</label>
			<div class="form-group line">
			    <div class="star-rating">
			        <i class="fa fa-star" data-value="1"></i>
			        <i class="fa fa-star" data-value="2"></i>
			        <i class="fa fa-star" data-value="3"></i>
			        <i class="fa fa-star" data-value="4"></i>
			        <i class="fa fa-star" data-value="5"></i>
			    </div>
			    <input type="hidden" id="rating" name="rating" value="0" required>
			</div>

            <div><strong>식사 시간:</strong> ${reserve.reviewAdminVO.meal_time}</div>
            <div>
                <strong>예약 날짜:</strong>
                <fmt:formatDate value="${reserve.reviewAdminVO.reserve_date}" pattern="yyyy-MM-dd" />
            </div>
        </div>

		<div style="display: flex; gap: 40px; margin-top: 30px; flex-wrap: wrap;">
		    <!-- 왼쪽: 현재 사진 -->
		    <c:if test="${not empty review.photoUrls}">
		        <div class="review-photo" style="flex: 1;">
		            <p><strong>현재 첨부 사진:</strong></p>
		            <c:forEach var="photo" items="${fn:split(review.photoUrls, ',')}">
		                <img src="${contextPath}/upload/review/${photo}" alt="리뷰 사진" />
		            </c:forEach>
		        </div>
		    </c:if>
		
		    <!-- 오른쪽: 새로 선택한 사진 미리보기 -->
		    <div style="flex: 1;">
		        <div id="newPreview" class="review-photo" style="margin-top: 10px;">
		            <p><strong>변경할 사진:</strong></p>
		            <!-- JS에서 이미지 삽입 -->
		        </div>
		    </div>
		</div>

        <div class="review-content">
            <label><strong>내용</strong></label>
            <textarea name="content">${review.content}</textarea>
        </div>

        <div style="margin-top: 20px;">
	        <label><strong>사진 변경 :</strong></label><br>
	        <input type="file" name="photoFiles" id="photoFiles" multiple accept="image/*" />
	        <input type="hidden" name="photoUrls" value="${review.photoUrls}"/>
        </div>

        <div class="review-buttons">
            <div class="left-buttons">
                <button type="submit">수정 완료</button>
            </div>
            <div class="right-button">
                <button type="button" onclick="location.href='${contextPath}/review/detail.do?reviewId=${review.reviewId}'">취소</button>
            </div>
        </div>
    </div>
</form>


<script>
document.getElementById('photoFiles').addEventListener('change', function (e) {
	  const previewContainer = document.getElementById('newPreview');
	  previewContainer.innerHTML = '<p><strong>미리보기:</strong></p>';

	  const files = e.target.files;
	  if (files.length === 0) return;

	  Array.from(files).forEach(file => {
	    if (!file.type.startsWith('image/')) return;

	    const reader = new FileReader();
	    reader.onload = function (event) {
	      const img = document.createElement('img');
	      img.src = event.target.result;
	      img.alt = '미리보기';
	      img.style.width = '160px';
	      img.style.margin = '10px';
	      img.style.borderRadius = '8px';
	      img.style.border = '1px solid #ddd';
	      previewContainer.appendChild(img);
	    };
	    reader.readAsDataURL(file);
	  });
	});

//별점 클릭 로직
document.addEventListener('DOMContentLoaded', function () {
  const stars = document.querySelectorAll('.star-rating .fa-star');
  const ratingInput = document.getElementById('rating');

  function highlightStars(value) {
    stars.forEach(star => {
      const starValue = parseInt(star.getAttribute('data-value'));
      if (starValue <= value) {
        star.classList.add('selected');
      } else {
        star.classList.remove('selected');
      }
    });
  }

  // 초기 별점 값 설정 (서버값 반영)
  const initialRating = parseInt('${review.rating}');
  ratingInput.value = initialRating;
  highlightStars(initialRating);

  // 클릭 이벤트
  stars.forEach(star => {
    star.addEventListener('click', function () {
      const selectedValue = parseInt(this.getAttribute('data-value'));
      ratingInput.value = selectedValue;
      highlightStars(selectedValue);
    });
  });
});

// 페이드 인 효과
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
</script>
