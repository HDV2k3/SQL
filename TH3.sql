﻿CREATE DATABASE QL_SP
USE QL_SP

CREATE TABLE LOAISP
(
	MALOAI VARCHAR(5) PRIMARY KEY  NOT NULL,
	TENLOAI NVARCHAR(50) NOT NULL
)

CREATE TABLE SANPHAM
(
	MASP VARCHAR(5) PRIMARY KEY,
	TENSP NVARCHAR(50),
	MOTA NVARCHAR(50),
	GIA BIGINT,
	MALOAI VARCHAR(5) FOREIGN KEY(MALOAI) REFERENCES LOAISP,
	CONSTRAINT MASP_DUYNHAT UNIQUE(MASP),
	CONSTRAINT TENSP_DUYNHAT UNIQUE(TENSP),
	CONSTRAINT MOTA_DUYNHAT UNIQUE(MOTA),
	CONSTRAINT GIA_DUYNHAT UNIQUE(GIA),
)

CREATE TABLE KHACHHANG
(
	MAKH VARCHAR(10) PRIMARY KEY NOT NULL,
	TENKH NVARCHAR(50) NOT NULL,
	DC NVARCHAR(100) NOT NULL,
	DT VARCHAR(11) NOT NULL
)

CREATE TABLE DONDH
(
	SODDH VARCHAR(10) PRIMARY KEY,
	NGAYDAT DATE NOT NULL,
	MAKH VARCHAR(10) FOREIGN KEY(MAKH) REFERENCES KHACHHANG NOT NULL,
	CONSTRAINT SODDH_DUYNHAT UNIQUE(SODDH)
)

CREATE TABLE CTDDH
(
	SODDH VARCHAR(10) FOREIGN KEY(SODDH) REFERENCES DONDH,
	MASP VARCHAR(5) FOREIGN KEY(MASP) REFERENCES SANPHAM,
	SOLUONG INT
)

CREATE TABLE NGUYENLIEU
(
	MANL VARCHAR(5) PRIMARY KEY NOT NULL,
	TENNL NVARCHAR(50) NOT NULL,
	DVT NVARCHAR(5) NOT NULL,
	GIA BIGINT NOT NULL
)

CREATE TABLE LAM
(
	MANL VARCHAR(5) FOREIGN KEY(MANL) REFERENCES NGUYENLIEU,
	MASP VARCHAR(5) FOREIGN KEY(MASP) REFERENCES SANPHAM,
	SOLUONG FLOAT
)

-- VIEW

-- CÂU 1

SELECT TOP 1 WITH TIES LOAISP.TENLOAI ,COUNT(SANPHAM.MALOAI) AS[SL]
FROM LOAISP,SANPHAM
WHERE LOAISP.MALOAI=SANPHAM.MALOAI
GROUP BY LOAISP.TENLOAI
ORDER BY SL DESC
-- CÂU 2
SET DATEFORMAT DMY
SELECT KHACHHANG.TENKH,KHACHHANG.DC
FROM KHACHHANG
WHERE MAKH NOT IN
(
	SELECT DONDH.MAKH
	FROM DONDH
	WHERE MONTH(NGAYDAT)=3 AND YEAR(NGAYDAT)=2010
)

-- CÂU 3

SELECT TOP 1 WITH TIES KHACHHANG.TENKH,KHACHHANG.DC, COUNT(CTDDH.SODDH) AS [SL ĐƠN HÀNG]
FROM KHACHHANG,DONDH,CTDDH
WHERE KHACHHANG.MAKH=DONDH.MAKH AND DONDH.SODDH=CTDDH.SODDH AND MONTH(NGAYDAT)=3 AND YEAR(NGAYDAT)=2010
GROUP BY KHACHHANG.TENKH,KHACHHANG.DC
ORDER BY [SL ĐƠN HÀNG] DESC

-- CÂU 4
SELECT SANPHAM.TENSP,SANPHAM.MOTA
FROM SANPHAM
WHERE SANPHAM.MASP NOT IN
(
	SELECT CTDDH.MASP
	FROM CTDDH,DONDH
	WHERE CTDDH.SODDH=DONDH.SODDH AND MONTH(NGAYDAT)=3 AND YEAR(NGAYDAT)=2010
)
-- CÂU 5

