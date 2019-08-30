SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
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
