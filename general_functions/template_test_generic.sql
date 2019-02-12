USE [Sandbox]
GO

/*
 * Generic template for testing SQL functions
*/
declare @debug as bit = 1
-- set to 1 to see all tests, not just failing ones

declare @result as varchar(max)
declare @param as varchar(max)
declare @exp_result as varchar(max)

--  ADDITIONAL global test variables here
-- DECLARE @x as int = 0

-- GIVEN 
-- Some data
-- WHEN 
-- that data is set to X
-- THEN
-- Result should be Y

-- Unit test variables set for each test here
-- may also want to name tests here, if multiple per file
-- test 1
set @param = 1
set @exp_result = 1
SELECT @result = @param
if isnull(@result,'') <> isnull(@exp_result,'')
    select @result as  'result', @exp_result as 'expected', '** FAIL **' as result, @param as parameter;
else
    if @debug = 1
        select @result as  'result', @exp_result as 'expected', 'pass' as result, @param as parameter;


-- test 2
set @param = 2
set @exp_result = 1
SELECT @result = @param
if @result <> @exp_result
    select @result as  'result', @exp_result as 'expected', '** FAIL **' as result, @param as parameter;
else
    if @debug = 1
        select @result as  'result', @exp_result as 'expected', 'pass' as result, @param as parameter;

-- test 3
set @param = 1
set @exp_result = NULL
SELECT @result = @param
if isnull(@result,'') <> isnull(@exp_result,'')
    select @result as  'result', @exp_result as 'expected', '** FAIL **' as result, @param as parameter;
else
    if @debug = 1
        select @result as  'result', @exp_result as 'expected', 'pass' as result, @param as parameter;