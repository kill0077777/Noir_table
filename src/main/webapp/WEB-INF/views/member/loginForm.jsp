<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>NOIR | 로그인</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      background-color: #f7f7f7;
      font-family: 'Noto Sans KR', sans-serif;
    }

    .login-container {
      width: 400px;
      margin: 120px auto;
      background-color: white;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 0 20px rgba(0,0,0,0.1);
      text-align: center;
    }

    .login-title {
      font-size: 2rem;
      margin-bottom: 30px;
      color: #333;
      font-weight: bold;
      letter-spacing: 2px;
    }

    .login-form input[type="text"],
    .login-form input[type="password"] {
      width: 100%;
      padding: 12px;
      margin: 10px 0;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 1rem;
    }

    .login-form button {
      width: 100%;
      padding: 12px;
      background-color: black;
      color: white;
      border: none;
      border-radius: 6px;
      font-size: 1rem;
      cursor: pointer;
      margin-top: 15px;
    }

    .login-form button:hover {
      background-color: #452160;
    }

    .divider {
      margin: 30px 0;
      text-align: center;
      color: #aaa;
      position: relative;
    }

    .divider::before,
    .divider::after {
      content: '';
      display: inline-block;
      width: 30%;
      height: 1px;
      background: #ccc;
      vertical-align: middle;
      margin: 0 10px;
    }
    
    .brand-icon {
      width: 36px;
      margin-bottom: 10px;
    }
	
	.main_title{
		text-decoration:none;
		color: black;
	}
	
	.main_title:hover{
		color: black;
	}
	
	.register-link {
	  margin-top: 20px;
	  font-size: 0.9rem;
	  color: #666;
	}
	
	.register-link a {
	  color: #5A2A7C;
	  text-decoration: none;
	  font-weight: bold;
	}
	
	.register-link a:hover {
	  text-decoration: underline;
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
  </style>
</head>
<body>

  <div class="login-container">
    <img src="${contextPath}/resources/image/noir_icon.png" class="brand-icon" alt="NOIR">
    <div class="login-title"><a href="${contextPath}/main.do" class="main_title" style="margin:0;">NOIR</a></div>
    
    <form class="login-form" action="${contextPath}/member/login.do" method="post">
      <input type="text" name="login_id" placeholder="아이디" required>
      <input type="password" name="password" placeholder="비밀번호" required>
      <c:if test="${not empty errorMsg}">
		 <div style="color: red; font-size: 0.9rem; margin-top: 10px;">
		   ${errorMsg}
		 </div>
	  </c:if>
      <button type="submit">로그인</button>
    </form>
    

    <div class="divider">또는</div>

    <!-- 카카오 로그인 -->
    <button class="social-btn kakao-btn" id="kakaoLoginBtn">
      <img src="${contextPath}/resources/image/카카오톡 로고.webp" class="social-icon" alt="Kakao">
      <span class="social-text">카카오 로그인</span>
    </button>
    
    <button class="social-btn naver-btn" id="naverLoginBtn">
      <img src="${contextPath}/resources/image/네이버 로고.png" class="social-icon" alt="Naver">네이버 로그인
    </button>
    
    <button class="social-btn google-btn" id="googleLoginBtn">
      <img src="${contextPath}/resources/image/구글 로고.png" class="social-icon" alt="Google">구글 로그인
    </button>
    
    <!-- 회원가입 링크 -->
	<div class="register-link">
	  아직 계정이 없으신가요? <a href="${contextPath}/member/registerForm.do">회원가입</a>
	</div>
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
</script>


</body>
</html>
