<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../header.jsp"/>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>회원관리</title>

<form id="searchForm" onsubmit="return false;">
    <select id="searchType" name="searchType">
        <option value="all">전체보기</option>
        <option value="id">Id</option>
        <option value="nickname">닉네임</option>
    </select>
    <input type="text" id="searchKeyword" name="searchKeyword" placeholder="Id 혹은 닉네임을 입력하세요">
    <button type="button" onclick="doSearch(1)">검색</button>
</form>

<div id="resultSearch">
    <!-- 검색 결과가 여기에 표시됩니다. -->
</div>
<div id="pagination">
    <!-- 페이지 네비게이션이 여기에 표시됩니다. -->
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    var currentPage = 1;
    var pageSize = 5;

    function doSearch(page) {
        currentPage = page;
        var searchType = $('#searchType').val();
        var searchKeyword = $('#searchKeyword').val();
        var csrfToken = $("meta[name='_csrf']").attr("content");
        var csrfHeader = $("meta[name='_csrf_header']").attr("content");

        $.ajax({
            url: '/admin/searchMember.do',
            method: 'POST',
            data: {
                searchType: searchType,
                searchKeyword: searchKeyword,
                page: currentPage,
                size: pageSize,
                _csrf: csrfToken
            },
            dataType: 'json',
            beforeSend: function(xhr) {
                if (csrfHeader && csrfToken) {
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                } else {
                    console.error("CSRF header or token is missing");
                }
            },
            success: function(response) {
                var members = response.members;
                var totalPages = response.totalPages;
                var resultHtml = '';
		
                if (members.length === 0) {
                    resultHtml = '회원이 존재하지 않습니다.';
                } else {
                    $.each(members, function(index, member) {
                        resultHtml += '<div>';
                        resultHtml += 'ID: ' + member.memberID + '<br>';
                        resultHtml += '이름: ' + member.name + '<br>';
                        resultHtml += '전화번호: ' + member.phone + '<br>';
                        resultHtml += '닉네임: ' + member.nickname + '<br>';
                        resultHtml += '이메일: ' + member.email + '<br>';
                        resultHtml += '<button type ="button"  onclick="doUpdate(\'' + member.memberID + '\')">수정</button>';
                        resultHtml += '<hr>';
                        resultHtml += '</div>';
                    });
                }
            	
                $('#resultSearch').html(resultHtml);
                updatePagination(totalPages);
            },
            error: function(xhr, status, error) {
                console.log("검색 중 오류 발생:", error);
            }
        });
    }
    function updatePagination(totalPages) {
        var paginationHtml = '';

        paginationHtml += '<button onclick="doSearch(1)"' + (currentPage === 1 ? ' disabled' : '') + '>처음</button>';
        paginationHtml += '<button onclick="doSearch(' + (currentPage - 1) + ')"' + (currentPage <= 1 ? ' disabled' : '') + '>이전</button>';
        // 페이지 버튼들
        if (totalPages <= 5) {
            for (var i = 1; i <= totalPages; i++) {
                paginationHtml += '<button onclick="doSearch(' + i + ')"' + (i === currentPage ? ' class="active"' : '') + '>' + i + '</button>';
            }
        } else {
         
            if (currentPage <= 3) {
                for (var i = 1; i <= 5; i++) {
                    paginationHtml += '<button onclick="doSearch(' + i + ')"' + (i === currentPage ? ' class="active"' : '') + '>' + i + '</button>';
                }
                paginationHtml += '<button disabled>...</button>';
                paginationHtml += '<button onclick="doSearch(' + totalPages + ')">' + totalPages + '</button>';
            }
         
            else if (currentPage >= totalPages - 2) {
                paginationHtml += '<button onclick="doSearch(1)">1</button>';
                paginationHtml += '<button disabled>...</button>';
                for (var i = totalPages - 4; i <= totalPages; i++) {
                    paginationHtml += '<button onclick="doSearch(' + i + ')"' + (i === currentPage ? ' class="active"' : '') + '>' + i + '</button>';
                }
            }
            else {
                paginationHtml += '<button onclick="doSearch(1)">1</button>';
                paginationHtml += '<button disabled>...</button>';
                for (var i = currentPage - 2; i <= currentPage + 2; i++) {
                    if (i > 0 && i <= totalPages) {
                        paginationHtml += '<button onclick="doSearch(' + i + ')"' + (i === currentPage ? ' class="active"' : '') + '>' + i + '</button>';
                    }
                }
                paginationHtml += '<button disabled>...</button>';
                paginationHtml += '<button onclick="doSearch(' + totalPages + ')">' + totalPages + '</button>';
            }
        }

        paginationHtml += '<button onclick="doSearch(' + (currentPage + 1) + ')"' + (currentPage >= totalPages ? ' disabled' : '') + '>다음</button>';
        paginationHtml += '<button onclick="doSearch(' + totalPages + ')"' + (currentPage >= totalPages ? ' disabled' : '') + '>마지막</button>';

        $('#pagination').html(paginationHtml);
    }
</script>
<jsp:include page="../footer.jsp"/>