USE [Sandbox]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_get_phone_number_nums_only]    Script Date: 2/12/2019 1:08:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Beau Kinstler
-- Create date: 
-- Description:	strip non-number chars common in phone numbers out of phone numbers
-- expects input will be not longer than than something like this: +1(XXX) 555 1111
-- and the 
-- =============================================
ALTER FUNCTION [dbo].[fn_get_phone_number_nums_only] 
(
	-- Add the parameters for the function here
	@phone_with_chars varchar(max)
)
RETURNS varchar(10)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @Result varchar(10)
    if len(@phone_with_chars) <= 16	
	BEGIN
        -- Add the T-SQL statements to compute the return value here
        set @phone_with_chars = REPLACE(@phone_with_chars,' ','')
        set @phone_with_chars = REPLACE(@phone_with_chars,'(','')
        set @phone_with_chars = REPLACE(@phone_with_chars,')','')
        set @phone_with_chars = REPLACE(@phone_with_chars,'.','')
        set @phone_with_chars = REPLACE(@phone_with_chars,'-','')
        set @phone_with_chars = REPLACE(@phone_with_chars,'+1','')
        if len(@phone_with_chars) = 10
			SELECT @Result = @phone_with_chars

    END


    -- Return the result of the function
    RETURN @Result

END
GO


