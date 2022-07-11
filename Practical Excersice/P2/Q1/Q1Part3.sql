CREATE FUNCTION GetChildren(@_id AS BIGINT)
RETURNS @children TABLE
(
    _cId BIGINT,
    _cSsn BIGINT,
    _cName VARCHAR(MAX),
    _cLastName VARCHAR(MAX),
    _cRole VARCHAR(MAX),
    _cParent_Id BIGINT
)
AS BEGIN
    IF((SELECT _role FROM Member WHERE id = @_id) = 'HRM')
        INSERT INTO @children SELECT id, ssn, _name, _lastName, _role, parent_id FROM Member
    ELSE
    BEGIN
    WITH cte_getChild(cte_id, cte_ssn, cte_name, cte_lastname,
            cte_role, cte_parentId) AS (
            SELECT id, ssn, _name, _lastName, _role, parent_id
            FROM Member WHERE id = @_id
            UNION ALL
            SELECT M.id, M.ssn, M._name, M._lastname, M._role, M.parent_id
            FROM Member M JOIN cte_getChild C 
            on M.parent_id = C.cte_id
            )
        INSERT INTO @children SELECT * FROM cte_getChild
    END
    RETURN;
END;

--HRM example
--SELECT * FROM GetChildren(2)
--Other Example
--SELECT * FROM GetChildren(3) 
--SELECT * FROM GetChildren(4)


