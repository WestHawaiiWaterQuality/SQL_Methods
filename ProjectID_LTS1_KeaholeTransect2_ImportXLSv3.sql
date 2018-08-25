-- Import XLS file from NELHA 'OT-2rawdata.xlsx' to represent raw data for Transect#1
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
--  sp_rename ['Station 1$'], [NELHARawImportTransect2Station1]

--  sp_rename ['Station 2$'], [NELHARawImportTransect2Station2]

--  sp_rename ['Station 3$'], [NELHARawImportTransect2Station3]

--  sp_rename ['Station 4$'], [NELHARawImportTransect2Station4]

--  sp_rename ['Station 5$'], [NELHARawImportTransect2Station5]

SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect2Station1 GROUP BY [DATE] HAVING COUNT([DATE])>1
SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect2Station2 GROUP BY [DATE] HAVING COUNT([DATE])>1
SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect2Station3 GROUP BY [DATE] HAVING COUNT([DATE])>1
SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect2Station4 GROUP BY [DATE] HAVING COUNT([DATE])>1
SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect2Station5 GROUP BY [DATE] HAVING COUNT([DATE])>1
-- all zero
------------------------------
/*
DROP TABLE [NELHARawImportTransect2Station1]
DROP TABLE [NELHARawImportTransect2Station2]
DROP TABLE [NELHARawImportTransect2Station3]
DROP TABLE [NELHARawImportTransect2Station4]
DROP TABLE [NELHARawImportTransect2Station5]
*/
------------------------------
/*
https://stackoverflow.com/questions/14556737/how-to-find-duplicates-from-two-tables-and-also-to-find-duplicate-in-itself

*/
select * from NELHARawImportTransect2Station1 A where exists (select 1 From NELHARawImportTransect2Station2 B where A.[DATE] = B.[DATE] AND A.[TIME ] =B.[TIME ])
--1
/*
SITE ID	DATE	TIME 	GPS	F5	PO43-	F7	NO3- & NO2-	F9	NH4+ & NH3	F11	Si	F13	TDP	F15	TDN	F17	TP	F19	TOC	Turbidity	Salinity	Temp#	pH	DO	Chl a	Fecal Coliform	Enterococci	F29	F30
O2-1S-8m	1902-10-09 00:00:00.000	958	NULL	NULL	0.09	2.7876384	0.47	6.583149	0.11	1.540737	3.68	103.35464	0.31	9.6018656	6.26428571428571	87.7419707142857	0.32	9.9116032	0.948	0.08	34.903	27.1	8.259	8.13	0.12	1	1	NULL	NULL
*/
--  UPDATE NELHARawImportTransect2Station2 SET [TIME ] = [TIME ] + 1 WHERE  [DATE] = '1902-10-09 00:00:00.000'

