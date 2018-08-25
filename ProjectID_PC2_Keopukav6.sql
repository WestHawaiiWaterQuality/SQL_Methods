-- create script for Keopuka EIS
-- last update 04/7/2018

use whwq4
-

/*
FileName: 'PDR3 2000-07-23-HA-DEIS-KEOPUKA- Water qual appen C -VOL-2.pdf' from the State of Hawaii archives
          (these spaces in filename are as correct). This document is all images, so need to transcribe.
Keopuka Lands
Kona Coast Island of Hawai'i
DRAFT ENVIRONMENTAL IMPACT STATEMENT
APPENDICES Volume 2 of 2
Prepared By:  PBR HAWAII, Wm. Frank Brandt,FALSA,President 
Prepared For: Pacific Star LLC 
Date:         July 12, 2000

Water quality starts on page 36/490:
STATUS OF NEARSHORE MARINE COMMUNITIES AND COASTAL QUALITY FRONTING THE KEOPUKA LANDS PARCEL,SOUTHERN KONA HAWII
PRECONSTRUCTION BASELINE REPORT
Prepared For: Pacific Star. LLC 8777 North Galney Center Drive, Suite 205 Scottsdale, Arizona 85258
Prepared By: Richard Brock, Ph.D Environmental Asssessment Co. 1802 Kihi Street Honolulu, Hawaii 96821
EAC Report No.2000-09 Draft - April 2000

Page 46/490:
Table 2 12 December 1991 (only grabbed "S" surface stations)
Station,mShore,Nitrate,Ammonia,TotalN,OrthoP,TotalP,Silicia,DOP,DON,Salinity,Turbidity,Chl-a,Temp,OxySat,pH

Page 46/490: (same page)
Table 1 21 April 2000    ("B" Bottom,  "S" surface stations)
Station,mShore,Nitrate,Ammonia,TotalN,OrthoP,TotalP,Silicia,DOP,DON,Salinity,Turbidity,Chl-a,Temp,OxySat,pH

Keopuka_TranscribedTable1AndTable2_SQLImport.txt

*/

--  DROP table KeopukaTranscribedValues
CREATE TABLE KeopukaTranscribedValues (
   TableNum     [int]            NOT NULL,
   DocSCode     [nvarchar](255)  NOT NULL,
   StationNum   [int]            NOT NULL,
   RepeatTest   [int]            NOT NULL,
   SampleDate   [nvarchar](255)  NOT NULL,
   mShore       [nvarchar](255)  NOT NULL,
--
   Nitrate      [numeric](38,8)  NOT NULL,--Nate6393
   Ammonia      [numeric](38,8)  NOT NULL,--AmmN6220
   TotalN       [numeric](38,8)  NOT NULL,--TDNi6210
   OrthoP       [numeric](38,8)  NOT NULL,--Pho06395
   TotalP       [numeric](38,8)  NOT NULL,--TPho6240
   Silicia      [numeric](38,8)  NOT NULL,--Sili6360
   DOP          [numeric](38,8)  NOT NULL,--OxyD6270
   DON          [numeric](38,8)  NOT NULL,--DOgN6369
   Salinity     [numeric](38,8)  NOT NULL,--Sali6350
   Turbidity    [numeric](38,8)  NOT NULL,--Turb6260
   ChlA         [numeric](38,8)  NOT NULL,--ChlA6250
   Temp         [numeric](38,8)  NOT NULL,--Temp6280
   OxySat       [numeric](38,8)  NOT NULL,--OxyS6367
   pH           [numeric](38,8)  NOT NULL,--pHyd6390
)
-- 
select * from KeopukaTranscribedValues

/*
Use MSSQL Import to import flat file: Keopuka_TranscribedTable1AndTable2_SQLImport.txt
into this table.
Tasks -> Import Data
Flat File Source (use all other Code Page ad Format recommended Next, Next
Destination is 'SQL Server Native Client 11.0'
Select Source Table and Views: Next
In destination choose or type in: KeopukaTranscribedValues
Click on 'Edit Mappings', all the fields should match the first row of fields names in the txt file,
there should not be any '<Ignore>' int he destination column
Next, 
Review Data Type Mapping, ignore yellow flags, no changes, Next
Finish
24 rows transferred

*/
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
select * from KeopukaTranscribedValues


--  DROP table KeopukaRaw
CREATE TABLE KeopukaRaw (
   TableNum      [int]            NOT NULL,--pk+
   StationNum    [int]            NOT NULL,--pk+
   RepeatTest    [int]            NOT NULL,--pk+
   DocSCode      [nvarchar](255)  NOT NULL,
   mShore        [nvarchar](255)  NOT NULL,--pk
   MyStartDate   [datetime2]      NOT NULL,
   MyEndDate     [datetime2]      NOT NULL,
--
   Nate6393   [numeric](38,8)  NULL,--Nitrate   
   AmmN6220   [numeric](38,8)  NULL,--Ammonia   
   TDNi6210   [numeric](38,8)  NULL,--TotalN    
   Pho06395   [numeric](38,8)  NULL,--OrthoP    
   TPho6240   [numeric](38,8)  NULL,--TotalP    
   Sili6360   [numeric](38,8)  NULL,--Silicia   
   OxyD6270   [numeric](38,8)  NULL,--DOP       
   DOgN6369   [numeric](38,8)  NULL,--DON       
   Sali6350   [numeric](38,8)  NULL,--Salinity  
   Turb6260   [numeric](38,8)  NULL,--Turbidity 
   ChlA6250   [numeric](38,8)  NULL,--ChlA      
   Temp6280   [numeric](38,8)  NULL,--Temp      
   OxyS6367   [numeric](38,8)  NULL,--OxySat    
   pHyd6390   [numeric](38,8)  NULL,--pH      
     
  -- new fields I added to needed to prepare for geodatbase and Esri
   MyCoreName      [nvarchar](255)        NULL,
   MyLabel         [nvarchar](255)        NULL,
   AnalyteList     [nvarchar](255)        NULL,

   MyLatLong       [nvarchar](255)        NULL,
   MyLatitude      [nvarchar](255)        NULL,
   POINT_Y         [numeric](38,8)        NULL,
   POINT_X         [numeric](38,8)        NULL,

   RawUniq         [uniqueidentifier] NOT NULL,

PRIMARY KEY (TableNum,StationNum,RepeatTest,mShore)
)

