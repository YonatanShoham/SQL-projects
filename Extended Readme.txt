SQL-projects
Contain SQL projects

Final project contain 4 different unrelated databases, each one with his own theme.

Final project

Part1 restaurant database

This database conatin consumer restaurant ratings in Mexico. Including information about each restaurant and its cuisines, as well as each consumer and their unique preferences.

The following segments of SQL code answer the questions below.

What is the number of distinct users, restaurants, ratings, food ratings, and service ratings segment 9

How many times has a person given a review ? segment 2

What is the number of times a restaurant has been rated? segment 3

What can you learn from the restaurants with the highest ratings?

cuisine, number of reveiews

Is there a link between consumer preferences and ratings? segment 8

segment 11 to 17
This part provides statistics for each attribute (Cuisine, Price, Franchise, Area, Alcohol_Service, Smoking_Allowed, Parking) based on the ratings of the restaurants. It focuses on restaurants with the highest possible scores for overall rating, food rating, and service rating.

The results include the following information:

Attribute Count: The number of restaurants that received the highest possible score for the attribute.

Total Count: The total number of restaurants for the attribute, regardless of the rating conditions.

Attribute Percentage: The percentage of restaurants that meet the rating conditions for the attribute, out of the total count for that attribute.

The results are ordered in descending order based on the attribute count percentage.

The purpose of this section is to identify the top qualities in successful restaurants.

Here are the key findings for each attribute:

Cuisine: The top cuisines with the highest percentage of restaurants meeting the rating conditions are International, Vietnamese, and Brewery.

Price: Restaurants in the high price range have the highest percentage of meeting the rating conditions.

Franchise: Non-franchise restaurants have approximately 6% higher percentage than franchise restaurants in meeting the rating conditions.

Area: Restaurants with closed areas have approximately 6% higher percentage than open-spaced restaurants in meeting the rating conditions.

Alcohol Service: Restaurants with full bar service have the highest percentage of meeting the rating conditions.

Parking: Restaurants with valet parking have the highest percentage of meeting the rating conditions.

Smoking: Restaurants where smoking is allowed only in their bar area have the highest percentage of meeting the rating conditions.

explanation for segments 18-25
Smoker: No specific pattern is observed based on the given information. The reviews given by smokers do not show a significant trend in terms of the overall rating, food rating, and service rating.

Drink_Level: Social drinkers tend to give the best reviews. It implies that customers who enjoy social drinking activities are more likely to provide positive feedback on the overall dining experience, food quality, and service.

Transportation_Method: Customers who use cars for transportation tend to give the best reviews. This suggests that individuals who use cars to visit restaurants are more likely to have a positive perception of their dining experience, potentially due to the convenience and ease of access provided by car transportation.

Marital_Status: Married customers tend to give the best reviews. This indicates that individuals who are married are more likely to have positive experiences and provide favorable feedback on the overall rating, food quality, and service at restaurants.

Children: Customers with dependent children tend to give the best reviews. It suggests that individuals who visit restaurants with their children and have dependent family members are more likely to have positive dining experiences and rate the overall experience, food quality, and service more favorably.

Age: Customers of ages 45, 60, 72, and 43 tend to give the best reviews. This suggests that individuals within these specific age groups are more likely to have positive dining experiences and provide higher ratings for the overall experience, food quality, and service at restaurants.

Occupation: Employed customers tend to give the best reviews. It implies that individuals who are employed, regardless of their specific occupation, are more likely to have positive dining experiences and rate the overall experience, food quality, and service more favorably.

Budget: Customers with a higher budget tend to give the best reviews. This indicates that individuals who have a higher spending capacity and are willing to allocate a larger budget for dining out are more likely to have positive experiences and rate the overall experience, food quality, and service more positively.

Are there any demand and supply gaps in the industry that you might take advantage of? Which features would you look for in a restaurant if you were to invest?

I would look for a score of two scores sections of 2 and one score section of 1 or zero thus with an imrpovement of one section of the bussiness it can reach a total of the best score this rating system could grant for it.

Part2 marketing database

This dataset contains 2240 observations (customers), with 28 variables relevant to marketing data. The variables (columns), in particular, give information about: profiles of customers, purchased products, success of the campaign (or failure), performance of the channel

The following segments of SQL code answer the questions below.

What are the factors that have a big impact on the number of online purchases ? segment 8

