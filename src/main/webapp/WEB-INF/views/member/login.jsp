<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
asdsadaaa
<p>로그인 실패: ${param.message}</p>
<c:if test="${param.error == 'true'}">
    <div>
        <p>로그인 실패: ${param.message}</p>
    </div>
</c:if>
</body>
</html>