SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
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
