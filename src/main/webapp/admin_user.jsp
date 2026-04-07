<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý người dùng - ABC News</title>

<style>
    .container {
        width: 80%;
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

    form {
        margin-bottom: 30px;
    }

    form input[type="text"],
    form input[type="email"],
    form input[type="date"],
    form select {
        width: 100%;
        padding: 8px;
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
    .btn-clear { background-color: #7f8c8d; }

    table {
        width: 100%;
        border-collapse: collapse;
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

    .alert {
        background: #d1f7d1;
        border-left: 5px solid #27ae60;
        padding: 10px;
        margin-bottom: 10px;
        border-radius: 5px;
    }
</style>
</head>
<body>

<!-- Include layout -->
<jsp:include page="layout/header.jsp" />
<jsp:include page="layout/menu.jsp" />

<div class="container">
    <h2>Quản lý người dùng</h2>

    <!-- Hiển thị thông báo -->
    <c:if test="${not empty message}">
        <div class="alert">${message}</div>
    </c:if>

    <!-- Form nhập người dùng -->
    <form id="userForm" action="${pageContext.request.contextPath}/admin/user" method="post">
        <label>Mã người dùng:</label>
        <input type="text" name="id" required>

        <label>Mật khẩu:</label>
        <input type="text" name="password" required>

        <label>Họ và tên:</label>
        <input type="text" name="fullname" required>

        <label>Email:</label>
        <input type="email" name="email" required>

        <label>Điện thoại:</label>
        <input type="text" name="mobile">

        <label>Ngày sinh:</label>
        <input type="date" name="birthday">

        <label>Giới tính:</label>
        <select name="gender">
            <option value="true">Nam</option>
            <option value="false">Nữ</option>
        </select>

        <label>Vai trò:</label>
        <select name="role">
            <option value="true">Quản trị viên</option>
            <option value="false">Phóng viên</option>
        </select>

        <div style="margin-top: 10px;">
            <button class="btn-add" type="submit">Lưu</button>
            <button class="btn-clear" type="reset" onclick="clearForm()">Mới</button>
        </div>
    </form>

    <!-- Bảng danh sách người dùng -->
    <table id="userTable">
        <thead>
            <tr>
                <th>Mã</th>
                <th>Họ tên</th>
                <th>Email</th>
                <th>Điện thoại</th>
                <th>Giới tính</th>
                <th>Vai trò</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="u" items="${list}">
                <tr data-id="${u.id}" data-password="${u.password}" data-fullname="${u.fullname}" 
                    data-email="${u.email}" data-mobile="${u.mobile}" data-birthday="${u.birthday}" 
                    data-gender="${u.gender}" data-role="${u.role}">
                    <td>${u.id}</td>
                    <td>${u.fullname}</td>
                    <td>${u.email}</td>
                    <td>${u.mobile}</td>
                    <td><c:if test="${u.gender}">Nam</c:if><c:if test="${!u.gender}">Nữ</c:if></td>
                    <td><c:if test="${u.role}">Quản trị viên</c:if><c:if test="${!u.role}">Phóng viên</c:if></td>
                    <td>
                        <a href="user?action=delete&id=${u.id}" onclick="return confirm('Xóa người dùng này?')">🗑️</a>
                    </td>
                </tr>
            </c:forEach>

            <c:if test="${empty list}">
                <tr><td colspan="7" style="text-align:center;">Chưa có người dùng nào.</td></tr>
            </c:if>
        </tbody>
    </table>
</div>

<script>
function clearForm() {
    document.getElementById("userForm").reset();
}

// Khi nhấn vào dòng → đổ dữ liệu lên form
document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll("#userTable tbody tr").forEach(row => {
        row.addEventListener("click", () => {
            const f = document.getElementById("userForm");
            f.querySelector("[name='id']").value = row.dataset.id;
            f.querySelector("[name='password']").value = row.dataset.password;
            f.querySelector("[name='fullname']").value = row.dataset.fullname;
            f.querySelector("[name='email']").value = row.dataset.email;
            f.querySelector("[name='mobile']").value = row.dataset.mobile;
            f.querySelector("[name='birthday']").value = row.dataset.birthday;
            f.querySelector("[name='gender']").value = row.dataset.gender;
            f.querySelector("[name='role']").value = row.dataset.role;
        });
    });
});
</script>

<jsp:include page="layout/footer.jsp" />
</body>
</html>
