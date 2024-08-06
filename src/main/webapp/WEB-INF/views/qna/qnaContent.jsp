<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link rel="stylesheet" type="text/css" href="/css/qna/qnaContent.css">
<!-- content.jsp -->
<!DOCTYPE html>
<jsp:include page="../header.jsp"/>
<div class="container1">
	<b>글내용 보기</b>
	<table border="1" width="100%">
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
				<input type="button" value="답글달기" onclick="window.location='/qna/qnaWrite.do?id=${getQna.id}'">
                    <input type="button" value="글수정" onclick="window.location='/qna/qnaUpdate.do?id=${getQna.id}'">
                    <input type="button" value="글삭제" onclick="window.location='/qna/qnaDelete.do?id=${getQna.id}'">
                    <input type="button" value="글목록" onclick="window.location='/qna/qnaList.do'">
			</td>
		</tr>
	</table>
</div>


<jsp:include page="../footer.jsp"/>






