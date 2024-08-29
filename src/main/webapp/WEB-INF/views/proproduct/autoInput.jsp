<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자동결제 설정</title>
    <style>
        :root {
            --primary-color: #3f51b5;
            --secondary-color: #303f9f;
            --text-color: #333;
            --background-color: #f5f5f5;
            --input-height: 50px;
            --spacing: 20px;
        }
        body {
            font-family: 'Roboto', 'Noto Sans KR', sans-serif;
            background-color: var(--background-color);
            margin: 0;
            padding: var(--spacing);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 3px 6px rgba(0,0,0,0.1);
            padding: calc(var(--spacing) * 2);
            width: 100%;
            max-width: 400px;
        }
        h1 {
            color: var(--primary-color);
            font-size: 24px;
            margin-bottom: calc(var(--spacing) * 1.5);
            text-align: center;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        .input-group {
            margin-bottom: var(--spacing);
            position: relative;
        }
        label {
            color: var(--text-color);
            font-size: 14px;
            position: absolute;
            top: -10px;
            left: 10px;
            background-color: white;
            padding: 0 5px;
        }
        input, select {
            width: 100%;
            height: var(--input-height);
            padding: 0 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            transition: border-color 0.3s;
            box-sizing: border-box;
        }
        input:focus, select:focus {
            outline: none;
            border-color: var(--primary-color);
        }
        button {
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 4px;
            height: var(--input-height);
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: var(--secondary-color);
        }
        .toggle-switch {
            position: relative;
            display: inline-block;
            width: 60px;
            height: 34px;
        }
        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }
        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 34px;
        }
        .slider:before {
            position: absolute;
            content: "";
            height: 26px;
            width: 26px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }
        input:checked + .slider {
            background-color: var(--primary-color);
        }
        input:checked + .slider:before {
            transform: translateX(26px);
        }
        .summary {
            margin-top: var(--spacing);
            padding: var(--spacing);
            background-color: #e8eaf6;
            border-radius: 4px;
        }
        #errorMsg {
            color: red;
            font-size: 14px;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>자동결제 설정</h1>
        <form action="/proProduct/auto.do" method="post">
         <input type="hidden" name="product_code" value="${product}">
            <div class="input-group">
                <label for="amount">자동결제 금액</label>
                <input type="number" id="amount" name="amount" required min="1000" step="1000">
            </div>
            <div class="input-group">
                <label for="cycle">자동결제 주기</label>
                <select id="cycle" name="cycle" required>
                    <option value="매일">매일</option>
                    <option value="매주">매주</option>
                    <option value="매월">매월</option>
                </select>
            </div>
            <div class="input-group">
                <label for="account">자동결제 계좌</label>
                <input type="text" id="account" name="account" required>
            </div>
            <div class="input-group">
                <label for="start-date">자동결제 시작일</label>
                <input type="date" id="start_date" name="start_date" required>
            </div>

            <div id="errorMsg"></div>
            <button type="submit">설정 완료</button>
        </form>
    </div>
    <script>
        document.getElementById('start_date').addEventListener('change', function() {
            const date = new Date(this.value);
            const dayOfMonth = date.getDate();
            document.getElementById('day-of-month').textContent = `선택한 날짜의 일: ${dayOfMonth}`;
        });
    </script>

</body>
</html>