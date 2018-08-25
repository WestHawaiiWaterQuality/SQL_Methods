-- Create script for Hokulia 
-- last update 4/7/2018

USE whwq4
-

/* Hokulia Transcribed
Hokulia Water Monitoring Program
Distribution and Relationships between Water Quality Parameters at Hokulia and Control Stations
A Technical Report Prepared in Support of Continued Water Monitoring
FIleName: 19_5139_Hokulia_DZiemann_Y2003_EIS.pdf

Submitted by:
David A Ziemann, Ph.D Oceanic Institute Makau’u Point 41-202 Kalanianole Highway Waimanalo, Hawaii 96795
Karen Klein AECOS Laboratories of Hawaii 74-5602 Alapa Street Kailua-Kona, Hawaii 96740
November 20, 2003
*/
--  DROP table HokuliaTranscribedValues
CREATE TABLE HokuliaTranscribedValues (
   Transect  [int]            NOT NULL, -- pk+
   mShore    [int]            NOT NULL, -- pk
   DocName   [nvarchar](255)  NOT NULL,
   DocSName  [nvarchar](255)  NOT NULL,

   pHyd6390  [numeric](38, 8)     NULL,--1
   Temp6280  [numeric](38, 8)     NULL,
   OxyD6270  [numeric](38, 8)     NULL,
   Sali6350  [numeric](38, 8) NOT NULL,
   Turb6260  [numeric](38, 8) NOT NULL,--5

   Ammn6220  [numeric](38, 8) NOT NULL,
   TDNi6210  [numeric](38, 8) NOT NULL,
   NaNi6230  [numeric](38, 8) NOT NULL,
   TPho6240  [numeric](38, 8) NOT NULL,
   Pho06395  [numeric](38, 8) NOT NULL,--10

   ChlA6250  [numeric](38, 8) NOT NULL,
   Sili6360  [numeric](38, 8) NOT NULL,
   Nate6393  [numeric](38, 8) NOT NULL,--13

PRIMARY KEY (Transect,mShore)
)


-----------------
-- this document is only available on paper so here is my effort to get into electronic form

