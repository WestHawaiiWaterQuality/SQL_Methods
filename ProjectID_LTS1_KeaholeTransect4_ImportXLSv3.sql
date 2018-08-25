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
-- sp_rename ['Station 1$'], [NELHARawImportTransect4Station1]

-- sp_rename ['Station 2$'], [NELHARawImportTransect4Station2]

-- sp_rename ['Station 3$'], [NELHARawImportTransect4Station3]

-- sp_rename ['Station 4$'], [NELHARawImportTransect4Station4]

-- sp_rename ['Station 5$'], [NELHARawImportTransect4Station5]

SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect4Station1 GROUP BY [DATE] HAVING COUNT([DATE])>1
SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect4Station2 GROUP BY [DATE] HAVING COUNT([DATE])>1
SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect4Station3 GROUP BY [DATE] HAVING COUNT([DATE])>1
SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect4Station4 GROUP BY [DATE] HAVING COUNT([DATE])>1
SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect4Station5 GROUP BY [DATE] HAVING COUNT([DATE])>1
--0s
------------------------------
/*
DROP TABLE [NELHARawImportTransect4Station1]
DROP TABLE [NELHARawImportTransect4Station2]
DROP TABLE [NELHARawImportTransect4Station3]
DROP TABLE [NELHARawImportTransect4Station4]
DROP TABLE [NELHARawImportTransect4Station5]
*/

