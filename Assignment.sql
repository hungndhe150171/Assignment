create database Store_Assignment3
use Store_Assignment

select UserName, Password,role, c.CustomerID from Account a left outer join Customer c ON a.CustomerID = c.CustomerID
select * from Account
CREATE TABLE Account (
	UserName varchar(50) PRIMARY KEY,
	[Password] varchar(100) NOT NULL,
	[role] int default 1,
	CustomerID INT,
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
)
insert into Account(UserName, [Password], role) values('admin', 'admin', 0)

CREATE TABLE Category (
    CategoryID INT IDENTITY PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL
);

CREATE TABLE Customer (
    CustomerID INT IDENTITY PRIMARY KEY,
    FirstName NVARCHAR(255) NOT NULL,
    LastName NVARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Address NVARCHAR(255) NOT NULL,
	Gender Nvarchar(10) NOT NULL,
	--UserName varchar(50),
    --FOREIGN KEY (UserName) REFERENCES Account(UserName)
)


DBCC CHECKIDENT ('Product', RESEED, 47);


CREATE TABLE Product (
    ProductID INT IDENTITY PRIMARY KEY,
    ProductName NVARCHAR(255) NOT NULL,
    CategoryID INT,
	Quantity INT DEFAULT 0,
	Sale DECIMAL(10, 2),
    Price float NOT NULL,
	Image VARCHAR(255) NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);


SELECT MONTH(o.OrderDate) AS Month, SUM(od.Quantity * od.Price) AS MonthlyRevenue
FROM  [Order] o INNER JOIN   OrderDetail od ON o.OrderID = od.OrderID GROUP BY  YEAR(o.OrderDate), MONTH(o.OrderDate)
ORDER BY  Month;


select * from [Order]
select * from Product
select * from OrderDetail
select * from Customer
select * from Cart
select * from Account 


