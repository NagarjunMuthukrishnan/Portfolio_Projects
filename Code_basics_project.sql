#Creating a new database

CREATE DATABASE code_basics_project;
USE code_basics_project;
SHOW TABLES;

#Identifying the city of the respondents

SELECT A.Respondent_ID, A.Name, A.Age, A.Gender, B.City, B.Tier 
FROM RESPONDENT AS A
INNER JOIN CITY AS B
ON A.City_ID = B.City_ID;

#Identifying the response id of each respondent

SELECT C.*
FROM RESPONDENT AS A
INNER JOIN SURVEY AS C
ON A.Respondent_ID = C.Respondent_ID;

#Combining Tables

SELECT A.Name, A.Age, A.Gender, B.City, B.Tier, C.*
FROM RESPONDENT AS A
INNER JOIN CITY AS B ON A.City_ID = B.City_ID
INNER JOIN SURVEY AS C ON A.Respondent_ID = C.Respondent_ID;

#Creating a new table with the result

CREATE TABLE RESPONSES AS
SELECT A.Name, A.Age, A.Gender, B.City, B.Tier, C.*
FROM RESPONDENT AS A
INNER JOIN CITY AS B ON A.City_ID = B.City_ID
INNER JOIN SURVEY AS C ON A.Respondent_ID = C.Respondent_ID;

#Selecting all information from responses table

SELECT * FROM RESPONSES;

#1.Who prefers energy drink more? (Male,Female,Non-binary)

ALTER TABLE Responses
ADD COLUMN frequencypermonth INT;

UPDATE Responses
SET frequencypermonth = 
CASE 
WHEN Consume_frequency = 'Rarely' THEN 1
WHEN Consume_frequency = '2-3 times a week' THEN 12
WHEN Consume_frequency = '2-3 times a month' THEN 3
WHEN Consume_frequency = 'Daily' THEN 30
WHEN Consume_frequency = 'Once a week' THEN 4
END;

SELECT  Gender, Sum(frequencypermonth) AS Total_consumers
FROM RESPONSES
WHERE Heard_before = 'Yes'
GROUP BY Gender
Order by Total_consumers DESC;

#2. Which age group prefers enery drink more?

SELECT Age, Sum(frequencypermonth) AS Total_consumers
FROM Responses
WHERE Heard_before = 'Yes'
GROUP BY Age
Order by Total_consumers DESC;

#3. Which type of marketing reaches the most youth?

SELECT Marketing_channels, COUNT(Marketing_channels) AS Count_Marketing_channels
FROM Responses
WHERE (Age = '15-18' OR Age = '19-30')
AND Heard_before = 'YES'
GROUP BY Marketing_channels
ORDER BY Count_Marketing_channels DESC;

#4.What are the preferred ingredients of energy drinks among respondents?

SELECT COUNT(Respondent_ID) AS Total_respondents, Ingredients_expected
FROM Responses
WHERE Heard_before = 'Yes'
Group by Ingredients_expected
Order by Total_respondents DESC;

#5. What packaging preferences do respondents have for energy drinks?

SELECT COUNT(Respondent_ID) AS Total_respondents, Packaging_preference 
FROM Responses
WHERE Heard_before = 'Yes'
GROUP BY Packaging_preference
Order by Total_respondents DESC;

#6. Who are the current market leaders?

SELECT COUNT(Respondent_ID) AS Total_respondents, Current_brands
FROM Responses
GROUP BY Current_brands
order by Total_respondents DESC;

#7. What are the primary reasons consumers prefer those brands over ours?

SELECT COUNT(Respondent_ID) AS Total_respondents, Reasons_preventing_trying
FROM Responses
GROUP BY Reasons_preventing_trying
Order by Total_respondents DESC;

#8. Which marketing channel can be used to reach more customers?

SELECT COUNT(Respondent_ID) AS Total_respondents, Marketing_channels
FROM Responses
GROUP BY Marketing_channels
Order by Total_respondents DESC;

#9. How effective are different marketing strategies and channels in reaching our customers?

SELECT COUNT(Respondent_ID) AS Total_respondents, Heard_before
FROM Responses
GROUP BY Heard_before
Order by Total_respondents DESC;

#10. What do people think about our brand?

SELECT COUNT(Respondent_ID) AS Total_respondents, Brand_perception
FROM Responses
GROUP BY Brand_perception 
Order by Total_respondents DESC;

#11. Which cities do we need to focus more on?

SELECT COUNT(Respondent_ID) AS Total_respondents, City
FROM Responses
GROUP BY City
Order by Total_respondents DESC;

#12. Where do respondents prefer to purchase energy drinks?

SELECT COUNT(Respondent_ID) AS Total_respondents, Purchase_location
FROM Responses
GROUP BY Purchase_Location
ORDER BY Total_respondents DESC;

#13.  What are the typical consumption situations for energy drinks among respondents?

SELECT COUNT(Respondent_ID) AS Total_respondents, Typical_consumption_situations
FROM Responses
GROUP BY Typical_consumption_situations
ORDER BY Total_respondents DESC;

#14. What factors influence respondents' purchase decisions, such as price range and limited edition packaging?

SELECT COUNT(Respondent_ID) AS Total_respondents, Price_range, Limited_edition_packaging
FROM Responses
GROUP BY Price_range, Limited_edition_packaging
ORDER BY Total_respondents DESC, Limited_edition_packaging;

#15. Which area of business should we focus more on our product development?

SELECT COUNT(Respondent_ID) AS Total_respondents, Reasons_for_choosing_brands
FROM Responses
GROUP BY Reasons_for_choosing_brands
ORDER BY Total_respondents DESC;

/*Recommendations for CodeX:
1. Immediate improvements we can bring to the product
We can reduce the sugar content and use more natural ingredients*/

SELECT COUNT(Respondent_ID) AS Total_respondents, Improvements_desired
FROM Responses
Group by Improvements_desired
ORDER BY Total_respondents DESC;

/*
2. Ideal price of our product
Pricing the product in the range of 50-99 would be ideal*/

SELECT COUNT(Respondent_ID) AS Total_respondents, Price_range
FROM Responses
GROUP BY Price_range
ORDER BY Total_respondents DESC;

/*
3.  What kind of marketing campaigns, offers, and discounts we can run?
We can run online ads and TV commercials*/

SELECT COUNT(Respondent_ID) AS Total_respondents, Marketing_channels
FROM Responses
GROUP BY Marketing_channels
ORDER BY Total_respondents DESC;

/*
4. Who can be a brand ambassador, and why?
Any sportsperson/athelete or fitness influencers can be a brand ambassador because most people consume energy drinks while sports/exercise*/

SELECT COUNT(Respondent_ID) AS Total_respondents, Typical_consumption_situations
FROM Responses
GROUP BY Typical_consumption_situations
ORDER BY Total_respondents DESC;

/*
5. Who should be our target audience, and why?
Our target audience should be male with the age of 19-30, because most of our respondents lies under this category*/

SELECT COUNT(Respondent_ID) AS Total_respondents, Gender, Age
FROM Responses
Group by Gender, Age
ORDER BY Total_respondents DESC;

##These were the Insights to the Marketing Team in Food & Beverage Industry
