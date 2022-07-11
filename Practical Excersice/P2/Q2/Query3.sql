CREATE FUNCTION GradeByHW_Id(@id BIGINT)
RETURNS @scoreOfStudents TABLE (
    Student_id BIGINT,
    ScoreOfHomeWork INT
)
BEGIN
    INSERT INTO @scoreOfStudents
    Select A.studentId, G.grades
    FROM GradeOfHomeWork G
    JOIN AnswerOfHomeWork A
    ON G.anshw_id = A.anshw_id
    WHERE G.hw_id = @id;
    RETURN;
END;

SELECT * FROM GradeByHW_Id(1)