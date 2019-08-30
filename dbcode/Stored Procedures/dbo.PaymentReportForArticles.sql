SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE   PROCEDURE [dbo].[PaymentReportForArticles]
   @startdate DATE
   , @enddate date
AS
SELECT ContactID,
       COUNT(ArticleID) AS NumberOfArticles,
       CASE
           WHEN COUNT(ArticleID) > 10 THEN
       (SUM(ArticlePaymentRate) + (SUM(ArticlePaymentRate) * .1))
           WHEN COUNT(ArticleID) > 5 THEN
       (SUM(ArticlePaymentRate) + (SUM(ArticlePaymentRate) * .05))
           ELSE
               SUM(ArticlePaymentRate)
       END AS paymenttotal
FROM dbo.ArticlePayment
WHERE PublishDate >= @startdate
      AND PublishDate < @enddate
GROUP BY ContactID;

GO
