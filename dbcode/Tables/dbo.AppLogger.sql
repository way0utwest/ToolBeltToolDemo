CREATE TABLE [dbo].[AppLogger]
(
[LogDate] [datetime2] NOT NULL,
[LogCat] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LogMsg] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[readflag] [bit] NULL,
[Completed] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AppLogger] ADD CONSTRAINT [PK_AppLogger] PRIMARY KEY CLUSTERED  ([LogDate]) ON [PRIMARY]
GO
