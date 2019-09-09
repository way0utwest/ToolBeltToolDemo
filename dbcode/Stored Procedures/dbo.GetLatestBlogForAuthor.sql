SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[GetLatestBlogForAuthor]
    @authorid INT,
    @top TINYINT
AS
BEGIN
    SELECT TOP (@top)
           a.ArticlesID,
           a.AuthorID,
           c.ContactFullName,
           c.CountryCode,
           c.Email
    FROM dbo.Articles       AS a
    INNER JOIN dbo.Contacts AS c
        ON c.ContactsID = a.AuthorID
    WHERE a.AuthorID = @authorid
    ORDER BY a.PublishDate DESC;

END;
GO
