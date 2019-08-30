SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
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
