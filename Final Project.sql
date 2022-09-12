---
Part1


---1
SELECT R.Consumer_ID,
 RE.name AS name_of_restaurant, Overall_Rating,food_rating
,service_rating
FROM RATINGS R
JOIN RESTAURANTS RE
ON R.RESTAURANT_ID=RE.RESTAURANT_ID
JOIN consumers c
ON R.Consumer_ID=c.Consumer_ID
;

---2
SELECT DISTINCT R.Consumer_ID,
 COUNT(Overall_Rating) AS reveiews_per_customer
FROM RATINGS R
JOIN RESTAURANTS RE
ON R.RESTAURANT_ID=RE.RESTAURANT_ID
JOIN consumers c
ON R.Consumer_ID=c.Consumer_ID
GROUP BY R.Consumer_ID
ORDER BY COUNT(Overall_Rating) DESC
;

---3
SELECT DISTINCT RE.name AS name_of_restaurant,
 COUNT(Overall_Rating) AS reveiews_per_customer
FROM RATINGS R
JOIN RESTAURANTS RE
ON R.RESTAURANT_ID=RE.RESTAURANT_ID
JOIN consumers c
ON R.Consumer_ID=c.Consumer_ID
GROUP BY RE.name
ORDER BY COUNT(Overall_Rating) DESC
;

---4
SELECT 
 RE.name AS name_of_restaurant,AVG(Overall_Rating)*1.0 avg_Overall_Rating,AVG(food_rating)*1.0 avg_food_rating
,AVG(service_rating)*1.0 avg_service_rating
FROM RATINGS R
JOIN RESTAURANTS RE
ON R.RESTAURANT_ID=RE.RESTAURANT_ID
JOIN consumers c
ON R.Consumer_ID=c.Consumer_ID
GROUP BY RE.name
ORDER BY AVG(Overall_Rating) DESC,AVG(food_rating) DESC,AVG(service_rating) DESC
;

---5
SELECT DISTINCT R.Consumer_ID,
 RE.name AS name_of_restaurant,Cuisine,preferred_cuisine, Overall_Rating,food_rating
,service_rating
FROM RATINGS R
JOIN RESTAURANTS RE
ON R.RESTAURANT_ID=RE.RESTAURANT_ID
JOIN restaurant_cuisines RC
ON R.RESTAURANT_ID=RC.RESTAURANT_ID
JOIN consumers c
ON R.Consumer_ID=c.Consumer_ID
JOIN consumer_preferences cP
ON R.Consumer_ID=cp.Consumer_ID
ORDER BY Overall_Rating DESC
;

---6
SELECT DISTINCT R.Consumer_ID,
 RE.name AS name_of_restaurant,Cuisine,preferred_cuisine, Overall_Rating,food_rating
,service_rating
FROM RATINGS R
JOIN RESTAURANTS RE
ON R.RESTAURANT_ID=RE.RESTAURANT_ID
JOIN restaurant_cuisines RC
ON R.RESTAURANT_ID=RC.RESTAURANT_ID
JOIN consumers c
ON R.Consumer_ID=c.Consumer_ID
JOIN consumer_preferences cP
ON R.Consumer_ID=cp.Consumer_ID
ORDER BY Overall_Rating
;

---7
SELECT 
 RE.name AS name_of_restaurant,Cuisine,AVG(Overall_Rating)*1.0 avg_Overall_Rating,AVG(food_rating)*1.0 avg_food_rating
,AVG(service_rating)*1.0 avg_service_rating,COUNT(DISTINCT R.Consumer_ID) AS num_of_reveiews,
AVG(COUNT(DISTINCT R.Consumer_ID)) OVER() AS avg_num_of_reveiews_per_restarurant
FROM RATINGS R
JOIN RESTAURANTS RE
ON R.RESTAURANT_ID=RE.RESTAURANT_ID
JOIN restaurant_cuisines RC
ON R.RESTAURANT_ID=RC.RESTAURANT_ID
JOIN consumers c
ON R.Consumer_ID=c.Consumer_ID
JOIN consumer_preferences cP
ON R.Consumer_ID=cp.Consumer_ID
GROUP BY RE.name,Cuisine
ORDER BY AVG(Overall_Rating) DESC,AVG(food_rating) DESC,AVG(service_rating) DESC
;

