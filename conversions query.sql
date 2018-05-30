--7. Conversions--

--1. 
	-- CAST Syntax:  
	CAST ( expression AS data_type [ ( length ) ] )  
	
	--Cast
	SELECT 9.5 AS Original, CAST(9.5 AS int) AS int, 
    CAST(9.5 AS decimal(6,4)) AS decimal;
	
	-- CONVERT Syntax:  
	CONVERT ( data_type [ ( length ) ] , expression [ , style ] )  

	--Convert
	SELECT 9.5 AS Original, CONVERT(int, 9.5) AS int, 
    CONVERT(decimal(6,4), 9.5) AS decimal;

--2.
	--syntax : PARSE ( string_value AS data_type [ USING culture ] )
	SELECT PARSE('Wednesday, 12 June 1996' AS datetime2 USING 'en-US') AS Result;

--3. TRY_CAST ()
	--syntax : TRY_CAST( expression AS data_type [ ( length ) ] )

	-- A. TRY_CAST returns null

	SELECT   
    CASE WHEN TRY_CAST('test' AS nvarchar) IS NULL   
    THEN 'Cast failed'  
    ELSE 'Cast succeeded'  
	END AS Result;  
	GO

	--or

	SELECT   
    CASE WHEN TRY_CAST('test' AS float) IS NULL   
    THEN 'Cast failed'  
    ELSE 'Cast succeeded'  
	END AS Result;  
	GO

	--correct format results value
	SET DATEFORMAT dmy;  
	SELECT TRY_CAST('1996-06-12' AS datetime2) AS Result;  
	GO
	--or
	--incorrect format results null
	SET DATEFORMAT dmy;  
	SELECT TRY_CAST('12/31/2010' AS datetime2) AS Result;  
	GO

	--B. TRY_CAST fails with an error
	SELECT TRY_CAST(4 AS xml) AS Result;  
	GO

	--or

	--C. TRY_CAST gives result
	SELECT TRY_CAST(4 AS int) AS Result;  
	GO


--4. TRY_CONVERT
	--syntax : TRY_CONVERT ( data_type [ ( length ) ], expression [, style ] )

	--A. TRY_CONVERT returns null
	SELECT   
    CASE WHEN TRY_CONVERT(float, 'test') IS NULL   
    THEN 'Cast failed'  
    ELSE 'Cast succeeded'  
	END AS Result;  
	GO

	--B. TRY_CONVERT fails with an error
	SELECT TRY_CONVERT(xml, 4) AS Result;  
	GO

	--C. TRY_CONVERT succeeds
	SET DATEFORMAT mdy;  
	SELECT TRY_CONVERT(datetime2, '12/31/2010') AS Result;  
	GO

--5. TRY_PARSE
	--syntax : TRY_PARSE ( string_value AS data_type [ USING culture ] )
	
	--A. Simple example of TRY_PARSE
	SELECT TRY_PARSE('Jabberwokkie' AS datetime2 USING 'en-US') AS Result;

	--B. Detecting nulls with TRY_PARSE
	SELECT  
    CASE WHEN TRY_PARSE('Aragorn' AS decimal USING 'sr-Latn-CS') IS NULL  
        THEN 'True'  
        ELSE 'False'  
	END  
	AS Result;

	--C. Using IIF with TRY_PARSE and implicit culture setting
	SET LANGUAGE English;  
	SELECT IIF(TRY_PARSE('01/01/2011' AS datetime2) IS NULL, 'True', 'False') AS Result;

--6.-- CONCAT ()
	--SYNTAX : CONCAT ( string_value1, string_value2 [, string_valueN ] )
	--A. Using concat
	SELECT CONCAT ( 'Happy ', 'Birthday ', 11, '/', '25' ) AS Result;

	--B. Using CONCAT with NULL values
	CREATE TABLE #temp (  
    emp_name nvarchar(200) NOT NULL,  
    emp_middlename nvarchar(200) NULL,  
    emp_lastname nvarchar(200) NOT NULL  
	);  
	INSERT INTO #temp VALUES( 'Name', NULL, 'Lastname' );  
	SELECT CONCAT( emp_name, emp_middlename, emp_lastname ) AS Result  
	FROM #temp;

