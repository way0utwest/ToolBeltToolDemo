CREATE TABLE [dbo].[MyTable]
(
[myid] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MyTable] ADD CONSTRAINT [mytablepk] PRIMARY KEY CLUSTERED  ([myid]) ON [PRIMARY]
GO