---8
SELECT 
 RE.name AS name_of_restaurant,Cuisine,AVG(Overall_Rating)*1.0 avg_Overall_Rating,AVG(food_rating)*1.0 avg_food_rating
,AVG(service_rating)*1.0 avg_service_rating,COUNT(DISTINCT R.Consumer_ID) AS num_of_reveiews,
AVG(COUNT(DISTINCT R.Consumer_ID)) OVER() AS avg_num_of_reveiews_per_restarurant
,PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY Overall_Rating) OVER(PARTITION BY RE.name)
AS median_per_restaurant,
PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY Overall_Rating) OVER()
AS median_per_all_restaurants,DENSE_RANK () 
OVER(ORDER BY COUNT(DISTINCT R.Consumer_ID )) AS RANK
FROM RATINGS R
JOIN RESTAURANTS RE
ON R.RESTAURANT_ID=RE.RESTAURANT_ID
JOIN restaurant_cuisines RC
ON R.RESTAURANT_ID=RC.RESTAURANT_ID
JOIN consumers c
ON R.Consumer_ID=c.Consumer_ID
JOIN consumer_preferences cP
ON R.Consumer_ID=cp.Consumer_ID
GROUP BY RE.name,Cuisine,Overall_Rating
ORDER BY AVG(Overall_Rating) DESC,AVG(food_rating) DESC,AVG(service_rating) DESC, 
 COUNT(DISTINCT R.Consumer_ID) DESC
;

---9
SELECT c.Consumer_ID,c.Smoker,c.Age,c.Budget,c.Children,c.City,c.Drink_Level,c.Marital_Status,c.Occupation,c.Transportation_Method,c.State,
 RE.name AS name_of_restaurant,AVG(Overall_Rating)*1.0 avg_Overall_Rating,AVG(food_rating)*1.0 avg_food_rating
,AVG(service_rating)*1.0 avg_service_rating
FROM RATINGS R
JOIN RESTAURANTS RE
ON R.RESTAURANT_ID=RE.RESTAURANT_ID
JOIN consumers c
ON R.Consumer_ID=c.Consumer_ID
GROUP BY c.Consumer_ID,c.Smoker,c.Age,c.Budget,c.Children,c.City,c.Drink_Level,c.Marital_Status,c.Occupation,c.Transportation_Method,c.State,RE.name
ORDER BY AVG(Overall_Rating) DESC,AVG(food_rating) DESC,AVG(service_rating) DESC
;

---10
SELECT COUNT(DISTINCT R.Consumer_ID)
AS num_of_consumers,
COUNT(DISTINCT RE.name) 
AS num_of_restaurant
,COUNT( Overall_Rating)
AS num_of_reveiews,COUNT( food_rating)
AS num_of_food_ratings,COUNT( service_rating)
AS num_of_service_ratings

FROM RATINGS R
JOIN RESTAURANTS RE
ON R.RESTAURANT_ID=RE.RESTAURANT_ID
JOIN consumers c
ON R.Consumer_ID=c.Consumer_ID

;
---
Part2
---1

SELECT *
FROM marketing_data
ORDER BY ACCEPTEDCMP1 DESC,ACCEPTEDCMP2 DESC,ACCEPTEDCMP3 DESC,ACCEPTEDCMP4 DESC,ACCEPTEDCMP5 DESC
;
---2

