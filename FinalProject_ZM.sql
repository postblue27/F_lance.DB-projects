

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

USE [master];
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'dbFinalProject_ZM')
	DROP DATABASE dbFinalProject_ZM;
GO

-- Create the dbFinalProject_ZM database.
CREATE DATABASE dbFinalProject_ZM;
GO

-- Specify a simple recovery model 
-- to keep the log growth to a minimum.
ALTER DATABASE dbFinalProject_ZM 
	SET RECOVERY SIMPLE;
GO

USE dbFinalProject_ZM;
GO

-- --------------------------------------------------------------------------------
--	Step #1 : Create table 
-- --------------------------------------------------------------------------------
--1
GO 

CREATE TABLE TCustomers
(
     intCustomerID                       INTEGER         NOT NULL
    ,strFirstName                        VARCHAR(255)     NOT NULL
    ,strLastName                         VARCHAR(255)     NOT NULL
    ,strAddress                          VARCHAR(255)     NOT NULL
    ,intCityID                           INTEGER         NOT NULL
    ,intStateID                          INTEGER         NOT NULL
	,PhoneNumber                         VARCHAR(255)     NOT NULL
    ,CONSTRAINT Customers_table_PK PRIMARY KEY( intCustomerID )
)
--2
GO 

CREATE TABLE TCities
(
    intCityID					    INTEGER			NOT NULL
	,strCity						Varchar(255)	NOT NULL
	,CONSTRAINT TCities_PK PRIMARY KEY (intCityID)
)
--3
GO 

CREATE TABLE TStates
(
	 intStateID						INTEGER			NOT NULL
	,strState       				Varchar(255)	NOT NULL
	,CONSTRAINT TStates_PK PRIMARY KEY ( intStateID )
	)
--4
GO 

CREATE TABLE TStatuses
(
	 intStatusID				    INTEGER			NOT NULL
	,strstatus					    Varchar(255)	NOT NULL
	,CONSTRAINT TStatuses_PK PRIMARY KEY ( intStatusID )
)
--5
GO 

CREATE TABLE TJobs
(
     intJobID                          INTEGER         NOT NULL
    ,strJobdescription                 VARCHAR(255)    NOT NULL
    ,dtmSdate                          DATE            NOT NULL
    ,dtmEdate                          DATE            NOT NULL
	,intCustomerID                     INTEGER         NOT NULL
	,intStatusID                       INTEGER         NOT NULL
    ,CONSTRAINT Job_table_PK PRIMARY KEY( intJobID )
)

--7
GO 

CREATE TABLE TJobsWorks
(
    intjobsWorkID                        INTEGER         NOT NULL
	,intJobID                            INTEGER         NOT NULL
	,intWorkID                           INTEGER         NOT NULL
	,intWorkHours                        VARCHAR(255)     NOT NULL
	,CONSTRAINT JobsWorks_PK PRIMARY KEY( intJobsWorkID )  
)
--8
GO 

CREATE TABLE TWorkers
(
     intWorkerID                        INTEGER         NOT NULL
    ,strFirstname                        VARCHAR(255)     NOT NULL
    ,strLastname                         VARCHAR(255)     NOT NULL
    ,strAddress                          VARCHAR(255)    NOT NULL
    ,strCityID                           INTEGER         NOT NULL
    ,strStateID                          INTEGER         NOT NULL
	,PhoneNumber                         VARCHAR(255)    NULL
	,dtmDateOfHire                       DATE        NOT NULL
	,monHourlyRate                       INTEGER    NOT NULL
    ,CONSTRAINT Workers_table_PK PRIMARY KEY (intWorkerID)
)
--9
GO 

