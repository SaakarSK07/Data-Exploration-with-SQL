##Data Exploration with SQL

#Project Title: Comprehensive Business Insights and Analytics Using SQL

#first lets get familair with the data sets


#USing Dataset, after importing the data
USE BITS;


#The following retrieves the client name and other information for clients in Easton city with a credit limit exceeding 2500.
SELECT ClientNum, ClientName, Street, ConsltNum FROM Client WHERE City = 'Easton' AND CreditLimit > 2500;

#This query will return the top 2 clients with the balances over 4000 and will be sorted in descending order based on their balance values.
SELECT * FROM client
WHERE Balance > 4000
ORDER BY Balance DESC
LIMIT 2;


#This query retrieves data from the "Client" table and groups the results by city.
#For each city, it calculates the number of clients (unique "ClientNum" values) and labels the calculated count as "ClientCount." 
#The results are then sorted in descending order by the client count.
SELECT City, COUNT(ClientNum) AS ClientCount 
FROM Client
GROUP BY City
ORDER BY ClientCount DESC;

#, this query retrieves data from three tables and associates information from the "Client," "Consultant," and "WorkOrders" tables.
#It combines client names, consultant last names, and work order dates by performing inner joins based on common keys.
SELECT Client.ClientName, Consultant.FirstName, WorkOrders.ClientNum
FROM Client
INNER JOIN Consultant ON Client.ConsltNum = Consultant.ConsltNum
INNER JOIN WorkOrders ON Client.ClientNum = WorkOrders.ClientNum;


#This query retrieves data from the "Orderline" table (aliased as "O") and combines it with data from the "WorkOrders" table (aliased as "W") using a LEFT JOIN based on the "OrderNum" column.
SELECT O.*, W.OrderDate, W.ClientNum
FROM Orderline O
LEFT JOIN WorkOrders W ON O.OrderNum = W.OrderNum;

#Now, let's perform some analyses to answer typical business questions.

# 1. Consultants with the highest workload:
SELECT LastName, FirstName, Hours
FROM Consultant
ORDER BY Hours DESC;

# 2. Earnings of each consultant:
SELECT LastName, FirstName, (Hours * Rate) AS Earnings
FROM Consultant
ORDER BY Earnings DESC;

# 3. Clients with the highest outstanding balances:
SELECT ClientName, Balance
FROM Client
ORDER BY Balance DESC;

# 4. Average credit limit of clients:
SELECT AVG(CreditLimit) AS AverageCreditLimit
FROM Client;

# 5. Most common types of tasks performed:
SELECT Description, COUNT(*) AS TaskCount
FROM Tasks
JOIN OrderLine ON Tasks.TaskID = OrderLine.TaskID
GROUP BY Description
ORDER BY TaskCount DESC;

# 6. Revenue generated from each category of tasks:
SELECT Category, SUM(QuotedPrice) AS TotalRevenue
FROM Tasks
JOIN OrderLine ON Tasks.TaskID = OrderLine.TaskID
GROUP BY Category
ORDER BY TotalRevenue DESC;

# 7. Number of orders scheduled for each client:
SELECT ClientName, COUNT(*) AS OrderCount
FROM Client
JOIN WorkOrders ON Client.ClientNum = WorkOrders.ClientNum
GROUP BY ClientName
ORDER BY OrderCount DESC;

#8. How many work orders were created each month?
SELECT DATE_FORMAT(OrderDate, '%Y-%m') AS Month, COUNT(OrderNum) AS NumberOfWorkOrders
FROM WorkOrders
GROUP BY Month
ORDER BY Month;

#9. top 5 tasks by total quoted price?
SELECT t.Description, SUM(ol.QuotedPrice) AS TotalQuotedPrice
FROM OrderLine ol
JOIN Tasks t ON ol.TaskID = t.TaskID
GROUP BY t.Description
ORDER BY TotalQuotedPrice DESC
LIMIT 5;

#10. Clients with Balances Exceeding Their Credit Limit
SELECT ClientName, Balance, CreditLimit
FROM Client
WHERE Balance > CreditLimit;
