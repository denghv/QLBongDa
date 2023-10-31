CREATE DATABASE QLBongDa
GO

USE QLBongDa
GO

CREATE TABLE QUOCGIA(
	MAQG VARCHAR(5) PRIMARY KEY,
	TENQG NVARCHAR(60) NOT NULL
);

CREATE TABLE TINH(
	MATINH VARCHAR(5) PRIMARY KEY,
	TENTINH NVARCHAR(100) NOT NULL
);

CREATE TABLE SANVD(
	MASAN VARCHAR(5) PRIMARY KEY,
	TENSAN NVARCHAR(100) NOT NULL,
	DIACHI NVARCHAR(200)
);

CREATE TABLE HUANLUYENVIEN(
	MAHLV VARCHAR(5) PRIMARY KEY,
	TENHLV NVARCHAR(100) NOT NULL,
	NGAYSINH DATETIME,
	DIACHI NVARCHAR(200),
	DIENTHOAI NVARCHAR(20),
	MAQG VARCHAR(5) NOT NULL,

	FOREIGN KEY(MAQG) REFERENCES QUOCGIA(MAQG)
);

CREATE TABLE CAULACBO(
	MACLB VARCHAR(5) PRIMARY KEY,
	TENCLB NVARCHAR(100) NOT NULL,
	MASAN VARCHAR(5) NOT NULL,
	MATINH VARCHAR(5) NOT NULL,

	FOREIGN KEY(MASAN) REFERENCES SANVD(MASAN),
	FOREIGN KEY(MATINH) REFERENCES TINH(MATINH)
);

CREATE TABLE HLV_CLB(
	MAHLV VARCHAR(5),
	MACLB VARCHAR(5),
	VAITRO NVARCHAR(100) NOT NULL,

	PRIMARY KEY(MAHLV, MACLB),
	FOREIGN KEY(MAHLV) REFERENCES HUANLUYENVIEN(MAHLV),
	FOREIGN KEY(MACLB) REFERENCES CAULACBO(MACLB),
	CHECK(VAITRO IN (N'HLV Chính', N'HLV phụ', N'HLV thủ môn', N'HLV thể lực'))
);

CREATE TABLE CAUTHU(
	MACT NUMERIC IDENTITY(1,1) PRIMARY KEY,
	HOTEN NVARCHAR(100) NOT NULL,
	VITRI NVARCHAR(20) NOT NULL,
	NGAYSINH DATE,
	DIACHI NVARCHAR(200),
	MACLB VARCHAR(5) NOT NULL,
	MAQG VARCHAR(5) NOT NULL,
	SO INT NOT NULL,

	FOREIGN KEY(MACLB) REFERENCES CAULACBO(MACLB),
	CHECK(VITRI IN (N'Thủ môn', N'Tiền đạo', N'Tiền vệ', N'Trung vệ', N'Hậu vệ'))
);

CREATE TABLE TRANDAU(
	MATRAN NUMERIC IDENTITY(1,1) PRIMARY KEY,
	NAM INT NOT NULL,
	VONG INT NOT NULL,
	NGAYTD DATETIME NOT NULL,
	MACLB1 VARCHAR(5) NOT NULL,
	MACLB2 VARCHAR(5) NOT NULL,
	MASAN VARCHAR(5) NOT NULL,
	KETQUA VARCHAR(5) NOT NULL,

	FOREIGN KEY(MACLB1) REFERENCES CAULACBO(MACLB),
	FOREIGN KEY(MACLB2) REFERENCES CAULACBO(MACLB),
	CHECK(MACLB1 <> MACLB2),
	FOREIGN KEY(MASAN) REFERENCES SANVD(MASAN)
);

CREATE TABLE BANGXH(
	MACLB VARCHAR(5),
	NAM INT,
	VONG INT,
	SOTRAN INT NOT NULL,
	THANG INT NOT NULL,
	HOA INT NOT NULL,
	THUA INT NOT NULL,
	HIEUSO VARCHAR(5) NOT NULL,
	DIEM INT NOT NULL,
	HANG INT NOT NULL,

	PRIMARY KEY(MACLB, NAM, VONG),
	FOREIGN KEY(MACLB) REFERENCES CAULACBO(MACLB)
);

