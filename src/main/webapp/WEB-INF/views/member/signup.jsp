<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="../header.jsp"/>
<form action="/member/signupPro.do" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<div class="signForm">
		<p>이름 : </p> <input type="text" name="name">
		<p>아이디 : </p> <input type="text" name ="memberID">
		<p>비밀번호 : </p> <input type="password" name="password">
		<p>프로필 사진(추후 사진업로드로 변경예정) : </p> <input type="text" name="profile">
		<p>닉네임 : </p> <input type="text" name="nickname">
		<p>이메일 : </p> <input type="text" name="email">
		<p>전화번호 : </p> <input type="text" name="phone">
		<button type="submit">회원가입</button>
	</div>
</form>
<jsp:include page="../footer.jsp"/>