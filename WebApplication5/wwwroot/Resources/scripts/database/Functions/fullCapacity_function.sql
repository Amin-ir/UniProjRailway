CREATE FUNCTION fullcap(@p_travel_id INT)
RETURNS INT
AS
BEGIN
RETURN(
SELECT t.coup_in_wagon * t.coup_capacity * t.numof_wagon AS fullcap FROM (SELECT train_id FROM travel WHERE travel_id = @p_travel_id) f
JOIN train t ON t.train_id = f.train_id
);
END;