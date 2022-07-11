CREATE TABLE Class(
    classId BIGINT PRIMARY KEY,
    _description VARCHAR(MAX),
    class_name VARCHAR(MAX) NOT NULL,
    _subject CHAR NOT NULL CHECK(
        _subject = 'M' OR _subject = 'P' OR _subject = 'C' OR _subject = 'B' OR 
        _subject = 'F' OR _subject = 'E' OR _subject = 'A' OR _subject = 'R' ),
    class_status CHAR(2) CHECK ( class_status = 'AC' OR class_status = 'NA' OR class_status = 'AR' ) NOT NULL,
    firstSession DATE NOT NULL,
    finalSession DATE NOT NULL,
    grade INT NOT NULL CHECK ( 1 <= grade AND grade <= 12 ),
    teacherName VARCHAR(25) NOT NULL,
    CHECK( finalSession > firstSession )
);
CREATE TABLE Student(
    stuId BIGINt PRIMARY KEY,
    username VARCHAR(20) NOT NULL,
    _password VARCHAR(8) NOT NULL,
    _name VARCHAR(15) NOT NULL,
    _lastname VARCHAR(15) NOT NULL,
    email VARCHAR(50),
    ssn VARCHAR(10) UNIQUE NOT NULL CHECK(LEN(ssn) = 10 AND ssn LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    _address VARCHAR(MAX) NOT NULL,
    phone_number VARCHAR(8) NOT NULL CHECK(LEN(phone_number) = 8 AND phone_number LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    birthdate DATE NOT NULL,
    classId BIGINT FOREIGN KEY REFERENCES Class(classId) ON DELETE CASCADE
);
CREATE TABLE WeeklySchedule
(
    weekId BIGINT PRIMARY KEY,
    classId BIGINT FOREIGN KEY REFERENCES Class(classId) ON DELETE CASCADE
);
CREATE TABLE DayOfClass(
    classDay VARCHAR(3) NOT NULL CHECK(
        classDay = 'SAT' OR classDay = 'SUN' OR classDay = 'MON' OR
        classDay = 'TUE' OR classDay = 'WED' OR classDay = 'THU' OR
        classDay = 'FRI' ),
    classStart TIME NOT NULL,
    classFinish TIME NOT NULL,
    weekId BIGINT FOREIGN KEY REFERENCES WeeklySchedule(weekId) ON DELETE CASCADE
);
CREATE TABLE Homework(
    hw_id BIGINT PRIMARY KEY,
    _description VARCHAR(MAX),
    _file VARCHAR(MAX) NOT NULL,
    publishedDate DATE NOT NULL,
    deadlineDate DATE NOT NULL,
    CHECK (DATEDIFF(Day,publishedDate, deadlineDate) >= 0),
    classId BIGINT FOREIGN KEY REFERENCES Class(classId) ON DELETE CASCADE
);
CREATE TABLE AnswerOfHomeWork(
    anshw_id BIGINT PRIMARY KEY,
    _description VARCHAR(MAX),
    _file VARCHAR(MAX) NOT NULL,
    publishedDate DATE NOT NULL,
    studentId BIGINT FOREIGN KEY REFERENCES Student(stuId) ON DELETE NO ACTION,
    hw_id BIGINT FOREIGN KEY REFERENCES Homework(hw_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT uniqueStuHw UNIQUE(studentId, hw_id)
);
CREATE TABLE GradeOfHomeWork(
    grades INT CHECK( grades <= 20 AND grades >= 0 ),  
    anshw_id BIGINT FOREIGN KEY REFERENCES AnswerOfHomeWork(anshw_id),
    hw_id BIGINT FOREIGN KEY REFERENCES Homework(hw_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT uniqueAnsHw UNIQUE(anshw_id, hw_id)
);