<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>NOIR | 전화번호 입력</title>
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      height: 100vh;
    }

    .form-container {
      margin: 150px auto;
      padding: 40px 30px;
      border-radius: 16px;
      box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4), 0 2px 4px rgba(255, 255, 255, 0.05);
      width: 100%;
      max-width: 420px;
    }

    .form-container h2 {
      font-size: 1.5rem;
      margin-bottom: 16px;
      color: black;
      text-align: center;
    }

    .info-box {
      background-color: rgba(255, 255, 255, 0.08);
      border-left: 4px solid #888;
      padding: 16px;
      border-radius: 10px;
      margin-bottom: 24px;
      font-size: 0.95rem;
      line-height: 1.5;
      color: black;
    }

    label {
      display: block;
      margin-bottom: 6px;
      color: black;
      font-size: 0.95rem;
    }

    input[type="tel"] {
      width: 100%;
      padding: 12px;
      background-color: white;
      color: black;
      border: 1px solid #444;
      border-radius: 10px;
      font-size: 1rem;
      margin-bottom: 20px;
    }

    input[type="tel"]::placeholder {
      color: #888;
    }

    input[type="submit"] {
      width: 100%;
      padding: 12px;
      background-color: black;
      color: white;
      border: none;
      border-radius: 10px;
      font-weight: bold;
      font-size: 1rem;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    input[type="submit"]:hover {
      background-color: #5A2A7C;
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
	}
	
	.icon_box img{
		width:50px;
		height:50px;
	}
  </style>
</head>
<body>
  <div class="icon_box fade-up" style="margin-top:50px;">
	 <img src="${contextPath}/resources/image/noir_icon.png"/>
  </div>
  <div class="form-container fade-up">
    <h2>전화번호 입력</h2>
    <div class="info-box">
      구글 로그인은 전화번호 정보를 제공하지 않기 때문에<br>
      <strong style="color:black;">식당 예약을 위해 전화번호는 반드시 입력해 주세요.</strong>
    </div>

    <form action="${contextPath}/member/saveGooglePhone" method="post">
      <label for="phone">전화번호</label>
      <input type="tel" id="phone" name="phone" placeholder="예: 010-1234-5678" required>

      <input type="submit" value="등록하기">
    </form>
  </div>

<script>
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
</body>
</html>
