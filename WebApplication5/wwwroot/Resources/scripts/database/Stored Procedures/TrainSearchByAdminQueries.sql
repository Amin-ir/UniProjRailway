CREATE PROCEDURE TrainSearch(
    @P_train_id INT = NULL,
    @P_train_degree INT = NULL,
    @P_coupe_capacity INT = NULL,
	@p_coup_in_wagon INT = NULL,
    @P_numof_wagon INT = NULL,
    @P_org_id INT = NULL,
    @P_org_name VARCHAR(20) = NULL,
    @P_model_id INT = NULL,
    @P_model_name VARCHAR(15) = NULL
)
AS
    IF @p_train_id IS NULL AND
    @P_train_degree IS NULL AND
    @P_coupe_capacity IS NULL AND
	@p_coup_in_wagon IS NULL AND
    @P_numof_wagon IS NULL AND
    @P_org_id IS NULL AND
    @P_org_name IS NULL AND
    @P_model_id IS NULL AND
    @P_model_name IS NULL
    SELECT * FROM fullTrainView;
    ELSE IF 
    @P_train_id IS NULL OR
    @P_train_degree IS NULL OR
    @P_coupe_capacity IS NULL OR
	@p_coup_in_wagon IS NULL OR
    @P_numof_wagon IS NULL OR
    @P_ORG_ID IS NULL OR
    @P_ORG_NAME IS NULL OR
    @P_model_id IS NULL OR
    @P_model_name IS NULL
    SELECT * FROM fullTrainView WHERE
    (@P_train_id = train_id OR @P_train_id IS NULL) AND
    (@P_train_degree = train_degree OR @P_train_degree IS NULL) AND
    (@P_coupe_capacity = coup_capacity OR @P_coupe_capacity IS NULL) AND
    (@P_coup_in_wagon = coup_in_wagon OR @P_coup_in_wagon IS NULL) AND
    (@P_numof_wagon = numof_wagon OR @P_numof_wagon IS NULL) AND
    (@P_org_id = org_id OR @P_org_id IS NULL) AND
    (org_name LIKE CONCAT('%',@p_org_name,'%') OR @P_org_name IS NULL) AND
    (@P_model_id = model_id OR @P_model_id IS NULL) AND
    (model_name LIKE CONCAT('%',@p_model_name,'%') OR @P_model_name IS NULL);
    ELSE SELECT * FROM fullTrainView WHERE
    @P_train_id = train_id AND
    @P_train_degree = train_degree AND
    @P_coupe_capacity = coup_capacity AND
    @P_coup_in_wagon = coup_in_wagon AND
    @P_numof_wagon = numof_wagon AND
    @P_org_id = org_id AND
    org_name LIKE CONCAT('%',@p_org_name,'%') AND
    @P_model_id = model_id AND
    model_name LIKE CONCAT('%',@p_model_name,'%');
