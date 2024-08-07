<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/css/commu/commuContent.css">
	<jsp:include page="../header.jsp"/>
	<script> 
        
        
        function checkLogin() {
                alert("로그인이 필요합니다.");
                window.location.href = "/index.do";
            
        }
        
        function checkUpdateId(username){
        	
        	  if (username === '${getCommu.author}') {
                  window.location.href = "/commu/commuUpdate.do?id=${getCommu.id}";
              } else {
                  alert("본인만 글만 수정 가능합니다.");
              }

        }
        
        function checkDeleteId(username) {
        	if (username === '${getCommu.author}' || username === 'admin') {
                if (confirm("정말로 삭제하시겠습니까?")) {
                    window.location.href = "/commu/commuDelete.do?id=${getCommu.id}";
                }
            } else {
                alert("본인만 글을 삭제할 수 있습니다.");
            }
        }
    </script>
	
    <div class="container1">
        <h2>글내용 보기</h2>
        <table>
            <tr>
                <th>글번호</th>
                <td>${getCommu.id}</td>
                <th>조회수</th>
                <td>${getCommu.views}</td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>${getCommu.author}</td>
                <th>작성일</th>
                <td>${getCommu.createtime}</td>
            </tr>
            <tr>
                <th>글제목</th>
                <td colspan="3">${getCommu.subject}</td>
            </tr>
            <tr>
                <th>글내용</th>
                <td colspan="3">${getCommu.content}</td>
            </tr>
            <tr>
                <td colspan="4" style="text-align: right;">
                <sec:authorize access="isAuthenticated()">
                <sec:authentication property="principal.username" var="username" />
                    <input type="button" value="답글달기" onclick="window.location='/commu/commuWrite.do?id=${getCommu.id}'">
                    <input type="button" value="글수정" onclick="checkUpdateId('${username}')">
                    <input type="button" value="글삭제" onclick="checkDeleteId('${username}')">
                </sec:authorize>
                <sec:authorize access="isAnonymous()">
                	<input type="button" value="답글달기" onclick="checkLogin()">
                	<input type="button" value="글수정" onclick="checkLogin()">
                 	<input type="button" value="글삭제" onclick="checkLogin()">
                </sec:authorize>
                    <input type="button" value="글목록" onclick="window.location='/commu/commuList.do'">
                </td>
            </tr>
        </table>
    </div>
    <jsp:include page="../footer.jsp"/>


