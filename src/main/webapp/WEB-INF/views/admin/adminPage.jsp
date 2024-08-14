<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="../header.jsp"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<main>
<div align="center">
		<font size="5">관리자 페이지</font><br>
		<table border="1" width="1200" height="600">
			<tr height="10%">
				<th width="33%"><a href="${pageContext.request.contextPath}/admin/adminMember.do">회원관리</a></th>
				<th width="33%"><a href="${pageContext.request.contextPath}/admin/updateProd.do">상품관리</a></th>
				<th width="33%"><a href="${pageContext.request.contextPath}/admin/adminChart.do"">매출관리</a></th>
			</tr>
			<tr height="90%">
				<td align="center" colspan="4">
				<img src="img/le.png" width="100%" height="100%">
				</td>
			</tr>
		
		</table>
	</div>
				
</main>

<jsp:include page="../footer.jsp"/>