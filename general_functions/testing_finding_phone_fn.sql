USE Sandbox
GO

/*
 *  Tests for dbo.fn_phone_number_formatter
 *  Tests pass if they return 1
*/

declare @result as varchar(max)
declare @param as varchar(max)
declare @exp_result as varchar(max)


-- should return (555)555-5555
set @param = '(555)555.5555'
set @exp_result = '(555)555-5555'
SELECT @result= [dbo].[fn_phone_number_formatter] (@param)
if @result = @exp_result
    select 1;
else
    select @result as  'result', @exp_result as 'expected';

-- should return (555)555-4444
set @param = '555-555-4444'
set @exp_result = '(555)555-4444'
SELECT @result= [dbo].[fn_phone_number_formatter] (@param)
if @result = @exp_result
    select 1;
else
    select @result as  'result', @exp_result as 'expected';

-- should return (555)555-4444
set @param = ' 555 555 4444'
set @exp_result = '(555)555-4444'
SELECT @result= [dbo].[fn_phone_number_formatter] (@param)
if @result = @exp_result
    select 1;
else
    select @result as  'result', @exp_result as 'expected';