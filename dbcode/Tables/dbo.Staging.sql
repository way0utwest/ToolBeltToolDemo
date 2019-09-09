CREATE TABLE [dbo].[Staging]
(
[StagingKey] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Staging] ADD CONSTRAINT [StagingPK] PRIMARY KEY CLUSTERED  ([StagingKey]) ON [PRIMARY]
GO