--  Select * from KeopukaRaw  
--  select * from KeopukaTranscribedValues order by StationNum,mShore


-----------------------------------------------------
-----------------------------------------------------
-----------------------------------------------------
 --  delete from KeopukaRaw
--  INSERT INTO KeopukaRaw
SELECT 
TableNum,
StationNum,
RepeatTest,
DocSCode,
mShore,
SampleDate + ' 12:00:01 AM',
SampleDate + ' 11:00:00 PM',
--
Nitrate  ,  -- Nate6393
Ammonia  ,  -- AmmN6220
TotalN   ,  -- TDNi6210
OrthoP   ,  -- Pho06395
TotalP   ,  -- TPho6240
Silicia  ,  -- Sili6360
DOP      ,  -- OxyD6270
DON      ,  -- DOgN6369
Salinity ,  -- Sali6350
Turbidity,  -- Turb6260
ChlA     ,  -- ChlA6250
Temp     ,  -- Temp6280
OxySat   ,  -- OxyS6367
pH       ,  -- pHyd6390
-- my fields
NULL,NULL,NULL,      -- MyCoreName, MyLabel, AnalyteList
NULL,NULL,NULL,NULL, -- location fields all null here, geocoded values will update to these
newid()

FROM KeopukaTranscribedValues
ORDER BY StationNum,mShore
-- 24 rows affected
select * from KeopukaRaw ORDER BY StationNum,mShore
-- 

--/* development only
select sum(Nate6393),avg(Nate6393) from KeopukaRaw
-- 194.32000000	8.09666666
select sum(Sali6350),avg(Sali6350) from KeopukaRaw
-- 829.63900000	34.56829166
--  select StationNum,mShore,Sali6350 from KeopukaRaw order by StationNum,mShore
select sum(AmmN6220),avg(AmmN6220) from KeopukaRaw
-- 64.73000000	2.69708333
--*/

---------------------------------------------
---------------------------------------------
---------------------------------------------
select distinct(StationNum), RepeatTest, mShore FROM KeopukaRaw GROUP BY StationNum,RepeatTest,mShore ORDER BY StationNum,mShore
--17
/*
StationNum	RepeatTest	mShore
1	0	000
2	0	020
4	0	050
6	0	100
8	0	000
9	0	020
11	0	050
13	0	100
15	0	000
16	0	020
18	0	050
20	0	100
22	0	000
22	1	000
23	0	020
25	0	050
27	0	100
*/
select distinct(StationNum), DocSCode FROM KeopukaRaw GROUP BY StationNum,DocSCode ORDER BY StationNum,DocSCode
/*
StationNum	DocSCode
1	 1S
2	 2S
4	 4S
6	 6S
8	 8S
9	 9S
11	11S
13	13S
15	15S
16	16S
18	18S
20	20S
22	22S
23	23S
25	25S
27	27S
*/


/* the "transects" are 1-4 starting from the North 
   each station number is on a unique transect starting from 1, thus
   transect1 station1-7, transect2 station8-14, transect3 station15-21 and transect4 station22-28
   the "missing" station numbers here are bottom samples which are not imported in to this surface system
   updates are across table1 and table2 so there are multiple updated rows per command and station22 was
   repeated (because the measurements were so different)
*/
-- geocoding effort for each of the stations

