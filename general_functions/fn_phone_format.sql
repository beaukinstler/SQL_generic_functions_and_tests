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

ALTER FUNCTION dbo.fn_phone_number_formatter
(
    @safe_string varchar(max)-- expecting string safe from sql injections
)

RETURNS varchar
(max)
AS
BEGIN
    declare @result as varchar(13) = ''

    set @safe_string = REPLACE(@safe_string,'.','')
    set @safe_string = REPLACE(@safe_string,'-','')
    set @safe_string = REPLACE(@safe_string,'(','')
    set @safe_string = REPLACE(@safe_string,')','')
    set @safe_string = REPLACE(@safe_string,' ','')
    set @result = 
            '(' + 
            substring(@safe_string,1,3) +
            ')' +
            substring(@safe_string,4,3) +
            '-' +
            substring(@safe_string,7,4)
        
    return @result
END

GO