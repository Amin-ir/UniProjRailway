CREATE TRIGGER PASSENGER_UP
ON PASSENGER
INSTEAD OF UPDATE
AS
DECLARE C CURSOR
FOR (SELECT PASSENGER_ID FROM INSERTED)
OPEN C
	DECLARE @T INT;
	FETCH NEXT FROM C INTO @T;
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		BEGIN TRANSACTION
		IF @T NOT IN (SELECT PASSENGER_ID FROM PASSENGER)
		BEGIN
			DECLARE @PS INT;
			SET @PS = (SELECT S.PASSENGER_ID FROM PASSENGER S JOIN INSERTED I ON S.PHONE = I.PHONE
			WHERE I.PASSENGER_ID = @T);
			INSERT INTO PASSENGER SELECT * FROM INSERTED WHERE PASSENGER_ID = @T;
			UPDATE TICKET SET PASSENGER_ID = @T WHERE PASSENGER_ID = @PS;
			DELETE FROM PASSENGER WHERE PASSENGER_ID = @PS;
		END;
		ELSE 
		BEGIN
		  UPDATE PASSENGER SET FNAME = inserted.FNAME,
		  LNAME = INSERTED.LNAME, IMG = INSERTED.IMG,
		  REG_DATE = INSERTED.REG_DATE , PASSENGER_ID = INSERTED.PASSENGER_ID,
		  PASSW = INSERTED.PASSW, SX = INSERTED.SX, BIRTH = INSERTED.BIRTH,
		  FATHER_NAME = INSERTED.FATHER_NAME, PHONE = INSERTED.PHONE,
		  ADDRESS = INSERTED.ADDRESS
		  FROM INSERTED WHERE PASSENGER.PASSENGER_ID = @T;
		  FETCH NEXT FROM C INTO @T; 		
		END;
		IF EXISTS (SELECT * FROM PASSENGER P JOIN TICKET T ON P.PASSENGER_ID = T.PASSENGER_ID WHERE P.PASSENGER_ID = @T)
		COMMIT;
		ELSE ROLLBACK;
	END;
CLOSE C;
DEALLOCATE C;