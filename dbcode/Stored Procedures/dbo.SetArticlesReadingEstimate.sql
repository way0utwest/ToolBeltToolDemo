SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- What if someone changes the error message?
CREATE procedure [dbo].[SetArticlesReadingEstimate]
	@articleid as int = null
/*
Comments:
05/22/2014 jsj - Refactored to specify parameter default and throw error if not supplied.
*/
as
DECLARE @t TIME
 , @a VARCHAR(max)


-- throw error if no parameter
if @articleid is null
  throw 50001, N'dude, pass in an articleID', 1; 

select
   @a = article
 FROM
    dbo.Articles A
 where
   ArticlesID = @articleid;

select
   @t = CONVERT(TIME, DATEADD(SECOND,
                               dbo.calculateEstimateOfReadingTime(@a),
                               0))

update
   dbo.Articles
 set
    ReadingTimeEstimate = @t
 where
    ArticlesID = @articleid;
GO
