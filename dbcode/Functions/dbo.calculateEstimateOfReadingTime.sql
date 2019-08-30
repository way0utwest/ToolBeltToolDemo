SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- create function - calculateEstimateOfReadingTime

create function [dbo].[calculateEstimateOfReadingTime] ( @value varchar(max) )
returns int
as
    begin
      declare
        @ret as int = 1
      , @i as int = 1;
      while @i <= len(@value)
        begin
          if substring(@value, @i, 1) = ' '
            begin
              set @ret = @ret + 1;
            end
          set @i = @i + 1;
        end
      return @ret / 250;

    end
;
GO
