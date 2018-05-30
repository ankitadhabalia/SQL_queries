
--6.-- All functions of date

--1.-- GETDATE()
Declare @Date datetime   
set @Date = (SELECT GETDATE());  
Print @Date 

--2.-- DATEADD()
--SYNTAX :  DATEADD(datetimepart, number, date)

    --Adding days  
    Select DATEADD(day, 5,getdate()) as New_Date  
      
    --Subtracting days    
    SELECT DATEADD(day, -2,getdate()) as New_Date  
      
    --Adding Months  
    SELECT DATEADD(MONTH, 2,getdate()) as New_Month  
      
    --Subtracting Months  
    SELECT DATEADD(MONTH, -2,getdate()) as New_Month 
	
--3.-- DATEDIFF()

--SYNTAX : DATEDIFF(datepart, starting_date, ending_date)  
     --a.-- 
	 -- Declare Four DateTime Variable  
    Declare @Starting_Date datetime   
    Declare @Ending_Date datetime   
    Declare @Ending_Month datetime   
    Declare @Ending_Year datetime   

     --Set @Staring_Date with Current Date  
    set @Starting_Date = (SELECT GETDATE());  
      
    -- Set @Ending_Date with 5 days more than @Ending_Date  
    set @Ending_Date = (SELECT DATEADD(day, 5,@Starting_Date ))
	  
    -- Get The Date Difference  
    SELECT DATEDIFF(day, @Starting_Date, @Ending_Date) AS Difference_Of_Days  
     

	   --b.-- 
	 -- Declare Four DateTime Variable  
    Declare @Starting_Date datetime   
    Declare @Ending_Date datetime   
    Declare @Ending_Month datetime   
    Declare @Ending_Year datetime   
	 
	 -- Set @Staring_Date with Current Date  
    set @Starting_Date = (SELECT GETDATE());  
    
    -- Set @Ending_Date with 8 Month more than @Ending_Date  
    set @Ending_Month = (SELECT DATEADD(MONTH, 8,@Starting_Date )) 
	 
    -- Get The Date Difference  
    SELECT DATEDIFF(MONTH, @Starting_Date, @Ending_Month) AS Difference_Of_Months  
    

	   --c.-- 
	 -- Declare Four DateTime Variable  
    Declare @Starting_Date datetime   
    Declare @Ending_Date datetime   
    Declare @Ending_Month datetime   
    Declare @Ending_Year datetime   
	 
	 -- Set @Staring_Date with Current Date  
    set @Starting_Date = (SELECT GETDATE());  
	  
    -- Set @Ending_Date with 2 Month more than @Ending_Date  
    set @Ending_Year = (SELECT DATEADD(YEAR, 2,@Starting_Date ))  

    -- Get The Date Difference  
    SELECT DATEDIFF(YEAR, @Starting_Date, @Ending_Year) AS Difference_Of_Years 
	
	
--4.--  DATEPART()
--syntax : DATEPART(datepart, date)  
    
	declare @date datetime  
    set @date=GETDATE();  
      
    SELECT DATEPART(DAY, @date) AS Day,   
    DATEPART(MONTH, @date) AS Month,   
    DATEPART(YEAR, @date) AS Year,   
    DATEPART(HOUR, @date) AS Hour,   
    DATEPART(MINUTE,@date) AS Minute,   
    DATEPART(SECOND, @date) AS SECOND  

--5.--	DATENAME()
--syntax : DATENAME(datepart, date)  

	-- Get Today   
	SELECT DATENAME(DW, getdate()) AS 'Today Is'  
  
	-- Get Month name  
	SELECT DATENAME(M, getdate()) AS 'Month'


--6.-- DAY(), MONTH (0, YEAR ()
	--syntax : DAY(datetime)  
	--syntax : MONTH(datetime)  
	--syntax : YEAR(getdate()) 'Year' 
	      
		SELECT DAY(getdate()) 'TODAY DATE'  
		    SELECT MONTH(getdate()) 'MONTH'  
		    SELECT YEAR(getdate()) 'Year'  

--7.-- ISDATE()
--SYNTAX : ISDATE ( expression ) 

IF ISDATE('2018-05-24 10:19:41.177') =1
    PRINT 'VALID'  
ELSE  
    PRINT 'INVALID';  


--8.-- GETUTCDATE()  
	-- SYNTAX : GETUTCDATE() 
	 SELECT 'GETUTCDATE()  ', GETUTCDATE();   


--9.-- DATEFROMPARTS ()
	-- SYNTAX : DATEFROMPARTS ( year, month, day ) 
	SELECT DATEFROMPARTS ( 1996, 06, 12 ) AS Result;  