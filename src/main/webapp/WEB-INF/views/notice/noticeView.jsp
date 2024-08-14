<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>글내용 보기</title>
   <link rel="stylesheet" type="text/css" href="/css/notice/noticeListStyle.css">
    <link rel="stylesheet" type="text/css" href="/css/notice/noticeViewStyle.css">
</head>
<body>
<jsp:include page="../header.jsp"/>
<div class="notice">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<div class="slideshow-container">
                <div class="slides fade">
                    <img src="../img/fast.jpg" width="100%" height="280">
                </div>
                <div class="slides fade">
                    <img src="../img/adult.jpg" width="100%" height="280">
                </div>
                <div class="slides fade">
                    <img src="../img/smart.jpg" width="100%" height="280">
                </div>
                <div class="slides fade">
                    <img src="../img/year.jpg" width="100%" height="280">
                </div>
                <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
                <a class="next" onclick="plusSlides(1)">&#10095;</a>
            </div>
    <h2>글내용 보기</h2>
    <table>
        <tr>
            <th>글번호</th>
            <td>${getNotice.id}</td>
            <th>조회수</th>
            <td>${getNotice.views}</td>
        </tr>
        <tr>
            <th>작성자</th>
            <td>${getNotice.author}</td>
            <th>작성일</th>
            <td>${getNotice.createtime}</td>
        </tr>
        <tr>
            <th>글제목</th>
            <td colspan="3">${getNotice.subject}</td>
        </tr>
        <tr>
            <td colspan="90">
                <div class="textarea-container">
                    <textarea readonly>${getNotice.content}</textarea>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="4" style="text-align: right;">
                <input type="button" value="글수정" onclick="window.location='/notice/noticeEdit.do?id=${getNotice.id}'">
                <input type="button" value="글삭제" onclick="window.location='/notice/noticeDelete.do?id=${getNotice.id}'">
                <input type="button" value="글목록" onclick="window.location='/notice/noticeList.do'">
            </td>
        </tr>
    </table>
</div>
<jsp:include page="../footer.jsp"/>
</body>
</html>