SELECT KHACHHANG.TENKH,KHACHHANG.DC,SUM(SOLUONG) AS[SL]
FROM KHACHHANG,CTDDH,DONDH,SANPHAM
WHERE KHACHHANG.MAKH=DONDH.MAKH AND CTDDH.SODDH=DONDH.SODDH AND SANPHAM.MASP=CTDDH.MASP AND SANPHAM.TENSP=N'Tủ DDA'  AND SOLUONG > 10
GROUP BY  KHACHHANG.TENKH,KHACHHANG.DC

-- CÂU 6
SELECT TOP 1 WITH TIES  SANPHAM.TENSP,SANPHAM.GIA,COUNT(LAM.MANL) AS[SỐ LOẠI NL]
FROM SANPHAM,NGUYENLIEU,LAM
WHERE NGUYENLIEU.MANL=LAM.MANL AND SANPHAM.MASP=LAM.MASP 
GROUP BY SANPHAM.TENSP,SANPHAM.GIA
ORDER BY [SỐ LOẠI NL] DESC
-- CÂU 7
SELECT SANPHAM.TENSP,SUM(NGUYENLIEU.GIA*LAM.SOLUONG) AS[GIÁ THÀNH SX]
FROM SANPHAM,NGUYENLIEU,LAM
WHERE SANPHAM.MASP=LAM.MASP AND NGUYENLIEU.MANL=LAM.MANL 
GROUP BY SANPHAM.TENSP
HAVING SUM(NGUYENLIEU.GIA*LAM.SOLUONG)>1000000

--CÂU 8
SELECT SANPHAM.TENSP,SANPHAM.GIA,SUM(NGUYENLIEU.GIA*LAM.SOLUONG) AS[GIÁ THÀNH SX],
SUM(NGUYENLIEU.GIA*LAM.SOLUONG)/(SANPHAM.GIA)*10 AS[PHẦN TRĂM LÃI CỦA  SP LỚN HƠN 20%]
FROM SANPHAM,NGUYENLIEU,LAM
WHERE SANPHAM.MASP=LAM.MASP AND NGUYENLIEU.MANL=LAM.MANL 
GROUP BY SANPHAM.TENSP,SANPHAM.GIA
HAVING SUM(NGUYENLIEU.GIA*LAM.SOLUONG)/(SANPHAM.GIA)*10 > 20


-- CÂU 9
SELECT DONDH.SODDH,DONDH.NGAYDAT, SUM(SANPHAM.GIA*CTDDH.SOLUONG) AS[TỔNG TIỀN]
FROM DONDH,CTDDH,SANPHAM
WHERE DONDH.SODDH=CTDDH.SODDH AND SANPHAM.MASP=CTDDH.MASP 
GROUP BY DONDH.SODDH,DONDH.NGAYDAT
HAVING SUM(SANPHAM.GIA*CTDDH.SOLUONG)>100000000
-- CÂU 10

SELECT DISTINCT NGUYENLIEU.TENNL,NGUYENLIEU.GIA
FROM NGUYENLIEU,LAM,SANPHAM
WHERE NGUYENLIEU.MANL=LAM.MANL AND SANPHAM.MASP=LAM.MASP