UPDATE KeopukaRaw SET POINT_Y=19.48839, POINT_X=-155.95011 WHERE StationNum= 1  -- Keopuka_000m_Tr01To07   
UPDATE KeopukaRaw SET POINT_Y=19.48838, POINT_X=-155.95030 WHERE StationNum= 2	-- Keopuka_020m_Tr01To07   
UPDATE KeopukaRaw SET POINT_Y=19.48836, POINT_X=-155.95058 WHERE StationNum= 4	-- Keopuka_050m_Tr01To07   
UPDATE KeopukaRaw SET POINT_Y=19.48833, POINT_X=-155.95106 WHERE StationNum= 6	-- Keopuka_100m_Tr01To07   
--1 each
UPDATE KeopukaRaw SET POINT_Y=19.48480, POINT_X=-155.94888 WHERE StationNum= 8	-- Keopuka_000m_Tr08To14
UPDATE KeopukaRaw SET POINT_Y=19.48475, POINT_X=-155.94906 WHERE StationNum= 9	-- Keopuka_020m_Tr08To14
UPDATE KeopukaRaw SET POINT_Y=19.48466, POINT_X=-155.94933 WHERE StationNum=11  -- Keopuka_050m_Tr08To14
UPDATE KeopukaRaw SET POINT_Y=19.48453, POINT_X=-155.94979 WHERE StationNum=13  -- Keopuka_100m_Tr08To14
--2 each
UPDATE KeopukaRaw SET POINT_Y=19.48367, POINT_X=-155.94520 WHERE StationNum=15	-- Keopuka_000m_Tr15To21
UPDATE KeopukaRaw SET POINT_Y=19.48348, POINT_X=-155.94522 WHERE StationNum=16	-- Keopuka_020m_Tr15To21
UPDATE KeopukaRaw SET POINT_Y=19.48322, POINT_X=-155.94524 WHERE StationNum=18	-- Keopuka_050m_Tr15To21
UPDATE KeopukaRaw SET POINT_Y=19.48276, POINT_X=-155.94527 WHERE StationNum=20	-- Keopuka_100m_Tr15To21
--1 each
UPDATE KeopukaRaw SET POINT_Y=19.48278, POINT_X=-155.94057 WHERE StationNum=22	-- Keopuka_000m_T226To28
--3
UPDATE KeopukaRaw SET POINT_Y=19.48261, POINT_X=-155.94071 WHERE StationNum=23	-- Keopuka_020m_Tr22To28
--2
UPDATE KeopukaRaw SET POINT_Y=19.48242, POINT_X=-155.94090 WHERE StationNum=25	-- Keopuka_050m_Tr22To28
--2
UPDATE KeopukaRaw SET POINT_Y=19.48210, POINT_X=-155.94125 WHERE StationNum=27	-- Keopuka_100m_Tr22To28
--1
select * from KeopukaRaw ORDER BY StationNum
/*
TableNum	StationNum	RepeatTest	DocSCode	mShore	StartDate	EndDate	Nate6393	AmmN6220	TDNi6210	Pho06395	TPho6240	Sili6360	OxyD6270	DOgN6369	Sali6350	Turb6260	ChlA6250	Temp6280	OxyS6367	pHyd6390	MyCoreName	MyLabel	AnalyteList	MyLatLong	MyLatitude	POINT_Y	POINT_X	RawUniq
1	1	0	 1S	000	2000-04-01 00:00:00.0000000	2000-04-01 23:59:59.0000000	27.66000000	3.64000000	125.58000000	8.68000000	16.43000000	688.80000000	7.75000000	94.08000000	33.96600000	0.16000000	0.10800000	26.20000000	102.00000000	8.21000000	NULL	NULL	NULL	NULL	NULL	19.48839000	-155.95011000	B341170E-A3BC-4280-9564-030679330CD5
1	2	0	 2S	020	2000-04-01 00:00:00.0000000	2000-04-01 23:59:59.0000000	5.26000000	2.80000000	111.72000000	6.20000000	13.95000000	202.72000000	7.75000000	100.66000000	34.52600000	0.09000000	0.11700000	25.80000000	101.00000000	8.20000000	NULL	NULL	NULL	NULL	NULL	19.48838000	-155.95030000	0C56F038-8997-4145-A64D-D565D900575F
1	4	0	 4S	050	2000-04-01 00:00:00.0000000	2000-04-01 23:59:59.0000000	1.28000000	1.96000000	121.52000000	6.51000000	13.33000000	57.68000000	6.82000000	118.30000000	34.68600000	0.10000000	0.11100000	25.80000000	102.00000000	8.20000000	NULL	NULL	NULL	NULL	NULL	19.48836000	-155.95058000	BF8B3C7E-3773-49DB-9C94-66AF0CA7AE7D
1	6	0	 6S	100	2000-04-01 00:00:00.0000000	2000-04-01 23:59:59.0000000	0.14000000	1.54000000	111.44000000	5.89000000	13.33000000	43.66000000	7.44000000	109.76000000	34.69700000	0.11000000	0.09700000	26.20000000	101.00000000	8.20000000	NULL	NULL	NULL	NULL	NULL	19.48833000	-155.95106000	40A082CE-80C6-46B1-935E-21419864B390
1	8	0	 8S	000	2000-04-01 00:00:00.0000000	2000-04-01 23:59:59.0000000	4.34000000	1.65000000	112.14000000	5.58000000	14.57000000	145.32000000	8.99000000	106.12000000	34.58400000	0.08000000	0.12700000	26.10000000	103.00000000	8.13000000	NULL	NULL	NULL	NULL	NULL	19.48480000	-155.94888000	41267692-AA33-4FA5-A2CE-6F9B460529E5
2	8	0	 8S	000	1991-12-01 00:00:00.0000000	1991-12-01 23:59:59.0000000	6.02000000	3.36000000	97.02000000	2.17000000	9.61000000	310.52000000	11.16000000	96.18000000	34.59200000	0.08000000	0.10600000	25.50000000	102.00000000	8.19000000	NULL	NULL	NULL	NULL	NULL	19.48480000	-155.94888000	8BF8B5EA-6186-48B0-AC46-8AE168533DC3
2	9	0	 9S	020	1991-12-01 00:00:00.0000000	1991-12-01 23:59:59.0000000	0.56000000	7.14000000	81.20000000	1.86000000	8.68000000	59.64000000	10.85000000	98.00000000	34.76000000	0.08000000	0.08600000	25.50000000	101.00000000	8.21000000	NULL	NULL	NULL	NULL	NULL	19.48475000	-155.94906000	A9DA6347-55B6-47B5-80A7-4EDF2DDABE03
1	9	0	 9S	020	2000-04-01 00:00:00.0000000	2000-04-01 23:59:59.0000000	0.42000000	3.64000000	159.46000000	4.96000000	15.50000000	46.76000000	10.54000000	155.40000000	34.70900000	0.11000000	0.11900000	25.60000000	102.00000000	8.14000000	NULL	NULL	NULL	NULL	NULL	19.48475000	-155.94906000	C6BA6391-DF42-4527-A8E3-69080B9A827C
1	11	0	11S	050	2000-04-01 00:00:00.0000000	2000-04-01 23:59:59.0000000	0.00000000	1.96000000	98.28000000	4.34000000	13.64000000	46.20000000	9.30000000	96.32000000	34.70100000	0.08000000	0.11200000	25.60000000	101.00000000	8.21000000	NULL	NULL	NULL	NULL	NULL	19.48466000	-155.94933000	F8033E29-653E-477C-8EDF-439AECC44C7C
2	11	0	11S	050	1991-12-01 00:00:00.0000000	1991-12-01 23:59:59.0000000	0.14000000	2.60000000	87.50000000	1.24000000	7.44000000	45.08000000	7.44000000	99.96000000	34.76000000	0.07000000	0.09000000	25.80000000	100.00000000	8.24000000	NULL	NULL	NULL	NULL	NULL	19.48466000	-155.94933000	43DF8133-BB6F-42D2-90EF-E0BF8F13AFBE
2	13	0	13S	100	1991-12-01 00:00:00.0000000	1991-12-01 23:59:59.0000000	1.96000000	4.06000000	101.78000000	2.48000000	8.69000000	189.56000000	9.92000000	102.62000000	34.76400000	0.07000000	0.13800000	25.50000000	101.00000000	8.26000000	NULL	NULL	NULL	NULL	NULL	19.48453000	-155.94979000	CE9D4DFA-2DA0-417E-9B61-94B0B75AA8CD
1	13	0	13S	100	2000-04-01 00:00:00.0000000	2000-04-01 23:59:59.0000000	0.26000000	2.24000000	145.60000000	4.65000000	13.64000000	42.28000000	8.99000000	143.08000000	34.70600000	0.10000000	0.10400000	25.50000000	100.00000000	8.21000000	NULL	NULL	NULL	NULL	NULL	19.48453000	-155.94979000	5AB85A21-AAD2-4655-B260-C7C74FA79C65
1	15	0	15S	000	2000-04-01 00:00:00.0000000	2000-04-01 23:59:59.0000000	2.38000000	1.54000000	97.72000000	4.96000000	13.95000000	69.16000000	8.99000000	93.80000000	34.67900000	0.07000000	0.06900000	25.20000000	102.00000000	8.19000000	NULL	NULL	NULL	NULL	NULL	19.48367000	-155.94520000	4ABE780D-164E-4903-8069-BACD16434836
1	16	0	16S	020	2000-04-01 00:00:00.0000000	2000-04-01 23:59:59.0000000	1.40000000	2.24000000	118.30000000	6.51000000	13.64000000	58.24000000	7.13000000	114.66000000	34.69600000	0.07000000	0.09700000	25.20000000	102.00000000	8.15000000	NULL	NULL	NULL	NULL	NULL	19.48348000	-155.94522000	8B68BBEF-F4E7-44C3-9ED0-E86F7144F1BD
1	18	0	18S	050	2000-04-01 00:00:00.0000000	2000-04-01 23:59:59.0000000	0.42000000	2.38000000	116.06000000	4.96000000	13.95000000	62.16000000	8.99000000	113.26000000	34.69300000	0.09000000	0.09500000	24.50000000	101.00000000	8.47000000	NULL	NULL	NULL	NULL	NULL	19.48322000	-155.94524000	E2EE9978-F996-4B7B-A251-E6021FD0A0EF
1	20	0	20S	100	2000-04-01 00:00:00.0000000	2000-04-01 23:59:59.0000000	0.70000000	1.82000000	100.52000000	4.96000000	15.81000000	59.36000000	10.85000000	98.00000000	34.69900000	0.08000000	0.10100000	24.50000000	101.00000000	8.02000000	NULL	NULL	NULL	NULL	NULL	19.48276000	-155.94527000	6FD7BBAC-0FC7-4A73-B672-F11D231ECEF5
1	22	0	22S	000	2000-04-01 00:00:00.0000000	2000-04-01 23:59:59.0000000	25.34000000	2.80000000	128.10000000	8.99000000	16.43000000	557.20000000	7.44000000	99.96000000	34.10300000	0.12000000	0.09900000	24.50000000	102.00000000	8.20000000	NULL	NULL	NULL	NULL	NULL	19.48278000	-155.94057000	B6F39085-523F-4B73-BEB3-6D3AB488C89B
1	22	1	22S	000	2000-04-01 00:00:00.0000000	2000-04-01 23:59:59.0000000	26.74000000	2.94000000	136.92000000	9.30000000	16.12000000	577.36000000	6.82000000	107.24000000	34.07400000	0.09000000	0.10300000	24.50000000	102.00000000	8.20000000	NULL	NULL	NULL	NULL	NULL	19.48278000	-155.94057000	FB259F72-021F-429A-89CA-306EA1F8DA19
2	22	0	22S	000	1991-12-01 00:00:00.0000000	1991-12-01 23:59:59.0000000	45.78000000	1.96000000	143.22000000	6.20000000	11.78000000	1153.68000000	8.37000000	116.06000000	34.60900000	0.07000000	0.07000000	25.50000000	103.00000000	8.26000000	NULL	NULL	NULL	NULL	NULL	19.48278000	-155.94057000	37B89DF2-D128-4BBE-80E3-2DB37ACB15B0
2	23	0	23S	020	1991-12-01 00:00:00.0000000	1991-12-01 23:59:59.0000000	6.86000000	2.38000000	85.96000000	3.10000000	8.68000000	183.96000000	11.16000000	110.04000000	34.58300000	0.07000000	0.07000000	25.70000000	102.00000000	8.28000000	NULL	NULL	NULL	NULL	NULL	19.48261000	-155.94071000	39924B14-6DC6-4722-A998-7F4299B4805A
1	23	0	23S	020	2000-04-01 00:00:00.0000000	2000-04-01 23:59:59.0000000	24.06000000	2.10000000	135.24000000	7.75000000	19.22000000	511.00000000	11.47000000	109.06000000	34.15500000	0.10000000	0.09000000	24.80000000	100.00000000	8.07000000	NULL	NULL	NULL	NULL	NULL	19.48261000	-155.94071000	92FC1225-2013-487D-A8FF-DE3A988B2E65
1	25	0	25S	050	2000-04-01 00:00:00.0000000	2000-04-01 23:59:59.0000000	7.56000000	2.10000000	125.72000000	7.75000000	16.12000000	198.24000000	8.37000000	115.06000000	34.53400000	0.09000000	0.12000000	25.80000000	102.00000000	7.95000000	NULL	NULL	NULL	NULL	NULL	19.48242000	-155.94090000	2EECE505-CF10-402D-AF68-FAD51FE8B546
2	25	0	25S	050	1991-12-01 00:00:00.0000000	1991-12-01 23:59:59.0000000	1.40000000	2.66000000	87.50000000	2.48000000	8.37000000	65.80000000	9.92000000	126.52000000	34.71600000	0.08000000	0.10200000	25.60000000	101.00000000	8.27000000	NULL	NULL	NULL	NULL	NULL	19.48242000	-155.94090000	762EC6B8-22CB-4131-A962-D0A87D5CD363
1	27	0	27S	100	2000-04-01 00:00:00.0000000	2000-04-01 23:59:59.0000000	3.64000000	3.22000000	135.38000000	7.13000000	17.05000000	112.84000000	9.92000000	128.52000000	34.64700000	0.12000000	0.10600000	24.70000000	101.00000000	8.15000000	NULL	NULL	NULL	NULL	NULL	19.48210000	-155.94125000	7EC5A313-679F-4824-8DEC-673CB6773C41
*/
---------------------------------------------------
---------------------------------------------------
---------------------------------------------------
--
-- put together lat/long fields now that have POINTs


