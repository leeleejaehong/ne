<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/css/qna/qnaContent.css">
<link rel="stylesheet" type="text/css" href="/css/qna/qnaStyle.css">
<jsp:include page="../header.jsp"/>
<script> 
function checkLogin() {
                alert("로그인이 필요합니다.");
                window.location.href = "/index.do";
            
        }
        
function checkWriteId(username){
	
	  if (username === 'admin') {
        window.location.href = "/qna/qnaWrite.do?id=${getQna.id}";
    } else {
        alert("관리자만 답글을 작성할 수 있습니다.");
    }

}
        
        function checkUpdateId(username){
        	
        	  if (username === '${getQna.author}') {
                  window.location.href = "/qna/qnaUpdate.do?id=${getQna.id}";
              } else {
                  alert("본인만 글만 수정 가능합니다.");
              }

        }
        
        function checkDeleteId(username) {
        	if (username === '${getQna.author}' || username === 'admin') {
                if (confirm("정말로 삭제하시겠습니까?")) {
                    window.location.href = "/qna/qnaDelete.do?id=${getQna.id}";
                }
            } else {
                alert("본인만 글을 삭제할 수 있습니다.");
            }
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
		<h2>글내용 보기</h2>
        <table>
            <tr>
                <th>글번호</th>
                <td>${getQna.id}</td>
                <th>조회수</th>
                <td>${getQna.views}</td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>${getQna.author}</td>
                <th>작성일</th>
                <td>${getQna.createtime}</td>
            </tr>
            <tr>
                <th>글제목</th>
                <td colspan="3">${getQna.subject}</td>
            </tr>
            <tr>
                <th>글내용</th>
                <td colspan="3">${getQna.content}</td>
            </tr>
            <tr>
                <td colspan="4" style="text-align: right;">
                 <sec:authorize access="isAuthenticated()">
                  <sec:authentication property="principal.username" var="username" />
					<input type="button" value="답글달기" onclick="checkWriteId('${username}')">
                    <input type="button" value="글수정" onclick="checkUpdateId('${username}')">
                    <input type="button" value="글삭제" onclick="checkDeleteId('${username}')">
					</sec:authorize>
				<sec:authorize access="isAnonymous()">
                	<input type="button" value="답글달기" onclick="checkLogin()">
                	<input type="button" value="글수정" onclick="checkLogin()">
                 	<input type="button" value="글삭제" onclick="checkLogin()">
                </sec:authorize>
                    <input type="button" value="글목록" onclick="window.location='/qna/qnaList.do'">
			</td>
		</tr>
	</table>
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






