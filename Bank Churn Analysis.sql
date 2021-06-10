DROP SCHEMA IF EXISTS bankcustomerschurn;
CREATE SCHEMA bankcustomerschurn;

CREATE TABLE churn(
RowNumber INT(5),
CustomerID INT(8),
Surname VARCHAR(255),
CreditScore INT(3),
Geography VARCHAR(255),
Gender VARCHAR(6),
Age INT(2),
Tenure INT(2),
Balance VARCHAR(255),
NumOfProducts INT(2),
HasCrCard VARCHAR(3),
IsActiveMember VARCHAR(3),
EstimatedSalary VARCHAR(255),
Exited VARCHAR(3));


/*DATA CLEANING SECTION:*/

/* Step 1:
 To avoid confusion with other numeric columns,
 “1” and “0” will be replaced with “Yes” and “No” across the columns “HasCrCard”, “IsActiveMember” and “Exited” */

SELECT HasCrCard,
CASE
WHEN HasCrCard = 1 THEN 'Yes'
WHEN HasCrCard = 0 THEN 'No'
 END AS HasCrCard
 FROM churn;
 
UPDATE churn
SET HasCrCard = CASE
WHEN HasCrCard = 1 THEN 'Yes'
WHEN HasCrCard = 0 THEN 'No'
 END;
 

SELECT IsActiveMember,
CASE
WHEN IsActiveMember = 1 THEN 'Yes'
WHEN IsActiveMember = 0 THEN 'No'
 END AS IsActiveMember
 FROM churn;
 
UPDATE churn
SET IsActiveMember = CASE
WHEN IsActiveMember = 1 THEN 'Yes'
WHEN IsActiveMember = 0 THEN 'No'
 END;

SELECT Exited,
CASE
WHEN Exited = 1 THEN 'Yes'
WHEN Exited = 0 THEN 'No'
 END AS Exited
 FROM churn;
 
UPDATE churn
SET Exited = CASE
WHEN Exited = 1 THEN 'Yes'
WHEN Exited = 0 THEN 'No'
 END;
 
/* SELECT * FROM churn*/

/*Step 2: Now for better clarity, below column headers will be updated:
Geography to Country
NumofProducts to NumofProductsPurchased
Exited to HasCustomerExitedBank
Tenure to TenureInYears*/

ALTER TABLE churn 
CHANGE COLUMN Geography Country VARCHAR(255)

ALTER TABLE churn 
CHANGE COLUMN NumofProducts NumofProductsPurchased INT(2)

ALTER TABLE churn
CHANGE COLUMN Exited HasCustomerExitedBank VARCHAR(3)

ALTER TABLE churn
CHANGE COLUMN Tenure TenureInYears INT(2)

/*DATA ANALYSIS SECTION* - Focussing only on France data/

/*First, the Churn Rate will be calculated: Total no. of exited customers in France/Total no. of customers in France */

SELECT COUNT(HasCustomerExitedBank)
FROM churn
WHERE Country = 'France' AND HasCustomerExitedBank = 'Yes'

/*The total no. of exited customers of France are 810*/

SELECT COUNT(HasCustomerExitedBank)
FROM churn
WHERE Country = 'France'

/*Output: The total number of customers in France are 5014*/

/*Now, calculating Churn Rate in France*/
*SELECT 810/5014*
/*Output: Churn Rate in France is 0.16*/

/*Now, the compartive analysis between exited and non-exited customers in France*/

/*Section A: Exited customers' analysis*/

/*Q.1: What was average tenure of exited customers in France with the bank?*/
SELECT AVG(TenureInYears) as avg_tenure
FROM churn
WHERE Country = 'France' AND HasCustomerExitedBank = 'Yes'
/* Output: 5 years was average tenure of exited customers in France with the bank*/

/*Q.2: Among exited customers, how many were active customers and inactive customers?*/
SELECT COUNT(IsActiveMember), HasCustomerExitedBank
FROM churn
WHERE Country = 'France' AND IsActiveMember = 'Yes' AND HasCustomerExitedBank = 'Yes'
/*Ouput: Among exited customers, 298 customers were active*/

SELECT COUNT(IsActiveMember), HasCustomerExitedBank
FROM churn
WHERE Country = 'France' AND IsActiveMember = 'No' AND HasCustomerExitedBank = 'Yes'*/
/*Ouput: Among exited customers, 512 customers were inactive

Q.3: What was average no. of bank products purchased by exited customers?*/
/*SELECT AVG(NumOfProductsPurchased) FROM churn
WHERE Country = 'France' AND HasCustomerExitedBank = 'Yes'
/*The avg no. of bank products for exited customers was 2*/

/*Q.4: What was average age of exited customers in France?*/
SELECT AVG(AGE)
FROM churn
WHERE Country = 'France' AND HasCustomerExitedBank = 'Yes'
/* 45yrs was average age of exited customers in France*/

/*Q.5: What was average credit score of exited customers in France?*/
SELECT AVG(CreditScore) 
FROM churn
WHERE Country = 'France' AND HasCustomerExitedBank = 'Yes'
/* 642 was average credit score of exited customers in France*/

/*Q.6: What was gender distribution of exited customers in France?"*/
SELECT COUNT(Gender) 
FROM churn
WHERE Country = 'France' AND HasCustomerExitedBank = 'Yes' AND Gender = 'Male'
/*Output: 350 Males exited bank in France*/

SELECT COUNT(Gender) 
FROM churn
WHERE Country = 'France' AND HasCustomerExitedBank = 'Yes' AND Gender = 'Female'
/*Output: 460 Females exited bank in France*/
