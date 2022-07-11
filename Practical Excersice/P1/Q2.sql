--Question02
--pubs Database
USE pubs
--Query01
SELECT t.title, t.type
FROM titles t
WHERE 17 < t.price AND t.price < 21 AND t.type != 'mod_cook';
--Query02
SELECT a.au_id, a.phone,
		CONCAT(a.au_fname, ' ', a.au_lname) Full_Name
FROM authors a
WHERE a.city = 'Oakland';
--Query03
--sabeghe kari bar asas zud tarin tarikh estekhdam
SELECT e.*
FROM employee e
WHERE e.hire_date = (SELECT MIN(hire_date) FROM employee);
--agar ke sabeghe kari bar asas sale estekhdam bashe
SELECT DISTINCT e.*
FROM employee e
WHERE DATEDIFF(YEAR, e.hire_date, GETDATE()) =
    (select MAX(DATEDIFF(YEAR, hire_date, GETDATE())) FROM employee)
--QUERY04
--Farzi ke dar nazar gereftam ekhtelaf sale estekhdam o alan bishtar az 30 bashe
--yani tafavote rooz ha (30*365) ro dar nazar nagereftam va
--faghat tafavote YYYY ba emsal made nazaram bud
SELECT t.*
FROM titles t
WHERE DATEDIFF(YEAR, t.pubdate, GETDATE()) > 30;
--QUERY05
SELECT CONCAT(a.au_fname,' ',a.au_lname) FullName, a.address, ISNULL(SUM(s.qty),0) NumOfSales_Books 
FROM authors a FULL OUTER JOIN titleauthor ta ON a.au_id = ta.au_id
FULL OUTER JOIN sales s ON s.title_id = ta.title_id
GROUP BY a.au_id, a.au_fname, a.au_lname, a.address;