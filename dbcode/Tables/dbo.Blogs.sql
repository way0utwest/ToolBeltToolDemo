CREATE TABLE [dbo].[Blogs]
(
[BlogID] [int] NOT NULL IDENTITY(1, 1),
[BlogName] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[modifieddate] [datetime2] (3) NOT NULL CONSTRAINT [dfSysDateTime] DEFAULT (sysdatetime()),
[createdate] [datetime2] (3) NOT NULL CONSTRAINT [df_SysUTCDate] DEFAULT (sysdatetime()),
[BlogTagline] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BlogURL] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Blogs] ADD CONSTRAINT [CK_blogs_blank] CHECK ((len([BlogName])>(0)))
GO
ALTER TABLE [dbo].[Blogs] ADD CONSTRAINT [PK_Blogs] PRIMARY KEY CLUSTERED  ([BlogID]) ON [PRIMARY]
GO
