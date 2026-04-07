<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý tin tức - ABC News</title>

<style>
    .container {
        width: 85%;
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
    form input[type="date"],
    form select,
    form textarea {
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
    .btn-update { background-color: #2980b9; }
    .btn-delete { background-color: #c0392b; }
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

    img {
        width: 80px;
        height: 50px;
        object-fit: cover;
        border-radius: 5px;
    }
</style>
</head>
<body>

<!-- Include layout -->
<jsp:include page="layout/header.jsp" />
<jsp:include page="layout/menu.jsp" />

<div class="container">
    <h2>Quản lý tin tức</h2>
    
    <c:if test="${not empty message}">
    <div id="toast" 
         style="background:#d1ecf1;color:#0c5460;padding:10px 15px;
                border-radius:5px;margin-bottom:15px;box-shadow:0 0 5px rgba(0,0,0,0.2);">
        ${message}
    </div>
    <script>
        setTimeout(() => {
            const t = document.getElementById('toast');
            if (t) t.style.display = 'none';
        }, 2000); // Ẩn sau 2 giây
    </script>
</c:if>
    

<form id="newsForm" action="${pageContext.request.contextPath}/admin/news" method="post">

    <label>Mã tin:</label>
    <input type="text" name="id" value="${news.id}" required>

    <label>Tiêu đề:</label>
    <input type="text" name="title" value="${news.title}" required>

    <label>Nội dung:</label>
    <textarea name="content" rows="4">${news.content}</textarea>

    <label>Ảnh (URL):</label>
    <input type="text" name="image" value="${news.image}">

    <label>Tác giả:</label>
    <input type="text" name="author" value="${news.author}">

    <label>Loại tin:</label>
    <select name="category">
        <option value="thethao" ${news.categoryId == 'thethao' ? 'selected' : ''}>Thể thao</option>
        <option value="kinhte" ${news.categoryId == 'kinhte' ? 'selected' : ''}>Kinh tế</option>
        <option value="giaitri" ${news.categoryId == 'giaitri' ? 'selected' : ''}>Giải trí</option>
    </select>

    <label>Trang nhất:</label>
    <select name="home">
        <option value="true" ${news.home ? 'selected' : ''}>Có</option>
        <option value="false" ${!news.home ? 'selected' : ''}>Không</option>
    </select>

    <div style="margin-top: 10px;">
        <button class="btn-add" type="submit">Lưu</button>
        <button class="btn-clear" type="reset" onclick="clearForm()">Mới</button>
    </div>
</form>

<!-- Bảng danh sách -->
<table id="newsTable">
    <thead>
        <tr>
            <th>Mã tin</th>
            <th>Tiêu đề</th>
            <th>Ảnh</th>
            <th>Ngày đăng</th>
            <th>Loại tin</th>
            <th>Trang nhất</th>
            <th>Tác giả</th>
            <th>Hành động</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="n" items="${list}">
            <tr data-id="${n.id}" data-title="${n.title}" data-content="${n.content}" data-image="${n.image}"
                data-author="${n.author}" data-category="${n.categoryId}" data-home="${n.home}">
                <td>${n.id}</td>
                <td>${n.title}</td>
                <td><img src="${n.image}" alt="${n.title}"></td>
                <td>${n.postedDate}</td>
                <td>${n.categoryId}</td>
                <td><c:if test="${n.home}">Có</c:if><c:if test="${!n.home}">Không</c:if></td>
                <td>${n.author}</td>
                <td>
                    <a href="news?action=edit&id=${n.id}">✏️</a>
                    <a href="news?action=delete&id=${n.id}" onclick="return confirm('Xóa bản tin này?')">🗑️</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<script>
function clearForm() {
    document.getElementById('newsForm').reset();
}

document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll("#newsTable tbody tr").forEach(row => {
        row.addEventListener("click", () => {
            const f = document.getElementById("newsForm");
            f.id.value = row.dataset.id;
            f.title.value = row.dataset.title;
            f.content.value = row.dataset.content;
            f.image.value = row.dataset.image;
            f.author.value = row.dataset.author;
            f.category.value = row.dataset.category;
            f.home.value = row.dataset.home;
        });
    });
});

</script>

</div>

<jsp:include page="layout/footer.jsp" />

</body>
</html>
