CREATE PROCEDURE CitySearch(@PID INT = NULL, @PNAME VARCHAR(25) = NULL)
AS
    IF @PID IS NULL AND @PNAME IS NULL
    SELECT * FROM CITY;
    ELSE IF @pid is null or @pname is null
    SELECT * FROM CITY
    WHERE (@PID = city_id OR @PID IS NULL) AND
          (@PNAME IS NULL OR city_name LIKE CONCAT('%',@PNAME,'%'));