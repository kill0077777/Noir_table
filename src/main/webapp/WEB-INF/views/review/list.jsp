<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- JSTL 중에서 core 태그를 사용하기 위해 주소를 import --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- 한글 인코딩 --%>
<% request.setCharacterEncoding("UTF-8"); %>

<%-- 현재 웹 애플리케이션(프로젝트)의 기본 경로를 가져옵니다. --%>
<%-- 예를 들어, 프로젝트 주소가 http://localhost:8090/noir/review.do --%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link rel="stylesheet" href="${contextPath}/resources/css/review/paging.css">
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

.fa-star {
  transition: transform 0.15s;
}
.fa-star:hover {
  transform: scale(1.2) rotate(-10deg);
  color: #ffbc42 !important;
}

.review-table {
  width: 80%;
  margin: 40px auto;
  border-collapse: collapse;
  font-family: 'Noto Sans KR', sans-serif;
  box-shadow: 0 0 15px rgba(0, 0, 0, 0.05);
  border-radius: 8px;
  overflow: hidden;
}

.review-table th, .review-table td {
  padding: 12px;
  border-bottom: 1px solid #e5e5e5;
}

.review-table thead {
  background-color: black;
  color: white;
}

/* tr 호버 시 볼록하게 */
.body-tr {
  transition: transform 0.2s ease, box-shadow 0.2s ease;
  cursor: pointer;
}
.body-tr:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.review-table th, .review-table td {
  padding: 15px 12px;
  border-bottom: 1px solid #ddd;
  text-align: center;         /* ✅ 가로 중앙 정렬 */
  vertical-align: middle;     /* ✅ 세로 중앙 정렬 */
}


.review-table a {
  color: #333;
  text-decoration: none;
  font-weight: bold;
}

.review-table a:hover {
  color: #555;
  text-decoration: underline;
}

</style>
<div class="icon_box fade-up" style="margin-top:30px; margin-bottom:20px;">
  <img src="${contextPath}/resources/image/noir_icon.png"/>
</div>
<h2 class="fade-up" style="text-align: center;">리뷰 목록</h2>
<table class="review-table fade-up">
    <colgroup>
        <col style="width: 10%;">   <!-- 번호 -->
        <col style="width: 60%;">  <!-- 제목 -->
        <col style="width: 10%;">  <!-- 별점 -->
        <col style="width: 10%;">  <!-- 작성자 -->
        <col style="width: 10%;">  <!-- 식사종류 -->
    </colgroup>
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>별점</th>
			<th>작성자</th>
			<th>식사종류</th>
		</tr>
	</thead>
	<tbody>
	    <c:forEach var="review" items="${reviewList}">
	        <tr class="body-tr">
	            <td>${review.reviewId}</td>
	            <td><a href="${contextPath}/review/detail.do?reviewId=${review.reviewId}">${review.title}</a></td>
	            <td>
	                <c:forEach var="i" begin="1" end="5">
	                    <i class="${i <= review.rating ? 'fas' : 'far'} fa-star" style="color:#FFD700"></i>
	                </c:forEach>
	            </td>
	            <td>${review.userName}</td>
	
	            <!-- ✅ reserveList에서 customer_id 매칭되는 meal_time 찾기 -->
	            <td>
	                <c:forEach var="reserve" items="${reserveList}">
	                    <c:if test="${reserve.customer_id == review.customer_id}">
	                        ${reserve.reviewAdminVO.meal_time}
	                    </c:if>
	                </c:forEach>
	            </td>
	        </tr>
	    </c:forEach>
	</tbody>
</table>

<c:if test="${not empty sessionScope.member}">
  <div class="fade-up" style="text-align: center; margin-top: 20px;">
    <a href="${contextPath}/review/write.do" style="padding: 10px 20px; background: #333; color: white; text-decoration: none; border-radius: 6px;">
      리뷰 작성
    </a>
  </div>
</c:if>
<!-- 페이징 및 블록페이징 처리 -->
<center>
	<div class="pagination fade-up" style="text-align:center; clear:both; margin-bottom:50px;">
		<c:if test="${startBlock > 1}">
			<a href="${contextPath}/review.do?page=${startBlock - 1}">이전</a>
		</c:if>
	
		<c:forEach var="i" begin="${startBlock}" end="${endBlock}">
			<c:choose>
				<c:when test="${i == currentPage}">
					<strong>${i}</strong>
				</c:when>
				<c:otherwise>
					<a href="${contextPath}/review.do?page=${i}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	
		<c:if test="${endBlock < totalPage}">
	    	<a href="${contextPath}/review.do?page=${endBlock + 1}">다음</a>
		</c:if>
	</div>
</center>            

<script>

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
