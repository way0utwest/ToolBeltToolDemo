CREATE TABLE [auditing].[Contacts]
(
[ContactsID] [int] NULL,
[Firstname] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Lastname] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address3] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
DECLARE @xp int
SELECT @xp=1
EXEC sp_addextendedproperty N'PKException', @xp, 'SCHEMA', N'auditing', 'TABLE', N'Contacts', NULL, NULL
GO
