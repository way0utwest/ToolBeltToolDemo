CREATE TABLE [dbo].[BlogArchive_ModDate]
(
[BlogArchiveID] [int] NOT NULL IDENTITY(1, 1),
[BlogID] [int] NULL,
[modifieddate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BlogArchive_ModDate] ADD CONSTRAINT [BlogArchiveModDate_PK] PRIMARY KEY CLUSTERED  ([BlogArchiveID]) ON [PRIMARY]
GO
