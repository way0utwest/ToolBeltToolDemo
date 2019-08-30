SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[SearchArticles]
(
    @AuthorName VARCHAR(200) = NULL,
    @ArticleTitle VARCHAR(142) = NULL,
    @ArticleDesc VARCHAR(1000) = NULL,
    @ReadingTimeMax INT = NULL
)
AS
DECLARE @sSQL NVARCHAR(2000),
        @Where NVARCHAR(1000) = N'';
SET @sSQL
    = N'SELECT ProductID, ReferenceOrderID, TransactionType, Quantity, TransactionDate, ActualCost
from dbo.Articles as a inner join dbo.Contacts as c on a.authorid = c.contactsid ';

IF @AuthorName IS NOT NULL
    SET @Where = @Where + N'AND c.ContactFullName like @_Author ';
IF @ArticleTitle IS NOT NULL
    SET @Where = @Where + N'AND a.title = @_ArticleTitle ';
IF @ArticleDesc IS NOT NULL
    SET @Where = @Where + N'AND TransactionType = @_TransactionType ';
IF @ReadingTimeMax IS NOT NULL
    SET @Where = @Where + N'AND ReadingTimeEstimate <= @_ReadingTimeMax ';

IF LEN(@Where) > 0
    SET @sSQL = @sSQL + N'WHERE ' + RIGHT(@Where, LEN(@Where) - 3);

EXEC sp_executesql @sSQL,
                   N'@_Product int, @_OrderID int, @_TransactionType char(1), @_Qty int',
                   @_Author = @AuthorName,
                   @_ArticleTitle = @ArticleTitle,
                   @_ArticleDesc = @ArticleDesc,
                   @_ReadingTimeMax = @ReadingTimeMax;

GO
