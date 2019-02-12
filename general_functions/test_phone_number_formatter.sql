USE Sandbox
GO

/*
 *  Tests for dbo.fn_phone_number_formatter
 *  Tests pass if they return 1
*/

declare @result as varchar(max)
declare @param as varchar(max)
declare @exp_result as varchar(max)
declare @debug as bit = 1

-- should return (555)555-4444
set @param = '555.555.4444'
set @exp_result = '(555)555-4444'
SELECT @result= [dbo].[fn_phone_number_formatter] (@param)
if isnull(@result, '') <> isnull(@exp_result,'')
    select @result as  'result', @exp_result as 'expected', '** FAIL **' as test_status;
else
    if @debug = 1
		select @result as  'result', @exp_result as 'expected', 'pass' as test_status;

-- should return (555)555-5555
set @param = '(555)555.5555'
set @exp_result = '(555)555-5555'
SELECT @result= [dbo].[fn_phone_number_formatter] (@param)
if isnull(@result, '') <> isnull(@exp_result,'')
    select @result as  'result', @exp_result as 'expected', '** FAIL **' as test_status;
else
    if @debug = 1
		select @result as  'result', @exp_result as 'expected', 'pass' as test_status;

-- should return (555)555-4444
set @param = '555-555-4444'
set @exp_result = '(555)555-4444'
SELECT @result= [dbo].[fn_phone_number_formatter] (@param)
if isnull(@result, '') <> isnull(@exp_result,'')
    select @result as  'result', @exp_result as 'expected', '** FAIL **' as test_status;
else
    if @debug = 1
		select @result as  'result', @exp_result as 'expected', 'pass' as test_status;

-- should return (555)555-4444
set @param = ' 555 555 4444'
set @exp_result = '(555)555-4444'
SELECT @result= [dbo].[fn_phone_number_formatter] (@param)
if isnull(@result, '') <> isnull(@exp_result,'')
    select @result as  'result', @exp_result as 'expected', '** FAIL **' as test_status;
else
    if @debug = 1
		select @result as  'result', @exp_result as 'expected', 'pass' as test_status;