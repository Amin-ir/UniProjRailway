CREATE VIEW fullTrainView
AS
SELECT T.*,O.org_name,M.model_name FROM TRAIN AS T
JOIN ORG AS O ON O.ORG_ID = T.ORG_ID
JOIN MODEL AS M ON T.MODEL_ID = M.MODEL_ID;
