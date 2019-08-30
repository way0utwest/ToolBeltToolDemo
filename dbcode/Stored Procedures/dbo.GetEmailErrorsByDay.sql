SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetEmailErrorsByDay]
  @date DATE = null
/*
Description:

Changes:
Date       Who         Notes
---------- ---         ---------------------------------------------------
2/14/2017  WAY0UTWESTVAIO\way0u    
*/
AS
BEGIN

 IF @date IS NULL
  SELECT @date = DATEADD(DAY, -1, GETDATE())

  SELECT Errcount = COUNT(*)
   FROM dbo.EmailErrorLog
   WHERE EmailDate = @date
RETURN
END
GO
GRANT EXECUTE ON  [dbo].[GetEmailErrorsByDay] TO [WebUsers]
GO
