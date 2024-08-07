<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../header.jsp" />
<link rel="stylesheet"	href="/css/qna/signup.css">
</head>
<body>
	<div align="center" style="margin-top: 50px;">
		<h1>
			<span style="font-weight: bold; color: #004d99;">회원가입</span>
		</h1>
		<div align="center" style="margin-top: 10px;">
			
			<table class="form-wrapper">
				<tr>
					<td>
						<form action="/member/signupPro.do" method="post"
							class="form-container">
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
							<div class="signForm">
								<table>
								    <tr>
									<td style="text-align: center;"><label for="profile"
											style="display: none">프로필 사진</label> <input type="text"
											id="profile" name="profile" placeholder="프로필 사진"></td>
									</tr>
									<tr>
										<td style="text-align: center;"><label for="name"
											style="display: none">이름</label> <input type="text" id="name"
											name="name" placeholder="이름 입력(필수)"></td>
									</tr>
									<tr>
										<td style="text-align: center;"><label for="memberID"
											style="display: none">아이디</label> <input type="text"
											id="memberID" name="memberID" placeholder="아이디 입력(필수)">
										</td>
									</tr>
									<tr>
										<td style="text-align: center;"><label for="password"
											style="display: none">비밀번호</label> <input type="password"
											id="password" name="password" placeholder="비밀번호 입력(필수)">
										</td>
									</tr>
									<tr>
										<td style="text-align: center;"><label for="nickname"
											style="display: none">닉네임</label> <input type="text"
											id="nickname" name="nickname" placeholder="닉네임 입력"></td>
									</tr>
									<tr>
										<td style="text-align: center;"><label for="email"
											style="display: none">이메일</label> <input type="text"
											id="email" name="email" placeholder="이메일 입력"></td>
									</tr>
									<tr>
										<td style="text-align: center;"><label for="phone"
											style="display: none">전화번호</label> <input type="text"
											id="phone" name="phone" placeholder="전화번호 입력"></td>
									</tr>
									<tr>
										<td style="text-align: center;">
											<button type="submit">회원가입</button>
										</td>
									</tr>
								</table>
							</div>
						</form>
					</td>
				</tr>
			</table>
		</div>
		<div align="center" style="margin-bottom: 50px; border-radius: 8px;">
		</div>
	</div>
	<jsp:include page="../footer.jsp" />
</body>
</html>
