Drop TABLE IF EXISTS Centre CASCADE;
DROP TABLE IF EXISTS Car CASCADE;
DROP TABLE IF EXISTS School CASCADE;
DROP TABLE IF EXISTS AdminStaff;
DROP TABLE IF EXISTS Instructor CASCADE;
DROP TABLE IF EXISTS Client;
DROP TABLE IF EXISTS Lesson;
DROP TABLE IF EXISTS Test;

CREATE TABLE Centre(
    CentreID INT PRIMARY KEY, 
    Name VARCHAR(255), 
    Address VARCHAR(255), 
    PhoneNo CHAR(255) 
);

CREATE TABLE Car(
    CarID INT PRIMARY KEY, 
    RegNO CHAR(255), 
    Model CHAR(255) 
);

CREATE TABLE School(
    SchoolID INT PRIMARY KEY,
    Address VARCHAR(255)
);

CREATE TABLE AdminStaff(
    EmpID INTEGER PRIMARY KEY,
    Forename CHAR(255),
    Surname CHAR(255),
    Gender CHAR(1) CHECK ( gender IN ('F', 'M','O') ),
    PhoneNo CHAR(255),
    Address VARCHAR(255),
    Role TEXT,
    SchoolID INT,
    FOREIGN KEY (SchoolID) REFERENCES School (SchoolID)
);

CREATE TABLE Instructor(
    EmpID INTEGER PRIMARY KEY,
    Forename CHAR(255),
    Surname CHAR(255),
    Gender CHAR(1) CHECK ( gender IN ('F', 'M','O') ),
    PhoneNo CHAR(255),
    Address VARCHAR(255),
    LicenceNo VARCHAR(255),
    SchoolID INT,
    CarID INTEGER,
    FOREIGN KEY (SchoolID) REFERENCES School (SchoolID),
    FOREIGN KEY (CarID) REFERENCES Car (CarID)
);

CREATE TABLE Client(
    ClientID INTEGER PRIMARY KEY,
    Forename CHAR(255),
    Surname CHAR(255),
    Gender CHAR(1) CHECK ( gender IN ('F', 'M','O') ),
    DoB DATE,
    PhoneNo CHAR(255),
    Address VARCHAR(255),
    ProvlicenceNo VARCHAR(255)
);

CREATE TABLE Lesson(
    OnDate DATE,
    OnTime TIME(2),
    ClientID INTEGER,
    EmpID INTEGER,
    PRIMARY KEY(OnDate, OnTime, ClientID),
    FOREIGN KEY (EmpID) REFERENCES Instructor (EmpID)
);

CREATE TABLE Test(
    OnDate DATE,
    OnTime TIME(2),
    ClientID INTEGER,
    EmpID INTEGER,
    CentreID INT,
    Status CHAR(255),
    Reason VARCHAR(500),
    PRIMARY KEY(OnDate, OnTime, ClientID),
    FOREIGN KEY (EmpID) REFERENCES Instructor (EmpID),
    FOREIGN KEY (CentreID) REFERENCES Centre (CentreID)
);

---Insert into Centre---
INSERT INTO Centre
VALUES ('1','Canterbury','12 Meryl Street','+44 1227-968-5287');

INSERT INTO Centre
VALUES ('2','Whitstable','5 The Strand, Whitstable','01227457012');


INSERT INTO Centre
VALUES ('3','Faversham','1 High Street, Whitstable','01795 865129');

---Insert into Car---
INSERT INTO Car
VALUES ('124','BD51 SMR','VW POLO');

INSERT INTO Car
VALUES ('653', 'WS62 QWE', 'Ford Focus');

INSERT INTO Car
VALUES ('912', 'FD52 TGF', 'VW Polo');

INSERT INTO Car
VALUES ('167', 'FD52 YTR', 'VW Polo');

---Insert into School---
INSERT INTO School
VALUES ('1','12 Whitechapel, Canterbury');

INSERT INTO School
VALUES ('2','9 Middle Wall, Whitstable');

---Insert into AdminStaff---
INSERT INTO AdminStaff
VALUES ('1006','Fred','Grimes','M','012275435665','27 Cherry Street','assistant','2');

INSERT INTO AdminStaff
VALUES ('1009','Jill','Joffries','F','+44776618645','27 Cherry Street','manager','1');

INSERT INTO AdminStaff
VALUES ('1019','Justine','Joffries','F','(01227) 812035','19 Creosote Road','assistant','1');

