<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
.editContainer {
  max-width: 500px;
  margin: 5px auto;
  padding: 30px;
  text-align: center;
  font-family: 'Noto Sans KR', sans-serif;
}

.profile-wrap {
  position: relative;
  display: inline-block;
  margin-bottom: 30px;
}

.profile-img {
  width: 150px;
  height: 150px;
  border-radius: 50%;
  object-fit: cover;
  border: 3px solid #ccc;
}

.change-btn {
  position: absolute;
  right: 0;
  bottom: 0;
  transform: translate(25%, 25%);
  padding: 6px 10px;
  font-size: 0.9rem;
  background-color: #333;
  color: white;
  border: none;
  border-radius: 20px;
  cursor: pointer;
  z-index: 10;
}

.input-label {
  text-align: left;
  margin: 5px 0 5px 3px;
  font-size: 0.9rem;
  font-weight: bold;
}

.input-field {
  width: 100%;
  padding: 10px;
  font-size: 1rem;
  border: 1px solid #ccc;
  border-radius: 8px;
  box-sizing: border-box;
}

.input-field:focus {
  outline: none;
  border-color: #666;
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

.icon_box {
  display: flex;
  justify-content: center;
}

.icon_box img {
  width: 50px;
  height: 50px;
}

#social_btn{
  color: #452160;
  border:1px solid #452160;
  background-color:white;
}

#social_btn:hover{
  background-color:#452160; 
  color:white;
}
</style>

<div class="icon_box fade-up" style="margin-top:30px; margin-bottom:20px;">
  <img src="${contextPath}/resources/image/noir_icon.png"/>
</div>
<div class="icon_box fade-up">
 	<h2>개인정보 수정</h2>
</div>

<div class="editContainer fade-up">
	
  <!-- 사용자 정보 수정 인풋 필드 -->
  <form action="${contextPath}/member/update.do" method="post" enctype="multipart/form-data">
    <!-- 프로필 이미지 영역 -->
	<div class="profile-wrap fade-up">
	 <c:choose>

	    <c:when test="${fn:startsWith(sessionScope.member.profileImage, 'http')}">
	      <c:set var="profileSrc" value="${sessionScope.member.profileImage}" />
	    </c:when>
	

	    <c:when test="${not empty sessionScope.member.profileImage}">
	      <c:set var="profileSrc" value="${contextPath}/upload/profile/${sessionScope.member.profileImage}" />
	    </c:when>
	

	    <c:otherwise>
	      <c:set var="profileSrc" value="${contextPath}/resources/image/noir_icon.png" />
	    </c:otherwise>
	  </c:choose>
	
	  <img id="profilePreview"
	       class="profile-img"
	       src="${profileSrc}"
	       alt="프로필 이미지" />
	
	  <!-- 숨김 파일 업로드 인풋 -->
	  <input type="file" id="profileImageInput" name="profileImage"
	         accept="image/*" style="display: none;" onchange="previewProfileImage(this)" />
	
	  <!-- 사용자 클릭 유도 버튼 -->
	  <button type="button" class="change-btn"
	          onclick="document.getElementById('profileImageInput').click();">사진 변경</button>
	</div>
	
    <!-- 로그인 아이디 (읽기전용) -->
    <div class="input-label">아이디</div>
    <div class="input-field" style="background-color:#f2f2f2; cursor: default;">
      ${member.login_id}
    </div>


	<!-- 비밀번호 -->
	<div class="input-label">비밀번호</div>
	
	<div style="display: flex; justify-content:space-between; align-items:center;">
	  <!-- 비밀번호 인풋 -->
	  <div style="display: flex;">
	  <input type="password" id="password" name="password" class="input-field" value="${member.password}" placeholder="비밀번호" style="width:400px;">
	
	  <!-- 보기 버튼 (input 내부 오른쪽) -->
	  <button type="button" onclick="togglePassword()" style="
	  	position:absolute;
	  	margin-top:10px;
	  	margin-left:350px;
	  	background: white;
	  	cursor:pointer;
	  	border:0;
	  	">보기</button>
	  </div>
	
	  <!-- 비밀번호 변경 버튼 (가로형) -->
	  <button type="button" id="change-btn" onclick="showChangePasswordFields()" style="
	    padding: 10px 16px;
	    background-color: black;
	    color: white;
	    border: none;
	    border-radius: 8px;
	    font-size: 1rem;
	    cursor: pointer;
	    height: 45px;
	  ">변경</button>
	</div>
	
	<!-- 변경할 비밀번호 입력 필드 (초기에는 숨김) -->
	<div id="changePasswordSection" style="display: none; margin-top: 15px;">
	  <div class="input-label">변경할 비밀번호</div>
	  <input type="password" id="newPassword" class="input-field" placeholder="새 비밀번호">
	
	  <div class="input-label">변경할 비밀번호 확인</div>
	  <input type="password" id="confirmPassword" class="input-field" placeholder="새 비밀번호 확인">
	
	  <div id="pwMatchMessage" style="font-size: 0.9rem; margin-top: 5px;"></div>
	</div>


    <!-- 이름 -->
    <div class="input-label">이름</div>
    <input type="text" name="name" class="input-field" value="${member.name}" placeholder="이름">

    <!-- 전화번호 -->
    <div class="input-label">전화번호</div>
    <input type="text" name="phone" class="input-field" value="${member.phone}" placeholder="전화번호">

    <!-- 소셜 타입 -->
    <div class="input-label">소셜 연동</div>
    <c:choose>
      <c:when test="${empty member.social_type}">
        <button type="button" class="input-field" id="social_btn" onclick="location.href='${contextPath}/member/snslink.do'">소셜 연동하기</button>
      </c:when>
      <c:otherwise>
        <div class="input-field" style="background-color:#f2f2f2; cursor: default;">
          ${member.social_type}
        </div>
      </c:otherwise>
    </c:choose>

    <!-- 제출 버튼 -->
    <button type="submit" class="input-field" style="background-color: black; color: white; margin-top:30px;">수정하기</button>
  </form>
