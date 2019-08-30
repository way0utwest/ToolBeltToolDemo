CREATE TABLE [dbo].[Contacts]
(
[ContactsID] [int] NOT NULL IDENTITY(101, 1),
[ContactFullName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PhoneWork] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PhoneMobile] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address1] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address2] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address3] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CountryCode] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[JoiningDate] [datetime] NULL,
[ModifiedDate] [datetime] NOT NULL CONSTRAINT [dfSysUTCDate] DEFAULT (sysdatetime()),
[Email] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Photo] [image] NULL,
[ModifiedBy] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StatusID] [tinyint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Contacts] ADD CONSTRAINT [PK_Contacts] PRIMARY KEY CLUSTERED  ([ContactsID]) ON [PRIMARY]
GO
