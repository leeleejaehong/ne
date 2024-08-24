<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<link rel="stylesheet" type="text/css" href="/css/notice/notice.css">
<link rel="stylesheet" type="text/css" href="/css/notice/noticeListStyle.css">

<!DOCTYPE html>
<jsp:include page="../header.jsp"/>
<main>
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
            
    <form name="f" action="/notice/noticeInsert.do" method="post" onsubmit="return check()">
        <input type="hidden" name="id" value="${getNotice.id}" />
        <h2>공지사항 작성</h2>
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
 			<td><textarea name="content" rows="30" cols="50" class="box"></textarea></td>            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="글쓰기">
                    <input type="button" value="목록보기" onclick="window.location='/notice/noticeList.do'">
                </td>
            </tr>
        </table>
    </form>
</div>
</main>
<jsp:include page="../footer.jsp"/>








