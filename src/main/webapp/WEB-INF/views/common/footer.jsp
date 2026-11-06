<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"    
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<style>
    footer {
        background-color: #f0f0f0; /* 연한 회색 배경 */
        color: #444;
        font-family: 'Noto Sans KR', sans-serif;
        font-size: 0.85rem;
        padding: 30px 40px;
        text-align: center;
    }

    .footer-inner {
        max-width: 1200px;
        margin: 0 auto;
    }

    .footer-logo {
        font-weight: bold;
        font-size: 1.1rem;
        margin-bottom: 8px;
    }

    .footer-links {
        margin: 12px 0;
        color: #666;
    }

    .footer-links span {
        margin: 0 10px;
    }

    .footer-address {
        color: #888;
    }
</style>

<footer>
    <div class="footer-inner">
        <div class="footer-logo">NOIR 누아르</div>
        <div class="footer-links">
            <span>이용약관</span> | 
            <span>개인정보처리방침</span> | 
            <span>고객센터</span>
        </div>
        <div class="footer-address">
            서울특별시 강남구 모던로 123, 3층 &nbsp;&nbsp;|&nbsp;&nbsp; 사업자등록번호 123-45-67890  
            <br/>대표자 박세진 &nbsp;&nbsp;|&nbsp;&nbsp; 대표번호 02-1234-5678
        </div>
        <div style="margin-top: 10px; color: #aaa;">© 2025 NOIR. All rights reserved.</div>
    </div>
</footer>

