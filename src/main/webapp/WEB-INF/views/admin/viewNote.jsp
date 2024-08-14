<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../header.jsp"/>  
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메모 보기</title>
    <style>
        .note-content {
            white-space: pre-wrap; 
        }
    </style>
</head>
<body>
    <h1>메모 내용: ${fileName}</h1>
    <div class="note-content">
        <form action="/admin/updateNote.do" method="post">
            <textarea name="note" rows="10">${content}</textarea>
            <input type="hidden" name="fileName" value="${fileName}">
            <button type="submit">수정</button>
        </form>
    </div>
    <form action="/admin/deleteNote.do" method="post">
        <input type="hidden" name="fileName" value="${fileName}">
        <button type="submit">삭제</button>
    </form>
    <a href="/admin/calTest.do">계산기로 돌아가기</a>
</body>
<jsp:include page="../footer.jsp"/>
</html>