/**************************************************************************

Redgate On the Cog Workshop - 2 hour

This script creates the production database. Run this as the first step

Copyright 2019 Redgate Software
***************************************************************************/
USE [master]
GO
CREATE DATABASE [SimpleTalk_5_Prod]
 CONTAINMENT = NONE
GO
GO
EXEC sys.sp_db_vardecimal_storage_format N'SimpleTalk_5_Prod', N'ON'
GO
USE [SimpleTalk_5_Prod]
GO
CREATE ROLE [WebUsers]
GO
CREATE SCHEMA [auditing]
GO
CREATE SCHEMA [RedGateLocal]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- create function - calculateEstimateOfReadingTime

create function [dbo].[calculateEstimateOfReadingTime] ( @value varchar(max) )
returns int
as
    begin
      declare
        @ret as int = 1
      , @i as int = 1;
      while @i <= len(@value)
        begin
          if substring(@value, @i, 1) = ' '
            begin
              set @ret = @ret + 1;
            end
          set @i = @i + 1;
        end
      return @ret / 250;

    end
;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Articles](
	[ArticlesID] [int] IDENTITY(1,1) NOT NULL,
	[AuthorID] [int] NULL,
	[Title] [char](142) NULL,
	[Description] [varchar](max) NULL,
	[Article] [varchar](max) NULL,
	[PublishDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[URL] [char](200) NULL,
	[Comments] [int] NOT NULL,
	[ReadingTimeEstimate] [time](7) NULL,
	[CreatedDate] [datetime2](3) NOT NULL,
	[ModifiedBy] [nvarchar](200) NULL,
 CONSTRAINT [PK_Article] PRIMARY KEY CLUSTERED 
(
	[ArticlesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CountryCodes](
	[CountryName] [nvarchar](255) NULL,
	[CountryCode] [nvarchar](4) NOT NULL,
	[ModifiedDate] [datetime2](3) NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[CountryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contacts](
	[ContactsID] [int] IDENTITY(101,1) NOT NULL,
	[ContactFullName] [nvarchar](100) NOT NULL,
	[PhoneWork] [nvarchar](25) NULL,
	[PhoneMobile] [nvarchar](25) NULL,
	[Address1] [nvarchar](128) NULL,
	[Address2] [nvarchar](128) NULL,
	[Address3] [nvarchar](128) NULL,
	[CountryCode] [nvarchar](4) NULL,
	[JoiningDate] [datetime] NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[Email] [nvarchar](256) NULL,
	[Photo] [image] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[StatusID] [tinyint] NULL,
 CONSTRAINT [PK_Contacts] PRIMARY KEY CLUSTERED 
(
	[ContactsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- create v_articles
create view [dbo].[v_Articles]
as
    select  top 250 a.[Title] ,
            a.[PublishDate] ,
            a.[Description] ,
            a.[URL] ,
            a.[Comments], 
			dbo.calculateEstimateOfReadingTime(a.Article) as readingTime,
            c.[ContactFullName] ,
			c.[Photo],
			cc.CountryCode,
			cc.CountryName
    from    Articles a
		        left join Contacts c on a.AuthorID = c.ContactsID
			left join dbo.CountryCodes cc on c.CountryCode = cc.Countrycode
;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vContacts]
AS
SELECT ContactsID
     , ContactFullName
     , PhoneWork
     , PhoneMobile
     , CountryCode
     , JoiningDate
     , ModifiedDate
     , Email
     , Photo
 FROM dbo.Contacts
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [auditing].[Contacts](
	[ContactsID] [int] NULL,
	[Firstname] [varchar](100) NULL,
	[Lastname] [varchar](100) NULL,
	[address1] [varchar](200) NULL,
	[address2] [varchar](200) NULL,
	[address3] [varchar](200) NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppLogger](
	[LogDate] [datetime2](7) NOT NULL,
	[LogCat] [varchar](100) NULL,
	[LogMsg] [varchar](max) NULL,
	[readflag] [bit] NULL,
	[Completed] [bit] NULL,
 CONSTRAINT [PK_AppLogger] PRIMARY KEY CLUSTERED 
(
	[LogDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArticlePayment](
	[ArticlePaymentKey] [int] IDENTITY(1,1) NOT NULL,
	[ArticleID] [int] NULL,
	[ContactID] [int] NULL,
	[PublishDate] [date] NULL,
	[PaymentDate] [date] NULL,
	[AuthorPaid] [bit] NULL,
	[ArticlePaymentRate] [numeric](10, 2) NULL,
 CONSTRAINT [ArticlePaymentPK] PRIMARY KEY CLUSTERED 
(
	[ArticlePaymentKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Blog_Archive](
	[BlogArchiveID] [int] IDENTITY(1,1) NOT NULL,
	[BlogID] [int] NULL,
	[BlogName] [varchar](200) NULL,
	[ModDate] [datetime2](7) NULL,
	[CrDate] [datetime2](7) NULL,
	[Tagline] [varchar](200) NULL,
	[BlogURL] [varchar](200) NULL,
 CONSTRAINT [Blog_Archive_PK] PRIMARY KEY CLUSTERED 
(
	[BlogArchiveID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogContent](
	[BlogContentKey] [int] IDENTITY(1,1) NOT NULL,
	[BlogID] [int] NULL,
	[BlogEntryTitle] [varchar](200) NULL,
	[BlogEntry] [varchar](max) NULL,
	[BlogContentStatus] [int] NULL,
 CONSTRAINT [BlogContentPK] PRIMARY KEY CLUSTERED 
(
	[BlogContentKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Blogs](
	[BlogID] [int] IDENTITY(1,1) NOT NULL,
	[BlogName] [varchar](200) NULL,
	[modifieddate] [datetime2](3) NOT NULL,
	[createdate] [datetime2](3) NOT NULL,
	[BlogTagline] [varchar](300) NULL,
	[BlogURL] [varchar](300) NULL,
 CONSTRAINT [PK_Blogs] PRIMARY KEY CLUSTERED 
(
	[BlogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer](
	[customerid] [int] NOT NULL,
	[CustomerName] [varchar](200) NULL,
	[CustomerLocation] [varchar](200) NULL,
	[orders] [money] NULL,
	[region] [varchar](20) NULL,
	[OrderDate] [date] NULL,
 CONSTRAINT [CustomerPK] PRIMARY KEY CLUSTERED 
(
	[customerid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailErrorLog](
	[emailid] [int] NULL,
	[EmailDate] [datetime2](7) NULL,
	[errormsg] [varchar](max) NULL,
	[reviewed] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailMessage_Archive](
	[EmailID] [int] NULL,
	[emailsent] [tinyint] NULL,
	[archivedate] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailMessages](
	[EmailID] [int] IDENTITY(1,1) NOT NULL,
	[EmailReceipients] [varchar](1000) NULL,
	[Subject] [varchar](300) NULL,
	[EmailMsg] [varchar](max) NULL,
	[emailsent] [tinyint] NOT NULL,
	[SentDate] [datetime2](7) NULL,
	[EmailCC] [varchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventLogger](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[LogMsg] [varchar](max) NULL,
	[LogDate] [datetime2](7) NULL,
	[LogUser] [varchar](200) NULL,
 CONSTRAINT [EventLoggerPK] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ratings](
	[RatingKey] [int] IDENTITY(1,1) NOT NULL,
	[ArticlesID] [int] NULL,
	[RatingDate] [datetime2](7) NULL,
	[Rating] [tinyint] NULL,
	[UserKey] [int] NULL,
 CONSTRAINT [RatingsPK] PRIMARY KEY CLUSTERED 
(
	[RatingKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RSSFeeds](
	[RSSFeedID] [int] IDENTITY(1,1) NOT NULL,
	[FeedName] [varchar](max) NULL,
	[Checked] [bit] NOT NULL,
	[FeedBurner] [bit] NOT NULL,
	[ModifiedDate] [datetime2](3) NULL,
 CONSTRAINT [PK__RSSFeeds__DF1690F2C1F77AC5] PRIMARY KEY CLUSTERED 
(
	[RSSFeedID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[Statusid] [int] NOT NULL,
	[Status] [varchar](50) NULL,
	[ModifiedDate] [datetime2](7) NULL,
	[Active] [bit] NULL,
 CONSTRAINT [pk_Status] PRIMARY KEY CLUSTERED 
(
	[Statusid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](200) NULL,
	[FullName] [varchar](500) NULL,
	[NTAuthAccount] [varchar](300) NULL,
	[modifieddate] [datetime] NULL,
	[modifiedby] [varchar](200) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [EventLogger_IDX] ON [dbo].[EventLogger]
(
	[LogDate] ASC,
	[LogUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [EventLogger_IDXUser] ON [dbo].[EventLogger]
(
	[LogUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Articles] ADD  CONSTRAINT [df_Zero]  DEFAULT ((0)) FOR [Comments]
GO
ALTER TABLE [dbo].[Articles] ADD  CONSTRAINT [DF__Articles__Modifi__3F3159AB]  DEFAULT (suser_name()) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[Blogs] ADD  CONSTRAINT [dfSysDateTime]  DEFAULT (sysdatetime()) FOR [modifieddate]
GO
ALTER TABLE [dbo].[Blogs] ADD  CONSTRAINT [df_SysUTCDate]  DEFAULT (sysdatetime()) FOR [createdate]
GO
ALTER TABLE [dbo].[Contacts] ADD  CONSTRAINT [dfSysUTCDate]  DEFAULT (sysdatetime()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[CountryCodes] ADD  CONSTRAINT [DF__CountryCo__Modif__1881A0DE]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[EventLogger] ADD  CONSTRAINT [df_getdate]  DEFAULT (sysdatetime()) FOR [LogDate]
GO
ALTER TABLE [dbo].[EventLogger] ADD  CONSTRAINT [DF__EventLogg__LogUs__22FF2F51]  DEFAULT (user_name()) FOR [LogUser]
GO
ALTER TABLE [dbo].[RSSFeeds] ADD  CONSTRAINT [DF__RSSFeeds__Checke__34E8D562]  DEFAULT ((0)) FOR [Checked]
GO
ALTER TABLE [dbo].[BlogContent]  WITH CHECK ADD  CONSTRAINT [BlogContent_Blogs_BlogID] FOREIGN KEY([BlogID])
REFERENCES [dbo].[Blogs] ([BlogID])
GO
ALTER TABLE [dbo].[BlogContent] CHECK CONSTRAINT [BlogContent_Blogs_BlogID]
GO
ALTER TABLE [dbo].[Ratings]  WITH CHECK ADD  CONSTRAINT [Ratings_Articles_ArticlesID] FOREIGN KEY([ArticlesID])
REFERENCES [dbo].[Articles] ([ArticlesID])
GO
ALTER TABLE [dbo].[Ratings] CHECK CONSTRAINT [Ratings_Articles_ArticlesID]
GO
ALTER TABLE [dbo].[Blogs]  WITH CHECK ADD  CONSTRAINT [CK_blogs_blank] CHECK  ((len([BlogName])>(0)))
GO
ALTER TABLE [dbo].[Blogs] CHECK CONSTRAINT [CK_blogs_blank]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddLog]
    @logMsg VARCHAR(2000),
    @Logdate DATETIME2 = NULL,
    @LogCat VARCHAR(200) = ''
AS
BEGIN
    IF @Logdate IS NULL
        SELECT @Logdate = SYSDATETIME();
    INSERT dbo.AppLogger
    (
        LogDate,
        LogCat,
        LogMsg,
        readflag
    )
    VALUES
    (   @Logdate, -- LogDate - datetime2(7)
        @LogCat,  -- LogCat - varchar(100)
        @logMsg,  -- LogMsg - varchar(max)
        NULL     -- readflag - bit
    );

END;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[ContactsEmailAll]
  @subject VARCHAR(400)
  , @msg VARCHAR(MAX)
AS

INSERT dbo.EmailMessages
        (
          EmailReceipients
        , Subject
        , EmailMsg
		, emailsent
		, SentDate
		, EmailCC
        )
  SELECT 
 Email
  , @subject
  , @msg
  , 0
  , NULL
  , null
   FROM dbo.Contacts
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetActiveContacts]
AS
BEGIN
    SELECT top 10
     c.ContactsID,
     c.ContactFullName,
     c.PhoneWork,
     c.PhoneMobile,
     c.CountryCode,
     c.Email,
     s.[StatusID]
     FROM dbo.Contacts AS c
	 INNER JOIN [status] s
	 ON c.StatusID = s.StatusID
	 WHERE s.[Status] = 'Active'   
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAppLoggerCountByType]
  @type VARCHAR(20)
AS
    SELECT *
	 FROM dbo.AppLogger
	 WHERE LogCat = @type
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[GetArticleCommentsForAuthor]
@authorID INT = null
AS
BEGIN
  IF @authorID IS NOT null
    SELECT ArticlesID
         , AuthorID
         , Title
         , Comments
         , ReadingTimeEstimate
         , CreatedDate
        FROM dbo.Articles
    	WHERE AuthorID = @authorID
	ELSE
     RAISERROR('You must pass in an authorID.', 10, 50000)    
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[GetAverageArticleComments]
@CalculateNullAsZero BIT = 1
AS
BEGIN
	-- 20170203 Added ISNULL to catch null comment counts.
    SELECT ArticleCount = COUNT(articlesid)    
       , AverageComments = AVG(ISNULL(comments, 0))
        FROM dbo.Articles
    	 GROUP BY AuthorID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[GetBlogs]
AS
SELECT top 10
  BlogID
, BlogName
, ModifiedDate
 FROM dbo.Blogs
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCountryCodes]
AS
BEGIN
		SELECT top 10
		  cc.CountryName
         ,cc.CountryCode
      
		 FROM dbo.CountryCodes AS cc
		 WHERE cc.ModifiedDate IS NOT NULL 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetEmailErrorsByDay]
  @date DATE = null
/*
Description:

Changes:
Date       Who         Notes
---------- ---         ---------------------------------------------------
2/14/2017  WAY0UTWESTVAIO\way0u    
*/
AS
BEGIN

 IF @date IS NULL
  SELECT @date = DATEADD(DAY, -1, GETDATE())

  SELECT Errcount = COUNT(*)
   FROM dbo.EmailErrorLog
   WHERE EmailDate = @date
RETURN
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[GetEvent]
AS
SELECT * FROM dbo.DPS2017
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[InsertCleanContact]
              @ContactFullName VARCHAR(100)
            , @PhoneWork	   VARCHAR(25)
            , @PhoneMobile	   VARCHAR(25)
            , @Address1		   VARCHAR(128)
            , @Address2		   VARCHAR(128)
            , @Address3		   VARCHAR(128)
            , @CountryCode	   VARCHAR(4)
            , @JoiningDate	   datetime
            , @ModifiedDate	   datetime
            , @Email		   VARCHAR(256)
            , @Photo		   image
AS
BEGIN
    INSERT dbo.Contacts
            (
              ContactFullName
            , PhoneWork
            , PhoneMobile
            , Address1
            , Address2
            , Address3
            , CountryCode
            , JoiningDate
            , ModifiedDate
            , Email
            , Photo
            )
        VALUES
            (
              @ContactFullName
            , @PhoneWork
            , @PhoneMobile
            , @Address1
            , @Address2
            , @Address3
            , @CountryCode
            , @JoiningDate
            , @ModifiedDate
            , @Email
            , @Photo
            )
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProcessArticlePayments]
    @ArticleID INT ,
	@ContactID INT, 
    @PaymentDate DATE
AS
UPDATE dbo.ArticlePayment
SET PaymentDate = @PaymentDate ,
    AuthorPaid = 1
WHERE ArticleID = @ArticleID
AND ContactID = @ContactID
      AND PaymentDate IS NULL;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- What if someone changes the error message?
CREATE procedure [dbo].[SetArticlesReadingEstimate]
	@articleid as int = null
/*
Comments:
05/22/2014 jsj - Refactored to specify parameter default and throw error if not supplied.
*/
as
DECLARE @t TIME
 , @a VARCHAR(max)


-- throw error if no parameter
if @articleid is null
  throw 50001, N'dude, pass in an articleID', 1; 

select
   @a = article
 FROM
    dbo.Articles A
 where
   ArticlesID = @articleid;

select
   @t = CONVERT(TIME, DATEADD(SECOND,
                               dbo.calculateEstimateOfReadingTime(@a),
                               0))

update
   dbo.Articles
 set
    ReadingTimeEstimate = @t
 where
    ArticlesID = @articleid;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SummarizeAuthorPaymentByMonth]
  @month date
 AS
     BEGIN
	 DECLARE @begin DATE, @end DATE
	 SET @begin = DATEADD(Month, DATEDIFF(Month, 0, @month), 0)
	 SET @end = DATEADD(MONTH, 1, @begin)
         SELECT ap.ContactID ,
                @begin AS StartofMonth ,
                DATEADD(DAY, -1, @end) AS EndofMonth ,
                SUM(ap.ArticlePaymentRate) AS PaymentTotal
		  FROM dbo.ArticlePayment AS ap
		  WHERE ap.PaymentDate BETWEEN @begin AND @end
		  AND ap.AuthorPaid = 1
		  GROUP BY ap.ContactID
     END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetArticles]
AS
    SELECT  ArticlesID
           ,AuthorID
           ,Title
           ,Description
           ,Article
           ,PublishDate
           ,ModifiedDate
           ,URL
           ,Comments
           ,ReadingTimeEstimate
    FROM    dbo.Articles
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[uspGetContacts]
AS
SELECT top 10
  *
 FROM dbo.Contacts AS c
GO
EXEC sys.sp_addextendedproperty @name=N'PKException', @value=1 , @level0type=N'SCHEMA',@level0name=N'auditing', @level1type=N'TABLE',@level1name=N'Contacts'
GO
EXEC sys.sp_addextendedproperty @name=N'PKException', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EmailErrorLog'
GO
EXEC sys.sp_addextendedproperty @name=N'PKException', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EmailMessage_Archive'
GO
EXEC sys.sp_addextendedproperty @name=N'PKException', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EmailMessages'
GO
