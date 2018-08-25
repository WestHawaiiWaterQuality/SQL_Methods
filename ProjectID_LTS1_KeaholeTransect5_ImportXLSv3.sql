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
-- sp_rename ['Station 1$'], [NELHARawImportTransect5Station1]

-- sp_rename ['Station 2$'], [NELHARawImportTransect5Station2]

-- sp_rename ['Station 3$'], [NELHARawImportTransect5Station3]

-- sp_rename ['Station 4$'], [NELHARawImportTransect5Station4]

-- sp_rename ['Station 5$'], [NELHARawImportTransect5Station5]

SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect5Station1 GROUP BY [DATE] HAVING COUNT([DATE])>1
SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect5Station2 GROUP BY [DATE] HAVING COUNT([DATE])>1
SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect5Station3 GROUP BY [DATE] HAVING COUNT([DATE])>1
/*
2009-02-10 00:00:00.000	2
2010-02-24 00:00:00.000	2
*/
SELECT * FROM NELHARawImportTransect5Station3 WHERE [DATE] = '2009-02-10 00:00:00.000'
-- UPDATE NELHARawImportTransect5Station3 SET [DATE] = '2009-06-30 00:00:00.000' WHERE [DATE] = '2009-02-10 00:00:00.000' AND [TIME ] = 1013
SELECT * FROM NELHARawImportTransect5Station3 WHERE [DATE] = '2010-02-24 00:00:00.000'
-- UPDATE NELHARawImportTransect5Station3 SET [DATE] = '2010-05-25 00:00:00.000' WHERE [DATE] = '2010-02-24 00:00:00.000' AND [TIME ] = 933

SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect5Station4 GROUP BY [DATE] HAVING COUNT([DATE])>1
SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect5Station5 GROUP BY [DATE] HAVING COUNT([DATE])>1
------------------------------
/*
DROP TABLE [NELHARawImportTransect5Station1]
DROP TABLE [NELHARawImportTransect5Station2]
DROP TABLE [NELHARawImportTransect5Station3]
DROP TABLE [NELHARawImportTransect5Station4]
DROP TABLE [NELHARawImportTransect5Station5]
*/
------------------------------
/*
https://stackoverflow.com/questions/14556737/how-to-find-duplicates-from-two-tables-and-also-to-find-duplicate-in-itself

*/
select * from NELHARawImportTransect5Station1 A where exists (select 1 From NELHARawImportTransect5Station2 B where A.[DATE] = B.[DATE] AND A.[TIME ] =B.[TIME ])
--0
select * from NELHARawImportTransect5Station1 A where exists (select 1 From NELHARawImportTransect5Station3 B where A.[DATE] = B.[DATE] AND A.[TIME ] =B.[TIME ])
--0
select * from NELHARawImportTransect5Station1 A where exists (select 1 From NELHARawImportTransect5Station4 B where A.[DATE] = B.[DATE] AND A.[TIME ] =B.[TIME ])
--0
select * from NELHARawImportTransect5Station1 A where exists (select 1 From NELHARawImportTransect5Station5 B where A.[DATE] = B.[DATE] AND A.[TIME ] =B.[TIME ])
-- 0
select * from NELHARawImportTransect5Station2 A where exists (select 1 From NELHARawImportTransect5Station3 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect5Station2 A where exists (select 1 From NELHARawImportTransect5Station4 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect5Station2 A where exists (select 1 From NELHARawImportTransect5Station5 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect5Station3 A where exists (select 1 From NELHARawImportTransect5Station4 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--1
/*
SITE ID	DATE	TIME 	GPS	F5	PO43-	F7	NO3- & NO2-	F9	NH4+ & NH3	F11	Si	F13	TDP	F15	TDN	F17	Turbidity	Salinity	Temp#	pH	DO	Chl a	F24	F25	F26
O5-3S-38m	2003-11-03 00:00:00.000	922	NULL	NULL	0.12	3.7168512	0.01	0.140067	0.17	2.381139	3.96	111.21858	NULL	NULL	NULL	NULL	0.12	34.651	27.4	NULL	NULL	NULL	NULL	NULL	NULL
*/
--  UPDATE NELHARawImportTransect5Station4 SET [TIME ] = [TIME ] + 1 WHERE  [DATE] = '2003-11-03 00:00:00.000'

select * from NELHARawImportTransect5Station3 A where exists (select 1 From NELHARawImportTransect5Station5 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect5Station4 A where exists (select 1 From NELHARawImportTransect5Station5 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect5Station5 A where exists (select 1 From NELHARawImportTransect5Station1 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect5Station5 A where exists (select 1 From NELHARawImportTransect5Station2 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect5Station5 A where exists (select 1 From NELHARawImportTransect5Station3 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect5Station5 A where exists (select 1 From NELHARawImportTransect5Station4 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0

-----------------------------------------------------
-- SELECT * FROM NELHARawImportTransect5Station1 order by [DATE],[TIME]
--  delete from NELHARaw
--/*
/* make sure to include this in execute selection for inserts */
DECLARE @TransectFile int=5
DECLARE @OldLength8  int=8,  @NewLength1   int=1
DECLARE @OldLength23 int=23, @NewLength10  int=10
DECLARE @OldLength38 int=38, @NewLength50  int=50
DECLARE @OldLength53 int=53, @NewLength100 int=100
DECLARE @OldLength69 int=69, @NewLength500 int=500
--
----------------------------------------------------------
-- SELECT * FROM NELHARawImportTransect5Station1  ORDER BY [DATE]
-- SELECT * from NELHARaw WHERE EsriDateTime = '2008-09-23 10:35:00.0000000'
-- add a second to make unique date/time
UPDATE NELHARaw SET EsriDateTime = '2008-09-23 10:35:01.0000000' WHERE EsriDateTime = '2008-09-23 10:35:00.0000000'
--

-- Station#1
--   DECLARE @TransectFile int=5, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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

FROM NELHARawImportTransect5Station1 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by EsriDateTime
-- 98/2058

UPDATE NELHARaw SET EsriDateTime = '2000-01-12 10:53:01.0000000' WHERE EsriDateTime = '1900-01-12 10:53:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-04-11 09:59:02.0000000' WHERE EsriDateTime = '1900-04-11 09:59:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-25 11:07:03.0000000' WHERE EsriDateTime = '1900-07-25 11:07:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-31 10:57:04.0000000' WHERE EsriDateTime = '1900-10-31 10:57:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-03-06 10:47:05.0000000' WHERE EsriDateTime = '1901-03-06 10:47:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-08 10:10:06.0000000' WHERE EsriDateTime = '1902-10-08 10:10:00.0000000'

-----------------------------------------------------------------------------------------
-- Station#2
-- SELECT * FROM NELHARawImportTransect5Station2  ORDER BY [DATE]
-- SELECT * from NELHARaw WHERE EsriDateTime = '2008-09-23 10:42:00.0000000'
-- add a second to make unique date/time
UPDATE NELHARaw SET EsriDateTime = '2008-09-23 10:42:01.0000000' WHERE EsriDateTime = '2008-09-23 10:42:00.0000000'
--

--  DECLARE @TransectFile int=5, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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

FROM NELHARawImportTransect5Station2 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by Esridatetime
-- 196/2156

UPDATE NELHARaw SET EsriDateTime = '2000-01-12 10:47:01.0000000' WHERE EsriDateTime = '1900-01-12 10:47:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-04-11 09:55:02.0000000' WHERE EsriDateTime = '1900-04-11 09:55:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-25 11:02:03.0000000' WHERE EsriDateTime = '1900-07-25 11:02:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-31 10:49:04.0000000' WHERE EsriDateTime = '1900-10-31 10:49:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-03-06 10:41:05.0000000' WHERE EsriDateTime = '1901-03-06 10:41:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-08 10:05:06.0000000' WHERE EsriDateTime = '1902-10-08 10:05:00.0000000'


-----------------------------------------------------------------------------------------
-- Station#3
-- SELECT * from NELHARaw WHERE EsriDateTime = '2007-02-12 10:39:00.0000000'
-- add a second to make unique date/time
UPDATE NELHARaw SET EsriDateTime = '2007-02-12 10:39:01.0000000' WHERE EsriDateTime = '2007-02-12 10:39:00.0000000'
-- SELECT * from NELHARaw WHERE EsriDateTime = '2008-09-23 10:47:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2008-09-23 10:47:01.0000000' WHERE EsriDateTime = '2008-09-23 10:47:00.0000000'


--  DECLARE @TransectFile int=5, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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

FROM NELHARawImportTransect5Station3 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by EsriDateTime
-- 294/2254
--
UPDATE NELHARaw SET EsriDateTime = '2000-01-12 10:42:01.0000000' WHERE EsriDateTime = '1900-01-12 10:42:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-04-11 09:51:02.0000000' WHERE EsriDateTime = '1900-04-11 09:51:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-25 10:58:03.0000000' WHERE EsriDateTime = '1900-07-25 10:58:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-31 10:45:04.0000000' WHERE EsriDateTime = '1900-10-31 10:45:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-03-06 10:37:05.0000000' WHERE EsriDateTime = '1901-03-06 10:37:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-08 10:00:06.0000000' WHERE EsriDateTime = '1902-10-08 10:00:00.0000000'

-----------------------------------------------------------------------------------------
-- SELECT * FROM NELHARawImportTransect5Station2  ORDER BY [DATE]
-- SELECT * from NELHARaw WHERE EsriDateTime = '2008-09-23 10:52:00.0000000'
-- add a second to make unique date/time
UPDATE NELHARaw SET EsriDateTime = '2008-09-23 10:52:01.0000000' WHERE EsriDateTime = '2008-09-23 10:52:00.0000000'
--
-- Station#4
--
--  DECLARE @TransectFile int=5, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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

FROM NELHARawImportTransect5Station4 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by Esridatetime
-- 392/2352
--
UPDATE NELHARaw SET EsriDateTime = '2000-01-12 10:38:01.0000000' WHERE EsriDateTime = '1900-01-12 10:38:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-04-11 09:46:02.0000000' WHERE EsriDateTime = '1900-04-11 09:46:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-25 10:54:03.0000000' WHERE EsriDateTime = '1900-07-25 10:54:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-31 10:40:04.0000000' WHERE EsriDateTime = '1900-10-31 10:40:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-03-06 10:29:05.0000000' WHERE EsriDateTime = '1901-03-06 10:29:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-08 09:56:06.0000000' WHERE EsriDateTime = '1902-10-08 09:56:00.0000000'


-----------------------------------------------------------------------------------------
-- Station#5
-- SELECT * FROM NELHARawImportTransect5Station5  ORDER BY [DATE]
-- SELECT * from NELHARaw WHERE EsriDateTime = '2008-09-23 11:00:00.0000000'
-- add a second to make unique date/time
UPDATE NELHARaw SET EsriDateTime = '2008-09-23 11:00:01.0000000' WHERE EsriDateTime = '2008-09-23 11:00:00.0000000'
-- SELECT * from NELHARaw WHERE EsriDateTime = '2015-11-18 10:50:00.0000000'
-- add a second to make unique date/time
UPDATE NELHARaw SET EsriDateTime = '2015-11-18 10:50:01.0000000' WHERE EsriDateTime = '2015-11-18 10:50:00.0000000'


-- Station#5
--
--  DECLARE @TransectFile int=5, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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

FROM NELHARawImportTransect5Station5 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by EsriDateTime
-- 490/2450

UPDATE NELHARaw SET EsriDateTime = '2000-01-12 10:29:01.0000000' WHERE EsriDateTime = '1900-01-12 10:29:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-04-11 09:41:02.0000000' WHERE EsriDateTime = '1900-04-11 09:41:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-25 10:48:03.0000000' WHERE EsriDateTime = '1900-07-25 10:48:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-31 10:34:04.0000000' WHERE EsriDateTime = '1900-10-31 10:34:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-03-06 10:22:05.0000000' WHERE EsriDateTime = '1901-03-06 10:22:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-08 09:49:06.0000000' WHERE EsriDateTime = '1902-10-08 09:49:00.0000000'


-- select * FROM NELHARawImportTransect5Station5 order by [DATE]


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- create our own identity attribute by this import file
--  DECLARE @TransectFile int=5, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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
-- 490/2450
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