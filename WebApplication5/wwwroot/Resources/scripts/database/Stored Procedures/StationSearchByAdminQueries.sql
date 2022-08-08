CREATE PROCEDURE StationSearch(@pid INT = NULL, @pname VARCHAR(25) = NULL)
AS
    IF @pid IS NULL AND @pname IS NULL
    SELECT * FROM station;
    ELSE IF @pid IS NULL OR @pname IS NULL
    SELECT * FROM station
    WHERE (@pid = station_id OR @PID IS NULL)AND
          (@PNAME IS NULL OR station_name LIKE CONCAT('%',@pname,'%'));
    ELSE
        SELECT * FROM station
        WHERE @pid = station_id AND
          station_name LIKE CONCAT('%',@pname,'%');