﻿  USE QL_BANHANG
  GO
 -- CÂU 1
CREATE VIEW KH
AS(
 SELECT *
 FROM dbo.KhachHang
 WHERE DiaChi=N'TÂN BÌNH'
)
GO
-- CÂU 2
CREATE VIEW KH1
AS (
 SELECT *
 FROM dbo.KhachHang
 WHERE DT IS NULL
 )
 GO
-- CÂU 3
CREATE VIEW KH2
AS(
 SELECT *
 FROM dbo.KhachHang
 WHERE DT IS NULL AND Email IS NULL
 )
 GO
-- CÂU 4
CREATE VIEW KH3
AS(
 SELECT *
 FROM dbo.KhachHang
 WHERE DT IS NOT NULL AND Email IS NOT NULL
 )
 GO
-- CÂU 5
CREATE VIEW KH4
AS(
 SELECT *
 FROM dbo.VATTU
 WHERE DVT = N'CÁI%'
 )
 GO
--CÂU 6
CREATE VIEW KH5
AS(
 SELECT *
 FROM dbo.VATTU
 WHERE GiaMua>25000
 )
 GO

--CÂU 7
CREATE VIEW KH6
AS(
SELECT *
FROM dbo.VATTU
WHERE TenVT LIKE N'GẠCH%'
)
GO
-- CÂU 8
CREATE VIEW KH7
AS(
SELECT *
FROM dbo.VATTU
WHERE GiaMua BETWEEN 20000 AND 40000
)
GO
-- CÂU 9
CREATE VIEW KH8
AS(
SELECT SoHD,NgayLap,TenKH,DiaChi,DT
FROM dbo.HOADON,dbo.KhachHang
WHERE dbo.HOADON.MaKH=dbo.KhachHang.MaKH
)
GO
-- CÂU 10
CREATE VIEW KH9
AS(
SELECT SoHD,TenKH,DiaChi,DT 
FROM dbo.HOADON,dbo.KhachHang
WHERE dbo.HOADON.MaKH=dbo.KhachHang.MaKH AND DAY(NgayLap)=25 AND MONTH(NgayLap)=5 AND YEAR(NgayLap)=2010
)
GO
-- 
--CÂU 11
CREATE VIEW KH10
AS
(
	SELECT SoHD,TenKH,NgayLap,DiaChi,DT
	FROM HOADON,dbo.KhachHang
	WHERE dbo.HOADON.MaKH=dbo.KhachHang.MaKH AND MONTH(NgayLap)=6 AND YEAR(NgayLap)=2010
)
GO
-- CÂU 12
CREATE VIEW KH11
AS(
	SELECT TenKH,DiaChi,DT
	FROM dbo.KhachHang,dbo.HOADON
	WHERE dbo.KhachHang.MaKH=dbo.HOADON.MaKH AND  MONTH(NgayLap)=6 AND YEAR(NgayLap )=2010
)
GO
-- CÂU 13 
CREATE VIEW KH12
AS
	(
	SELECT *
	FROM dbo.KhachHang
	WHERE MaKH NOT IN
	
	(SELECT MaKH 
	FROM dbo.HOADON
	WHERE MONTH(NgayLap)=6 AND YEAR(NgayLap )=2010
	)
)
GO
-- CÂU 14 
CREATE VIEW KH13
AS
(	SELECT dbo.HOADON.SoHD,dbo.VATTU.MaVT,TenVT,DVT,GiaBan,GiaMua,SoLuong,(GiaMua*SoLuong) AS [TRỊ GIÁ MUA],(GiaBan*SoLuong) AS[TRỊ GIÁ BÁN]
	FROM HOADON,VATTU,dbo.CHITIETHOADON
	WHERE dbo.HOADON.SoHD=dbo.CHITIETHOADON.SoHD AND dbo.VATTU.MaVT=dbo.CHITIETHOADON.MaVT
)
GO
-- CÂU 15
CREATE VIEW KH14
AS
(	SELECT dbo.HOADON.SoHD,dbo.VATTU.MaVT,TenVT,DVT,GiaBan,GiaMua,SoLuong,(GiaMua*SoLuong) AS [TRỊ GIÁ MUA],(GiaBan*SoLuong) AS[TRỊ GIÁ BÁN]
	FROM HOADON,VATTU,dbo.CHITIETHOADON
	WHERE dbo.HOADON.SoHD=dbo.CHITIETHOADON.SoHD AND dbo.VATTU.MaVT=dbo.CHITIETHOADON.MaVT AND GiaBan>=GiaMua
)
GO

  -- CÂU 16
  CREATE VIEW KH15
  AS
  (
SELECT VATTU.MaVT,VATTU.TenVT,DVT,GiaBan,GiaMua,SoLuong,(GiaMua*SoLuong) AS[TRỊ GIÁ MUA] ,(GiaBan*SoLuong) AS[TRỊ GIÁ BÁN],KhuyenMai =CASE WHEN (SoLuong>100) THEN 0.1 ELSE 0 END 
FROM VATTU,CHITIETHOADON
WHERE VATTU.MaVT=CHITIETHOADON.MaVT
)
GO
-- CÂU 17
CREATE VIEW KH16
AS
(
SELECT *
FROM VATTU
WHERE MaVT NOT IN(
	SELECT MaVT
	FROM CHITIETHOADON
)
)
GO
-- CÂU 18
CREATE VIEW KH17
AS
(
SELECT H.SoHD,H.NgayLap,K.TenKH,K.DiaChi,K.DT,V.TenVT,V.DVT,V.GiaMua,C.GiaBan,C.SoLuong,(GiaMua*SoLuong) AS[TRỊ GIÁ MUA] ,(GiaBan*SoLuong) AS[TRỊ GIÁ BÁN] 
FROM HOADON H,KhachHang K,CHITIETHOADON C,VATTU V
WHERE H.MaKH=K.MaKH AND H.SoHD=C.SoHD AND V.MaVT=C.MaVT
)
GO