--  delete from HokuliaTranscribedValues
-- INSERT INTO HokuliaTranscribedValues VALUES
(4,1  , 'Transect 4-North Boundary JustNorthOfGolf',   '1S',  8.23,  27.6, 6.90, 35.2, 0.23,      2, 129,     4,  5,  1, 0.27,  96,   1.8),
(4,10 , 'Transect 4-North Boundary JustNorthOfGolf',  '10S',  8.24,  27.4, 6.80, 33.2, 0.32,  0.999, 139, .9999,  6,  3, 0.29, 189,   3.6),
(4,50 , 'Transect 4-North Boundary JustNorthOfGolf',  '50S',  8.23,  27.8, 6.82, 35.5, 0.19,      1, 153,     2,  8,  4, 0.20, 145,   2.3),
(4,100, 'Transect 4-North Boundary JustNorthOfGolf', '100S',  8.23,  27.9, 6.60, 35.5, 0.24,      1, 378, .9999,  6,  3, 0.15,  76,   3.5),
(4,500, 'Transect 4-North Boundary JustNorthOfGolf', '500S',  8.23,  27.9, 6.59, 35.5, 0.22,      1,  68,     6,  6,  3, 0.14,  70,   2.3),
(7,1  , 'Control B Leinokano Point                 ',   '1S',  NULL,  NULL, NULL, 35.1, 0.23,  0.999, 112,     5,  5,  3, 0.45,  351,  2.2),
(7,10 , 'Control B Leinokano Point                 ',  '10S',  NULL,  NULL, NULL, 35.2, 0.18,      1, 111,     5,  7,  3, 0.43,  293,  3.6),
(7,50 , 'Control B Leinokano Point                 ',  '50S',  NULL,  NULL, NULL, 35.3, 0.30,  0.999, 100,     4,  5,  2, 0.21,  189,  3.7),
(7,100, 'Control B Leinokano Point                 ', '100S',  NULL,  NULL, NULL, 35.5, 0.28,  0.999, 122,     3,  4,  2, 0.23,  198,  3.3),
(7,500, 'Control B Leinokano Point                 ', '500S',  NULL,  NULL, NULL, 35.5, 0.14,  0.999, 105,     1,  8,  2, 0.14,   87,  3.2),           
(6,1  , 'ControlC 79-7401 Keauhou Kainaliu BeachRd' ,   '1S',  NULL,  NULL, NULL, 34.9, 0.32,      6, 138,    22,  8,  7, 3.24,  820,  7.2),
(6,10 , 'ControlC 79-7401 Keauhou Kainaliu BeachRd' ,  '10S',  NULL,  NULL, NULL, 35.1, 0.21,      9, 181,    56, 11, 10, 1.20, 1444,  3.6),
(6,50 , 'ControlC 79-7401 Keauhou Kainaliu BeachRd' ,  '50S',  NULL,  NULL, NULL, 35.2, 0.28,  0.499, 134,    24, 12,  7, 0.83,  780,  2.2),
(6,100, 'ControlC 79-7401 Keauhou Kainaliu BeachRd' , '100S',  NULL,  NULL, NULL, 35.5, 0.31,    0.6, 116,     9,  9,  4, 0.26,  333,  7.6),
(6,500, 'ControlC 79-7401 Keauhou Kainaliu BeachRd' , '500S',  NULL,  NULL, NULL, 35.4, 0.25,  0.499, 107,     2,  6,  2, 0.25,  102,  4.6),
(5,1  , 'ControlA PaaoaoBay NorthBoundary No Golf Course',   '1S',  NULL,  NULL, NULL, 35.0, 0.57,      4, 129,     7,  9,  6, 0.50,  216,  3.0),
(5,10 , 'ControlA PaaoaoBay NorthBoundary No Golf Course',  '10S',  NULL,  NULL, NULL, 35.2, 0.44,  0.999, 145,    15,  8,  7, 0.39,  328,  2.9),
(5,50 , 'ControlA PaaoaoBay NorthBoundary No Golf Course',  '50S',  NULL,  NULL, NULL, 35.4, 0.30,      1, 135,     4,  5,  3, 0.27,  309,  2.8),
(5,100, 'ControlA PaaoaoBay NorthBoundary No Golf Course', '100S',  NULL,  NULL, NULL, 35.5, 0.17,  0.999, 105,    14,  5,  2, 0.16,  142,  3.4),
(5,500, 'ControlA PaaoaoBay NorthBoundary No Golf Course', '500S',  NULL,  NULL, NULL, 35.4, 0.28,  0.999,  94,     1,  7,  2, 0.15,   75,  2.3),
(3,1  , 'Transect 3-NawaawaaBay Club at Hokulia adj',   '1S',  8.35,  27.7, 6.80, 34.2, 0.45,      5, 212,    87,  7,  6, 2.03,  926,  3.0),
(3,10 , 'Transect 3-NawaawaaBay Club at Hokulia adj',  '10S',  8.34,  27.8, 6.85, 33.6, 0.41,     10, 183,    97,  8,  7, 0.79, 1252,  3.2),
(3,50 , 'Transect 3-NawaawaaBay Club at Hokulia adj',  '50S',  8.35,  27.8, 6.95, 34.4, 0.36,      4, 146,    46,  7,  6, 0.36,  749,  3.7),
(3,100, 'Transect 3-NawaawaaBay Club at Hokulia adj', '100S',  8.28,  28.1, 6.70, 34.5, 0.36,      4, 158,    38,  7,  6, 0.21,  657,  3.1),
(3,500, 'Transect 3-NawaawaaBay Club at Hokulia adj', '500S',  8.26,  27.7, 6.80, 35.4, 0.23,      1, 136,     1,  7,  2, 0.10,   77,  2.8),
(2,1  , 'Control D - Kaawaloa -Offsite South'       ,   '1S',  NULL,  NULL, NULL, 35.4, 0.25,     10, 161,    28, 12,  8, 0.36,  107, 10.2),
(2,10 , 'Control D - Kaawaloa -Offsite South'       ,  '10S',  NULL,  NULL, NULL, 35.5, 0.51,  0.499, 125,     1,  6,  2, 0.28,   98,  7.7),
(2,50 , 'Control D - Kaawaloa -Offsite South'       ,  '50S',  NULL,  NULL, NULL, 35.5, 0.24,    0.6, 101, 0.999,  6,  2, 0.18,   72,  8.8),
(2,100, 'Control D - Kaawaloa -Offsite South'       , '100S',  NULL,  NULL, NULL, 35.5, 0.31,  0.499,  96, 0.999,  8,  2, 0.17,   79,  3.3),
(2,500, 'Control D - Kaawaloa -Offsite South'       , '500S',  NULL,  NULL, NULL, 35.6, 0.52,  0.499, 138, 0.999,  8,  4, 0.17,   86,  4.8),
(1,1  , 'Control E - Kealakakua Bay -Offsite South' ,   '1S',  NULL,  NULL, NULL, 30.2, 0.26,      3, 261,   190, 15, 14, 0.43, 2376,  4.6),
(1,10 , 'Control E - Kealakakua Bay -Offsite South' ,  '10S',  NULL,  NULL, NULL, 31.4, 0.28,      7, 350,   272, 13,  7, 0.28, 3223,  5.5),
(1,50 , 'Control E - Kealakakua Bay -Offsite South' ,  '50S',  NULL,  NULL, NULL, 33.4, 0.35,      2, 163,    75, 14,  8, 0.28,  827,  6.8),
(1,100, 'Control E - Kealakakua Bay -Offsite South' , '100S',  NULL,  NULL, NULL, 35.0, 0.20,      5, 281,   205, 16, 15, 0.33,  723,  4.1),
(1,500, 'Control E - Kealakakua Bay -Offsite South' , '500S',  NULL,  NULL, NULL, 35.3, 0.30,  0.499, 109,    26,  5,  3, 0.24,  103,  4.8)
-- 35 rows
select * from HokuliaTranscribedValues
/*
Transect	mShore	DocName	DocSName	pHyd6390	Temp6280	OxyD6270	Sali6350	Turb6260	Ammn6220	TDNi6210	NaNi6230	TPho6240	Pho06395	ChlA6250	Sili6360	Nate6393
1	1	Control E - Kealakakua Bay -Offsite South	1S	NULL	NULL	NULL	30.20000000	0.26000000	3.00000000	261.00000000	190.00000000	15.00000000	14.00000000	0.43000000	2376.00000000	4.60000000
1	10	Control E - Kealakakua Bay -Offsite South	10S	NULL	NULL	NULL	31.40000000	0.28000000	7.00000000	350.00000000	272.00000000	13.00000000	7.00000000	0.28000000	3223.00000000	5.50000000
1	50	Control E - Kealakakua Bay -Offsite South	50S	NULL	NULL	NULL	33.40000000	0.35000000	2.00000000	163.00000000	75.00000000	14.00000000	8.00000000	0.28000000	827.00000000	6.80000000
1	100	Control E - Kealakakua Bay -Offsite South	100S	NULL	NULL	NULL	35.00000000	0.20000000	5.00000000	281.00000000	205.00000000	16.00000000	15.00000000	0.33000000	723.00000000	4.10000000
1	500	Control E - Kealakakua Bay -Offsite South	500S	NULL	NULL	NULL	35.30000000	0.30000000	0.49900000	109.00000000	26.00000000	5.00000000	3.00000000	0.24000000	103.00000000	4.80000000
2	1	Control D - Kaawaloa -Offsite South	1S	NULL	NULL	NULL	35.40000000	0.25000000	10.00000000	161.00000000	28.00000000	12.00000000	8.00000000	0.36000000	107.00000000	10.20000000
2	10	Control D - Kaawaloa -Offsite South	10S	NULL	NULL	NULL	35.50000000	0.51000000	0.49900000	125.00000000	1.00000000	6.00000000	2.00000000	0.28000000	98.00000000	7.70000000
2	50	Control D - Kaawaloa -Offsite South	50S	NULL	NULL	NULL	35.50000000	0.24000000	0.60000000	101.00000000	0.99900000	6.00000000	2.00000000	0.18000000	72.00000000	8.80000000
2	100	Control D - Kaawaloa -Offsite South	100S	NULL	NULL	NULL	35.50000000	0.31000000	0.49900000	96.00000000	0.99900000	8.00000000	2.00000000	0.17000000	79.00000000	3.30000000
2	500	Control D - Kaawaloa -Offsite South	500S	NULL	NULL	NULL	35.60000000	0.52000000	0.49900000	138.00000000	0.99900000	8.00000000	4.00000000	0.17000000	86.00000000	4.80000000
3	1	Transect 3-NawaawaaBay Club at Hokulia adj	1S	8.35000000	27.70000000	6.80000000	34.20000000	0.45000000	5.00000000	212.00000000	87.00000000	7.00000000	6.00000000	2.03000000	926.00000000	3.00000000
3	10	Transect 3-NawaawaaBay Club at Hokulia adj	10S	8.34000000	27.80000000	6.85000000	33.60000000	0.41000000	10.00000000	183.00000000	97.00000000	8.00000000	7.00000000	0.79000000	1252.00000000	3.20000000
3	50	Transect 3-NawaawaaBay Club at Hokulia adj	50S	8.35000000	27.80000000	6.95000000	34.40000000	0.36000000	4.00000000	146.00000000	46.00000000	7.00000000	6.00000000	0.36000000	749.00000000	3.70000000
3	100	Transect 3-NawaawaaBay Club at Hokulia adj	100S	8.28000000	28.10000000	6.70000000	34.50000000	0.36000000	4.00000000	158.00000000	38.00000000	7.00000000	6.00000000	0.21000000	657.00000000	3.10000000
3	500	Transect 3-NawaawaaBay Club at Hokulia adj	500S	8.26000000	27.70000000	6.80000000	35.40000000	0.23000000	1.00000000	136.00000000	1.00000000	7.00000000	2.00000000	0.10000000	77.00000000	2.80000000
4	1	Transect 4-North Boundary JustNorthOfGolf	1S	8.23000000	27.60000000	6.90000000	35.20000000	0.23000000	2.00000000	129.00000000	4.00000000	5.00000000	1.00000000	0.27000000	96.00000000	1.80000000
4	10	Transect 4-North Boundary JustNorthOfGolf	10S	8.24000000	27.40000000	6.80000000	33.20000000	0.32000000	0.99900000	139.00000000	0.99990000	6.00000000	3.00000000	0.29000000	189.00000000	3.60000000
4	50	Transect 4-North Boundary JustNorthOfGolf	50S	8.23000000	27.80000000	6.82000000	35.50000000	0.19000000	1.00000000	153.00000000	2.00000000	8.00000000	4.00000000	0.20000000	145.00000000	2.30000000
4	100	Transect 4-North Boundary JustNorthOfGolf	100S	8.23000000	27.90000000	6.60000000	35.50000000	0.24000000	1.00000000	378.00000000	0.99990000	6.00000000	3.00000000	0.15000000	76.00000000	3.50000000
4	500	Transect 4-North Boundary JustNorthOfGolf	500S	8.23000000	27.90000000	6.59000000	35.50000000	0.22000000	1.00000000	68.00000000	6.00000000	6.00000000	3.00000000	0.14000000	70.00000000	2.30000000
5	1	ControlA PaaoaoBay NorthBoundary No Golf Course	1S	NULL	NULL	NULL	35.00000000	0.57000000	4.00000000	129.00000000	7.00000000	9.00000000	6.00000000	0.50000000	216.00000000	3.00000000
5	10	ControlA PaaoaoBay NorthBoundary No Golf Course	10S	NULL	NULL	NULL	35.20000000	0.44000000	0.99900000	145.00000000	15.00000000	8.00000000	7.00000000	0.39000000	328.00000000	2.90000000
5	50	ControlA PaaoaoBay NorthBoundary No Golf Course	50S	NULL	NULL	NULL	35.40000000	0.30000000	1.00000000	135.00000000	4.00000000	5.00000000	3.00000000	0.27000000	309.00000000	2.80000000
5	100	ControlA PaaoaoBay NorthBoundary No Golf Course	100S	NULL	NULL	NULL	35.50000000	0.17000000	0.99900000	105.00000000	14.00000000	5.00000000	2.00000000	0.16000000	142.00000000	3.40000000
5	500	ControlA PaaoaoBay NorthBoundary No Golf Course	500S	NULL	NULL	NULL	35.40000000	0.28000000	0.99900000	94.00000000	1.00000000	7.00000000	2.00000000	0.15000000	75.00000000	2.30000000
6	1	ControlC 79-7401 Keauhou Kainaliu BeachRd	1S	NULL	NULL	NULL	34.90000000	0.32000000	6.00000000	138.00000000	22.00000000	8.00000000	7.00000000	3.24000000	820.00000000	7.20000000
6	10	ControlC 79-7401 Keauhou Kainaliu BeachRd	10S	NULL	NULL	NULL	35.10000000	0.21000000	9.00000000	181.00000000	56.00000000	11.00000000	10.00000000	1.20000000	1444.00000000	3.60000000
6	50	ControlC 79-7401 Keauhou Kainaliu BeachRd	50S	NULL	NULL	NULL	35.20000000	0.28000000	0.49900000	134.00000000	24.00000000	12.00000000	7.00000000	0.83000000	780.00000000	2.20000000
6	100	ControlC 79-7401 Keauhou Kainaliu BeachRd	100S	NULL	NULL	NULL	35.50000000	0.31000000	0.60000000	116.00000000	9.00000000	9.00000000	4.00000000	0.26000000	333.00000000	7.60000000
6	500	ControlC 79-7401 Keauhou Kainaliu BeachRd	500S	NULL	NULL	NULL	35.40000000	0.25000000	0.49900000	107.00000000	2.00000000	6.00000000	2.00000000	0.25000000	102.00000000	4.60000000
7	1	Control B Leinokano Point                 	1S	NULL	NULL	NULL	35.10000000	0.23000000	0.99900000	112.00000000	5.00000000	5.00000000	3.00000000	0.45000000	351.00000000	2.20000000
7	10	Control B Leinokano Point                 	10S	NULL	NULL	NULL	35.20000000	0.18000000	1.00000000	111.00000000	5.00000000	7.00000000	3.00000000	0.43000000	293.00000000	3.60000000
7	50	Control B Leinokano Point                 	50S	NULL	NULL	NULL	35.30000000	0.30000000	0.99900000	100.00000000	4.00000000	5.00000000	2.00000000	0.21000000	189.00000000	3.70000000
7	100	Control B Leinokano Point                 	100S	NULL	NULL	NULL	35.50000000	0.28000000	0.99900000	122.00000000	3.00000000	4.00000000	2.00000000	0.23000000	198.00000000	3.30000000
7	500	Control B Leinokano Point                 	500S	NULL	NULL	NULL	35.50000000	0.14000000	0.99900000	105.00000000	1.00000000	8.00000000	2.00000000	0.14000000	87.00000000	3.20000000
*/

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-- select * from HokuliaRaw
-- DROP table HokuliaRaw

