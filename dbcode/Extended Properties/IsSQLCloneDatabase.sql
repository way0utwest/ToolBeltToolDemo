DECLARE @xp int
SELECT @xp=1
EXEC sp_addextendedproperty N'IsSQLCloneDatabase', @xp, NULL, NULL, NULL, NULL, NULL, NULL
GO
