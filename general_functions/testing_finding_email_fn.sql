

USE [Sandbox]
GO

/*
 *  Tests for dbo.[fn_get_email_from_string]
 *  Tests pass if they return 1
 *  If they return a table, it shows that they havn'te returned the proper value, but shows 
 *  the result, and what was expected.
*/

declare @result as varchar(max)
declare @param as varchar(max)
declare @exp_result as varchar(max)
declare @delim as varchar(1)


set @delim = ' '
set @param = @delim + @delim + 'tes-t@exam-ple4.com' + @delim  + @delim
set @exp_result = 'tes-t@exam-ple4.com'
SELECT @result= [dbo].fn_get_email_from_string (@param, @delim)
if @result = @exp_result
    select 1;
else
    select @result as  'result', @exp_result as 'expected';


set @delim = ':'
set @param = @delim + @delim + 'tes-t@exam-ple4.com' + @delim  + @delim
set @exp_result = 'tes-t@exam-ple4.com'
SELECT @result= [dbo].fn_get_email_from_string (@param, @delim)
if @result = @exp_result
    select 1;
else
    select @result as  'result', @exp_result as 'expected';

set @delim = ' '
set @param = 'first' + @delim + 'fdslk@sdlfkjascom' + @delim  + 'last '
set @exp_result = NULL
SELECT @result= [dbo].fn_get_email_from_string (@param, @delim)
if @result IS NULL
    select 1;
else
    select @result as  'result', @exp_result as 'expected';

set @delim = ','
set @param = 'first' + @delim + 'fdslk@sdlfkjascom' + @delim  + 'last '
set @exp_result = NULL
SELECT @result= [dbo].fn_get_email_from_string (@param, @delim)
if @result IS NULL
    select 1;
else
    select @result as  'result', @exp_result as 'expected';

set @delim = ' '
set @param = 'first@.com' + @delim + 'fdslk@sdlfkjas.com' + @delim  + 'last '
set @exp_result = 'fdslk@sdlfkjas.com'
SELECT @result= [dbo].fn_get_email_from_string (@param, @delim)
if @result = @exp_result
    select 1;
else
    select @result as  'result', @exp_result as 'expected';


set @delim = ','
set @param = 'first@.com' + @delim + 'fdslk@sdlfkjas.com' + @delim  + 'last '
set @exp_result = 'fdslk@sdlfkjas.com'
SELECT @result= [dbo].fn_get_email_from_string (@param, @delim)
if @result = @exp_result
    select 1;
else
    select @result as  'result', @exp_result as 'expected';