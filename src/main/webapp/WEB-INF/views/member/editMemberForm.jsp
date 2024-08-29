<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../header.jsp"/>
<style>
table {
    width: 50%;
    border-collapse: collapse;
    margin: 20px 0;
    font-size: 16px;
}
table td {
    padding: 10px;
}
table input[type="text"], table input[type="file"] {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 14px;
}
table img {
    max-width: 100px;
    max-height: 100px;
    margin-bottom: 10px;
}
table input[type="submit"], .delete-btn {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 10px 20px;
    font-size: 16px;
    border-radius: 4px;
    cursor: pointer;
    margin-right: 10px;
}
table input[type="submit"]:hover, .delete-btn:hover {
    background-color: #0056b3;
}
.delete-btn {
    background-color: #dc3545;
}
.delete-btn:hover {
    background-color: #c82333;
}
.button-group {
    display: flex;
    justify-content: center;
    align-items: center;
}
</style>
<h2 align="center">내 정보 수정</h2>
<div align="center">

<form name="f" action="/member/editMemberPro.do" method="POST" enctype="multipart/form-data">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<table>
    <tr>
        <td><label for="memberID">MemberID :</label>
        <input type="text" name="memberID" id="memberID" value="${member.memberID}" readonly="readonly"></td>
    </tr>
    <tr>
        <td><label for="name">Name : </label>
        <input type="text" name="name" id="name" value="${member.name}"></td>
    </tr>
    <tr>
        <td><label for="profile">Profile : </label>
        <img src="${pageContext.request.contextPath}/img/${member.profile}" alt="Profile Picture" id="currentProfilePic"/>
        <input type="file" name="file" id="profile" />
        <input type="hidden" id="previousImg" name="previousImg" value="${member.profile}">
        </td>
    </tr>
    <tr>
        <td><label for="nickname">NickName :</label>
        <input type="text" name="nickname" id="nickname" value="${member.nickname}"></td>
    </tr>
    <tr>
        <td><label for="email">E-Mail :</label>
        <input type="text" name="email" id="email" value="${member.email}"></td>
    </tr>
    <tr>
        <td><label for="phone">Phone :</label>
        <input type="text" name="phone" id="phone" value="${member.phone}"></td>
    </tr>
    <tr>
        <td><label for="signup_date">SignUp Date :</label>
        <fmt:formatDate value="${member.signup_date}" pattern="yyyy-MM-dd" var="signup_date" />
        ${signup_date}</td>
    </tr>
    <tr>
        <td align="center" class="button-group">
            <input type="submit" value="수정하기">
            <button type="button" class="delete-btn" onclick="confirmDelete()">탈퇴하기</button>
        </td>
    </tr>
</table>
</form>
</div>

<script type="text/javascript">
   function confirmDelete() {
	 var username = "${member.memberID}";
	 if (confirm("정말로 탈퇴하시겠습니까? 이 작업은 되돌릴 수 없습니다.")) {
        window.location.href = "/member/deleteMember.do?member_id="+ encodeURIComponent(username);
    }
}
</script>

<jsp:include page="../footer.jsp"/>
