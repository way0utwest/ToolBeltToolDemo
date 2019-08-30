SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[GetAverageArticleComments]
@CalculateNullAsZero BIT = 1
AS
BEGIN
	-- 20170203 Added ISNULL to catch null comment counts.
    SELECT ArticleCount = COUNT(articlesid)    
       , AverageComments = AVG(ISNULL(comments, 0))
        FROM dbo.Articles
    	 GROUP BY AuthorID
END
GO