CREATE TABLE TVendors
(
    intVendorsID                        INTEGER         NOT NULL
	,strVendorsName                     VARCHAR(255)    NOT NULL
	,intAddress                         VARCHAR(255)     NOT NULL
	,intCityID                           INTEGER         NOT NULL
	,intPhoneNumber                     VARCHAR(255)     NOT NULL
	,intStateID							INTEGER			NOT NULL
	,CONSTRAINT Vendors_PK PRIMARY KEY( intVendorsID )  
)
--11
GO 

CREATE TABLE TMaterials
(   
     intMaterialID                       INTEGER         NOT NULL
	 ,strDescription                     VARCHAR(255)    NULL
	 ,strMaterialName                    VARCHAR(255)    NOT NULL
	 ,monUnitCost                        VARCHAR(255)    NOT NULL
	 ,intVendorID                        INTEGER         NOT NULL
	 ,CONSTRAINT TMaterials_PK PRIMARY KEY(intMaterialID  )  

)
--10
GO 

CREATE TABLE TSkills
(
     intSkillID                          INTEGER         NOT NULL
	,strSkillName                        VARCHAR(255)    NOT NULL
 ,CONSTRAINT TSkills_PK PRIMARY KEY(intSkillID)  
)
--11
GO 

CREATE TABLE TJobMaterials
(
    intJobMaterialsID                    INTEGER         NOT NULL
	,intJobID                            INTEGER         NOT NULL
	,intMaterialID                       INTEGER         NOT NULL
	,intMaterialQuntity                  INTEGER		 NOT NULL
	,CONSTRAINT TJobMaterials_PK PRIMARY KEY(intJobMaterialsID  )  
)
--12
GO 

CREATE TABLE TWorkerSkills
  (    
	  intWorkerSkillID                    INTEGER         NOT NULL
	  ,intSkillID                         INTEGER         NOT NULL
	  ,intWorkerID						  INTEGER		  NOT NULL
	  ,CONSTRAINT TWorkerSkill_PK PRIMARY KEY(intWorkerSkillID  )  
)

--13
GO 

CREATE TABLE TWorkerJobsHours
  (    
	  intWorkerJobsHoursID                    INTEGER         NOT NULL
	  ,intWorkerID                       INTEGER         NOT NULL
	  ,intJobID							 INTEGER	     NOT NULL
	  ,intHoursWorked					 INTEGER		 NOT NULL
	  ,CONSTRAINT TWorkerJobs_PK PRIMARY KEY(intWorkerJobsHoursID   )  
)
-- --------------------------------------------------------------------------------
-- Step #1: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
-- #	Child										Parent							Column(s)
-- -	-----										------							---------
-- 1	TVendors							        TStates							intStateID --
-- 2	TVendors									TCities					        intCityID  --
-- 3	TMaterials 								    TVendors						intVendorID --
-- 4	TCustomers									TCities							intCityID --
-- 5	TCustomers									TStates					        intStateID --
-- 6	TJobs										TStatuses						intStatusID --
-- 7	TJobs										TCustomers						intCustomerID --
-- 8	TJobMaterials								TJobs					        intJobID --
-- 9	TJobMaterials 								TMaterials					    intMaterialID --
-- 10	TWorkerSkills					            TWorkers						intWorkerID --
-- 11	TWorkerSkills					            TSkills							intSkillID  --
-- 12	TWorkerJobs									TWorkers						TWorkerID --	
-- 13	TWorkerJobs									TJobs 							intJobID --

-- 1
GO 

ALTER TABLE TVendors ADD CONSTRAINT TVendors_TStates_FK
FOREIGN KEY ( intStateID ) REFERENCES TStates ( intStateID )
-- 2
GO 

ALTER TABLE TVendors ADD CONSTRAINT TVendors_TCities_FK
FOREIGN KEY ( intCityID ) REFERENCES TCities ( intCityID )

-- 3
GO 

ALTER TABLE TMaterials ADD CONSTRAINT TMaterials_TVendors_FK
FOREIGN KEY ( intVendorID ) REFERENCES TVendors( intVendorsID )

