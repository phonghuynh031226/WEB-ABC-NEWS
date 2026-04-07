<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng nhập - ABC News</title>

<style>
/* ========== Tổng thể trang ========== */
body {
    font-family: "Segoe UI", Arial, sans-serif;
    background: linear-gradient(135deg, #f1c40f, #2c3e50);
    height: 100vh;
    margin: 0;
    display: flex;
    flex-direction: column;
}

/* ========== Container đăng nhập ========== */
.login-container {
    width: 400px;
    margin: auto;
    background-color: #fff;
    padding: 40px 30px;
    border-radius: 15px;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
    text-align: center;
    animation: fadeIn 0.6s ease;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(-15px); }
    to { opacity: 1; transform: translateY(0); }
}

/* ========== Tiêu đề ========== */
.login-container h2 {
    margin-bottom: 25px;
    color: #2c3e50;
    letter-spacing: 1px;
}

/* ========== Input ========== */
.login-container input[type="text"],
.login-container input[type="password"] {
    width: 90%;
    padding: 12px;
    margin: 10px 0;
    border: 1px solid #ccc;
    border-radius: 8px;
    outline: none;
    font-size: 14px;
    transition: all 0.3s;
}

.login-container input:focus {
    border-color: #f1c40f;
    box-shadow: 0 0 5px rgba(241, 196, 15, 0.6);
}

/* ========== Nút đăng nhập thường ========== */
.login-container button {
    width: 95%;
    background-color: #2c3e50;
    color: white;
    border: none;
    padding: 12px 0;
    margin-top: 15px;
    border-radius: 8px;
    font-size: 16px;
    cursor: pointer;
    transition: 0.3s;
}

.login-container button:hover {
    background-color: #f1c40f;
    color: #2c3e50;
}

/* ========== Nút Google ========== */
.google-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    width: 95%;
    background-color: white;
    border: 1px solid #ccc;
    color: #444;
    padding: 10px 0;
    border-radius: 8px;
    font-size: 15px;
    font-weight: 500;
    margin-top: 15px;
    cursor: pointer;
    transition: 0.3s;
}

.google-btn img {
    width: 20px;
    height: 20px;
}

.google-btn:hover {
    background-color: #f9f9f9;
    border-color: #aaa;
}

/* ========== Liên kết phụ ========== */
.login-container a {
    text-decoration: none;
    color: #2c3e50;
    font-weight: 500;
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

    <!-- Thông báo lỗi -->
    <c:if test="${not empty message}">
        <div class="error-message">${message}</div>
    </c:if>

    <!-- Form đăng nhập thường -->
    <form action="login" method="post">
        <input type="text" name="username" placeholder="Tên đăng nhập" required><br>
        <input type="password" name="password" placeholder="Mật khẩu" required><br>
        <button type="submit">Đăng nhập</button>
    </form>

    <!-- hoặc -->
    <p style="margin: 10px 0; color: #999;">— Hoặc —</p>

<!-- Nút đăng nhập Google -->
<div class="google-btn" id="customGoogleBtn">
    <img src="https://developers.google.com/identity/images/g-logo.png" alt="Google logo">
    <span>Đăng nhập với Google</span>
</div>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    const btn = document.getElementById("customGoogleBtn");
    btn.addEventListener("click", function () {
      // ✅ Khi nhấn sẽ chuyển hướng sang servlet login-google
      window.location.href = "http://localhost:8080/ASM_JAVA3_SOF203/login-google";
    });
  });
</script>



    <p style="margin-top: 15px;">Quên mật khẩu? <a href="#">Khôi phục</a></p>
</div>

<jsp:include page="layout/footer.jsp" />

</body>
</html>