/* */
-- my working table
--   DROP TABLE HokuliaRaw
CREATE TABLE HokuliaRaw (
   Transect  [int]            NOT NULL, -- pk+
   mShore    [int]            NOT NULL, -- pk

   StartDate [datetime2](7)   NOT NULL,
   EndDate   [datetime2](7)   NOT NULL,

   DocName   [nvarchar](255)  NOT NULL,
   DocSName  [nvarchar](255)  NOT NULL,

   pHyd6390  [numeric](38, 8)     NULL,--1 only the first three have NULL values
   Temp6280  [numeric](38, 8)     NULL,
   OxyD6270  [numeric](38, 8)     NULL,
   Sali6350  [numeric](38, 8) NOT NULL,
   Turb6260  [numeric](38, 8) NOT NULL,--5

   Ammn6220  [numeric](38, 8) NOT NULL,
   TDNi6210  [numeric](38, 8) NOT NULL,
   NaNi6230  [numeric](38, 8) NOT NULL,
   TPho6240  [numeric](38, 8) NOT NULL,
   Pho06395  [numeric](38, 8) NOT NULL,--10

   ChlA6250  [numeric](38, 8) NOT NULL,
   Sili6360  [numeric](38, 8) NOT NULL,
   Nate6393  [numeric](38, 8) NOT NULL,--13
 
  -- new fields I added to needed to prepare for geodatbase and Esri
   MyCoreName      [nvarchar](255)        NULL,
   MyLabel         [nvarchar](255)        NULL,
   AnalyteList     [nvarchar](255)        NULL,

   MyLatLong       [nvarchar](255)        NULL,
   MyLatitude      [nvarchar](255)        NULL,
   POINT_Y         [numeric](38,8)        NULL,
   POINT_X         [numeric](38,8)        NULL,

   RawUniq         [uniqueidentifier] NOT NULL,

PRIMARY KEY (Transect,mShore)
)
--
--Select * from HokuliaRaw  
-- 


-----------------------------------------------------
-----------------------------------------------------
-----------------------------------------------------
--    delete from HokuliaRaw
--  INSERT INTO HokuliaRaw
SELECT 
Transect,
mShore,
CONVERT(datetime2, '2003-08-01 12:00:01 AM', 121), -- StartTime doc states activities happened mostly in Aug18,2003 but certain other
                                                   -- efforts were performed during the entire month
CONVERT(datetime2, '2003-08-31 10:00:00 PM', 121), -- EndTime
DocName,
DocSName,
--
pHyd6390,--1
Temp6280,
OxyD6270,
Sali6350,
Turb6260,--5
Ammn6220,
TDNi6210,
NaNi6230,
TPho6240,
Pho06395,--10
ChlA6250,
Sili6360,
Nate6393,--13
-- my fields
NULL,NULL,NULL,      -- MyCoreName, MyLabel, AnalyteList
NULL,NULL,NULL,NULL, -- location fields all null here, geocoded values will update to these
newid()

FROM HokuliaTranscribedValues
ORDER BY Transect,mShore
-- 35 rows copied
select * from HokuliaRaw
-- 35



/* development only
select sum(NaNi6230),avg(NaNi6230) from HokuliaRaw
-- 1254.99680000	35.85705142
select sum(Sali6350),avg(Sali6350) from HokuliaRaw
-- 1219.00000000	34.82857142
select Transect,mShore,Sali6350 from HokuliaRaw order by Transect,mShore
select sum(Ammn6220),avg(Ammn6220) from HokuliaRaw
-- 89.18600000	2.54817142
*/

---------------------------------------------
---------------------------------------------
---------------------------------------------
select distinct(Transect), mShore FROM HokuliaRaw GROUP BY Transect,mShore ORDER BY Transect,mShore
select distinct(Transect), DocName FROM HokuliaRaw GROUP BY Transect,DocName ORDER BY Transect,DocName

-- my geocoding effort for each of the stations
-- Control E - Kealakakua Bay -Offsite South
UPDATE HokuliaRaw SET POINT_Y=19.48120, POINT_X=-155.93320 WHERE Transect=1 AND mShore = 1
UPDATE HokuliaRaw SET POINT_Y=19.48118, POINT_X=-155.93310 WHERE Transect=1 AND mShore = 10
UPDATE HokuliaRaw SET POINT_Y=19.48110, POINT_X=-155.93273 WHERE Transect=1 AND mShore = 50
UPDATE HokuliaRaw SET POINT_Y=19.48101, POINT_X=-155.93228 WHERE Transect=1 AND mShore = 100
UPDATE HokuliaRaw SET POINT_Y=19.48014, POINT_X=-155.92790 WHERE Transect=1 AND mShore = 500
-- Control D - Kaawaloa -Offsite South
UPDATE HokuliaRaw SET POINT_Y=19.47328, POINT_X=-155.91940 WHERE Transect=2 AND mShore = 1
UPDATE HokuliaRaw SET POINT_Y=19.47327, POINT_X=-155.91949 WHERE Transect=2 AND mShore = 10
UPDATE HokuliaRaw SET POINT_Y=19.47318, POINT_X=-155.91986 WHERE Transect=2 AND mShore = 50
UPDATE HokuliaRaw SET POINT_Y=19.47307, POINT_X=-155.92032 WHERE Transect=2 AND mShore = 100
UPDATE HokuliaRaw SET POINT_Y=19.47221, POINT_X=-155.92403 WHERE Transect=2 AND mShore = 500

--
-- keep lat same on other transect since have no other info
UPDATE HokuliaRaw SET POINT_Y=19.50724   WHERE Transect=3              -- Transect 3-NawaawaaBay Club at Hokulia adj
UPDATE HokuliaRaw SET POINT_X=-155.95280 WHERE Transect=3 AND mShore = 1
UPDATE HokuliaRaw SET POINT_X=-155.95290 WHERE Transect=3 AND mShore = 10
UPDATE HokuliaRaw SET POINT_X=-155.95328 WHERE Transect=3 AND mShore = 50
UPDATE HokuliaRaw SET POINT_X=-155.95374 WHERE Transect=3 AND mShore = 100
UPDATE HokuliaRaw SET POINT_X=-155.95757 WHERE Transect=3 AND mShore = 500