-- 4
GO 

ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TStates_FK
FOREIGN KEY ( intStateID ) REFERENCES TStates ( intStateID )

-- 5
GO 

ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TCities_FK
FOREIGN KEY ( intCityID ) REFERENCES TCities ( intCityID )

-- 6
GO 

ALTER TABLE TJobs ADD CONSTRAINT TJobs_TStatuses_FK
FOREIGN KEY ( intStatusID ) REFERENCES TStatuses ( intStatusID )

-- 7
GO 

ALTER TABLE TJobs ADD CONSTRAINT TJobs_TCustomers_FK
FOREIGN KEY ( intCustomerID ) REFERENCES TCustomers (intCustomerID )
-- 8
GO 

ALTER TABLE TJobMaterials ADD CONSTRAINT TJobMaterials_TJobs_FK
FOREIGN KEY ( intJobID ) REFERENCES TJobs( intJobID ) ON DELETE CASCADE

-- 
ALTER TABLE TJobMaterials ADD CONSTRAINT TJobMaterials_TMaterials_FK
FOREIGN KEY ( intMaterialID ) REFERENCES TMaterials ( intMaterialID ) ON DELETE CASCADE

-- 10
GO 

ALTER TABLE TWorkerSkills ADD CONSTRAINT TWorkerSkills_TWorkers_FK
FOREIGN KEY ( intWorkerID ) REFERENCES TWorkers ( intWorkerID )

-- 11
GO 

ALTER TABLE TWorkerSkills ADD CONSTRAINT TWorkerSkills_TSkills_FK
FOREIGN KEY ( intSkillID ) REFERENCES TSkills( intSkillID )

-- 12
GO 

ALTER TABLE TWorkerJobsHours ADD CONSTRAINT TWorkerJobsHours_TWorkers_FK
FOREIGN KEY ( intWorkerID ) REFERENCES TWorkers ( intWorkerID ) ON DELETE CASCADE


-- 13
GO 

ALTER TABLE TWorkerJobsHours ADD CONSTRAINT TWorkerJobsHours_TJobs_FK
FOREIGN KEY ( intJobID ) REFERENCES TJobs ( intJobID ) ON DELETE CASCADE
-- --------------------------------------------------------------------------------
-- step #3 Add Date - Inserts
-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------
-- Add Records into TCities 1
-- --------------------------------------------------------------------------------
GO 

INSERT INTO TCities (intCityID,strCity)
VALUES   ( 1, 'Florence' )
		,( 2, 'Hebron' )
		,( 3, 'Thomas' )
-- --------------------------------------------------------------------------------
-- Add Records into States 2
-- --------------------------------------------------------------------------------
GO 

INSERT INTO TStateS( intStateID, strState)
VALUES	 ( 1, 'Kentucky' )
		,( 2, 'Ohio' )
		,( 3, 'Indiana' )
-- --------------------------------------------------------------------------------
-- Add Records into Customers 3
-- ------ --------------------------------------------------------------------------
GO 

INSERT INTO TCustomers(intCustomerID,strFirstName,strLastName,strAddress,intCityID,intStateID,PhoneNumber)
VALUES   ( 1, 'Bob', 'Nields', '8741 Rosebrook Drive', 1 , 1,'8597602063')
        ,( 2, 'Tony', 'Hardan', '2222 Track', 3, 1, '8592222063') 
		,( 3, 'Mary' , 'Beimesch', '4444 Tobertge Drive', 2, 1,'8597603333')
		,( 4, 'Aaliyah' , 'Beimesch', 'Main Street', 2, 1,'8597603333')
		,( 5, 'Alex' , 'Beimesch', 'Main Street', 2, 1,'8597603333')
		,( 6, 'Sandra' , 'Beimesch', 'Main Street', 2, 1,'8597603333')
-- --------------------------------------------------------------------------------
-- Add Records into Statuses 4
-- --------------------------------------------------------------------------------
GO 