SELECT SUM(ACCEPTEDCMP1+ACCEPTEDCMP2+ACCEPTEDCMP3+ACCEPTEDCMP4+ACCEPTEDCMP5) AS sum_of_cmp,
SUM(Numdealspurchases+numwebpurchases+numcatalogpurchases+numstorepurchases) AS overall_purchases
,ID,YEAR_BIRTH,EDUCATION,MARITAL_STATUS,[ income],kidhome,teenhome,dt_customer
,ACCEPTEDCMP1,ACCEPTEDCMP2,ACCEPTEDCMP3,ACCEPTEDCMP4,ACCEPTEDCMP5 

FROM marketing_data
GROUP BY ID,YEAR_BIRTH,EDUCATION,MARITAL_STATUS,[ income],kidhome,teenhome,dt_customer
,ACCEPTEDCMP1,ACCEPTEDCMP2,ACCEPTEDCMP3,ACCEPTEDCMP4,ACCEPTEDCMP5
ORDER BY SUM(ACCEPTEDCMP1+ACCEPTEDCMP2+ACCEPTEDCMP3+ACCEPTEDCMP4+ACCEPTEDCMP5) DESC,
SUM(Numdealspurchases+numwebpurchases+numcatalogpurchases+numstorepurchases)
DESC,ACCEPTEDCMP1 DESC,ACCEPTEDCMP2 DESC,ACCEPTEDCMP3 DESC,ACCEPTEDCMP4 DESC,ACCEPTEDCMP5 DESC

;


---3

SELECT SUM(ACCEPTEDCMP1) AS sum_of_cmp1,SUM(ACCEPTEDCMP2) AS sum_of_cmp2,SUM(ACCEPTEDCMP3)AS sum_of_cmp3,SUM(ACCEPTEDCMP4)AS sum_of_cmp4,SUM(ACCEPTEDCMP5) AS sum_of_cmp5

FROM marketing_data
;

---4

SELECT 
AVG(YEAR_BIRTH) AS avg_year,
EDUCATION,COUNT(EDUCATION) AS split_of_education,MARITAL_STATUS,COUNT(MARITAL_STATUS) AS split_of_marital_status,
([ income]),(kidhome),(teenhome),
(dt_customer)
 

FROM marketing_data
GROUP BY EDUCATION,MARITAL_STATUS,YEAR_BIRTH,([ income]),Kidhome
,Teenhome,Dt_Customer;


---5
SELECT SUM(MntFishProducts) AS SUM_MntFishProducts,SUM(MntFruits)
 AS SUM_MntFruits,SUM(MntGoldProds) AS SUM_MntGoldProds,SUM(MntMeatProducts) AS SUM_MntMeatProducts,
SUM(MntMeatProducts) AS SUM_MntMeatProducts,SUM(MntSweetProducts) AS SUM_MntSweetProducts,SUM(MntWines) AS SUM_MntWines
FROM marketing_data

;


---
Part3


SELECT *
FROM tmp
;
---1
SELECT AGE,COUNT(AGE) AS num_of_same_age_gold_medal
FROM tmp
WHERE Medal= 'GOLD'
GROUP BY AGE
ORDER BY AGE DESC
;
---2
SELECT COUNT(CASE WHEN Sex='M' THEN ID ELSE ID END)
AS Sex,Sex
,Medal
FROM tmp

GROUP BY Sex,Medal
ORDER BY Medal 
;
---3
SELECT COUNT(CASE WHEN Sex='M' THEN ID ELSE ID END)
AS num_of_medalist,Sex,Year
,Medal
FROM tmp
WHERE Medal IS NOT NULL
GROUP BY Sex,Medal,Year
ORDER BY year,Medal 
;
---4
SELECT COUNT(CASE WHEN Sex='M' THEN ID ELSE ID END)
AS num_of_medalist,Sex,Year

FROM tmp
WHERE Medal IS NOT NULL
GROUP BY Sex,Year
ORDER BY year
;
---5
SELECT NOC,Team,COUNT(CASE WHEN Medal='Gold' Then ID END) AS num_of_gold
,COUNT(CASE WHEN Medal='silver' Then ID END) AS num_of_silver,
COUNT(CASE WHEN Medal='bronze' Then ID END) AS num_of_bronze
FROM tmp
WHERE Medal IS NOT NULL
GROUP BY NOC,Team

