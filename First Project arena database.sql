---1
WITH QUERY1 AS (SELECT
P.player_id,email_address,credit_card_type,credit_card_number
,CASE WHEN credit_card_type ='americanexpress' THEN 1
WHEN credit_card_type ='mastercard' THEN 2
WHEN credit_card_type ='visa' THEN 300 ELSE 900 END AS 'rating'
FROM paying_method p
JOIN players PL
ON P.player_id=PL.player_id
GROUP BY P.player_id,email_address,credit_card_type,credit_card_number
),QUERY2 AS(
 SELECT player_id,email_address,credit_card_type,credit_card_number,ROW_NUMBER()
OVER(PARTITION BY player_id
ORDER BY rating ) AS RN
FROM QUERY1
GROUP BY player_id,email_address,credit_card_type,credit_card_number
 ,rating),
 QUERY3 AS(
 SELECT *
 FROM QUERY2
 WHERE RN=1)
 SELECT player_id,email_address,credit_card_type,credit_card_number
 FROM QUERY3
 ORDER BY player_id
;

 ---2
SELECT *
FROM (SELECT gender,age_group,credit_card_type,P.player_id
 FROM paying_method p
 JOIN players PL
 ON P.player_id=PL.player_id)
 AS TBL PIVOT
 (COUNT(player_id) FOR credit_card_type
IN ([americanexpress],[mastercard],[visa]))
AS PVT
ORDER BY GENDER 
;

---3
SELECT game_name,COUNT(session_id ) AS num_sessions,DENSE_RANK() OVER(ORDER BY COUNT(session_id) DESC) AS num_sessions_rank 
FROM game_sessions gs
JOIN games g
on gs.game_id=g.id
GROUP BY game_name
ORDER BY DENSE_RANK() OVER(ORDER BY COUNT(session_id )) DESC
;

---4
 SELECT game_name,SUM(DATEDIFF(MINUTE,session_begin_date,session_end_date)) AS total_playing_minutes,DENSE_RANK() OVER(ORDER BY SUM(DATEDIFF(MINUTE,session_begin_date,session_end_date)) DESC) AS num_sessions_rank 
FROM game_sessions gs
JOIN games g
on gs.game_id=g.id
GROUP BY game_name
ORDER BY DENSE_RANK() OVER(ORDER BY SUM(DATEDIFF(MINUTE,session_begin_date,session_end_date))) DESC
;

---5
WITH QUERY5 AS (
SELECT p.age_group,game_name,SUM(DATEDIFF(MINUTE,session_begin_date,session_end_date)) AS total_playing_minutes
,DENSE_RANK () OVER (PARTITION BY age_group ORDER BY SUM(DATEDIFF(MINUTE,session_begin_date,session_end_date)) DESC) 
AS RANK
FROM game_sessions gs
JOIN games g
ON gs.game_id=g.id
JOIN players p
ON gs.player_id=p.player_id
GROUP BY p.age_group,game_name)
SELECT age_group,game_name,total_playing_minutes FROM QUERY5
WHERE RANK= 1 
ORDER BY RANK DESC
;

---6
 SELECT gs.session_id,action_id,action_type,amount ,
 SUM(CASE WHEN action_type= 'loss' THEN amount
*-1.0 ELSE amount *1.0 END)
OVER (PARTITION BY(gs.session_id) ORDER BY action_id)
AS balance
 FROM game_sessions gs
 JOIN players p
 ON gs.player_id=p.player_id
 JOIN session_details d
 ON gs.session_id=d.session_id
 ORDER BY gs.session_id
;

---7
 WITH QUERY7 AS (SELECT gs.session_id,
 action_id,action_type,amount ,
 SUM(CASE WHEN action_type= 'loss' THEN amount
*-1.0 ELSE amount *1.0 END)
OVER (PARTITION BY(gs.session_id) ORDER BY action_id)
AS balance
 FROM game_sessions gs
 JOIN players p
 ON gs.player_id=p.player_id
 JOIN session_details d
 ON gs.session_id=d.session_id),QUERY8 AS
(SELECT session_id,LAST_VALUE(balance)
OVER( ORDER BY session_id) AS LAST,DENSE_RANK()
OVER(PARTITION BY session_id ORDER BY action_id ) AS DR
FROM QUERY7
GROUP BY session_id,action_id,balance)
 SELECT COUNT( CASE WHEN LAST< 0
 THEN 1 ELSE NULL
  END) AS total_amount_lost,
 COUNT( CASE WHEN LAST >= 0 THEN 1 ELSE NULL
  END) AS total_amount_gained
 FROM QUERY8
 WHERE DR=1
;

---8
 WITH QUERY7 AS (SELECT gender,age_group,gs.session_id,
 action_id,action_type,amount ,
 SUM(CASE WHEN action_type= 'loss' THEN amount
*-1.0 ELSE amount *1.0 END)
OVER (PARTITION BY(gs.session_id) ORDER BY action_id)
AS balance
 FROM game_sessions gs
 JOIN players p
 ON gs.player_id=p.player_id
 JOIN session_details d
 ON gs.session_id=d.session_id
),QUERY8 AS
(SELECT gender,age_group,session_id,LAST_VALUE(balance)
OVER( ORDER BY session_id) AS LAST,DENSE_RANK()
OVER(PARTITION BY session_id ORDER BY action_id ) AS DR
FROM QUERY7
GROUP BY session_id,action_id,balance,gender,age_group
)
SELECT gender,age_group,COUNT( CASE WHEN LAST< 0
THEN 1 ELSE NULL
 END) AS total_amount_lost,
