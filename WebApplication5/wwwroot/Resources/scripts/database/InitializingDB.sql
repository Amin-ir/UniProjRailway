CREATE TABLE PASSENGER (
	img NVARCHAR(MAX),
	REG_DATE DATETIME NOT NULL,
	PASSENGER_ID INT PRIMARY KEY,
	PASSW NVARCHAR(MAX) NOT NULL,
	SX NVARCHAR(MAX) NOT NULL,
	FNAME NVARCHAR(MAX) NOT NULL,
	LNAME NVARCHAR(MAX) NOT NULL,
	BIRTH DATE NOT NULL,
	FATHER_NAME NVARCHAR(MAX) NOT NULL,
	PHONE VARCHAR(13) NOT NULL,
	ADDRESS NVARCHAR (MAX) NOT NULL
);
CREATE TABLE ORG(
	ORG_ID INT PRIMARY KEY,
	ORG_NAME NVARCHAR(MAX) NOT NULL
);
CREATE TABLE MODEL(
	MODEL_ID INT PRIMARY KEY,
	MODEL_NAME NVARCHAR(MAX) NOT NULL
);
CREATE TABLE CITY(
	CITY_ID INT PRIMARY KEY,
	CITY_NAME NVARCHAR(MAX) NOT NULL
);
CREATE TABLE STATION(
	STATION_ID INT PRIMARY KEY,
	STATION_NAME NVARCHAR(MAX) NOT NULL
);
CREATE TABLE MEAL(
	MEAL_ID INT PRIMARY KEY,
	MEAL_NAME NVARCHAR(MAX) NOT NULL,
	MEAL_PRICE INT NOT NULL
);

CREATE TABLE TRAIN(
	TRAIN_ID INT PRIMARY KEY,
	TRAIN_DEGREE INT NOT NULL,
	COUP_CAPACITY INT,
	COUP_IN_WAGON INT,
	NUMOF_WAGON INT NOT NULL,
	ORG_ID INT NOT NULL,
	MODEL_ID INT,
	FOREIGN KEY (ORG_ID) REFERENCES ORG (ORG_ID)
	ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (MODEL_ID) REFERENCES MODEL (MODEL_ID)
	ON DELETE SET NULL ON UPDATE SET NULL
);

