<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<link rel="stylesheet" type="text/css" href="/css/notice/noticeInsert.css">

<!DOCTYPE html>
<jsp:include page="../header.jsp"/>
<div class="container1">
    <form name="f" action="/notice/noticeInsert.do" method="post" onsubmit="return check()">
        <input type="hidden" name="id" value="${getNotice.id}" />
        <h2>글 쓰 기</h2>
        <table border="1">
            <tr>
                <th>제 목</th>
                <td><input type="text" name="title" class="box" size="50"></td>
            </tr>
            <tr>
                <th>아이디</th>
                <td><input type="text" name="author" class="box"></td>
            </tr>
            <tr>
                <th>내 용</th>
                <td><textarea name="content" rows="11" cols="50" class="box"></textarea></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="글쓰기">
                    <input type="reset" value="다시작성">
                    <input type="button" value="목록보기" onclick="window.location='/notice/noticeList.do'">
                </td>
            </tr>
        </table>
    </form>

</div>
<jsp:include page="../footer.jsp"/>