-- CÂU 19
CREATE VIEW KH18
AS
(
SELECT H.SoHD,H.NgayLap,K.TenKH,K.DiaChi,K.DT,V.TenVT,V.DVT,V.GiaMua,C.GiaBan,C.SoLuong,(GiaMua*SoLuong) AS[TRỊ GIÁ MUA] ,(GiaBan*SoLuong) AS[TRỊ GIÁ BÁN] 
FROM HOADON H,KhachHang K,CHITIETHOADON C,VATTU V
WHERE H.MaKH=K.MaKH AND H.SoHD=C.SoHD AND V.MaVT=C.MaVT AND MONTH(NgayLap)=5 AND YEAR(NgayLap)=2010
)
GO

-- CÂU 20
CREATE VIEW KH19
AS
(
SELECT H.SoHD,H.NgayLap,K.TenKH,K.DiaChi,K.DT,V.TenVT,V.DVT,V.GiaMua,C.GiaBan,C.SoLuong,(GiaMua*SoLuong) AS[TRỊ GIÁ MUA] ,(GiaBan*SoLuong) AS[TRỊ GIÁ BÁN] 
FROM HOADON H,KhachHang K,CHITIETHOADON C,VATTU V
WHERE H.MaKH=K.MaKH AND H.SoHD=C.SoHD AND V.MaVT=C.MaVT AND (MONTH(NgayLap) BETWEEN 1 AND 3) AND YEAR(NgayLap)=2010
)
GO
-- CÂU 21
CREATE VIEW KH20
AS
(
SELECT H.SoHD,NgayLap,TenKH,DiaChi,SUM(SoLuong*GiaBan) AS [TỔNG GIÁ TRỊ CỦA HÓA ĐƠN]
FROM HOADON H,KhachHang,CHITIETHOADON
WHERE H.MaKH=KhachHang.MaKH AND CHITIETHOADON.SoHD=H.SoHD
GROUP BY H.SoHD,NgayLap,TenKH,DiaChi
)
GO

