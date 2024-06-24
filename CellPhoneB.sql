CREATE DATABASE CellPhoneB;
GO
-- Sử dụng cơ sở dữ liệu CellPhoneB
USE CellPhoneB;
GO

-- Tạo bảng tbl_User
CREATE TABLE tbl_User
(
   userId VARCHAR(20) primary key NOT NULL,
   password VARCHAR(20) NOT NULL,
   fullName VARCHAR(50) NOT NULL,
   role VARCHAR(10) not null,
   phoneNumber varchar(20) not null,
   address VARCHAR(50) NOT NULL,
   email VARCHAR(50) NOT NULL
)
select * from tbl_User
insert into tbl_User values ('admin','123','Admin','AD','0905024174','TpHCM','binhnptse181532@fpt.edu.vn');
insert into tbl_User values ('binh','123',N'Thanh Bình','AD','0948182978','TpHCM','nptbinh17092004@gmail.com');
insert into tbl_User values ('vietcute','1','Viet','US','0915002142','TpHCM','vietngu@gmail.com');
insert into tbl_User values ('thinh','1','Thinh','US','0921341242','TpHCM','thinh@gmail.com');
insert into tbl_User values ('tb','1','Binhdaynee','US','0948182978','TpHCM','nptbinh17092004@gmail.com');
insert into tbl_User values ('mixi','1','Mixigaming','US','0922343232','TpHCM','mixigaming@gmail.com');
insert into tbl_User values ('cocvang','1','Cóc vàng SU24 ','US','0946162231','TpHCM','cocvangsu24@gmail.com');
-- Tạo bảng tbl_Product
create table tbl_Product	
(
   productId varchar(10) primary key not null ,
   image varchar(max) not null,
   brand varchar(20) not null,
   productName varchar(200) not null,
   price float not null,
   description nvarchar(250) not null,
   yearOfProduction int,
   quantity int,
   notSale int,
   discount int,
)
select * from tbl_Product

-- Tạo bảng tbl_Order
create table tbl_Order
(
  orderId int not null primary key,
  userId varchar(20) not null ,
  totalPrice float not null,
  orderDate varchar(50) not null,
  status int not null,
  CONSTRAINT PR_userId_O FOREIGN KEY(userId) REFERENCES tbl_User(userId),
)
select * from tbl_Order
-- Tạo bảng tbl_OrderDetail
create table tbl_OrderDetail
(
   orderId int not null,
   productId varchar(10) not null,
   quantity int not null,
   price float not null
   CONSTRAINT PK_orderId_mobileId PRIMARY KEY (orderId, productId),
   CONSTRAINT PR_orderId_OD FOREIGN KEY(orderId) REFERENCES tbl_Order(orderId),
   CONSTRAINT PR_productId_OD FOREIGN KEY(productId) REFERENCES tbl_Product(productId)
)  
select * from tbl_OrderDetail
-- Tạo bảng tbl_WishList
create table tbl_WishList
(
   userId varchar(20) not null,
   productId varchar(10) not null,
   CONSTRAINT PK_userId_productId PRIMARY KEY (userId, productId),
   CONSTRAINT PR_userId_WL FOREIGN KEY(userId) REFERENCES tbl_User(userId),
   CONSTRAINT PR_productId_WL FOREIGN KEY(productId) REFERENCES tbl_Product(productId)
)
select * from tbl_WishList
-- Tạo bảng tbl_Invoice
create table tbl_Invoice
(
  invoiceId nvarchar(20) not null,
  userId VARCHAR(20) NOT NULL,
  orderId int not null,
  fullName nvarchar(50) not null,
  email nvarchar(50) not null,
  phone nvarchar(50) not null,
  address nvarchar(50) not null,
  date varchar(50) not null,
  totalPrice float not null,
  methodPayment varchar(50) not null,
  CONSTRAINT PR_userId_I FOREIGN KEY(userId) REFERENCES tbl_User(userId),
  CONSTRAINT PR_orderId_I FOREIGN KEY(orderId) REFERENCES tbl_Order(orderId),
) 

