USE [VcAnalysis]
GO

/****** Object:  StoredProcedure [dbo].[JobReportAnalysis]    Script Date: 2018/11/26 12:41:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Junli
-- Create date: 2018/11/8
-- Description:	JobReportAnalysis GroupBy Owner generate count, Sum ,percent,avgTotalQueuedTime
-- =============================================
CREATE PROCEDURE [dbo].[JobReportAnalysis] 
	-- Add the parameters for the stored procedure here
	@StartTime datetimeoffset = '2018-10-22 00:00:00 +00:00', 
    @EndTime datetimeoffset = '2018-10-28 00:00:00 +00:00'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
SELECT	AetherOwner,COUNT(*) as CNT,
		Cast(DateAdd(ms, AVG(CAST(DateDiff( ms, '00:00:00', cast(TotalQueuedTime as time)) AS BIGINT)), '00:00:00' ) as Time ) AS avgTotalQueuedTime
FROM [VcAnalysis].[dbo].[EntityMatchingProd]
WHERE SubmitTime   >=  @StartTime             
	  AND SubmitTime <= @EndTime 
GROUP BY AetherOwner;

END
GO


