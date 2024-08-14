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

    function updateFill(currentAmount, goalAmount, fillId, labelId) {
        var percentage = (currentAmount / goalAmount) * 100;
        // 퍼센트가 100을 초과하지 않도록 제한
        percentage = Math.min(percentage, 100);
        var boxFill = document.getElementById(fillId);
        boxFill.style.transform = 'translateY(' + (100 - percentage) + '%)';
    }

    // 페이지 로드 시 초기값 설정
    window.onload = function() {
       checkAdVisibility();
        // 슬라이드 쇼 초기화
        showSlides(slideIndex);
        autoShowSlides();

        
        // 퍼센트 채우기 초기화
        var initialValues = [
            { amount: 150000, goal: 1000000, fillId: 'box-fill-0', labelId: 'box-label-1' },
            { amount: 700000, goal: 1000000, fillId: 'box-fill-1', labelId: 'box-label-2' },
            { amount: 500000, goal: 1000000, fillId: 'box-fill-2', labelId: 'box-label-3' },
            { amount: 1000000, goal: 1000000, fillId: 'box-fill-3', labelId: 'box-label-4' }
        ];

        initialValues.forEach(function(item) {
            updateFill(item.amount, item.goal, item.fillId, item.labelId);
        });
        
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
</script>
</head>
<body>
<header>
        <div class="container">
         <img alt ="main"
            src="${pageContext.request.contextPath}/img/logo.jpg"
            style="width: 70px; height: 60px; vertical-alignt: bottom">
            <h1><a href="/index.do">neoheulge</a></h1>
            <div class="scrolling-text-container">
            <div class="scrolling-text">상품1의 당첨자 xxx님,상품2의 당첨자 xxx님</div>
        </div>
            <nav>
                <a href="${pageContext.request.contextPath}/commu/commuList.do">커뮤니티</a>
                <a href="${pageContext.request.contextPath}/notice/noticeList.do">공지사항</a>
                <a href="${pageContext.request.contextPath}/product/productList.do">상품 목록</a>
                <a href="${pageContext.request.contextPath}/qna/qnaList.do">고객지원</a>
                <a href="${pageContext.request.contextPath}/admin/adminPage.do">관리자 페이지</a>
            </nav>
        </div>
    </header>
    <div class="page-wrapper">
    <div class="ad-left">
    <button class="close-btn" onclick="closeAd('ad-left')">X</button>
    <a href="https://pokemongolive.com/ko" target="_blank">
        <img src="${pageContext.request.contextPath}/img/poket1.jpg" alt="Left Advertisement" width="250" height="700" class="ad-image">
    </a>
    <div class="ad-blocked">30분 동안 광고 차단</div>
</div>
    <div class="main-content">