/* make our fields for later insertions into our tables */
--

-- continue with manipulations
UPDATE KeopukaRaw SET
MyLatLong  = str(POINT_Y, 7, 4) + ' , ' + str(POINT_X, 9, 4),
MyLatitude = CAST( REPLACE( str( CAST(POINT_Y AS DECIMAL (7,4)),7,4),'.','_') AS varchar)
-- 24
select * from KeopukaRaw

-- 
-- now the final name assembly
/*
Keopuka_RBrock_
Nate6393AmmN6220TDNi6210Pho06395TPho6240Sili6360OxyD6270DOgN6369Sali6350Turb6260ChlA6250Temp6280OxyS6367pHyd6390
*/

-- analyte list easy here, all rows have all analytes owing to RBrock's consistency
UPDATE KeopukaRaw SET
AnalyteList = 'Nate6393AmmN6220TDNi6210Pho06395TPho6240Sili6360OxyD6270DOgN6369Sali6350Turb6260ChlA6250Temp6280OxyS6367pHyd63903'
-- 24

-- label
UPDATE KeopukaRaw SET MyLabel = 
   'Keopuka ' + 
   RIGHT('0'+LTRIM(DocSCode),3) + ' ' +
   RIGHT('000'+LTRIM(str(mShore)),3) + 'm'
