SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[GetArticleCommentsForAuthor]
@authorID INT = null
AS
BEGIN
  IF @authorID IS NOT null
    SELECT ArticlesID
         , AuthorID
         , Title
         , Comments
         , ReadingTimeEstimate
         , CreatedDate
        FROM dbo.Articles
    	WHERE AuthorID = @authorID
	ELSE
     RAISERROR('You must pass in an authorID.', 10, 50000)    
END
GO
