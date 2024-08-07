<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>공지 사항</title>
  <link rel="stylesheet" type="text/css" href="/css/notice/viewStyle.css">
  <script>
    document.addEventListener('DOMContentLoaded', (event) => {
    const checkbox = document.getElementById('dontShowAgain');
    const noticeId = '${getNotice.id}';

    // 체크박스 상태 로드
    const storedTime = localStorage.getItem(`dontShowNoticeTime_${noticeId}`);
    if (storedTime) {
      const currentTime = new Date().getTime();
      const storedTimestamp = parseInt(storedTime, 10);
      const oneDayInMilliseconds = 24 * 60 * 60 * 1000; // 24시간

      if (currentTime < storedTimestamp + oneDayInMilliseconds) {
        // 24시간 이내이면 팝업 표시하지 않기
        document.getElementById('popup').style.display = 'none';
      }
    }

    // 체크박스 상태 저장
    checkbox.addEventListener('change', () => {
      if (checkbox.checked) {
        const currentTime = new Date().getTime();
        localStorage.setItem(`dontShowNoticeTime_${noticeId}`, currentTime.toString());
        document.getElementById('popup').style.display = 'none'; // 팝업 숨기기
      } else {
        localStorage.removeItem(`dontShowNoticeTime_${noticeId}`);
      }
    });
  });

  function closePage() {
    window.close();
  }
  </script>
</head>
<body>
<div class="notice-container">
  <h1>공지사항</h1>
  <table class="notice-info">
    <tr>
      <th>작성자</th>
      <td>${getNotice.author}</td>
      <th>작성일</th>
      <td>${getNotice.createtime}</td>
    </tr>
    <tr>
      <th>글제목</th>
      <td colspan="3">${getNotice.subject}</td>
    </tr>
  </table>
  <div class="content-box">
    <h3>글내용</h3>
    <div class="notice-content">${getNotice.content}</div>
  </div>
  <div class="action-container">
    <button onclick="closePage()">닫기</button>
    <div class="checkbox-container">
      <input type="checkbox" id="dontShowAgain">
      <label for="dontShowAgain">24시간 동안 보지 않기</label>
    </div>
  </div>
</div>
</body>
</html>