UPDATE HokuliaRaw SET POINT_Y=19.52550   WHERE Transect=4              -- Transect 4-North Boundary JustNorthOfGolf              
UPDATE HokuliaRaw SET POINT_X=-155.95622 WHERE Transect=4 AND mShore = 1
UPDATE HokuliaRaw SET POINT_X=-155.95631 WHERE Transect=4 AND mShore = 10
UPDATE HokuliaRaw SET POINT_X=-155.95669 WHERE Transect=4 AND mShore = 50
UPDATE HokuliaRaw SET POINT_X=-155.95716 WHERE Transect=4 AND mShore = 100
UPDATE HokuliaRaw SET POINT_X=-155.96099 WHERE Transect=4 AND mShore = 500

UPDATE HokuliaRaw SET POINT_Y=19.53374   WHERE Transect=5              -- ControlA PaaoaoBay NorthBoundary No Golf Course
UPDATE HokuliaRaw SET POINT_X=-155.95702 WHERE Transect=5 AND mShore = 1
UPDATE HokuliaRaw SET POINT_X=-155.95712 WHERE Transect=5 AND mShore = 10
UPDATE HokuliaRaw SET POINT_X=-155.95749 WHERE Transect=5 AND mShore = 50
UPDATE HokuliaRaw SET POINT_X=-155.95760 WHERE Transect=5 AND mShore = 100
UPDATE HokuliaRaw SET POINT_X=-155.96178 WHERE Transect=5 AND mShore = 500

UPDATE HokuliaRaw SET POINT_Y=19.54382   WHERE Transect=6            -- Control C-Kuamoo Point at north boundary
UPDATE HokuliaRaw SET POINT_X=-155.9583  WHERE Transect=6 AND mShore = 1
UPDATE HokuliaRaw SET POINT_X=-155.95839 WHERE Transect=6 AND mShore = 10
UPDATE HokuliaRaw SET POINT_X=-155.95877 WHERE Transect=6 AND mShore = 50
UPDATE HokuliaRaw SET POINT_X=-155.95925 WHERE Transect=6 AND mShore = 100
UPDATE HokuliaRaw SET POINT_X=-155.96308 WHERE Transect=6 AND mShore = 500

UPDATE HokuliaRaw SET POINT_Y=19.5394   WHERE Transect=7              -- Control B Leinokano Point
UPDATE HokuliaRaw SET POINT_X=-155.95873 WHERE Transect=7 AND mShore = 1
UPDATE HokuliaRaw SET POINT_X=-155.95883 WHERE Transect=7 AND mShore = 10
UPDATE HokuliaRaw SET POINT_X=-155.95921 WHERE Transect=7 AND mShore = 50
UPDATE HokuliaRaw SET POINT_X=-155.95968 WHERE Transect=7 AND mShore = 100
UPDATE HokuliaRaw SET POINT_X=-155.9635  WHERE Transect=7 AND mShore = 500

