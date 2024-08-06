<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/commu/commuWrite.css">
    
<!-- writeForm.jsp -->
<!DOCTYPE html>
<jsp:include page="../header.jsp"/>
<script type="text/javascript">
	function check(){
		if (f.author.value==""){
			alert("이름을 입력해 주세요!!")
			f.author.focus()
			return false
		}
		if (f.subject.value==""){
			alert("제목을 입력해 주세요!!")
			f.subject.focus()
			return false
		}
		if (f.content.value==""){
			alert("내용을 입력해 주세요!!") 
			f.content.focus()
			return false
		}
		return true
	}
</script>
<div class="container1">
    <form name="f" action="/commu/commuWrite.do" method="post" onsubmit="return check()">
        <input type="hidden" name="id" value="${getCommu.id}" />
        <input type="hidden" name="re_step" value="${getCommu.re_step}" />
        <input type="hidden" name="re_level" value="${getCommu.re_level}" />
        <h2>글 쓰 기</h2>
        <table border="1">
            <tr>
                <th>제 목</th>
                <td><input type="text" name="subject" class="box" size="50"></td>
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
                    <input type="button" value="목록보기" onclick="window.location='/commu/commuList.do'">
                </td>
            </tr>
        </table>
    </form>
    
</div>
<jsp:include page="../footer.jsp"/>