------------------------------
/*
https://stackoverflow.com/questions/14556737/how-to-find-duplicates-from-two-tables-and-also-to-find-duplicate-in-itself

*/
select * from NELHARawImportTransect4Station1 A where exists (select 1 From NELHARawImportTransect4Station2 B where A.[DATE] = B.[DATE] AND A.[TIME ] =B.[TIME ])
--2
/*
SITE ID	DATE	TIME 	GPS	F5	PO43-	F7	NO3- & NO2-	F9	NH4+ & NH3	F11	Si	F13	TDP	F15	TDN	F17	TP	F19	TOC	Turbidity	Salinity	Temp#	pH	DO	Chl a	Fecal Coliform	Enterococci	F29	F30
T4-1m	2007-12-14 00:00:00.000	904	19°43'35.12"N	156° 3'38.75"W	0.0903990991084066	2.8	0.0713944041066061	1	NULL	NULL	2.80571825319115	78.8	0.342225160910396	10.6	5.17609429772894	72.5	NULL	NULL	NULL	0.07	34.705	25.65	8.25	6.82	0.31	NULL	NULL	NULL	NULL
T4-1m	2008-03-11 00:00:00.000	914	19°43'35.12"N	156° 3'38.75"W	0.13559864866261	4.2	0.778199004762007	10.9	0.0571155232852849	0.8	12.4441437752577	349.5	0.242140444040375	7.5	6.57542461821842	92.1	NULL	NULL	NULL	0.09	34.853	24.77	8.07	6.65	0.65	NULL	NULL	NULL	NULL
*/
--  UPDATE NELHARawImportTransect4Station2 SET [TIME ] = [TIME ] + 1 WHERE  [DATE] = '2007-12-14 00:00:00.000'
--  UPDATE NELHARawImportTransect4Station2 SET [TIME ] = [TIME ] + 1 WHERE  [DATE] = '2008-03-11 00:00:00.000'
-- 
select * from NELHARawImportTransect4Station1 A where exists (select 1 From NELHARawImportTransect4Station3 B where A.[DATE] = B.[DATE] AND A.[TIME ] =B.[TIME ])
--0
select * from NELHARawImportTransect4Station1 A where exists (select 1 From NELHARawImportTransect4Station4 B where A.[DATE] = B.[DATE] AND A.[TIME ] =B.[TIME ])
--0
select * from NELHARawImportTransect4Station1 A where exists (select 1 From NELHARawImportTransect4Station5 B where A.[DATE] = B.[DATE] AND A.[TIME ] =B.[TIME ])
--0
select * from NELHARawImportTransect4Station2 A where exists (select 1 From NELHARawImportTransect4Station3 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect4Station2 A where exists (select 1 From NELHARawImportTransect4Station4 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect4Station2 A where exists (select 1 From NELHARawImportTransect4Station5 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect4Station3 A where exists (select 1 From NELHARawImportTransect4Station4 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect4Station3 A where exists (select 1 From NELHARawImportTransect4Station5 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect4Station4 A where exists (select 1 From NELHARawImportTransect4Station5 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect4Station5 A where exists (select 1 From NELHARawImportTransect4Station1 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect4Station5 A where exists (select 1 From NELHARawImportTransect4Station2 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect4Station5 A where exists (select 1 From NELHARawImportTransect4Station3 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect4Station5 A where exists (select 1 From NELHARawImportTransect4Station4 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0


-----------------------------------------------------
-- SELECT * FROM NELHARawImportTransect4Station1 order by [DATE],[TIME]
--  delete from NELHARaw
--/*
/* make sure to include this in execute selection for inserts */
DECLARE @TransectFile int=4
DECLARE @OldLength8  int=8,  @NewLength1   int=1
DECLARE @OldLength23 int=23, @NewLength10  int=10
DECLARE @OldLength38 int=38, @NewLength50  int=50
DECLARE @OldLength53 int=53, @NewLength100 int=100
DECLARE @OldLength69 int=69, @NewLength500 int=500
--
-- Station#1
--   DECLARE @TransectFile int=4, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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

FROM NELHARawImportTransect4Station1 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by EsriDateTime
-- 98
UPDATE NELHARaw SET EsriDateTime = '2000-01-12 09:46:00.0000000' WHERE EsriDateTime = '1900-01-12 09:46:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-05-16 09:18:00.0000000' WHERE EsriDateTime = '1900-05-16 09:18:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-25 09:43:00.0000000' WHERE EsriDateTime = '1900-07-25 09:43:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-31 09:37:00.0000000' WHERE EsriDateTime = '1900-10-31 09:37:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-03-06 09:28:00.0000000' WHERE EsriDateTime = '1901-03-06 09:28:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-07 09:59:00.0000000' WHERE EsriDateTime = '1902-10-07 09:59:00.0000000'

-----------------------------------------------------------------------------------------
-- Station#2
--  DECLARE @TransectFile int=4, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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

FROM NELHARawImportTransect4Station2 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by Esridatetime
-- 196/3234
UPDATE NELHARaw SET EsriDateTime = '2000-01-12 09:42:01.0000000' WHERE EsriDateTime = '1900-01-12 09:42:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-05-16 09:11:02.0000000' WHERE EsriDateTime = '1900-05-16 09:11:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-25 09:38:03.0000000' WHERE EsriDateTime = '1900-07-25 09:38:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-31 09:34:04.0000000' WHERE EsriDateTime = '1900-10-31 09:34:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-03-06 09:25:05.0000000' WHERE EsriDateTime = '1901-03-06 09:25:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-07 09:55:06.0000000' WHERE EsriDateTime = '1902-10-07 09:55:00.0000000'

-----------------------------------------------------------------------------------------
-- Station#3
--  DECLARE @TransectFile int=4, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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

FROM NELHARawImportTransect4Station3 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by EsriDateTime
-- 294/1764
--
UPDATE NELHARaw SET EsriDateTime = '2000-01-12 09:37:01.0000000' WHERE EsriDateTime = '1900-01-12 09:37:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-05-16 09:07:02.0000000' WHERE EsriDateTime = '1900-05-16 09:07:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-25 09:34:03.0000000' WHERE EsriDateTime = '1900-07-25 09:34:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-31 09:30:04.0000000' WHERE EsriDateTime = '1900-10-31 09:30:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-03-06 09:19:05.0000000' WHERE EsriDateTime = '1901-03-06 09:19:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-07 09:49:06.0000000' WHERE EsriDateTime = '1902-10-07 09:49:00.0000000'

-----------------------------------------------------------------------------------------
-- Station#4
--  DECLARE @TransectFile int=4, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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

FROM NELHARawImportTransect4Station4 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by Esridatetime
-- 392/1862
--
UPDATE NELHARaw SET EsriDateTime = '2000-01-12 09:32:01.0000000' WHERE EsriDateTime = '1900-01-12 09:32:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-05-16 09:03:02.0000000' WHERE EsriDateTime = '1900-05-16 09:03:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-25 09:29:03.0000000' WHERE EsriDateTime = '1900-07-25 09:29:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-31 09:23:04.0000000' WHERE EsriDateTime = '1900-10-31 09:23:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-03-06 09:15:05.0000000' WHERE EsriDateTime = '1901-03-06 09:15:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-07 09:45:06.0000000' WHERE EsriDateTime = '1902-10-07 09:45:00.0000000'

-----------------------------------------------------------------------------------------
-- Station#5
--  DECLARE @TransectFile int=4, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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

FROM NELHARawImportTransect4Station5 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by EsriDateTime
-- 490/1960

UPDATE NELHARaw SET EsriDateTime = '2000-01-12 09:25:01.0000000' WHERE EsriDateTime = '1900-01-12 09:25:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-05-16 08:57:02.0000000' WHERE EsriDateTime = '1900-05-16 08:57:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-25 09:25:03.0000000' WHERE EsriDateTime = '1900-07-25 09:25:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-31 09:17:04.0000000' WHERE EsriDateTime = '1900-10-31 09:17:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-03-06 09:09:05.0000000' WHERE EsriDateTime = '1901-03-06 09:09:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-07 09:40:06.0000000' WHERE EsriDateTime = '1902-10-07 09:40:00.0000000'


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- create our own identity attribute by this import file
--  DECLARE @TransectFile int=4, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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
-- 490/1960
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