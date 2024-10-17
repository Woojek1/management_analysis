#tworzenie listy produktów bez znacznika usuniętych <strike>

with devices as
	(
	select 
		productid
		#,productname
		,replace(replace(ProductName,"<STRIKE>", ""),"</STRIKE>", "") as product_name
		,ProductProducer
		,lastmodification
		,ProductCatalogNumber
		,isdeleted
	from product p
	where ProductProducer = "Clivet"
	order by 2 desc
	)
	select *
	from devices