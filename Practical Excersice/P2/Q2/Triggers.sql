--Trigger for inserting data in AnswerOfHomeWork and GradeOfHomeWork
GO
CREATE OR ALTER TRIGGER insertNewData ON AnswerOfHomeWork
AFTER INSERT
AS
BEGIN
    INSERT INTO GradeOfHomeWork(grades, anshw_id, hw_id)
    SELECT FLOOR(RAND()*21) ,anshw_id, hw_id FROM inserted
END;
--Trigger (check Dates)
GO
CREATE OR ALTER TRIGGER insertCheckDate ON AnswerOfHomeWork
AFTER INSERT
AS
BEGIN
    IF(  NOT EXISTS ( SELECT * FROM Homework H JOIN inserted A ON A.hw_id = H.hw_id 
        WHERE DATEDIFF(DAY , A.publishedDate, H.deadlineDate) >= 0 
        AND DATEDIFF(DAY , H.publishedDate, A.publishedDate) >= 0 ) )
        ROLLBACK TRAN;
END;

-- insert into AnswerOfHomeWork (anshw_id, _description, _file, publishedDate, hw_id, studentId) values (31, ' ', 'InHac.mov', '2022-03-24' , 8, 117);
-- insert into AnswerOfHomeWork (anshw_id, _description, _file, publishedDate, hw_id, studentId) values (32, ' ', 'InHac.mov', '5/2/2022' , 8, 128);

--Trigger (delete record from AnswerOfHomeWork (grade))

GO
CREATE OR ALTER TRIGGER deleteGrades ON AnswerOfHomeWork
AFTER DELETE
AS
BEGIN
    IF(  NOT EXISTS ( SELECT * FROM GradeOfHomeWork G WHERE G.anshw_id in (SELECT D.anshw_id FROM deleted D)) )
        DELETE FROM AnswerOfHomeWork WHERE anshw_id IN (SELECT anshw_id FROM deleted); 
END;

--DELETE FROM AnswerOfHomeWork 
