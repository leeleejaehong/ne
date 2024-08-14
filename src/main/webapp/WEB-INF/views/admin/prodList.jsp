<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../header.jsp"/>
상품리스트(보이는건 수정가능)

<h1>
<a href="${pageContext.request.contextPath}/admin/adminProdcut.do">상품추가</a>
</h1>

<c:forEach var="dto" items="${prodList}">
<form name="f" action="/admin/updateProdPro.do" method="POST">
	
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="product_code" value="${dto.product_code}" />
	<table>
	<tr>
		<td>상품이름:${dto.product_name}</td>
		<td>상품기간:${dto.start_date} ~ ${dto.end_date}</td>
		<td>기본금리:${dto.base_rate}</td>
		<td>골든볼금리:${dto.goldenball_rate}</td>
		<td>상품상태:${dto.product_status}</td>
		<td><input type="submit" value="수정하기"></td>
	</tr>
	</table>

	
		</form>
		</c:forEach>

<jsp:include page="../footer.jsp"/>