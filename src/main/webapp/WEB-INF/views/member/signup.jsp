<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../header.jsp" />
	<link rel="stylesheet" href="/css/qna/signup.css">
	<%--	<script src="javascript/signup.js"></script>--%>
</head>
<body>
<style>
	.hide {
		display: none;
	}
</style>
<div align="center" style="margin-top: 50px;">
	<h1>
		<span style="font-weight: bold; color: #004d99;">회원가입</span>
	</h1>
	<div align="center" style="margin-top: 10px;">

		<table class="form-wrapper">
			<tr>
				<td>
					<form action="/member/signupPro.do" method="post"
						  class="form-container" name="frm" enctype="multipart/form-data">
						<input type="hidden" name="${_csrf.parameterName}"
							   value="${_csrf.token}" />
						<div class="signForm">
							<table>
								<tr>
									<td><label for="profile">프로필 사진</label>
										<div class="profile-upload">
											<input type="file" id="profile" name="file"
												   accept="image/*" />
										</div></td>

								</tr>
								<tr>
									<td><label for="name">이름</label> <input
											type="text" id="name" name="name" placeholder="이름 입력(필수)"></td>
								</tr>
								<tr>
									<td><label for="memberID"
									>아이디</label> <input type="text"
														id="memberID" name="memberID" placeholder="아이디 입력(필수)">
										<div class="success-message hide">사용할 수 있는 아이디입니다</div>
										<div class="failure-message hide">아이디는 4~12글자이어야 합니다</div>
										<div class="failure-message2 hide">영어 또는 숫자만 가능합니다</div>
									</td>

								</tr>
								<tr>
									<td><label for="password">비밀번호</label> <input type="password"
																				  id="password" name="password" placeholder="비밀번호 입력(필수)">
										<div class="strongPassword-message hide">8글자 이상, 영문, 숫자, 특수문자(@$!%*#?&)를 사용하세요</div>
										<label for="password">비밀번호 확인</label> <label
												for="password-retype"> </label><input type="password" id="password-retype" name="password-retype" placeholder="비밀번호 입력(필수)">
										<div class="mismatch-message hide">비밀번호가 일치하지 않습니다</div>

									</td>
								</tr>
								<tr>
									<td><label for="nickname"
									>닉네임</label> <input type="text"
														id="nickname" name="nickname" placeholder="닉네임 입력"></td>
								</tr>
								<tr>
									<td><label for="email"
									>이메일</label> <input type="text"
														id="email" name="email" placeholder="이메일 입력"></td>
								</tr>
								<tr>
									<td><label for="phone"
									>전화번호</label> <input type="text"
														 id="phone" name="phone" placeholder="전화번호 입력"></td>
								</tr>
								<tr>
									<td style="text-align: center;">
										<button type="button" onclick="subForm()">회원가입</button>
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
<script>
	document.addEventListener('DOMContentLoaded', function() {
		const form = document.querySelector('form[name="frm"]');
		const elInputUsername = document.querySelector('#memberID');
		const elSuccessMessage = document.querySelector('.success-message');
		const elFailureMessage = document.querySelector('.failure-message');
		const elFailureMessageTwo = document.querySelector('.failure-message2');

		const elInputPassword = document.querySelector('#password');
		const elInputPasswordRetype = document.querySelector('#password-retype');
		const elMismatchMessage = document.querySelector('.mismatch-message');
		const elStrongPasswordMessage = document.querySelector('.strongPassword-message');

		const elName = document.querySelector('#name');
		const elNickname = document.querySelector('#nickname');
		const elEmail = document.querySelector('#email');
		const elPhone = document.querySelector('#phone');

		// 새로운 오류 메시지 요소 생성
		const elNameError = createErrorElement('name-error');
		const elNicknameError = createErrorElement('nickname-error');
		const elEmailError = createErrorElement('email-error');
		const elPhoneError = createErrorElement('phone-error');

		// 스타일 추가
		const style = document.createElement('style');
		style.textContent = `
          .error-message {
              color: red;
              font-size: 0.9em;
              margin-top: 5px;
          }
          .success-message {
              color: green;
              font-size: 0.9em;
              margin-top: 5px;
          }
      `;
		document.head.appendChild(style);

		function createErrorElement(id) {
			const el = document.createElement('div');
			el.id = id;
			el.classList.add('error-message');
			el.style.display = 'none';
			return el;
		}

		function idLength(value) {
			return value.length >= 4 && value.length <= 12;
		}

		function onlyNumberAndEnglish(str) {
			return /^[A-Za-z0-9]+$/.test(str);
		}

		function strongPassword(str) {
			return /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/.test(str);
		}

		function isMatch(password1, password2) {
			return password1 === password2;
		}

		function isValidEmail(email) {
			return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
		}

		function isValidNickname(nickname) {
			return /^[A-Za-z0-9가-힣]{2,10}$/.test(nickname);
		}

		function isValidKoreanName(name) {
			return /^[가-힣]{2,5}$/.test(name);
		}

		function isValidPhoneNumber(phone) {
			return /^01[016789][0-9]{8}$/.test(phone);
		}

		function toggleVisibility(element, shouldShow) {
			element.style.display = shouldShow ? 'block' : 'none';
		}

		function validateForm() {
			let isValid = true;

			// Username validation
			if (!idLength(elInputUsername.value) || !onlyNumberAndEnglish(elInputUsername.value)) {
				isValid = false;
				toggleVisibility(elSuccessMessage, false);
				toggleVisibility(elFailureMessage, !idLength(elInputUsername.value));
				toggleVisibility(elFailureMessageTwo, !onlyNumberAndEnglish(elInputUsername.value));
			} else {
				toggleVisibility(elSuccessMessage, true);
				toggleVisibility(elFailureMessage, false);
				toggleVisibility(elFailureMessageTwo, false);
			}

			// Password validation
			if (!strongPassword(elInputPassword.value)) {
				isValid = false;
				toggleVisibility(elStrongPasswordMessage, true);
			} else {
				toggleVisibility(elStrongPasswordMessage, false);
			}

			// Password match validation
			if (!isMatch(elInputPassword.value, elInputPasswordRetype.value)) {
				isValid = false;
				toggleVisibility(elMismatchMessage, true);
			} else {
				toggleVisibility(elMismatchMessage, false);
			}

			// Name validation
			if (!isValidKoreanName(elName.value)) {
				isValid = false;
				elNameError.textContent = "이름은 2~5자의 한글만 가능합니다.";
				toggleVisibility(elNameError, true);
			} else {
				toggleVisibility(elNameError, false);
			}

			// Nickname validation
			if (!isValidNickname(elNickname.value)) {
				isValid = false;
				elNicknameError.textContent = "닉네임은 2~10자의 한글, 영문, 숫자만 가능합니다.";
				toggleVisibility(elNicknameError, true);
			} else {
				toggleVisibility(elNicknameError, false);
			}

			// Email validation
			if (!isValidEmail(elEmail.value)) {
				isValid = false;
				elEmailError.textContent = "올바른 이메일 형식이 아닙니다.";
				toggleVisibility(elEmailError, true);
			} else {
				toggleVisibility(elEmailError, false);
			}

			// Phone validation
			if (!isValidPhoneNumber(elPhone.value)) {
				isValid = false;
				elPhoneError.textContent = "올바른 전화번호 형식이 아닙니다. (11자리 숫자)";
				toggleVisibility(elPhoneError, true);
			} else {
				toggleVisibility(elPhoneError, false);
			}

			return isValid;
		}

		// 오류 메시지 요소에 클래스 추가 및 DOM에 삽입
		[elFailureMessage, elFailureMessageTwo, elMismatchMessage, elStrongPasswordMessage,
			elNameError, elNicknameError, elEmailError, elPhoneError].forEach(el => {
			el.classList.add('error-message');
			if (!el.parentNode) {
				const inputEl = document.getElementById(el.id.replace('-error', ''));
				inputEl.parentNode.insertBefore(el, inputEl.nextSibling);
			}
		});

		// Initialize visibility of messages
		[elSuccessMessage, elFailureMessage, elFailureMessageTwo, elMismatchMessage,
			elStrongPasswordMessage, elNameError, elNicknameError, elEmailError, elPhoneError].forEach(el => {
			toggleVisibility(el, false);
		});

		// 비밀번호 재확인 실시간 검사
		function checkPasswordMatch() {
			if (elInputPassword.value === elInputPasswordRetype.value) {
				toggleVisibility(elMismatchMessage, false);
			} else {
				elMismatchMessage.textContent = "비밀번호가 일치하지 않습니다.";
				toggleVisibility(elMismatchMessage, true);
			}
		}

		elInputPasswordRetype.addEventListener('input', checkPasswordMatch);
		elInputPasswordRetype.addEventListener('paste', function(e) {
			setTimeout(checkPasswordMatch, 0);
		});

		// Override the original subForm function
		window.subForm = function() {
			if (validateForm()) {
				form.submit();
			}
		};
	});
</script>
</body>

</html>
