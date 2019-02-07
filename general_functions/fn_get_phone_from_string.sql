USE [Sandbox]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Beau Kinstler
-- Create date: 2/6/2019
-- Description:	get phonenumber out of a string
--              if more than one, will return a csv field with multiple.
--              Expects an SQL safe string, so check any imput from untrusted
--              Sources
--				Expects that the phone number isn't deimited with spaces, if 
--				the text is also delimted with spaces.
-- =============================================
CREATE FUNCTION [dbo].[fn_get_phone_from_string] 
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
    Declare @phone_chars as varchar(50) = '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'

    -- loop we've parsed all but the last column, unless there's only one
    -- which will be parsed
    While PatIndex('%'+ @delim +'%', @safe_string) > 0
	  BEGIN
        set @temp = left(@safe_string,PatIndex('%'+ @delim +'%', @safe_string) -1 )
        set @temp = REPLACE(@temp,' ','')
        set @temp = REPLACE(@temp,'(','')
        set @temp = REPLACE(@temp,')','')
        set @temp = REPLACE(@temp,'.','')
        set @temp = REPLACE(@temp,'-','')
        set @safe_string = substring(@safe_string,PatIndex('%'+ @delim +'%', @safe_string) + 1,100)
        if PatIndex('%'+ @phone_chars +'%', @temp) > 0 and len(@temp) >= 10 and @temp not like '%_____-____%'
			set @result = LTRIM(RTRIM(@result + ', ' + dbo.fn_phone_number_formatter(@temp)))
    END

    -- one more pass to check the last column for an phone
    --set @temp = left(@safe_string,PatIndex('%'+ @delim +'%', @safe_string) -1 )
    if PatIndex('%'+ @phone_chars +'%', @safe_string) > 0 and len(@safe_string) >= 10 and @safe_string not like '%_____-____%'
			set @result = LTRIM(RTRIM(@result + ', ' + dbo.fn_phone_number_formatter(@safe_string)))

    Return LTRIM(RTRIM(stuff(@result, CHARINDEX(', ',@result), LEN(', '), '')))

END
GO