INSERT INTO Tstatuses (intstatusID,strstatus)
VALUES  (11,'Open')
        ,(22,'In process')
        ,(33,'Complete')
-- --------------------------------------------------------------------------------
-- Add Records into Jobs 5
-- --------------------------------------------------------------------------------
GO 

INSERT INTO TJobs (intJobID,strJobdescription,dtmSdate,dtmEdate,intCustomerID,intStatusID)
VALUES (1, 'Add Kitchen','02/02/2013','11/03/2015',1,33)
      ,(2,' Master closet','02/02/2011','02/10/2012',2,11)
	  ,(3,'bedrooms','03/01/2013','03/11/2013',3,22)
	  ,(4,'house','04/04/2013','04/09/2013',3,33)
	  ,(5,'road','03/07/2013','11/07/2013',3,33)
	  ,(6,'window','06/09/2013','06/11/2013',3,33)
	  ,(7,'roof','03/09/2013','11/09/2013',3,11)
	  ,(8,'floor','03/09/2013','11/09/2013',3,22)
-- --------------------------------------------------------------------------------
-- Add Records into Workers 6
-- --------------------------------------------------------------------------------
GO 

INSERT INTO TWorkers (intWorkerID,strFirstname,strLastname,strAddress,strCityID,strStateID,dtmDateOfHire,monHourlyRate)
VALUES    (1,'Jay', 'Graue', '1111 SHDHS Drive', 1 ,1,'01/01/2014',10.00)
         ,(2,'Toy','rord','8304 Grey Fox Drive',3,1,'01/01/2014',15.00)
		 ,(3,'Mano','lim','4509 Mian Stree',2,1,'02/06/2019',10.00)	 
		 ,(4,'Lukas','Shvartz','4509 Mian Street',2,1,'02/06/2019',20.00)	
		 ,(5,'Quento','Edvard','4509 Mian Street',2,1,'02/06/2019',18.00)
		 ,(6,'Theodor','Black','4509 Mian Street',2,1,'02/06/2019',16.00)
		 ,(7,'Dmitry','White','4509 Mian Street',2,1,'02/06/2019',12.00)
		 ,(8,'Alex','Brown','4509 Mian Street',2,1,'02/06/2019',14.00)
-- --------------------------------------------------------------------------------
-- Add Records into JobWorks 7
-- --------------------------------------------------------------------------------
GO 

INSERT INTO TWorkerJobsHours(intWorkerJobsHoursID,intJobID,intWorkerID,intHoursWorked)
VALUES (1,2,1,60)
      ,(2,2,2,70)
	  ,(3,3,3,50)
	  ,(4,4,4,30)
	  ,(5,4,5,40)
	  ,(6,4,6,50)
	  ,(7,2,7,18)
	  ,(8,2,8,15)
	  ,(9,6,6,30)
	  ,(10,5,6,30)
-- --------------------------------------------------------------------------------
-- Add Records into Vendors 8
-- --------------------------------------------------------------------------------
GO 

INSERT INTO TVendors (intVendorsID,strVendorsName,intAddress,intCityID,intPhoneNumber, intStateID)
VALUES  (1, 'Kohler','321 Elm St.', 1,'5133311947', 1)
	   ,(2, 'ELKAY','987 Main St.',2,'77762478', 2)
	   ,(3,'Caroma','1569 Windisch Rd.',3,'513331241', 3)
-- --------------------------------------------------------------------------------
-- Add Records into Materials 9
-- --------------------------------------------------------------------------------
GO 

INSERT INTO  TMaterials (intMaterialID,strMaterialName,monUnitCost,intVendorID)
VALUES    (1,'Wood process',200,1)
         ,(2,'paint',100,2)
		 ,(3,'silver',50,3)
		 ,(4,'wood',50,3)
		 ,(5,'pipes',50,3)
-- --------------------------------------------------------------------------------
-- Add Records into Skill 10
-- --------------------------------------------------------------------------------
GO 

