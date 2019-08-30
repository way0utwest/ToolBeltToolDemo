CREATE TABLE [dbo].[Users]
(
[UserID] [int] NOT NULL IDENTITY(1, 1),
[Username] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FullName] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NTAuthAccount] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[modifieddate] [datetime] NULL,
[modifiedby] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Users] ADD CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED  ([UserID]) ON [PRIMARY]
GO
