<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<link rel="stylesheet" type="text/css" href="/css/notice/notice.css">
<link rel="stylesheet" type="text/css" href="/css/notice/noticeListStyle.css">

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

  
    <form name="f" action="/notice/noticeEdit.do" method="post" onsubmit="return checkForm()">
        <input type="hidden" name="id" value="${getNotice.id}"/>
        <h2>글 수 정</h2>
     <table border="1">
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
                <td><textarea name="content" rows="30" class="box">${getNotice.content}</textarea></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: left;">
                   
                        <input type="submit" value="글 수정">
                        <input type="button" value="목록 보기" onclick="window.location='/notice/noticeList.do'">
                    
                </td>
            </tr>
        </table>
    </form>
</div>

<jsp:include page="../footer.jsp"/>
