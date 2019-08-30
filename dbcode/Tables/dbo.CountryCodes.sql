CREATE TABLE [dbo].[CountryCodes]
(
[CountryName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CountryCode] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ModifiedDate] [datetime2] (3) NULL CONSTRAINT [DF__CountryCo__Modif__1881A0DE] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CountryCodes] ADD CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED  ([CountryCode]) ON [PRIMARY]
GO
