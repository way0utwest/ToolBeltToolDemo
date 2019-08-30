SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
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
