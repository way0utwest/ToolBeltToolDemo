SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
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
