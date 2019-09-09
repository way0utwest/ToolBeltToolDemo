CREATE TABLE [dbo].[Articles]
(
[ArticlesID] [int] NOT NULL IDENTITY(1, 1),
[AuthorID] [int] NULL,
[Title] [char] (142) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Article] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PublishDate] [datetime] NULL,
[ModifiedDate] [datetime] NULL,
[URL] [char] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Comments] [int] NOT NULL CONSTRAINT [df_Zero] DEFAULT ((0)),
[ReadingTimeEstimate] [time] NULL,
[CreatedDate] [datetime2] (3) NOT NULL,
[ModifiedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__Articles__Modifi__3F3159AB] DEFAULT (suser_name()),
[Rating] [numeric] (10, 4) NULL
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[Articles_triu] ON [dbo].[Articles] FOR INSERT, UPDATE
AS
BEGIN
    UPDATE dbo.Articles
	 SET ModifiedDate = GETDATE()
	 , ModifiedBy = SUSER_SNAME()
	 FROM inserted i
	 WHERE i.ArticlesID = Articles.ArticlesID
END
GO
ALTER TABLE [dbo].[Articles] ADD CONSTRAINT [PK_Article] PRIMARY KEY CLUSTERED  ([ArticlesID]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Article text for all content', 'SCHEMA', N'dbo', 'TABLE', N'Articles', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'FK to Contact.ContactsID', 'SCHEMA', N'dbo', 'TABLE', N'Articles', 'COLUMN', N'AuthorID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Abstract', 'SCHEMA', N'dbo', 'TABLE', N'Articles', 'COLUMN', N'Description'
GO
EXEC sp_addextendedproperty N'MS_Description', N'DO NOT REPORT', 'SCHEMA', N'dbo', 'TABLE', N'Articles', 'COLUMN', N'ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Latest Publish date', 'SCHEMA', N'dbo', 'TABLE', N'Articles', 'COLUMN', N'PublishDate'
GO
