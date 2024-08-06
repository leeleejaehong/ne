<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" type="text/css" href="/css/commu/commuStyle.css">
<script> 
        function performSearch() {
            var searchType = document.getElementById("searchType").value;
            var searchTerm = document.getElementById("search").value.trim();

            if (searchTerm !== "") {
                var currentURL = window.location.href.split('?')[0];
                var queryString = "?searchType=" + searchType + "&search=" + encodeURIComponent(searchTerm);
                window.location.href = currentURL + queryString;
            }else if(searchTerm === ""){
                var currentURL = window.location.href.split('?')[0];
                window.location.href =currentURL;
            }
        }
    </script>
<div class="commu">
        <h2>커뮤니티</h2>
        <br>
        <div class="search-form">
              <select id="searchType">
            <option value="all" <c:if test="${searchType == 'all'}">selected</c:if>>전체</option>
            <option value="subject" <c:if test="${searchType == 'subject'}">selected</c:if>>제목</option>
            <option value="author" <c:if test="${searchType == 'author'}">selected</c:if>>작성자</option>
        </select>
        <input type="text" placeholder="검색어를 입력하세요" id="search" value="${search}">
        <button onclick="performSearch()">검색</button>
        </div>
        <div id="commu">
            <table align="right">
                <tr>
                  <td>
                   <a href="/commu/commuWrite.do" class="write-btn">글쓰기</a>
                  </td>
                </tr>
            </table>
            <table class="commu-table">
                <thead>
                <tr class="commu-header">
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>조회수</th> 
                </tr>
                </thead>
                <tbody>
                <c:if test="${empty commuList}">
                    <tr>
                        <td colspan="4" class="no-data">등록된 게시글이 없습니다.</td>
                    </tr>
                </c:if>
                <c:forEach var="dto" items="${commuList}">
                    <tr class="commu-row">
                        <td align="center">${dto.id}</td>
                        <td align="left">
                            <a href="/commu/commuContent.do?id=${dto.id}" class="commu-link">${dto.subject}</a>
                        </td>
                        <td align="center">${dto.author}</td>
                        <td align="center">${dto.createtime}</td>
                        <td align="right">${dto.views}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <c:if test="${not empty commuList}">
                <div class="pagination">
                       
                    <%
                        int pageSize = 5;
                        int currentPage = (request.getParameter("pageNum") != null) ? Integer.parseInt(request.getParameter("pageNum")) : 1;
                        int count = (Integer) request.getAttribute("count");
                        int pageBlock = 5;
                        int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
                        int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
                        int endPage = startPage + pageBlock - 1;
                        if (endPage > pageCount) endPage = pageCount;
                    %>
                       
                    <% if (startPage > pageBlock) { %>
                    <a href="/commu/commuList.do?pageNum=<%=startPage-pageBlock%>">&laquo; 이전</a>
                    <% } %>

                      
                    <% for (int i = startPage; i <= endPage; ++i) { %>
                    <a href="/commu/commuList.do?pageNum=<%=i%>" class="<%= (i == currentPage) ? "active" : "" %>"><%=i%></a>
                    <% } %>

                      
                    <% if (endPage < pageCount) { %>
                    <a href="/commu/commuList.do?pageNum=<%=startPage+pageBlock%>">다음 &raquo;</a>
                    <% } %>
                </div>
            </c:if>
        </div>
    </div>
<jsp:include page="../footer.jsp"/>
