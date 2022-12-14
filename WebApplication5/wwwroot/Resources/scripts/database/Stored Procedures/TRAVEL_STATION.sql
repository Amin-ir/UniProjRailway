CREATE PROCEDURE TRAVELSTATION_MOD (@SID INT = NULL, @SNID VARCHAR(30) = NULL,@TID INT = NULL)
AS
IF (@SID IS NULL AND @SNID IS NULL AND @TID IS NULL)
SELECT * FROM TRAVELSTATION_VIEW;
ELSE IF (@SID IS NULL OR @SNID IS NULL OR @TID IS NULL)
SELECT * FROM TRAVELSTATION_VIEW
WHERE (STATION_ID = @SID OR @SID IS NULL) AND (STATION_NAME LIKE CONCAT('%',@SNID,'%') OR @SNID IS NULL) AND (TRAVEL_ID = @TID OR @TID IS NULL);
ELSE SELECT * FROM TRAVELSTATION_VIEW
WHERE (STATION_ID = @SID) AND (STATION_NAME LIKE CONCAT('%',@SNID,'%')) AND (TRAVEL_ID = @TID);
