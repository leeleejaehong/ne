<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="_csrf" content="${_csrf.token}">
    <meta name="_csrf_header" content="${_csrf.headerName}">
    <title>적금 사이트</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mainStyle.css">
 <script>
    let slideIndex = 1;

    function showSlides(n) {
        let slides = document.getElementsByClassName("slides");
        if (n > slides.length) {slideIndex = 1}
        if (n < 1) {slideIndex = slides.length}
        for (let i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        slides[slideIndex-1].style.display = "block";
    }

    function plusSlides(n) {
        showSlides(slideIndex += n);
    }

    function autoShowSlides() {
        plusSlides(1);
        setTimeout(autoShowSlides, 5000); // Change image every 5 seconds
    }

    

    // 페이지 로드 시 초기값 설정
    window.onload = function() {
        loadWinners();
       checkAdVisibility();
        // 슬라이드 쇼 초기화
        showSlides(slideIndex);
        autoShowSlides();	
        
    };
    
    function closeAd(adClass) {
        var hideUntil = new Date().getTime() + (30 * 60 * 1000); // 30분 후
        localStorage.setItem('hideAdUntil_' + adClass, hideUntil);
        var adElement = document.querySelector('.' + adClass);
        adElement.querySelector('.ad-image').style.display = 'none';
        adElement.querySelector('.ad-blocked').style.display = 'block';
    }

    function checkAdVisibility() {
        var adElement = document.querySelector('.ad-left');
        var hideUntil = localStorage.getItem('hideAdUntil_ad-left');

        if (hideUntil && new Date().getTime() < hideUntil) {
            adElement.querySelector('.ad-image').style.display = 'none';
            adElement.querySelector('.ad-blocked').style.display = 'block';
        } else {
            adElement.querySelector('.ad-image').style.display = 'block';
            adElement.querySelector('.ad-blocked').style.display = 'none';
        }
        adElement.style.display = 'block';
    }
    
    function loadWinners() {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "${pageContext.request.contextPath}/product/winner.do", true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var response = JSON.parse(xhr.responseText);
                // 데이터를 localStorage에 저장
                localStorage.setItem('winnerList', JSON.stringify(response));
                // 현재 페이지에서 데이터를 사용하거나 다른 페이지로 이동할 수 있습니다.
               displayWinners(response);
            }
        };
        xhr.send();
    }
    function profile() {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "${pageContext.request.contextPath}/profile.do", true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var response = JSON.parse(xhr.responseText);
                // 데이터를 localStorage에 저장
                localStorage.setItem('profile', JSON.stringify(response));
                // 현재 페이지에서 데이터를 사용하거나 다른 페이지로 이동할 수 있습니다.
            }
        };
        xhr.send();
    }

    function displayWinners(winnerList) {
        var scrollingTextContainer = document.querySelector(".scrolling-text");
        scrollingTextContainer.innerHTML = ""; // 기존 내용을 비웁니다.

        winnerList.forEach(function(winner,index) {
            var winnerText = winner.product_name + "의 당첨자 " + winner.winner + "님";
         // 마지막 항목이 아니면 쉼표 추가
         if (index < winnerList.length - 1) {
            winnerText += ", ";
        }
            scrollingTextContainer.innerHTML += winnerText;
        });
    }
    
</script>
</head>
<body>
<header>
        <div class="container">
         <a href="/index.do"><img alt ="main"
            src="${pageContext.request.contextPath}/img/logo2.png"
            style="width: 80px; height: 60px; vertical-alignt: bottom"></a>
            <h1><a href="/index.do">neoheulge</a></h1>
            <div class="scrolling-text-container">
            <div class="scrolling-text"></div>
        </div>
            <nav>
                <a href="${pageContext.request.contextPath}/commu/commuList.do">커뮤니티</a>
                <a href="${pageContext.request.contextPath}/notice/noticeList.do">공지사항</a>
                <a href="${pageContext.request.contextPath}/product/productList.do">상품 목록</a>
                <a href="${pageContext.request.contextPath}/qna/qnaList.do">고객지원</a>
                <sec:authorize access="hasRole('ROLE_2')">
                	<a href="${pageContext.request.contextPath}/admin/adminPage.do">관리자 페이지</a>
        		</sec:authorize>
            </nav>
        </div>
    </header>
    <div class="page-wrapper">
    <div class="ad-left">
    <button class="close-btn" onclick="closeAd('ad-left')">X</button>
    <a href="https://m.shinhan.com/rib/mnew/index.jsp#220011110001" target="_blank">
        <img src="${pageContext.request.contextPath}/img/save.jpg" alt="Left Advertisement" width="250" height="700" class="ad-image">
    </a>
    <div class="ad-blocked">30분 동안 광고 차단</div>
</div>
    <div class="main-content">