-- CÂU 22
CREATE VIEW KH21
AS(
SELECT H.SoHD,NgayLap,TenKH,DiaChi,SUM(SoLuong*GiaBan) AS [TỔNG GIÁ TRỊ CỦA HÓA ĐƠN]
FROM HOADON H,KhachHang,CHITIETHOADON
WHERE H.MaKH=KhachHang.MaKH AND CHITIETHOADON.SoHD=H.SoHD 
GROUP BY H.SoHD,NgayLap,TenKH,DiaChi
HAVING SUM(SoLuong*GiaBan) >= ALL
					(SELECT SUM(SoLuong*GiaBan) AS [TỔNG GIÁ TRỊ CỦA HÓA ĐƠN]
					FROM HOADON H,KhachHang,CHITIETHOADON
					WHERE H.MaKH=KhachHang.MaKH AND CHITIETHOADON.SoHD=H.SoHD 
					GROUP BY H.SoHD,NgayLap,TenKH,DiaChi)
)
GO

-- CÂU 23
CREATE VIEW KH22
AS
(
SELECT H.SoHD,NgayLap,TenKH,DiaChi,SUM(SoLuong*GiaBan) AS [TỔNG GIÁ TRỊ CỦA HÓA ĐƠN]
FROM HOADON H,KhachHang,CHITIETHOADON
WHERE H.MaKH=KhachHang.MaKH AND CHITIETHOADON.SoHD=H.SoHD  AND MONTH(NgayLap)=5 AND YEAR(NgayLap)=2010
GROUP BY H.SoHD,NgayLap,TenKH,DiaChi
HAVING SUM(SoLuong*GiaBan) >= ALL
					(SELECT SUM(SoLuong*GiaBan) AS [TỔNG GIÁ TRỊ CỦA HÓA ĐƠN]
					FROM HOADON H,KhachHang,CHITIETHOADON
					WHERE H.MaKH=KhachHang.MaKH AND CHITIETHOADON.SoHD=H.SoHD 
					GROUP BY H.SoHD,NgayLap,TenKH,DiaChi)
)
GO

-- CÂU 24
CREATE VIEW KH23
AS
(
SELECT TenKH,KhachHang.MaKH ,COUNT(HOADON.SoHD) [SỐ HÓA ĐƠN]
FROM KhachHang,HOADON
WHERE KhachHang.MaKH=HOADON.MaKH
GROUP BY TenKH,KhachHang.MaKH
)
GO

-- CÂU 25
CREATE VIEW KH24
AS
(
SELECT TenKH,KhachHang.MaKH,MONTH(dbo.HOADON.NgayLap) AS [THÁNG] ,COUNT(HOADON.SoHD) AS [SỐ HÓA ĐƠN]
FROM KhachHang,HOADON
WHERE KhachHang.MaKH=HOADON.MaKH
GROUP BY TenKH,KhachHang.MaKH,dbo.HOADON.NgayLap
)
GO

-- CÂU 26
CREATE VIEW KH25
AS
(
SELECT TenKH,KhachHang.MaKH ,COUNT(*) [SỐ HÓA ĐƠN]
FROM KhachHang,HOADON
WHERE KhachHang.MaKH=HOADON.MaKH
GROUP BY TenKH,KhachHang.MaKH
HAVING COUNT(*) >=ALL
					(SELECT COUNT(*) [SỐ HÓA ĐƠN]
					FROM KhachHang,HOADON
					WHERE KhachHang.MaKH=HOADON.MaKH
					GROUP BY TenKH,KhachHang.MaKH)
)
GO
-- câu 27
CREATE VIEW KH26
AS
(
SELECT HOADON.MaKH,KhachHang.TenKH ,SUM(SoLuong) [SỐ LƯỢNG HÀNG]
FROM CHITIETHOADON,HOADON,KhachHang
WHERE CHITIETHOADON.SoHD=HOADON.SoHD AND KhachHang.MaKH=HOADON.MaKH
GROUP BY HOADON.MaKH,KhachHang.TenKH
HAVING SUM(SoLuong) >=ALL
					(SELECT SUM(SoLuong) [SỐ LƯỢNG HÀNG]
					FROM CHITIETHOADON,HOADON,KhachHang
					WHERE CHITIETHOADON.SoHD=HOADON.SoHD AND KhachHang.MaKH=HOADON.MaKH
					GROUP BY HOADON.MaKH,KhachHang.TenKH)
			)
			GO
