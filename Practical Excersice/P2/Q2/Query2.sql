--median for class with 1 hw
CREATE OR ALTER FUNCTION reportGradesByHw1_Id(@Class_id BIGINT)
RETURNS @scoresReport TABLE (
    rep_hw BIGINT,
    rep_min INT,
    rep_max INT,
    rep_avg FLOAT,
    rep_var FLOAT,
    rep_med FLOAT
)
BEGIN
    INSERT INTO @scoresReport
    SELECT G.hw_id, MIN(grades),
        MAX(grades), AVG(grades),
        ROUND(VAR(grades),2) ,
        (
 (SELECT MAX(grades) FROM
   (SELECT TOP 50 PERCENT G.grades 
   FROM GradeOfHomeWork G JOIN Homework H ON H.hw_id = G.hw_id 
   WHERE H.classId = @Class_id ORDER BY G.grades) Bottom)
 +
 (SELECT MIN(grades) FROM
   (SELECT TOP 50 PERCENT G.grades 
   FROM GradeOfHomeWork G JOIN Homework H ON H.hw_id = G.hw_id 
   WHERE H.classId = @Class_id ORDER BY G.grades DESC) [Top])
) / 2 rep_med
    FROM GradeOfHomeWork G JOIN Homework H 
    ON H.hw_id = G.hw_id
    WHERE H.classId = @Class_id GROUP BY G.hw_id;
    RETURN;
END;

--report grades function for class with more than 1 hw
CREATE OR ALTER FUNCTION reportGradesByHw_moreThan1_Id(@Class_id BIGINT)
RETURNS @scoresReport TABLE (
    rep_hw BIGINT,
    rep_min INT,
    rep_max INT,
    rep_avg FLOAT,
    rep_var FLOAT
)
BEGIN
    INSERT INTO @scoresReport
    SELECT G.hw_id, MIN(grades),
        MAX(grades), AVG(grades),
        ROUND(VAR(grades),2) 
    FROM GradeOfHomeWork G JOIN Homework H 
    ON H.hw_id = G.hw_id
    WHERE H.classId = @Class_id GROUP BY G.hw_id;
    RETURN;
END;


SELECT * FROM reportGradesByHw1_Id(1)

SELECT * FROM reportGradesByHw_moreThan1_Id(2)
SELECT * FROM reportGradesByHw_moreThan1_Id(10)
