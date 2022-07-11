CREATE TABLE Member
(
    ssn BIGINT UNIQUE,
    _name NVARCHAR(max),
    _lastName NVARCHAR(max),
    _role NVARCHAR(max),
    id BIGINT PRIMARY KEY,
    parent_id BIGINT FOREIGN KEY REFERENCES Member(id)
);

INSERT INTO Member (ssn, _name, _lastName, _role, id, parent_id)
VALUES (1234567890, 'Ali', 'Jafari', 'CEO', 1, null);
INSERT INTO Member (ssn, _name, _lastName, _role, id, parent_id)
VALUES (1236547524, 'Zahra', 'Kazemi', 'HRM', 2, 1);
INSERT INTO Member (ssn, _name, _lastName, _role, id, parent_id)
VALUES (1236523654, 'Saleh', 'Akbari', 'FM', 3, 1);
INSERT INTO Member (ssn, _name, _lastName, _role, id, parent_id)
VALUES (1246578125, 'Reza', 'Bageri', 'TM', 4, 1);
INSERT INTO Member (ssn, _name, _lastName, _role, id, parent_id)
VALUES (4512547856, 'Sina', 'Ahmadi', 'E', 5, 3);
INSERT INTO Member (ssn, _name, _lastName, _role, id, parent_id)
VALUES (2365478941, 'Melika', 'Zare', 'E', 6, 4);
INSERT INTO Member (ssn, _name, _lastName, _role, id, parent_id)
VALUES (1230212015, 'Maryam', 'Askari', 'E', 7, 4);
INSERT INTO Member (ssn, _name, _lastName, _role, id, parent_id)
VALUES (1203201458, 'Mehrdad', 'Moradi', 'E', 8, 4);