select * from tbl_Invoice

	CREATE PROCEDURE UpdateProductQuantity
		@ProductID varchar(10),
		@Quantity INT
	AS
	BEGIN
		SET NOCOUNT ON;

		DECLARE @CurrentQuantity INT;

		-- Kiểm tra số lượng hiện tại của sản phẩm
		SELECT @CurrentQuantity = Quantity
		FROM tbl_Product
		WHERE productId = @ProductID;

		-- Kiểm tra nếu số lượng hiện tại đủ để thực hiện giao dịch
		IF @CurrentQuantity >= @Quantity
		BEGIN
			-- Cập nhật số lượng sản phẩm
			UPDATE tbl_Product
			SET quantity = quantity - @Quantity
			WHERE productId = @ProductID;

			IF (SELECT quantity FROM tbl_Product WHERE productId = @ProductID) = 0
            BEGIN
            UPDATE tbl_Product
            SET notSale = 2
            WHERE productId = @ProductID;
        END
		END
		ELSE
		BEGIN
			PRINT 'Giao dịch thất bại. Số lượng sản phẩm không đủ.';
		END
	END

select * from tbl_Product
insert into tbl_Product values ('MOB001','img/mobile/ip15.jpg','Iphone','Iphone 15',20000000,N'128GB | Chính hãng VN/A',2023,40,0,0);
insert into tbl_Product values ('MOB002','img/mobile/ip15pm.jpg','Iphone','iPhone 15 Pro Max',40000000,N'256GB | Chính hãng VN/A',2023,20,0,0);
insert into tbl_Product values ('MOB003','img/mobile/ip14pm.jpg','Iphone','Iphone 14 Pro Max',30000000,N'128GB | Chính hãng VN/A',2022,40,0,0);
insert into tbl_Product values ('MOB004','img/mobile/ssgm14.jpg','Samsung','Samsung Galaxy M14',5000000,N'5G 4GB 128GB',2024,15,0,0);
insert into tbl_Product values ('MOB005','img/mobile/ip15plus.jpg','Iphone','iPhone 15 Plus',25000000,N'256GB | Chính hãng VN/A',2023,20,0,10);
insert into tbl_Product values ('MOB006','img/mobile/ip11.jpg','Iphone','iPhone 11',6000000,N'128GB | Chính hãng VN/A',2019,20,0,0);
insert into tbl_Product values ('MOB007','img/mobile/sszplod5.jpg','Samsung','Samsung Galaxy Z Flod5',30000000,N'12GB 256GB',2023,10,0,0);
insert into tbl_Product values ('MOB008','img/mobile/ip13.jpg','Iphone','iPhone 13',12000000,N'128GB | Chính hãng VN/A',2021,20,0,5);
insert into tbl_Product values ('MOB009','img/mobile/ss24ultra.jpg','Samsung','Samsung Galaxy S24 Ultra',24000000,N'12GB 256GB',2024,5,0,0);
insert into tbl_Product values ('MOB010','img/mobile/ssga05.jpg','Samsung','Samsung Galaxy A05',3000000,N'4GB 128GB',2024,8,0,0);
insert into tbl_Product values ('MOB011','img/mobile/sszflip5.jpg','Samsung','Samsung Galaxy Z Flip5',3000000,N'4GB 128GB',2024,8,0,5);
insert into tbl_Product values ('MOB012','img/mobile/ssga54.jpg','Samsung','Samsung Galaxy A54',9000000,N'5G 8GB 128GB',2024,8,0,10);
insert into tbl_Product values ('MOB013','img/mobile/ip15pro.jpg','Iphone','iPhone 15 Pro ',34000000,N'512GB | Chính hãng VN/A',2024,20,0,5);
insert into tbl_Product values ('MOB014','img/mobile/ip14.jpg','Iphone','iPhone 14',17000000,N'128GB | Chính hãng VN/A',2023,20,0,5);
insert into tbl_Product values ('MOB015','img/mobile/ip14pro.jpg','Iphone','iPhone 14 Pro',27000000,N'256GB | Chính hãng VN/A',2023,7,0,0);
insert into tbl_Product values ('MOB016','img/mobile/xiaomin13pro.jpg','Xiaomi','Xiaomi Redmi Note 13 Pro',7000000,N'8GB 128GB',2023,12,0,5);
insert into tbl_Product values ('MOB017','img/mobile/xiaomi14ultra.jpg','Xiaomi','Xiaomi 14 Ultra 5G',30000000,N'16GB 512GB',2023,7,0,0);
insert into tbl_Product values ('MOB018','img/mobile/xiaomipocox6p.jpg','Xiaomi','Xiaomi POCO X6 Pro 5G',8000000,N'8GB 256GB - Chỉ có tại CellphoneB',2022,10,0,0);
insert into tbl_Product values ('MOB019','img/mobile/xiaomi13Tpro.jpg','Xiaomi','Xiaomi 13T Pro 5G',15000000,N'16GB 512GB - Chỉ có tại CellphoneB',2023,7,0,6);
insert into tbl_Product values ('MOB020','img/mobile/xiaomin12pro.jpg','Xiaomi','Xiaomi Redmi Note 12 Pro 5G',7000000,N'8GB 256GB',2023,8,0,0);
insert into tbl_Product values ('MOB021','img/mobile/asusrog6.jpg','Asus','ASUS ROG Phone 6',18000000,N'16GB 512GB - Chỉ có tại CellphoneB',2023,8,0,5);
insert into tbl_Product values ('MOB022','img/mobile/asusrog7.jpg','Asus','ASUS ROG Phone 7 Ultimate',30000000,N'16GB 512GB - Chỉ có tại CellphoneB',2023,8,0,10);
insert into tbl_Product values ('MOB023','img/mobile/oppofindx5pro.jpg','Oppo','OPPO Find X5 Pro',20000000,N'12GB 256GB - Chỉ có tại CellphoneB',2022,8,0,10);
insert into tbl_Product values ('MOB024','img/mobile/ssgs23.jpg','Samsung','Samsung Galaxy S23',20000000,N'8GB 128GB - Chỉ có tại CellphoneB',2023,8,0,20);
insert into tbl_Product values ('MOB025','img/mobile/opporeno11f.jpg','Oppo','OPPO Reno11 F',8500000,N'5G 8GB 256GB',2024,8,0,0);
insert into tbl_Product values ('MOB026','img/mobile/oppofindn3.jpg','Oppo','OPPO Find N3',42000000,N'16GB 512GB',2024,5,0,10);
insert into tbl_Product values ('MOB027','img/mobile/oppoa77s.jpg','Oppo','OPPO A77s ',6000000,N'8GB 128GB',2022,4,0,12);
insert into tbl_Product values ('MOB028','img/mobile/opporeno10.jpg','Oppo','OPPO Reno10 ',7500000,N'8GB 128GB',2023,9,0,0);
insert into tbl_Product values ('MOB029','img/mobile/oppoa18.jpg','Oppo','OPPO A18',4000000,N'4GB 128GB',2023,8,0,10);
insert into tbl_Product values ('MOB030','img/mobile/opporeno10plus.jpg','Oppo','OPPO Reno10 Pro Plus 5G',20000000,N'12GB 256GB',2023,12,0,10);
insert into tbl_Product values ('MOB031','img/mobile/ip12prm.jpg','Iphone','iPhone 12 Pro Max',23000000,N'128GB | Chính hãng VN/A',2021,10,0,5);
insert into tbl_Product values ('MOB032','img/mobile/ip12.jpg','Iphone','iPhone 12',12000000,N'64GB | Chính hãng VN/A',2021,10,0,12);
insert into tbl_Product values ('MOB033','img/mobile/ip13pro.jpg','Iphone','iPhone 13 Pro',24000000,N' 256GB | Chính hãng VN/A',2022,4,0,0);
insert into tbl_Product values ('MOB034','img/mobile/ip13prm.jpg','Iphone','iPhone 13 Pro Max',25000000,N'128GB | Chính hãng VN/A',2022,2,0,0);
insert into tbl_Product values ('MOB035','img/mobile/ip14plus.jpg','Iphone','iPhone 14 Plus',24000000,N'256GB | Chính hãng VN/A',2023,10,0,5);
insert into tbl_Product values ('MOB036','img/mobile/realmec67.jpg','Realme','realme C67',5000000,N'8GB 128GB',2023,10,0,0);
insert into tbl_Product values ('MOB037','img/mobile/realmec33.jpg','Realme','realme C33',2500000,N'4GB 64GB',2022,4,0,0);
insert into tbl_Product values ('MOB038','img/mobile/realme10plus.jpg','Realme','realme 10 Pro Plus',5000000,N'6GB 64GB',2023,10,1,0);
insert into tbl_Product values ('MOB039','img/mobile/realmec30s.jpg','Realme','realme C30s',2000000,N'2GB 32GB',2022,2,0,0);
insert into tbl_Product values ('MOB040','img/mobile/realme11pro.jpg','Realme','realme 11 Pro',9500000,N'8GB - 256GB',2023,7,0,0);