Which of your marketing campaigns was the most effective ? segment 3

What does a typical consumer look like ? segment 4

Which products are the most effective ? segment 8

Which channels are underperforming ? segment 3

Part3 olympics database

The following dataset contains data about modern Olympic Games, from Athens in 1896 until Rio de Janeiro in 2016. Each row represents a single athlete competing in a single event, including information such as the athlete's name, sex, age, height, weight, nation, and medal, as well as the event's name, sport, games, year, and city.

The following segments of SQL code answer the questions below.

The age distribution of gold medalists. segment 2

Male/female athlete differences across time segment 4

Medals awarded to each country segment 6

Variation of athletes characteristics (age / weight / height) along time / across particular disciplines

segment 7

Part4 toy Sales database

Sales & inventory data for a fictitious chain of toy stores in Mexico, including information about products, stores, daily sales transactions, and current inventory levels at each location.

The following segments of SQL code answer the questions below.

Which product categories drive the biggest profits? Is this the same across store locations? segment 3

Can you find any seasonal trends or patterns in the sales data? segment1

Are sales being lost with out-of-stock products at certain locations? segment 2

How much money is tied up in inventory at the toy stores? How long will it last? segment 4

Project 1 relies on one database wich is called arena.

This project have 12 SQL segments that reaserch the connection between players of various video games to how much money and time they spent on each game and what payment methods they use wich affect sales of items in the various video games.

segment 1 This segment relate between players their email and their credit card type with priortization of certain credit card types over others.

segment 2 This segment relate between player age_group,their gender and the credit card type number per the above categories.

segment 3 This segment relate specific games and their each respective number of sessions, the bigger the number of sessions the assumption is that the game is more popular while considering more factors.

segment 4 This segment relate specific games and their each respective total playing time in minutes. The bigger the amount of time spent the assumption is that the game is more popular while considering more factors similar to the previous segment.

segment 5 This segment relate specific age groups,games and their each respective total playing time in minutes. The bigger the amount of time spent the assumption is that the game is more popular while considering more factors similar to the last segments.

segment 6 This segment relate between players and their ingame money balance in their specific account.

segment 7 This segment count the number of sessions wich ended for the player in loss or gain of his ingame money.

segment 8 This segment count the gender and age group of the players,and in relation to this parametters wich session ended for the player in loss or gain of his ingame money.

segment 9 This segment relate between specific players and their total balance of ingame money.

segment 10 This segment sum the total balance of ingame money and seperate between gain and loss of all the players,when the player win the company looses and vice versa.

segment 11 This segment sum the total balance of ingame money and seperate between gain and loss of all the players seperated to quarter and year.

segment 12 This segment sum the total balance of ingame money and seperate between gain and loss of all the players seperated to month and year. This segment present only the best and the worst 3 months of the game company in terms of gain and loss.

Project 2

This project contain 15 segments that reaserch the connection between authors, articels, the product that the articler published, and the traffic and views of each article trying to measure it's popularity.

segment 1 This segment relate between the author and the article he wrote.

segment 2 This segment relate between article and it's daily views.

segment 3 This segment relate between the product and it's category.

segment 4 This segment relate between article,it's daily views,the product the article advertise and the product views.

segment 5 This segment relate between article,it's total views and the sum of product views.

segment 6 This segment relate between the product the article that advertised the product and the sum of product views.

segment 7 This segment relate between article and it's total daily views

segment 8 This segment relate between the author that wrote the article, the number of articles he wrote and the total views of all the author articles.

segment 9 This segment relate between the author that wrote the article,it's daily views, and the total views per each articles category.

segment 10 This segment relate between the specific category,the specific product,the sum of product views, total views per category and the percentage of total product views per total views per category.

segment 11 This segment relate between month number, weekly day number, total daily article views, total monthly article views and the percentage of total daily article views per total monthly article views.

segment 12 This segment relate between date, articles, total daily article views,total daily views of all articles combined and the percentage of total daily article views per views of all articles combined.

segment 13 This segment relate between articles, it's total views and ranking by total views where the articles with the largest article views get the rank 1.

segment 14 This segment relate between category, product, total product views and ranking by total views where the product with the largest product views get the rank 1.

segment 15 This segment relate between articles, date, views of the prevoius day, views of the current day and the percentage of views of the prevoius day per views of the current day.
