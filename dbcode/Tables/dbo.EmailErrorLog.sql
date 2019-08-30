CREATE TABLE [dbo].[EmailErrorLog]
(
[emailid] [int] NULL,
[EmailDate] [datetime2] NULL,
[errormsg] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[reviewed] [bit] NULL
) ON [PRIMARY]
GO
DECLARE @xp int
SELECT @xp=1
EXEC sp_addextendedproperty N'PKException', @xp, 'SCHEMA', N'dbo', 'TABLE', N'EmailErrorLog', NULL, NULL
GO
