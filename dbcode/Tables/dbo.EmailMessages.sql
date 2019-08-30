CREATE TABLE [dbo].[EmailMessages]
(
[EmailID] [int] NOT NULL IDENTITY(1, 1),
[EmailReceipients] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Subject] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailMsg] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[emailsent] [tinyint] NOT NULL,
[SentDate] [datetime2] NULL,
[EmailCC] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
DECLARE @xp int
SELECT @xp=1
EXEC sp_addextendedproperty N'PKException', @xp, 'SCHEMA', N'dbo', 'TABLE', N'EmailMessages', NULL, NULL
GO
