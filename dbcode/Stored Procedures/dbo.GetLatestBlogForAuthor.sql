SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetLatestBlogForAuthor]
  @authorid INT
  AS
  BEGIN
	SELECT TOP 1 *
	 FROM dbo.Articles AS a INNER JOIN dbo.Contacts AS c ON c.ContactsID = a.AuthorID
	 WHERE a.AuthorID = @authorid
  END
GO