</div>

<script>
	function previewProfileImage(input) {
	  const preview = document.getElementById('profilePreview');
	  const file = input.files[0];

	  if (file && file.type.startsWith('image/')) {
	    const reader = new FileReader();
	    reader.onload = function (e) {
	      preview.src = e.target.result;
	    };
	    reader.readAsDataURL(file);
	  }
	}

   function togglePassword() {
	  const pwInput = document.getElementById('password');
	  if (pwInput.type === 'password') {
	    pwInput.type = 'text';
	  } else {
	    pwInput.type = 'password';
	  }
	}

   function showChangePasswordFields() {
	   const section = document.getElementById('changePasswordSection');
	   const button = event.target;

	   if (section.style.display === 'none' || section.style.display === '') {
	     section.style.display = 'block';
	     button.textContent = '취소';
	   } else {
	     section.style.display = 'none';
	     button.textContent = '변경';
	   }
	 }

	// 비밀번호 일치 여부 확인
	document.addEventListener("DOMContentLoaded", function () {
	  const newPw = document.getElementById('newPassword');
	  const confirmPw = document.getElementById('confirmPassword');
	  const message = document.getElementById('pwMatchMessage');

	  function checkMatch() {
	    if (newPw.value === "" && confirmPw.value === "") {
	      message.textContent = "";
	      return;
	    }

	    if (newPw.value === confirmPw.value) {
	      message.style.color = "green";
	      message.textContent = "비밀번호가 일치합니다.";
	    } else {
	      message.style.color = "red";
	      message.textContent = "비밀번호가 일치하지 않습니다.";
	    }
	  }

	  newPw.addEventListener("input", checkMatch);
	  confirmPw.addEventListener("input", checkMatch);
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