INSERT INTO TSkills (intSkillID,strSkillName)
VALUES  (1,'Sand process')
       ,(2,'Paint bedroom')
	   ,(3,'Draw table')
-- --------------------------------------------------------------------------------
-- Add Records into JobMaterials 11
-- --------------------------------------------------------------------------------
GO 

INSERT INTO TJobMaterials (intJobMaterialsID,intJobID,intMaterialID,intMaterialQuntity)
VALUES  (1,1,1,9)
       ,(2,2,2,7)
	   ,(3,3,2,8)
	   ,(4,4,1,8)
	   ,(5,4,2,8)
	   ,(6,5,1,8)
	   ,(7,5,3,8)
	   ,(8,6,1,8)
	   ,(9,6,2,8)
	   ,(10,7,2,8)
	   ,(11,7,3,8)
	   ,(12,8,1,8)
	   ,(13,8,2,8)
-- --------------------------------------------------------------------------------
-- Add Records into WorkerSkill 12
-- --------------------------------------------------------------------------------
GO 

INSERT INTO TWorkerSkills (intWorkerSkillID,intSkillID, intWorkerID)
VALUES (1,1,1)
      ,(2,2,2)
	  ,(3,3,3)
	  ,(4,1,4)
	  ,(5,2,5)
	  ,(6,3,6)
	  ,(7,2,6)
-- --------------------------------------------------------------------------------
--3.1. Create SQL to update the address for a specific customer. Include a select statement before and after the update. 
-- --------------------------------------------------------------------------------
GO
SELECT intCustomerId, strFirstName, strLastName, strAddress FROM TCustomers WHERE intCustomerID = 2
GO
UPDATE TCustomers SET strAddress = 'New address' WHERE intCustomerID = 2
GO
SELECT intCustomerId, strFirstName, strLastName, strAddress FROM TCustomers WHERE intCustomerID = 2
-- --------------------------------------------------------------------------------
--3.2. Create SQL to increase the hourly rate by $2 for each worker that has been an employee for at least 1 year. Include a select before and after the update. Make sure that you have data so that some rows are updated and others are not. 
-- --------------------------------------------------------------------------------
GO
SELECT intWorkerID, strFirstname, strLastname, dtmDateOfHire, monHourlyRate FROM TWorkers 
GO
UPDATE TWorkers SET monHourlyRate = (monHourlyRate + 2) WHERE DATEDIFF(year, dtmDateOfHire, GETDATE()) > 1
GO
SELECT intWorkerID, strFirstname, strLastname, dtmDateOfHire, monHourlyRate FROM TWorkers 

-- --------------------------------------------------------------------------------
--3.3. Create SQL to delete a specific job that has associated work hours and materials assigned to it. Include a select before and after the statement(s). 
-- --------------------------------------------------------------------------------
GO
SELECT TJobs.intJobID, strJobdescription, TMaterials.intMaterialID, strMaterialName, TWorkers.intWorkerID, strFirstname, strLastname, intHoursWorked
FROM TJobs INNER JOIN TJobMaterials ON TJobs.intJobID = TJobMaterials.intJobID 
		   INNER JOIN TMaterials ON TJobMaterials.intMaterialID = TMaterials.intMaterialID
		   INNER JOIN TWorkerJobsHours ON TWorkerJobsHours.intJobID = TJobs.intJobID
		   INNER JOIN TWorkers ON TWorkers.intWorkerID = TWorkerJobsHours.intWorkerID
GO
DELETE FROM TJobs WHERE intJobID = 1
GO
SELECT TJobs.intJobID, strJobdescription, TMaterials.intMaterialID, strMaterialName, TWorkers.intWorkerID, strFirstname, strLastname, intHoursWorked
FROM TJobs INNER JOIN TJobMaterials ON TJobs.intJobID = TJobMaterials.intJobID 
		   INNER JOIN TMaterials ON TJobMaterials.intMaterialID = TMaterials.intMaterialID
		   INNER JOIN TWorkerJobsHours ON TWorkerJobsHours.intJobID = TJobs.intJobID
		   INNER JOIN TWorkers ON TWorkers.intWorkerID = TWorkerJobsHours.intWorkerID