CREATE TABLE TRAVEL(
	TRAVEL_ID INT PRIMARY KEY,
	START_TIME DATETIME2 NOT NULL,
	ARRIVAL_TIME DATETIME2 NOT NULL,
	TRAIN_ID INT NOT NULL,
	START_ID INT NOT NULL,
	DEST_ID INT NOT NULL,
	BASE_PRICE INT NOT NULL,
	FOREIGN KEY (START_ID) REFERENCES CITY (CITY_ID),
	FOREIGN KEY (DEST_ID) REFERENCES CITY (CITY_ID),
	FOREIGN KEY (TRAIN_ID) REFERENCES TRAIN(TRAIN_ID)
	ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE TICKET (
	TRAVEL_ID INT NOT NULL,
	PASSENGER_ID INT NOT NULL,
	FOREIGN KEY (TRAVEL_ID) REFERENCES TRAVEL (TRAVEL_ID)
	ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (PASSENGER_ID) REFERENCES PASSENGER (PASSENGER_ID),
	CONSTRAINT TICKET_ID PRIMARY KEY (TRAVEL_ID,PASSENGER_ID),
	WAGON_NUMBER INT NOT NULL,
	COUPE_NUMBER INT,
	SEAT_NUMBER INT NOT NULL,
	MEAL_RESERVE BIT,
	IS_PAID BIT
);
CREATE TABLE MEAL_TRAVEL (
	MEAL_ID INT,
	TRAVEL_ID INT NOT NULL,
	FOREIGN KEY (MEAL_ID) REFERENCES MEAL (MEAL_ID),
	FOREIGN KEY (TRAVEL_ID) REFERENCES TRAVEL (TRAVEL_ID)
	ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT MT_ID PRIMARY KEY (TRAVEL_ID,MEAL_ID)
);
CREATE TABLE TRAVEL_STATION(
	TRAVEL_ID INT NOT NULL,
	STATION_ID INT,
	FOREIGN KEY (TRAVEL_ID) REFERENCES TRAVEL (TRAVEL_ID)
	ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (STATION_ID) REFERENCES STATION (STATION_ID),
	ENTRANCE DATETIME NOT NULL,
	QUIT DATETIME NOT NULL,
	CONSTRAINT TS_ID PRIMARY KEY (TRAVEL_ID,STATION_ID)
); 

CREATE FUNCTION fullcap(@p_travel_id INT)
RETURNS INT
AS
BEGIN
RETURN(
SELECT t.coup_in_wagon * t.coup_capacity * t.numof_wagon AS fullcap FROM (SELECT train_id FROM travel WHERE travel_id = @p_travel_id) f
JOIN train t ON t.train_id = f.train_id
);
END;

CREATE FUNCTION REMAINING(@p_travel_id int)
RETURNS INT
AS
BEGIN
RETURN (
    SELECT dbo.fullcap(@p_travel_id) - (SELECT COUNT(*) FROM TICKET WHERE @p_travel_id = travel_id)
);
END;

CREATE FUNCTION MEALPRICECAL (@PID INT ,@TID INT)
RETURNS INT
AS
BEGIN
	DECLARE @RV INT = 0;
	IF (SELECT MEAL_RESERVE FROM TICKET WHERE PASSENGER_ID = @PID AND TRAVEL_ID = @TID) != 0
	AND (SELECT MEAL_ID FROM MEAL_TRAVEL WHERE TRAVEL_ID = @TID) IS NOT NULL
	SET @RV = (
		SELECT MEAL_PRICE FROM MEAL 
		JOIN (SELECT MEAL_ID FROM MEAL_TRAVEL WHERE TRAVEL_ID = @TID) M 
		ON M.MEAL_ID = MEAL.MEAL_ID
		);
	RETURN @RV;
END;


CREATE VIEW fullTrainView
AS
SELECT T.*,O.org_name,M.model_name FROM TRAIN AS T
JOIN ORG AS O ON O.ORG_ID = T.ORG_ID
JOIN MODEL AS M ON T.MODEL_ID = M.MODEL_ID;

CREATE VIEW TRAVELFullView
AS
SELECT t.*, CITY_NAME AS destPoint,dbo.fullcap(TRAVEL_ID) AS [Full Capacity],
	dbo.REMAINING(TRAVEL_ID) AS [Remaining Capacity] 
	FROM (	SELECT TRAVEL.* , CITY_NAME AS startPoint FROM TRAVEL
	JOIN CITY ON CITY_ID = START_ID
	) AS t
    JOIN CITY ON DEST_ID = CITY_ID
;

CREATE VIEW TRAVELSTATION_VIEW
AS
SELECT V.STATION_ID,S.STATION_NAME,V.TRAVEL_ID FROM TRAVEL_STATION V
JOIN STATION S ON V.STATION_ID = S.STATION_ID;

CREATE VIEW MEALTRAVEL_VIEW
AS
SELECT V.* , M.MEAL_NAME FROM MEAL_TRAVEL V
JOIN MEAL M ON M.MEAL_ID = V.MEAL_ID;

CREATE VIEW TICKETVIEW
AS
SELECT P.PASSENGER_ID, P.SX , P.FNAME , P.LNAME , P.BIRTH, P.FATHER_NAME, P.PHONE,F.ORG_NAME,
T.WAGON_NUMBER,T.COUPE_NUMBER,T.SEAT_NUMBER,T.MEAL_RESERVE, S.START_TIME,S.ARRIVAL_TIME,S.BASE_PRICE,S.startPoint,S.destPoint
,dbo.MEALPRICECAL(P.PASSENGER_ID,T.TRAVEL_ID) + S.BASE_PRICE AS FINAL_PRICE,T.IS_PAID
FROM TICKET T JOIN PASSENGER P ON T.PASSENGER_ID = P.PASSENGER_ID
JOIN TRAVELFullView S ON T.TRAVEL_ID = S.TRAVEL_ID
JOIN FULLTRAINVIEW F ON S.TRAIN_ID = F.TRAIN_ID; 
-- IN ORDER TO CREATE THIS VIEW, MAKE SURE YOU HAVE ALREADY CREATED THE MEALPRICECAL FUNCTION INTO THE DATABASE
-- WARNING: IN ORDER TO MAKE THIS VIEW WORK RIGHT, MAKE SURE THERE IS NOT TWO MEALS FOR THE SAME TRAVEL
-- AT MEAL_TRAVEL TABLE, ELSE IT'LL RETRIEVE A SUBQUERY AT DBO.MEALPRICECAL AND MAKE IT MALFUNCTION

INSERT INTO MODEL VALUES (1,'کوپه ای'), (2,'اتوبوسی'), (3,'دو طبقه');
INSERT INTO PASSENGER VALUES 
(NULL,CURRENT_TIMESTAMP,1,'amin1751','male','محمدامین','مقدسی','2001-02-14','ابوالقاسم','09107561751','قم-خ30متری کیوانفر-ک29-پ24'),
(NULL,CURRENT_TIMESTAMP,2,'t1350','female','طیبه','نجمی','1971-01-01','محمدرضا','09194522672','قم-خ30متری کیوانفر-ک29-پ24'),
(NULL,CURRENT_TIMESTAMP,3,'ghsmghdsi','male','ابوالقاسم','مقدسی','1967-01-01','احمد','09124520031','قم-خ30متری کیوانفر-ک29-پ24'),
(NULL,CURRENT_TIMESTAMP,4,'ali7549003','male','علیرضا','مقدسی','1990-01-01','ابوالقاسم','09127549003','قم-خ30متری کیوانفر-ک29-پ19')
;
INSERT INTO CITY VALUES (1,'قم'),(2,'تهران'),(3,'مشهد'),(4,'اراک');
INSERT INTO ORG VALUES (1,'رجا'),(2,'فدک'),(3,'بنیاد'),(4,'پردیس');
INSERT INTO STATION VALUES (1,'قم'),(2,'تهران'),(3,'قمرود'),(4,'سپر رستم'),(5,'گرمسار'),(6,'مشهد'),(7,'نیشابور');
INSERT INTO MEAL VALUES (1,'صبحانه',5000),(2,'صبحانه',3000),(3,'ناهار',15000),(4,'ناهار',25000),(5,'شام',17000);
INSERT INTO TRAIN VALUES (1,1,4,10,12,2,1),(2,1,4,12,14,1,1),(3,2,6,12,14,3,1),(4,2,20,1,14,4,2);
INSERT INTO TRAVEL VALUES (1,'2022-07-27 20:00:00','2022-07-27 23:00:00',2,1,2,7000)
,(2,'2022-07-27 20:00:00','2022-07-27 23:00:00',3,2,1,7000),(3,'2022-07-27 20:00:00','2022-07-28 10:00:00',1,1,3,1000000);
INSERT INTO TICKET VALUES (3,1,1,1,1,0,0),(1,4,1,1,1,0,0),(2,2,1,1,1,1,0);
INSERT INTO MEAL_TRAVEL VALUES (1,3),(5,3),(5,1),(5,2);
INSERT INTO TRAVEL_STATION VALUES (1,1,'2022-07-27 19:30:00.000','2022-07-27 20:00:00.000'),
(1,2,'2022-07-27 20:00:00.000','2022-07-27 20:30:00.000');
SELECT * FROM MEAL_TRAVEL;
SELECT * FROM TRAVEL_STATION;
SELECT * FROM TICKET;
SELECT * FROM TRAVEL;
SELECT * FROM TRAIN;
SELECT * FROM MODEL;
SELECT * FROM MEAL;
SELECT * FROM PASSENGER;
select * from fulltrainview;
SELECT * FROM TRAVELFULLVIEW;
