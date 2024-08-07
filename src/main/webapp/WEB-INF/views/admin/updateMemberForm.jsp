<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../header.jsp"/>

<h2 align="center">회원정보수정</h2>
<div align="center">

<form name="f" action="/admin/updateMemberPro.do" method="POST" enctype="multipart/form-data">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<table>
	<tr>
		<td><label for="grade">Grade :</label>
			<input type="text" name="grade" id ="grade" value="${member.grade}"></td>
	</tr>
	<tr>
		<td><label for="memberID">MemberID :</label>
			<input type="text" name="memberID" id = "memberID" value="${member.memberID}"readonly="readonly"></td>
	</tr>
	<tr>
		<td><label for="name">Name : </label>
			<input type="text" name="name" id ="name" value="${member.name}"></td>
	</tr>
	<tr>
		<td><label for="profile">Profile : </label>
		
		  <img src="${pageContext.request.contextPath}/img/${member.profile}" alt="Profile Picture" id="currentProfilePic"/>
          <input type="file" name="file" id="profile" /></td>
    </tr>
    <tr>
    	<td><label for ="NickName">NickName:</label>     
    		<input type="text" name="nickname" id="nickname" value="${member.nickname}"></td>
    </tr>    
	<tr>
		<td><label for = "email">E-Mail :</label>
		<input type="text" name="email" id="email" value="${member.email}"></td>
	</tr>
	<tr>
		<td><label for="phone">Phone : </label>
		<input type="text" name="phone" id="phone" value="${member.phone}"></td>
	</tr>
	<tr>
	<td>
		<label for ="signup_date">SignUp_Date :</label><fmt:formatDate value="${member.signup_date}" pattern="yyyy-MM-dd" var="signup_date" />
  		  ${signup_date}</td>
	</tr>
	<tr>
		<td align="center"><input type="submit" value="UPDATE"></td>
	</tr>
</table>
</form>
</div>

<jsp:include page="../footer.jsp"/>