-- --------------------------------------------------------------------------------
--4.1	Write a query to list all jobs that are in process. Include the Job ID and Description, Customer ID and name, and the start date. Order by the Job ID. 
-- --------------------------------------------------------------------------------
GO
SELECT TJobs.intJobID, strJobdescription, TCustomers.intCustomerID, TCustomers.strFirstName, TCustomers.strLastName, dtmSdate
FROM TJobs INNER JOIN TStatuses ON TJobs.intStatusID = TStatuses.intStatusID
		   INNER JOIN TCustomers ON TJobs.intCustomerID = TCustomers.intCustomerID
WHERE TStatuses.strstatus = 'In process' ORDER BY TJobs.intJobID
 
-- --------------------------------------------------------------------------------
--4.2
-- --------------------------------------------------------------------------------
GO
SELECT TCustomers.intCustomerID, TCustomers.strFirstName, TCustomers.strLastName, 
	   TJobs.intJobID, strJobdescription, strstatus, TMaterials.intMaterialID, TMaterials.strMaterialName,
	   TMaterials.monUnitCost, TJobMaterials.intMaterialQuntity, 
	   (TJobMaterials.intMaterialQuntity * TMaterials.monUnitCost) AS 'Total Cost'
FROM TJobs INNER JOIN TJobMaterials ON TJobs.intJobID = TJobMaterials.intJobID 
		   INNER JOIN TMaterials ON TJobMaterials.intMaterialID = TMaterials.intMaterialID
		   INNER JOIN TStatuses ON TJobs.intStatusID = TStatuses.intStatusID
		   INNER JOIN TCustomers ON TJobs.intCustomerID = TCustomers.intCustomerID
WHERE TStatuses.strstatus = 'Complete' AND TCustomers.intCustomerID = 3 
ORDER BY TJobs.intJobID, TMaterials.intMaterialID
-- --------------------------------------------------------------------------------
--4.3
-- --------------------------------------------------------------------------------
GO
SELECT intCustomerID, strFirstName, strLastName, 
	   intJobID, strJobdescription, strstatus, SUM(TotalCost) 
FROM (SELECT TCustomers.intCustomerID, TCustomers.strFirstName, TCustomers.strLastName, 
		   TJobs.intJobID, strJobdescription, strstatus, TMaterials.intMaterialID, TMaterials.strMaterialName,
		   TMaterials.monUnitCost, TJobMaterials.intMaterialQuntity, 
		   (TJobMaterials.intMaterialQuntity * TMaterials.monUnitCost) AS 'TotalCost'
	FROM TJobs INNER JOIN TJobMaterials ON TJobs.intJobID = TJobMaterials.intJobID 
			   INNER JOIN TMaterials ON TJobMaterials.intMaterialID = TMaterials.intMaterialID
			   INNER JOIN TStatuses ON TJobs.intStatusID = TStatuses.intStatusID
			   INNER JOIN TCustomers ON TJobs.intCustomerID = TCustomers.intCustomerID
	WHERE TStatuses.strstatus = 'Complete' AND TCustomers.intCustomerID = 3 ) t 
GROUP BY intCustomerID, strFirstName, strLastName, intJobID, strJobdescription, strstatus
-- --------------------------------------------------------------------------------
--4.4
-- --------------------------------------------------------------------------------
GO
SELECT TJobs.intJobID, strJobdescription, strstatus, SUM(TWorkerJobsHours.intHoursWorked) AS 'TotalHours', 
	MIN(TWorkers.monHourlyRate) AS 'minHourlyRate', MAX(TWorkers.monHourlyRate) AS 'maxHourlyRate', 
	SUM(TWorkerJobsHours.intHoursWorked * monHourlyRate)/SUM(TWorkerJobsHours.intHoursWorked) AS avgBasedOnHours
