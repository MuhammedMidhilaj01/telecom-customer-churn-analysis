create database churn_analysis;
use churn_analysis
CREATE TABLE churn_data (
customerID VARCHAR(20),
gender VARCHAR(10),
SeniorCitizen INT,
Partner VARCHAR(5),
Dependents VARCHAR(5),
tenure INT,
PhoneService VARCHAR(5),
MultipleLines VARCHAR(20),
InternetService VARCHAR(20),
OnlineSecurity VARCHAR(20),
OnlineBackup VARCHAR(20),
DeviceProtection VARCHAR(20),
TechSupport VARCHAR(20),
StreamingTV VARCHAR(20),
StreamingMovies VARCHAR(20),
Contract VARCHAR(20),
PaperlessBilling VARCHAR(5),
PaymentMethod VARCHAR(50),
MonthlyCharges DECIMAL(10,2),
TotalCharges DECIMAL(10,2),
Churn VARCHAR(5)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/churn_cleaned.csv'
INTO TABLE churn_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT * 
FROM churn_data
LIMIT 10;

SELECT COUNT(*) 
FROM churn_data;

SELECT COUNT(*) AS total_customers
FROM churn_data;

SELECT 
Churn,
COUNT(*) AS customer_count
FROM churn_data
GROUP BY Churn;


### churn rate percentage
SELECT 
ROUND(
SUM(CASE WHEN TRIM(Churn) = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
2
) AS churn_rate_percentage
FROM churn_data;

SELECT Churn, LENGTH(Churn)
FROM churn_data
LIMIT 10;

UPDATE churn_data
SET Churn = TRIM(Churn);
 SET SQL_SAFE_UPDATES = 0;
 SET SQL_SAFE_UPDATES = 0
 UPDATE churn_data
SET Churn = TRIM(Churn);
SELECT Churn, LENGTH(Churn)
FROM churn_data
LIMIT 10;
UPDATE churn_data
SET Churn = REPLACE(TRIM(Churn), ' ', '');
UPDATE churn_data
SET Churn = REPLACE(REPLACE(REPLACE(Churn, '\r', ''), '\n', ''), '\t', '');
 UPDATE churn_data
SET Churn = TRIM(Churn);

SELECT Churn, LENGTH(Churn)
FROM churn_data
LIMIT 10;
 SELECT Churn, LENGTH(Churn)
FROM churn_data
LIMIT 10;

SELECT COUNT(*)
FROM churn_data
WHERE Churn = 'Yes';
SELECT DISTINCT Churn
FROM churn_data;
SELECT 
TRIM(Churn) AS churn_status,
COUNT(*) AS customers
FROM churn_data
GROUP BY TRIM(Churn);

### churn by contract
SELECT 
Contract,
Churn,
COUNT(*) AS customers
FROM churn_data
GROUP BY Contract, Churn;

### churn by internet services
SELECT 
InternetService,
Churn,
COUNT(*) AS customers
FROM churn_data
GROUP BY InternetService, Churn;

### churn by payment method
SELECT 
PaymentMethod,
Churn,
COUNT(*) AS customers
FROM churn_data
GROUP BY PaymentMethod, Churn;

### average monthly charges by churn
SELECT 
Churn,
AVG(MonthlyCharges) AS avg_monthly_charges
FROM churn_data
GROUP BY Churn;

### revenue loss due to churn
SELECT 
SUM(MonthlyCharges) AS monthly_revenue_lost
FROM churn_data
WHERE Churn='Yes';

### high value customers
SELECT 
customerID,
MonthlyCharges,
TotalCharges
FROM churn_data
ORDER BY TotalCharges DESC
LIMIT 10;

### churn by tenure
SELECT 
tenure,
Churn,
COUNT(*) AS customers
FROM churn_data
GROUP BY tenure, Churn;