;
---6
SELECT Year,Sport,AVG(Age) AS avg_age,AVG(Weight) AS avg_Weight,
AVG(Height) AS avg_Height
FROM tmp

GROUP BY Year,Sport
ORDER BY Year

---
part4

---1
WITH QUERY1 AS (SELECT  TOP  (22500) date
,(PRODUCT_PRICE*UNITS) AS Money_Earned FROM 
SALES  S
JOIN PRODUCTS P
ON S.PRODUCT_ID=P.PRODUCT_ID
JOIN  STORES ST
ON S.STORE_ID=ST.STORE_ID
GROUP BY date,PRODUCT_PRICE,UNITS
)
SELECT date,SUM(Money_Earned) AS Money_Earned
FROM QUERY1
GROUP BY date
ORDER BY Money_Earned DESC

;
---2
SELECT  TOP  (22500)
ST.Store_ID,P.PRODUCT_ID,
COUNT(DISTINCT S.Sale_ID) AS LOST ,stock_on,COUNT(DISTINCT S.Sale_ID)-stock_on  AS Orders_missed
FROM 
SALES  S
JOIN PRODUCTS P
ON S.PRODUCT_ID=P.PRODUCT_ID
JOIN  STORES ST
ON S.STORE_ID=ST.STORE_ID
JOIN  inventory i
ON S.STORE_ID=i.STORE_ID
 
GROUP BY St.Store_ID,stock_on,P.Product_ID
HAVING COUNT(DISTINCT S.Sale_ID)>stock_on
;

---3
WITH QUERY1 AS (SELECT  TOP  (22500)
STORE_LOCATION,PRODUCT_CATEGORY,(PRODUCT_PRICE*UNITS) AS Money_Earned FROM 
SALES  S
JOIN PRODUCTS P
ON S.PRODUCT_ID=P.PRODUCT_ID
JOIN  STORES ST
ON S.STORE_ID=ST.STORE_ID
GROUP BY STORE_LOCATION,PRODUCT_CATEGORY,PRODUCT_PRICE,UNITS
),
QUERY3 AS(
SELECT STORE_LOCATION,(PRODUCT_CATEGORY) ,SUM(Money_Earned) AS Money_Earned
,DENSE_RANK () OVER (PARTITION BY STORE_LOCATION ORDER BY Money_Earned) AS DR
FROM QUERY1
GROUP BY STORE_LOCATION,PRODUCT_CATEGORY,Money_Earned)

SELECT STORE_LOCATION,PRODUCT_CATEGORY AS PC,SUM(Money_Earned) AS Money_Earned

FROM QUERY3
GROUP BY STORE_LOCATION,PRODUCT_CATEGORY
ORDER BY STORE_LOCATION,Money_Earned DESC

;

---4
SELECT  TOP  (25) 
SUM(PRODUCT_COST*STOCK_ON) AS total_value_inventory
FROM
SALES  S
JOIN PRODUCTS P
ON S.PRODUCT_ID=P.PRODUCT_ID
JOIN  STORES ST
ON S.STORE_ID=ST.STORE_ID
JOIN  inventory i
ON S.STORE_ID=i.STORE_ID

;

---5
SELECT  TOP  (25) *
FROM
SALES  S
JOIN PRODUCTS P
ON S.PRODUCT_ID=P.PRODUCT_ID
JOIN  STORES ST
ON S.STORE_ID=ST.STORE_ID
JOIN  inventory i
ON S.STORE_ID=i.STORE_ID

;


---6
SELECT  TOP  (25) 
SUM(PRODUCT_COST*STOCK_ON) AS total_value_inventory
FROM
SALES  S
JOIN PRODUCTS P
ON S.PRODUCT_ID=P.PRODUCT_ID
JOIN  STORES ST
ON S.STORE_ID=ST.STORE_ID
JOIN  inventory i
ON S.STORE_ID=i.STORE_ID

;


