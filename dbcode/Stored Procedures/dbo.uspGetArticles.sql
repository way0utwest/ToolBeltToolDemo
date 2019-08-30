SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[uspGetArticles]
AS
    SELECT  ArticlesID
           ,AuthorID
           ,Title
           ,Description
           ,Article
           ,PublishDate
           ,ModifiedDate
           ,URL
           ,Comments
           ,ReadingTimeEstimate
    FROM    dbo.Articles
GO