--24

-- make core name 
UPDATE KeopukaRaw SET MyCoreName = 
   MyLatitude + '_' +
   RIGHT('000'+LTRIM(str(mShore)),3) + 'm' + + '_' +      -- 000m,020m,050m,100m at Keopuka
   'KeopukaLands' + '_' +
    'Y' + SUBSTRING(convert(varchar, MyStartDate, 107),1,3) + SUBSTRING(convert(varchar, MyStartDate, 107),9,4) + '_' +
   'RBrock'  + '_' + 
   'Station' + RIGHT('0'+LTRIM(str(StationNum)),2) +
   IIF(RepeatTest=0,'','Repeat')
--
UPDATE KeopukaRaw SET MyCoreName = REPLACE(REPLACE(MyCoreName, ' ',''),'-','')
--
select MyCoreName,MyLabel from KeopukaRaw

select * from KeopukaRaw
-- 
--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- make the dates unique by adding a few seconds
DECLARE @RawUniq uniqueidentifier, @StartDate datetime2, @EndDate datetime2, @RowCount integer=0
DECLARE @cursorInsert CURSOR SET @cursorInsert = CURSOR FOR
   SELECT RawUniq, MyStartDate, MyEndDate FROM KeopukaRaw
OPEN @cursorInsert
FETCH NEXT FROM @cursorInsert INTO @RawUniq, @StartDate, @EndDate
--
WHILE @@FETCH_STATUS = 0
   BEGIN
   set @RowCount = @RowCount + 1
   UPDATE KeopukaRaw 
   SET MyStartDate = DATEADD(ss,@RowCount,MyStartDate),MyEndDate = DATEADD(ss,@RowCount,MyEndDate)
   WHERE KeopukaRaw.RawUniq IN (SELECT @RawUniq FROM KeopukaRaw)
   FETCH NEXT FROM @cursorInsert INTO @RawUniq, @StartDate, @EndDate
   END
CLOSE @cursorInsert
DEALLOCATE @cursorInsert
--
select MyStartDate,MyEndDate from KeopukaRaw
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--  DROP TABLE [dbo].[KeopukaFCStation]
CREATE TABLE [dbo].[KeopukaFCStation](
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
	[PageQuery]  [int]               NULL,
	[PageQueryS] [nvarchar](255)     NULL,
--
	[GeoUniq] [uniqueidentifier]  NOT NULL,
	[StatUniq] [uniqueidentifier] NOT NULL,
	[RawUniq] [uniqueidentifier]  NOT NULL,

 PRIMARY KEY (pkStation)
 ) 

-- 
-- FCStation is populated from KeopukaRaw and the names/location information I have assembled
--  DELETE from KeopukaFCStation
 INSERT INTO KeopukaFCStation 
SELECT 
MyCoreName,          -- pkStation
MyLabel,             -- Label
'Table' + str(TableNum,1)+'Page46', -- TablePage
DocSCode,            -- fkStation1 
StationNum,          -- fkStation2
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
MyStartDate, MyEndDate,      -- StartDate and EndDate
NULL,NULL,NULL,NULL,NULL,    -- 5 extra fields
POINT_X,POINT_Y,             -- XField, YField
--
ROW_NUMBER() OVER(ORDER BY POINT_Y ASC)%2, -- Rotation
0,                           -- Normalize
0,                           -- Weight
0,NULL,                      -- PageQuery/S
--