FROM TJobs INNER JOIN TWorkerJobsHours ON TJobs.intJobID = TWorkerJobsHours.intJobID
		   INNER JOIN TWorkers ON TWorkers.intWorkerID = TWorkerJobsHours.intWorkerID
		   INNER JOIN TStatuses ON TJobs.intStatusID = TStatuses.intStatusID
GROUP BY TJobs.intJobID, strJobdescription, strstatus
-- --------------------------------------------------------------------------------
--4.5
-- --------------------------------------------------------------------------------
GO
SELECT t.intMaterialID, t.strMaterialName FROM TMaterials t
WHERE t.intMaterialID NOT IN (SELECT TMaterials.intMaterialID
								FROM TMaterials INNER JOIN TJobMaterials ON TMaterials.intMaterialID = TJobMaterials.intMaterialID
								INNER JOIN TJobs ON TJobs.intJobID = TJobMaterials.intJobID)
ORDER BY t.intMaterialID
-- --------------------------------------------------------------------------------
--4.6
-- --------------------------------------------------------------------------------
GO
SELECT TSkills.intSkillID, TSkills.strSkillName, TWorkers.intWorkerID, TWorkers.strFirstname,
		TWorkers.strLastname, TWorkers.dtmDateOfHire, COUNT(TJobs.intJobID) AS 'numOfJobs'
FROM TSkills INNER JOIN TWorkerSkills ON TWorkerSkills.intSkillID = TSkills.intSkillID
			 INNER JOIN TWorkers ON TWorkers.intWorkerID = TWorkerSkills.intWorkerID
			 INNER JOIN TWorkerJobsHours ON TWorkerJobsHours.intWorkerID = TWorkers.intWorkerID
			 INNER JOIN TJobs ON TJobs.intJobID = TWorkerJobsHours.intJobID
WHERE TSkills.strSkillName = 'Draw table'
GROUP BY TSkills.intSkillID, TSkills.strSkillName, TWorkers.intWorkerID, TWorkers.strFirstname,
		TWorkers.strLastname, TWorkers.dtmDateOfHire
ORDER BY TWorkers.intWorkerID

-- --------------------------------------------------------------------------------
--4.7
-- --------------------------------------------------------------------------------
GO
SELECT TWorkers.intWorkerID, TWorkers.strFirstname, TWorkers.strLastname, 
	   SUM(TWorkerJobsHours.intHoursWorked) AS 'TotalHoursWorked', COUNT(TJobs.intJobID) AS 'numOfJobs'
FROM TWorkers INNER JOIN TWorkerJobsHours ON TWorkerJobsHours.intWorkerID = TWorkers.intWorkerID
			  INNER JOIN TJobs ON TJobs.intJobID = TWorkerJobsHours.intJobID
WHERE TWorkers.intWorkerID NOT IN (SELECT t1.intWorkerID FROM TWorkerJobsHours t1 WHERE t1.intHoursWorked < 20)
GROUP BY TWorkers.intWorkerID, TWorkers.strFirstname, TWorkers.strLastname
ORDER BY TWorkers.intWorkerID

-- --------------------------------------------------------------------------------
--4.8
-- --------------------------------------------------------------------------------
GO
SELECT TCustomers.intCustomerID, TCustomers.strAddress, TCities.strCity, TStates.strState
FROM TCustomers INNER JOIN TCities ON TCustomers.intCityID = TCities.intCityID
			  INNER JOIN TStates ON TCustomers.intStateID= TStates.intStateID
WHERE TCustomers.strAddress = 'Main Street'
ORDER BY TCustomers.intCustomerID
-- --------------------------------------------------------------------------------
--4.9
-- --------------------------------------------------------------------------------

