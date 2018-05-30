--1.-- PIVOT
--Pivot for names into year

    SELECT [Year], Pankaj,Rahul,Sandeep FROM   
    (SELECT Name, [Year] , Sales FROM PivotTable )Tab1  
    PIVOT  
    (  
    SUM(Sales) FOR Name IN (Pankaj,Rahul,Sandeep)) AS Tab2  
    ORDER BY [Tab2].[Year] 
	

	--Pivot for year into names
	 SELECT Name, [2010],[2011],[2012] FROM   
    (SELECT Name, [Year] , Sales FROM PivotTable )Tab1  
    PIVOT  
    (  
    SUM(Sales) FOR [Year] IN ([2010],[2011],[2012])) AS Tab2  
    ORDER BY Tab2.Name 


--2.-- UNPIVOT
	--All 3 are included in unpivot while performing
	 
	  --1. Declare temp variable 
	    DECLARE @Tab TABLE  
    (  
    [Year] int,  
    Pankaj int,  
    Rahul int,  
    Sandeep int  
    )  

	--2. Insert Value in Temp Variable

	    INSERT INTO @Tab  
    SELECT [Year], Pankaj,Rahul,Sandeep FROM   
    (SELECT Name, [Year] , Sales FROM PivotTable)Tab1  
    PIVOT  
    (  
    SUM(Sales) FOR Name IN (Pankaj,Rahul,Sandeep)) AS Tab2  
    ORDER BY [Tab2].[Year]  

	--3. Perform unpivot operation
	    SELECT Name,[Year] , Sales FROM @Tab t  
    UNPIVOT  
    (  
    Sales FOR Name IN (Pankaj,Rahul,Sandeep)  
    ) AS TAb2  

	--AFTER PERFORMING ALL 3 QUERIES OUTPUT WILL BE SAME AS ORIGINAL TABLE


	--Unpivot and pivot in same query
	    SELECT Name,[Year] , Sales FROM   
    (  
    SELECT [Year], Pankaj,Rahul,Sandeep FROM   
    (SELECT Name, [Year] , Sales FROM PivotTable )Tab1  
    PIVOT  
    (  
    SUM(Sales) FOR Name IN (Pankaj,Rahul,Sandeep)) AS Tab2  
    )Tab  
    UNPIVOT  
    (  
    Sales FOR Name IN (Pankaj,Rahul,Sandeep)  
    ) AS TAb2  


--3.-- TOP QUERY

	 SELECT TOP 5 PersonID, FirstName, LastName, City, empSales
     FROM dbo.Associate
     ORDER BY empSales DESC


	 --example
---------------top 10 Querrry---------
select * from(
select
rank() over(order by sum(PersonID)desc) as ranking,

sum(PersonID)as total from Associate group by FirstName) as D
where D.ranking<=10


--4.-- Ranking includes dense rank, rank, row number, ntile

SELECT FirstName, LastName  
    ,ROW_NUMBER() OVER (ORDER BY empSales) AS "Row Number"  
    ,RANK() OVER (ORDER BY empSales) AS Rank  
    ,DENSE_RANK() OVER (ORDER BY empSales) AS "Dense Rank"  
    ,NTILE(4) OVER (ORDER BY empSales) AS Quartile  
  FROM dbo.Associate AS s 


--5.-- Paging

CREATE PROCEDURE People
(
  @pageNum INT,
  @pageSize INT
)
AS
BEGIN
    SELECT PersonID, FirstName, LastName
    FROM dbo.Associate WITH(NOLOCK)
    ORDER BY FirstName
    OFFSET (@pageNum - 1) * @pageSize ROWS
    FETCH NEXT @pageSize ROWS ONLY 
END

EXEC dbo.People
         @pageNum = 1, @pageSize = 3

		 
EXEC dbo.People 
         @pageNum = 2, @pageSize = 3

		 
EXEC dbo.People 
         @pageNum = 3, @pageSize = 3

