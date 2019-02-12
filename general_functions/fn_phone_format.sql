USE [Sandbox]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_phone_number_formatter]    Script Date: 2/12/2019 12:55:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Beau Kinstler
-- Create date: 2/6/2019
-- Description:	RETURN A PHONE NUMBER IN A STANDARD US FORMAT
--  See 'C:\Users\beau.support\Documents\SQL Server Management Studio \
--				\owner_cleanup_email\test_fn_phone_number_formatter.sql'
-- for tests
-- =============================================

ALTER FUNCTION [dbo].[fn_phone_number_formatter]
(
    @safe_string varchar(max)-- expecting string safe from sql injections
)

RETURNS varchar
(max)
AS
BEGIN
    Declare @phone_chars as varchar(50) = '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
    DECLARE @result as varchar(13)

    set @safe_string = [dbo].[fn_get_phone_number_nums_only] (@safe_string)
    if PatIndex(@phone_chars, @safe_string) = 1
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

