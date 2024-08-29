<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!DOCTYPE html>
<jsp:include page="../header.jsp" />
<link rel="stylesheet" type="text/css" href="/css/member/MypageStyle.css">
<script>
    function openPopup(url) {
        window.open(url, "popupWindow", "width=600,height=400,scrollbars=yes");
    }
    
    function changeMainAccount(accountId) {
        if (confirm("주 계좌를 바꾸시겠습니까?")) {
            // AJAX 요청을 통해 서버에 주 계좌 변경 요청
            fetch('/acount/changeMainAccount.do', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ accountId: accountId })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert("주 계좌가 변경되었습니다.");
                    location.reload(); // 페이지 새로고침
                } else {
                    alert("주 계좌 변경에 실패했습니다.");
                }
            })
            .catch((error) => {
                console.error('Error:', error);
                alert("오류가 발생했습니다.");
            });
        }
    }

    function confirmDelete(event) {
        event.stopPropagation(); 
        return confirm("계좌정보를 삭제하시겠습니까?");
    }
</script>


<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <main>
    <div class="myPage">
        <div class="header-content">
            <div class="vanner">
                <img alt="main" src="${pageContext.request.contextPath}/img/van.jpg" style="width:898px; height: 280px;">
            </div>
            <div class="login-form">
                <sec:authorize access="isAuthenticated()">
<div class="logview">
    <div class="profile-container">
        <table class="profile-table">
            <tr>
                <td width="50%" class="profile-image-cell">
                    <img src="${pageContext.request.contextPath}/img/${profile.profile}" alt="프로필 이미지" class="profile-img"/>
                </td>
                <td class="profile-info-cell">
                    <div class="profile-info">
                        <strong class="itemfont col" id="nickNameArea">
                            환영합니다<br>
                            <sec:authentication property="principal.username"/>님
                        </strong>
                        <br>
                        <div class="links">
                            <a href="${pageContext.request.contextPath}/member/myPage.do?user=<sec:authentication property="principal.username"/>" class="link-btn">마이페이지</a>
                            <a href="/member/editMemberForm.do?memberID=<sec:authentication property='principal.username'/>" class="link-btn">내 정보 수정</a>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <form action="<c:url value='/logout' />" method="post" class="logout-form">
            <button type="submit" class="logout-btn">로그아웃</button>
        </form>
    </div>
</div>
</sec:authorize>
                <sec:authorize access="isAnonymous()">
                    <h4>neoheulge <br> 더 안전하고 더 편리하게</h4>
                    <form action="<c:url value='/login' />" method="post">
                        <input type="text" name="username" placeholder="사용자 이름" required>
                        <input type="password" name="password" placeholder="비밀번호" required>
                        <button type="submit">로그인</button>
                    </form>
                    <div class="links">
                        <a href="/find-id">아이디 찾기</a> |
                        <a href="/find-password">비밀번호 찾기</a> |
                        <a href="${pageContext.request.contextPath}/member/signup.do">회원가입</a>
                    </div>
                </sec:authorize>
            </div>
        </div>
        <div class="container1">
 <div class="Account">
    <div class="Account-header">
        <span class="material-icons"></span> 계좌 정보
    </div>
    <br>
    <div class="Account-body">
        <c:choose>
            <c:when test="${empty acount}">
                <p>등록된 계좌가 없습니다.</p>
            </c:when>
            <c:otherwise>
                <div class="products">
                    <c:forEach items="${acount}" var="ac">
                        <div class="acount-card ${ac.acount_status eq 'Y' ? 'primary-account' : ''}">
                            <div class="card-content" onclick="changeMainAccount(${ac.acount_id})">
                                <c:if test="${ac.acount_status eq 'Y'}">
                                    <span class="badge">주 계좌</span>
                                    <i class="fas fa-star primary-icon"></i>
                                </c:if>
                                <p><strong>계좌 번호:</strong> ${ac.acount_number}</p>
                                <p><strong>현재 잔액:</strong> ${ac.money}원</p>
                            </div>
                            <div class="account-actions">
								<form action="/payment.do" method="post" id="paymentForm">
								  <input type="hidden" name="acount_id" value="${ac.acount_id}" />
								  <button type="submit" class="btn btn-primary">충전하기</button>
								</form>                            	
                                <form action="/acount/deleteNeacount.do" method="post" style="display:inline;" onsubmit="return confirmDelete(event)">
                                    <input type="hidden" name="acount_id" value="${ac.acount_id}" />
                                    <button type="submit" class="btn btn-danger">계좌삭제</button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
            </c:otherwise>
        </c:choose>
    </div>
            
    <c:choose>
	    <c:when test="${empty acount}">
			<button type="button" class="btn btn-primary" onclick="openPopup('/acount/add.do?member=<sec:authentication property="principal.username"/>')">계좌 추가하기</button>
	    </c:when>
    	<c:when test="${not empty acount}">
            <button type="button" class="btn btn-primary" onclick="window.location.href='/acount/insertNeacountform.do'">계좌 추가하기</button>
    	</c:when>
    </c:choose>

