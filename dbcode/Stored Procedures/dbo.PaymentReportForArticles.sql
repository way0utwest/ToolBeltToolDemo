SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PaymentReportForArticles]
    @startdate DATE
  , @enddate DATE
AS
SELECT ap.ContactID
     , co.ContactFullName
     , COUNT(ap.ArticleID) AS NumberOfArticles
     , CASE
           WHEN COUNT(ap.ArticleID) > 10 THEN
     (SUM(ap.ArticlePaymentRate) + (SUM(ap.ArticlePaymentRate) * .1))
           WHEN COUNT(ap.ArticleID) >= 5 THEN
     (SUM(ap.ArticlePaymentRate) + (SUM(ap.ArticlePaymentRate) * .05))
           ELSE
               SUM(ap.ArticlePaymentRate)
       END AS paymenttotal
FROM dbo.ArticlePayment ap
    INNER JOIN dbo.Contacts AS co
        ON ap.ContactID = co.ContactsID
WHERE ap.PublishDate >= @startdate
      AND ap.PublishDate < @enddate
GROUP BY ap.ContactID
       , co.ContactFullName;

GO
