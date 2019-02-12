USE [Sandbox]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Beau Kinstler
-- Create date: 
-- Description:	strip non-number chars common in phone numbers out of phone numbers
-- =============================================
CREATE FUNCTION [dbo].[fn_get_phone_number_nums_only] 
(
	-- Add the parameters for the function here
	@phone_with_chars varchar(15)
)
RETURNS varchar(10)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @Result varchar(10)

    -- Add the T-SQL statements to compute the return value here
    set @phone_with_chars = REPLACE(@phone_with_chars,' ','')
    set @phone_with_chars = REPLACE(@phone_with_chars,'(','')
    set @phone_with_chars = REPLACE(@phone_with_chars,')','')
    set @phone_with_chars = REPLACE(@phone_with_chars,'.','')
    set @phone_with_chars = REPLACE(@phone_with_chars,'-','')
    set @phone_with_chars = REPLACE(@phone_with_chars,'+1','')
    SELECT @Result = @phone_with_chars

    -- Return the result of the function
    RETURN @Result

END
GO

