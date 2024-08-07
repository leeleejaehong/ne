<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<link rel="stylesheet" type="text/css" href="/css/notice/notice.css">
<!DOCTYPE html>
<jsp:include page="../header.jsp"/>
</header>

<div class="container1">
    <div class="center-align">
        <h3 class="form-title">글 수정</h3>
    </div>
    <form name="f" action="/notice/noticeEdit.do" method="post" onsubmit="return checkForm()">
        <input type="hidden" name="id" value="${getNotice.id}"/>
        <table class="form-table">
            <tr>
                <th>제 목</th>
                <td><input type="text" name="subject" class="box" size="50" value="${getNotice.subject}"></td>
            </tr>
<%--            value="${getNotice.subject}"--%>
            <tr>
                <th>이름</th>
                <td><input type="text" name="author" class="box" value="${getNotice.author}" readonly></td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea name="content" rows="11" class="box">${getNotice.content}</textarea></td>
            </tr>
            <tr>
                <td colspan="2" class="center-align">
                    <div class="btn-group">
                        <input type="submit" value="글 수정">
                        <input type="button" value="목록 보기" onclick="window.location='/notice/noticeList.do'">
                    </div>
                </td>
            </tr>
        </table>
    </form>
</div>
<jsp:include page="../footer.jsp"/>
