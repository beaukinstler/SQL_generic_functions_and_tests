USE [Sandbox]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Beau Kinstler
-- Create date: 2/6/2019
-- Description:	get email addresss out of a string
--              if more than one, will return a csv field with multiple.
--              Expects an SQL safe string, so check any imput from untrusted
--              Sources
-- =============================================
ALTER FUNCTION [dbo].[fn_get_email_from_string] 
(
	-- Add the parameters for the function here
	@safe_string varchar(max),
	@delim varchar(1) = ' '
)
RETURNS varchar(max)
AS
BEGIN
	declare @temp as varchar(max) = ''
	declare @result as varchar(max) = ''
    Declare @email_chars as varchar(50) = '[@,\.]'

	-- loop we've parsed all but the last column, unless there's only one
	-- which will be parsed
    While PatIndex('%'+ @delim +'%', @safe_string) > 0
	  BEGIN
        set @temp = left(@safe_string,PatIndex('%'+ @delim +'%', @safe_string) -1 )
		set @safe_string = substring(@safe_string,PatIndex('%'+ @delim +'%', @safe_string) + 1,100)
		if PatIndex('%'+ @email_chars +'%', @temp) > 0
			select @result = LTRIM(RTRIM(@result + ', ' + @temp)) 
	  END

	-- one more pass to check the last column for an email
	set @temp = left(@safe_string,PatIndex('%'+ @delim +'%', @safe_string) -1 )
	if PatIndex('%'+ @email_chars +'%', @temp) > 0
			select @result = LTRIM(RTRIM(@result + ', ' + @temp))

    Return LTRIM(RTRIM(stuff(@result, CHARINDEX(', ',@result), LEN(', '), '')))

END
GO


