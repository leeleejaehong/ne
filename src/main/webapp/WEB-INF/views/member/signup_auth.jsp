<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="../header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/findid.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<h2 style="text-align: center;">본인인증</h2>
<div class="content_header">
</div>
<div class="login-form">

    <form action="findid.do" method="post" name="frm">
        <input type="text" name="name" placeholder="이름을 입력해주세요" id="name">
        <input type="text" name="phone" id="phone" placeholder="전화번호를 입력해주세요" style="width: 60%;">
        <button type="button" onclick="subCertifi()" style="width: 30%; margin-left: 10px; padding: 7px;" >인증번호발송</button>
        <input type="text" name="certi" id="certi" placeholder="인증번호를 입력해주세요" style="width: 60%;">
        <button type="button" onclick="check()" style="width: 30%; margin-left: 10px; padding: 7px;">인증번호확인</button>
        <button type="button" onclick="sub()">회원가입</button>
    </form>
</div>
<script type="text/javascript">
    let ck = false;
    let serverCheck = '';

    function subCertifi() {

        const phone = document.getElementById("phone").value;
        const name = document.getElementById("name").value;

        if (!name) {
            alert("이름을 먼저 입력해주세요");
            return;
        }

        $.ajax({
            url: 'subCrtifi.ajax',
            type: 'POST',
            contentType: 'application/x-www-form-urlencoded',
            data: { "phone": phone },
            // beforeSend: function(xhr) {
            //     xhr.setRequestHeader(csrfHeader, csrfToken);
            // },
            success: function(response) {
                console.log(response);
                serverCheck = response.check;
                alert("인증번호가 전송되었습니다. 문자를 확인해주세요");
                document.getElementById("phone").disabled = true;
            },
            error: function(xhr, status, error) {
                console.error('인증번호 전송 실패:', error);
                console.error('상태 코드:', xhr.status);
                console.error('응답 텍스트:', xhr.responseText);
                alert("인증번호 전송에 실패했습니다. 다시 시도해 주세요.");
            }
        });
    }
    async function check() {
        const certInput = document.getElementById("certi").value;
        const phone = document.getElementById("phone").value;
        const name = document.getElementById("name").value;

        if (serverCheck === certInput && serverCheck !== '') {
            try {
                const requestData = {
                    phone: phone
                };
                const response = await fetch("/member/validateMember", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json",
                    },
                    body: JSON.stringify(requestData),
                });
                console.log('전송하는 데이터:', { phone: phone });
                console.log('응답 상태:', response.status);
                console.log('응답 헤더:', Object.fromEntries(response.headers));

                if (!response.ok) {
                    console.error('HTTP 상태:', response.status);
                    console.error('상태 텍스트:', response.statusText);
                    const errorBody = await response.text();
                    console.error('응답 본문:', errorBody);
                    throw new Error(`HTTP error! status: ${response.status}`);
                }

                const responseBody = await response.text();
                console.log('서버 응답:', responseBody);

                // JSON 파싱을 시도합니다.
                let json;
                try {
                    json = JSON.parse(responseBody);
                } catch (parseError) {
                    console.error('JSON 파싱 오류:', parseError);
                    throw new Error('서버 응답을 파싱할 수 없습니다.');
                }

                alert(json.message);

                if (json.status === "new") {
                    sessionStorage.setItem('userName', name);
                    sessionStorage.setItem('userPhone', phone);
                } else {
                    // 기존 회원인 경우의 처리
                    alert("이미 가입된 회원입니다.");
                }
            } catch (error) {
                console.error('검증 오류:', error);
                alert("검증 과정에서 오류가 발생했습니다. 다시 시도해 주세요.");
            }
        } else {
            alert("인증번호가 일치하지 않습니다.");
        }
    }


    function sub() {
        if (ck) {
            document.frm.submit();
            window.location.replace("member/signup.do");
        } else {
            alert("문자 인증을 마쳐주세요!");
        }
    }
</script>


<jsp:include page="../footer.jsp" />