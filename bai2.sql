-- Step 1: Tạo cơ sở dữ liệu QuanLyDiemThi
CREATE DATABASE IF NOT EXISTS QuanLyDiemThi;
USE QuanLyDiemThi;

-- Step 2: Tạo bảng HocSinh
CREATE TABLE HocSinh (
    MaHS VARCHAR(20) PRIMARY KEY,
    TenHS VARCHAR(50),
    NgaySinh DATETIME,
    Lop VARCHAR(20),
    GT VARCHAR(20)
);

-- Step 3: Tạo bảng GiaoVien
CREATE TABLE GiaoVien (
    MaGV VARCHAR(20) PRIMARY KEY,
    TenGV VARCHAR(50),
    SDT VARCHAR(10)
);

-- Step 4: Tạo bảng MonHoc (Có khóa ngoại tham chiếu tới GiaoVien)
CREATE TABLE MonHoc (
    MaMH VARCHAR(50) PRIMARY KEY,
    TenMH VARCHAR(50),
    MaGV VARCHAR(20),
    CONSTRAINT FK_MonHoc_GiaoVien FOREIGN KEY (MaGV) REFERENCES GiaoVien(MaGV)
);

-- Step 5: Tạo bảng BangDiem (Bảng trung gian liên kết HocSinh và MonHoc)
CREATE TABLE BangDiem (
    MaHS VARCHAR(20),
    MaMH VARCHAR(50),
    DiemThi INT,
    NgayKT DATETIME,
    PRIMARY KEY (MaHS, MaMH),
    CONSTRAINT FK_BangDiem_HocSinh FOREIGN KEY (MaHS) REFERENCES HocSinh(MaHS),
    CONSTRAINT FK_BangDiem_MonHoc FOREIGN KEY (MaMH) REFERENCES MonHoc(MaMH)
);