-- CÂU 11
SELECT DISTINCT KHACHHANG.TENKH,KHACHHANG.DC ,COUNT(SANPHAM.MASP)  AS[DANH SÁCH KH ĐẶT TẤT CẢ CÁC SẢN PHẨM]
FROM KHACHHANG,CTDDH,DONDH,SANPHAM
WHERE KHACHHANG.MAKH=DONDH.MAKH AND CTDDH.SODDH=DONDH.SODDH AND SANPHAM.MASP=CTDDH.MASP
GROUP BY KHACHHANG.TENKH,KHACHHANG.DC
HAVING COUNT(SANPHAM.MASP) =(SELECT COUNT(SANPHAM.MASP) FROM SANPHAM,CTDDH WHERE SANPHAM.MASP=CTDDH.MASP)
-- NOTE, CHECK : HAVING COUNT(SANPHAM.MASP) = @X
-- CÂU 12
SELECT SANPHAM.TENSP,SANPHAM.MOTA ,COUNT(KHACHHANG.MAKH) AS[ DANH SÁCH SP KHÁCH HÀNG ĐỀU ĐẶT]
FROM SANPHAM,CTDDH,DONDH,KHACHHANG
WHERE SANPHAM.MASP=CTDDH.MASP AND CTDDH.SODDH=DONDH.SODDH AND KHACHHANG.MAKH=DONDH.MAKH
GROUP BY SANPHAM.TENSP,SANPHAM.MOTA
HAVING COUNT(KHACHHANG.MAKH) = (SELECT COUNT(KHACHHANG.MAKH) FROM KHACHHANG,DONDH WHERE KHACHHANG.MAKH=DONDH.MAKH)
--NOTE,CHECK : HAVING COUNT(KHACHHANG.MAKH) = @X
-- CÂU 13

SELECT KHACHHANG.TENKH,KHACHHANG.DC 
FROM KHACHHANG
WHERE KHACHHANG.MAKH NOT IN
(
	SELECT KHACHHANG.MAKH
	FROM KHACHHANG,DONDH
	WHERE KHACHHANG.MAKH=DONDH.MAKH
)

--Stored Procedure
--a.	Liệt kê DS khách hàng (TênKH, DC) có đặt hàng vào Ngày tháng năm X.
CREATE PROC A(@NGAY INT,@THANG INT,@NAM INT)
AS
	BEGIN 
		SELECT DISTINCT KHACHHANG.TENKH,KHACHHANG.DC
		FROM KHACHHANG,DONDH,CTDDH
		WHERE KHACHHANG.MAKH=DONDH.MAKH AND DONDH.SODDH=CTDDH.SODDH AND 
		DAY(NGAYDAT)=@NGAY AND MONTH(NGAYDAT)=@THANG AND YEAR(NGAYDAT)=@NAM
	END
	DROP PROC A
EXEC dbo.A @NGAY=15,@THANG=3,@NAM=2010
--b.	Liệt kê DS khách hàng (TênKH, DC) có đặt hàng sản phẩm có mã số X.
CREATE PROC B(@MASP VARCHAR(5))
AS
	BEGIN
		SELECT KHACHHANG.TENKH,KHACHHANG.DC
		FROM KHACHHANG,DONDH,CTDDH,SANPHAM
		WHERE KHACHHANG.MAKH=DONDH.MAKH AND CTDDH.SODDH=DONDH.SODDH AND SANPHAM.MASP=CTDDH.MASP AND CTDDH.MASP=@MASP
	END
DROP PROC B
EXEC dbo.B @MASP=SP01
--c.	Liệt kê DS khách hàng (TênKH, DC) có đặt hàng với tổng số tiền trên X (1 đơn).

--d.	Liệt kê DS khách hàng (TênKH, DC) có đặt hàng với tổng số tiền trên X (tất cả).
CREATE PROC D(@SOTIEN BIGINT)
AS
	BEGIN
		SELECT KHACHHANG.TENKH,KHACHHANG.DC , SUM(SANPHAM.GIA*CTDDH.SOLUONG) AS[ GIÁ TIỀN CỦA CÁC ĐƠN ĐẶT HÀNG CỦA 1 KHÁCH HÀNG]
		FROM KHACHHANG,DONDH,CTDDH,SANPHAM
		WHERE KHACHHANG.MAKH=DONDH.MAKH AND DONDH.SODDH=CTDDH.SODDH AND SANPHAM.MASP=CTDDH.MASP
		GROUP BY KHACHHANG.TENKH,KHACHHANG.DC
		HAVING SUM(SANPHAM.GIA*CTDDH.SOLUONG) > @SOTIEN
	END
	DROP PROC D
EXEC dbo.D @SOTIEN =4000000

--e.	Liệt kê DS sản phẩm (TênSP, Giá thành SX, Giá) bán lãi trên X.

