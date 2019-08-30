CREATE TABLE [dbo].[Ratings]
(
[RatingKey] [int] NOT NULL IDENTITY(1, 1),
[ArticlesID] [int] NULL,
[RatingDate] [datetime2] NULL,
[Rating] [tinyint] NULL,
[UserKey] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Ratings] ADD CONSTRAINT [RatingsPK] PRIMARY KEY CLUSTERED  ([RatingKey]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Ratings] ADD CONSTRAINT [Ratings_Articles_ArticlesID] FOREIGN KEY ([ArticlesID]) REFERENCES [dbo].[Articles] ([ArticlesID])
GO