select * from HokuliaRaw
/*
Transect	mShore	StartDate	EndDate	DocName	DocSName	pHyd6390	Temp6280	OxyD6270	Sali6350	Turb6260	Ammn6220	TDNi6210	NaNi6230	TPho6240	Pho06395	ChlA6250	Sili6360	Nate6393	MyCoreName	MyLabel	AnalyteList	MyLatLong	MyLatitude	POINT_X	POINT_Y	RawUniq
1	1	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	Control E - Kealakakua Bay -Offsite South	1S	NULL	NULL	NULL	30.20000000	0.26000000	3.00000000	261.00000000	190.00000000	15.00000000	14.00000000	0.43000000	2376.00000000	4.60000000	NULL	NULL	NULL	NULL	NULL	-155.9332	19.4812	87E08714-03EB-4755-8AC0-121C438923B1
1	10	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	Control E - Kealakakua Bay -Offsite South	10S	NULL	NULL	NULL	31.40000000	0.28000000	7.00000000	350.00000000	272.00000000	13.00000000	7.00000000	0.28000000	3223.00000000	5.50000000	NULL	NULL	NULL	NULL	NULL	-155.9331	19.48118	FA87EB3E-92F8-4E8C-94AC-16D71C2986F0
1	50	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	Control E - Kealakakua Bay -Offsite South	50S	NULL	NULL	NULL	33.40000000	0.35000000	2.00000000	163.00000000	75.00000000	14.00000000	8.00000000	0.28000000	827.00000000	6.80000000	NULL	NULL	NULL	NULL	NULL	-155.93273	19.4811	1111B09B-0B77-4DC1-9A0A-CB548606E78B
1	100	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	Control E - Kealakakua Bay -Offsite South	100S	NULL	NULL	NULL	35.00000000	0.20000000	5.00000000	281.00000000	205.00000000	16.00000000	15.00000000	0.33000000	723.00000000	4.10000000	NULL	NULL	NULL	NULL	NULL	-155.93228	19.48101	CA280C83-305E-44B9-A3A9-9DED36E705E8
1	500	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	Control E - Kealakakua Bay -Offsite South	500S	NULL	NULL	NULL	35.30000000	0.30000000	0.49900000	109.00000000	26.00000000	5.00000000	3.00000000	0.24000000	103.00000000	4.80000000	NULL	NULL	NULL	NULL	NULL	-155.9279	19.48014	E263E67F-B895-4D46-8D19-E49FFE7F6AB4
2	1	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	Control D - Kaawaloa -Offsite South	1S	NULL	NULL	NULL	35.40000000	0.25000000	10.00000000	161.00000000	28.00000000	12.00000000	8.00000000	0.36000000	107.00000000	10.20000000	NULL	NULL	NULL	NULL	NULL	-155.9194	19.47328	8170E1D1-18C9-4D79-80AC-A0DFBA6569DF
2	10	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	Control D - Kaawaloa -Offsite South	10S	NULL	NULL	NULL	35.50000000	0.51000000	0.49900000	125.00000000	1.00000000	6.00000000	2.00000000	0.28000000	98.00000000	7.70000000	NULL	NULL	NULL	NULL	NULL	-155.91949	19.47327	17216303-1909-4F60-99A5-7ED9F6BCBBB6
2	50	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	Control D - Kaawaloa -Offsite South	50S	NULL	NULL	NULL	35.50000000	0.24000000	0.60000000	101.00000000	0.99900000	6.00000000	2.00000000	0.18000000	72.00000000	8.80000000	NULL	NULL	NULL	NULL	NULL	-155.91986	19.47318	0B73C117-77D1-4278-AF6A-4E76C79AA201
2	100	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	Control D - Kaawaloa -Offsite South	100S	NULL	NULL	NULL	35.50000000	0.31000000	0.49900000	96.00000000	0.99900000	8.00000000	2.00000000	0.17000000	79.00000000	3.30000000	NULL	NULL	NULL	NULL	NULL	-155.92032	19.47307	30F5C4E8-6233-426A-94E4-555D280EEBD3
2	500	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	Control D - Kaawaloa -Offsite South	500S	NULL	NULL	NULL	35.60000000	0.52000000	0.49900000	138.00000000	0.99900000	8.00000000	4.00000000	0.17000000	86.00000000	4.80000000	NULL	NULL	NULL	NULL	NULL	-155.92403	19.47221	0ABF8669-7DEB-405D-96F0-04A3E08D7775
3	1	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	Transect 3-NawaawaaBay Club at Hokulia adj	1S	8.35000000	27.70000000	6.80000000	34.20000000	0.45000000	5.00000000	212.00000000	87.00000000	7.00000000	6.00000000	2.03000000	926.00000000	3.00000000	NULL	NULL	NULL	NULL	NULL	-155.9528	19.50724	1345076D-DD1A-4B37-B129-1AA30920282E
3	10	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	Transect 3-NawaawaaBay Club at Hokulia adj	10S	8.34000000	27.80000000	6.85000000	33.60000000	0.41000000	10.00000000	183.00000000	97.00000000	8.00000000	7.00000000	0.79000000	1252.00000000	3.20000000	NULL	NULL	NULL	NULL	NULL	-155.9529	19.50724	F9012484-64A0-499B-9348-DD3A20F15B23
3	50	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	Transect 3-NawaawaaBay Club at Hokulia adj	50S	8.35000000	27.80000000	6.95000000	34.40000000	0.36000000	4.00000000	146.00000000	46.00000000	7.00000000	6.00000000	0.36000000	749.00000000	3.70000000	NULL	NULL	NULL	NULL	NULL	-155.95328	19.50724	46466839-B199-4C9B-94BC-B3087A2D591A
3	100	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	Transect 3-NawaawaaBay Club at Hokulia adj	100S	8.28000000	28.10000000	6.70000000	34.50000000	0.36000000	4.00000000	158.00000000	38.00000000	7.00000000	6.00000000	0.21000000	657.00000000	3.10000000	NULL	NULL	NULL	NULL	NULL	-155.95374	19.50724	294BCB20-5F66-4423-A60B-62A6148A9C02
3	500	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	Transect 3-NawaawaaBay Club at Hokulia adj	500S	8.26000000	27.70000000	6.80000000	35.40000000	0.23000000	1.00000000	136.00000000	1.00000000	7.00000000	2.00000000	0.10000000	77.00000000	2.80000000	NULL	NULL	NULL	NULL	NULL	-155.95757	19.50724	93309D48-465C-45B8-9B4D-7032972F5D6E
4	1	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	Transect 4-North Boundary JustNorthOfGolf	1S	8.23000000	27.60000000	6.90000000	35.20000000	0.23000000	2.00000000	129.00000000	4.00000000	5.00000000	1.00000000	0.27000000	96.00000000	1.80000000	NULL	NULL	NULL	NULL	NULL	-155.95622	19.5255	F0CD6995-994E-4B39-BCCE-CBEAE03244A0
4	10	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	Transect 4-North Boundary JustNorthOfGolf	10S	8.24000000	27.40000000	6.80000000	33.20000000	0.32000000	0.99900000	139.00000000	0.99990000	6.00000000	3.00000000	0.29000000	189.00000000	3.60000000	NULL	NULL	NULL	NULL	NULL	-155.95631	19.5255	AA28E7CF-EC19-4011-AAD1-B704F4F3D09C
4	50	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	Transect 4-North Boundary JustNorthOfGolf	50S	8.23000000	27.80000000	6.82000000	35.50000000	0.19000000	1.00000000	153.00000000	2.00000000	8.00000000	4.00000000	0.20000000	145.00000000	2.30000000	NULL	NULL	NULL	NULL	NULL	-155.95669	19.5255	2A40AC06-62AD-4C41-82D9-8426FB150361
4	100	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	Transect 4-North Boundary JustNorthOfGolf	100S	8.23000000	27.90000000	6.60000000	35.50000000	0.24000000	1.00000000	378.00000000	0.99990000	6.00000000	3.00000000	0.15000000	76.00000000	3.50000000	NULL	NULL	NULL	NULL	NULL	-155.95716	19.5255	59DB2C0B-0097-49D8-8965-5A8CBF9BF7EE
4	500	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	Transect 4-North Boundary JustNorthOfGolf	500S	8.23000000	27.90000000	6.59000000	35.50000000	0.22000000	1.00000000	68.00000000	6.00000000	6.00000000	3.00000000	0.14000000	70.00000000	2.30000000	NULL	NULL	NULL	NULL	NULL	-155.96099	19.5255	725B312C-91FE-4187-8D97-AA179A0082B2
5	1	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	ControlA PaaoaoBay NorthBoundary No Golf Course	1S	NULL	NULL	NULL	35.00000000	0.57000000	4.00000000	129.00000000	7.00000000	9.00000000	6.00000000	0.50000000	216.00000000	3.00000000	NULL	NULL	NULL	NULL	NULL	-155.95702	19.53374	BE3ADEDC-8F84-47E7-824A-88904230FEFC
5	10	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	ControlA PaaoaoBay NorthBoundary No Golf Course	10S	NULL	NULL	NULL	35.20000000	0.44000000	0.99900000	145.00000000	15.00000000	8.00000000	7.00000000	0.39000000	328.00000000	2.90000000	NULL	NULL	NULL	NULL	NULL	-155.95712	19.53374	2A2D20B3-5B2B-4DD8-82D7-03C4C1A6653D
5	50	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	ControlA PaaoaoBay NorthBoundary No Golf Course	50S	NULL	NULL	NULL	35.40000000	0.30000000	1.00000000	135.00000000	4.00000000	5.00000000	3.00000000	0.27000000	309.00000000	2.80000000	NULL	NULL	NULL	NULL	NULL	-155.95749	19.53374	DF3E4747-5207-4DF7-BDE7-9A094666247D
5	100	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	ControlA PaaoaoBay NorthBoundary No Golf Course	100S	NULL	NULL	NULL	35.50000000	0.17000000	0.99900000	105.00000000	14.00000000	5.00000000	2.00000000	0.16000000	142.00000000	3.40000000	NULL	NULL	NULL	NULL	NULL	-155.9576	19.53374	F20D387E-F6F6-4C61-B021-8A0B63FFCEAD
5	500	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	ControlA PaaoaoBay NorthBoundary No Golf Course	500S	NULL	NULL	NULL	35.40000000	0.28000000	0.99900000	94.00000000	1.00000000	7.00000000	2.00000000	0.15000000	75.00000000	2.30000000	NULL	NULL	NULL	NULL	NULL	-155.96178	19.53374	B3962DDA-06B4-455F-957F-584DF54ED1AA
6	1	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	ControlC 79-7401 Keauhou Kainaliu BeachRd	1S	NULL	NULL	NULL	34.90000000	0.32000000	6.00000000	138.00000000	22.00000000	8.00000000	7.00000000	3.24000000	820.00000000	7.20000000	NULL	NULL	NULL	NULL	NULL	-155.9583	19.54382	60F769FC-EE88-4218-8A34-658123B4551B
6	10	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	ControlC 79-7401 Keauhou Kainaliu BeachRd	10S	NULL	NULL	NULL	35.10000000	0.21000000	9.00000000	181.00000000	56.00000000	11.00000000	10.00000000	1.20000000	1444.00000000	3.60000000	NULL	NULL	NULL	NULL	NULL	-155.95839	19.54382	E72259FC-F5C7-4E1E-9FB7-6C0D72DF2BF6
6	50	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	ControlC 79-7401 Keauhou Kainaliu BeachRd	50S	NULL	NULL	NULL	35.20000000	0.28000000	0.49900000	134.00000000	24.00000000	12.00000000	7.00000000	0.83000000	780.00000000	2.20000000	NULL	NULL	NULL	NULL	NULL	-155.95877	19.54382	17B5264A-9CF1-4898-BD7B-B0895F7FEE81
6	100	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	ControlC 79-7401 Keauhou Kainaliu BeachRd	100S	NULL	NULL	NULL	35.50000000	0.31000000	0.60000000	116.00000000	9.00000000	9.00000000	4.00000000	0.26000000	333.00000000	7.60000000	NULL	NULL	NULL	NULL	NULL	-155.95925	19.54382	735DE610-B85E-4A51-9E0D-1E465C518026
6	500	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	ControlC 79-7401 Keauhou Kainaliu BeachRd	500S	NULL	NULL	NULL	35.40000000	0.25000000	0.49900000	107.00000000	2.00000000	6.00000000	2.00000000	0.25000000	102.00000000	4.60000000	NULL	NULL	NULL	NULL	NULL	-155.96308	19.54382	3FC01543-6465-4FD7-87AD-95432E6473BF
7	1	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	Control B Leinokano Point                 	1S	NULL	NULL	NULL	35.10000000	0.23000000	0.99900000	112.00000000	5.00000000	5.00000000	3.00000000	0.45000000	351.00000000	2.20000000	NULL	NULL	NULL	NULL	NULL	-155.95873	19.5394	A2AB9BA1-DAE0-41F1-AC26-32113F74E485
7	10	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	Control B Leinokano Point                 	10S	NULL	NULL	NULL	35.20000000	0.18000000	1.00000000	111.00000000	5.00000000	7.00000000	3.00000000	0.43000000	293.00000000	3.60000000	NULL	NULL	NULL	NULL	NULL	-155.95883	19.5394	4B770067-C9B7-486A-A281-4F4B877CD738
7	50	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	Control B Leinokano Point                 	50S	NULL	NULL	NULL	35.30000000	0.30000000	0.99900000	100.00000000	4.00000000	5.00000000	2.00000000	0.21000000	189.00000000	3.70000000	NULL	NULL	NULL	NULL	NULL	-155.95921	19.5394	70C6AD52-F0CC-494C-AE95-71577726A39D
7	100	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	Control B Leinokano Point                 	100S	NULL	NULL	NULL	35.50000000	0.28000000	0.99900000	122.00000000	3.00000000	4.00000000	2.00000000	0.23000000	198.00000000	3.30000000	NULL	NULL	NULL	NULL	NULL	-155.95968	19.5394	3DF0A72D-B974-47B3-ACEA-999A3B0D95CD
7	500	2003-08-01 09:00:00.0000000	2003-08-31 09:00:00.0000000	Control B Leinokano Point                 	500S	NULL	NULL	NULL	35.50000000	0.14000000	0.99900000	105.00000000	1.00000000	8.00000000	2.00000000	0.14000000	87.00000000	3.20000000	NULL	NULL	NULL	NULL	NULL	-155.9635	19.5394	689F9148-AD7F-4777-B7A5-2C4661B30836
*/
---------------------------------------------------
---------------------------------------------------
---------------------------------------------------
--
-- put together lat/long fields now that have POINTs