INSERT INTO QUOCGIA(MAQG, TENQG)
VALUES ('VN', N'Việt Nam'),
	   ('ANH', N'Anh Quốc'),
	   ('TBN', N'Tây Ban Nha'),
	   ('BDN', N'Bồ Đào Nha'),
	   ('BRA', N'Bra-xin'),
	   ('ITA', N'Ý'),
	   ('THA', N'Thái Lan');

INSERT INTO TINH(MATINH, TENTINH)
VALUES ('BD', N'Bình Dương'),
	   ('GL', N'Gia Lai'),
	   ('DN', N'Đà Nẵng'),
	   ('KH', N'Khánh Hòa'),
	   ('PY', N'Phú Yên'),
	   ('LA', N'Long An');

INSERT INTO SANVD(MASAN, TENSAN, DIACHI)
VALUES ('GD', N'Gò Đậu', N'123 QL1, TX Thủ Dầu Một, Bình Dương'),
	   ('PL', N'Pleiku', N'22 Hồ Tùng Mậu, Thống Nhất, Thị xã Pleiku, Gia Lai'),
	   ('CL', N'Chi Lăng', N'127 Võ Văn Tần, Đà Nẵng'),
	   ('NT', N'Nha Trang', N'128 Phan Chu Trinh, Nha Trang, Khánh Hòa'),
	   ('TH', N'Tuy Hòa', N'57 Trường Chinh, Tuy Hòa, Phú Yên'),
	   ('LA', N'Long An', N'102 Hùng Vương, Tp Tân An, Long An');

INSERT INTO HUANLUYENVIEN(MAHLV, TENHLV, NGAYSINH, DIACHI, DIENTHOAI, MAQG)
VALUES ('HLV01', N'Vital', '10-15-1995', NULL, '0918011075', 'BDN'),
	   ('HLV02', N'Lê Huỳnh Đức', '05-20-1972', NULL, '01223456789', 'VN'),
	   ('HLV03', N'Kiatisuk', '12-11-1970', NULL, '01990123456', 'THA'),
	   ('HLV04', N'Hoàng Anh Tuấn', '06-10-1970', NULL, '0989112233', 'VN'),
	   ('HLV05', N'Trần Công Minh', '07-07-1973', NULL, '0909099990', 'VN'),
	   ('HLV06', N'Trần Văn Phúc', '03-02-1965', NULL, '01650101234', 'VN');

INSERT INTO CAULACBO(MACLB, TENCLB, MASAN, MATINH)
VALUES ('BBD', N'BECAMEX BÌNH DƯƠNG', 'GD', 'BD'),
	   ('HAGL', N'HOÀNG ANH GIA LAI', 'PL', 'GL'),
	   ('SDN', N'SHB ĐÀ NẴNG', 'CL', 'DN'),
	   ('KKH', N'KHATOCO KHÁNH HÒA', 'NT', 'KH'),
	   ('TPY', N'THÉP PHÚ YÊN', 'TH', 'PY'),
	   ('GDT', N'GẠCH ĐỒNG TÂM LONG AN', 'LA', 'LA');

INSERT INTO HLV_CLB(MAHLV, MACLB, VAITRO)
VALUES ('HLV01', 'BBD', N'HLV Chính'),
	   ('HLV02', 'SDN', N'HLV Chính'),
	   ('HLV03', 'HAGL', N'HLV Chính'),
	   ('HLV04', 'KKH', N'HLV Chính'),
	   ('HLV05', 'GDT', N'HLV Chính'),
	   ('HLV06', 'BBD', N'HLV thủ môn');

