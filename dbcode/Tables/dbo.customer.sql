CREATE TABLE [dbo].[customer]
(
[customerid] [int] NOT NULL,
[CustomerName] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CustomerLocation] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[orders] [money] NULL,
[region] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OrderDate] [date] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[customer] ADD CONSTRAINT [CustomerPK] PRIMARY KEY CLUSTERED  ([customerid]) ON [PRIMARY]
GO
