--STORED PROCEDURE
--1. Example 
CREATE PROCEDURE uspNewFindCountries
                 @PersonID [int]
AS
BEGIN
   SET NOCOUNT ON;
   SELECT FirstName,
         empSales
   FROM  dbo.Associate
   WHERE  PersonID = @PersonID
END

EXECUTE uspNewFindCountries 101

---------------------------------------------------------------------------------------------------------------------
--working example of stored procedure

		--a. -----------create procedure------------------

CREATE PROCEDURE uspCalcArea
                 @height float,
                 @width float,
                 @area float OUTPUT
AS
BEGIN TRY
   SELECT @area = @height * @width;
   RETURN 0
END TRY
BEGIN CATCH
   RETURN 1
END CATCH;

			--b. ------------------ value Declaration-----------

Declare @areaparm float=0.0;
Declare @h float=3.0;
Declare @w float=5.0;

			--c. ------execute stored procedure with declared variables----------

execute dbo.uspCalcArea @h,@w,@areaparm OUTPUT
SELECT @areaparm as roof

			--d. ----------simple method execution-------------
declare @areaout float;
DECLARE @returnValue int;
execute @returnValue = dbo.uspCalcArea 55,47,@areaout OUTPUT
SELECT @areaout as roof, @returnValue as ReturnValue

---------------------------------------------------------------------------------------------------------------------
--2. Example without dynamic sql
SELECT  FirstName,   empSales
FROM  dbo.Associate
WHERE   empBonus = 500

SELECT  FirstName,   empSales
FROM  dbo.Associate
WHERE   empBonus = 1500


---------------------------------------------------------------------------------------------------------------------
--3. Example with dynamic sql
DECLARE @empSales int = 15000
DECLARE @statement NVARCHAR(4000)

WHILE @empSales <= 25000
BEGIN
   SET @statement = '
        SELECT   FirstName, LastName, City
        FROM     dbo.Associate
        WHERE    empBonus = ' + CAST(@empSales as NVARCHAR) +
      ' GROUP BY empSales'

   SET @empSales = @empSales + 1
END

 EXECUTE sp_executesql @statement

 
---------------------------------------------------------------------------------------------------------------------
--4. example of sp_executesql
DECLARE @statement1 NVARCHAR(4000)
SET @statement1 = N'SELECT getdate()'
EXECUTE sp_executesql  @statement1


---------------------------------------------------------------------------------------------------------------------
--5. example of sp_executesql with if-else
CREATE PROCEDURE uspCalcuateSales
                 @returnAverage bit
AS
DECLARE @statement NVARCHAR(4000),
@function NVARCHAR(10)
IF (@returnAverage = 1) SET @function = 'Avg'
ELSE SET @function = 'Sum'

SET @statement =
    'SELECT  Assc.PersonID,' +
             @function +  + '(Assc.LineTotal) as Result' + @function + '
     FROM    Associate.empSales Assc
             INNER JOIN Employee.empName emp
                        ON emp.id = emp.id
     WHERE    emp.empDOB = 1996
     GROUP BY  Assc.PersonID'

EXECUTE sp_executesql @statement


---------------------------------------------------------------------------------------------------------------------
--6. Using sp_executesql with Parameters
DECLARE @statement NVARCHAR(4000)
DECLARE @parameterDefinition NVARCHAR(4000)

SET @statement = N'SELECT @a * @b - @a'
SET @parameterDefinition = N'@a int, @b int'

EXECUTE sp_executesql  @statement, @parameterDefinition, @a=10, @b=25


---------------------------------------------------------------------------------------------------------------------
--7. using union
SELECT emp.empID,emp.empName,emp.empPhone
FROM   Employee AS emp
UNION ALL
SELECT prod.Id,prod.Name,prod.Price
FROM   Products AS prod


---------------------------------------------------------------------------------------------------------------------
--8. using if..else
CREATE PROCEDURE uspCalcVelocity
                 @distance float,
                 @time float,
                 @velocity float OUTPUT
AS

IF (@time = 0.00)
BEGIN
   -- we can't divide by zero, so assume time is 1 hour
   Select @time = 1;
   SELECT @velocity = @distance / @time;
END
ELSE
BEGIN
   SELECT @velocity = @distance / @time;   
END

Declare @v float
EXECUTE uspCalcVelocity 120.00, 2.00, @v OUTPUT
SELECT @v


---------------------------------------------------------------------------------------------------------------------
--9. example of nested if..else
DECLARE @a int = 5,
        @b int = 10

IF (@a > 4)
BEGIN
   PRINT '@a is largest'
   IF (@b < 10)
      PRINT '@b is smallest'
   ELSE
      PRINT '@b is largest'
END


---------------------------------------------------------------------------------------------------------------------
--10. example of WHILE, BREAK, and CONTINUE
--while :
--Setup Variables
DECLARE @myTable TABLE(WeekNumber int,
                       DateStarting smalldatetime)
DECLARE @n int = 0
DECLARE @firstWeek smalldatetime = '12/31/2017'

--Loop Through weeks
WHILE @n <= 52
BEGIN
   INSERT INTO @myTable VALUES (@n, DATEADD(wk,@n,@firstWeek));
   SELECT @n = @n + 1
END

--Show Results
SELECT WeekNumber, DateStarting
FROM   @myTable


--break : 
 DECLARE @myTable TABLE(WeekNumber int,
                       DateStarting smalldatetime)
DECLARE @n int = 0
DECLARE @firstWeek smalldatetime = '12/31/2017'
WHILE @n > -1
BEGIN
   INSERT INTO @myTable VALUES (@n, DATEADD(wk,@n,@firstWeek));
   SELECT @n = @n + 1
   IF @n > 52 BREAK
END


--continue : 
DECLARE @myTable TABLE(WeekNumber int,
                       DateStarting smalldatetime)
DECLARE @n int = 0
DECLARE @firstWeek smalldatetime = '12/31/2017'
WHILE @n > -1
BEGIN
   INSERT INTO @myTable VALUES (@n, DATEADD(wk,@n,@firstWeek));
   SELECT @n = @n + 1
   IF @n > 52 BREAK
   ELSE CONTINUE
   PRINT 'I Never get executed'
END


---------------------------------------------------------------------------------------------------------------------
--11. Stored procedure within store procedure

--1st store procedure
    create procedure Sp_insert (  
    @ID int, @TempName varchar(max)        
    ) as  
    begin   
    Declare @SampleTable Table(id int, Name varchar(max))  
    Insert into @SampleTable (id,Name) values (@ID,@TempName)  
    select * from @SampleTable        
    end   

--2nd store procedure	
    create procedure Sp_Call (  
    @SID int, @Name varchar(max)  
    )  
    as  
    begin  
    exec Sp_insert @ID=@SID,@TempName=@Name  
    end  
    
	--In the above query we are calling first stored procedure 'Sp_insert'
	-- and passing the parameter @ID and @TempName to it..
	-- Now execute the second procedure using the following query. It will call the first procedure and return the result. 
	Exec Sp_Call @SID=1,@Name='Ankita Dhabalia' 

---------------------------------------------------------------------------------------------------------------------
--12. Example – Inserting Single Row

WITH topSalesPerson (FullName, Price, rowguid)
AS (
    SELECT assc.FirstName + ' ' + assc.LastName, prod.Price, NEWID()
    FROM   Products prod
           INNER JOIN Associate assc
           ON prod.Id = assc.PersonID
    WHERE  prod.Price > 1000
)
INSERT INTO Products
            (FullName, Price, rowguid)
SELECT      FullName, Price, rowguid
FROM        topSalesPerson




