CREATE PROCEDURE TravelSearch @pid INT = NULL, @pStartName VARCHAR(25) = NULL, @pStartId INT = NULL,
@pDestName VARCHAR(25) = NULL, @pDestID INT = NULL, @pstartDate DATE = NULL, @parrival DATE = NULL, @ptrainID INT = NULL,@twoSided BIT = 0
AS
    IF @pid  IS NULL AND @pStartName IS NULL AND @pStartId IS NULL AND @pDestName IS NULL
     AND @pDestID IS NULL AND @pstartDate IS NULL AND @parrival IS NULL AND @ptrainID IS NULL
     SELECT * FROM travelFullView;
    ELSE IF @pid IS NULL OR @pStartName IS NULL OR @pStartId IS NULL OR @pDestName IS NULL
     OR @pDestID IS NULL OR @pstartDate IS NULL OR @parrival IS NULL OR @ptrainID IS NULL
     SELECT * FROM travelFullView
    WHERE (@pid = travel_id OR @pid IS NULL) AND (start_id = @pStartId OR @pStartId IS NULL) AND (dest_id = @pDestID OR @pDestID IS NULL) AND
        (startPoint LIKE CONCAT('%', @pStartName,'%') OR @pStartName IS NULL) AND (destPoint LIKE CONCAT('%', @pDestName,'%') OR @pDestName IS NULL) AND
        (SELECT CONVERT(VARCHAR(10), START_TIME, 111)) = @pstartDate OR @pstartDate IS NULL AND (SELECT CONVERT(VARCHAR(10),ARRIVAL_TIME, 111)) = @parrival OR @parrival IS NULL AND (@ptrainID = train_id OR @ptrainID IS NULL); 
    ELSE
        SELECT * FROM travelFullView
        WHERE @pid = travel_id AND start_id = @pStartId AND dest_id = @pDestID AND
        startPoint LIKE CONCAT('%', @pStartName,'%') AND destPoint LIKE CONCAT('%', @pDestName,'%') AND
        (SELECT CONVERT(VARCHAR(10), START_TIME, 111)) = @pstartDate AND (SELECT CONVERT(VARCHAR(10),ARRIVAL_TIME, 111)) = @parrival AND @ptrainID = train_id; 