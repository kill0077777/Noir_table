<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>NOIR | 회원가입</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      background-color: #f7f7f7;
      font-family: 'Noto Sans KR', sans-serif;
    }

    .register-container {
      width: 400px;
      margin: 120px auto;
      background-color: white;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 0 20px rgba(0,0,0,0.1);
      text-align: center;
    }

    .register-title {
      font-size: 2rem;
      margin-bottom: 30px;
      color: #333;
      font-weight: bold;
      letter-spacing: 2px;
    }

    .register-form input[type="text"],
    .register-form input[type="password"] {
      width: 100%;
      padding: 12px;
      margin: 10px 0;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 1rem;
    }

    .join-btn{
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

    .join-btn:hover {
      background-color: #452160;
    }

    .brand-icon {
      width: 36px;
      margin-bottom: 10px;
    }

    .main_title {
      text-decoration: none;
      color: black;
    }

    .main_title:hover {
      color: black;
    }
    
    .error-msg {
	  color: red;
	  font-size: 0.85rem;
	  text-align: left;
	  margin: 0 0 10px 5px;
	}
	
	.login-link {
	  margin-top: 20px;
	  font-size: 0.9rem;
	  color: #666;
	}
	
	.login-link a {
	  color: #5A2A7C;
	  text-decoration: none;
	  font-weight: bold;
	}
	
	.login-link a:hover {
	  text-decoration: underline;
	}
.id-check-wrapper {
  display: flex;
  gap: 10px;
  align-items: center;
  margin-bottom: 10px;
}

.id-check-wrapper input[type="text"] {
  flex: 1;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 6px;
  font-size: 1rem;
}

.check-btn {
  padding: 12px 16px;
  background-color: black;
  color: white;
  border: none;
  border-radius: 6px;
  font-size: 0.9rem;
  white-space: nowrap;
  height: 44px;
  cursor: pointer;
}

.check-btn:hover {
  background-color: #452160;
}
  </style>
</head>
<body>

  <div class="register-container">
    <img src="${contextPath}/resources/image/noir_icon.png" class="brand-icon" alt="NOIR">
    <div class="register-title"><a href="${contextPath}/main.do" class="main_title" style="margin:0;">NOIR</a></div>

	<form class="register-form" action="${contextPath}/member/register.do" method="post">
		<!-- 아이디 + 중복확인 버튼 묶음 -->
		<div class="id-check-wrapper">
		  <input type="text" name="loginId" id="loginId" placeholder="아이디" value="${param.loginId}">
		  <button type="button" class="check-btn" onclick="checkDuplicateId()">중복확인</button>
		</div>
		
		<div id="idCheckResult" class="error-msg" style="color: red;">
		  <c:if test="${not empty loginIdError}">
		    ${loginIdError}
		  </c:if>
		</div>
	
	  <input type="password" name="password" placeholder="비밀번호">
	  <c:if test="${not empty passwordError}">
	    <div class="error-msg">${passwordError}</div>
	  </c:if>
	
	  <input type="text" name="name" placeholder="이름" value="${param.name}">
	  <c:if test="${not empty nameError}">
	    <div class="error-msg">${nameError}</div>
	  </c:if>
	
	  <input type="text" name="phone" placeholder="전화번호" value="${param.phone}">
	  <c:if test="${not empty phoneError}">
	    <div class="error-msg">${phoneError}</div>
	  </c:if>
	  
	  <!-- 개인정보 동의 체크 -->
	  <div style="text-align: left; margin-top: 20px;">
		 <label>
		   <input type="checkbox" name="agreePolicy" value="true" 
		          ${param.agreePolicy eq 'true' ? 'checked' : ''}>
		   [필수] 개인정보 처리방침에 동의합니다.
		 </label>
	  	 <c:if test="${not empty agreePolicyError}">
		    <div class="error-msg">${agreePolicyError}</div>
		 </c:if>
	  </div>
		
	  <!-- 마케팅 수신 동의 -->
	  <div style="text-align: left; margin-top: 10px;">
		 <label>
		   <input type="checkbox" name="agreeMarketing" value="true"
		          ${param.agreeMarketing eq 'true' ? 'checked' : ''}>
		   [선택] 마케팅 정보 수신에 동의합니다.
		</label>
	  </div>
	  
	
	  <button class="join-btn" type="submit">회원가입</button>
	</form>
	
	<!-- 로그인 링크 -->
	<div class="login-link">
	  이미 회원이신가요? <a href="${contextPath}/member/loginForm.do">로그인</a>
	</div>
  </div>

<script>
  function checkDuplicateId() {
    const loginId = document.getElementById("loginId").value.trim();
    const resultEl = document.getElementById("idCheckResult");

    if (!loginId) {
      resultEl.style.color = "red";
      resultEl.textContent = "아이디를 입력해주세요.";
      return;
    }

    fetch("${contextPath}/member/checkId.do?loginId=" + encodeURIComponent(loginId))
      .then(response => response.json())
      .then(data => {
	   	  if (data.isDuplicate) {
	   		  resultEl.style.color = "red";
	   		  resultEl.textContent = "이미 사용 중인 아이디입니다.";
	   		} else {
	   		  resultEl.style.color = "green";
	   		  resultEl.textContent = "사용 가능한 아이디입니다.";
	   		}
      })
      .catch(error => {
        resultEl.style.color = "red";
        resultEl.textContent = "오류 발생: 중복 확인 실패";
      });
  }
</script>
</body>
</html>