--7. FORMAT ()
	--SYNTAX : FORMAT ( value, format [, culture ] )
	DECLARE @d DATETIME = '10/01/2011';  
	SELECT FORMAT ( @d, 'd', 'en-US' ) AS 'US English Result'  
      ,FORMAT ( @d, 'd', 'en-gb' ) AS 'Great Britain English Result'  
      ,FORMAT ( @d, 'd', 'de-de' ) AS 'German Result'  
      ,FORMAT ( @d, 'd', 'zh-cn' ) AS 'Simplified Chinese (PRC) Result';   

	SELECT FORMAT ( @d, 'D', 'en-US' ) AS 'US English Result'  
      ,FORMAT ( @d, 'D', 'en-gb' ) AS 'Great Britain English Result'  
      ,FORMAT ( @d, 'D', 'de-de' ) AS 'German Result'  
      ,FORMAT ( @d, 'D', 'zh-cn' ) AS 'Chinese (Simplified PRC) Result';

--8. IIF ()
	--SYNTAX : IIF ( boolean_expression, true_value, false_value )
	--A. Simple iif example
	DECLARE @a int = 45, @b int = 40;  
	SELECT IIF ( @a > @b, 'TRUE', 'FALSE' ) AS Result;

	--B. IIF with NULL constants
	SELECT IIF ( 45 > 30, NULL, NULL ) AS Result;

	--C. IIF with NULL parameters
	DECLARE @P INT = NULL, @S INT = NULL;  
	SELECT IIF ( 45 > 30, @p, @s ) AS Result;

--9.-- CHOOSE ()
	--SYNTAX : CHOOSE ( index, val_1, val_2 [, val_n ] )
	--A. 
	SELECT CHOOSE ( 3, 'Manager', 'Director', 'Developer', 'Tester' ) AS Result;
	--B. 
	
	SELECT PersonID, CHOOSE (PersonID, 'A','B','C','D','E') AS Expression1  
	FROM dbo.Associate;

--10.-- CHARINDEX()
		--SYNTAX : CHARINDEX ( expressionToFind , expressionToSearch [ , start_location ] )
		
		--A. Returning the starting position of an expression
		DECLARE @document varchar(64);  
		SELECT @document = 'Reflectors are vital safety' +  
                   ' components of your bicycle.';  
		SELECT CHARINDEX('bicycle', @document);  
		GO

--11.-- LEFT ()
	--SYNTAX : LEFT ( character_expression , integer_expression )

	--A. USING LEFT WITH A COLUMN
	SELECT LEFT(FirstName, 5)   
	FROM dbo.Associate
	ORDER BY PersonID;  
	GO

	--B. Using LEFT with a character string
	SELECT LEFT('abcdefg',2);  

--12.-- LTRIM ()
	--SYNTAX : LTRIM ( character_expression )
	
	--A. SIMPLE EXAMPLE : 
	SELECT LTRIM('     Five spaces are at the beginning of this string.') FROM Associate;

	--B. EXAMPLE USING A VARIABLE
	DECLARE @string_to_trim varchar(60);  
	SET @string_to_trim = '     5 spaces are at the beginning of this string.';  
	SELECT 
    @string_to_trim AS 'Original string',
    LTRIM(@string_to_trim) AS 'Without spaces';  
	GO


--13.-- LEN ()
	--SYNTAX : LEN ( string_expression )
	SELECT LEN(FirstName) AS Length, FirstName, LastName   
	FROM Associate 
	WHERE City = 'Nagpur';  


--14.-- LEft ()
	--SYNTAX : LEFT ( character_expression , integer_expression )
	
	--A. Using LEFT with a column
	SELECT LEFT(FirstName, 5)   
	FROM Associate
	ORDER BY PersonId;  

	--B. Using LEFT with a CHARACTER STRING
	SELECT LEFT('abcdefg',2); 
	
--15.-- RIGHT ()
	--SYNTAX : RIGHT ( character_expression , integer_expression ) 
	
	--A: Using RIGHT with a column
	SELECT RIGHT(LastName, 5) AS 'LastName'  
	FROM Associate
	WHERE PersonID < 5  
	ORDER BY LastName;  


--16.--	  ROW NUMBER ()
		--Partition By ()
    SELECT *, ROW_NUMBER() OVER(Partition by FirstName ORDER BY FirstName) AS Row_Number  
    FROM Associate

