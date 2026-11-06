<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% request.setCharacterEncoding("UTF-8"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

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
</style>
<div class="icon_box fade-up" style="margin-top:30px; margin-bottom:20px;">
  <img src="${contextPath}/resources/image/noir_icon.png"/>
</div>
<h2 class="fade-up" style="text-align: center;">고객 리뷰</h2>

<div class="review-container fade-up">
	<div style="font-size:30px; margin-bottom:25px; text-align:center;">
    	<strong>${review.title}</strong>
	</div>
	<div class="review-header" style="display: flex; gap: 30px; flex-wrap: wrap;">

	    <div>
	        <strong>별점:</strong>
	        <c:forEach var="i" begin="1" end="5">
	            <i class="${i <= review.rating ? 'fas' : 'far'} fa-star" style="color:#FFD700;"></i>
	        </c:forEach>
	    </div>
	
	    <div><strong>식사 시간:</strong> ${reserve.reviewAdminVO.meal_time}</div>
	
	    <div>
	        <strong>예약 날짜:</strong>
	        <fmt:formatDate value="${reserve.reviewAdminVO.reserve_date}" pattern="yyyy-MM-dd" />
	    </div>
	</div>

	<c:choose>
	    <c:when test="${fn:startsWith(review.photoUrls, '/resources/')}">
	        <div class="review-photo">
	            <img src="${contextPath}${review.photoUrls}" alt="리뷰 사진" />
	        </div>
	    </c:when>
	
	    <c:when test="${not empty review.photoUrls}">
	        <div class="review-photo">
	            <c:forEach var="photo" items="${fn:split(review.photoUrls, ',')}">
	                <img src="${contextPath}/upload/review/${photo}" alt="리뷰 사진" />
	            </c:forEach>
	        </div>
	    </c:when>
	</c:choose>

    <div class="review-content">
        <label><strong>내용</strong></label>
        <textarea readonly>${review.content}</textarea>
    </div>

    <div class="review-buttons">
        <div class="left-buttons">
            <c:if test="${sessionScope.member != null && sessionScope.member.id == reserve.member_id}">
                <form action="${contextPath}/review/edit.do" method="get" style="display:inline;">
                    <input type="hidden" name="reviewId" value="${review.reviewId}" />
                    <button type="submit">수정</button>
                </form>
                <form action="${contextPath}/review/delete.do" method="post" style="display:inline;">
                    <input type="hidden" name="reviewId" value="${review.reviewId}" />
                    <input type="hidden" name="photoUrls" value="${review.photoUrls}"/>
                    <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
                </form>
            </c:if>
        </div>
        <div class="right-button">
            <form action="${contextPath}/review/list.do" method="get">
                <button type="submit">목록으로</button>
            </form>
        </div>
    </div>
</div>

<script>
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
