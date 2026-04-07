<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng nhập - ABC News</title>

<style>
    .login-container {
        width: 400px;
        margin: 60px auto;
        background-color: white;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0,0,0,0.2);
        text-align: center;
    }

    .login-container h2 {
        margin-bottom: 20px;
        color: #2c3e50;
    }

    .login-container input[type="text"],
    .login-container input[type="password"] {
        width: 90%;
        padding: 10px;
        margin: 8px 0;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    .login-container button {
        background-color: #2c3e50;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
        transition: 0.3s;
    }

    .login-container button:hover {
        background-color: #f1c40f;
        color: #2c3e50;
    }

    .login-container a {
        text-decoration: none;
        color: #2c3e50;
    }

    .login-container a:hover {
        color: #f1c40f;
    }

    .error-message {
        color: red;
        margin-bottom: 10px;
        font-weight: bold;
    }
</style>
</head>
<body>

<!-- Include layout -->
<jsp:include page="layout/header.jsp" />
<jsp:include page="layout/menu.jsp" />

<div class="login-container">
    <h2>Đăng nhập hệ thống</h2>

    <!-- Hiển thị lỗi từ LoginServlet -->
    <c:if test="${not empty message}">
        <div class="error-message">${message}</div>
    </c:if>

    <!-- Gửi form đến LoginServlet -->
    <form action="login" method="post">
        <input type="text" name="username" placeholder="Tên đăng nhập" required><br>
        <input type="password" name="password" placeholder="Mật khẩu" required><br>
        <button type="submit">Đăng nhập</button>
    </form>

    <p style="margin-top: 15px;">Quên mật khẩu? <a href="#">Khôi phục</a></p>
</div>

<jsp:include page="layout/footer.jsp" />


</body>
</html>
