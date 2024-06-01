create proc themDanhmuc @madm varchar(10),@tendm varchar(50)
as
begin 
insert into DanhMuc(MADM,TenDM,TrangThai) values(@madm,@tendm,1)
end

select *from DanhMuc
exec themDanhmuc 'DM005',N'Áo nam hot'
create proc xoaDanhmuc @madm varchar(10)
as
begin 
update DanhMuc
set TrangThai=0
where MADM=@madm;
end
exec xoaDanhmuc 'DM005'
create proc capnhatDanhmuc @madm varchar(10),@tendm varchar(50)
as
begin 
update DanhMuc set TenDM=@tendm where MADM=@madm;
end
exec capnhatDanhmuc 'DM001','AO nu'

CREATE PROCEDURE TimKiemDanhMucTheoTen
    @tendm NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT * 
    FROM DanhMuc 
    WHERE TenDM LIKE '%' + @tendm + '%' and TrangThai=1;
END


--phatss ssinh ma
CREATE PROCEDURE dbo.GetLastMaDanhMuc
AS
BEGIN
    SELECT TOP 1 MADM
    FROM DanhMuc
    ORDER BY MADM DESC;
END;
drop proc dbo.GetLastMaDanhMuc
delete  from DanhMuc where MADM=''
--khách hàng
create proc ThemKhachHang @makh varchar(10),@tenkh varchar(50),@sdt varchar(50), @diachi varchar(100), @email varchar(50)
as
begin 
insert into KhachHang(MaKH,Hoten,SoDT,DiaChi,Email,TrangThai) values(@makh,@tenkh,@sdt,@diachi,@email,1)
end


create proc xoaKhachHang @makh varchar(10)
as
begin 
update KhachHang
set TrangThai=0
where MaKH=@makh;
end

create proc capnhatKhachHang @makh varchar(10),@tenkh varchar(50),@sdt varchar(50), @diachi varchar(100), @email varchar(50)
as
begin 
update KhachHang set Hoten=@tenkh,SoDT=@sdt,DiaChi=@diachi,Email=@email where MaKH=@makh;
end


CREATE PROCEDURE timKiemKhachHangTheoMa
    @makh NVARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT * 
    FROM KhachHang
    WHERE MaKH =@makh and TrangThai=1;
END


--phatss ssinh ma
CREATE PROCEDURE dbo.GetLastMakh
AS
BEGIN
    SELECT TOP 1 MaKH
    FROM KhachHang
    ORDER BY MaKH DESC;
END;
drop proc dbo.GetLastMakh
--Nhà Cung Cấp
create proc themNCC @mancc varchar(10),@tenncc varchar(50)
as
begin 
insert into NHACUNGCAP(MaNCC,TenNCC,TrangThai) values(@mancc,@tenncc,1)
end
go
exec themNCC 'NCC4',N'Đại Lis Binh Thường'

create proc xoaNcc @mancc varchar(10)
as
begin 
update NHACUNGCAP
set TrangThai=0
where MaNCC=@mancc;
end
go

create proc capnhatNcc @mancc varchar(10),@tenncc varchar(50)
as
begin 
update NHACUNGCAP set TenNCC=@tenncc where MaNCC=@mancc;
end


CREATE PROCEDURE TimKiemNCCTheoTen
    @tenncc NVARCHAR(50)
AS
BEGIN

    SET NOCOUNT ON;
    
    SELECT * 
    FROM NHACUNGCAP 
    WHERE TenNCC LIKE '%' + @tenncc + '%' and TrangThai=1;
END
go
CREATE PROCEDURE dbo.GetLastMancc
AS
BEGIN
    SELECT TOP 1 MaNCC
    FROM NHACUNGCAP
    ORDER BY MaNCC DESC;
END;
select *from NHACUNGCAP
drop proc GetLastMaDanhMuc
drop proc GetLastMakh
drop proc GetLastMancc

--Bán hàng
CREATE PROCEDURE dbo.GetMHD
AS
BEGIN
    SELECT TOP 1 MaHD
    FROM HoaDon
    ORDER BY MaHD DESC;
END;
CREATE PROCEDURE TimKiemKHTheoSDT
    @SDT NVARCHAR(50)
AS
BEGIN

    SET NOCOUNT ON;
    
    SELECT *
    FROM  KhachHang
    WHERE SoDT=@SDT and TrangThai=1;
END
go
select *From HoaDon
create proc GetMaHD
as
begin
if((select count(*)from HoaDon)=0)
	select 'HD0000' MaHD
	else
	select top 1 MaHD from HoaDon order by MaHD desc
end
select *from HoaDon

--tao hoa don
create proc TaoHoaDon @maHd varchar(50), @maNv varchar(50), @maKh varchar(50),@ngayban datetime, @TongGT decimal
as
begin
Insert into HoaDon(MaHD,MaNV,MaKH,NgayBanHang,TongGT,TrangThai) values(@maHd,@maNv,@maKh,@ngayban,@TongGT,1)
end
go
EXEC TaoHoaDon 'HD000', 'NV001', 'KH001', '2024-05-25' , 0
select *from NhanVien
select *from ChiTietHoaDon
 
 ---chitiethoadon
 create proc ThemChiTietHoaDon @maSp varchar(50), @maHd varchar(50), @soluong int,@gia decimal
as
begin
Insert into ChiTietHoaDon(MaSp,MaHD,SoLuong,Gia,TrangThai) values(@maSp,@maHd,@soluong,@gia,1)
end
go

alter table sanpham
add hinh varchar(100)

update SanPham
set hinh='ASP03.jpg'
where MaSp='SP003'

update SanPham
set MaNCC='NCC3'
where MaSp='SP003'
select *from NHACUNGCAP

--sanpham
CREATE PROCEDURE dbo.GetLastMasp
AS
BEGIN
    SELECT TOP 1 MaSp
    FROM SanPham
    ORDER BY MaSp DESC;
END;
select *from SanPham
create proc ThemSanPham 
@masp varchar(10),@mancc varchar(10), @madm varchar(10),@tensp varchar(50),@mota varchar(100),@hinh varchar(50) 
as
begin 
insert into SanPham(MaSp,MaNCC,MADM,TenSp,MoTa,hinh,TrangThai) values(@masp,@mancc,@madm,@tensp,@mota,@hinh,1)
end
go
EXEC ThemSanPham 
    @masp = 'SP004', 
    @mancc = 'NCC1', 
    @madm = 'DM001', 
    @tensp = 'San Pham 1', 
    @mota = 'Mo ta san pham 1', 
    @hinh = 'hinh1.jpg'
select *from DanhMuc
select *from SanPham
select *from NHACUNGCAP


create proc xoaSanPham @masp varchar(10)
as
begin
update SanPham
set TrangThai=0
where MaSp=@masp
end

create proc capnhatSanpham  @masp varchar(10), @tensanpham varchar(50), @giaban decimal,@mota varchar(50), @maNCC varchar(10), @maDm varchar(10), @hinh varchar(50)
as
begin
update SanPham 
set TenSp=@tensanpham,GiaBan=@giaban,MoTa=@mota, MADM=@maDm, MaNCC=@maNCC, hinh=@hinh
where MADM=@madm
end




