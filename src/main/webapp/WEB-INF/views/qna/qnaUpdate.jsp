<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link rel="stylesheet" type="text/css" href="/css/qna/qnaWrite.css">
<!DOCTYPE html>
  <jsp:include page="../header.jsp"/> 
    </header>
    
    <div class="container1">
        <div class="center-align">
            <h3 class="form-title">글 수정</h3>
        </div>
        <form name="f" action="/qna/qnaUpdate.do" method="post" onsubmit="return checkForm()">
            <input type="hidden" name="id" value="${getQna.id}"/>    
            <table class="form-table">
                <tr>
                    <th>제목</th>
                    <td><input type="text" name="subject" class="box" size="50" value="${getQna.subject}"></td>
                </tr>
                <tr>
                    <th>이름</th>
                    <td><input type="text" name="author" class="box" value="${getQna.author}" readonly></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea name="content" rows="11" class="box">${getQna.content}</textarea></td>
                </tr>
                <tr>
                    <td colspan="2" class="center-align">
                        <div class="btn-group">
                            <input type="submit" value="글 수정">
                            <input type="reset" value="다시 작성">
                            <input type="button" value="목록 보기" onclick="window.location='/qna/qnaList.do'">
                        </div>
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <script type="text/javascript">
        function checkForm() {
            if (document.f.subject.value.trim() === "") {
                alert("제목을 입력해 주세요!!");
                document.f.subject.focus();
                return false;
            }
            if (document.f.content.value.trim() === "") {
                alert("내용을 입력해 주세요!!");
                document.f.content.focus();
                return false;
            }
            return true;
        }
    </script>
    
 
       <jsp:include page="../footer.jsp"/>
   