-- Bước 1: Sử dụng cơ sở dữ liệu QuanLySinhVien
USE QuanLySinhVien;

-- 1. Hiển thị tất cả các thông tin môn học (bảng Subject) có credit lớn nhất
SELECT * 
FROM Subject 
WHERE Credit = (SELECT MAX(Credit) FROM Subject);

-- 2. Hiển thị các thông tin môn học có điểm thi lớn nhất
SELECT S.SubId, S.SubName, S.Credit, S.Status, M.Mark 
FROM Subject S 
JOIN Mark M ON S.SubId = M.SubId 
WHERE M.Mark = (SELECT MAX(Mark) FROM Mark);

-- 3. Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
SELECT St.StudentId, St.StudentName, St.Address, St.Phone, St.Status, St.ClassId, AVG(M.Mark) AS 'Điểm trung bình'
FROM Student St 
LEFT JOIN Mark M ON St.StudentId = M.StudentId 
GROUP BY St.StudentId, St.StudentName, St.Address, St.Phone, St.Status, St.ClassId
ORDER BY AVG(M.Mark) DESC;
