USE [VcAnalysis]
GO

/****** Object:  StoredProcedure [dbo].[JobAvgTime]    Script Date: 2018/11/26 12:43:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		junli
-- Create date: 2018/11/26
-- Description:	get avg time hh:mm:ss
-- =============================================
CREATE PROCEDURE [dbo].[JobAvgTime] 
	-- Add the parameters for the stored procedure here
	@StartTime datetimeoffset = '2018-10-22 00:00:00 +00:00', 
    @EndTime datetimeoffset = '2018-10-28 23:59:59 +00:00'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
SELECT Cast(DateAdd(ms, AVG(CAST(DateDiff( ms, '00:00:00', cast(TotalQueuedTime as time)) AS BIGINT)), '00:00:00' ) as Time ) 
from [VcAnalysis].[dbo].[EntityMatchingProd]
  where SubmitTime>=@StartTime
 AND  SubmitTime<=@EndTime
END
GO


