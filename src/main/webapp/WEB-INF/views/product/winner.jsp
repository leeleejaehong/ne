<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
 <jsp:include page="../header.jsp"/>
<table border="1">
	<tr>
		<td>상품</td>
		<td>당첨금액</td>
		<td>당첨자</td>	
	</tr>
	<c:forEach var="dto" items="${winnerList}">
	<tr>
		<td>${dto.product_name}</td>
		<td>${dto.accumulated_amount}</td>
		<td>${dto.winner}</td>
	</tr>
	</c:forEach>
</table>
    <jsp:include page="../footer.jsp"/>
