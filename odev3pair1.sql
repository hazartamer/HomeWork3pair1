--1. Product isimlerini (`ProductName`) ve birim başına miktar (`QuantityPerUnit`) değerlerini almak için sorgu yazın.
SELECT product_name, quantity_per_unit FROM products;
--2. Ürün Numaralarını (`ProductID`) ve Product isimlerini (`ProductName`) değerlerini almak için sorgu yazın. Artık satılmayan ürünleri (`Discontinued`) filtreleyiniz.
SELECT product_id, product_name FROM products WHERE discontinued = 0;
--3. Durdurulmayan (`Discontinued`) Ürün Listesini, Ürün kimliği ve ismi (`ProductID`, `ProductName`) değerleriyle almak için bir sorgu yazın.
SELECT product_id, product_name FROM products WHERE discontinued = 1;
--4. Ürünlerin maliyeti 20'dan az olan Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.
SELECT product_id,product_name,unit_price FROM products WHERE unit_price < 20;
--5. Ürünlerin maliyetinin 15 ile 25 arasında olduğu Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.
SELECT product_id,product_name,unit_price FROM products WHERE unit_price BETWEEN 15 AND 25;
--6. Ürün listesinin (`ProductName`, `UnitsOnOrder`, `UnitsInStock`) stoğun siparişteki miktardan az olduğunu almak için bir sorgu yazın.
SELECT product_name, units_on_order,units_in_stock FROM products WHERE units_in_stock < units_on_order;
--7. İsmi `a` ile başlayan ürünleri listeleyeniz.
SELECT * FROM products WHERE product_name LIKE 'a%';
--8. İsmi `i` ile biten ürünleri listeleyeniz.
SELECT * FROM products WHERE product_name LIKE '%i';
--9. Ürün birim fiyatlarına %18’lik KDV ekleyerek listesini almak (ProductName, UnitPrice, UnitPriceKDV) için bir sorgu yazın.
SELECT product_name, unit_price,sum(unit_price + (unit_price * 0.18)) AS unit_price_with_KDV FROM products
GROUP BY product_name, unit_price;
--10. Fiyatı 30 dan büyük kaç ürün var?
SELECT COUNT(product_name) AS unit_price_more_than_30 FROM products WHERE unit_price > 30;
--11. Ürünlerin adını tamamen küçültüp fiyat sırasına göre tersten listele
SELECT LOWER(product_name) AS lower_product_name, * FROM products ORDER BY unit_price DESC;
--12. Çalışanların ad ve soyadlarını yanyana gelecek şekilde yazdır
SELECT CONCAT(first_name,' ',last_name) AS full_name FROM employees;
--13. Region alanı NULL olan kaç tedarikçim var?
SELECT COUNT(company_name) FROM suppliers WHERE region ISNULL;
--14. a.Null olmayanlar?
SELECT COUNT(company_name) FROM suppliers WHERE region NOTNULL;
--15. Ürün adlarının hepsinin soluna TR koy ve büyültüp olarak ekrana yazdır.
SELECT UPPER(CONCAT('tr ',product_name )) AS edited_product_name FROM products;
--16. a.Fiyatı 20den küçük ürünlerin adının başına TR ekle
SELECT UPPER(CONCAT('tr ',product_name )) AS edited_product_name FROM products WHERE unit_price < 20;
--17. En pahalı ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
SELECT product_name, unit_price FROM products ORDER BY unit_price DESC LIMIT 1;
--18. En pahalı on ürünün Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
SELECT product_name, unit_price FROM products ORDER BY unit_price DESC LIMIT 10;
--19. Ürünlerin ortalama fiyatının üzerindeki Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
SELECT product_name, unit_price FROM products WHERE unit_price > (SELECT AVG(unit_price) FROM products);
--20. Stokta olan ürünler satıldığında elde edilen miktar ne kadardır.
SELECT SUM(unit_price * units_in_stock) AS total_earnings FROM products WHERE units_in_stock > 0;
--21. Mevcut ve Durdurulan ürünlerin sayılarını almak için bir sorgu yazın.
SELECT COUNT(product_name) FROM products WHERE units_in_stock > 0 AND discontinued = 0;
--22. Ürünleri kategori isimleriyle birlikte almak için bir sorgu yazın.
SELECT p.*, c.category_name FROM products AS p
INNER JOIN categories AS c ON p.category_id = c.category_id;
--23. Ürünlerin kategorilerine göre fiyat ortalamasını almak için bir sorgu yazın.
SELECT c.category_name, AVG(p.unit_price) AS avg_price_by_category FROM products AS p
INNER JOIN categories AS c ON p.category_id = c.category_id
GROUP BY c.category_name;
--24. En pahalı ürünümün adı, fiyatı ve kategorisin adı nedir?
SELECT p.product_id, p.unit_price, c.category_name FROM products AS p 
INNER JOIN categories AS c ON p.category_id = c.category_id
ORDER BY unit_price DESC LIMIT 1;
--25. En çok satılan ürününün adı, kategorisinin adı ve tedarikçisinin adı
SELECT p.product_name,c.category_name,s.company_name FROM order_details AS od
INNER JOIN products AS p ON od.product_id = p.product_id
INNER JOIN suppliers AS s ON p.supplier_id = s.supplier_id
INNER JOIN categories AS c ON p.category_id = c.category_id
ORDER BY quantity DESC LIMIT 1;