/* make our fields for later insertions into our tables */
--
UPDATE HokuliaRaw SET
MyLatLong  = str(POINT_Y, 7, 4) + ' , ' + str(POINT_X, 9, 4),
MyLatitude = CAST( REPLACE( str( CAST(POINT_Y AS DECIMAL (7,4)),7,4),'.','_') AS varchar)
-- 35
select * from HokuliaRaw

-- will use text created above in the transcribed data since I had resolved some details about the location
-- of the transects beyond what the documentation said. I used Google maps and MyMaps to get details
UPDATE HokuliaRaw SET MyLabel = DocName
-- 35

-- 
-- now the final name assembly
/*
Transect	mShore	DocName	DocSName	pHyd6390	Temp6280	OxyD6270	Sali6350	Turb6260	Ammn6220	TDNi6210	NaNi6230	TPho6240	Pho06395	ChlA6250	Sili6360	Nate6393
Hokulia_DZiemann_
YAug2003
pHyd6390Temp6280OxyD6270Sali6350Turb6260Ammn6220TDNi6210NaNi6230TPho6240Pho06395ChlA6250Sili6360Nate6393
OxyD6270Sali6350Turb6260Ammn6220TDNi6210NaNi6230TPho6240Pho06395ChlA6250Sili6360Nate6393

*/

-- analyte list determined simply by looking at data, pHyd6390Temp6280 are missing in other than tr3&4
UPDATE HokuliaRaw SET
AnalyteList = 'ResultspHyd6390Temp6280OxyD6270Sali6350Turb6260Ammn6220TDNi6210NaNi6230TPho6240Pho06395ChlA6250Sili6360Nate6393'
FROM HokuliaRaw
WHERE Transect IN (3,4)
-- 10
UPDATE HokuliaRaw SET
AnalyteList = 'ResultsOxyD6270Sali6350Turb6260Ammn6220TDNi6210NaNi6230TPho6240Pho06395ChlA6250Sili6360Nate6393'
FROM HokuliaRaw
WHERE Transect NOT IN (3,4)
-- 25

-- make core name 
UPDATE HokuliaRaw SET MyCoreName = 
   MyLatitude + '_' +
   RIGHT('000'+LTRIM(str(mShore)),3) + 'm' + -- 001m,010m,050m,100m or 500m at Hokulia
   '_Hokulia' + '_' + 
   MyLabel    + '_DZiemannKKlein_' + 
   'Transect' + str(Transect,1)
FROM HokuliaRaw
--
UPDATE HokuliaRaw SET MyCoreName = REPLACE(REPLACE(MyCoreName, ' ',''),'-','')
--
select MyCoreName from HokuliaRaw


-- make the dates unique by adding a few seconds
DECLARE @RawUniq uniqueidentifier, @StartDate datetime2, @EndDate datetime2, @RowCount integer=0
DECLARE @cursorInsert CURSOR SET @cursorInsert = CURSOR FOR
   SELECT RawUniq, StartDate, EndDate FROM HokuliaRaw
OPEN @cursorInsert
FETCH NEXT FROM @cursorInsert INTO @RawUniq, @StartDate, @EndDate
--
WHILE @@FETCH_STATUS = 0
   BEGIN
   set @RowCount = @RowCount + 1
   --select @pkSample,@RowCount FROM HokuliaTBSample
   UPDATE HokuliaRaw 
   SET StartDate = DATEADD(ss,@RowCount,StartDate),EndDate = DATEADD(ss,@RowCount,EndDate)
   WHERE HokuliaRaw.RawUniq IN (SELECT @RawUniq  FROM HokuliaRaw)
   FETCH NEXT FROM @cursorInsert INTO @RawUniq, @StartDate, @EndDate
   END
CLOSE @cursorInsert
DEALLOCATE @cursorInsert
--
select StartDate,EndDate from HokuliaRaw




--select MyCoreName,AnalyteList from HokuliaRaw
select * from HokuliaRaw
-- 35
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--   DROP TABLE [dbo].[HokuliaFCStation]
CREATE TABLE [dbo].[HokuliaFCStation] (
	[pkStation] [nvarchar](255) NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
	[TablePage] [nvarchar](255) NULL,
	[fkStation1] [nvarchar](255) NULL,
	[fkStation2] [nvarchar](255) NULL,
	[mShore] [int] NULL,
	[dmStA] [int] NOT NULL,
	[dmStAA] [int] NOT NULL,
	[dmStBott] [int] NULL,
	[dmStClas] [int] NOT NULL,
	[dmAccuracy] [int] NOT NULL,
	[dmStReef] [int] NULL,
	[dmStRule] [int] NOT NULL,
	[dmStType] [int] NOT NULL,
	[fkEPA] [nvarchar](255) NULL,
	[fkUSGS] [nvarchar](255) NULL,
	[Embayment] [nvarchar](255) NULL,
	[VolumeBay] [numeric](38, 8) NULL,
	[CrossArea] [numeric](38, 8) NULL,
	[AttachSt] [int] NULL,
	[HICWBTier] [int] NULL,
	[dmAccu4610] [nvarchar](255) NULL,
	[dmAccu4620] [nvarchar](255) NULL,
	[dmAccu4630] [nvarchar](255) NULL,
	[dmAccu4640] [nvarchar](255) NULL,
	[dmAccu4650] [nvarchar](255) NULL,
	[dmAccu4660] [nvarchar](255) NULL,
	[dmAccu4670] [nvarchar](255) NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NOT NULL,
	[StFloat1] [numeric](38, 8) NULL,
	[StFloat2] [numeric](38, 8) NULL,
	[StDate3] [datetime2](7) NULL,
	[StDate4] [datetime2](7) NULL,
	[StLong5] [int] NULL,
--
	[XField] [numeric](38, 8)    NOT NULL, -- Longtitude
	[YField] [numeric](38, 8)    NOT NULL, -- Latitude
--
	[Rotation]   [int]           NOT NULL,
	[Normalize]  [int]           NOT NULL,
	[Weight]     [int]           NOT NULL,
	[PageQuery]  [int]                NULL,
	[PageQueryS] [nvarchar](255)     NULL,
--
	[GeoUniq] [uniqueidentifier]  NOT NULL,
	[StatUniq] [uniqueidentifier] NOT NULL,
	[RawUniq] [uniqueidentifier]  NOT NULL,

 PRIMARY KEY (pkStation)
 ) 

-- 
-- FCStation is populated from HokuliaRaw and the names/location information I have assembled
--  DELETE from HokuliaFCStation
INSERT INTO HokuliaFCStation SELECT 
MyCoreName,  -- pkStation
MyLabel,     -- Label
DocName,     -- TablePage
DocSName,    -- fkStation1 
Transect,    -- fkStation2
mShore,
3499,6499,3799,      -- dmStA, dmStAA, dmStBott  the n/a value for these domains
7110,                -- dmStClas not applicable value
4650,                -- dmAccuracy from Google MyMaps geocoding
8855,7777,           -- dmReef, dmRule  not applicable values
700,                 -- dmStType Environment Impact Report
NULL,NULL,         
'No',                -- not a embayment
NULL,NULL,
REPLACE(MyLatitude,'_',''),  -- AttachSt is latitude as int number
NULL,NULL,NULL,NULL,NULL,    -- no GPS coordinates supplied, so all these NULL to track geocoding
MyLatLong,                   -- dmAccu4650 my Google geocode effort
NULL,NULL,
CAST(StartDate as datetime), CAST(EndDate as datetime), -- startDate and EndDate is set as entire month of Aug2003
NULL,NULL,NULL,NULL,NULL,    -- 5 extra fields
POINT_X,POINT_Y,             -- XField, YField
--
ROW_NUMBER() OVER(ORDER BY POINT_Y ASC)%2, -- Rotation
0,                           -- Normalize
0,                           -- Weight
0,NULL,                      -- PageQueryI/S
--

