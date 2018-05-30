--COMMON TABLE EXPRESSIONS & VIEWS

WITH   PersonCTE (PersonID, FirstName, LastName)
AS     (SELECT PersonID,
               FirstName,
               LastName
        FROM   Associate AS a

		),
PhoneCTE (Id, Price,Name)
AS     (SELECT Id,
               Price,
			   Name
        FROM   Products AS p
		 WHERE Price >= 1000
		)

SELECT a.FirstName, a.LastName,
      p.Price
FROM PhoneCTE p
   INNER JOIN PersonCTE a ON
      p.Id = a.PersonID

-----------------------------------------------------------------------------------------------------------
 SELECT * FROM Associate

------------------------------------------------------------------------------------------------------------
  CREATE VIEW vw_
  WITH Percentage_Profit_CTE(FirstName,Percentage,empBonus,Salary) 
    AS
    ( 
    SELECT FirstName,
    (CAST(empBonus AS float)/ CAST(Salary AS float)*100) Percentage,
	    empBonus,Salary
      FROM Associate
    )
    SELECT * FROM Percentage_Profit_CTE

------------------------------------------------------------------------------------------------------------


/* syntax :- view :

CREATE VIEW view_name AS
SELECT column1, column2.....
FROM table_name
WHERE [condition];
*/

CREATE VIEW CUSTOMERS_VIEW AS
SELECT FirstName,LastName,empBonus
FROM  Associate;

SELECT * FROM CUSTOMERS_VIEW;