<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <link rel="icon" href="https://static.toss.im/icons/png/4x/icon-toss-logo.png" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>토스페이먼츠 결제</title>
    <script src="https://js.tosspayments.com/v2/standard"></script>
	<link rel="stylesheet" type="text/css" href="/css/payment/payment.css">
</head>
<body>
    <button class="dark-mode-toggle" onclick="toggleDarkMode()">다크 모드</button>
    <div class="container">
        <h1>토스페이먼츠 결제</h1>
        <div class="input-group">
            <label for="amount">충전 금액</label>
            <input type="text" id="amount" placeholder="최소 충전 금액: 1,000원">
        </div>
        <div class="amount-buttons">
            <button class="amount-btn" onclick="setAmount(10000)">1만원</button>
            <button class="amount-btn" onclick="setAmount(30000)">3만원</button>
            <button class="amount-btn" onclick="setAmount(50000)">5만원</button>
            <button class="amount-btn" onclick="setAmount(100000)">10만원</button>
        </div>
        <div class="payment-methods">
            <div class="payment-method" id="CARD" onclick="selectPaymentMethod('CARD')">카드</div>
            <div class="payment-method" id="TRANSFER" onclick="selectPaymentMethod('TRANSFER')">계좌이체</div>
        </div>
        <div class="total-amount">총 결제 금액: <span id="total">0</span>원</div>
        <button class="submit-btn" onclick="requestPayment()">결제하기</button>
    </div>

    <script>
        const amount = { currency: "KRW", value: '' };
        let selectedPaymentMethod = null;

        function updateAmount(value) {
            const numericValue = parseInt(value.replace(/,/g, ''), 10);
            if (!isNaN(numericValue) && numericValue >= 1000) {
                amount.value = numericValue;
                document.getElementById('amount').classList.remove('error');
            } else {
                amount.value = 0;
                document.getElementById('amount').classList.add('error');
            }
            updateFeeAndTotal();
        }

        function setAmount(value) {
            document.getElementById('amount').value = value.toLocaleString();
            updateAmount(value.toString());
        }

        function selectPaymentMethod(method) {
            if (selectedPaymentMethod) {
                document.getElementById(selectedPaymentMethod).classList.remove('selected');
            }
            selectedPaymentMethod = method;
            document.getElementById(selectedPaymentMethod).classList.add('selected');
            updateFeeAndTotal();
        }

        function updateFeeAndTotal() {
            const total = amount.value;
            document.getElementById('total').textContent = total.toLocaleString();
        }

        document.getElementById('amount').addEventListener('input', function() {
            updateAmount(this.value);
        });

        const clientKey = "test_ck_6bJXmgo28e1pJj0EzE1A8LAnGKWx";
        const customerKey = generateRandomString();
        const tossPayments = TossPayments(clientKey);
        const payment = tossPayments.payment({ customerKey });

        async function requestPayment() {
            if (!selectedPaymentMethod || amount.value === 0) {
                alert('결제 방법을 선택하고 올바른 금액을 입력해주세요.');
                return;
            }

            try {
                const res = await fetch('/api/v1/payments/toss', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        payType: selectedPaymentMethod,
                        amount: Number(amount.value),
                        orderName: '입금',
                        yourSuccessUrl: `${window.location.origin}/payment-success`,
                        yourFailUrl: `${window.location.origin}/fail`,
                    })
                }).then(response => response.json());

                const paymentConfig = {
                    method: selectedPaymentMethod,
                    amount,
                    orderId: res.orderId,
                    orderName: "입금",
                    successUrl: window.location.origin + "/payment/success.html",
                    failUrl: window.location.origin + "/payment/fail.html",
                    customerEmail: res.customerEmail,
                    customerName: res.customerName,
                    customerMobilePhone: "01012341234",
                };

                if (selectedPaymentMethod === "CARD") {
                    paymentConfig.card = {
                        useEscrow: false,
                        flowMode: "DEFAULT",
                        useCardPoint: false,
                        useAppCardOnly: false,
                    };
                } else if (selectedPaymentMethod === "TRANSFER") {
                    paymentConfig.transfer = {
                        cashReceipt: { type: "소득공제" },
                        useEscrow: false,
                    };
                }

                await payment.requestPayment(paymentConfig);
            } catch (error) {
                console.error("Payment request failed:", error);
                alert('결제 요청 중 오류가 발생했습니다.');
            }
        }

        function generateRandomString() {
            return window.btoa(Math.random()).slice(0, 20);
        }

        function toggleDarkMode() {
            document.body.classList.toggle('dark-mode');
        }
    </script>
</body>
</html>