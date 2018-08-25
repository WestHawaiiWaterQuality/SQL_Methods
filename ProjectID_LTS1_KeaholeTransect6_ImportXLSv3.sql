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
-- sp_rename ['Station 1$'], [NELHARawImportTransect6Station1]

-- sp_rename ['Station 2$'], [NELHARawImportTransect6Station2]

-- sp_rename ['Station 3$'], [NELHARawImportTransect6Station3]

-- sp_rename ['Station 4$'], [NELHARawImportTransect6Station4]

-- sp_rename ['Station 5$'], [NELHARawImportTransect6Station5]

SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect6Station1 GROUP BY [DATE] HAVING COUNT([DATE])>1
SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect6Station2 GROUP BY [DATE] HAVING COUNT([DATE])>1
SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect6Station3 GROUP BY [DATE] HAVING COUNT([DATE])>1
SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect6Station4 GROUP BY [DATE] HAVING COUNT([DATE])>1
SELECT [DATE], COUNT([DATE]) FROM NELHARawImportTransect6Station5 GROUP BY [DATE] HAVING COUNT([DATE])>1
-- all zeros
------------------------------
/*
DROP TABLE [NELHARawImportTransect6Station1]
DROP TABLE [NELHARawImportTransect6Station2]
DROP TABLE [NELHARawImportTransect6Station3]
DROP TABLE [NELHARawImportTransect6Station4]
DROP TABLE [NELHARawImportTransect6Station5]
*/
------------------------------
/*
https://stackoverflow.com/questions/14556737/how-to-find-duplicates-from-two-tables-and-also-to-find-duplicate-in-itself

*/
select * from NELHARawImportTransect6Station1 A where exists (select 1 From NELHARawImportTransect6Station2 B where A.[DATE] = B.[DATE] AND A.[TIME ] =B.[TIME ])
--0
select * from NELHARawImportTransect6Station1 A where exists (select 1 From NELHARawImportTransect6Station3 B where A.[DATE] = B.[DATE] AND A.[TIME ] =B.[TIME ])
--0
select * from NELHARawImportTransect6Station1 A where exists (select 1 From NELHARawImportTransect6Station4 B where A.[DATE] = B.[DATE] AND A.[TIME ] =B.[TIME ])
--0
select * from NELHARawImportTransect6Station1 A where exists (select 1 From NELHARawImportTransect6Station5 B where A.[DATE] = B.[DATE] AND A.[TIME ] =B.[TIME ])
--0
select * from NELHARawImportTransect6Station2 A where exists (select 1 From NELHARawImportTransect6Station3 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect6Station2 A where exists (select 1 From NELHARawImportTransect6Station4 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect6Station2 A where exists (select 1 From NELHARawImportTransect6Station5 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect6Station3 A where exists (select 1 From NELHARawImportTransect6Station4 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--4
/*
SITE ID	DATE	TIME 	GPS	F5	PO43-	F7	NO3- & NO2-	F9	NH4+ & NH3	F11	Si	F13	TDP	F15	TDN	F17	Turbidity	Salinity	Temp#	pH	DO	Chl a	F24	F25	F26	F27	F28	F29	F30	F31	F32	F33	F34	F35	F36	F37	F38	F39	F40	F41	F42	F43	F44	F45	F46	F47	F48	F49	F50	F51	F52	F53
T6-50m	2016-07-07 00:00:00.000	1054	 19°42'43.78"N	156° 3'0.68"W	0.125913030900995	3.9	0.271298735605103	3.8	0.514039709567564	7.2	6.48377276530594	182.1	0.46	14.3	3.0	42	0.1	34.47	26.72	8.32	6.75	0.26	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
T6-50m	2016-12-21 00:00:00.000	1125	 19°42'43.78"N	156° 3'0.68"W	0.0451995495542033	1.4	0.285577616426424	4	0.364111460943691	5.1	2.84488437093874	79.9	0.36	11.0	4.4	62	0.04	34.62	25.57	8.28	5.98	0.13	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
T6-50m	2017-03-01 00:00:00.000	1200	 19°42'43.78"N	156° 3'0.68"W	0.0322853925387166	1	0.635410196548794	8.9	0.0785338445172667	1.1	5.05242918943939	141.9	0.15	4.6	5.3	74	0.08	34.61	24.55	8.25	5.83	0.18	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
T6-50m	2017-05-10 00:00:00.000	1149	 19°42'43.78"N	156° 3'0.68"W	0.0451995495542033	1.4	0.178486010266515	2.5	0.0999521657492486	1.4	1.71974862473518	48.3	0.22	6.8	4.4	61	0.09	34.83	25.84	8.24	4.15	0.15	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
*/
--  UPDATE NELHARawImportTransect6Station3 SET [TIME ] = [TIME ] + 1 WHERE [DATE] = '2016-07-07 00:00:00.000'
--  UPDATE NELHARawImportTransect6Station3 SET [TIME ] = [TIME ] + 1 WHERE [DATE] = '2016-12-21 00:00:00.000'
--  UPDATE NELHARawImportTransect6Station3 SET [TIME ] = [TIME ] + 1 WHERE [DATE] = '2017-03-01 00:00:00.000'
--  UPDATE NELHARawImportTransect6Station3 SET [TIME ] = [TIME ] + 1 WHERE [DATE] = '2017-05-10 00:00:00.000'

select * from NELHARawImportTransect6Station3 A where exists (select 1 From NELHARawImportTransect6Station5 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect6Station4 A where exists (select 1 From NELHARawImportTransect6Station5 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--8
/*
SITE ID	DATE	TIME 	GPS	F5	PO43-	F7	NO3- & NO2-	F9	NH4+ & NH3	F11	Si	F13	TDP	F15	TDN	F17	Turbidity	Salinity	Temp#	pH	DO	Chl a	F24	F25	F26	F27
T6-100m	2008-09-23 00:00:00.000	1219	 19°42'43.47"N	156° 3'2.39"W	0.0258283140309733	0.8	0.142788808213212	2	0.306995937658406	4.3	2.23602926777163	62.8	0.35	10.7	5.4	75	0.06	34.787	26.75	8.07	6.05	0.12	NULL	NULL	NULL	NULL
T6-100m	2008-12-08 00:00:00.000	1042	 19°42'43.47"N	156° 3'2.39"W	0.161426962693583	5	0.57829467326351	8.1	0.299856497247746	4.2	5.31234978903705	149.2	0.35	10.8	5.8	81	0.08	34.69	26.31	8.3	5.63	0.04	NULL	NULL	NULL	NULL
T6-100m	2009-02-10 00:00:00.000	1009	 19°42'43.47"N	156° 3'2.39"W	0.0903990991084066	2.8	0.549736911620867	7.7	0.178486010266515	2.5	5.65772373644763	158.9	0.24	7.4	8.7	122	0.09	34.9076	24.76	8.06	5.87	0.04	NULL	NULL	NULL	NULL
T6-100m	2009-06-30 00:00:00.000	1102	 19°42'43.47"N	156° 3'2.39"W	0.29056853284845	9	1.43502752254278	20.1	0.628270756138134	8.8	13.5799611899379	381.4	0.49	15.1	5.3	75	0.1	34.516	26.65	8.18	6.28	0.16	NULL	NULL	NULL	NULL
T6-100m	2016-07-07 00:00:00.000	1054	 19°42'43.47"N	156° 3'2.39"W	0.125913030900995	3.9	0.271298735605103	3.8	0.514039709567564	7.2	6.48377276530594	182.1	0.46	14.3	3.0	42	0.1	34.47	26.72	8.32	6.75	0.26	NULL	NULL	NULL	NULL
T6-100m	2016-12-21 00:00:00.000	1125	 19°42'43.47"N	156° 3'2.39"W	0.0451995495542033	1.4	0.285577616426424	4	0.364111460943691	5.1	2.84488437093874	79.9	0.36	11.0	4.4	62	0.04	34.62	25.57	8.28	5.98	0.13	NULL	NULL	NULL	NULL
T6-100m	2017-03-01 00:00:00.000	1200	 19°42'43.47"N	156° 3'2.39"W	0.0322853925387166	1	0.635410196548794	8.9	0.0785338445172667	1.1	5.05242918943939	141.9	0.15	4.6	5.3	74	0.08	34.61	24.55	8.25	5.83	0.18	NULL	NULL	NULL	NULL
T6-100m	2017-05-10 00:00:00.000	1149	 19°42'43.47"N	156° 3'2.39"W	0.0451995495542033	1.4	0.178486010266515	2.5	0.0999521657492486	1.4	1.71974862473518	48.3	0.22	6.8	4.4	61	0.09	34.83	25.84	8.24	4.15	0.15	NULL	NULL	NULL	NULL
*/
/*
 UPDATE NELHARawImportTransect6Station4 SET [TIME ] = [TIME ] + 1 WHERE [DATE] = '2008-09-23 00:00:00.000'
 UPDATE NELHARawImportTransect6Station4 SET [TIME ] = [TIME ] + 1 WHERE [DATE] = '2008-12-08 00:00:00.000'
 UPDATE NELHARawImportTransect6Station4 SET [TIME ] = [TIME ] + 1 WHERE [DATE] = '2009-02-10 00:00:00.000'
 UPDATE NELHARawImportTransect6Station4 SET [TIME ] = [TIME ] + 1 WHERE [DATE] = '2009-06-30 00:00:00.000'
 UPDATE NELHARawImportTransect6Station4 SET [TIME ] = [TIME ] + 1 WHERE [DATE] = '2016-07-07 00:00:00.000'
 UPDATE NELHARawImportTransect6Station4 SET [TIME ] = [TIME ] + 1 WHERE [DATE] = '2016-12-21 00:00:00.000'
 UPDATE NELHARawImportTransect6Station4 SET [TIME ] = [TIME ] + 1 WHERE [DATE] = '2017-03-01 00:00:00.000'
 UPDATE NELHARawImportTransect6Station4 SET [TIME ] = [TIME ] + 1 WHERE [DATE] = '2017-05-10 00:00:00.000'
 */

select * from NELHARawImportTransect6Station5 A where exists (select 1 From NELHARawImportTransect6Station1 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect6Station5 A where exists (select 1 From NELHARawImportTransect6Station2 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect6Station5 A where exists (select 1 From NELHARawImportTransect6Station3 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0
select * from NELHARawImportTransect6Station5 A where exists (select 1 From NELHARawImportTransect6Station4 B where A.[DATE] =B.[DATE] AND A.[TIME ]=B.[TIME ])
--0


-----------------------------------------------------
-- SELECT * FROM NELHARawImportTransect6Station1 order by [DATE],[TIME]
--  delete from NELHARaw
--/*
/* make sure to include this in execute selection for inserts */
DECLARE @TransectFile int=6
DECLARE @OldLength8  int=8,  @NewLength1   int=1
DECLARE @OldLength23 int=23, @NewLength10  int=10
DECLARE @OldLength38 int=38, @NewLength50  int=50
DECLARE @OldLength53 int=53, @NewLength100 int=100
DECLARE @OldLength69 int=69, @NewLength500 int=500
--
----------------------------------------------------------
-- Station#1
-- SELECT * FROM NELHARawImportTransect6Station1  ORDER BY [DATE]
-- SELECT * from NELHARaw WHERE EsriDateTime = '2008-12-08 10:17:00.0000000'
-- add a second to make unique date/time
UPDATE NELHARaw SET EsriDateTime = '2008-12-08 10:17:01.0000000' WHERE EsriDateTime = '2008-12-08 10:17:00.0000000'


--   DECLARE @TransectFile int=6, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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

FROM NELHARawImportTransect6Station1 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by EsriDateTime
-- 98/2458

UPDATE NELHARaw SET EsriDateTime = '2000-01-12 12:08:01.0000000' WHERE EsriDateTime = '1900-01-12 12:08:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-04-11 11:04:02.0000000' WHERE EsriDateTime = '1900-04-11 11:04:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-25 12:21:03.0000000' WHERE EsriDateTime = '1900-07-25 12:21:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-31 12:09:04.0000000' WHERE EsriDateTime = '1900-10-31 12:09:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-03-06 11:56:05.0000000' WHERE EsriDateTime = '1901-03-06 11:56:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-08 11:15:06.0000000' WHERE EsriDateTime = '1902-10-08 11:15:00.0000000'

-----------------------------------------------------------------------------------------
-- Station#2
-- SELECT * FROM NELHARawImportTransect6Station2  ORDER BY [DATE]
-- SELECT * from NELHARaw WHERE EsriDateTime = '2008-12-08 10:22:00.0000000'
-- add a second to make unique date/time
UPDATE NELHARaw SET EsriDateTime = '2008-12-08 10:22:01.0000000' WHERE EsriDateTime = '2008-12-08 10:22:00.0000000'


--  DECLARE @TransectFile int=6, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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

FROM NELHARawImportTransect6Station2 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by Esridatetime
-- 196/2646
--
UPDATE NELHARaw SET EsriDateTime = '2000-01-12 12:03:01.0000000' WHERE EsriDateTime = '1900-01-12 12:03:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-04-11 11:00:02.0000000' WHERE EsriDateTime = '1900-04-11 11:00:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-25 12:19:03.0000000' WHERE EsriDateTime = '1900-07-25 12:19:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-31 12:05:04.0000000' WHERE EsriDateTime = '1900-10-31 12:05:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-03-06 11:50:05.0000000' WHERE EsriDateTime = '1901-03-06 11:50:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-08 11:10:06.0000000' WHERE EsriDateTime = '1902-10-08 11:10:00.0000000'

-----------------------------------------------------------------------------------------
-- Station#3
-- SELECT * FROM NELHARawImportTransect6Station3  ORDER BY [DATE]
-- SELECT * from NELHARaw WHERE EsriDateTime = '2008-12-08 10:28:00.0000000'
-- add a second to make unique date/time
UPDATE NELHARaw SET EsriDateTime = '2008-12-08 10:28:01.0000000' WHERE EsriDateTime = '2008-12-08 10:28:00.0000000'

--
--  DECLARE @TransectFile int=6, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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

FROM NELHARawImportTransect6Station3 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by EsriDateTime
-- 294/2744
--
UPDATE NELHARaw SET EsriDateTime = '2000-01-12 11:57:01.0000000' WHERE EsriDateTime = '1900-01-12 11:57:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-04-11 10:55:02.0000000' WHERE EsriDateTime = '1900-04-11 10:55:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-25 12:15:03.0000000' WHERE EsriDateTime = '1900-07-25 12:15:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-31 11:59:04.0000000' WHERE EsriDateTime = '1900-10-31 11:59:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-03-06 11:45:05.0000000' WHERE EsriDateTime = '1901-03-06 11:45:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-08 11:06:06.0000000' WHERE EsriDateTime = '1902-10-08 11:06:00.0000000'


-----------------------------------------------------------------------------------------
-- Station#4
-- SELECT * FROM NELHARawImportTransect6Station4  ORDER BY [DATE]
-- SELECT * from NELHARaw WHERE EsriDateTime = '2016-07-07 10:55:00.0000000'
-- add a second to make unique date/time
UPDATE NELHARaw SET EsriDateTime = '2016-07-07 10:55:01.0000000' WHERE EsriDateTime = '2016-07-07 10:55:00.0000000'
-- SELECT * from NELHARaw WHERE EsriDateTime = '2016-12-21 11:26:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2016-12-21 11:26:01.0000000' WHERE EsriDateTime = '2016-12-21 11:26:00.0000000'
-- SELECT * from NELHARaw WHERE EsriDateTime = '2017-03-01 12:01:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2017-03-01 12:01:00.0000000' WHERE EsriDateTime = '2017-03-01 12:01:00.0000000'
-- SELECT * from NELHARaw WHERE EsriDateTime = '2017-03-01 12:01:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2017-03-01 12:01:01.0000000' WHERE EsriDateTime = '2017-03-01 12:01:00.0000000'
-- SELECT * from NELHARaw WHERE EsriDateTime = '2017-05-10 11:50:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2017-05-10 11:50:01.0000000' WHERE EsriDateTime = '2017-05-10 11:50:00.0000000'



--  DECLARE @TransectFile int=6, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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

FROM NELHARawImportTransect6Station4 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by Esridatetime
-- 392/2842
--
UPDATE NELHARaw SET EsriDateTime = '2000-01-12 11:49:01.0000000' WHERE EsriDateTime = '1900-01-12 11:49:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-04-11 10:49:02.0000000' WHERE EsriDateTime = '1900-04-11 10:49:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-25 12:09:03.0000000' WHERE EsriDateTime = '1900-07-25 12:09:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-31 11:53:04.0000000' WHERE EsriDateTime = '1900-10-31 11:53:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-03-06 11:40:05.0000000' WHERE EsriDateTime = '1901-03-06 11:40:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-08 11:02:06.0000000' WHERE EsriDateTime = '1902-10-08 11:02:00.0000000'


-----------------------------------------------------------------------------------------
-- Station#5
-- SELECT * FROM NELHARawImportTransect6Station5  ORDER BY [DATE]
-- SELECT * from NELHARaw WHERE EsriDateTime = '2008-12-08 10:42:00.0000000'
-- add a second to make unique date/time
UPDATE NELHARaw SET EsriDateTime = '2008-12-08 10:42:01.0000000' WHERE EsriDateTime = '2008-12-08 10:42:00.0000000'


--  DECLARE @TransectFile int=6, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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

FROM NELHARawImportTransect6Station5 s
WHERE 
[SITE ID] IS NOT NULL AND [DATE] IS NOT NULL
ORDER BY dt
-- 98
select * from NELHARaw order by EsriDateTime
-- 490/2940
--
UPDATE NELHARaw SET EsriDateTime = '2000-01-12 11:40:01.0000000' WHERE EsriDateTime = '1900-01-12 11:40:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-04-11 10:42:02.0000000' WHERE EsriDateTime = '1900-04-11 10:42:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-07-25 12:05:03.0000000' WHERE EsriDateTime = '1900-07-25 12:05:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2000-10-31 11:48:04.0000000' WHERE EsriDateTime = '1900-10-31 11:48:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2001-03-06 11:34:05.0000000' WHERE EsriDateTime = '1901-03-06 11:34:00.0000000'
UPDATE NELHARaw SET EsriDateTime = '2002-10-08 10:56:06.0000000' WHERE EsriDateTime = '1902-10-08 10:56:00.0000000'



-- select * FROM NELHARawImportTransect6Station5 order by [DATE]


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- create our own identity attribute by this import file
--  DECLARE @TransectFile int=6, @OldLength8  int=8,  @NewLength1   int=1, @OldLength23 int=23, @NewLength10  int=10, @OldLength38 int=38, @NewLength50  int=50, @OldLength53 int=53, @NewLength100 int=100,@OldLength69 int=69, @NewLength500 int=500
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
-- 490/2940
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