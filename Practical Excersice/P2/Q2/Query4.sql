--WeeklySchedule Function Orderby classDay and classStart 
--no data with classDay 'THU' and 'FRI'
CREATE FUNCTION WeekScheduleForStudent(@studentID BIGINT)
RETURNS @weeklyPlan TABLE
    (
        w_Subject CHAR,
        w_ClassName VARCHAR(Max),
        w_TeacherName VARCHAR(25),
        w_DaysOfClass VARCHAR(3),
        w_startTime TIME,
        w_finishTime TIME
    )
BEGIN
    INSERT INTO @weeklyPlan
    SELECT C._subject, C.class_name, C.teacherName, D.classDay, D.classStart, D.classFinish
    FROM Student S JOIN Class C ON S.stuId = @studentID AND S.classId = C.classId
    JOIN WeeklySchedule W ON C.classId = W.classId
    JOIN DayOfClass D ON D.weekId = W.weekId
    ORDER BY CASE 
        when D.classDay = 'SAT' THEN 1
        when D.classDay = 'SUN' THEN 2
        when D.classDay = 'MON' THEN 3
        when D.classDay = 'TUE' THEN 4
        when D.classDay = 'WED' THEN 5
        when D.classDay = 'THU' THEN 6
        when D.classDay = 'FRI' THEN 7
    END ASC, D.classStart
    RETURN;
END;

SELECT * FROM WeekScheduleForStudent(150)