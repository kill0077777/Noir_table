<%@ page contentType="text/html; charset=UTF-8" %>
<%
  String message = request.getAttribute("message") != null ? (String) request.getAttribute("message") : "알 수 없는 오류입니다.";
  String redirectUrl = request.getAttribute("redirectUrl") != null ? (String) request.getAttribute("redirectUrl") : "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script type="text/javascript">
        alert("<%= message %>");
        location.href = "<%= redirectUrl %>";
    </script>
</head>
<body></body>
</html>
