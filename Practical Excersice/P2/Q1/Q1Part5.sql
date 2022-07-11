CREATE PROCEDURE deleteFromTable @id1 BIGINT, @id2 BIGINT
AS
BEGIN
    UPDATE Member
    SET parent_id = @id2
    WHERE parent_id = @id1

    DELETE FROM Member WHERE id = @id1
END;
-- EXEC deleteFromTable @id1=4, @id2=3 <= delete from table id = 4 subset -> to id = 3 