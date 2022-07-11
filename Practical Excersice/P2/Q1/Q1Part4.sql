CREATE PROCEDURE replaceInformation @id1 BIGINT, @id2 BIGINT
AS
BEGIN
    DECLARE @pid1 bigint;
	DECLARE @_role1 nvarchar(max);
    SET @pid1 = ( SELECT parent_id FROM Member where id = @id1);
    SET @_role1 = ( SELECT _role FROM Member where id = @id1);
  
	DECLARE @child1 TABLE (id INT);
    
    UPDATE Member
    SET parent_id = ( SELECT parent_id FROM Member where id = @id2),
		_role = ( SELECT _role FROM Member where id = @id2)
    WHERE id = @id1;
    
    UPDATE Member
    SET parent_id = @pid1, _role = @_role1
    WHERE id = @id2;
	
    INSERT into @child1 SELECT id FROM Member WHERE parent_id = @id1;
    
	UPDATE Member
    SET parent_id = @id1  
    WHERE parent_id = @id2;

    UPDATE Member
    SET parent_id = @id2
    WHERE id in (select id from @child1);
END;

--EXEC replaceInformation @id1=2, @id2=3 <= command for runmog procedure replaceInformation
--Example of changing id = 2 and id =3