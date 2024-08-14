<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="../header.jsp" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<div class="login-form" style="width: 35%; margin: auto; margin-top: 150px; height: 50%;">
	<h2 style="text-align: center">비밀번호변경하기</h2>
	<form action="updatepwPro.do" method="post" name="frm">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="memberID" value="${member.memberID}"/>
		<input type="password" name="pass" placeholder="변경할 패스워드" id="pass">
		<input type="password" name="password" placeholder="변경할 패스워드 확인" id="passwd">
		<button type="button" onclick="sub()">변경하기</button>
	</form>
</div>
<script>
	function sub(){
		if(document.getElementById("pass").value == "" || document.getElementById("passwd").value == ""){
			alert("비밀번호를 입력해주세요");
		} else if(document.getElementById("pass").value != document.getElementById("passwd").value) {
			alert("입력하신 비밀번호가 다릅니다");
		} else{
			alert("비밀번호가 변경되었습니다!");
			document.frm.submit();
		}
	}
</script>
<jsp:include page="../footer.jsp" />