select * from NELHARawImportTransect2Station2 A where exists (select 1 From NELHARawImportTransect2Station3 B where A.[DATE] = B.[DATE] AND A.[TIME ] =B.[TIME ])
--1
select * from NELHARawImportTransect2Station1 A where exists (select 1 From NELHARawImportTransect2Station4 B where A.[DATE] = B.[DATE] AND A.[TIME ] =B.[TIME ])
--0
select * from NELHARawImportTransect2Station1 A where exists (select 1 From NELHARawImportTransect2Station5 B where A.[DATE] = B.[DATE] AND A.[TIME ] =B.[TIME ])
--0
select * from NELHARawImportTransect2Station2 A where exists (select 1 From NELHARawImportTransect2Station3 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect2Station2 A where exists (select 1 From NELHARawImportTransect2Station4 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect2Station2 A where exists (select 1 From NELHARawImportTransect2Station5 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect2Station3 A where exists (select 1 From NELHARawImportTransect2Station4 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect2Station3 A where exists (select 1 From NELHARawImportTransect2Station5 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect2Station4 A where exists (select 1 From NELHARawImportTransect2Station5 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect2Station5 A where exists (select 1 From NELHARawImportTransect2Station1 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect2Station5 A where exists (select 1 From NELHARawImportTransect2Station2 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect2Station5 A where exists (select 1 From NELHARawImportTransect2Station3 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect2Station5 A where exists (select 1 From NELHARawImportTransect2Station4 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0


-----------------------------------------------------
-- SELECT * FROM NELHARawImportTransect2Station1 order by [DATE],[TIME]
--  delete from NELHARaw
--/*
/* make sure to include this in execute selection for inserts */
DECLARE @TransectFile int=2
DECLARE @OldLength8  int=8,  @NewLength1   int=1
DECLARE @OldLength23 int=23, @NewLength10  int=10
DECLARE @OldLength38 int=38, @NewLength50  int=50
DECLARE @OldLength53 int=53, @NewLength100 int=100
DECLARE @OldLength69 int=69, @NewLength500 int=500
--
-- Station#1
--   DECLARE @TransectFile int=2, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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

FROM NELHARawImportTransect2Station1 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by EsriDateTime
-- 98 (588 accumulative)

UPDATE NELHARaw SET EsriDateTime = '2000-01-04 11:14:01.0000000' WHERE EsriDateTime = '1900-01-04 11:14:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-04-17 11:02:02.0000000' WHERE EsriDateTime = '1900-04-17 11:02:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-24 11:19:03.0000000' WHERE EsriDateTime = '1900-07-24 11:19:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-30 11:38:04.0000000' WHERE EsriDateTime = '1900-10-30 11:38:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-02-26 11:27:05.0000000' WHERE EsriDateTime = '1901-02-26 11:27:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-09 09:58:06.0000000' WHERE EsriDateTime = '1902-10-09 09:58:00.0000000'


-----------------------------------------------------------------------------------------
-- Station#2
--  DECLARE @TransectFile int=2, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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

FROM NELHARawImportTransect2Station2 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by Esridatetime
-- 196/686

UPDATE NELHARaw SET EsriDateTime = '2000-01-04 11:08:01.0000000' WHERE EsriDateTime = '1900-01-04 11:08:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-04-17 10:56:02.0000000' WHERE EsriDateTime = '1900-04-17 10:56:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-24 11:15:03.0000000' WHERE EsriDateTime = '1900-07-24 11:15:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-30 11:33:04.0000000' WHERE EsriDateTime = '1900-10-30 11:33:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-02-26 11:21:05.0000000' WHERE EsriDateTime = '1901-02-26 11:21:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-09 09:58:10.0000000' WHERE EsriDateTime = '1902-10-09 09:59:00.0000000'


-----------------------------------------------------------------------------------------
select * FROM NELHARawImportTransect2Station3
--  UPDATE NELHARawImportTransect2Station3 SET [TIME ] = [TIME ] + 1 WHERE  [DATE] = '2013-08-01 00:00:00.000'

-- Station#3
--  DECLARE @TransectFile int=2, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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

FROM NELHARawImportTransect2Station3 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by EsriDateTime
-- 294/784
--
UPDATE NELHARaw SET EsriDateTime = '1900-01-04 11:03:01.0000000' WHERE EsriDateTime = '1900-01-04 11:03:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '1900-04-17 10:52:02.0000000' WHERE EsriDateTime = '1900-04-17 10:52:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '1900-07-24 11:10:03.0000000' WHERE EsriDateTime = '1900-07-24 11:10:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '1900-10-30 11:27:04.0000000' WHERE EsriDateTime = '1900-10-30 11:27:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '1901-02-26 11:16:05.0000000' WHERE EsriDateTime = '1901-02-26 11:16:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '1902-10-09 09:52:06.0000000' WHERE EsriDateTime = '1902-10-09 09:52:00.0000000'

-----------------------------------------------------------------------------------------
-- Station#4
--  DECLARE @TransectFile int=2, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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

FROM NELHARawImportTransect2Station4 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by Esridatetime
-- 392/882
--
UPDATE NELHARaw SET EsriDateTime = '2000-01-04 10:59:01.0000000' WHERE EsriDateTime = '1900-01-04 10:59:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-01-04 11:03:02.0000000' WHERE EsriDateTime = '1900-01-04 11:03:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-04-17 10:47:03.0000000' WHERE EsriDateTime = '1900-04-17 10:47:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-04-17 10:52:04.0000000' WHERE EsriDateTime = '1900-04-17 10:52:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-24 11:06:05.0000000' WHERE EsriDateTime = '1900-07-24 11:06:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-24 11:10:06.0000000' WHERE EsriDateTime = '1900-07-24 11:10:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-30 11:21:07.0000000' WHERE EsriDateTime = '1900-10-30 11:21:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-30 11:27:08.0000000' WHERE EsriDateTime = '1900-10-30 11:27:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-02-26 11:11:09.0000000' WHERE EsriDateTime = '1901-02-26 11:11:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-02-26 11:16:11.0000000' WHERE EsriDateTime = '1901-02-26 11:16:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-09 09:46:12.0000000' WHERE EsriDateTime = '1902-10-09 09:46:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-09 09:52:13.0000000' WHERE EsriDateTime = '1902-10-09 09:52:00.0000000'

-----------------------------------------------------------------------------------------
-- Station#5
--  DECLARE @TransectFile int=2, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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

FROM NELHARawImportTransect2Station5 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by EsriDateTime
-- 490/980

UPDATE NELHARaw SET EsriDateTime = '2000-01-04 10:52:01.0000000' WHERE EsriDateTime = '1900-01-04 10:52:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-04-17 10:42:02.0000000' WHERE EsriDateTime = '1900-04-17 10:42:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-24 11:00:03.0000000' WHERE EsriDateTime = '1900-07-24 11:00:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-30 11:10:04.0000000' WHERE EsriDateTime = '1900-10-30 11:10:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-02-26 11:06:05.0000000' WHERE EsriDateTime = '1901-02-26 11:06:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-09 09:42:06.0000000' WHERE EsriDateTime = '1902-10-09 09:42:00.0000000'


-- select * FROM NELHARawImportTransect2Station5 order by [DATE]


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- create our own identity attribute by this import file
--  DECLARE @TransectFile int=2, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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
-- 490/980
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