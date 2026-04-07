<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh sách tin tức - ABC News</title>
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
        border-bottom: 2px solid #2c3e50;
        padding-bottom: 5px;
        color: #2c3e50;
    }

    .news-list {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        margin-top: 15px;
    }

    .news-item {
        border: 1px solid #ddd;
        padding: 10px;
        border-radius: 5px;
        text-align: center;
        background-color: #fafafa;
    }

    .news-item img {
        width: 100%;
        height: 200px;
        object-fit: cover;
        border-radius: 5px;
    }

    .news-item h3 {
        margin: 10px 0 5px;
    }

    .news-item a {
        text-decoration: none;
        color: #2c3e50;
    }

    .news-item a:hover {
        color: #f1c40f;
    }
</style>
</head>
<body>


<!-- Include layout -->
<jsp:include page="layout/header.jsp" />
<jsp:include page="layout/menu.jsp" />

<div class="container">
    <h2>Danh sách tin tức</h2>

    <div class="news-list">
        <!-- 🔹 Duyệt danh sách tin thật từ servlet -->
        <c:forEach var="n" items="${newsList}">
            <div class="news-item">
                <img src="${n.image}" alt="${n.title}">
                <h3><a href="news-detail?id=${n.id}">${n.title}</a></h3>
                <p>Ngày đăng: ${n.postedDate}</p>
            </div>
        </c:forEach>
    </div>

    <!-- Hiện thông báo nếu không có tin -->
    <c:if test="${empty newsList}">
        <p>Hiện chưa có tin tức nào trong hệ thống.</p>
    </c:if>
</div>

<jsp:include page="layout/footer.jsp" />

</body>
</html>