--f.	Liệt kê DS khách hàng (TênKH, DC) đã trên X ngày rồi chưa đặt hàng.
CREATE PROC F(@NGAY INT)
AS
	BEGIN
		SELECT KHACHHANG.TENKH,KHACHHANG.DC
		FROM KHACHHANG,DONDH,CTDDH
		WHERE KHACHHANG.MAKH=DONDH.MAKH AND DONDH.SODDH=CTDDH.SODDH AND 
--g.	Liệt kê DS sản phẩm (TênSP, Số đơn) có tổng số đơn đặt hàng trên X.
ALTER PROC G(@Y INT)
AS
	BEGIN
		SELECT SANPHAM.TENSP,COUNT(DONDH.SODDH) AS[TỔNG ĐƠN HÀNG/SP]
		FROM SANPHAM,CTDDH,DONDH
		WHERE SANPHAM.MASP=CTDDH.MASP AND CTDDH.SODDH=DONDH.SODDH 
		GROUP BY SANPHAM.TENSP
		HAVING COUNT(DONDH.SODDH)> @Y
		ORDER BY [TỔNG ĐƠN HÀNG/SP] 
	END
	DROP PROC G
EXEC dbo.G @Y=2  
--h.	Liệt kê DS sản phẩm (TênSP, Tổng SL) có tổng số lượng đặt hàng trên X.
 CREATE PROC H(@X INT)
	AS
		BEGIN
			SELECT SANPHAM.TENSP,SUM(CTDDH.SOLUONG) AS [TỔNG SỐ LƯỢNG ĐẶT HÀNG TRÊN X]
		FROM SANPHAM,CTDDH
		WHERE SANPHAM.MASP=CTDDH.MASP
		GROUP BY SANPHAM.TENSP
		HAVING SUM(CTDDH.SOLUONG) >@X
		END
EXEC H @X=5
--i.	Liệt kê DS sản phẩm (TênSP, Tổng số tiền) có tổng số tiền đặt hàng trên X.
CREATE PROC I(@X INT)
	AS
	BEGIN
		SELECT SANPHAM.TENSP ,SUM(SANPHAM.GIA*CTDDH.SOLUONG) AS[ TỔNG SỐ TIỀN ĐẶT HÀNG X]
		FROM SANPHAM,CTDDH
		WHERE SANPHAM.MASP=CTDDH.MASP
		GROUP BY SANPHAM.TENSP
		HAVING SUM(SANPHAM.GIA*CTDDH.SOLUONG)>@X
	END
EXEC I @X=1000000

--BONUS
CREATE PROC INSERT_MLSP @TL NVARCHAR(30)
AS
	DECLARE @ML VARCHAR(5) , @R INT
		SET @R = (SELECT COUNT(*) FROM LOAISP)
		IF
			(@R=0)
				SET @ML = 'L01'
		ELSE
			BEGIN
				SET @ML =('L' + IIF(@R<10,'0',' ') + CONVERT (VARCHAR(4),@R+1))
	END
INSERT INTO LOAISP VALUES (@ML,@TL)

EXEC INSERT_MLSP N'Tủ'
EXEC INSERT_MLSP N'Ghế'
EXEC INSERT_MLSP N'Giường'

SELECT * FROM LOAISP

CREATE PROC insert_SP @TENSP NVARCHAR(30), @MT NVARCHAR(40), @GIA BIGINT, @ML VARCHAR(5)
AS
	DECLARE @MASP VARCHAR(5), @R INT
	SET @R = (SELECT COUNT(*) FROM SANPHAM)
	SET @MASP = ('SP' + iif(@R < 10, '00', '') + CONVERT(VARCHAR(4), @R + 1))
	INSERT INTO  SANPHAM VALUES (@MASP, @TENSP, @MT, @GIA, @ML)

	EXEC insert_SP N'Tủ trang điểm1', N'Cao 1.5m, rộng 2.3m', 16000, 'L01'
	EXEC insert_SP N'Giường đoi Cali1', N'Rộng 1.7m', 15000, 'L03'

	SELECT * FROM SANPHAM