newid(),                     -- GeoUniq set only since can't set to null on table create
newid(),                     -- StatUniq is assigned here when making a new record
RawUniq                      -- tracer backwards
FROM HokuliaRaw
ORDER BY MyCoreName 
-- 35
select * from HokuliaFCStation
--35

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- FCStation complete and many preparations compete, move to insert data from HokuliaRaw and other tables
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- Now work on the TBSample table
-- the pkSample name pieces are available to include fully formed names
-- there are xx sample, with up to 7 analytes recorded per sample

--  DROP TABLE HokuliaTBSample
CREATE TABLE HokuliaTBSample (
	--[OBJECTID] [int] NOT NULL,

	[pkSample] [nvarchar](255) NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
	[TablePage] [nvarchar](255) NULL,
	[AlertTrue] [int] NULL,
	[fkIDLoc] [nvarchar](255) NOT NULL,
	[Transect] [int] NULL,
	[mShore] [int] NULL,
	[fkStation] [nvarchar](255) NOT NULL,
	[fkStation2] [nvarchar](255) NULL,
	[fkProject] [nvarchar](255) NOT NULL,
	[fkUnqID] [nvarchar](255) NOT NULL,
	[fkOrg] [nvarchar](255) NOT NULL,
	[dmSample] [int] NOT NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NOT NULL,
	[TimeMissg] [nvarchar](255) NULL,
	[Medium] [nvarchar](255) NULL,
	[CompStat] [nvarchar](255) NULL,
	[Comment] [nvarchar](255) NULL,
	[AttachSa] [int] NULL,
	[SaFloat1] [numeric](38, 8) NULL,
	[SaFloat2] [numeric](38, 8) NULL,
	[SaDate3] [datetime2](7) NULL,
	[SaDate4] [datetime2](7) NULL,
	[SaLong5] [int] NULL,
	[Rotation] [int] NOT NULL,
	[Normalize] [int] NOT NULL,
	[Weight] [int] NOT NULL,
	[PageQuery] [int] NOT NULL,
	[PageQueryS] [nvarchar](255) NULL,
	[SampUniq] [uniqueidentifier] NULL,
	[RawUniq] [uniqueidentifier] NULL,

PRIMARY KEY (pkSample)
)
GO

select * from HokuliaRaw

--    DELETE FROM HokuliaTBSample
--  INSERT INTO HokuliaTBSample
SELECT 
MyCoreName + '_' + AnalyteList,  -- pkSample
MyLabel,                 -- LabelName
DocName,                 -- TablePage 
0,                       -- AlertTrue
'DZiemann',              -- fkIDLoc
Transect,                -- Transect
mShore,                  -- mShore
MyCoreName,              -- pkStation, same as FCStation code
DocSName,                -- fkStation2, station as known to Hokulia
'DZiemann',              -- fkProject
newid(),                 -- fkUniqID is the new if generated in this new row creation of the insert
'<<fkOrg>>',             -- *** GET ****
1420,                    -- dmSample, laboratory
StartDate, 
EndDate,                 -- 
'Yes',                   -- TimeMissg field
NULL,NULL,               -- Medium, CompStat
NULL,                    -- no Comment yet
REPLACE(MyLatitude,'_',''), -- attach code
NULL,NULL,NULL,NULL,NULL,   -- 5 extras
0,0,0,1,NULL,               -- cartography fields
newid(),
RawUniq                     -- important for tracing to save source row id
FROM HokuliaRaw
ORDER BY (MyCoreName + '_' + AnalyteList)
-- 35 rows affected
select * from HokuliaTBSample
-- 35
-----------------------
-----------------------




/*
-- inner join should be all, outer join should be none as pkStation and fkStation must match, no nulls allowed
select A_sta.*, B_samp.*
from HokuliaFCStation A_sta
INNER JOIN HokuliaTBSample B_samp ON
A_sta.pkStation = B_samp.fkStation
-- 35
select A_sta.*, B_samp.*
from HokuliaFCStation A_sta
full outer JOIN HokuliaTBSample B_samp ON
A_sta.pkStation = B_samp.fkStation
WHERE A_sta.pkStation IS NULL OR B_samp.fkStation IS NULL
-- 0
*/
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- move to populate HokuliaTBResult

--  DROP TABLE HokuliaTBResult
CREATE TABLE HokuliaTBResult (
	--[OBJECTID] [int] NOT NULL,

	[fkSample] [nvarchar](255) NOT NULL,
	[Label] [nvarchar](255)    NOT NULL,
	[fkIDLoc] [nvarchar](255) NOT NULL,
	[fkUnqID] [nvarchar](255) NOT NULL,
	[Result] [numeric](38, 8) NOT NULL,
	[Stddev] [numeric](38, 8) NULL,
	[dmRAll] [int] NOT NULL,
	[dmRAMeth] [int] NOT NULL,
	[dmR11546] [int] NOT NULL,
	[dmRAnlyt] [int] NOT NULL,
	[dmRBEACH] [int] NOT NULL,
	[Grade] [nvarchar](255) NULL,
	[Comments] [nvarchar](255) NULL,
	[AttachR] [int] NULL,
	[RFloat1] [numeric](38, 8) NULL,
	[RFloat2] [numeric](38, 8) NULL,
	[RDate3] [datetime2](7) NULL,
	[RDate4] [datetime2](7) NULL,
	[RLong5] [int] NULL,
	[RawUniq] [uniqueidentifier] NULL,
	[ResUniq] [uniqueidentifier] NULL,
	[SampUniq] [uniqueidentifier] NULL

  PRIMARY KEY (fkSample,dmRAll)-- per my schema in gdb
)
GO


-- designed to run from here, grab entire set of next 10 TBResult inserts and exec
--  delete from HokuliaTBResult
--------------------------------------------------------------------------------
 -- 1/12  
 INSERT INTO HokuliaTBResult
SELECT 
samp.pkSample,
'pHyd6390 - pH',
samp.fkIDLoc,
samp.fkUnqID,
pHyd6390,
NULL,-- Stddev
6390,--dmRAll
6465,--dmRAMethod
6310,--dmR11546
6390,--dmRAnlyt
6499,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM HokuliaRaw raw
INNER JOIN HokuliaTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and pHyd6390 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 10
--------------------------------------------------------------------------------
--2
INSERT INTO HokuliaTBResult
SELECT 
samp.pkSample,
'Temp6280 - Temperature C',
samp.fkIDLoc,
samp.fkUnqID,
Temp6280,
NULL,-- Stddev
6280,--dmRAll
6465,--dmRAMethod
6280,--dmR11546
6399,--dmRAnlyt
6499,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM HokuliaRaw raw
INNER JOIN HokuliaTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and Temp6280 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 10
--------------------------------------------------------------------------------
--3
INSERT INTO HokuliaTBResult
SELECT 
samp.pkSample,
'OxyD6270 - Dissolved Oxygen',
samp.fkIDLoc,
samp.fkUnqID,
OxyD6270,
NULL,-- Stddev
6270,--dmRAll
6465,--dmRAMethod
6270,--dmR11546
6399,--dmRAnlyt
6499,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM HokuliaRaw raw
INNER JOIN HokuliaTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and OxyD6270 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 10
--------------------------------------------------------------------------------
--4
INSERT INTO HokuliaTBResult
SELECT 
samp.pkSample,
'Sali6350 - Salinity',
samp.fkIDLoc,
samp.fkUnqID,
Sali6350,
NULL,-- Stddev
6350,--dmRAll
6465,--dmRAMethod
6310,--dmR11546
6350,--dmRAnlyt
6499,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM HokuliaRaw raw
INNER JOIN HokuliaTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and Sali6350 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 35
select * from HokuliaTBResult order by dmRAll

