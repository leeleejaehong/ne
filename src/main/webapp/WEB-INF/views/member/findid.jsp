<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="../header.jsp" />
<div class="login-form" style="width: 35%; margin: auto; margin-top: 150px; height: 50%;">
	<h2 style="text-align: center">아이디찾기</h2>
	<form action="findid" method="post">
		<input type="text" name="name" placeholder="이름을 입력해주세요">
		<input type="text" name="mail" placeholder="메일을 입력해주세요">
		<input type="text" name="mail" placeholder="인증번호를 입력해주세요" style="width: 60%;">
		<button type="submit" style="width: 30%; margin-left: 10px; padding: 7px;">인증번호발송</button>
		<button type="submit" style="width: 45%; margin-left: 15px;">인증번호확인</button>
		<button type="submit" style="width: 45%;">찾기</button>
	</form>
</div>
<jsp:include page="../footer.jsp" />