INSERT INTO CAUTHU(HOTEN, VITRI, NGAYSINH, DIACHI, MACLB, MAQG, SO)
VALUES (N'Nguyễn Vũ Phong', N'Tiền vệ', '02-20-1990', NULL, 'BBD', 'VN', 17),
	   (N'Nguyễn Công Vinh', N'Tiền đạo', '03-10-1992', NULL, 'HAGL', 'VN', 9),
	   (N'Nguyễn Trọng Tuấn', N'Trung vệ', '01-05-2003', NULL, 'TPY', 'VN', 10),
	   (N'Trần Tấn Tài', N'Tiền vệ', '11-12-1989', NULL, 'BBD', 'VN', 8),
	   (N'Phan Hồng Sơn', N'Thủ môn', '06-10-1991', NULL, 'HAGL', 'VN', 1),
	   (N'Ronaldo', N'Tiền vệ', '12-12-1989', NULL, 'SDN', 'BRA', 7),
	   (N'Robinho', N'Tiền vệ', '10-12-1989', NULL, 'SDN', 'BRA', 8),
	   (N'Vidic', N'Hậu vệ', '10-15-1987', NULL, 'HAGL', 'ANH', 3),
	   (N'Trần Văn Santos', N'Thủ môn', '10-21-1990', NULL, 'BBD', 'BRA', 1),
	   (N'Nguyễn Trường Sơn', N'Hậu vệ', '08-26-1993', NULL, 'BBD', 'VN', 4);
	
INSERT INTO TRANDAU(NAM, VONG, NGAYTD, MACLB1, MACLB2, MASAN, KETQUA)
VALUES (2009, 1, '2-7-2009', 'BBD', 'SDN', 'GD', '3-0'),
	   (2009, 1, '2-7-2009', 'KKH', 'GDT', 'NT', '1-1'),
	   (2009, 2, '2-16-2009', 'SDN', 'KKH', 'CL', '2-2'),
	   (2009, 2, '2-16-2009', 'TPY', 'BBD', 'TH', '5-0'),
	   (2009, 3, '3-1-2009', 'TPY', 'GDT', 'TH', '0-2'),
	   (2009, 3, '3-1-2009', 'KKH', 'BBD', 'NT', '0-1'),
	   (2009, 4, '3-7-2009', 'KKH', 'TPY', 'NT', '1-0'),
	   (2009, 4, '3-7-2009', 'BBD', 'GDT', 'GD', '2-2');
	
INSERT INTO BANGXH(MACLB, NAM, VONG, SOTRAN, THANG, HOA, THUA, HIEUSO, DIEM, HANG)
VALUES ('BBD', 2009, 1, 1, 1, 0, 0, '3-0', 3, 1),
	   ('KKH', 2009, 1, 1, 0, 1, 0, '1-1', 1, 2),
	   ('GDT', 2009, 1, 1, 0, 1, 0, '1-1', 1, 3),
	   ('TPY', 2009, 1, 0, 0, 0, 0, '0-0', 0, 4),
	   ('SDN', 2009, 1, 1, 0, 0, 1, '0-3', 0, 5),
	   ('TPY', 2009, 2, 1, 1, 0, 0, '5-0', 3, 1),
	   ('BBD', 2009, 2, 2, 1, 0, 1, '3-5', 3, 2),
	   ('KKH', 2009, 2, 2, 0, 2, 0, '3-3', 2, 3),
	   ('GDT', 2009, 2, 1, 0, 1, 0, '1-1', 1, 4),
	   ('SDN', 2009, 2, 2, 1, 1, 0, '2-5', 1, 5),
	   ('BBD', 2009, 3, 3, 2, 0, 1, '4-5', 6, 1),
	   ('GDT', 2009, 3, 2, 1, 1, 0, '3-1', 4, 2),
	   ('TPY', 2009, 3, 2, 1, 0, 1, '5-2', 3, 3),
	   ('KKH', 2009, 3, 3, 0, 2, 1, '3-4', 2, 4),
	   ('SDN', 2009, 3, 2, 1, 1, 0, '2-5', 1, 5),
	   ('BBD', 2009, 4, 4, 2, 1, 1, '6-7', 7, 1),
	   ('GDT', 2009, 4, 3, 1, 2, 0, '5-1', 5, 2),
	   ('KKH', 2009, 4, 4, 1, 2, 1, '4-4', 5, 3),
	   ('TPY', 2009, 4, 3, 1, 0, 2, '5-3', 3, 4),
	   ('SDN', 2009, 4, 2, 1, 1, 0, '2-5', 1, 5);