<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../header.jsp"/>  
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>계산기</title>
    <style>
        form {
            margin: 20px;
        }
        .calculator {
            display: grid;
            grid-template-columns: repeat(4, 50px);
            gap: 5px;
        }
        .calculator button {
            width: 50px;
            height: 50px;
            font-size: 18px;
        }
        #display {
            width: 215px;
            height: 50px;
            font-size: 18px;
            text-align: right;
            margin-bottom: 5px;
        }
        #result {
            margin-top: 10px;
            font-size: 18px;
        }
        .note-section {
            margin-top: 20px;
        }
        .note-section textarea {
            width: 100%;
            height: 100px;
        }
        .note-section button {
            margin-top: 10px;
        }
        .note-list a {
            display: block;
            margin: 5px 0;
            color: blue;
            text-decoration: underline;
        }
        /* Flexbox layout for calculator and note sections */
        .container-note-cal {
            display: flex;
            justify-content: space-between;
        }
        .calculator-container, .note-container {
            width: 48%;
        }
    </style>
</head>
<body>
    <h1>계산기</h1>
    <div class="container-note-cal">
        <!-- Calculator Section -->
        <div class="calculator-container">
            <form action="/admin/calculator.do" method="POST">
                <input type="text" id="display" name="display" value="${display}" readonly>
                <input type="hidden" name="operation" id="operation" value="${operation}">
                <input type="hidden" name="result" id="resultValue" value="${result}">
                <div class="calculator">
                    <button type="button" onclick="appendNumber('7')">7</button>
                    <button type="button" onclick="appendNumber('8')">8</button>
                    <button type="button" onclick="appendNumber('9')">9</button>
                    <button type="button" onclick="setOperation('/')">/</button>
                    <button type="button" onclick="appendNumber('4')">4</button>
                    <button type="button" onclick="appendNumber('5')">5</button>
                    <button type="button" onclick="appendNumber('6')">6</button>
                    <button type="button" onclick="setOperation('*')">*</button>
                    <button type="button" onclick="appendNumber('1')">1</button>
                    <button type="button" onclick="appendNumber('2')">2</button>
                    <button type="button" onclick="appendNumber('3')">3</button>
                    <button type="button" onclick="setOperation('-')">-</button>
                    <button type="button" onclick="appendNumber('0')">0</button>
                    <button type="button" onclick="appendNumber('.')">.</button>
                    <button type="submit">계산</button>
                    <button type="button" onclick="clearDisplay()">C</button>
                    <button type="button" onclick="setOperation('+')">+</button>
                </div>
            </form>

            <div id="result">
                <c:if test="${not empty result}">
                    결과: ${result}
                </c:if>
            </div>
            <div>
                <p>이자율 예시(기본/골든볼 값따라만들기 바로사용할수있게 a태그): <br>
                   예시(1개월): <a href="#" onclick="appendInterestRate(1.3)">1.3%</a><br>
                   예시(3개월): <a href="#" onclick="appendInterestRate(2.5)">2.5%</a><br>
                   예시(6개월): <a href="#" onclick="appendInterestRate(3.7)">3.7%</a><br>
                </p>
            </div>
        </div>

        <!-- Note Section -->
        <div class="note-container">
            <div class="note-section">
                <h2>메모 작성</h2>
                <form action="/admin/saveNote.do" method="POST">
                    <textarea name="note" placeholder="여기에 메모를 작성하세요..."></textarea>
                    <button type="submit">저장</button>
                </form>
            </div>

            <div class="note-section">
    <h2>저장된 메모</h2>
    <div class="note-list">
    
        <c:forEach var="file" items="${files}">
        <table>
        <tr>
            <td> <a href="/admin/viewNote.do?fileName=${file.name}">
                <c:out value="${file.name}"/></td>
            </a>
            <form action="/admin/deleteNote.do" method="POST" style="display:inline;">
              
               <input type="hidden" name="fileName" value="${file.name}">
                <td><button type="submit">삭제</button></td>
                </tr>
              
            </form>
            </table>
        </c:forEach>
    </div>
</div>
        </div>
    </div>
    <script>
        function appendNumber(number) {
            const display = document.getElementById('display');
            display.value += number;
        }

        function setOperation(operation) {
            const display = document.getElementById('display');
            const existingValue = display.value;
            if (existingValue && !['+', '-', '*', '/'].includes(existingValue.slice(-1))) {
                display.value += ' ' + operation + ' ';
            }
        }

        function clearDisplay() {
            document.getElementById('display').value = '';
        }

        function appendInterestRate(rate) {
            const display = document.getElementById('display');
            if (display.value) {
                display.value += ' ' + rate + ' ';
            } else {
                display.value = rate;
            }
        }
    </script>
</body>
<jsp:include page="../footer.jsp"/>