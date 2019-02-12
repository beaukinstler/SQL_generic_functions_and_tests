USE [Sandbox]
GO

/*
 *  Tests for dbo.fn_get_phone_from_string
 *  Tests pass if they return 1
 *  If they return a table, it shows that they havn'te returned the proper value, but shows 
 *  the result, and what was expected.
*/
declare @debug as bit = 1 -- set to 1 to see all tests, not just failing ones

declare @result as varchar(max)
declare @param as varchar(max)
declare @exp_result as varchar(max)
declare @delim as varchar(1)

-- should return 55555
set @delim = ' '
set @param = @delim + @delim + '55555' + @delim  + @delim + '55555'
set @exp_result = '55555, 55555'
SELECT @result= [dbo].[fn_get_zip_from_string] (@param, @delim)
if isnull(@result,'') <> isnull(@exp_result,'')
    select @result as  'result', @exp_result as 'expected', '** FAIL **' as result, @param as parameter;
else
    if @debug = 1
        select @result as  'result', @exp_result as 'expected', 'pass' as result, @param as parameter;

-- should return NULL
set @delim = ' '
set @param = @delim + @delim + 'first' + @delim + '5555555555' + @delim + 'last'
set @exp_result = NULL
SELECT @result= [dbo].[fn_get_zip_from_string] (@param, @delim)
if isnull(@result,'') <> isnull(@exp_result,'')
    select @result as  'result', @exp_result as 'expected', '** FAIL **' as result, @param as parameter;
else
    if @debug = 1
        select @result as  'result', @exp_result as 'expected', 'pass' as result, @param as parameter;


set @delim = ','
set @param = @delim + @delim + 'first' + @delim + '5555555555' + @delim + 'last'
set @exp_result = NULL
SELECT @result= [dbo].[fn_get_zip_from_string] (@param, @delim)
if isnull(@result,'') <> isnull(@exp_result,'')
    select @result as  'result', @exp_result as 'expected', '** FAIL **' as result, @param as parameter;
else
    if @debug = 1
        select @result as  'result', @exp_result as 'expected', 'pass' as result, @param as parameter;

-- spaces in the phone number
set @delim = ','
set @param = @delim + @delim + 'first' + @delim + '555  555 5555' + @delim + 'last'
set @exp_result = NULL
SELECT @result= [dbo].[fn_get_zip_from_string] (@param, @delim)
if isnull(@result,'') <> isnull(@exp_result,'')
    select @result as  'result', @exp_result as 'expected', '** FAIL **' as result, @param as parameter;
else
    if @debug = 1
        select @result as  'result', @exp_result as 'expected', 'pass' as result, @param as parameter;

-- complicated with emails in in it.
set @delim = ','
set @param = @delim + @delim + 'first' + @delim + '5555555555' + @delim + 'last'
		+ ',first@.com,fdslk@sdlfkjas.com,4441114444,'
set @exp_result = '(555)555-5555, (444)111-4444'
SELECT @result= [dbo].[fn_get_zip_from_string] (@param, @delim)
if isnull(@result,'') <> isnull(@exp_result,'')
    select @result as  'result', @exp_result as 'expected', '** FAIL **' as result, @param as parameter;
else
    if @debug = 1
        select @result as  'result', @exp_result as 'expected', 'pass' as result, @param as parameter;

--complicated with emails and  zip code with dashes
set @delim = ','
set @param = @delim + '55555' + @delim + 'first' + @delim + '5555555555' + @delim + 'last'
		+ ',first@.com,fdslk@sdlfkjas.com,4441114444'
set @exp_result = '55555'
SELECT @result= [dbo].[fn_get_zip_from_string] (@param, @delim)
if isnull(@result,'') <> isnull(@exp_result,'')
    select @result as  'result', @exp_result as 'expected', '** FAIL **' as result, @param as parameter;
else
    if @debug = 1
        select @result as  'result', @exp_result as 'expected', 'pass' as result, @param as parameter;


-- complicated with address numbers and zip
set @delim = ','
set @param = @delim + @delim + 'first' + @delim + '5555555555' + @delim + 'last'
		+ @delim + '456 elm st.' + @delim + 'MN' + @delim + '55555-1234'
set @exp_result = '55555-1234'
SELECT @result= [dbo].[fn_get_zip_from_string] (@param, @delim)
if isnull(@result,'') <> isnull(@exp_result,'')
    select @result as  'result', @exp_result as 'expected', '** FAIL **' as result, @param as parameter;
else
    if @debug = 1
        select @result as  'result', @exp_result as 'expected', 'pass' as result, @param as parameter;

