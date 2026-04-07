<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý loại tin - ABC News</title>

<style>
    .container {
        width: 60%;
        margin: 20px auto;
        background: white;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 0 5px rgba(0,0,0,0.2);
    }

    h2 {
        color: #2c3e50;
        border-bottom: 2px solid #2c3e50;
        padding-bottom: 8px;
        margin-bottom: 15px;
    }

    form input[type="text"] {
        width: 100%;
        padding: 10px;
        margin: 8px 0;
        border: 1px solid #ccc;
        border-radius: 4px;
    }

    form button {
        padding: 8px 15px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin-right: 5px;
        color: white;
        font-weight: bold;
    }

    .btn-add { background-color: #27ae60; }
    .btn-update { background-color: #2980b9; }
    .btn-delete { background-color: #c0392b; }
    .btn-clear { background-color: #7f8c8d; }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    th, td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: left;
    }

    th {
        background-color: #2c3e50;
        color: white;
    }

    tr:nth-child(even) {
        background-color: #f2f2f2;
    }
</style>
</head>
<body>

<!-- Include layout -->
<jsp:include page="layout/header.jsp" />
<jsp:include page="layout/menu.jsp" />

<div class="container">
    <h2>Quản lý loại tin</h2>

    <!-- Form nhập loại tin -->
    <form action="${pageContext.request.contextPath}/admin/category" method="post">
        <label>Mã loại tin:</label>
        <input type="text" name="id" placeholder="Nhập mã loại tin" required>

        <label>Tên loại tin:</label>
        <input type="text" name="name" placeholder="Nhập tên loại tin" required>

        <div style="margin-top: 10px;">
            <button class="btn-add" type="submit">Lưu</button>
            <button class="btn-clear" type="reset">Mới</button>
        </div>
    </form>

    <!-- Thông báo -->
    <c:if test="${not empty message}">
        <div style="background: #d1f7d1; padding: 10px; border-radius: 5px; margin-bottom: 15px;">
            ${message}
        </div>
    </c:if>

    <!-- Bảng danh sách loại tin -->
    <table>
        <thead>
            <tr>
                <th>Mã loại</th>
                <th>Tên loại tin</th>
                <th>Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="c" items="${list}">
                <tr>
                    <td>${c.id}</td>
                    <td>${c.name}</td>
                    <td>
                        <a href="category?action=delete&id=${c.id}" 
                           onclick="return confirm('Xóa loại tin này?')">🗑️ Xóa</a>
                    </td>
                </tr>
            </c:forEach>

            <c:if test="${empty list}">
                <tr><td colspan="3" style="text-align:center;">Chưa có loại tin nào.</td></tr>
            </c:if>
        </tbody>
    </table>
</div>

<jsp:include page="layout/footer.jsp" />

</body>
</html>
