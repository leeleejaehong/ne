<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../header.jsp"/>  
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<title>adminChart</title>

 <a href="/admin/calTest.do">계산기</a> <br>
    <form id="productForm">
        <label for="productSelect">Select Product:</label>
        <select id="productSelect" name="product_code">
            <c:forEach var="dto" items="${nList}">
                <option value="${dto.product_code}">
                   ${dto.product_code}번상품 : ${dto.start_date} ~ ${dto.end_date} / ${dto.subscription_period}
                </option>
            </c:forEach>
        </select>
        <button type="button" id="submitButton">Submit</button>
    </form>
    <canvas id="myChart" width="400" height="200"></canvas>
	<div>
	1개월 기본금리: 3개월 기본금리: 6개월 기본금리: 1년 기본금리:<br>
	1개월 골든볼금리: 3개월 골든볼금리: 6개월 골든볼금리: 1년 골든볼금리:
	</div>
	
    <script>
        $(document).ready(function() {
            $('#submitButton').click(function() {
                const productCode = $('#productSelect').val();
               /*  var csrfToken = $("meta[name='_csrf']").attr("content");
                var csrfHeader = $("meta[name='_csrf_header']").attr("content");   */
                $.ajax({
                    url: '/admin/chartajax.do',
                    method: 'POST',
                    data: { 
                        product_code: productCode,
                        /* _csrf: csrfToken */
                    },
                   /*  beforeSend: function(xhr) {
                        xhr.setRequestHeader(csrfHeader, csrfToken);
                    }, */
                    success: function(response) {
                        const data = JSON.parse(response);
                        updateChart(data);
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.error('Error:', textStatus, errorThrown);
                    }
                });
            });
        });

        function updateChart(data) {
            const ctx = document.getElementById('myChart').getContext('2d');
            
           
            if (window.myChart && window.myChart.destroy) {
                window.myChart.destroy();
            }

            const labels = data.map(item => item.product_code);
            const accumulatedAmounts = data.map(item => parseFloat(item.accumulated_amount));
            const numberOfSubscribers = data.map(item => parseInt(item.number_of_subscribers));

            window.myChart = new Chart(ctx, {
                type: 'bar', 
                data: {
                    labels: labels, 
                    datasets: [
                        {
                            label: '누적 금액',
                            data: accumulatedAmounts, 
                            backgroundColor: 'rgba(75, 192, 192, 0.2)',
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: 1,
                            yAxisID: 'y1'
                        },
                        {
                            label: '가입 인원',
                            data: numberOfSubscribers, 
                            backgroundColor: 'rgba(153, 102, 255, 0.2)',
                            borderColor: 'rgba(153, 102, 255, 1)',
                            borderWidth: 1,
                            yAxisID: 'y2'
                        }
                    ]
                },
                options: {
                    scales: {
                        x: {
                            title: {
                                display: true,
                                text: '상품 코드' 
                            }
                        },
                        y1: {
                            type: 'linear',
                            display: true,
                            position: 'left',
                            title: {
                                display: true,
                                text: '누적 금액(원)' 
                            }
                        },
                        y2: {
                            type: 'linear',
                            display: true,
                            position: 'right',
                            title: {
                                display: true,
                                text: '가입 인원(명)' 
                            },
                            grid: {
                                drawOnChartArea: false 
                            }
                        }
                    }
                }
            });
        }
        
        
        
    </script>
</body>
<jsp:include page="../footer.jsp"/>
