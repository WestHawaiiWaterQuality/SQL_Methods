-- Import XLS file from NELHA 'OT-1rawdata.xlsx' to represent raw data for Transect#1
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
--  sp_rename ['Station 1$'], [NELHARawImportTransect1Station1]

--  sp_rename ['Station 2$'], [NELHARawImportTransect1Station2]

--  sp_rename ['Station 3$'], [NELHARawImportTransect1Station3]

--  sp_rename ['Station 4$'], [NELHARawImportTransect1Station4]

--  sp_rename ['Station 5$'], [NELHARawImportTransect1Station5]

SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect1Station1 GROUP BY [DATE] HAVING COUNT([DATE])>1
SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect1Station2 GROUP BY [DATE] HAVING COUNT([DATE])>1
SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect1Station3 GROUP BY [DATE] HAVING COUNT([DATE])>1
SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect1Station4 GROUP BY [DATE] HAVING COUNT([DATE])>1
-- all zeros

SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect1Station5 GROUP BY [DATE] HAVING COUNT([DATE])>1
/*
2011-04-26 00:00:00.000	2
*/
SELECT * FROM NELHARawImportTransect1Station5 WHERE [DATE] = '2011-04-26 00:00:00.000'
/*
SITE ID	DATE	TIME 	GPS	F5	PO43-	F7	NO3- & NO2-	F9	NH4+ & NH3	F11	Si	F13	TDP	F15	TDN	F17	Turbidity	Salinity	Temp#	pH	DO	Chl a	F24	F25	F26
T1-500m	2011-04-26 00:00:00.000	935	 19°44'9.84"N	156° 3'33.41"W	0.103313256123893	3.2	0.214183212319818	3	0.0785338445172667	1.1	4.69993412971106	132	0.46	14.1	3.5	49	0.08	34.94	25.03	8.22	6.33	0.14	NULL	NULL	NULL
T1-500m	2011-04-26 00:00:00.000	935	 19°44'9.84"N	156° 3'33.41"W	0.0903990991084066	2.8	0.0285577616426425	0.4	0.149928248623873	2.1	0.861654590447028	24.2	0.38	11.9	4.4	62	0.11	35.19	24.64	8.22	6.66	0.08	NULL	NULL	NULL
*/
--UPDATE NELHARawImportTransect1Station5 SET [DATE] = '2012-04-24 00:00:00.000' 
-- WHERE [DATE] = '2011-04-26 00:00:00.000' AND [PO43-] = 0.0903990991084066

------------------------------
/*
DROP TABLE [NELHARawImportTransect1Station1]
DROP TABLE [NELHARawImportTransect1Station2]
DROP TABLE [NELHARawImportTransect1Station3]
DROP TABLE [NELHARawImportTransect1Station4]
DROP TABLE [NELHARawImportTransect1Station5]
*/
---------------------
/*
https://stackoverflow.com/questions/14556737/how-to-find-duplicates-from-two-tables-and-also-to-find-duplicate-in-itself

*/
select * from NELHARawImportTransect1Station1 A where exists (select 1 From NELHARawImportTransect1Station2 B where A.[DATE] = B.[DATE] AND A.[TIME ] =B.[TIME ])
--0
select * from NELHARawImportTransect1Station1 A where exists (select 1 From NELHARawImportTransect1Station3 B where A.[DATE] = B.[DATE] AND A.[TIME ] =B.[TIME ])
--0
select * from NELHARawImportTransect1Station1 A where exists (select 1 From NELHARawImportTransect1Station4 B where A.[DATE] = B.[DATE] AND A.[TIME ] =B.[TIME ])
--1
/*
SITE ID	DATE	TIME 	GPS	F5	PO43-	F7	NO3- & NO2-	F9	NH4+ & NH3	F11	Si	F13	TDP	F15	TDN	F17	TP	F19	TOC	Turbidity	Salinity	Temp#	pH	DO	Chl a	Fecal Coliform	Enterococci	F29	F30
T1-1m	2008-06-05 00:00:00.000	941	 19°43'55.34"N	156° 3'25.71"W	0.122684491647123	3.8	0.192764891087837	2.7	0.157067689034533	2.2	12.5865660216126	353.5	0.300254150610065	9.3	11.9228654858032	167	NULL	NULL	NULL	0.1	34.8166	24.9	8.09	6.81	0.21	NULL	NULL	NULL	NULL
*/
--  UPDATE NELHARawImportTransect1Station1 SET [TIME ] = [TIME ] + 2 WHERE  [DATE] = '2008-06-05 00:00:00.000'
select * from NELHARawImportTransect1Station1 A where exists (select 1 From NELHARawImportTransect1Station5 B where A.[DATE] = B.[DATE] AND A.[TIME ] =B.[TIME ])
--1
/*
SITE ID	DATE	TIME 	GPS	F5	PO43-	F7	NO3- & NO2-	F9	NH4+ & NH3	F11	Si	F13	TDP	F15	TDN	F17	TP	F19	TOC	Turbidity	Salinity	Temp#	pH	DO	Chl a	Fecal Coliform	Enterococci	F29	F30
T1-1m	2011-04-26 00:00:00.000	935	 19°43'55.34"N	156° 3'25.71"W	0.177569658962942	5.5	0.34983258012237	4.9	0.135649367802552	1.9	6.83626782503427	192	0.481052348826878	14.9	3.4626285991704	48.5	NULL	NULL	NULL	0.08	34.95	25.06	8.23	6.46	0.14	NULL	NULL	NULL	NULL
*/
--  UPDATE NELHARawImportTransect1Station5 SET [TIME ] = [TIME ] + 1 WHERE  [DATE] = '2011-04-26 00:00:00.000'

