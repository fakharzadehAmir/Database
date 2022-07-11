--Question03
--Refah Database
USE Refah
--Query01
--All data is in NVARCHAR(MAX) ==> we use PARSE() to write our queries.
SELECT f.*
FROM final f
WHERE parse(f.Cars_Count AS FLOAT) <
(SELECT AVG(parse(Cars_Count AS FLOAT)) FROM final);
--Query02
SELECT f.Id, f.Gender
FROM final f
WHERE PARSE(f.Sood97 AS FLOAT) -
            PARSE(f.Sood96 AS FLOAT) >	0
        And 
        PARSE(f.Sood96 AS FLOAT) -
            PARSE(f.Sood95 AS FLOAT) >	0;
--Query03
SELECT f.SenfName
FROM final f
WHERE f.SenfName LIKE N'%ن%';
--Query04
--Farzi ke dar nazar gereftam ekhtelaf BirthDate o date alan 50 bashe
--yani tafavote rooz ha (50*365) ro dar nazar nagereftam va
--faghat tafavote YYYY ba emsal made nazaram bud
--Order az ziad be kam (Nozooli)
SELECT f.Id, f.Daramad_Total_Rials
FROM final f
WHERE f.ProvinceName = N'تهران'	AND
    DATEDIFF(YEAR, PARSE(f.BirthDate AS DATETIME), GETDATE()) = 50
ORDER BY f.Daramad_Total_Rials DESC;
--Query05
SELECT f.Id
FROM final f
WHERE f.Gender = N'مرد' AND
		PARSE(f.Bardasht97 AS FLOAT) > 30000000;