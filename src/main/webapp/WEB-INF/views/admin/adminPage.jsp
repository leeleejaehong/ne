<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="../header.jsp"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
       
        .admin-container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        .admin-header {
            background-color: #2c3e50;
            color: #ecf0f1;
            padding: 20px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
        }

        .admin-menu {
            display: flex;
            background-color: #34495e;
           
            position: relative;
        }

        .menu-item {
            position: relative;
            flex: 1;
            /* Make sure menu items have equal width and alignment */
            display: flex;
            flex-direction: column;
        }

        .menu-item > .menu-link {
            display: block;
            padding: 15px;
            color: #ecf0f1;
            text-align: center;
            text-decoration: none;
            font-weight: bold;
            cursor: default; /* Make sure cursor is not a pointer */
            background-color: #34495e;
        }

       

        .submenu {
            display: block; /* Always show the submenu */
            background-color: #2c3e50;
            border-top: 1px solid white;
        }

        .submenu a {
            display: block;
            padding: 10px;
            color: #ecf0f1;
            text-align: left;
            text-decoration: none;
        }

        .submenu a:hover {
            background-color: #1abc9c;
        }

        .admin-content {
            padding: 20px;
            text-align: center;
        }

        .admin-content img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <main>
        <div class="admin-container">
            <div class="admin-header">
                관리자 페이지
            </div>
            <div class="admin-menu">
                <div class="menu-item">
                    <div class="menu-link">회원관리</div>
                    <div class="submenu">
                        <a href="${pageContext.request.contextPath}/admin/adminMember.do">회원관리</a>
                        <a href="">회원 추가</a>
                    </div>
                </div>
                <div class="menu-item">
                    <div class="menu-link">상품관리</div>
                    <div class="submenu">
                        <a href="${pageContext.request.contextPath}/admin/updateProd.do">상품 목록</a>
 						<a href="${pageContext.request.contextPath}/admin/adminProdcut.do" class="add-product">상품 추가</a>                    </div>
                </div>
                <div class="menu-item">
                    <div class="menu-link">매출관리</div>
                    <div class="submenu">
                        <a href="${pageContext.request.contextPath}/admin/adminChart.do"">매출관리</a>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <jsp:include page="../footer.jsp"/>
</body>
</html>
