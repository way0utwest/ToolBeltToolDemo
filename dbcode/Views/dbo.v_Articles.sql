SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
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
