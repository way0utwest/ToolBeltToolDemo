SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[SummarizeAuthorPaymentByMonth]
  @month date
 AS
     BEGIN
	 DECLARE @begin DATE, @end DATE
	 SET @begin = DATEADD(Month, DATEDIFF(Month, 0, @month), 0)
	 SET @end = DATEADD(MONTH, 1, @begin)
         SELECT ap.ContactID ,
                @begin AS StartofMonth ,
                DATEADD(DAY, -1, @end) AS EndofMonth ,
                SUM(ap.ArticlePaymentRate) AS PaymentTotal
		  FROM dbo.ArticlePayment AS ap
		  WHERE ap.PaymentDate BETWEEN @begin AND @end
		  AND ap.AuthorPaid = 1
		  GROUP BY ap.ContactID
     END
GO
