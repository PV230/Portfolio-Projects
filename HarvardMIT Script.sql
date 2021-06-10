CREATE DATABASE HarvardMIT;
CREATE TABLE courses(
Institution VARCHAR(8),
Course_Number VARCHAR(255),
Launch_Date VARCHAR(255),
Course_Title VARCHAR(255),
Instructors VARCHAR(255),
Course_Subject VARCHAR(255),
Participants INT(10),
Certified INT(6),
Audited_Percentage FLOAT(4,2),
Certified_Percentage FLOAT(4,2),
Played_Video_Percentage FLOAT(4,2),
Percentage_Grade_Higher_Than_Zero FLOAT(4,2),
Total_Course_Hours_In_Thousands FLOAT(10,5),
Median_Age INT(2),
Percentage_of_Male_Participants FLOAT(4,2),
Percentage_of_Female_Participants FLOAT(4,2),
Bachelors_Degree_or_Higher_Percentage FLOAT(4,2));

/*SELECT * FROM courses*/

/* Display a list of all introductory-level courses launched by Harvard in the year 2012, with more than 10,000 participants */
SELECT Institution, Course_Title, Course_Number, Launch_Date, Participants
FROM courses
WHERE Institution = 'HarvardX' AND Course_Title LIKE 'Introduction%'
GROUP BY Participants
HAVING Participants > 10000

/* Display all course titles containing an average of more than 10% certified participants' percentage */
SELECT Course_Title, 
AVG(Certified_Percentage) AS Avg_certified_percentage
FROM courses
GROUP BY Course_Title
HAVING AVG(Certified_Percentage) > 10
ORDER BY Course_Title;

/* Display all course titles, along with average, min and max of certified participants, grouped by course subjects */
SELECT Course_Subject,
Course_Title,
MIN(Certified) AS min_number_of_certified_participants,
MAX(Certified) AS min_number_of_certified_participants,
AVG(Certified) AS avg_number_of_certified_participants
FROM courses
GROUP BY Course_Subject


/* Display only MIT course list containing all the course titles, course numbers and instructor names, 
sorted by number of participants (from highest to lowest) */
SELECT Course_Title,
Course_Number,
Instructors,
Participants
FROM courses
WHERE Institution = 'MITx'
ORDER BY Participants DESC;

/* Categorize the Median Age of learners into two categories – learners aged more than 30 and learners aged less than 30. 
Display this new list against Course Subjects */
SELECT Course_Subject,
CASE
WHEN Median_Age < 30 THEN 'Less than 30yrs'
WHEN Median_Age = 30 THEN '30 yrs'
WHEN Median_Age > 30 THEN 'More than 30yrs'
ELSE 'Check logic!'
END AS New_Median_Age_Category
FROM courses

/* Display number of the instances within two categories containing more than 30 and less than 30 years */
SELECT Course_Subject,
COUNT(CASE WHEN Median_Age < 30 THEN 'Less than 30yrs' ELSE NULL END) AS less_than_thirty_years,
COUNT(CASE WHEN Median_Age > 30 THEN 'More than 30yrs' ELSE NULL END) AS more_than_thirty_years
FROM courses
GROUP BY Course_Subject
ORDER BY Course_Subject;