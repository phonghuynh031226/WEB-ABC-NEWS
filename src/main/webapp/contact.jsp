<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Liên hệ - ABC News</title>
<style>
    .container {
        width: 80%;
        margin: 30px auto;
        background: white;
        padding: 25px;
        border-radius: 8px;
        box-shadow: 0 0 6px rgba(0,0,0,0.2);
    }
    .abc {
        border-bottom: 2px solid #2c3e50;
        padding-bottom: 8px;
        color: #2c3e50;
    }
    .aaa {
        display: flex;
        flex-direction: column;
        gap: 12px;
    }
    input, textarea {
        padding: 10px;
        border-radius: 5px;
        border: 1px solid #ccc;
        font-size: 14px;
        width: 100%;
    }
    button {
        background: #2c3e50;
        color: white;
        border: none;
        padding: 10px;
        border-radius: 5px;
        cursor: pointer;
        font-weight: bold;
    }
    button:hover {
        background: #f1c40f;
        color: #2c3e50;
    }
</style>
</head>
<body>

<jsp:include page="layout/header.jsp" />
<jsp:include page="layout/menu.jsp" />

<div class="container">
    <h2 class="abc">Liên hệ với chúng tôi</h2>
    <form class="aaa">
        <label>Họ tên:</label>
        <input type="text" placeholder="Nhập họ tên của bạn">

        <label>Email:</label>
        <input type="email" placeholder="Nhập email của bạn">

        <label>Nội dung:</label>
        <textarea rows="5" placeholder="Nhập lời nhắn..."></textarea>

        <button type="submit">Gửi liên hệ</button>
    </form>
</div>

<jsp:include page="layout/footer.jsp" />
</body>
</html>