select * from NELHARawImportTransect1Station2 A where exists (select 1 From NELHARawImportTransect1Station3 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect1Station2 A where exists (select 1 From NELHARawImportTransect1Station4 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect1Station2 A where exists (select 1 From NELHARawImportTransect1Station5 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect1Station3 A where exists (select 1 From NELHARawImportTransect1Station4 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect1Station3 A where exists (select 1 From NELHARawImportTransect1Station5 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect1Station4 A where exists (select 1 From NELHARawImportTransect1Station5 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
-- 2
/*
SITE ID	DATE	TIME 	GPS	F5	PO43-	F7	NO3- & NO2-	F9	NH4+ & NH3	F11	Si	F13	TDP	F15	TDN	F17	Turbidity	Salinity	Temp#	pH	DO	Chl a	F24	F25	F26	F27
O1-4S-53m	1995-06-26 00:00:00.000	940	NULL	NULL	0.21	6.5044896	1.23	17.228241	0.2	2.80134	17.54	492.61967	NULL	NULL	NULL	NULL	0.08	34.145	26.7	NULL	NULL	NULL	NULL	NULL	NULL	NULL
T1-100m	2008-06-05 00:00:00.000	941	19°43'58.23"N	156° 3'27.26"W	0.106541795377765	3.3	0.242740973962461	3.4	0.157067689034533	2.2	17.7030852219117	497.2	0.29	9.0	8.0	111	0.08	34.8144	25.02	8.08	6.72	0.2	NULL	NULL	NULL	NULL
*/
--  UPDATE NELHARawImportTransect1Station5 SET [TIME ] = [TIME ] + 1 WHERE  [DATE] = '1995-06-26 00:00:00.000' -- O1-4S-53m
--  UPDATE NELHARawImportTransect1Station5 SET [TIME ] = [TIME ] + 1 WHERE  [DATE] = '2008-06-05 00:00:00.000' -- T1-100m

select * from NELHARawImportTransect1Station5 A where exists (select 1 From NELHARawImportTransect1Station1 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
/*SITE ID	DATE	TIME 	GPS	F5	PO43-	F7	NO3- & NO2-	F9	NH4+ & NH3	F11	Si	F13	TDP	F15	TDN	F17	Turbidity	Salinity	Temp#	pH	DO	Chl a	F24	F25	F26
T1-500m	2008-06-05 00:00:00.000	942	 19°44'9.84"N	156° 3'33.41"W	0.122684491647123	3.8	0.128509927391891	1.8	0.157067689034533	2.2	16.5957522565025	466.1	0.26	7.9	6.6	92	0.08	34.8146	25.04	8.07	6.63	0.13	NULL	NULL	NULL
*/
--  UPDATE NELHARawImportTransect1Station5 SET [TIME ] = [TIME ] + 2 WHERE  [DATE] = '2008-06-05 00:00:00.000' -- T1-500m
select * from NELHARawImportTransect1Station5 A where exists (select 1 From NELHARawImportTransect1Station2 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
select * from NELHARawImportTransect1Station5 A where exists (select 1 From NELHARawImportTransect1Station3 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
select * from NELHARawImportTransect1Station5 A where exists (select 1 From NELHARawImportTransect1Station4 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])



--------------------------------------------
--------------------------------------------


-- SELECT * FROM NELHARawImportTransect1Station1 order by [DATE],[TIME]
--  delete from NELHARaw
--/*
/* make sure to include this in execute selection for inserts */
DECLARE @TransectFile int=1
DECLARE @OldLength8  int=8,  @NewLength1   int=1
DECLARE @OldLength23 int=23, @NewLength10  int=10
DECLARE @OldLength38 int=38, @NewLength50  int=50
DECLARE @OldLength53 int=53, @NewLength100 int=100
DECLARE @OldLength69 int=69, @NewLength500 int=500
--
-- Station#1
-- select * from NELHARawImportTransect1Station1
--   DECLARE @TransectFile int=1, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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

FROM NELHARawImportTransect1Station1 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by EsriDateTime
-- 98
-----------------------------------------------------------------------------------------
-- Station#2
-- select * from NELHARawImportTransect1Station2
--  DECLARE @TransectFile int=1, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
INSERT INTO NELHARaw
SELECT 
CAST(CAST(s.[DATE] as date) as nvarchar) + ' ' +
     CAST(CONVERT(time, SUBSTRING(RIGHT('0' + LTRIM(cast(s.[TIME ] as nvarchar)),4),1,2) + ':' +
          SUBSTRING(RIGHT('0' + LTRIM(cast(s.[TIME ] as nvarchar)),4),3,2)) as nvarchar) as dt,
IIF(CAST(SUBSTRING(RIGHT('0' + LTRIM(cast(s.[TIME ] as nvarchar)),4),1,2) as int) >= 12, 'PM', 'AM'),
CAST(SUBSTRING(REPLACE([SITE ID],' ',''),2,1) as int),                        -- Transect
IIF (SUBSTRING(REPLACE([SITE ID],' ',''),1,1)='O', @OldLength23, @NewLength10),  -- mShore
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

FROM NELHARawImportTransect1Station2 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by Esridatetime
-- 196

-----------------------------------------------------------------------------------------
-- Station#3
-- select * from NELHARawImportTransect1Station3
--  DECLARE @TransectFile int=1, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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

FROM NELHARawImportTransect1Station3 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by EsriDateTime
-- 294
--
UPDATE NELHARaw SET EsriDateTime = '2000-01-04 12:04:01.0000000' WHERE EsriDateTime = '1900-01-04 12:04:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-04-17 09:55:02.0000000' WHERE EsriDateTime = '1900-04-17 09:55:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-24 12:28:03.0000000' WHERE EsriDateTime = '1900-07-24 12:28:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-30 12:40:04.0000000' WHERE EsriDateTime = '1900-10-30 12:40:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-02-26 12:23:05.0000000' WHERE EsriDateTime = '1901-02-26 12:23:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-09 11:00:06.0000000' WHERE EsriDateTime = '1902-10-09 11:00:00.0000000'

-----------------------------------------------------------------------------------------
-- Station#4
-- select * from NELHARawImportTransect1Station4
--  DECLARE @TransectFile int=1, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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

FROM NELHARawImportTransect1Station4 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by Esridatetime
-- 392
--
UPDATE NELHARaw SET EsriDateTime='2000-01-04 11:59:01.0000000' WHERE EsriDateTime = '1900-01-04 11:59:00.0000000'
UPDATE NELHARaw SET EsriDateTime='2000-04-17 09:51:02.0000000' WHERE EsriDateTime = '1900-04-17 09:51:00.0000000'
UPDATE NELHARaw SET EsriDateTime='2000-07-24 12:20:03.0000000' WHERE EsriDateTime = '1900-07-24 12:20:00.0000000'
UPDATE NELHARaw SET EsriDateTime='2000-10-30 12:34:04.0000000' WHERE EsriDateTime = '1900-10-30 12:34:00.0000000'
UPDATE NELHARaw SET EsriDateTime='2001-02-26 12:18:05.0000000' WHERE EsriDateTime = '1901-02-26 12:18:00.0000000'
UPDATE NELHARaw SET EsriDateTime='2002-10-09 10:55:06.0000000' WHERE EsriDateTime = '1902-10-09 10:55:00.0000000'

-----------------------------------------------------------------------------------------
-- Station#5
-- select * from NELHARawImportTransect1Station5
--  DECLARE @TransectFile int=1, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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

FROM NELHARawImportTransect1Station5 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by EsriDateTime
-- 490

UPDATE NELHARaw SET EsriDateTime = '2000-01-04 11:54:01.0000000' WHERE EsriDateTime = '1900-01-04 11:54:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-04-17 09:46:02.0000000' WHERE EsriDateTime = '1900-04-17 09:46:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-24 12:12:03.0000000' WHERE EsriDateTime = '1900-07-24 12:12:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-30 12:28:04.0000000' WHERE EsriDateTime = '1900-10-30 12:28:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-02-26 12:10:05.0000000' WHERE EsriDateTime = '1901-02-26 12:10:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-09 10:50:06.0000000' WHERE EsriDateTime = '1902-10-09 10:50:00.0000000'



-- select * FROM NELHARawImportTransect1Station5 order by [DATE]


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- create our own identity attribute by this import file
--  DECLARE @TransectFile int=1, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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