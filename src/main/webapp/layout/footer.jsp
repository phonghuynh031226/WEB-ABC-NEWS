<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : 'vi'}"/>
<fmt:setBundle basename="languages.global"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Footer</title>
<style>
  footer {
      background-color: #2c3e50;
      color: white;
      text-align: center;
      padding: 20px 0;
      margin-top: auto; /* ✅ đẩy footer xuống cuối nếu dùng flex layout */
      width: 100%;
  }
  footer p { 
      margin: 5px 0;
  }
  .newsletter {
      margin-bottom: 10px;
  }
  .newsletter input[type="email"] {
      padding: 8px;
      width: 220px;
      border: none;
      border-radius: 3px;
  }
  .newsletter button {
      padding: 8px 12px;
      border: none;
      border-radius: 3px;
      background-color: #f1c40f;
      color: #2c3e50;
      font-weight: bold;
      cursor: pointer;
  }
  .newsletter button:hover {
      background-color: #d4ac0d;
  }

  /* ✅ Khi trang ngắn, cố định footer ở cuối màn hình */
  html, body {
      height: 100%;
      display: flex;
      flex-direction: column;
  }

  /* Phần nội dung chính chiếm không gian còn lại */
  main {
      flex: 1;
  }

  /* Hiển thị thông báo */
  .alert {
      background-color: #27ae60;
      padding: 10px;
      margin-top: 10px;
      border-radius: 4px;
      color: white;
      display: inline-block;
  }

  select {
      margin-top: 10px;
      padding: 5px;
      border-radius: 3px;
      border: none;
  }
</style>
</head>
<body>

<footer>
  <div class="newsletter">
    <form action="${pageContext.request.contextPath}/newsletter" method="post">
      <label for="email">Đăng ký nhận bản tin:</label>
      <input type="email" name="email" id="email" placeholder="Nhập email của bạn" required>
      <button type="submit">Đăng ký</button>
    </form>
  </div>

  <p>© 2025 ABC News. All rights reserved.</p>

  <!-- Hiển thị thông báo (nếu có) -->
  <c:if test="${not empty sessionScope.newsMessage}">
    <div class="alert">${sessionScope.newsMessage}</div>
    <%
      session.removeAttribute("newsMessage");
    %>
  </c:if>

  <!-- Ngôn ngữ -->
  <select onchange="location.href=this.value;">
    <option value="?lang=vi" ${sessionScope.lang == 'vi' ? 'selected' : ''}>Tiếng Việt</option>
    <option value="?lang=en" ${sessionScope.lang == 'en' ? 'selected' : ''}>English</option>
  </select>
</footer>

</body>
</html>