-- CÂU 28
CREATE VIEW KH27
AS (
SELECT TOP 1 WITH TIES dbo.CHITIETHOADON.MaVT,TenVT,DVT,SLTON,COUNT(dbo.CHITIETHOADON.SoHD) AS [MẶT HÀNG BÁN NHIỀU NHẤT]
FROM dbo.CHITIETHOADON,dbo.VATTU
WHERE dbo.CHITIETHOADON.MaVT=dbo.VATTU.MaVT 
GROUP BY dbo.CHITIETHOADON.MaVT,TenVT,DVT,SLTON
ORDER BY COUNT(CHITIETHOADON.SoHD)
)
GO
-- CÂU 29
CREATE VIEW KH28
AS (
SELECT TOP 1 WITH TIES dbo.CHITIETHOADON.MaVT,TenVT,DVT,SLTON,SUM(dbo.CHITIETHOADON.SoLuong) AS [MẶT HÀNG BÁN NHIỀU NHẤT]
FROM dbo.CHITIETHOADON,dbo.VATTU
WHERE dbo.CHITIETHOADON.MaVT=dbo.VATTU.MaVT 
GROUP BY dbo.CHITIETHOADON.MaVT,TenVT,DVT,SLTON
ORDER BY SUM(CHITIETHOADON.SoLuong)
)
GO
-- CÂU 30
CREATE VIEW KH29
AS
(
SELECT K.MaKH,TenKH,DiaChi, 
		CASE WHEN (NOT EXISTS(SELECT MaKH FROM HOADON)) THEN 0
		ELSE(SELECT SUM(SoLuong) 
				FROM HOADON H, CHITIETHOADON C
				WHERE H.SoHD=C.SoHD AND K.MaKH=H.MaKH
				GROUP BY H.MaKH)
				END  AS [SỐ LƯỢNG MUA]
FROM KhachHang K 
)
GO
-- procedure
-- CÂU 1
CREATE PROCEDURE SP_DSKH (@NGAY INT)
AS
	BEGIN
		SELECT *
		FROM KhachHang,HOADON
		WHERE KhachHang.MaKH=HOADON.MaKH AND DAY(NgayLap)=@NGAY
	END
EXEC SP_DSKH 25
GO

-- CÂU 2
CREATE PROC SP_DH(@KH INT)
AS	
	SELECT DISTINCT MaKH
	FROM dbo.CHITIETHOADON,dbo.HOADON
	WHERE dbo.CHITIETHOADON.SoHD=dbo.HOADON.SoHD
	GROUP BY dbo.CHITIETHOADON.SoHD ,MaVT,MaKH
	HAVING SUM (GiaBan*SoLuong)>@KH
GO

EXEC dbo.SP_DH @KH = 1000000 -- int

-- CÂU 3
CREATE PROC CAU3 (@X INT)
AS
	SELECT TOP (@X) WITH TIES MaKH,SUM(GiaBan*SoLuong) AS[TỔNG TIỀN]
	FROM dbo.CHITIETHOADON,dbo.HOADON
	WHERE dbo.CHITIETHOADON.SoHD=dbo.HOADON.SoHD
	GROUP BY MaKH,dbo.CHITIETHOADON.SoHD
	ORDER BY [TỔNG TIỀN] DESC
GO
EXEC CAU3 @X =1


-- CÂU 4
CREATE PROC CAU4 (@X INT)
AS
	SELECT TOP (@X) WITH TIES MaVT,SUM(SoLuong) AS [SỐ HÀNG BÁN ĐƯỢC]
	FROM dbo.CHITIETHOADON
	GROUP BY MaVT
	ORDER BY [SỐ HÀNG BÁN ĐƯỢC] DESC
