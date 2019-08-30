CREATE TABLE [dbo].[DMSSTAT_RSTATS]
(
[runid] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ruleid] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ruleblock] [int] NOT NULL,
[rulenum] [int] NOT NULL,
[rulesubscript] [int] NOT NULL,
[ruletype] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[rulecreated] [datetime] NOT NULL,
[ruleupdated] [datetime] NOT NULL,
[secondsactive] [int] NOT NULL,
[rulestatus] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[rulesource] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ruletarget] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[rowoperations] [int] NULL,
[coloperations] [int] NULL,
[rulePrevRPN] [int] NULL,
[ruleRPN] [int] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_DMSSTAT_RSTATS] ON [dbo].[DMSSTAT_RSTATS] ([runid], [ruleid]) ON [PRIMARY]
GO
DECLARE @xp int
SELECT @xp=1
EXEC sp_addextendedproperty N'PKException', @xp, 'SCHEMA', N'dbo', 'TABLE', N'DMSSTAT_RSTATS', NULL, NULL
GO
