CREATE TABLE [dbo].[Status]
(
[Statusid] [int] NOT NULL,
[Status] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ModifiedDate] [datetime2] NULL,
[Active] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Status] ADD CONSTRAINT [pk_Status] PRIMARY KEY CLUSTERED  ([Statusid]) ON [PRIMARY]
GO