</div>
        </div>
        <br>
        <div class = "container1">
            <div class="subscription">
                <div class="subscription-header">
                    <span class="material-icons">가입한 상품</span>
                </div>
                <div class="subscription-body">
                    <div class="products">
                        <c:forEach items="${getByMemberId}" var="product">
                            <c:if test="${product.STATUS == '활성'}">
                                <div class="product-card">
                                    <div class="product-image">💰</div>
                                    <div class="product-info">
                                        <h3>${product.PRODUCT_NAME}</h3>
                                        <p><strong>가입일:</strong>
                                            <fmt:formatDate value="${product.SUBSCRIPTION_DATE}" pattern="yyyy-MM-dd"/>
                                        </p>
                                        <p><strong>상태:</strong>
                                                ${product.STATUS}
                                        </p>
                                        <p><strong>가입 금액:</strong>
                                                ${product.SUBSCRIPTION_AMOUNT}
                                        </p>
                                        <p><strong>주기:</strong>
                                                ${product.AUTO_CYCLE}
                                        </p>
                                        <p><strong>자동 결제 금액:</strong>
                                                ${product.AUTO_AMOUNT}
                                        </p>

                                        <div class="product-actions">
	                                        <form action="<c:url value='/proProduct/autoInput.do' />" method="post">
	                                            <input type="hidden" name="product_code" value="${product.PRODUCT_CODE}">
	                                        	<button type="submit" class="btn btn-primary">자동 결제 설정</button>
	                                        </form>
                                            <form action="<c:url value='/proProduct/cancel' />" method="post">
                                                <sec:authentication var="username" property="principal.username"/>
                                                <input type="hidden" name="user" value="${username}"/>
                                                <input type="hidden" name="product_code" value="${product.PRODUCT_CODE}">
                                                <button type="submit" class="btn btn-secondary">해지하기</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <br>
            <div class="container1">
                <div class="cancellation">
                        <div class="cancellation-header">
                            <span class="material-icons">해지한 상품</span>
                        </div>
                    <div class="cancellation-body">
                        <div class="products">
                            <c:forEach items="${getByMemberId}" var="product">
                   
                                <c:if test="${product.STATUS == '해지'}">
                                    <div class="product-card">
                                        <div class="product-info">
                                            <h3>${product.PRODUCT_NAME}</h3>
                                            <p><strong>해지일:</strong>
                                                <fmt:formatDate value="${product.TERMINATION_DATE}" pattern="yyyy-MM-dd"/>
                                            </p>
                                            <p><strong>상태:</strong>
                                                    ${product.STATUS}
                                            </p>
                                            <div class="product-actions">
                                                <form action="${pageContext.request.contextPath}/proProduct/deleteProProduct.do?subscription_id=${product.SUBSCRIPTION_ID}" method="POST">
                                                    <button type="submit" class="btn btn-secondary">삭제하기</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <br>
                <div class="expiration">
                    <div class="expiration-header">
                        <span class="material-icons">만기 상품</span>
                    </div>

                    <div class="expiration-body">
                        <div class="products">
                            <c:forEach items="${getByMemberId}" var="product">
                                <c:if test="${product.STATUS == '만기'}">
                                    <div class="product-card">
                                        <div class="product-info">
                                            <h3>${product.PRODUCT_NAME}</h3>
                                            <p><strong>만기일:</strong>
                                                <fmt:formatDate value="${product.TERMINATION_DATE}" pattern="yyyy-MM-dd"/>
                                            </p>
                                            <p><strong>상태:</strong>
                                                    ${product.STATUS}
                                            </p>
                                            <div class="product-actions">
                                                <form action="" method="post">
                                                    <button type="submit" class="btn btn-secondary">삭제하기</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </div>
             </div>
    </div>
</main>
<button type="button" class="btn btn-primary" onclick="openModal()">충전하기</button>

<!-- 모달 구조 -->
<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close1" onclick="closeModal()">&times;</span>
        <div id="modal-body">
            <!-- Ajax로 로드된 콘텐츠가 여기 들어갑니다 -->
            
        </div>
    </div>
</div>
<style>
/* 모달 배경 */
.modal {
    display: none; /* 기본적으로 숨김 상태 */
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0, 0, 0, 0.5); /* 회색 배경 */
}

/* 모달 콘텐츠 */
.modal-content {
    background-color: #fff; /* 하얀색 배경 */
    margin: 15% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%; /* 너비 조정 */
    max-width: 600px; /* 최대 너비 설정 */
}

/* 닫기 버튼 */
.close1 {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close1:hover,
.close1:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}
</style>

<script>
// 모달 열기
function openModal() {
    document.getElementById("myModal").style.display = "block";
    
    // Ajax로 콘텐츠 불러오기
    $.ajax({
        url: "/payment.do",  // URL을 /payment.jsp로 변경
        type: "GET",
        success: function(data) {
            // 데이터를 모달에 삽입
            $("#modal-body").html(data);
        },
        error: function(xhr, status, error) {
            console.log("Error: " + error);
            $("#modal-body").html("<p>콘텐츠를 불러오는 중 오류가 발생했습니다.</p>");
        }
    }); 
}

// 모달 닫기
function closeModal() {
    document.getElementById("myModal").style.display = "none";
    $("#modal-body").html(''); // 모달 닫을 때 내용 비우기
}

// 모달 배경 클릭 시 모달 닫기
window.onclick = function(event) {
    if (event.target == document.getElementById("myModal")) {
        closeModal();
    }
}
</script>


<jsp:include page="../footer.jsp" />