--------------------------------------------------------------------------------
--5
INSERT INTO HokuliaTBResult
SELECT 
samp.pkSample,
'Turb6260 - Turbidity',
samp.fkIDLoc,
samp.fkUnqID,
Turb6260,
NULL,-- Stddev
6260,--dmRAll
6465,--dmRAMethod
6260,--dmR11546
6350,--dmRAnlyt
6499,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM HokuliaRaw raw
INNER JOIN HokuliaTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and Turb6260 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 35
--------------------------------------------------------------------------------
--6
INSERT INTO HokuliaTBResult
SELECT 
samp.pkSample,
'AmmN6220 - Ammonia Nitrogen',
samp.fkIDLoc,
samp.fkUnqID,
AmmN6220,
NULL,-- Stddev
6220,--dmRAll
6465,--dmRAMethod
6220,--dmR11546
6399,--dmRAnlyt
6499,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM HokuliaRaw raw
INNER JOIN HokuliaTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and AmmN6220 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 35
--------------------------------------------------------------------------------
--6
INSERT INTO HokuliaTBResult
SELECT 
samp.pkSample,
'TDNi6210 - Total Nitrogen',
samp.fkIDLoc,
samp.fkUnqID,
TDNi6210,
NULL,-- Stddev
6210,--dmRAll
6465,--dmRAMethod
6210,--dmR11546
6399,--dmRAnlyt
6499,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM HokuliaRaw raw
INNER JOIN HokuliaTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and TDNi6210 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 35
--------------------------------------------------------------------------------
--7
INSERT INTO HokuliaTBResult
SELECT 
samp.pkSample,
'NaNi6230 - Nitrate+Nitrite Nitrogen',
samp.fkIDLoc,
samp.fkUnqID,
NaNi6230,
NULL,-- Stddev
6230,--dmRAll
6465,--dmRAMethod
6230,--dmR11546
6399,--dmRAnlyt
6499,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM HokuliaRaw raw
INNER JOIN HokuliaTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and NaNi6230 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 35
--------------------------------------------------------------------------------
--8
INSERT INTO HokuliaTBResult
SELECT 
samp.pkSample,
'TPho6240 - Total Phosphorus',
samp.fkIDLoc,
samp.fkUnqID,
TPho6240,
NULL,-- Stddev
6240,--dmRAll
6465,--dmRAMethod
6240,--dmR11546
6399,--dmRAnlyt
6499,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM HokuliaRaw raw
INNER JOIN HokuliaTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and TPho6240 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 35
select sum(TPho6240) FROM HokuliaRaw raw
WHERE raw.TPho6240 IS NOT NULL
select sum(Result) FROM HokuliaTBResult
WHERE dmRall = 6240
-- 279.00000000 both
--------------------------------------------------------------------------------
--9
INSERT INTO HokuliaTBResult
SELECT 
samp.pkSample,
'Pho06395 - 0-Phosphate',
samp.fkIDLoc,
samp.fkUnqID,
Pho06395,
NULL,-- Stddev
6395,--dmRAll
6465,--dmRAMethod
6310,--dmR11546
6395,--dmRAnlyt
6499,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM HokuliaRaw raw
INNER JOIN HokuliaTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and Pho06395 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 35
--------------------------------------------------------------------------------
--10
INSERT INTO HokuliaTBResult
SELECT 
samp.pkSample,
'ChlA6250 - Chlorophyll a',
samp.fkIDLoc,
samp.fkUnqID,
ChlA6250,
NULL,-- Stddev
6250,--dmRAll
6465,--dmRAMethod
6250,--dmR11546
6399,--dmRAnlyt
6499,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM HokuliaRaw raw
INNER JOIN HokuliaTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and ChlA6250 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 35
--------------------------------------------------------------------------------
--11
INSERT INTO HokuliaTBResult
SELECT 
samp.pkSample,
'Sili6360 - Silicates',
samp.fkIDLoc,
samp.fkUnqID,
Sili6360,
NULL,-- Stddev
6360,--dmRAll
6465,--dmRAMethod
6310,--dmR11546
6350,--dmRAnlyt
6499,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM HokuliaRaw raw
INNER JOIN HokuliaTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and Sili6360 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 35
--------------------------------------------------------------------------------
--12
INSERT INTO HokuliaTBResult
SELECT 
samp.pkSample,
'Nate6393 - NO3',
samp.fkIDLoc,
samp.fkUnqID,
Nate6393,
NULL,-- Stddev
6393,--dmRAll
6465,--dmRAMethod
6310,--dmR11546
6393,--dmRAnlyt
6499,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM HokuliaRaw raw
INNER JOIN HokuliaTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and Nate6393 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 35


select * from HokuliaTBResult
-- 380 rows

-- V1 thesis map displays
SELECT Count(*) as 'TBResult Count' FROM HokuliaTBResult
SELECT Label, Count(dmRAll) as 'TBResult rows' FROM HokuliaTBResult GROUP by Label, dmRAll ORDER by 2 DESC


-- V2 thesis map displays
SELECT 'Hokulia Aug2003' as 'D.Ziemann', Count(*) as 'TBResult #rows' FROM HokuliaTBResult;
SELECT Label, Count(dmRAll) as '#rows', round(exp(avg(log(Result))),3) as '~gmean', round(stdev(Result),2) as 'stdev',cast(min(Result) as decimal (10,2)) 
as 'min',cast(max(Result) as decimal (10,2)) as 'max' FROM HokuliaTBResult 
WHERE Result<>0 GROUP by Label, dmRAll

--------------------------------------------------------------------------------

--/* development only
select sum(NaNi6230),avg(NaNi6230) from HokuliaRaw
-- 1254.99680000	35.85705142
select sum(Result),avg(Result) from HokuliaTBResult WHERE dmRAll = 6230 -- NaNi6230
-- 1254.99680000	35.85705142

select count(*),sum(Sali6350),avg(Sali6350) from HokuliaRaw WHERE Sali6350 IS NOT NULL
select Transect,mShore,Sali6350 from HokuliaRaw WHERE Sali6350 IS NOT NULL ORDER BY Transect,mShore
-- 35   1219.00000000	34.82857142
select count(Result),sum(Result),avg(Result) from HokuliaTBResult WHERE dmRAll = 6350 -- Sali6350
-- 35	1219.00000000	34.82857142

select sum(Ammn6220),avg(Ammn6220) from HokuliaRaw
-- 89.18600000	2.54817142
select sum(Result),avg(Result) from HokuliaTBResult WHERE dmRAll = 6220 -- Ammn6220
-- 89.18600000	2.54817142
--*/

SELECT 
   SUM(pHyd6390) +
   SUM(Temp6280) + 
   SUM(OxyD6270) + 
   SUM(Sali6350) + 
   SUM(Turb6260) + 
   SUM(Ammn6220) + 
   SUM(TDNi6210) + 
   SUM(NaNi6230) + 
   SUM(TPho6240) + 
   SUM(Pho06395) +
   SUM(ChlA6250) + 
   SUM(Sili6360) + 
   SUM(Nate6393) FROM HokuliaRaw
 --26529.39280000
SELECT SUM(Result) FROM HokuliaTBResult
-- 26529.39280000

*/


-- select * from HokuliaTBResult order by dmRAll
SELECT COUNT(*) FROM HokuliaTBResult
-- 380 rows 3*10 + 10*35 = 380
SELECT * FROM HokuliaTBResult

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
select r.*, s.* 
From HokuliaTBResult r
inner join HokuliaTBSample  s
ON r.fkUnqID = s.fkUnqID
-- 380
select s.*, r.* 
From HokuliaTBSample s
inner join  HokuliaTBResult r
ON s.fkUnqID = r.fkUnqID
-- 380 as expect for inner join

select r.*, s.* 
From HokuliaTBResult r
left join HokuliaTBSample  s
ON r.fkUnqID = s.fkUnqID
-- 380

--select pkSample, fkSample, r.label
select s.*,r.*
From HokuliaTBSample s
left join  HokuliaTBResult r
ON r.fkUnqID = NULL
-- must be 35 DON LOOK
select * from HokuliaTBResult where fkUnqID is null
--0
select * from HokuliaTBSample where fkUnqID is null
--0
select count(*) from HokuliaTBSample
--35
select count(*) from HokuliaTBResult
--380

select r.*, s.* 
From HokuliaTBResult r
right join HokuliaTBSample  s
ON r.fkUnqID = s.fkUnqID
-- 380
select pkSample, fkSample, r.label
From HokuliaTBSample s
right join  HokuliaTBResult r
ON s.fkUnqID = NULL
-- 380

select r.*, s.* 
From HokuliaTBResult r
full outer join HokuliaTBSample  s
ON r.fkUnqID = s.fkUnqID
-- 380
select s.*, r.* 
From HokuliaTBSample s
full outer join  HokuliaTBResult r
ON s.fkUnqID = r.fkUnqID
-- 380

----
select r.*, s.* 
From HokuliaTBResult r
full outer join HokuliaTBSample  s
ON s.fkUnqID = r.fkUnqID
WHERE r.fkUnqID IS NULL OR s.fkUnqID IS NULL
-- 0
select s.*, r.* 
From HokuliaTBSample s
full outer join  HokuliaTBResult r
ON s.fkUnqID = r.fkUnqID
WHERE s.fkUnqID IS NULL OR r.fkUnqID IS NULL
-- 0
