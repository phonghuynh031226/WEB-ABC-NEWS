-- Tạo database
CREATE DATABASE ABCNews;
GO

USE ABCNews;
GO

-- Bảng USERS (Người dùng)
CREATE TABLE Users (
    Id VARCHAR(50) PRIMARY KEY,       -- Mã đăng nhập
    Password NVARCHAR(100) NOT NULL,  -- Mật khẩu
    Fullname NVARCHAR(100) NOT NULL,  -- Họ và tên
    Birthday DATE,                    -- Ngày sinh
    Gender BIT,                       -- Giới tính (0: Nữ, 1: Nam)
    Mobile NVARCHAR(20),              -- Điện thoại
    Email NVARCHAR(100) UNIQUE,       -- Email
    Role BIT NOT NULL                 -- Vai trò (1: Quản trị, 0: Phóng viên)
);
GO

-- Bảng CATEGORIES (Loại tin)
CREATE TABLE Categories (
    Id VARCHAR(50) PRIMARY KEY,       -- Mã loại tin
    Name NVARCHAR(100) NOT NULL       -- Tên loại tin
);
GO

-- Bảng NEWS (Bản tin)
CREATE TABLE News (
    Id VARCHAR(50) PRIMARY KEY,       -- Mã bản tin
    Title NVARCHAR(200) NOT NULL,     -- Tiêu đề
    Content NVARCHAR(MAX) NOT NULL,   -- Nội dung
    Image NVARCHAR(200),              -- Hình ảnh / video
    PostedDate DATE DEFAULT GETDATE(),-- Ngày đăng
    Author VARCHAR(50) NOT NULL,      -- Tác giả (mã phóng viên)
    ViewCount INT DEFAULT 0,          -- Số lượt xem
    CategoryId VARCHAR(50) NOT NULL,  -- Mã loại tin
    Home BIT DEFAULT 0,               -- Trang nhất (1: có, 0: không)

    CONSTRAINT FK_News_Users FOREIGN KEY (Author) REFERENCES Users(Id),
    CONSTRAINT FK_News_Categories FOREIGN KEY (CategoryId) REFERENCES Categories(Id)
);
GO

-- Bảng NEWSLETTERS (Đăng ký nhận tin)
CREATE TABLE Newsletters (
    Email NVARCHAR(100) PRIMARY KEY,  -- Email nhận tin
    Enabled BIT DEFAULT 1             -- Trạng thái (1: còn hiệu lực, 0: hủy)
);
GO


-- Thêm người dùng
INSERT INTO Users (Id, Password, Fullname, Birthday, Gender, Mobile, Email, Role)
VALUES 
('admin', '123456', N'Nguyễn Văn Quản Trị', '1990-01-01', 1, '0901234567', 'admin@abcnews.com', 1),
('pv01', '123456', N'Lê Thị Phóng Viên', '1995-05-05', 0, '0912345678', 'pv01@abcnews.com', 0);

-- Thêm loại tin
INSERT INTO Categories (Id, Name)
VALUES 
('thethao', N'Thể thao'),
('giaitri', N'Giải trí'),
('thoisu', N'Thời sự');

-- Thêm bản tin
INSERT INTO News (Id, Title, Content, Image, Author, CategoryId, Home)
VALUES
('n001', N'Chung kết bóng đá U23', N'Nội dung chi tiết về trận đấu...', 'u23.jpg', 'pv01', 'thethao', 1),
('n002', N'Showbiz Việt Nam', N'Tin nóng showbiz hôm nay...', 'showbiz.png', 'pv01', 'giaitri', 0);

-- Thêm newsletter
INSERT INTO Newsletters (Email, Enabled)
VALUES
('docgia1@gmail.com', 1),
('docgia2@yahoo.com', 1);