GO
EXEC CAU4 @X =2

-- CÂU 5
CREATE PROC CAU5 (@X INT)
AS
	SELECT TOP (@X) WITH TIES VATTU.MaVT,SUM((GiaBan*SoLuong)-(GiaMua*SoLuong)) AS [LÃI]
	FROM dbo.VATTU,dbo.CHITIETHOADON
	WHERE VATTU.MaVT=CHITIETHOADON.MaVT
	GROUP BY VATTU.MaVT
	ORDER BY [LÃI] ASC
GO
EXEC CAU5 @X=5
DROP PROC CAU5
--CÂU 6
CREATE PROC CAU6 (@X INT)
AS
	SELECT TOP (@X) WITH TIES HOADON.SoHD,SUM(GiaBan*SoLuong) AS[TỔNG TIỀN]
	FROM dbo.CHITIETHOADON,dbo.HOADON
	WHERE dbo.CHITIETHOADON.SoHD=dbo.HOADON.SoHD
	GROUP BY HOADON.SoHD,dbo.CHITIETHOADON.SoHD
	ORDER BY [TỔNG TIỀN] DESC
GO
EXEC CAU6 @X =3
-- CÂU 7
CREATE PROC SP_UPDATEKM
AS
	BEGIN
		SELECT SoHD,SoLuong,KhuyenMai = CASE WHEN (SoLuong>100 AND SoLuong<=500) THEN '5%' WHEN (SoLuong>500) THEN '10%' END
		FROM CHITIETHOADON
	END
EXEC SP_UPDATEKM
GO
DROP PROC SP_UPDATEKM

-- CÂU 8
CREATE PROC SP_TONGSLBAN
AS
	BEGIN
		SELECT VATTU.MaVT,TenVT,SLTON=(SLTON-SUM(SoLuong))
		FROM VATTU,CHITIETHOADON
		WHERE VATTU.MaVT=CHITIETHOADON.MaVT
		GROUP BY VATTU.MaVT,TenVT,SLTON
	END
EXEC SP_TONGSLBAN
GO
-- CÂU 9
CREATE PROC SP_TRIGIAMOIHOADON
AS
	BEGIN
		SELECT HOADON.SoHD,TongTG=(SoLuong*GiaBan)
		FROM HOADON,CHITIETHOADON
		WHERE HOADON.SoHD=CHITIETHOADON.SoHD
		GROUP BY HOADON.SoHD,TongTG,SoLuong,GiaBan
	END
EXEC SP_TRIGIAMOIHOADON
GO
USE QL_BANHANG
GO
 --CÂU 10
CREATE TABLE KH_VIP
(
	MaKH VARCHAR(5) PRIMARY KEY,
	TenKH NVARCHAR(30),
	DiaChi NVARCHAR(50),
	DT VARCHAR(11),
	Email VARCHAR(30)
)
DROP TABLE dbo.KH_VIP
 
SELECT *
FROM KH_VIP
CREATE PROC CAU10
AS
	BEGIN
		DECLARE @MaKH VARCHAR(5)
		DECLARE @TenKH NVARCHAR(30)
		DECLARE @DiaChi NVARCHAR(50)
		DECLARE @DT VARCHAR(11)
		DECLARE @Email VARCHAR(30)

		SELECT @MaKH=KHACHHANG.MaKH,@TenKH=TenKH,@DiaChi=DiaChi,@DT=DT,@Email=Email
		FROM HOADON,KhachHang,CHITIETHOADON
		WHERE HOADON.MaKH=KhachHang.MaKH AND CHITIETHOADON.SoHD = HOADON.SoHD AND TongTG>=10000000
		GROUP BY KHACHHANG.MaKH,TongTG,TenKH,DiaChi,DT,Email

		DECLARE @I INT
		SET @I=0

		INSERT INTO KH_VIP VALUES(@MaKH,@TenKH,@DiaChi,@DT,@Email) 
	END
	SELECT *
	FROM HOADON,KhachHang,CHITIETHOADON
	WHERE HOADON.MaKH=KhachHang.MaKH AND CHITIETHOADON.SoHD = HOADON.SoHD AND  TongTG>=10000000
		
	UPDATE HOADON SET TongTG = 12000000  

		SELECT MaKH,HOADON.SoHD,TongTG=(SoLuong*GiaBan)
		FROM HOADON,CHITIETHOADON
		WHERE HOADON.SoHD=CHITIETHOADON.SoHD
		GROUP BY HOADON.SoHD,TongTG,SoLuong,GiaBan,MaKH
		ORDER BY TongTG DESC
