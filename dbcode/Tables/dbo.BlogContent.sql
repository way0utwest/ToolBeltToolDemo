CREATE TABLE [dbo].[BlogContent]
(
[BlogContentKey] [int] NOT NULL IDENTITY(1, 1),
[BlogID] [int] NULL,
[BlogEntryTitle] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BlogEntry] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BlogContentStatus] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BlogContent] ADD CONSTRAINT [BlogContentPK] PRIMARY KEY CLUSTERED  ([BlogContentKey]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BlogContent] ADD CONSTRAINT [BlogContent_Blogs_BlogID] FOREIGN KEY ([BlogID]) REFERENCES [dbo].[Blogs] ([BlogID])
GO
