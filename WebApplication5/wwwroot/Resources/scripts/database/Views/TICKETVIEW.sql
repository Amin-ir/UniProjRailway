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