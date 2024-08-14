<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="/css/qna/qnaWrite.css">
<link rel="stylesheet" type="text/css" href="/css/qna/qnaStyle.css">
<!DOCTYPE html>
<jsp:include page="../header.jsp"/>
<div class="qna">
    <div class="header-content">
        <div class="vanner">
            <img alt="main" src="${pageContext.request.contextPath}/img/van.jpg" style="width:750px; height: 280px;">
        </div>
        <div class="login-form">
            <sec:authorize access="isAuthenticated()">
                <img src="https://blogpfthumb-phinf.pstatic.net/MjAyNDA3MTZfMjAg/MDAxNzIxMTE1NzY3MjY4.ueDvccl7mHx7z0DVBHHqagXj2aoAhIi1uSYaQrufjS4g.1xT_9Yxv4LolXwixUFJ-SEK-Y0z39lD3qbv2YsZbhS4g.JPEG/%EC%96%B4%EB%9E%98%EA%B3%A4.jpeg/%25EC%2596%25B4%25EB%259E%2598%25EA%25B3%25A4.jpeg?type=w161"
                     alt="프로필 이미지"/>
                <div class="nick">
                    <strong class="itemfont col" id="nickNameArea">현재 접속 아이디</strong> <br>
                    <span class="itemfont col">
                        <a id="blogDomainChange" onclick="return false;" class="set_domain_btn">
                        <span class="blog_domain col"> <sec:authentication property="principal.username"/> </span>
                        <span class ="set_domain_iconcol"></span>
                        </a>
                    </span>
                </div>
                <form action="<c:url value='/logout' />" method="post">
                    <button type="submit">로그아웃</button>
                </form>
            </sec:authorize>
            <sec:authorize access="isAnonymous()">
                <h1>neoheulge</h1>
                <h4>더 안전하고 더 편리하게 </h4>
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
</div>
<div class="center-align">
    <h3 class="form-title">글 수정</h3>
</div>
<form name="f" action="/qna/qnaUpdate.do" method="post" onsubmit="return checkForm()">
    <input type="hidden" name="id" value="${getQna.id}"/>
    <table class="form-table">
        <tr>
            <th>제목</th>
            <td><input type="text" name="subject" class="box" size="50" value="${getQna.subject}"></td>
        </tr>
        <tr>
            <th>이름</th>
            <td><input type="text" name="author" class="box" value="${getQna.author}" readonly></td>
        </tr>
        <tr>
            <th>내용</th>
            <td><textarea name="content" rows="30" class="box">${getQna.content}</textarea></td>
        </tr>
        <tr>
            <td colspan="2" class="center-align">
                <div class="btn-group">
                    <input type="submit" value="글 수정">
                    <input type="reset" value="다시 작성">
                    <input type="button" value="목록 보기" onclick="window.location='/qna/qnaList.do'">
                </div>
            </td>
        </tr>
    </table>
</form>
<div class="commu-container">
    <div class="community-content">
        <div class="community-posts">
            <div>
                <h3>공지글</h3>
                <c:forEach var="dto" items="${noticeList}" varStatus="status">
                    <c:if test="${status.index < 5}">
                        <p>
                            <a href="/notice/noticeView.do?id=${dto.id}">
                                    ${dto.subject}
                            </a>
                        </p>
                    </c:if>
                </c:forEach>
            </div>
        </div>
        <div class="community-posts">
            <div>
                <h3>커뮤니티</h3>
                <c:forEach var="dto" items="${commuList}" varStatus="status">
                    <c:if test="${status.index < 5}">
                        <p>
                            <a href="/commu/commuContent.do?id=${dto.id}">
                                    ${dto.subject}
                            </a>
                        </p>
                    </c:if>
                </c:forEach>
            </div>
        </div>
        <div class="community-prizes">
            <h3>전회차 상금</h3>
            <p>상품1 100,000원</p>
            <p>상품2 145,000원</p>
            <p>상품3 609,000원</p>
            <p>상품4 1,681,500원</p>
        </div>
    </div>
</div>


<script type="text/javascript">
    function checkForm() {
        if (document.f.subject.value.trim() === "") {
            alert("제목을 입력해 주세요!!");
            document.f.subject.focus();
            return false;
        }
        if (document.f.content.value.trim() === "") {
            alert("내용을 입력해 주세요!!");
            document.f.content.focus();
            return false;
        }
        return true;
    }
</script>


<jsp:include page="../footer.jsp"/>
   