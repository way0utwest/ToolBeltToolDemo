SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE   PROCEDURE [zPaymentTests].[test calculate payments for articles]
AS
BEGIN
-- Assemble
EXEC tsqlt.faketable @TableName = 'Contacts', @SchemaName = 'dbo';

INSERT dbo.Contacts
(ContactsID, ContactFullName, Address1, Address2,CountryCode, Email)
VALUES
(1, N'Louis Davidson', N'17 High Street', N'Darlington', N'USA', N'Louis.Davidson@example.com')
, (2, N'Adam Machanic', N'37 Green Lane', N'Portsmouth', N'USA', N'Adam.Machanic@example.com')
, (3, N'Francis Hanlon', N'33 George Street', N'Llandudno', N'USA', N'Francis.Hanlon@example.com')
;

EXEC tsqlt.FakeTable @TableName = N'ArticlePayment',        -- nvarchar(max)
                     @SchemaName = N'dbo'

INSERT dbo.ArticlePayment
(ArticleID, ContactID, PublishDate, PaymentDate, AuthorPaid, ArticlePaymentRate)
VALUES
  (1, 1, '2019-01-03', null, 0, 100)
, (2, 2, '2019-01-04', null, 0, 100)
, (3, 2, '2019-03-04', null, 0, 100)
, (4, 2, '2019-04-04', null, 0, 100)
, (5, 2, '2019-05-04', null, 0, 100)
, (6, 2, '2019-06-04', null, 0, 100)
, (7, 3, '2019-01-05', null, 0, 100)
, (8, 3, '2019-02-05', null, 0, 100)
, (9, 3, '2019-03-05', null, 0, 100)
, (10, 3, '2019-04-05', null, 0, 100)
, (11, 3, '2019-05-05', null, 0, 100)
, (12, 3, '2019-06-05', null, 0, 100)
, (13, 3, '2019-07-05', null, 0, 100)
, (14, 3, '2019-08-05', null, 0, 100)
, (15, 3, '2019-09-05', null, 0, 100)
, (16, 3, '2019-10-05', null, 0, 100)
, (17, 3, '2019-11-05', null, 0, 100)

CREATE TABLE #expected (
ContactID INT
, ContactFullName VARCHAR(200)
, NumberOfArticles INT
, PaymentTotal NUMERIC(6,2)
)

INSERT #expected
(ContactID, ContactFullName, NumberOfArticles, PaymentTotal)
VALUES
  (1, 'Louis Davidson', 1, 100.00)
, (2, 'Adam Machanic', 5, 525.00)
, (3, 'Francis Hanlon', 11, 1210.00)

SELECT ContactID,
       ContactFullName,
       NumberOfArticles,
       PaymentTotal
 INTO #actual
 FROM #expected
 WHERE 1 = 0

-- Act
INSERT #actual
  EXEC dbo.PaymentReportForArticles @startdate = '2019-01-01', -- date
                                  @enddate = '2020-01-01'    -- date

-- Assert
EXEC tsqlt.AssertEqualsTable @Expected = '#expected',
                        @Actual = '#actual',   -- sql_variant
                        @Message = N'Incorrect report calculation'    -- nvarchar(max)


	
END    
GO
