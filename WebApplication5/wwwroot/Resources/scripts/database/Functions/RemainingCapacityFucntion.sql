CREATE FUNCTION REMAINING(@p_travel_id int)
RETURNS INT
AS
BEGIN
RETURN (
    SELECT dbo.fullcap(@p_travel_id) - (SELECT COUNT(*) FROM TICKET WHERE @p_travel_id = travel_id)
);
END;