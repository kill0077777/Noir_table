<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

.icon_box {
  display: flex;
  justify-content: center;
}

.icon_box img {
  width: 50px;
  height: 50px;
}

.brand-icon {
  width: 36px;
  margin-bottom: 10px;
}

.social-btn {
  width: 100%;
  padding: 12px 40px; /* 좌우 여백 확보 */
  position: relative;
  display: flex;
  justify-content: center; /* 텍스트를 가운데 */
  align-items: center;
  border-radius: 6px;
  font-size: 1rem;
  font-weight: bold;
  cursor: pointer;
  margin-top: 10px;
  border: none;
  background-color: #FEE500; /* 예시: 카카오 컬러 */
  color: #000;
}

.social-icon {
  position: absolute;
  left: 16px;
  width: 17px;
  height: 17px;
}

.social-text {
  text-align: center;
}

.naver-btn img{
  left: 10px;
  width: 28px;
  height: 28px;
}

.kakao-btn {
  background-color: #FEE500;
  color: #3C1E1E;
}

.kakao-btn:hover {
  background-color: #ffd900;
}

.naver-btn {
  background-color: #03C75A;
  color: white;
}

.naver-btn:hover {
  background-color: #029a45;
}

.google-btn {
  background-color: white;
  color: #555;
  border: 1px solid #ccc;
}

.google-btn:hover {
  background-color: #f5f5f5;
}

.image-box{
	width:100%;
	display:flex;
	justify-content:center;
	align-items:center;
	margin-right:auto;
	margin-left:auto;
	margin-bottom:50px;
}

.image-box img{
	width:50%;
	heigth:70%;
	object-fit:cover;
	filter:grayScale(100%);
	transition: filter 0.5s ease-in;
}

.image-box img:hover{
	filter:grayScale(0%);
	transition: filter 0.5s ease-out;
}

</style>

<div class="icon_box fade-up" style="margin-top:30px; margin-bottom:20px;">
  <img src="${contextPath}/resources/image/noir_icon.png"/>
</div>
<div class="icon_box fade-up">
 	<h2>Connect with SNS</h2>
</div>
<div>

</div>
<div class=" fade-up" style="display:flex; gap:10px; width:50%; margin-left:auto; margin-right:auto; margin-bottom:50px;">

	<!-- 카카오 로그인 -->
    <button class="social-btn kakao-btn" id="kakaoLoginBtn">
      <img src="${contextPath}/resources/image/카카오톡 로고.webp" class="social-icon" alt="Kakao">
      <span class="social-text">카카오 연동하기</span>
    </button>
    
    <button class="social-btn naver-btn" id="naverLoginBtn">
      <img src="${contextPath}/resources/image/네이버 로고.png" class="social-icon" alt="Naver">네이버 연동하기
    </button>
    
    <button class="social-btn google-btn" id="googleLoginBtn">
      <img src="${contextPath}/resources/image/구글 로고.png" class="social-icon" alt="Google">구글 연동하기
    </button>
</div>

<c:if test="${not empty param.errorMsg}">
  <div class="icon_box" style="margin-bottom:50px;">
  	<div style="color:red; margin-left:auto; margin-right:auto;" class="fade-up">${param.errorMsg}</div>
  </div>
</c:if>

<div class="image-box fade-up">
	<img src="${contextPath}/resources/image/restaurant/restaurant2.png">
</div>
<script>
//카카오 로그인
const rawRedirectUri = "http://localhost:8090/noir/member/KakaoCallback";
const encodedRedirectUri = encodeURIComponent(rawRedirectUri);

const clientId = "f21e91b25c99a317f8ac6471ac3f3c5a";
const kakaoAuthUrl = "https://kauth.kakao.com/oauth/authorize?response_type=code&client_id="+clientId+"&redirect_uri="+encodedRedirectUri;

document.getElementById("kakaoLoginBtn").addEventListener("click", function () {
  window.location.href = kakaoAuthUrl;
});

//네이버 로그인
const naverRedirectUri = "http://localhost:8090/noir/member/NaverCallback";
const encodedNaverRedirectUri = encodeURIComponent(naverRedirectUri);
const state = "naver_" + new Date().getTime(); // CSRF 방지용 임시 state
const naverClientId = "EcRl77o5MKP8XONskdgt";
const naverAuthUrl = "https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id="+naverClientId+"&redirect_uri="+encodedNaverRedirectUri+"&state="+state;

document.getElementById("naverLoginBtn").addEventListener("click", function () {
	    window.location.href = naverAuthUrl;
});

//구글 로그인
const googleClientId = "1094665047278-252f9pu3h7e9547j7e39tjcnq83r6a2p.apps.googleusercontent.com";
const googleRedirectUri = encodeURIComponent("http://localhost:8090/noir/member/GoogleCallback");
const scope = "https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email";
const googleState = "google_" + new Date().getTime();

const googleAuthUrl = "https://accounts.google.com/o/oauth2/v2/auth?response_type=code&client_id="+googleClientId+"&redirect_uri="+googleRedirectUri+"&scope="+scope+"&state="+googleState;

document.getElementById("googleLoginBtn").addEventListener("click", function () {
  window.location.href = googleAuthUrl;
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
