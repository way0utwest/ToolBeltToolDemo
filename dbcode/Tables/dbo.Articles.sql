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
[ModifiedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__Articles__Modifi__3F3159AB] DEFAULT (suser_name())
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
