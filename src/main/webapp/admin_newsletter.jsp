<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý Newsletter - ABC News</title>

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

    .alert {
        background: #d1f7d1;
        border-left: 5px solid #27ae60;
        padding: 10px;
        margin-bottom: 10px;
        border-radius: 5px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 15px;
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

    tr:nth-child(even) { background-color: #f2f2f2; }

    .status-true { color: green; font-weight: bold; }
    .status-false { color: red; font-weight: bold; }
</style>
</head>
<body>

<jsp:include page="layout/header.jsp" />
<jsp:include page="layout/menu.jsp" />

<div class="container">
    <h2>Quản lý Newsletter</h2>

    <c:if test="${not empty message}">
        <div class="alert">${message}</div>
    </c:if>

    <table>
        <thead>
            <tr>
                <th>Email</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="n" items="${list}">
                <tr>
                    <td>${n.email}</td>
                    <td>
                        <c:choose>
                            <c:when test="${n.enabled}">
                                <span class="status-true">Còn hiệu lực</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-false">Hết hiệu lực</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <a href="newsletter?action=toggle&email=${n.email}">🔁 Đổi trạng thái</a> |
                        <a href="newsletter?action=delete&email=${n.email}" 
                           onclick="return confirm('Xóa email này?')">🗑️ Xóa</a>
                    </td>
                </tr>
            </c:forEach>

            <c:if test="${empty list}">
                <tr><td colspan="3" style="text-align:center;">Chưa có email đăng ký nào.</td></tr>
            </c:if>
        </tbody>
    </table>
</div>

<jsp:include page="layout/footer.jsp" />
</body>
</html>
