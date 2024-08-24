<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="../header.jsp"/>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>회원관리</title>

<style>
    
    #searchForm {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
        gap: 10px;
    }
    #searchType, #searchKeyword {
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
    }
    #searchKeyword {
        flex-grow: 1;
    }
    button {
        padding: 8px 16px;
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 14px;
         margin-right: 10px; /* 버튼들 사이의 간격을 조절합니다 */
    }
    button:hover {
        background-color: #0056b3;
    }
    button:disabled {
        background-color: #ccc;
        cursor: not-allowed;
    }
    #resultSearch {
        background-color: #fff;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    }
    #resultSearch > div {
        margin-bottom: 20px;
    }
    hr {
        border: 0;
        height: 1px;
        background-color: #eee;
        margin: 20px 0;
    }
    #pagination {
        display: flex;
        justify-content: center;
        margin-top: 20px;
    }
    #pagination button {
        margin: 0 5px;
        padding: 8px 12px;
        border-radius: 4px;
        background-color: #007bff;
        color: white;
        border: none;
        cursor: pointer;
    }
    #pagination button.active {
        background-color: #0056b3;
    }
    #pagination button:disabled {
        background-color: #ccc;
        cursor: not-allowed;
    }
</style>
<main>
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
</main>
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
                        resultHtml += '<strong>ID:</strong> ' + member.memberID + '<br>';
                        resultHtml += '<strong>이름:</strong> ' + member.name + '<br>';
                        resultHtml += '<strong>전화번호:</strong> ' + member.phone + '<br>';
                        resultHtml += '<strong>닉네임:</strong> ' + member.nickname + '<br>';
                        resultHtml += '<strong>이메일:</strong> ' + member.email + '<br>';
                        resultHtml += '<button type="button" onclick="doUpdate(\'' + member.memberID + '\')">회원수정</button>';
                        resultHtml += '<button type="button" onclick="doDelete(\'' + member.memberID + '\')">회원삭제</button>';
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
            } else if (currentPage >= totalPages - 2) {
                paginationHtml += '<button onclick="doSearch(1)">1</button>';
                paginationHtml += '<button disabled>...</button>';
                for (var i = totalPages - 4; i <= totalPages; i++) {
                    paginationHtml += '<button onclick="doSearch(' + i + ')"' + (i === currentPage ? ' class="active"' : '') + '>' + i + '</button>';
                }
            } else {
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

    function doUpdate(memberID) {
        var updateUrl = '/admin/updateMemberForm.do?memberID=' + encodeURIComponent(memberID);
        window.location.href = updateUrl;
    }
    
    function doDelete(memberID) {
        var deleteUrl = '/admin/deleteMember.do?memberID=' + encodeURIComponent(memberID);
        window.location.href = deleteUrl;
    }
</script>

<jsp:include page="../footer.jsp"/>
