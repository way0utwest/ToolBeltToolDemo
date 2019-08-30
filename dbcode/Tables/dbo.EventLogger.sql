CREATE TABLE [dbo].[EventLogger]
(
[LogId] [int] NOT NULL IDENTITY(1, 1),
[LogMsg] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LogDate] [datetime2] NULL CONSTRAINT [df_getdate] DEFAULT (sysdatetime()),
[LogUser] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__EventLogg__LogUs__22FF2F51] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventLogger] ADD CONSTRAINT [EventLoggerPK] PRIMARY KEY CLUSTERED  ([LogId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [EventLogger_IDX] ON [dbo].[EventLogger] ([LogDate], [LogUser]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [EventLogger_IDXUser] ON [dbo].[EventLogger] ([LogUser]) ON [PRIMARY]
GO
