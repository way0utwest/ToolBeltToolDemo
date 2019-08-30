CREATE TABLE [dbo].[Blog_Archive]
(
[BlogArchiveID] [int] NOT NULL IDENTITY(1, 1),
[BlogID] [int] NULL,
[BlogName] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ModDate] [datetime2] NULL,
[CrDate] [datetime2] NULL,
[Tagline] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BlogURL] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Blog_Archive] ADD CONSTRAINT [Blog_Archive_PK] PRIMARY KEY CLUSTERED  ([BlogArchiveID]) ON [PRIMARY]
GO