GO
DROP PROC CAU10
EXEC CAU10 
SELECT *
FROM KH_VIP
 --FUNCION
 --CÂU 1

 GO
CREATE FUNCTION [FUN_DOANHTHU_NAM](@NAM INT)
RETURNS INT
AS
 BEGIN
	RETURN
	(
		SELECT SUM(GiaBan*SoLuong) AS [TỔNG DOANH THU CỦA NĂM] 
		FROM dbo.HOADON,dbo.CHITIETHOADON
		WHERE  YEAR(NgayLap)=@NAM
	)
END
GO
DROP  FUNCTION [FUN_DOANHTHU_NAM]
SELECT dbo.FUN_DOANHTHU_NAM(2010)
-- CÂU 2
CREATE FUNCTION [FUNN_DOANHTHU_X] (@THANG INT ,@NAM INT)
RETURNS INT
AS
	BEGIN
		RETURN 
			(SELECT SUM(GiaBan*SoLuong) AS [TỔNG DOANH THU CỦA THÁNG VÀ NĂM] 
			FROM dbo.HOADON,dbo.CHITIETHOADON
			WHERE MONTH(NgayLap)=@THANG AND YEAR(NgayLap)=@NAM
			)
END
GO
SELECT dbo.FUNN_DOANHTHU_X(5 , 2010)
--CÂU 3
CREATE FUNCTION [FUN_DOANHTHU_MAKH] (@MaKH INT)
RETURNS INT
AS
	BEGIN
		RETURN
		(
			SELECT SUM(GiaBan*SoLuong) AS[DOANH THU CỦA KHÁCH HÀNG]
			FROM dbo.HOADON,dbo.CHITIETHOADON
			WHERE HOADON.MaKH=@MaKH
			)
END
GO
DROP FUNCTION FUN_DOANHTHU_MAKH
EXEC dbo.FUN_DOANHTHU_MAKH(02)

-- CÂU 4
CREATE FUNCTION fun_doanhthu_tungmathang(@MaVT INT,@THANG INT,@NAM INT)
	RETURNS INT
	AS
	BEGIN
		DECLARE @TINHTONG INT
		
			IF NOT EXISTS(
								SELECT *
								FROM HOADON
								WHERE MONTH(NgayLap) = @THANG AND YEAR(NgayLap) =@NAM
							
			)
				
								SET @TINHTONG=(SELECT SUM(SoLuong)
												FROM CHITIETHOADON )
			ELSE
				SET @TINHTONG=
				(SELECT SUM(SoLuong)
				FROM CHITIETHOADON,HOADON
				WHERE CHITIETHOADON.SoHD=HOADON.SoHD AND MONTH(NgayLap)=@THANG AND YEAR(NgayLap)=@NAM AND MaVT=@MaVT
				GROUP BY MONTH(NgayLap),YEAR(NgayLap)
				)
			RETURN @TINHTONG
		END
GO
DROP FUNCTION fun_doanhthu_tungmathang
SELECT dbo.fun_doanhthu_tungmathang(6,2010,null)

use QL_BANHANG
go
-- TRIGGER
--CÂU 1
CREATE TRIGGER cau2
ON dbo.HOADON
FOR DELETE
AS
	BEGIN
		DECLARE @COUNT INT =0
		SELECT @COUNT = COUNT(*) FROM deleted
		WHERE  


