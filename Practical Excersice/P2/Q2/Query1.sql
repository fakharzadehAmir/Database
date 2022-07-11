--Query1
CREATE FUNCTION ClassStuNumber() 
RETURNS @numberOfClassStu TABLE(
    NumberOFClass INT,
    NumberOfStudent INT
)
BEGIN
    INSERT INTO @numberOfClassStu VALUES(( SELECT COUNT(*) FROM Class ),
        ( SELECT COUNT(*) FROM Student ));
    RETURN;
END;

CREATE FUNCTION ClassGradeNum()
RETURNS @NumOfClassByGrade TABLE(
    _Grade INT,
    _NumOFClass INT
)
BEGIN
    INSERT INTO @NumOfClassByGrade
    SELECT grade, COUNT(*) FROM Class GROUP BY grade;
    RETURN;
END;

SELECT * from ClassGradeNum()
SELECT * from ClassStuNumber()