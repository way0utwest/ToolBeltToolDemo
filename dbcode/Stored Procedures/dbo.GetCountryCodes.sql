SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetCountryCodes]
AS
BEGIN
		SELECT top 10
		  cc.CountryName
         ,cc.CountryCode
      
		 FROM dbo.CountryCodes AS cc
		 WHERE cc.ModifiedDate IS NOT NULL 
END
GO
