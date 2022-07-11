CREATE PROCEDURE addToTable @_newssn BIGINT, @_newname NVARCHAR(max),
@_newlastname NVARCHAR(max), @_newrole NVARCHAR(max),
@newid BIGINT, @newparentid BIGINT
AS
BEGIN
    INSERT INTO Member (ssn, _name, _lastName, _role, id, parent_id)
    VALUES (@_newssn, @_newname, @_newlastname, @_newrole, @newid, @newparentid);
END;
-- EXEC addToTable 1342345789, 'Amir', 'Fakharzadeh', 'E', 9, 4 <= example of adding new row to table