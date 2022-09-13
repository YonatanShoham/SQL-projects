---1
SELECT author,title
FROM articles
;

---2
SELECT title,traffic_day,article_views
FROM articles a
JOIN traffic t
ON a.article_id=t.article_id
;

---3
SELECT product_name,category_name
FROM products p
JOIN categories c
ON p.category_id=c.category_id
;


---4
SELECT title,traffic_day,article_views,product_name,product_views
FROM articles a
JOIN traffic t
ON a.article_id=t.article_id
JOIN products p
ON t.product_id=p.product_id
;

---5
SELECT title,SUM(article_views) AS total_article_views,SUM(product_views) AS total_product_views
FROM articles a
JOIN traffic t
ON a.article_id=t.article_id
JOIN products p
ON t.product_id=p.product_id
GROUP BY title
;

---6
SELECT product_name,a.article_id,SUM(product_views) AS total_product_views
FROM articles a
JOIN traffic t
ON a.article_id=t.article_id
JOIN products p
ON t.product_id=p.product_id
GROUP BY product_name,a.article_id
ORDER BY product_name
;

---7
SELECT title,traffic_day,
SUM(article_views) OVER (PARTITION BY title ORDER BY traffic_day)
AS accumulated_article_views
FROM articles a
JOIN traffic t
ON a.article_id=t.article_id
JOIN products p
ON t.product_id=p.product_id
GROUP BY title,traffic_day,article_views
ORDER BY title,traffic_day
;

---8
SELECT author,
COUNT(DISTINCT a.article_id) AS num_of_articles,SUM(article_views) AS total_article_views
FROM articles a
JOIN traffic t
ON a.article_id=t.article_id
JOIN products p
ON t.product_id=p.product_id
GROUP BY author
ORDER BY SUM(article_views) DESC
;

---9
WITH QUERY9 AS (SELECT * 
FROM   (SELECT author,traffic_day,SUM(article_views) AS total_num_of_articles,
article_views
,category_name
FROM articles a
JOIN traffic t
ON a.article_id=t.article_id
JOIN products p
ON t.product_id=p.product_id
JOIN categories c
ON c.category_id=p.category_id
GROUP BY author,traffic_day,category_name
	,article_views	
	) AS TBL 
PIVOT  (SUM(article_views) 
FOR category_name IN ([technology],[finanace],[transportation],[energy])) AS PVT 
)
SELECT author,traffic_day,SUM(total_num_of_articles) AS total_num_of_articles,
SUM(technology) AS TechnologyViews,SUM(finanace) AS FinanaceViews,SUM(transportation) AS TransportationViews,SUM(energy) AS EnergyViews
FROM QUERY9
GROUP BY author,traffic_day
ORDER BY author,traffic_day
;

---10
WITH QUERY10 AS (
SELECT category_name,product_name,
t.product_views,
(SUM(SUM(t.product_views)) OVER(PARTITION BY category_name)) AS category_views 
FROM products p 
JOIN traffic t
ON p.product_id=t.product_id
JOIN categories c
ON p.category_id=c.category_id
GROUP BY category_name,product_name,product_views)
SELECT category_name,product_name,SUM(product_views) AS product_views,category_views
,(SUM(product_views)*1.0 / category_views)*100.0 AS PCT
FROM QUERY10
GROUP BY category_name,product_name,category_views
ORDER BY category_name,product_name
;

---11
WITH QUERY11 AS (
SELECT MONTH(traffic_day) AS traffic_month,
DATEPART(DW,traffic_day) AS traffic_day,(article_views) AS daily_article_views,
SUM(SUM(article_views)) OVER(PARTITION BY MONTH(traffic_day)) AS monthly_article_views
FROM TRAFFIC
GROUP BY traffic_day,article_views)
SELECT traffic_month,traffic_day,SUM(daily_article_views) AS daily_article_views,
monthly_article_views,(
 SUM(daily_article_views)* 100.0 
/monthly_article_views)   AS PCT
FROM QUERY11
GROUP BY traffic_month,traffic_day,monthly_article_views
ORDER BY traffic_month,traffic_day
;
	
---12
SELECT (traffic_day)  
 AS traffic_day,title ,
 SUM(article_views) AS totalarticleviews
 ,SUM(article_views) OVER(PARTITION BY traffic_day) AS totaldailyviews
 ,(SUM(article_views) *100.0/
 SUM(article_views)
 OVER(PARTITION BY traffic_day) ) AS ViewPCT
FROM TRAFFIC T
JOIN articles A
ON T.article_id=A.article_id
GROUP BY title,traffic_day,article_views
ORDER BY traffic_day
;

---13
SELECT title,
 SUM(article_views) AS totalviews
 ,DENSE_RANK() OVER(ORDER BY SUM(article_views) DESC )
 AS ViewsRank
 FROM TRAFFIC T
JOIN articles A
ON T.article_id=A.article_id
GROUP BY title
ORDER BY DENSE_RANK() OVER(ORDER BY SUM(article_views) DESC )
;

---14
SELECT C.category_name,P.product_name,
 SUM(t.product_views) AS totalviews
 ,DENSE_RANK()  OVER(PARTITION BY category_name ORDER BY SUM(t.product_views) DESC )
 AS ViewsRank
FROM TRAFFIC T
JOIN articles A
ON T.article_id=A.article_id
JOIN products P
ON T.product_id=P.product_id
JOIN CATEGORIES C
ON P.category_id=C.category_id
GROUP BY title,category_name,P.product_name
ORDER BY category_name,DENSE_RANK() OVER(PARTITION BY category_name ORDER BY SUM(t.product_views) DESC ) 
;

---15
SELECT title,traffic_day,LAG(article_views) OVER(PARTITION BY title ORDER BY traffic_day) AS previous_day_views,article_views
AS current_day_views,article_views*1.0/
LAG(article_views)  OVER(PARTITION BY title ORDER BY traffic_day)  *1.0 AS PCTChange
FROM TRAFFIC T
JOIN articles A
ON T.article_id=A.article_id
JOIN products P
ON T.product_id=P.product_id
JOIN CATEGORIES C
ON P.category_id=C.category_id
GROUP BY title,traffic_day,article_views
ORDER BY title,traffic_day
;

