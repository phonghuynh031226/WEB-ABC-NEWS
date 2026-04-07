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
<title>Menu</title>
<style>
	nav {
	    background-color: #34495e;
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	    padding: 10px 40px;
	    flex-wrap: wrap;
	}
    
    nav a {
        color: white;
        text-decoration: none;
        margin: 0 15px;
        font-weight: bold;
        transition: 0.3s;
    }
    nav a:hover {
        color: #f1c40f;
    }
    .user-info {
    	color: white;
    }
    
/* Modal nền */
.modal {
  display: none; /* Ẩn mặc định */
  position: fixed;
  z-index: 999;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0,0,0,0.5);
}

/* Hộp nội dung modal */
.modal-content {
  background-color: #fff;
  margin: 10% auto;
  padding: 20px;
  border-radius: 10px;
  width: 50%;
  box-shadow: 0 4px 8px rgba(0,0,0,0.3);
  position: relative;
}

/* Nút đóng */
.close {
  color: #aaa;
  position: absolute;
  top: 10px;
  right: 15px;
  font-size: 28px;
  font-weight: bold;
  cursor: pointer;
}
.close:hover {
  color: #e74c3c;
}

/* Danh sách bài viết */
.modal-content ul {
  list-style: none;
  padding: 0;
  margin-top: 20px;
}

.modal-content li {
  padding: 8px 0;
  border-bottom: 1px solid #ccc;
}

.modal-content a {
  color: #2c3e50;
  text-decoration: none;
}

.modal-content a:hover {
  color: #f1c40f;
}

/* Nút xóa */
.btn-clear {
  margin-top: 15px;
  background: #c0392b;
  color: white;
  border: none;
  padding: 8px 12px;
  border-radius: 5px;
  cursor: pointer;
}
.btn-clear:hover {
  background: #e74c3c;
}

/* --- SỬA LỖI KHÔNG HIỆN DANH SÁCH LƯU --- */
#savedList a {
  color: #000 !important;      /* Chữ màu đen */
  font-weight: bold;
  display: block;
  padding: 6px 0;
}

#savedList li {
  background: #f9f9f9;
  border: 1px solid #ddd;
  margin-bottom: 6px;
  border-radius: 4px;
  padding: 4px 8px;
}

.modal-content {
  color: black !important;     /* Toàn bộ modal hiện chữ rõ */
  z-index: 9999 !important;    /* Đặt modal nằm trên cùng */
}
#savedList img {
    border: 1px solid #ccc;
    background: #fff;
}
#savedList span {
    font-size: 15px;
    color: #2c3e50;
}

 
    
</style> 


</head>
<body>

<nav>
    <!-- MENU BÊN TRÁI -->
    <div class="menu-left">
        <a href="${pageContext.request.contextPath}/home"><fmt:message key="menu.home"/></a>
        <a href="${pageContext.request.contextPath}/news-list"><fmt:message key="menu.news"/></a>
        <a href="${pageContext.request.contextPath}/contact.jsp"><fmt:message key="menu.contact"/></a>
<a href="#" id="btnSaved">📖 <fmt:message key="menu.saved" /></a>
     
    </div>

    <!-- MENU BÊN PHẢI -->
    <div class="menu-right">
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <span class="user-info">
                    <fmt:message key="menu.hello" /> <strong>${sessionScope.user.fullname}</strong>
                </span>
                <a href="${pageContext.request.contextPath}/logout"><fmt:message key="menu.logout" /></a>

                <c:if test="${sessionScope.user.role}">
                    <a href="${pageContext.request.contextPath}/admin/dashboard">🏠 <fmt:message key="menu.admin"/></a>
                </c:if>

                <c:if test="${not sessionScope.user.role}">
                    <a href="${pageContext.request.contextPath}/admin/news">📰 <fmt:message key="menu.author"/></a>
                </c:if>
            </c:when>

            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login"><fmt:message key="menu.login" /></a>
            </c:otherwise>
        </c:choose>
    </div>
</nav>

<!-- Modal -->
<div id="savedModal" class="modal">
  <div class="modal-content">
    <span class="close" id="closeSaved">&times;</span>
    <h3>📚 Danh sách bài viết đã lưu</h3>
    <ul id="savedList"></ul>
    <button class="btn-clear">🗑 Xóa tất cả</button>
  </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const modal = document.getElementById("savedModal");
    const btn = document.getElementById("btnSaved");
    const close = document.getElementById("closeSaved");
    const listContainer = document.getElementById("savedList");
    const clearBtn = document.querySelector(".btn-clear");

    // 🧠 Hàm hiển thị danh sách
    function renderSaved() {
        const saved = JSON.parse(localStorage.getItem("savedNews") || "[]");
        console.log("📦 Dữ liệu đọc sau:", saved);

        listContainer.innerHTML = ""; // Xóa cũ

        if (saved.length === 0) {
            listContainer.innerHTML = "<li>Chưa có bài viết nào được lưu.</li>";
        } else {
            saved.forEach(item => {
                const li = document.createElement("li");
                li.innerHTML = `
                    <a href="${item.url}" target="_blank" style="display:flex; align-items:center; gap:10px;">
                        <img src="${item.image}" alt="${item.title}" style="width:60px;height:60px;object-fit:cover;border-radius:6px;">
                        <span>${item.title}</span>
                    </a>
                `;

                listContainer.appendChild(li);
            });
        }

        // 🧩 Thêm log kiểm tra
        console.log("📃 HTML hiện tại của danh sách:", listContainer.innerHTML);
    }

    // 🔹 Khi nhấn “Đọc sau”
    btn.addEventListener("click", e => {
        e.preventDefault();
        modal.style.display = "block";

        // ⏳ Gọi sau 100ms để chắc chắn DOM modal đã sẵn sàng
        setTimeout(() => {
            renderSaved();
        }, 100);
    });

    // 🔹 Khi nhấn “×”
    close.addEventListener("click", () => {
        modal.style.display = "none";
    });

    // 🔹 Khi nhấn ra ngoài modal
    window.addEventListener("click", e => {
        if (e.target === modal) {
            modal.style.display = "none";
        }
    });

    // 🔹 Khi nhấn “Xóa tất cả”
    clearBtn.addEventListener("click", () => {
        localStorage.removeItem("savedNews");
        renderSaved();
    });

    console.log("✅ Modal đọc sau đã sẵn sàng");
});
</script>
