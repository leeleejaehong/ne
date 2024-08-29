<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<jsp:include page="../header.jsp" />
<link rel="stylesheet" type="text/css" href="/css/member/acount.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<script>
    function handlePrimaryAccountChange(checkbox) {
        if (checkbox.checked) {
            // 모든 다른 체크박스를 비활성화
            const checkboxes = document.querySelectorAll('.primary-account-checkbox');
            checkboxes.forEach(cb => {
                if (cb !== checkbox) {
                    cb.checked = false;
                }
            });
            // 체크된 경우 value를 "Y"로 설정
            checkbox.value = "Y";
        } else {
            // 체크 해제된 경우 value를 "N" 설정
            checkbox.value = "N";
        }
    }


    function acountForm() {
        const memberID = document.getElementById("member_id").value.trim();
        const accountnum = document.getElementById("acount_number").value.trim();
        const primaryAccountChecked = document.getElementById("primaryAccount").checked;

        if (!memberID || !accountnum) {
            alert("모든 필드를 입력해주세요.");
        } else {
            // 주계좌로 설정된 경우 처리 로직 추가
            if (primaryAccountChecked) {
                // 모든 계좌를 비주계좌로 변경
                fetch(`/acount/updateAllAccountsToNonPrimary?member_id=${memberID}`, {method: 'POST'})
                    .then(response => response.text())
                    .then(() => {
                        document.getElementById("acount_status").value = "Y";
                        document.frm.submit();
                    });
            } else {
                document.getElementById("acount_status").value = "N";
                document.frm.submit();
            }
        }
    }
</script>
<main>
<div class="acount">
    <div class="header-content">
        <div class="vanner">
            <img alt="main" src="${pageContext.request.contextPath}/img/van.jpg" style="width:898px; height: 280px;">
        </div>
        <div class="login-form">
                <sec:authorize access="isAuthenticated()">
<div class="logview">
    <div class="profile-container">
        <table class="profile-table">
            <tr>
                <td width="50%" class="profile-image-cell">
                    <img src="${pageContext.request.contextPath}/img/${profile.profile}" alt="프로필 이미지" class="profile-img"/>
                </td>
                <td class="profile-info-cell">
                    <div class="profile-info">
                        <strong class="itemfont col" id="nickNameArea">
                            환영합니다<br>
                            <sec:authentication property="principal.username"/>님
                        </strong>
                        <br>
                        <div class="links">
                            <a href="${pageContext.request.contextPath}/member/myPage.do?user=<sec:authentication property="principal.username"/>" class="link-btn">마이페이지</a>
                            <a href="/admin/editMemberForm.do?memberID=<sec:authentication property='principal.username'/>" class="link-btn">내 정보 수정</a>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <form action="<c:url value='/logout' />" method="post" class="logout-form">
            <button type="submit" class="logout-btn">로그아웃</button>
        </form>
    </div>
</div>
</sec:authorize>
            <sec:authorize access="isAnonymous()">
                <h4>neoheulge <br> 더 안전하고 더 편리하게</h4>
                <form action="<c:url value='/login' />" method="post">
                    <input type="text" name="username" placeholder="사용자 이름" required>
                    <input type="password" name="password" placeholder="비밀번호" required>
                    <button type="submit">로그인</button>
                </form>
                <div class="links">
                    <a href="/find-id">아이디 찾기</a> |
                    <a href="/find-password">비밀번호 찾기</a> |
                    <a href="${pageContext.request.contextPath}/member/signup.do">회원가입</a>
                </div>
            </sec:authorize>
        </div>
    </div>

    <div align="center" style="margin-top: 10px;">
        <table class="form-wrapper">
            <tr>
                <td>
                    <form action="/acount/insertNeacount.do" method="post" class="form-container" name="frm">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <div class="signForm">
                            <table>
                                <tr>
                                    <td style="text-align: center;">
                                        <label for="member_id" style="display: none">아이디</label>
                                        <input type="text" id="member_id" name="member_id" value="<sec:authentication property="principal.username"/>">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">
                                        <label for="acount_number" style="display: none">계좌번호</label>
                                        <input type="text" id="acount_number" name="acount_number" placeholder="계좌번호 입력">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">
                                        <input type="hidden" id="acount_status" name="acount_status" value="">
                                        <input type="checkbox" id="primaryAccount" class="primary-account-checkbox" onclick="handlePrimaryAccountChange(this)"> 주계좌로 설정
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">
                                        <button type="button" onclick="acountForm()">계좌추가</button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </form>
                </td>
            </tr>
        </table>
    </div>
</div>
</main>
<jsp:include page="../footer.jsp" />