GO
SELECT TJobs.intJobID, TJobs.strJobdescription, TStatuses.strstatus, TJobs.dtmSdate, TJobs.dtmEdate
FROM TJobs INNER JOIN TStatuses ON TJobs.intStatusID = TStatuses.intStatusID
WHERE TStatuses.strstatus = 'Complete' AND MONTH(TJobs.dtmSdate) = MONTH(TJobs.dtmEdate) 
		AND YEAR(TJobs.dtmSdate) = YEAR(TJobs.dtmEdate) 

-- --------------------------------------------------------------------------------
--4.10
-- --------------------------------------------------------------------------------
GO
SELECT TWorkers.intWorkerID, TWorkers.strFirstname, TWorkers.strLastname, 
	    COUNT(TJobs.intJobID) AS 'numOfJobsForCustomer'
FROM TWorkers INNER JOIN TWorkerJobsHours ON TWorkerJobsHours.intWorkerID = TWorkers.intWorkerID
			  INNER JOIN TJobs ON TJobs.intJobID = TWorkerJobsHours.intJobID
			  INNER JOIN TCustomers ON TCustomers.intCustomerID = TJobs.intCustomerID

GROUP BY TWorkers.intWorkerID, TWorkers.strFirstname, TWorkers.strLastname HAVING COUNT(TJobs.intJobID) >= 3
ORDER BY TWorkers.intWorkerID
-- --------------------------------------------------------------------------------
--4.11
-- --------------------------------------------------------------------------------
GO
SELECT TWorkers.intWorkerID, TWorkers.strFirstname, TWorkers.strLastname, 
		COUNT(TSkills.intSkillID) AS 'CountOfSkills'
FROM TWorkers LEFT JOIN TWorkerSkills ON TWorkerSkills.intWorkerID = TWorkers.intWorkerID
			 LEFT JOIN TSkills ON TSkills.intSkillID = TWorkerSkills.intSkillID
GROUP BY TWorkers.intWorkerID, TWorkers.strFirstname, TWorkers.strLastname
ORDER BY TWorkers.intWorkerID
-- --------------------------------------------------------------------------------
--4.12
-- --------------------------------------------------------------------------------
GO
SELECT TCustomers.intCustomerID, TCustomers.strFirstName, TCustomers.strLastName, TJobs.intJobID,
		TJobs.strJobdescription, ((TJobMaterials.intMaterialQuntity * TMaterials.monUnitCost) + 
			(TWorkers.monHourlyRate * TWorkerJobsHours.intHoursWorked)) AS 'CHARGE'
FROM TCustomers INNER JOIN TJobs ON TJobs.intCustomerID = TCustomers.intCustomerID
			 INNER JOIN TJobMaterials ON TJobMaterials.intJobID = TJobs.intJobID
			 INNER JOIN TMaterials ON TMaterials.intMaterialID = TJobMaterials.intMaterialID
			 INNER JOIN TWorkerJobsHours ON TWorkerJobsHours.intJobID = TJobs.intJobID
			 INNER JOIN TWorkers ON TWorkerJobsHours.intWorkerID = TWorkers.intWorkerID


-- --------------------------------------------------------------------------------
--4.13
-- --------------------------------------------------------------------------------
GO
SELECT TVendors.intVendorsID, TVendors.strVendorsName, TJobs.intJobID, TJobs.strJobdescription,
	SUM(TMaterials.monUnitCost * TJobMaterials.intMaterialQuntity)
FROM TVendors INNER JOIN TMaterials ON TVendors.intVendorsID = TMaterials.intVendorID
			 INNER JOIN TJobMaterials ON TJobMaterials.intMaterialID = TMaterials.intMaterialID
			 INNER JOIN TJobs ON TJobs.intJobID = TJobMaterials.intJobID
GROUP BY TVendors.intVendorsID, TVendors.strVendorsName, TJobs.intJobID, TJobs.strJobdescription