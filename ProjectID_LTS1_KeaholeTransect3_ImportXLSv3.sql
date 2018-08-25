-- Import XLS file from NELHA 'OT-3rawdata.xlsx' to represent raw data for Transect#1
-- Files received Keith Olson CFO December 2017 to include last quarter 2017 values
--
USE [WHWQ4]
-
--------------------------------------------------
-- each file and sheet is handled separately since these files and sheets vary and I would rather
-- handle clean up here in SQL as opposed to explaining how to do in XLS
-----------------------------------------------
-- allow MSSQL to import the XLS to the default tablenames with pattern ['Station X$'], where X = 1-5

-- run separately, double check the new table exists (refresh Tables)
-- sp_rename ['Station 1$'], [NELHARawImportTransect3Station1]

-- sp_rename ['Station 2$'], [NELHARawImportTransect3Station2]

-- sp_rename ['Station 3$'], [NELHARawImportTransect3Station3]

-- sp_rename ['Station 4$'], [NELHARawImportTransect3Station4]

-- sp_rename ['Station 5$'], [NELHARawImportTransect3Station5]

SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect3Station1 GROUP BY [DATE] HAVING COUNT([DATE])>1
/*
2013-10-29 00:00:00.000	2
2014-11-17 00:00:00.000	2
2015-11-17 00:00:00.000	2
2016-12-20 00:00:00.000	2
2017-11-28 00:00:00.000	2
*/
/*
select * from NELHARawImportTransect3Station1 order by [DATE]
-- first one is Aug
UPDATE NELHARawImportTransect3Station1 SET [DATE]='2013-08-01 00:00:00.000' 
WHERE [DATE]='2013-10-29 00:00:00.000' AND [TIME ] = 952
-- first Aug5
UPDATE NELHARawImportTransect3Station1 SET [DATE]='2014-08-05 00:00:00.000' 
WHERE [DATE]='2014-11-17 00:00:00.000' AND [TIME ] = 1034
-- first Aug26
UPDATE NELHARawImportTransect3Station1 SET [DATE]='2015-08-26 00:00:00.000' 
WHERE [DATE]='2015-11-17 00:00:00.000' AND [TIME ] = 1024

UPDATE NELHARawImportTransect3Station1 SET [DATE]='2016-07-06 00:00:00.000' 
WHERE [DATE]='2016-12-20 00:00:00.000' AND [TIME ] = 1138

UPDATE NELHARawImportTransect3Station1 SET [DATE]='2017-09-27 00:00:00.000' 
WHERE [DATE]='2017-11-28 00:00:00.000' AND [TIME ] = 1203
*/
SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect3Station2 GROUP BY [DATE] HAVING COUNT([DATE])>1
SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect3Station3 GROUP BY [DATE] HAVING COUNT([DATE])>1
SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect3Station4 GROUP BY [DATE] HAVING COUNT([DATE])>1
SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect3Station5 GROUP BY [DATE] HAVING COUNT([DATE])>1
-- all zeros
------------------------------
/*
DROP TABLE [NELHARawImportTransect3Station1]
DROP TABLE [NELHARawImportTransect3Station2]
DROP TABLE [NELHARawImportTransect3Station3]
DROP TABLE [NELHARawImportTransect3Station4]
DROP TABLE [NELHARawImportTransect3Station5]
*/
------------------------------
/*
https://stackoverflow.com/questions/14556737/how-to-find-duplicates-from-two-tables-and-also-to-find-duplicate-in-itself

*/
select * from NELHARawImportTransect3Station1 A where exists (select 1 From NELHARawImportTransect3Station2 B where A.[DATE] = B.[DATE] AND A.[TIME ] =B.[TIME ])
--0
select * from NELHARawImportTransect3Station1 A where exists (select 1 From NELHARawImportTransect3Station3 B where A.[DATE] = B.[DATE] AND A.[TIME ] =B.[TIME ])
--0
select * from NELHARawImportTransect3Station1 A where exists (select 1 From NELHARawImportTransect3Station4 B where A.[DATE] = B.[DATE] AND A.[TIME ] =B.[TIME ])
--0
select * from NELHARawImportTransect3Station1 A where exists (select 1 From NELHARawImportTransect3Station5 B where A.[DATE] = B.[DATE] AND A.[TIME ] =B.[TIME ])
-- 0
select * from NELHARawImportTransect3Station2 A where exists (select 1 From NELHARawImportTransect3Station3 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect3Station2 A where exists (select 1 From NELHARawImportTransect3Station4 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect3Station2 A where exists (select 1 From NELHARawImportTransect3Station5 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect3Station3 A where exists (select 1 From NELHARawImportTransect3Station4 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect3Station3 A where exists (select 1 From NELHARawImportTransect3Station5 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect3Station4 A where exists (select 1 From NELHARawImportTransect3Station5 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect3Station5 A where exists (select 1 From NELHARawImportTransect3Station1 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect3Station5 A where exists (select 1 From NELHARawImportTransect3Station2 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect3Station5 A where exists (select 1 From NELHARawImportTransect3Station3 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect3Station5 A where exists (select 1 From NELHARawImportTransect3Station4 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0


-----------------------------------------------------
-- SELECT * FROM NELHARawImportTransect3Station1 order by [DATE],[TIME]
--  delete from NELHARaw
--/*
/* make sure to include this in execute selection for inserts */
DECLARE @TransectFile int=3
DECLARE @OldLength8  int=8,  @NewLength1   int=1
DECLARE @OldLength23 int=23, @NewLength10  int=10
DECLARE @OldLength38 int=38, @NewLength50  int=50
DECLARE @OldLength53 int=53, @NewLength100 int=100
DECLARE @OldLength69 int=69, @NewLength500 int=500
--
-- Station#1
--   DECLARE @TransectFile int=3, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
INSERT INTO NELHARaw
SELECT
CAST(CAST(s.[DATE] as date) as nvarchar) + ' ' +
     CAST(CONVERT(time, SUBSTRING(RIGHT('0' + LTRIM(cast(s.[TIME ] as nvarchar)),4),1,2) + ':' +
          SUBSTRING(RIGHT('0' + LTRIM(cast(s.[TIME ] as nvarchar)),4),3,2)) as nvarchar) as dt,
IIF(CAST(SUBSTRING(RIGHT('0' + LTRIM(cast(s.[TIME ] as nvarchar)),4),1,2) as int) >= 12, 'PM', 'AM'),
CAST(SUBSTRING(REPLACE([SITE ID],' ',''),2,1) as int),                        -- Transect
IIF (SUBSTRING(REPLACE([SITE ID],' ',''),1,1)='O', @OldLength8, @NewLength1),  -- mShore
IIF (SUBSTRING(REPLACE([SITE ID],' ',''),1,1)='O', 'Old', 'New'),              -- NewOrOld can be determined by distance as they are unique
RIGHT('0000' + LTRIM(str(s.[TIME ])), 4),
[GPS],            -- this is what is in row1 for column we need
[F5],                                                     
[SITE ID],        -- SiteId
[F7],             -- Phos6391
[F9],             -- NaNi6230
[F11],            -- AmmN6220
[F13],            -- Sili6360
[F15],            -- TDPh6386
[F17],            -- TDNi6210
--NULL,            -- TPho6240
[F19],            -- TPho6240 *removed since not in this sheet
--NULL,            -- TtOC6392
[TOC],            -- TtOC6392 *
[Turbidity],      -- Turb6260
[Salinity],       -- Sali6350
[Temp#],          -- Temp6280
[pH],             -- pHyd6390
[DO],             -- OxyD6270
[Chl a],          -- ChlA6250          
--NULL, -- Coli6420
[Fecal Coliform], -- Coli6420  *
--NULL,	  -- Ecci6410
[Enterococci],	  -- Ecci6410  *
--
NULL,             -- POINT_Y
NULL,             -- POINT_X
NULL,             -- MyLatLong
NULL,             -- MyLatitude
NULL,NULL,        -- Label fields
NULL,             -- CoreName
NULL,NULL,        -- StartDate/EndData
NULL,             -- MyAnalyteList
NULL,             -- MyTransectName
NULL,             -- MyDateRange
NULL,             -- MyQuarterCount
newid(),NULL,
-1,               -- RawIdentityI n/a
-2                -- RawIdentityA n/a

FROM NELHARawImportTransect3Station1 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by EsriDateTime
-- 98/1078


UPDATE NELHARaw SET EsriDateTime = '2000-01-04 09:44:01.0000000' WHERE EsriDateTime = '1900-01-04 09:44:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-05-16 10:08:02.0000000' WHERE EsriDateTime = '1900-05-16 10:08:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-24 09:56:03.0000000' WHERE EsriDateTime = '1900-07-24 09:56:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-30 10:02:04.0000000' WHERE EsriDateTime = '1900-10-30 10:02:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-02-26 10:03:05.0000000' WHERE EsriDateTime = '1901-02-26 10:03:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-07 11:04:06.0000000' WHERE EsriDateTime = '1902-10-07 11:04:00.0000000'


-----------------------------------------------------------------------------------------
-- Station#2
--  DECLARE @TransectFile int=3, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
INSERT INTO NELHARaw
SELECT 
CAST(CAST(s.[DATE] as date) as nvarchar) + ' ' +
     CAST(CONVERT(time, SUBSTRING(RIGHT('0' + LTRIM(cast(s.[TIME ] as nvarchar)),4),1,2) + ':' +
          SUBSTRING(RIGHT('0' + LTRIM(cast(s.[TIME ] as nvarchar)),4),3,2)) as nvarchar) as dt,
IIF(CAST(SUBSTRING(RIGHT('0' + LTRIM(cast(s.[TIME ] as nvarchar)),4),1,2) as int) >= 12, 'PM', 'AM'),
CAST(SUBSTRING(REPLACE([SITE ID],' ',''),2,1) as int),                         -- Transect
IIF (SUBSTRING(REPLACE([SITE ID],' ',''),1,1)='O', @OldLength23, @NewLength10),-- mShore
IIF (SUBSTRING(REPLACE([SITE ID],' ',''),1,1)='O', 'Old', 'New'),              -- NewOrOld can be determined by distance as they are unique
RIGHT('0000' + LTRIM(str(s.[TIME ])), 4),
[GPS],            -- this is what is in row1 for column we need
[F5],                                                    
[SITE ID],        -- SiteId
[F7],             -- Phos6391
[F9],             -- NaNi6230
[F11],            -- AmmN6220
[F13],            -- Sili6360
[F15],            -- TDPh6386
[F17],            -- TDNi6210
NULL,            -- TPho6240
--[F19],            -- TPho6240 *removed since not in this sheet
NULL,            -- TtOC6392
--[TOC],            -- TtOC6392 *
[Turbidity],      -- Turb6260
[Salinity],       -- Sali6350
[Temp#],          -- Temp6280
[pH],             -- pHyd6390
[DO],             -- OxyD6270
[Chl a],          -- ChlA6250          
NULL, -- Coli6420
--[Fecal Coliform], -- Coli6420  *
NULL,	  -- Ecci6410
--[Enterococci],	  -- Ecci6410  *
--
NULL,             -- POINT_Y
NULL,             -- POINT_X
NULL,             -- MyLatLong
NULL,             -- MyLatitude
NULL,NULL,        -- Label fields
NULL,             -- CoreName
NULL,NULL,        -- StartDate/EndData
NULL,             -- MyAnalyteList
NULL,             -- MyTransectName
NULL,             -- MyDateRange
NULL,             -- MyQuarterCount
newid(),NULL,
-1,               -- RawIdentityI n/a
-2                -- RawIdentityA n/a

FROM NELHARawImportTransect3Station2 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by Esridatetime
-- 196/1176

UPDATE NELHARaw SET EsriDateTime = '2000-01-04 09:39:01.0000000' WHERE EsriDateTime = '1900-01-04 09:39:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-05-16 10:05:02.0000000' WHERE EsriDateTime = '1900-05-16 10:05:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-24 09:47:03.0000000' WHERE EsriDateTime = '1900-07-24 09:47:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-30 09:58:04.0000000' WHERE EsriDateTime = '1900-10-30 09:58:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-02-26 09:58:05.0000000' WHERE EsriDateTime = '1901-02-26 09:58:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-07 10:59:06.0000000' WHERE EsriDateTime = '1902-10-07 10:59:00.0000000'

-----------------------------------------------------------------------------------------
-- Station#3
--  DECLARE @TransectFile int=3, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
INSERT INTO NELHARaw
SELECT 
CAST(CAST(s.[DATE] as date) as nvarchar) + ' ' +
     CAST(CONVERT(time, SUBSTRING(RIGHT('0' + LTRIM(cast(s.[TIME ] as nvarchar)),4),1,2) + ':' +
          SUBSTRING(RIGHT('0' + LTRIM(cast(s.[TIME ] as nvarchar)),4),3,2)) as nvarchar) as dt,
IIF(CAST(SUBSTRING(RIGHT('0' + LTRIM(cast(s.[TIME ] as nvarchar)),4),1,2) as int) >= 12, 'PM', 'AM'),
CAST(SUBSTRING(REPLACE([SITE ID],' ',''),2,1) as int),                         -- Transect
IIF (SUBSTRING(REPLACE([SITE ID],' ',''),1,1)='O', @OldLength38, @NewLength50),-- mShore
IIF (SUBSTRING(REPLACE([SITE ID],' ',''),1,1)='O', 'Old', 'New'),              -- NewOrOld can be determined by distance as they are unique
RIGHT('0000' + LTRIM(str(s.[TIME ])), 4),
[GPS],            -- this is what is in row1 for column we need
[F5],
[SITE ID],        -- SiteId
[F7],             -- Phos6391
[F9],             -- NaNi6230
[F11],            -- AmmN6220
[F13],            -- Sili6360
[F15],            -- TDPh6386
[F17],            -- TDNi6210
NULL,            -- TPho6240
--[F19],            -- TPho6240 *removed since not in this sheet
NULL,            -- TtOC6392
--[TOC],            -- TtOC6392 *
[Turbidity],      -- Turb6260
[Salinity],       -- Sali6350
[Temp#],          -- Temp6280
[pH],             -- pHyd6390
[DO],             -- OxyD6270
[Chl a],          -- ChlA6250          
NULL, -- Coli6420
--[Fecal Coliform], -- Coli6420  *
NULL,	  -- Ecci6410
--[Enterococci],	  -- Ecci6410  *
--
NULL,             -- POINT_Y
NULL,             -- POINT_X
NULL,             -- MyLatLong
NULL,             -- MyLatitude
NULL,NULL,        -- Label fields
NULL,             -- CoreName
NULL,NULL,        -- StartDate/EndData
NULL,             -- MyAnalyteList
NULL,             -- MyTransectName
NULL,             -- MyDateRange
NULL,             -- MyQuarterCount
newid(),NULL,
-1,               -- RawIdentityI n/a
-2                -- RawIdentityA n/a

FROM NELHARawImportTransect3Station3 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by EsriDateTime
-- 294/1274
--
UPDATE NELHARaw SET EsriDateTime = '2000-01-04 09:32:01.0000000' WHERE EsriDateTime = '1900-01-04 09:32:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-05-16 10:02:02.0000000' WHERE EsriDateTime = '1900-05-16 10:02:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-24 09:42:03.0000000' WHERE EsriDateTime = '1900-07-24 09:42:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-30 09:50:04.0000000' WHERE EsriDateTime = '1900-10-30 09:50:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-02-26 09:53:05.0000000' WHERE EsriDateTime = '1901-02-26 09:53:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-07 10:51:06.0000000' WHERE EsriDateTime = '1902-10-07 10:51:00.0000000'


-----------------------------------------------------------------------------------------
-- Station#4
--  DECLARE @TransectFile int=3, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
INSERT INTO NELHARaw
SELECT 
CAST(CAST(s.[DATE] as date) as nvarchar) + ' ' +
     CAST(CONVERT(time, SUBSTRING(RIGHT('0' + LTRIM(cast(s.[TIME ] as nvarchar)),4),1,2) + ':' +
          SUBSTRING(RIGHT('0' + LTRIM(cast(s.[TIME ] as nvarchar)),4),3,2)) as nvarchar) as dt,
IIF(CAST(SUBSTRING(RIGHT('0' + LTRIM(cast(s.[TIME ] as nvarchar)),4),1,2) as int) >= 12, 'PM', 'AM'),
CAST(SUBSTRING(REPLACE([SITE ID],' ',''),2,1) as int),                          -- Transect
IIF (SUBSTRING(REPLACE([SITE ID],' ',''),1,1)='O', @OldLength53, @NewLength100),-- mShore
IIF (SUBSTRING(REPLACE([SITE ID],' ',''),1,1)='O', 'Old', 'New'),               -- NewOrOld can be determined by distance as they are unique
RIGHT('0000' + LTRIM(str(s.[TIME ])), 4),
[GPS],            -- this is what is in row1 for column we need
[F5],
[SITE ID],        -- SiteId
[F7],             -- Phos6391
[F9],             -- NaNi6230
[F11],            -- AmmN6220
[F13],            -- Sili6360
[F15],            -- TDPh6386
[F17],            -- TDNi6210
NULL,            -- TPho6240
--[F19],            -- TPho6240 *removed since not in this sheet
NULL,            -- TtOC6392
--[TOC],            -- TtOC6392 *
[Turbidity],      -- Turb6260
[Salinity],       -- Sali6350
[Temp#],          -- Temp6280
[pH],             -- pHyd6390
[DO],             -- OxyD6270
[Chl a],          -- ChlA6250          
NULL, -- Coli6420
--[Fecal Coliform], -- Coli6420  *
NULL,	  -- Ecci6410
--[Enterococci],	  -- Ecci6410  *
--
NULL,             -- POINT_Y
NULL,             -- POINT_X
NULL,             -- MyLatLong
NULL,             -- MyLatitude
NULL,NULL,        -- Label fields
NULL,             -- CoreName
NULL,NULL,        -- StartDate/EndData
NULL,             -- MyAnalyteList
NULL,             -- MyTransectName
NULL,             -- MyDateRange
NULL,             -- MyQuarterCount
newid(),NULL,
-1,               -- RawIdentityI n/a
-2                -- RawIdentityA n/a

FROM NELHARawImportTransect3Station4 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by Esridatetime
-- 392/1372
--
UPDATE NELHARaw SET EsriDateTime = '2000-01-04 09:27:01.0000000' WHERE EsriDateTime = '1900-01-04 09:27:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-05-16 09:58:02.0000000' WHERE EsriDateTime = '1900-05-16 09:58:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-24 09:39:03.0000000' WHERE EsriDateTime = '1900-07-24 09:39:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-30 09:43:04.0000000' WHERE EsriDateTime = '1900-10-30 09:43:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-02-26 09:47:05.0000000' WHERE EsriDateTime = '1901-02-26 09:47:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-07 10:46:06.0000000' WHERE EsriDateTime = '1902-10-07 10:46:00.0000000'


-----------------------------------------------------------------------------------------
-- Station#5
--  DECLARE @TransectFile int=3, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
INSERT INTO NELHARaw
SELECT 
CAST(CAST(s.[DATE] as date) as nvarchar) + ' ' +
     CAST(CONVERT(time, SUBSTRING(RIGHT('0' + LTRIM(cast(s.[TIME ] as nvarchar)),4),1,2) + ':' +
          SUBSTRING(RIGHT('0' + LTRIM(cast(s.[TIME ] as nvarchar)),4),3,2)) as nvarchar) as dt,
IIF(CAST(SUBSTRING(RIGHT('0' + LTRIM(cast(s.[TIME ] as nvarchar)),4),1,2) as int) >= 12, 'PM', 'AM'),
CAST(SUBSTRING(REPLACE([SITE ID],' ',''),2,1) as int),                          -- Transect
IIF (SUBSTRING(REPLACE([SITE ID],' ',''),1,1)='O', @OldLength69, @NewLength500),-- mShore
IIF (SUBSTRING(REPLACE([SITE ID],' ',''),1,1)='O', 'Old', 'New'),               -- NewOrOld can be determined by distance as they are unique
RIGHT('0000' + LTRIM(str(s.[TIME ])), 4),
[GPS],            -- this is what is in row1 for column we need
[F5], 
[SITE ID],        -- SiteId
[F7],             -- Phos6391
[F9],             -- NaNi6230
[F11],            -- AmmN6220
[F13],            -- Sili6360
[F15],            -- TDPh6386
[F17],            -- TDNi6210
NULL,            -- TPho6240
--[F19],            -- TPho6240 *removed since not in this sheet
NULL,            -- TtOC6392
--[TOC],            -- TtOC6392 *
[Turbidity],      -- Turb6260
[Salinity],       -- Sali6350
[Temp#],          -- Temp6280
[pH],             -- pHyd6390
[DO],             -- OxyD6270
[Chl a],          -- ChlA6250          
NULL, -- Coli6420
--[Fecal Coliform], -- Coli6420  *
NULL,	  -- Ecci6410
--[Enterococci],	  -- Ecci6410  *
--
NULL,             -- POINT_Y
NULL,             -- POINT_X
NULL,             -- MyLatLong
NULL,             -- MyLatitude
NULL,NULL,        -- Label fields
NULL,             -- CoreName
NULL,NULL,        -- StartDate/EndData
NULL,             -- MyAnalyteList
NULL,             -- MyTransectName
NULL,             -- MyDateRange
NULL,             -- MyQuarterCount
newid(),NULL,
-1,               -- RawIdentityI n/a
-2                -- RawIdentityA n/a

FROM NELHARawImportTransect3Station5 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by EsriDateTime
-- 490/1470

UPDATE NELHARaw SET EsriDateTime = '2000-01-04 09:21:01.0000000' WHERE EsriDateTime = '1900-01-04 09:21:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-05-16 09:54:02.0000000' WHERE EsriDateTime = '1900-05-16 09:54:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-24 09:27:03.0000000' WHERE EsriDateTime = '1900-07-24 09:27:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-30 09:36:04.0000000' WHERE EsriDateTime = '1900-10-30 09:36:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-02-26 09:42:05.0000000' WHERE EsriDateTime = '1901-02-26 09:42:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-07 10:40:06.0000000' WHERE EsriDateTime = '1902-10-07 10:40:00.0000000'







-- select * FROM NELHARawImportTransect3Station5 order by [DATE]


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- create our own identity attribute by this import file
--  DECLARE @TransectFile int=3, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
Declare @myRow varchar(255), @MyRawUniq varchar(255)
Declare @cursorInsert CURSOR
set @cursorInsert = CURSOR FOR
Select ROW_NUMBER() OVER(ORDER BY Esridatetime),RawUniq from NELHARaw WHERE Transect = @TransectFile
OPEN @cursorInsert
FETCH NEXT FROM @cursorInsert into @myRow, @MyRawUniq
WHILE @@FETCH_STATUS = 0
BEGIN
UPDATE NELHARaw set RawIdentityI = @myRow where RawUniq = @MyRawUniq
FETCH NEXT FROM @cursorInsert INTO @myRow, @MyRawUniq
END
CLOSE @cursorInsert
DEALLOCATE @cursorInsert


-----
select COUNT(*) FROM NELHARaw
-- 490
-- select * FROM NELHARaw ORDER BY RawIdentityI
select distinct(Transect) FROM NELHARaw order by Transect
-------------------------
/*
select distinct(mShore)
FROM NELHARaw order by mShore
-- 10 distances from shore Old=(8,23,38,53,69), New=(1,10,50,100,500)
*/
/*
select distinct(pkStation)
FROM NELHARaw order by pkStation
-- 60
*/
/*
select distinct(SiteID)
FROM NELHARaw order by SiteId
-- 60
*/
/*
select distinct(Transect),mShore
FROM NELHARaw 
GROUP by Transect, mShore
order by Transect, mShore
-- 60
*/
/*
select count(*),Transect
from NELHARaw
GROUP by Transect
ORDER BY Transect
*/
/*
select count(*),Transect,mShore
from NELHARaw
GROUP by Transect,mShore
ORDER BY Transect,mShore
*/