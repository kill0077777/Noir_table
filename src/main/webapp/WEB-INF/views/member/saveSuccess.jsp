<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>전화번호 저장 성공</title>
    <script>
        alert("📞전화번호 저장이 성공적으로 완료되었습니다!");
        location.href = "<c:url value='/main.do'/>";
    </script>
</head>
<body>
</body>
</html>