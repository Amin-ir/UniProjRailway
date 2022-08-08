CREATE PROCEDURE UsersSearch (@p_id INT = null,@p_regDate DATETIME = NULL, @p_fname VARCHAR(15) = NULL,
 @p_lname VARCHAR(25) = NULL, @p_sx NVARCHAR(max) = NULL, @p_birth DATE = NULL, @p_phone VARCHAR(13) = NULL)
 AS
	IF @p_id IS NULL AND  @p_regDate IS NULL AND @p_fname IS NULL
		AND @p_lname IS NULL AND @p_sx IS NULL AND @p_birth IS NULL AND @p_phone IS NULL
		SELECT * FROM PASSENGER;
	ELSE IF @P_ID IS NULL OR @P_REGDATE IS NULL OR @P_FNAME IS NULL OR @P_LNAME IS NULL OR @P_SX IS NULL
	OR @P_SX IS NULL OR @P_BIRTH IS NULL OR @P_PHONE IS NULL
        SELECT * FROM PASSENGER
		WHERE (@p_id = passenger_id OR @P_ID IS NULL) AND
		(@p_regDate = reg_date OR @P_REGDATE IS NULL)AND
		(fname LIKE CONCAT('%',@p_fname,'%') OR @P_FNAME IS NULL)AND
		(lname LIKE CONCAT('%',@p_lname,'%') OR @P_LNAME IS NULL)AND
		(@p_sx = sx OR @P_SX IS NULL) AND
		(@p_birth = birth OR @P_BIRTH IS NULL)AND 
		(phone LIKE CONCAT ('%',@p_phone,'%') OR @P_PHONE IS NULL);
	ELSE
		SELECT * FROM PASSENGER
		WHERE @p_id = passenger_id AND 
		@p_regDate = reg_date AND
		fname LIKE CONCAT('%',@p_fname,'%') AND
		lname LIKE CONCAT('%',@p_lname,'%') AND
		@p_sx = sx AND
		@p_birth = birth AND
		phone LIKE CONCAT ('%',@p_phone,'%');
