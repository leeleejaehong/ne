<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>글내용 보기</title>
    <link rel="stylesheet" type="text/css" href="/css/commu/commuContent.css">
</head>
<body>
    <jsp:include page="../header.jsp"/>
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
                    <input type="button" value="답글달기" onclick="window.location='/commu/commuWrite.do?id=${getCommu.id}'">
                    <input type="button" value="글수정" onclick="window.location='/commu/commuUpdate.do?id=${getCommu.id}'">
                    <input type="button" value="글삭제" onclick="window.location='/commu/commuDelete.do?id=${getCommu.id}'">
                    <input type="button" value="글목록" onclick="window.location='/commu/commuList.do'">
                </td>
            </tr>
        </table>
    </div>
    <jsp:include page="../footer.jsp"/>
</body>
</html>
