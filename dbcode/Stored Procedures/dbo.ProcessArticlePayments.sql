SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ProcessArticlePayments]
    @ArticleID INT ,
	@ContactID INT, 
    @PaymentDate DATE
AS
UPDATE dbo.ArticlePayment
SET PaymentDate = @PaymentDate ,
    AuthorPaid = 1
WHERE ArticleID = @ArticleID
AND ContactID = @ContactID
      AND PaymentDate IS NULL;
GO