CREATE TABLE [Order] (
    OrderID INT IDENTITY PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE OrderDetail (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES [Order](OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);



CREATE TABLE Cart (
    CartId INT IDENTITY PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE CartItem (
    CartId INT,
    ProductID INT,
    Quantity INT,
	Price float,
    FOREIGN KEY (CartId) REFERENCES Cart(CartId) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);


select * from Product

select * from CartItem
select * from Cart


CREATE TRIGGER trgUpdateProductQuantity
ON OrderDetail
AFTER INSERT
AS
BEGIN
    DECLARE @ProductID INT;
    DECLARE @Quantity INT;

    SELECT @ProductID = ProductID, @Quantity = Quantity
    FROM inserted;

    UPDATE Product
    SET Quantity = Quantity - @Quantity
    WHERE ProductID = @ProductID;
END;



insert into Account values ('admin', 'admin', 0)
insert into Account values ('admin1', 'admin1', 0)




INSERT INTO Category (CategoryName) VALUES
    ('Phone'),
    ('Watche'),
    ('Laptop');

	INSERT INTO Category (CategoryName) VALUES
    ('Headphone')



INSERT INTO Product (ProductName, CategoryID, Price, Image, Quality, Sale) VALUES
    (N'Điện thoại Samsung Galaxy S21 FE 5G (6GB/128GB) ', 1, 12990000, 'https://sieuthismartphone.com/data/product/urr1642733987.jpg', 98, 0.13),
    (N'Laptop Asus Gaming ROG Strix G15 G513IH R7 4800H/8GB/512GB/4GB GTX1650/144Hz/Win11 (HN015W)', 3, 16490000, 'https://cdn.tgdd.vn/Products/Images/44/270031/asus-rog-strix-gaming-g513ih-r7-4800h-8gb-512gb-4gb-600x600.jpg', 97, 0.05),
    (N'Đồng hồ thông minh Apple Watch SE 2023 GPS 40mm viền nhôm dây thể thao ', 2, 6390000, 'https://cdn.tgdd.vn/Products/Images/7077/316007/apple-watch-se-2023-40mm-vien-nhom-day-silicone-xanh-duong-thumb-1-600x600.jpg', 99, 0.00);
INSERT INTO Product (ProductName, CategoryID, Price, Image, Quality, Sale) VALUES
(N'Điện thoại iPhone 15 Pro Max 256GB', 1, 31690000, 'https://minhtuanmobile.com/uploads/products/iphone-15-pro-max-blue-1-230913060803.png', 40, 0.05)

INSERT INTO Product (ProductName, CategoryID, Price, Image, Quality, Sale) VALUES
(N'Điện thoại iPhone 11 64GB', 1, 9990000, 'https://cdn11.dienmaycholon.vn/filewebdmclnew/DMCL21/Picture//Apro/Apro_product_30815/iphone-11-64gb-_main_638_1020.png.webp', 70, 0.015),
(N'Laptop Acer TravelMate P4 TMP414 51 50HX i5 1135G7/8GB/512GB/Win11 (NX.VP2SV.00T) ', 3, 11990000, 'https://cdn.tgdd.vn/Products/Images/44/314232/acer-travelmate-p4-tmp414-51-50hx-i5-nxvp2sv00t-010923-010324-600x600.jpg', 60, 0.00),
(N'Đồng hồ thông minh BeFit WatchFit 46.7mm', 2, 890000, 'https://cdn.tgdd.vn/Products/Images/7077/306530/befit-watch-fit-vang-tn-600x600.jpg',60, 0.39),
(N'Đồng hồ Casio 42 mm Nam AE-1200WH-1AVDF ', 2, 1140000, 'https://cdn.tgdd.vn/Products/Images/7264/199493/casio-ae-1200wh-1avdf-den-nt-600x600.jpg',50, 0.40);


INSERT INTO Product (ProductName, CategoryID, Price, Image, Quality, Sale) VALUES
('IPhone 13 Pro Max', 1, 42990000, 'https://cdn-v2.didongviet.vn/files/products/2023/3/26/1/1682495538648_iphone_13_pro_max_xanh_duong_didongviet.jpg', 50, 0.05),
('MacBook Pro 16-inch', 3, 79990000, 'https://product.hstatic.net/1000259254/product/macbook_pro_16-inch-gray_ab699ab2532f49da839855f30b344bec_master.jpg', 30, 0),
('Apple Watch Series 7', 2, 12490000, 'https://bizweb.dktcdn.net/100/442/323/products/4fa867f8-d3b2-4b67-8765-7a1b14f15776-0e821000-1d5b-443f-822b-60644d77f3a8.jpg?v=1685698465313', 25, 0.03),
('IPhone 13 Pro', 1, 37990000, 'https://bizweb.dktcdn.net/thumb/grande/100/398/430/products/iphone-13-pro-128gb-chinh-hang-vna-5-jpeg.jpg?v=1660806257760', 40, 0),
('MacBook Pro 14-inch (M1 Pro/M1 Max)', 3, 64990000, 'https://product.hstatic.net/200000348419/product/macbook_pro_14_inch_m1_2021_gray_0_29bd5446ffb94552a1a5f5ea7a1fe28e_master.png', 35, 0.02),
('Apple Watch SE', 2, 7490000, 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/MT3D3ref_VW_34FR+watch-case-44-aluminum-midnight-nc-se_VW_34FR+watch-face-44-aluminum-midnight-se_VW_34FR?wid=2000&hei=2000&fmt=png-alpha&.v=1694507496485', 20, 0.04),
('IPhone 13', 1, 31990000, 'https://cdn.viettelstore.vn/Images/Product/ProductImage/1931234010.jpeg', 45, 0),
('MacBook Pro 13-inch (M1)', 3, 49990000, 'https://phongvu.vn/cong-nghe/wp-content/uploads/sites/2/2020/12/MacBook-Pro-13-M1-phong-vu-1.jpg', 28, 0.01),
('Apple Watch Series 6', 2, 10490000, 'https://cdn.viettelstore.vn/Images/Product/ProductImage/1174747871.jpeg', 22, 0),
('IPhone SE (2020)', 1, 15990000, 'https://zshop.vn/images/detailed/54/iphone-se-gallery6.jpg', 55, 0.06);


INSERT INTO Product (ProductName, CategoryID, Price, Image, Quality, Sale) VALUES
('Sony WH-1000XM4', 4, 3499000, 'https://www.sony.com.vn/image/5d02da5df552836db894cead8a68f5f3?fmt=pjpeg&wid=330&bgcolor=FFFFFF&bgc=FFFFFF', 100, 0.1),
('Bose QuietComfort 45', 4, 2999000, 'https://product.hstatic.net/200000409445/product/qc-45-trang-0.2_a5390bdcd29c40c9b3271e27acb95d02_master.jpg', 90, 0.05),
('Apple AirPods Pro', 4, 3499000, 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/MTJV3?wid=1144&hei=1144&fmt=jpeg&qlt=90&.v=1694014871985', 80, 0.07),
('Samsung Galaxy Buds Pro', 4, 2799000, 'https://vn-live-01.slatic.net/p/5e7c751b17b4c4af41b1f5059d679e9d.jpg', 70, 0.03),
('Jabra Elite 85t', 4, 2799000, 'https://cdn.tgdd.vn/Products/Images/54/232918/bluetooth-true-wireless-jabra-elite-85t-d-1-org.jpg', 85, 0.09),
('Sony WF-1000XM4', 4, 2999000, 'https://tainghetot.com/wp-content/uploads/2021/06/P1220334.jpg', 75, 0.06),
('Sennheiser Momentum True Wireless 2', 4, 3499000, 'https://songlongmedia.com/media/product/2253_tai_nghe_sennheiser_momentum_true_wireless_2_songlongmedia__4_.jpg', 65, 0.08),
('Beats Studio Buds', 4, 2499000, 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/MQLH3?wid=1144&hei=1144&fmt=jpeg&qlt=90&.v=1682361480584', 60, 0.04),
('JBL Free X', 4, 1999000, 'https://vn.jbl.com/on/demandware.static/-/Sites-masterCatalog_Harman/default/dwfe1a3d59/JBL_FREEx_Hero_Black.png', 55, 0.02),
('Skullcandy Indy Evo', 4, 1799000, 'https://songlongmedia.com/media/product/2416_tai_nghe_true_wireless_skullcandy_indy_evo_true_black_songlongmedia__1_.jpg', 50, 0.01),
('Samsung Galaxy S21 Ultra 256GB', 1, 25990000, 'https://clickbuy.com.vn/uploads/images/2022/02/avt-galaxy-S21-ultra-silver.png', 30, 0.05),
('Xiaomi Redmi Note 11 Pro 128GB', 1, 8990000, 'https://images.fpt.shop/unsafe/fit-in/585x390/filters:quality(5):fill(white)/fptshop.com.vn/Uploads/Originals/2022/2/14/637804673212874594_2.xiaomi-redmi-note-11-pro-4g-trang-4.jpg', 25, 0),
('OnePlus 9 Pro 256GB', 1, 28990000, 'https://oasis.opstatics.com/content/dam/oasis/page/2021/9-series/spec-image/9-pro/Stellar%20Black-gallery..png', 20, 0.03),
('Google Pixel 6 128GB', 1, 15990000, 'https://mobileworld.com.vn/uploads/product/05_2021/google-pixel-6-quoc-te-128gb-moi-fullbox-den.jpg', 35, 0),
('Oppo Find X5 Pro 256GB', 1, 31990000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/425/302/products/9faf757b-c00c-48d9-91c9-856fd69ae3ff.jpg?v=1684467832257', 22, 0.02),
('Vivo X70 Pro+ 256GB', 1, 27990000, 'https://cdn.tgdd.vn/Products/Images/42/236978/vivo-x70-pro-plus-1-600x600.jpg', 28, 0.04),
('Realme GT 2 Pro 256GB', 1, 21990000, 'https://dienthoaihay.vn/images/products/2022/01/25/original/blue_1643092848.jpg.jpg', 32, 0),
('Sony Xperia 1 III 256GB', 1, 29990000, 'https://viostore.vn/wp-content/uploads/2023/07/sony-xperia-1-ii-600x600-600x600_1665560671_1681805055.jpg', 18, 0),
('Huawei P50 Pro 256GB', 1, 34990000, 'https://lequanmobile.com/wp-content/uploads/2023/09/P50-PRO-JULIN-WHITE-.png', 24, 0.06),
('Motorola Edge 30 Pro 256GB', 1, 23990000, 'https://motorolaroe.vtexassets.com/arquivos/ids/156744/motorola-edge30-pro-pdp-render-Stardust-3-8p1zhqcj.png?v=637810603612630000', 27, 0.01),
('Sony WH-1000XM3', 4, 2999000, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/2/0/2068_tai_nghe_bluetooth_sony_wh_1000xm3__5__1_1.jpg', 105, 0.12),
('Bose SoundSport Free', 4, 2499000, 'https://binhminhdigital.com/storedata/images/product/hop-sac-tai-nghe-bose-soundsport-free(3).jpg', 95, 0.08),
('Apple AirPods (3rd generation)', 4, 2699000, 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/MME73?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1632861342000', 85, 0.1),
('Samsung Galaxy Buds Live', 4, 2299000, 'https://samcenter.vn/images/thumbs/0001590_galaxy-buds-live.jpeg', 80, 0.07),
('Jabra Elite 75t', 4, 2299000, 'https://tainghetot.com/wp-content/uploads/2020/10/jabra-elite-75t-tnt-audio-2.jpg', 75, 0.05),
('Sony WF-XB700', 4, 1999000, 'https://tongkhonhaccu.com/Data/upload/images/Product/Tai%20nghe/Sony/WF-XB700/tai-nghe-bluetooth-sony-wf-xb700-gia-re.jpgg', 70, 0.04),
('Sennheiser CX 400BT True Wireless', 4, 1999000, 'https://antuan.vn/public/uploads/2021/08/tai-nghe-sennheiser-cx-400bt-1.jpg', 65, 0.03),
('Beats Flex', 4, 1499000, 'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/MYME2_AV3?wid=1144&hei=1144&fmt=jpeg&qlt=90&.v=1601053175000', 60, 0.02),
('JBL Tune 125TWS', 4, 1499000, 'https://image.anhducdigital.vn/di-dong/tai-nghe/tai-nghe-earphone/jbl/jbl-tune-125tws/1-500x500.jpg', 55, 0.01),

DBCC CHECKIDENT ('Product', RESEED, 47);


INSERT INTO Product (ProductName, CategoryID, Price, Image, Quantity, Sale) VALUES('Skullcandy Sesh Evo', 4, 1199000, 'https://tainghe.com.vn/media/product/3262_2.jpg', 50, 0)
;



select * from Product
ALTER TABLE Product
ADD Description NVARCHAR(MAX);

UPDATE Product
SET Description = N'Mô tả: Điện thoại Samsung Galaxy S21 FE 5G là một trong những sản phẩm đáng chú ý của Samsung, với khả năng kết nối 5G, RAM 6GB và bộ nhớ trong 128GB, đảm bảo hiệu suất mượt mà và lưu trữ đa nhiệm tốt. Thiết kế sang trọng, màn hình lớn và camera chất lượng, đây là một lựa chọn hàng đầu cho người dùng hiện đại.'
WHERE ProductID = 1;

UPDATE Product
SET Description = 
    CASE 
        WHEN ProductID = 2 THEN N'Mô tả: Laptop Asus Gaming ROG Strix G15 G513IH R7 4800H/8GB/512GB/4GB GTX1650/144Hz/Win11 là một sản phẩm mạnh mẽ dành cho game thủ với bộ vi xử lý AMD Ryzen 7 4800H, RAM 8GB và ổ cứng SSD 512GB, cùng với card đồ họa NVIDIA GTX1650 4GB. Màn hình 144Hz cung cấp trải nghiệm chơi game mượt mà và chân thực, là sự lựa chọn hoàn hảo cho những người yêu thích game.'
        WHEN ProductID = 3 THEN N'Mô tả: Đồng hồ thông minh Apple Watch SE 2023 GPS 40mm viền nhôm dây thể thao là một chiếc smartwatch đa năng của Apple, tích hợp GPS, thiết kế nhỏ gọn với viền nhôm và dây đeo thể thao. Sản phẩm này cung cấp nhiều tính năng sức khỏe và thể dục, bao gồm đo nhịp tim, theo dõi hoạt động và ngủ, cùng với khả năng kết nối và kiểm soát các thiết bị Apple khác. Đồng hồ thông minh này là một trợ thủ đắc lực cho mọi hoạt động hàng ngày.'
        WHEN ProductID = 4 THEN N'Mô tả: Điện thoại iPhone 15 Pro Max 256GB là một trong những chiếc điện thoại cao cấp nhất của Apple, với bộ nhớ trong lớn 256GB, camera chất lượng cao và hiệu suất mạnh mẽ. Thiết kế sang trọng và tính năng độc quyền của iOS, sản phẩm này mang lại trải nghiệm sử dụng đỉnh cao cho người dùng.'
        WHEN ProductID = 5 THEN N'Mô tả: Điện thoại iPhone 11 64GB với bộ nhớ trong 64GB, camera kép chất lượng cao và hiệu suất ổn định, là một trong những chiếc điện thoại phổ biến của Apple. Thiết kế hiện đại, màn hình Retina và tính năng tiện ích của iOS, sản phẩm này đáp ứng đầy đủ nhu cầu của người dùng hiện đại.'
        WHEN ProductID = 6 THEN N'Mô tả: Laptop Acer TravelMate P4 TMP414 51 50HX i5 1135G7/8GB/512GB/Win11 là một sản phẩm chất lượng với bộ vi xử lý Intel Core i5 1135G7, RAM 8GB và ổ cứng SSD 512GB. Thiết kế nhỏ gọn, màn hình chất lượng và tính di động cao, là sự lựa chọn tốt cho người dùng doanh nhân và sinh viên.'
        WHEN ProductID = 7 THEN N'Mô tả: Đồng hồ thông minh BeFit WatchFit 46.7mm là một chiếc smartwatch đa chức năng với thiết kế thời trang và tính năng đo sức khỏe toàn diện. Đồng hồ này cung cấp các tính năng như đo nhịp tim, theo dõi hoạt động và giấc ngủ, cùng với khả năng kết nối Bluetooth với điện thoại di động.'
        WHEN ProductID = 8 THEN N'Mô tả: Đồng hồ Casio 42 mm Nam AE-1200WH-1AVDF là một sản phẩm đơn giản và thực dụng, với thiết kế chắc chắn và tính năng đa dạng. Đồng hồ này có các tính năng như đồng hồ thế giới, đèn LED, báo thức và thời gian đồng hồ kỹ thuật số. Là một lựa chọn tốt cho những người yêu thích phong cách thể thao và năng động.'
        WHEN ProductID = 9 THEN N'Mô tả: IPhone 13 Pro Max là một trong những sản phẩm cao cấp nhất của Apple, với bộ nhớ trong lớn, camera chất lượng cao và hiệu suất mạnh mẽ. Thiết kế sang trọng và tính năng độc quyền của iOS, sản phẩm này mang lại trải nghiệm sử dụng đỉnh cao cho người dùng.'
        WHEN ProductID = 10 THEN N'Mô tả: MacBook Pro 16-inch là một trong những laptop mạnh mẽ nhất của Apple, với màn hình lớn, hiệu suất cao và tính di động tốt. Thiết kế sang trọng và hệ điều hành macOS, sản phẩm này thích hợp cho các tác vụ sáng tạo và công việc chuyên nghiệp.'
        WHEN ProductID = 11 THEN N'Mô tả: Apple Watch Series 7 là một trong những smartwatch hàng đầu trên thị trường, với màn hình lớn, nhiều tính năng sức khỏe và thể thao, cùng với khả năng kết nối và kiểm soát các thiết bị Apple khác. Đồng hồ này là một trợ thủ đắc lực cho việc theo dõi và cải thiện sức khỏe hàng ngày.'
        WHEN ProductID = 12 THEN N'Mô tả: IPhone 13 Pro là một trong những chiếc điện thoại cao cấp nhất của Apple, với bộ nhớ trong lớn, camera chất lượng cao và hiệu suất mạnh mẽ. Thiết kế sang trọng và tính năng độc quyền của iOS, sản phẩm này mang lại trải nghiệm sử dụng đỉnh cao cho người dùng.'
        WHEN ProductID = 13 THEN N'Mô tả: MacBook Pro 14-inch (M1 Pro/M1 Max) là một trong những laptop mạnh mẽ nhất của Apple, với bộ vi xử lý M1 Pro hoặc M1 Max, màn hình Retina lớn và hiệu suất cao. Thiết kế sang trọng và hệ điều hành macOS, sản phẩm này thích hợp cho các tác vụ sáng tạo và công việc chuyên nghiệp.'
        WHEN ProductID = 14 THEN N'Mô tả: Apple Watch SE là một trong những smartwatch phổ biến của Apple, với thiết kế đẹp mắt, nhiều tính năng sức khỏe và thể thao, cùng với khả năng kết nối và kiểm soát các thiết bị Apple khác. Đồng hồ này cung cấp một trải nghiệm tốt cho người dùng hàng ngày.'
        WHEN ProductID = 15 THEN N'Mô tả: IPhone 13 là một trong những chiếc điện thoại phổ biến nhất của Apple, với camera chất lượng cao, hiệu suất ổn định và thiết kế hiện đại. Sản phẩm này đáp ứng đầy đủ nhu cầu của người dùng hiện đại.'
		WHEN ProductID = 16 THEN N'Mô tả: MacBook Pro 13-inch (M1) là một trong những laptop mạnh mẽ của Apple, sử dụng chip M1 tự phát triển của hãng. Với thiết kế nhỏ gọn, màn hình Retina và hiệu suất ổn định, sản phẩm này là lựa chọn lý tưởng cho việc di chuyển và sử dụng hàng ngày.'
        WHEN ProductID = 17 THEN N'Mô tả: Apple Watch Series 6 là một trong những smartwatch hàng đầu trên thị trường, với nhiều tính năng sức khỏe và thể thao, cùng với khả năng kết nối và kiểm soát các thiết bị Apple khác. Đồng hồ này cung cấp một trải nghiệm tốt cho người dùng hàng ngày.'
        WHEN ProductID = 18 THEN N'Mô tả: IPhone SE (2020) là một trong những chiếc điện thoại phổ biến của Apple, với thiết kế nhỏ gọn, hiệu suất ổn định và camera chất lượng cao. Sản phẩm này là lựa chọn phù hợp cho người dùng muốn sử dụng hệ điều hành iOS với mức giá phải chăng.'
        WHEN ProductID = 19 THEN N'Mô tả: Tai nghe Sony WH-1000XM4 là một trong những sản phẩm chất lượng cao trong phân khúc tai nghe không dây, với chất lượng âm thanh xuất sắc, chức năng chống ồn tốt và thiết kế thoải mái. Sản phẩm này là lựa chọn tuyệt vời cho người dùng muốn trải nghiệm âm nhạc chất lượng cao.'
        WHEN ProductID = 20 THEN N'Mô tả: Tai nghe Bose QuietComfort 45 là một lựa chọn hàng đầu cho người dùng muốn trải nghiệm chất lượng âm thanh tốt cùng với tính năng chống ồn hiệu quả. Thiết kế thoải mái và tính di động cao, sản phẩm này làm hài lòng người dùng trong mọi tình huống.'
        WHEN ProductID = 21 THEN N'Mô tả: Apple AirPods Pro là một trong những tai nghe không dây hàng đầu trên thị trường, với chất lượng âm thanh xuất sắc, chức năng chống ồn và tính di động cao. Sản phẩm này là lựa chọn ưa thích của người dùng Apple.'
        WHEN ProductID = 22 THEN N'Mô tả: Tai nghe Samsung Galaxy Buds Pro là một lựa chọn tuyệt vời cho người dùng thiết bị Samsung, với chất lượng âm thanh tốt, chức năng chống ồn và tính di động cao. Thiết kế nhỏ gọn và thoải mái, sản phẩm này làm hài lòng người dùng trong mọi tình huống.'
        WHEN ProductID = 23 THEN N'Mô tả: Tai nghe Jabra Elite 85t là một lựa chọn hàng đầu cho người dùng muốn trải nghiệm âm thanh chất lượng cao cùng với tính năng chống ồn hiệu quả. Thiết kế thoải mái và chống nước, sản phẩm này phù hợp cho mọi hoạt động hàng ngày.'
        WHEN ProductID = 24 THEN N'Mô tả: Tai nghe Sony WF-1000XM4 là một trong những tai nghe True Wireless cao cấp nhất hiện nay, với chất lượng âm thanh xuất sắc, chức năng chống ồn tốt và thiết kế sang trọng. Sản phẩm này đáp ứng mọi nhu cầu của người dùng đắt tiền.'
        WHEN ProductID = 25 THEN N'Mô tả: Tai nghe Sennheiser Momentum True Wireless 2 là một trong những sản phẩm chất lượng cao trong phân khúc tai nghe True Wireless, với âm thanh chất lượng cao, thiết kế sang trọng và tính di động cao. Sản phẩm này là lựa chọn hàng đầu cho người yêu thích âm nhạc.'
        WHEN ProductID = 26 THEN N'Mô tả: Tai nghe Beats Studio Buds là một trong những lựa chọn phổ biến cho người dùng muốn trải nghiệm âm thanh tốt cùng với thiết kế thoải mái và tính di động cao. Sản phẩm này phù hợp cho mọi hoạt động hàng ngày.'
        WHEN ProductID = 27 THEN N'Mô tả: Tai nghe JBL Free X là một lựa chọn phổ biến cho người dùng muốn trải nghiệm âm thanh tốt cùng với tính di động cao. Thiết kế nhỏ gọn và thoải mái, sản phẩm này làm hài lòng người dùng trong mọi tình huống.'
        WHEN ProductID = 28 THEN N'Mô tả: Tai nghe Skullcandy Indy Evo là một lựa chọn phổ biến cho người dùng muốn trải nghiệm âm thanh tốt cùng với tính di động cao. Thiết kế nhỏ gọn và thoải mái, sản phẩm này làm hài lòng người dùng trong mọi tình huống.'
        WHEN ProductID = 29 THEN N'Mô tả: Samsung Galaxy S21 Ultra 256GB là một trong những chiếc smartphone hàng đầu của Samsung, với màn hình lớn và độ phân giải cao, hiệu suất mạnh mẽ và camera chất lượng. Thiết kế sang trọng và tính năng đa dạng, đây là một trong những lựa chọn hàng đầu cho người dùng đam mê công nghệ.'
        WHEN ProductID = 30 THEN N'Mô tả: Xiaomi Redmi Note 11 Pro 128GB là một trong những chiếc smartphone giá trị của Xiaomi, với hiệu suất tốt và camera đa dạng. Thiết kế hiện đại và màn hình lớn, sản phẩm này phù hợp cho người dùng muốn trải nghiệm công nghệ mới mà không cần bỏ ra nhiều tiền.'
        WHEN ProductID = 31 THEN N'Mô tả: OnePlus 9 Pro 256GB là một trong những smartphone cao cấp của OnePlus, với hiệu suất mạnh mẽ và camera chất lượng. Thiết kế sang trọng và tính năng đa dạng, đây là lựa chọn hàng đầu cho người dùng yêu công nghệ.'
        WHEN ProductID = 32 THEN N'Mô tả: Google Pixel 6 128GB là một trong những chiếc smartphone được đánh giá cao về camera và trải nghiệm Android gần như gốc. Thiết kế đẹp và tính năng thông minh, sản phẩm này là lựa chọn tốt cho người dùng muốn trải nghiệm Android nguyên bản.'
        WHEN ProductID = 33 THEN N'Mô tả: Oppo Find X5 Pro 256GB là một trong những chiếc smartphone cao cấp của Oppo, với hiệu suất mạnh mẽ và camera đa dạng. Thiết kế sang trọng và tính năng đa dạng, đây là lựa chọn hàng đầu cho người dùng yêu công nghệ.'
        WHEN ProductID = 34 THEN N'Mô tả: Vivo X70 Pro+ 256GB là một trong những chiếc smartphone hàng đầu của Vivo, với hiệu suất mạnh mẽ và camera chất lượng. Thiết kế sang trọng và tính năng đa dạng, đây là lựa chọn hàng đầu cho người dùng yêu công nghệ.'
        WHEN ProductID = 35 THEN N'Mô tả: Realme GT 2 Pro 256GB là một trong những chiếc smartphone cao cấp của Realme, với hiệu suất mạnh mẽ và thiết kế thời trang. Camera chất lượng và tính năng đa dạng, sản phẩm này phù hợp cho người dùng muốn trải nghiệm công nghệ mới.'
        WHEN ProductID = 36 THEN N'Mô tả: Sony Xperia 1 III 256GB là một trong những smartphone cao cấp của Sony, với hiệu suất mạnh mẽ và màn hình chất lượng cao. Thiết kế sang trọng và tính năng đa dạng, đây là lựa chọn hàng đầu cho người dùng yêu công nghệ.'
        WHEN ProductID = 37 THEN N'Mô tả: Huawei P50 Pro 256GB là một trong những chiếc smartphone hàng đầu của Huawei, với hiệu suất mạnh mẽ và camera chất lượng. Thiết kế sang trọng và tính năng đa dạng, đây là lựa chọn hàng đầu cho người dùng yêu công nghệ.'
        WHEN ProductID = 38 THEN N'Mô tả: Motorola Edge 30 Pro 256GB là một trong những chiếc smartphone hàng đầu của Motorola, với hiệu suất mạnh mẽ và camera đa dạng. Thiết kế sang trọng và tính năng đa dạng, đây là lựa chọn hàng đầu cho người dùng yêu công nghệ.'
        WHEN ProductID = 39 THEN N'Mô tả: Tai nghe Sony WH-1000XM3 là một trong những tai nghe chất lượng cao của Sony, với chất lượng âm thanh xuất sắc và chức năng chống ồn hiệu quả. Thiết kế thoải mái và tính di động cao, sản phẩm này phù hợp cho người dùng muốn trải nghiệm âm nhạc chất lượng.'
        WHEN ProductID = 40 THEN N'Mô tả: Tai nghe Bose SoundSport Free là một trong những tai nghe chất lượng cao của Bose, với chất lượng âm thanh tốt và thoải mái khi đeo. Thiết kế chống nước và tính di động cao, sản phẩm này là lựa chọn tốt cho người dùng yêu thích thể thao.'
        WHEN ProductID = 41 THEN N'Mô tả: Tai nghe Apple AirPods (3rd generation) là một trong những tai nghe không dây phổ biến của Apple, với chất lượng âm thanh tốt và tính di động cao. Thiết kế nhỏ gọn và dễ sử dụng, sản phẩm này là lựa chọn ưa thích của người dùng Apple.'
        WHEN ProductID = 42 THEN N'Mô tả: Tai nghe Samsung Galaxy Buds Live là một trong những tai nghe không dây phổ biến của Samsung, với chất lượng âm thanh tốt và thiết kế thoải mái. Thiết kế không gò bó và tính di động cao, sản phẩm này là lựa chọn tốt cho người dùng muốn trải nghiệm âm nhạc mọi lúc mọi nơi.'
        WHEN ProductID = 43 THEN N'Mô tả: Tai nghe Jabra Elite 75t là một trong những tai nghe True Wireless hàng đầu trên thị trường, với chất lượng âm thanh xuất sắc và thiết kế nhỏ gọn. Thiết kế chống nước và tính di động cao, sản phẩm này là lựa chọn tốt cho người dùng muốn trải nghiệm âm nhạc mọi lúc mọi nơi.'
        WHEN ProductID = 44 THEN N'Mô tả: Tai nghe Sony WF-XB700 là một trong những tai nghe True Wireless chất lượng cao của Sony, với chất lượng âm thanh tốt và thiết kế thoải mái. Thiết kế nhỏ gọn và tính di động cao, sản phẩm này là lựa chọn tốt cho người dùng muốn trải nghiệm âm nhạc mọi lúc mọi nơi.'
        WHEN ProductID = 45 THEN N'Mô tả: Tai nghe Sennheiser CX 400BT True Wireless là một trong những tai nghe True Wireless chất lượng cao của Sennheiser, với âm thanh chi tiết và thiết kế đơn giản. Thiết kế nhỏ gọn và tính di động cao, sản phẩm này là lựa chọn tốt cho người dùng muốn trải nghiệm âm nhạc chất lượng cao.'
        WHEN ProductID = 46 THEN N'Mô tả: Tai nghe Beats Flex là một trong những tai nghe có giá thành phù hợp nhất của Beats, với chất lượng âm thanh tốt và thiết kế linh hoạt. Thiết kế nhỏ gọn và tính di động cao, sản phẩm này là lựa chọn tốt cho người dùng muốn trải nghiệm âm nhạc mọi lúc mọi nơi.'
        WHEN ProductID = 47 THEN N'Mô tả: Tai nghe JBL Tune 125TWS là một trong những tai nghe True Wireless phổ biến của JBL, với chất lượng âm thanh tốt và thiết kế nhỏ gọn. Thiết kế thoải mái và tính di động cao, sản phẩm này là lựa chọn phổ biến cho người dùng muốn trải nghiệm âm nhạc mọi lúc mọi nơi.'
        WHEN ProductID = 48 THEN N'Mô tả: Tai nghe Skullcandy Sesh Evo là một trong những tai nghe True Wireless phổ biến của Skullcandy, với chất lượng âm thanh tốt và thiết kế nhỏ gọn. Thiết kế thoải mái và tính di động cao, sản phẩm này là lựa chọn phổ biến cho người dùng muốn trải nghiệm âm nhạc mọi lúc mọi nơi.'
    END;