newid(),                     -- GeoUniq set only since can't set to null on table create
newid(),                     -- StatUniq is assigned here when making a new record
RawUniq                      -- tracer backwards
FROM KeopukaRaw
ORDER BY MyCoreName 
--24
select * from KeopukaFCStation   ORDER BY mShore 

--24

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- FCStation complete and many preparations compete, move to insert data from KeopukaRaw and other tables
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- Now work on the TBSample table
-- the pkSample name pieces are available to include fully formed names
-- there are xx sample, with up to 7 analytes recorded per sample

--  DROP TABLE KeopukaTBSample
CREATE TABLE KeopukaTBSample (
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

select * from KeopukaRaw

--   DELETE FROM KeopukaTBSample
--  INSERT INTO KeopukaTBSample
SELECT 
MyCoreName + '_' + AnalyteList,  -- pkSample
MyLabel,                 -- LabelName
DocSCode,                -- TablePage 
-99,                     -- AlertTrue
'RBrock',                -- fkIDLoc
StationNum,              -- StationNum
mShore,                  -- mShore
MyCoreName,              -- pkStation, same as FCStation code
DocSCode,                -- fkStation2, station as known to Keopuka
'RBrock',
newid(),                 -- fkUniqID is the new if generated in this new row creation of the insert
'<<fkOrg>>',             -- *** GET ****
1420,                    -- dmSample, laboratory
MyStartDate, 
MyEndDate,               -- 
'Yes',                   -- TimeMissg field
NULL,NULL,               -- Medium, CompStat
NULL,                    -- no Comment yet
REPLACE(MyLatitude,'_',''), -- attach code
NULL,NULL,NULL,NULL,NULL,   -- 5 extras
0,0,0,1,NULL,               -- cartography fields
newid(),
RawUniq                     -- important for tracing to save source row id
FROM KeopukaRaw
ORDER BY (MyCoreName + '_' + AnalyteList)
-- 24 rows affected

select * from KeopukaTBSample
-- 24
-----------------------
-----------------------



/*
-- inner join should be all, outer join should be none as pkStation and fkStation must match, no nulls allowed
select A_sta.*, B_samp.*
from KeopukaFCStation A_sta
INNER JOIN KeopukaTBSample B_samp ON
A_sta.pkStation = B_samp.fkStation
-- 24
select A_sta.*, B_samp.*
from KeopukaFCStation A_sta
full outer JOIN KeopukaTBSample B_samp ON
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
-- move to populate KeopukaTBResult

--  DROP TABLE KeopukaTBResult
CREATE TABLE KeopukaTBResult (
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
-- delete from KeopukaTBResult
--------------------------------------------------------------------------------
 -- 1 of 14
 INSERT INTO KeopukaTBResult
SELECT 
samp.pkSample,
'Nate6393 - NO3',
samp.fkIDLoc,
samp.fkUnqID,
Nate6393,
NULL,-- Stddev
6393,--dmRAll
6465,--dmRAMethod
6399,--dmR11546
6393,--dmRAnlyt
6499,--dmRBEACH
NULL,--Grade
NULL,--Comments
NULL,--AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM KeopukaRaw raw
INNER JOIN KeopukaTBSample samp
ON (raw.RawUniq = samp.RawUniq) and Nate6393 IS NOT NULL
--ON (raw.TableNum = raw.StationNum = samp.StationNum AND raw.mShore = samp.mShore) and Nate6393 IS NOT NULL
--ORDER BY pkSample
ORDER BY mShore
--24
--------------------------------------------------------------------------------
--2
INSERT INTO KeopukaTBResult
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
NULL,--Grade
NULL,--Comments
NULL,--AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM KeopukaRaw raw
INNER JOIN KeopukaTBSample samp
ON (raw.RawUniq = samp.RawUniq) and AmmN6220 IS NOT NULL
ORDER BY mShore
--24
--------------------------------------------------------------------------------
--3
INSERT INTO KeopukaTBResult
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
NULL,--Grade
NULL,--Comments
NULL,--AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM KeopukaRaw raw
INNER JOIN KeopukaTBSample samp
ON (raw.RawUniq = samp.RawUniq) and TDNi6210 IS NOT NULL
ORDER BY mShore
--24
select sum(TDNi6210) FROM KeopukaRaw raw
WHERE raw.TDNi6210 IS NOT NULL
select sum(Result) FROM KeopukaTBResult
WHERE dmRall = 6210
-- 2763.88000000 both
--------------------------------------------------------------------------------
--4
INSERT INTO KeopukaTBResult
SELECT 
samp.pkSample,
'Pho06395 - 0-Phosphate',
samp.fkIDLoc,
samp.fkUnqID,
Pho06395,
NULL,-- Stddev
6395,--dmRAll
6465,--dmRAMethod
6299,--dmR11546
6395,--dmRAnlyt
6499,--dmRBEACH
NULL,--Grade
NULL,--Comments
NULL,--AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM KeopukaRaw raw
INNER JOIN KeopukaTBSample samp
ON (raw.RawUniq = samp.RawUniq) and Pho06395 IS NOT NULL
ORDER BY mShore
--24
--------------------------------------------------------------------------------
--5
INSERT INTO KeopukaTBResult
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
NULL,--Grade
NULL,--Comments
NULL,--AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM KeopukaRaw raw
INNER JOIN KeopukaTBSample samp
ON (raw.RawUniq = samp.RawUniq) and TPho6240 IS NOT NULL
ORDER BY mShore
--24
--------------------------------------------------------------------------------
--6
INSERT INTO KeopukaTBResult
SELECT 
samp.pkSample,
'Sili6360 - Silicates',
samp.fkIDLoc,
samp.fkUnqID,
Sili6360,
NULL,-- Stddev
6360,--dmRAll
6465,--dmRAMethod
6360,--dmR11546
6399,--dmRAnlyt
6499,--dmRBEACH
NULL,--Grade
NULL,--Comments
NULL,--AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM KeopukaRaw raw
INNER JOIN KeopukaTBSample samp
ON (raw.RawUniq = samp.RawUniq) and Sili6360 IS NOT NULL
ORDER BY mShore
--24
--------------------------------------------------------------------------------
--7
INSERT INTO KeopukaTBResult
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
NULL,--Grade
NULL,--Comments
NULL,--AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM KeopukaRaw raw
INNER JOIN KeopukaTBSample samp
ON (raw.RawUniq = samp.RawUniq) and OxyD6270 IS NOT NULL
ORDER BY mShore
--24
--------------------------------------------------------------------------------
--8
INSERT INTO KeopukaTBResult
SELECT 
samp.pkSample,
'DogN6369 - Dissolved Organic Nitrogen',
samp.fkIDLoc,
samp.fkUnqID,
DogN6369,
NULL,-- Stddev
6369,--dmRAll
6465,--dmRAMethod
6299,--dmR11546
6369,--dmRAnlyt
6499,--dmRBEACH
NULL,--Grade
NULL,--Comments
NULL,--AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM KeopukaRaw raw
INNER JOIN KeopukaTBSample samp
ON (raw.RawUniq = samp.RawUniq) and DogN6369 IS NOT NULL
ORDER BY mShore
--24
--------------------------------------------------------------------------------
--9
INSERT INTO KeopukaTBResult
SELECT 
samp.pkSample,
'Sali6350 - Salinity',
samp.fkIDLoc,
samp.fkUnqID,
Sali6350,
NULL,-- Stddev
6350,--dmRAll
6465,--dmRAMethod
6299,--dmR11546
6350,--dmRAnlyt
6499,--dmRBEACH
NULL,--Grade
NULL,--Comments
NULL,--AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM KeopukaRaw raw
INNER JOIN KeopukaTBSample samp
ON (raw.RawUniq = samp.RawUniq) and Sali6350 IS NOT NULL
ORDER BY mShore
--24
--------------------------------------------------------------------------------
--10
INSERT INTO KeopukaTBResult
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
6399,--dmRAnlyt
6499,--dmRBEACH
NULL,--Grade
NULL,--Comments
NULL,--AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM KeopukaRaw raw
INNER JOIN KeopukaTBSample samp
ON (raw.RawUniq = samp.RawUniq) and Turb6260 IS NOT NULL
ORDER BY mShore
--24
--------------------------------------------------------------------------------
--11
INSERT INTO KeopukaTBResult
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
NULL,--Grade
NULL,--Comments
NULL,--AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM KeopukaRaw raw
INNER JOIN KeopukaTBSample samp
ON (raw.RawUniq = samp.RawUniq) and ChlA6250 IS NOT NULL
ORDER BY mShore
--24
--------------------------------------------------------------------------------
--12
INSERT INTO KeopukaTBResult
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
NULL,--Grade
NULL,--Comments
NULL,--AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM KeopukaRaw raw
INNER JOIN KeopukaTBSample samp
ON (raw.RawUniq = samp.RawUniq) and Temp6280 IS NOT NULL
ORDER BY mShore
--24
--------------------------------------------------------------------------------
--13
INSERT INTO KeopukaTBResult
SELECT 
samp.pkSample,
'OxyS6367 - O2 Saturation',
samp.fkIDLoc,
samp.fkUnqID,
OxyS6367,
NULL,-- Stddev
6367,--dmRAll
6465,--dmRAMethod
6299,--dmR11546
6367,--dmRAnlyt
6499,--dmRBEACH
NULL,--Grade
NULL,--Comments
NULL,--AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM KeopukaRaw raw
INNER JOIN KeopukaTBSample samp
ON (raw.RawUniq = samp.RawUniq) and OxyS6367 IS NOT NULL
ORDER BY mShore
--24
--------------------------------------------------------------------------------
--14
INSERT INTO KeopukaTBResult
SELECT 
samp.pkSample,
'pHyd6390 - pH',
samp.fkIDLoc,
samp.fkUnqID,
pHyd6390,
NULL,-- Stddev
6390,--dmRAll
6465,--dmRAMethod
6299,--dmR11546
6390,--dmRAnlyt
6499,--dmRBEACH
NULL,--Grade
NULL,--Comments
NULL,--AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM KeopukaRaw raw
INNER JOIN KeopukaTBSample samp
ON (raw.RawUniq = samp.RawUniq) and pHyd6390 IS NOT NULL
ORDER BY mShore
--24



select * from KeopukaTBResult
-- 336 rows


------
-- V1 thesis maps
use WHWQ4

SELECT Label, Count(dmRAll),
round(stdev(Result),2) as 'stdev',
cast(min(Result) as decimal (10,2)) as 'min',
cast(max(Result) as decimal (10,2)) as 'max'
FROM KeopukaTBResult 
WHERE Result != 0 
AND fkSample LIKE '%YDec1991%'
 GROUP by Label, dmRAll ORDER by Label


-- V2 thesis maps
SELECT 'Old 12/1991' as 'Keopuka,R.Brock', Count(*) as 'TBResult #rows' FROM KeopukaTBResult WHERE fkSample LIKE '%YDec1991%'
SELECT Label, Count(dmRAll) as '#rows', round(exp(avg(log(Result))),3) as '~gmean',
round(stdev(Result),2) as 'stdev',
cast(min(Result) as decimal (10,2)) as 'min',
cast(max(Result) as decimal (10,2)) as 'max'
FROM KeopukaTBResult WHERE Result != 0 AND fkSample LIKE '%YDec1991%' GROUP by Label, dmRAll ORDER by Label

SELECT 'New 04/2000' as 'Keopuka,R.Brock', Count(*) as 'TBResult #rows' FROM KeopukaTBResult WHERE fkSample LIKE '%YApr2000%'
SELECT Label, Count(dmRAll) as '#rows', round(exp(avg(log(Result))),3) as '~gmean',
round(stdev(Result),2) as 'stdev',
cast(min(Result) as decimal (10,2)) as 'min',
cast(max(Result) as decimal (10,2)) as 'max'
FROM KeopukaTBResult WHERE Result != 0 AND fkSample LIKE '%YApr2000%' GROUP by Label, dmRAll ORDER by Label


SELECT Count(*) as 'TBResult Count' FROM KeopukaTBResult
SELECT Label, Count(dmRAll) as 'TBResult rows' FROM KeopukaTBResult GROUP by Label, dmRAll ORDER by 2 DESC

SELECT Count(*) FROM KeopukaTBResult WHERE fkSample LIKE '%YApr2000%' ; SELECT Label, Count(dmRAll), round(exp(avg(log(Result))),3) as '~gmean', round(stdev(Result),2), cast(min(Result) as decimal (10,2)), cast(max(Result) as decimal (10,2)) FROM KeopukaTBResult WHERE Result != 0 AND fkSample LIKE '%YApr2000%' GROUP by Label, dmRAll




SELECT Count(*) as 'TBResult Count' FROM KeopukaTBResult
--WHERE fkSample LIKE '%Apr2000%'
WHERE fkSample LIKE '%Dec1991%'

SELECT Label, Count(dmRAll) as 'TBResult rows' FROM KeopukaTBResult
--WHERE fkSample LIKE '%Apr2000%'
WHERE fkSample LIKE '%Dec1991%'
GROUP by Label, dmRAll ORDER by 2 DESC
--------------------------------------------------------------------------------

--/* development only
select sum(Nate6393),avg(Nate6393) from KeopukaRaw
--194.32000000	8.09666666
select sum(Result),avg(Result) from KeopukaTBResult WHERE dmRAll = 6393 -- Nate6393
-- 194.32000000	8.09666666

select count(*),sum(Sali6350),avg(Sali6350) from KeopukaRaw WHERE Sali6350 IS NOT NULL
select StationNum,mShore,Sali6350 from KeopukaRaw WHERE Sali6350 IS NOT NULL ORDER BY StationNum,mShore
--24	829.63900000	34.56829166
select count(Result),sum(Result),avg(Result) from KeopukaTBResult WHERE dmRAll = 6350 -- Sali6350
--24	829.63900000	34.56829166

select sum(AmmN6220),avg(AmmN6220) from KeopukaRaw
-- 64.73000000	2.69708333
select sum(Result),avg(Result) from KeopukaTBResult WHERE dmRAll = 6220 -- AmmN6220
-- 64.73000000	2.69708333
--*/

SELECT 
   SUM(Nate6393) +
   SUM(AmmN6220) + 
   SUM(TDNi6210) + 
   SUM(Pho06395) + 
   SUM(TPho6240) + 
   SUM(Sili6360) + 
   SUM(OxyD6270) + 
   SUM(DOgN6369) + 
   SUM(Sali6350) + 
   SUM(Turb6260) + 
   SUM(ChlA6250) + 
   SUM(Temp6280) + 
   SUM(OxyS6367) + 
   SUM(pHyd6390)
FROM KeopukaRaw
--15903.23600000
SELECT SUM(Result) FROM KeopukaTBResult
--15903.23600000

*/


-- select * from KeopukaTBResult order by dmRAll
SELECT COUNT(*) FROM KeopukaTBResult
-- 336 rows 24rows * 14 analytes = 336
SELECT * FROM KeopukaTBResult

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
select r.*, s.* 
From KeopukaTBResult r
inner join KeopukaTBSample  s
ON r.fkUnqID = s.fkUnqID
-- 336
select s.*, r.* 
From KeopukaTBSample s
inner join  KeopukaTBResult r
ON s.fkUnqID = r.fkUnqID
-- 336 as expect for inner join

select r.*, s.* 
From KeopukaTBResult r
left join KeopukaTBSample  s
ON r.fkUnqID = s.fkUnqID
-- 336

--select pkSample, fkSample, r.label
select s.*,r.*
From KeopukaTBSample s
left join  KeopukaTBResult r
ON r.fkUnqID = NULL
-- 24
select * from KeopukaTBResult where fkUnqID is null
--0
select * from KeopukaTBSample where fkUnqID is null
--0
select count(*) from KeopukaTBSample
--24
select count(*) from KeopukaTBResult
--336

select r.*, s.* 
From KeopukaTBResult r
right join KeopukaTBSample  s
ON r.fkUnqID = s.fkUnqID
--336
select pkSample, fkSample, r.label
From KeopukaTBSample s
right join  KeopukaTBResult r
ON s.fkUnqID = NULL
--336

select r.*, s.* 
From KeopukaTBResult r
full outer join KeopukaTBSample  s
ON r.fkUnqID = s.fkUnqID
--336
select s.*, r.* 
From KeopukaTBSample s
full outer join  KeopukaTBResult r
ON s.fkUnqID = r.fkUnqID
--336

----
select r.*, s.* 
From KeopukaTBResult r
full outer join KeopukaTBSample  s
ON s.fkUnqID = r.fkUnqID
WHERE r.fkUnqID IS NULL OR s.fkUnqID IS NULL
-- 0
select s.*, r.* 
From KeopukaTBSample s
full outer join  KeopukaTBResult r
ON s.fkUnqID = r.fkUnqID
WHERE s.fkUnqID IS NULL OR r.fkUnqID IS NULL
-- 0