---Insert into Instructor---
INSERT INTO Instructor
VALUES ('2009','James','Joffries','M','012275435665','27 Cherry Street','FTR76398','1','124');

INSERT INTO Instructor
VALUES ('2011','Jim','Adams','M','065490125674','4 The Vale','TGY98555a','2','912');

INSERT INTO Instructor
VALUES ('2013','Trinny','Vair','F','0044587208725','17 High Street, Chartham','YHF7665467','1','653');

---Insert into Client---
INSERT INTO Client
VALUES ('1','Andy','Twill','M','1998-02-01','0044678412349876','27 Cherry Street, CT4 7NF ','TYH7890');

INSERT INTO Client
VALUES ('2','Sue','Adams','F','1989-06-14','0841-234-876','45 Eggy Lane, CT4 7NF','CIO67891');

INSERT INTO Client
VALUES ('3','Jean','Adams','F','2001-11-19','01227765329','4 Harkness Lane, Canterbury','RTY678923');

---Insert into Lesson---
INSERT INTO Lesson
VALUES ('2017-06-24','10:00:00','1','2011');

INSERT INTO Lesson
VALUES ('2019-06-07','10:00:00','2','2009');

INSERT INTO Lesson
VALUES ('2017-07-12','14:00:00','1','2011');

INSERT INTO Lesson
VALUES ('2017-08-19','16:00:00','1','2011');

INSERT INTO Lesson
VALUES ('2020-08-17','16:00:00','2','2011');

INSERT INTO Lesson
VALUES ('2020-08-01','14:00:00','1','2009');

---Insert into Test---
INSERT INTO Test
VALUES ('2018-03-01','11:00:00','1','2009','2','Passed');

INSERT INTO Test
VALUES ('2019-08-13','13:00:00','2','2011','3','Failed','Lack of Observation');

INSERT INTO Test
VALUES ('2019-10-21','11:00:00','2','2011','2','Failed','Speeding');

INSERT INTO Test
VALUES ('2020-08-19','10:00:00','2','2009','2','Not Taken');

---Displaying Tables---
SELECT * FROM Centre;
SELECT * FROM Car;
SELECT * FROM AdminStaff;
SELECT * FROM Instructor;
SELECT * FROM Client;
SELECT * FROM Lesson;
SELECT * FROM Test;

---Selecting Information from tables---

---2.1---
SELECT Lesson.OnDate, Lesson.OnTime, Instructor.Surname
FROM Lesson
INNER JOIN Instructor ON Lesson.EmpID=Instructor.EmpID
WHERE Address LIKE  '%Cherry Street%';

---2.2---
SELECT Test.Status, count(Status)
FROM Test 
INNER JOIN Client ON Test.ClientID=Client.ClientID
WHERE Gender = 'F'
GROUP BY Status HAVING COUNT (Status)>0;

---2.3---  EmpID, Forename, Surname (Jeffries). AdminStaff & Instructors.
SELECT EmpID,Forename, Surname
FROM Instructor
WHERE Surname LIKE '%Joffries%'
UNION 
SELECT EmpID,Forename, Surname
FROM AdminStaff
WHERE Surname LIKE '%Joffries%';

---2.4---
SELECT School.Address, Instructor.SchoolID,Instructor.Forename, Instructor.Surname
FROM Instructor
LEFT JOIN School ON Instructor.SchoolID=School.SchoolID
WHERE Instructor.EmpID NOT IN 
(
    SELECT EmpID
    FROM Lesson
);

---2.5--- 
SELECT  Centre.Name, 
Test.OnDate, Test.OnTime, Test.Status,
            Client.Forename, Client.Surname,
                School.Address,
                    Car.Model
FROM Test
INNER JOIN Instructor ON Test.EmpID=Instructor.EmpID 
INNER JOIN Client ON Test.ClientID=Client.ClientID
INNER JOIN Centre ON Test.CentreID=Centre.CentreID
INNER JOIN Car ON Instructor.CarID=Car.CarID
Inner JOIN School ON School.SchoolID=Instructor.SchoolID
WHERE Name LIKE '%Whitstable%'
ORDER BY Client.Surname, Client.Forename ASC;

--2.6---
UPDATE Lesson 
SET EmpID = '2011'
WHERE EmpID = '2009'AND OnDate >= '2020-06-12';

