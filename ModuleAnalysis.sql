USE [VcAnalysis]
GO

/****** Object:  StoredProcedure [dbo].[ModuleAnalysis]    Script Date: 2018/11/26 12:42:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Junli
-- Create date: 2018/11/8
-- Description:	ModuleCountAndAvgQueuedRunningTime
-- =============================================
CREATE PROCEDURE [dbo].[ModuleAnalysis] 
	-- Add the parameters for the stored procedure here
	@StartTime datetimeoffset = '2018-10-22 00:00:00 +00:00', 
    @EndTime datetimeoffset = '2018-10-28 23:59:59 +00:00'
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

SELECT *,	MS*MODULECNT AS TOTALMS ,CAST(ROUND(CAST(MS*MODULECNT AS DECIMAL)/3600000.0,3) AS NUMERIC(38,3)) AS TOTALHours 
FROM
 (
	SELECT *,	CAST(DateDiff( ms, '00:00:00', CAST(avgTotalRunningTime AS TIME)) AS BIGINT) as MS
	FROM
	   (
			SELECT
				Module,	COUNT(*) AS MODULECNT,
				CAST(DateAdd(ms, AVG(CAST(DateDiff( ms, '00:00:00', cast(TotalQueuedTime as time)) AS BIGINT)), '00:00:00' ) as Time ) AS avgTotalQueueTime,
				Cast(DateAdd(ms, AVG(CAST(DateDiff( ms, '00:00:00', cast(TotalRunningTime as time)) AS BIGINT)), '00:00:00' ) as Time ) AS avgTotalRunningTime
			FROM [VcAnalysis].[dbo].[EntityMatchingProd]
			WHERE	SubmitTime   >=  @StartTime              
					AND SubmitTime <= @EndTime  
					AND AetherOwner IN ('BN2BEAP000009DF$','BN2BEAP000009DE$','BN2BEAP000009E0$')
			GROUP BY Module 
		)  test
  ) AS test1
   order by test1.moduleCNT
 

  
END
GO