COUNT( CASE WHEN LAST >= 0 THEN 1 ELSE NULL
 END) AS total_amount_gained
 FROM QUERY8
 WHERE DR=1
 GROUP BY gender,age_group
 ORDER BY gender,age_group
;

---9
 WITH QUERY12 AS (
 SELECT player_id,SUM(CASE WHEN action_type= 'loss' THEN amount
*-1.0 ELSE amount *1.0 END)
OVER (PARTITION BY(gs.session_id) ORDER BY action_id)
AS balance,	DENSE_RANK() OVER(PARTITION BY(gs.session_id) ORDER BY action_id DESC)
 AS DR
 FROM game_sessions gs
 JOIN session_details d
 ON gs.session_id=d.session_id
 GROUP BY player_id,action_id,amount,gs.session_id,action_type
 )
 SELECT player_id,SUM(balance) AS total_gain
 FROM QUERY12
 WHERE DR=1
 GROUP BY player_id
 ORDER BY player_id
;

---10
WITH QUERY15 AS (SELECT gs.session_id,action_id,action_type,amount ,
 SUM(CASE WHEN action_type= 'loss' THEN amount
*-1.0 ELSE amount *1.0 END)
OVER (PARTITION BY(gs.session_id) ORDER BY action_id)
AS balance,DENSE_RANK () OVER(PARTITION BY gs.session_id ORDER BY action_id DESC)
 AS DR 
 FROM game_sessions gs
 JOIN session_details d
 ON gs.session_id=d.session_id)
 SELECT (SUM(CASE WHEN balance < 0
 THEN balance
  END))*-1.0 AS house_gaines,
 (SUM(CASE WHEN balance >= 0 THEN balance
  END))*-1.0 AS house_losses,
  SUM(CASE WHEN balance >= 0 THEN balance
  END)*-1.0 +
  (SUM(CASE WHEN balance < 0
 THEN balance
  END))*-1.0 AS overall_gain_loss
 FROM QUERY15 
 WHERE DR =1
 
;
---11
WITH QUERY15 AS (SELECT gs.session_id,action_id,action_type,amount ,
 SUM(CASE WHEN action_type= 'loss' THEN amount
*-1.0 ELSE amount *1.0 END)
OVER (PARTITION BY(gs.session_id) ORDER BY action_id)
AS balance,session_begin_date,DENSE_RANK () OVER(PARTITION BY gs.session_id ORDER BY action_id DESC)
 AS DR 
 FROM game_sessions gs
 JOIN session_details d
 ON gs.session_id=d.session_id)
 SELECT YEAR(session_begin_date) AS year,
 DATEPART(QQ,session_begin_date)AS quarter,
 (SUM(CASE WHEN balance < 0
 THEN balance
  END))*-1.0 AS house_gaines,
 (SUM(CASE WHEN balance >= 0 THEN balance
  END))*-1.0 AS house_losses,
  SUM(CASE WHEN balance >= 0 THEN balance
  END)*-1.0 +
  (SUM(CASE WHEN balance < 0
 THEN balance
  END))*-1.0 AS overall_gain_loss
 FROM QUERY15 
 WHERE DR =1
 GROUP BY YEAR(session_begin_date),
 DATEPART(QQ,session_begin_date)
 ORDER BY YEAR(session_begin_date),
 DATEPART(QQ,session_begin_date)
;

---12
WITH QUERY15 AS (SELECT gs.session_id,action_id,action_type,amount ,
 SUM(CASE WHEN action_type= 'loss' THEN amount
*-1.0 ELSE amount *1.0 END)
OVER (PARTITION BY(gs.session_id) ORDER BY action_id)
AS balance,session_begin_date,DENSE_RANK () OVER(PARTITION BY gs.session_id ORDER BY action_id DESC)
 AS DR 
 FROM game_sessions gs
 JOIN session_details d
 ON gs.session_id=d.session_id
 ), QUERY16 AS (
 SELECT YEAR(session_begin_date) AS year,
 DATEPART(MM,session_begin_date)AS month,
 (SUM(CASE WHEN balance < 0
 THEN balance
  END))*-1.0 AS house_gaines,
 (SUM(CASE WHEN balance >= 0 THEN balance
  END))*-1.0 AS house_losses,
  SUM(CASE WHEN balance >= 0 THEN balance
  END)*-1.0 +
  (SUM(CASE WHEN balance < 0
 THEN balance
  END))*-1.0 AS overall_gain_loss
 FROM QUERY15 
 WHERE DR =1
 GROUP BY YEAR(session_begin_date),
 DATEPART(MM,session_begin_date)),
  QUERY17 AS
 (SELECT  year,month,house_gaines,house_losses,overall_gain_loss,DENSE_RANK () OVER (ORDER BY overall_gain_loss ) AS DE,
 DENSE_RANK () OVER (ORDER BY overall_gain_loss DESC) AS DA
FROM QUERY16
 GROUP BY year,month, house_gaines, house_losses,overall_gain_loss
 )
 SELECT year,month,house_gaines,house_losses,
 overall_gain_loss FROM QUERY17
 WHERE DE=1 OR DE=2 OR DE=3 OR DA=3 OR DA=2 OR DA=1
;


