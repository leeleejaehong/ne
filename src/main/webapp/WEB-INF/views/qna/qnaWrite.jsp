<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <link rel="stylesheet" type="text/css" href="/css/qna/qnaWrite.css">
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> 
<link rel="stylesheet" type="text/css" href="/css/qna/qnaStyle.css">
<!-- writeForm.jsp -->
<!DOCTYPE html>
<jsp:include page="../header.jsp"/>
<script type="text/javascript">
	function check(){
		if (f.author.value==""){
			alert("이름을 입력해 주세요!!")
			f.author.focus()
			return false
		}
		if (f.subject.value==""){
			alert("제목을 입력해 주세요!!")
			f.subject.focus()
			return false
		}
		if (f.content.value==""){
			alert("내용을 입력해 주세요!!") 
			f.content.focus()
			return false
		}
		return true
	}
</script>
<div class="qna">
<div class="header-content">
        <div class="login-form">
            <sec:authorize access="isAuthenticated()">
                <h2>로그아웃</h2>
                <sec:authentication property="principal.Username"/>
                <form action="<c:url value='/logout' />" method="post">
                    <button type="submit">로그아웃</button>
                </form>
            </sec:authorize>
            <sec:authorize access="isAnonymous()">
                <h2>로그인</h2>
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
        <div class="vanner">
            <img alt="main" src="${pageContext.request.contextPath}/img/van.jpg" style="width:750px; height: 280px;">
        </div>
    </div>


    <form name="f" action="/qna/qnaWrite.do" method="post" onsubmit="return check()">
        <input type="hidden" name="id" value="${getQna.id}" />
        <input type="hidden" name="re_step" value="${getQna.re_step}" />
        <input type="hidden" name="re_level" value="${getQna.re_level}" />
        <h2>글 쓰 기</h2>
        <table border="1">
            <tr>
                <th>제 목</th>
                <td><input type="text" name="subject" class="box" size="50"></td>
            </tr>
            <tr>
                <th>아이디</th>
                <td><input type="text" name="author" class="box" value="<sec:authentication property='principal.username'/>" readonly ></td>
            </tr>
            <tr>
                <th>내 용</th>
                <td><textarea name="content" rows="11" cols="50" class="box"></textarea></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="글쓰기">
                    <input type="reset" value="다시작성">
                    <input type="button" value="목록보기" onclick="window.location='/qna/qnaList.do'">
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
 </div>

<jsp:include page="../footer.jsp"/>








