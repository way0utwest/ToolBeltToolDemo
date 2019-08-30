CREATE TABLE [dbo].[ArticlePayment]
(
[ArticlePaymentKey] [int] NOT NULL IDENTITY(1, 1),
[ArticleID] [int] NULL,
[ContactID] [int] NULL,
[PublishDate] [date] NULL,
[PaymentDate] [date] NULL,
[AuthorPaid] [bit] NULL,
[ArticlePaymentRate] [numeric] (10, 2) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ArticlePayment] ADD CONSTRAINT [ArticlePaymentPK] PRIMARY KEY CLUSTERED  ([ArticlePaymentKey]) ON [PRIMARY]
GO
GRANT DELETE ON  [dbo].[ArticlePayment] TO [WebUsers]
GO
GRANT INSERT ON  [dbo].[ArticlePayment] TO [WebUsers]
GO
GRANT SELECT ON  [dbo].[ArticlePayment] TO [WebUsers]
GO
GRANT UPDATE ON  [dbo].[ArticlePayment] TO [WebUsers]
GO
