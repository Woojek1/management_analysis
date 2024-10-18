#tworzenie listy produktów bez znacznika usuniętych <strike>

select 
	productid
	#,productname
	,replace(replace(ProductName,"<STRIKE>", ""),"</STRIKE>", "") as product_name
	,ProductProducer
	#,lastmodification
	#,ProductCatalogNumber
from product p
where ProductProducer = "Clivet"
order by 2 desc



#tworzenie listy urządzeń Clivet występujących w ofertach z roku 2024
#zliczenie ilości produktów w poszczególnych projektach

select 
	products.product_name as Symbol
	#,concat(products.product_name, " ",pr.Projectnumber)
	,count(concat(products.product_name, " ",pr.Projectnumber)) as Ilosc_urzadzen
	,pr.Projectnumber as Numer_projektu
	,o.OrderSubject as Temat
	#,o.OfferNumber
	#,o.OrderDate
	from 
		(	
		select 
			productid
			,replace(replace(ProductName,"<STRIKE>", ""),"</STRIKE>", "") as product_name
			,ProductSuplier
		from product p
		where ProductSuplier = "Clivet"
		order by 2 desc
		) 
		as products
join orderproductrel op 
on products.ProductId = op.ProductId
join orders o 
on op.OrderId = o.OrderId
join project pr
on o.ProjectId = pr.ProjectId 
and year(o.OrderInsertDate) = 2024
group by concat(products.product_name, " ",pr.Projectnumber) 
order by 1, 4 desc 