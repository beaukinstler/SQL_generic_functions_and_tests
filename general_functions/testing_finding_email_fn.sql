USE [Sandbox]
GO

declare @x as varchar(max)
-- should return fdslk@sdlfkjascom
SELECT @x= [dbo].[fn_get_email_from_string] (
   '    first fdslk@sdlfkjascom last ', ' ')
if @x = 'fdslk@sdlfkjascom'
    select 1;
else
    select 0;
GO


-- should return 'first@.com, fdslk@sdlfkjas.com' last
SELECT @x= [dbo].[fn_get_email_from_string] (
   '    first@.com fdslk@sdlfkjas.com last ', ' ')
if @x = 'first@.com, fdslk@sdlfkjas.com'
    select 1;
else
    select 0;
GO

-- should return 'fdslk@sdlfkjas.com, last@.com'
SELECT @x= [dbo].[fn_get_email_from_string] (
   '    first,fdslk@sdlfkjas.com,last@.com ', ',')
if @x = 'fdslk@sdlfkjas.com, last@.com'
    select 1;
else
    select 0;
GO

