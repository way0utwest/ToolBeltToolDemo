CREATE TABLE [dbo].[EmailMessage_Archive]
(
[EmailID] [int] NULL,
[emailsent] [tinyint] NULL,
[archivedate] [datetime] NULL
) ON [PRIMARY]
GO
DECLARE @xp int
SELECT @xp=1
EXEC sp_addextendedproperty N'PKException', @xp, 'SCHEMA', N'dbo', 'TABLE', N'EmailMessage_Archive', NULL, NULL
GO
