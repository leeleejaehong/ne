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

<div class="acount">
    <div class="header-content">
        <div class="vanner">
            <img alt="main" src="${pageContext.request.contextPath}/img/van.jpg" style="width:750px; height: 280px;">
        </div>
        <div class="mylogin-form">
            <sec:authorize access="isAuthenticated()">
                <img src="https://blogpfthumb-phinf.pstatic.net/MjAyNDA3MTZfMjAg/MDAxNzIxMTE1NzY3MjY4.ueDvccl7mHx7z0DVBHHqagXj2aoAhIi1uSYaQrufjS4g.1xT_9Yxv4LolXwixUFJ-SEK-Y0z39lD3qbv2YsZbhS4g.JPEG/%EC%96%B4%EB%9E%98%EA%B3%A4.jpeg/%25EC%2596%25B4%25EB%259E%2598%25EA%25B3%25A4.jpeg?type=w161" alt="프로필 이미지"/>
                <div class="nick">
                    <strong class="itemfont col" id="nickNameArea">현재 접속 아이디</strong> <br>
                    <span class="itemfont col">
                    <a id="blogDomainChange" onclick="return false;" class="set_domain_btn">
                    <span class="blog_domain col"> <sec:authentication property="principal.username"/> </span>
                    <span class ="set_domain_iconcol"></span>
                    </a>
                </span>
                </div>
                <div>
                    <button><a href="">회원정보수정</a><br></button>
                    <form action="<c:url value='/logout' />" method="post">
                        <button type="submit">로그아웃</button>
                    </form>
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
                                        <input type="text" id="member_id" name="member_id" placeholder="아이디 입력">
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

<jsp:include page="../footer.jsp" />
