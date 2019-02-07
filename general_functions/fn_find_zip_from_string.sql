USE [Sandbox]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Beau Kinstler
-- Create date: 2/6/2019
-- Description:	get zip out of a string
--              if more than one, will return a csv field with multiple.
--              Expects an SQL safe string, so check any imput from untrusted
--              Sources
--				Expects that the zip number isn't deimited with spaces, if 
--				the text is also delimted with spaces.
-- =============================================
CREATE FUNCTION [dbo].[fn_get_zip_from_string] 
(

	@safe_string varchar(max),
	@delim varchar(1) = ' '
)
RETURNS varchar(max)
AS
BEGIN
    declare @temp as varchar(max) = ''
    declare @result as varchar(max) = ''
    Declare @zip_5_chars as varchar(50) = '[0-9][0-9][0-9][0-9][0-9]'
    Declare @zip_9_chars as varchar(50) = '[0-9][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'

    -- loop we've parsed all but the last column, unless there's only one
    -- which will be parsed
    While PatIndex('%'+ @delim +'%', @safe_string) > 0
	  BEGIN
        set @temp = left(@safe_string,PatIndex('%'+ @delim +'%', @safe_string) -1 )
        set @safe_string = substring(@safe_string,PatIndex('%'+ @delim +'%', @safe_string) + 1,100)
        if PatIndex(@zip_5_chars, @temp) > 0 or PatIndex('%'+ @zip_9_chars +'%', @temp) >0
			set @result = LTRIM(RTRIM(@result + ', ' + (@temp)))
    END

    -- one more pass to check the last column for an zip
    if PatIndex( @zip_5_chars, @safe_string) > 0 or PatIndex('%'+ @zip_9_chars +'%', @safe_string) >0
			set @result = LTRIM(RTRIM(@result + ', ' + (@safe_string)))

    Return LTRIM(RTRIM(stuff(@result, CHARINDEX(', ',@result), LEN(', '), '')))

END
GO


