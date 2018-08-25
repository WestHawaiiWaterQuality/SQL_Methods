/*
Handler for Dr. Dennis Mihalka kayak scientist 
Last Update: 04/05/2018 

This file was handled in a VERY brute force approach using no tsql, should have though.
The format is very unique in the columns are dates and rows are a combo analyte/distance.
*/

USE WHWQ4
-

/* 
Filename: 19_5620_DMihalka_KeauhouBay_YMayToDec2015_40WeeklySample_KYK.xlsx
Export of the XLS file massaged to add commas and remove unnessary spaces for SSMS import
first read into varchars to minimize issues of conversions and NULLsm choose this table
on the import destination and check the mappings are an exact match
*/

--   >>>>DROP TABLE<< MihalkaRawVarChars
--  CREATE TABLE MihalkaRawVarChars (
  MyAnalyteCode [nvarchar](10)  NOT NULL,-- my analyte code per the schema design
  mShore        [nvarchar](10)  NOT NULL,-- meters from shore

  D04_21_14     [nvarchar](255)     NULL,--1 these are the weekly dates of the samples
  D04_26_14     [nvarchar](255)     NULL,
  D04_29_14     [nvarchar](255)     NULL,
  D05_01_14     [nvarchar](255)     NULL,
  D05_06_14     [nvarchar](255)     NULL,--5
  D05_10_14     [nvarchar](255)     NULL,
  D05_13_14     [nvarchar](255)     NULL,
  D05_25_14     [nvarchar](255)     NULL,
  D05_27_14     [nvarchar](255)     NULL,
  D05_30_14     [nvarchar](255)     NULL,--10
  D06_08_14     [nvarchar](255)     NULL,
  D06_12_14     [nvarchar](255)     NULL,
  D06_20_14     [nvarchar](255)     NULL,
  D06_24_14     [nvarchar](255)     NULL,
  D06_28_14     [nvarchar](255)     NULL,--15
  D06_29_14     [nvarchar](255)     NULL,
  D07_02_14     [nvarchar](255)     NULL,
  D07_06_14     [nvarchar](255)     NULL,
  D07_10_14     [nvarchar](255)     NULL,
  D07_14_14     [nvarchar](255)     NULL,--20
  D07_18_14     [nvarchar](255)     NULL,
  D07_21_14     [nvarchar](255)     NULL,
  D07_24_14     [nvarchar](255)     NULL,
  D07_26_14     [nvarchar](255)     NULL,
  D07_29_14     [nvarchar](255)     NULL,--25
  D08_02_14     [nvarchar](255)     NULL,
  D08_09_14     [nvarchar](255)     NULL,
  D08_13_14     [nvarchar](255)     NULL,
  D08_16_14     [nvarchar](255)     NULL,
  D08_21_14     [nvarchar](255)     NULL,--30
  D08_24_14     [nvarchar](255)     NULL,
  D09_01_14     [nvarchar](255)     NULL,
  D09_03_14     [nvarchar](255)     NULL,
  D09_18_14     [nvarchar](255)     NULL,
  D09_21_14     [nvarchar](255)     NULL,--35
  D09_25_14     [nvarchar](255)     NULL,
  D10_24_14     [nvarchar](255)     NULL,
  D11_25_14     [nvarchar](255)     NULL,
  D11_27_14     [nvarchar](255)     NULL,
  D12_23_14     [nvarchar](255)     NULL,--40 weeks
--
PRIMARY KEY (MyAnalyteCode,mShore)
)
-- this is the file to select on the SSMS Import, SSMS will import
--the 63 rows and 40+ columns into this table




select * from MihalkaRawVarChars
-- 63

-- convert text string 'NULL' to internal MS-SQL NULL
UPDATE MihalkaRawVarChars SET D04_21_14=NULL WHERE D04_21_14= 'NULL'--1  -- 11
UPDATE MihalkaRawVarChars SET D04_26_14=NULL WHERE D04_26_14= 'NULL'	 -- 12
UPDATE MihalkaRawVarChars SET D04_29_14=NULL WHERE D04_29_14= 'NULL'	 -- 14
UPDATE MihalkaRawVarChars SET D05_01_14=NULL WHERE D05_01_14= 'NULL'	 -- 18
UPDATE MihalkaRawVarChars SET D05_06_14=NULL WHERE D05_06_14= 'NULL'--5  -- 15
UPDATE MihalkaRawVarChars SET D05_10_14=NULL WHERE D05_10_14= 'NULL'	 -- 15
UPDATE MihalkaRawVarChars SET D05_13_14=NULL WHERE D05_13_14= 'NULL'	 -- 33
UPDATE MihalkaRawVarChars SET D05_25_14=NULL WHERE D05_25_14= 'NULL'	 -- 37
UPDATE MihalkaRawVarChars SET D05_27_14=NULL WHERE D05_27_14= 'NULL'	 -- 30
UPDATE MihalkaRawVarChars SET D05_30_14=NULL WHERE D05_30_14= 'NULL'--10 -- 21
--
UPDATE MihalkaRawVarChars SET D06_08_14=NULL WHERE D06_08_14= 'NULL'	 -- 28
UPDATE MihalkaRawVarChars SET D06_12_14=NULL WHERE D06_12_14= 'NULL'	 -- 20
UPDATE MihalkaRawVarChars SET D06_20_14=NULL WHERE D06_20_14= 'NULL'	 -- 21
UPDATE MihalkaRawVarChars SET D06_24_14=NULL WHERE D06_24_14= 'NULL'	 -- 21
UPDATE MihalkaRawVarChars SET D06_28_14=NULL WHERE D06_28_14= 'NULL'--15 -- 56
UPDATE MihalkaRawVarChars SET D06_29_14=NULL WHERE D06_29_14= 'NULL'	 -- 18
UPDATE MihalkaRawVarChars SET D07_02_14=NULL WHERE D07_02_14= 'NULL'	 -- 0
UPDATE MihalkaRawVarChars SET D07_06_14=NULL WHERE D07_06_14= 'NULL'	 -- 56
UPDATE MihalkaRawVarChars SET D07_10_14=NULL WHERE D07_10_14= 'NULL'	 -- 0
UPDATE MihalkaRawVarChars SET D07_14_14=NULL WHERE D07_14_14= 'NULL'--20 -- 0
--
UPDATE MihalkaRawVarChars SET D07_18_14=NULL WHERE D07_18_14= 'NULL'	 -- 0
UPDATE MihalkaRawVarChars SET D07_21_14=NULL WHERE D07_21_14= 'NULL'	 -- 4
UPDATE MihalkaRawVarChars SET D07_24_14=NULL WHERE D07_24_14= 'NULL'	 -- 28
UPDATE MihalkaRawVarChars SET D07_26_14=NULL WHERE D07_26_14= 'NULL'	 -- 0
UPDATE MihalkaRawVarChars SET D07_29_14=NULL WHERE D07_29_14= 'NULL'--25 -- 0
UPDATE MihalkaRawVarChars SET D08_02_14=NULL WHERE D08_02_14= 'NULL'	 -- 0
UPDATE MihalkaRawVarChars SET D08_09_14=NULL WHERE D08_09_14= 'NULL'	 -- 0
UPDATE MihalkaRawVarChars SET D08_13_14=NULL WHERE D08_13_14= 'NULL'	 -- 7
UPDATE MihalkaRawVarChars SET D08_16_14=NULL WHERE D08_16_14= 'NULL'	 -- 0
UPDATE MihalkaRawVarChars SET D08_21_14=NULL WHERE D08_21_14= 'NULL'--30 -- 0
--
UPDATE MihalkaRawVarChars SET D08_24_14=NULL WHERE D08_24_14= 'NULL'     -- 0
UPDATE MihalkaRawVarChars SET D09_01_14=NULL WHERE D09_01_14= 'NULL'     -- 0
UPDATE MihalkaRawVarChars SET D09_03_14=NULL WHERE D09_03_14= 'NULL'     -- 0
UPDATE MihalkaRawVarChars SET D09_18_14=NULL WHERE D09_18_14= 'NULL'     -- 0
UPDATE MihalkaRawVarChars SET D09_21_14=NULL WHERE D09_21_14= 'NULL'--35 -- 0
UPDATE MihalkaRawVarChars SET D09_25_14=NULL WHERE D09_25_14= 'NULL'     -- 0
UPDATE MihalkaRawVarChars SET D10_24_14=NULL WHERE D10_24_14= 'NULL'     -- 7
UPDATE MihalkaRawVarChars SET D11_25_14=NULL WHERE D11_25_14= 'NULL'     -- 0
UPDATE MihalkaRawVarChars SET D11_27_14=NULL WHERE D11_27_14= 'NULL'     -- 0
UPDATE MihalkaRawVarChars SET D12_23_14=NULL WHERE D12_23_14= 'NULL'--40 -- 0

select * from MihalkaRawVarChars

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
-- our working raw table includes same fields as VarChars but with desired data types
-- and additional working fields

--   DROP TABLE MihalkaRaw
CREATE TABLE MihalkaRaw (
  MyAnalyteCode [nvarchar](255) NOT NULL,
  mShore        [int]           NOT NULL,

  D04_21_14     [numeric](38,8)     NULL,
  D04_26_14     [numeric](38,8)     NULL,
  D04_29_14     [numeric](38,8)     NULL,
  D05_01_14     [numeric](38,8)     NULL,
  D05_06_14     [numeric](38,8)     NULL,
  D05_10_14     [numeric](38,8)     NULL,
  D05_13_14     [numeric](38,8)     NULL,
  D05_25_14     [numeric](38,8)     NULL,
  D05_27_14     [numeric](38,8)     NULL,
  D05_30_14     [numeric](38,8)     NULL,
  D06_08_14     [numeric](38,8)     NULL,
  D06_12_14     [numeric](38,8)     NULL,
  D06_20_14     [numeric](38,8)     NULL,
  D06_24_14     [numeric](38,8)     NULL,
  D06_28_14     [numeric](38,8)     NULL,
  D06_29_14     [numeric](38,8)     NULL,

  D07_02_14     [numeric](38,8)     NULL,
  D07_06_14     [numeric](38,8)     NULL,
  D07_10_14     [numeric](38,8)     NULL,
  D07_14_14     [numeric](38,8)     NULL,
  D07_18_14     [numeric](38,8)     NULL,
  D07_21_14     [numeric](38,8)     NULL,
  D07_24_14     [numeric](38,8)     NULL,
  D07_26_14     [numeric](38,8)     NULL,
  D07_29_14     [numeric](38,8)     NULL,
  D08_02_14     [numeric](38,8)     NULL,
  D08_09_14     [numeric](38,8)     NULL,
  D08_13_14     [numeric](38,8)     NULL,
  D08_16_14     [numeric](38,8)     NULL,
  D08_21_14     [numeric](38,8)     NULL,
  D08_24_14     [numeric](38,8)     NULL,
  D09_01_14     [numeric](38,8)     NULL,
  D09_03_14     [numeric](38,8)     NULL,
  D09_18_14     [numeric](38,8)     NULL,
  D09_21_14     [numeric](38,8)     NULL,
  D09_25_14     [numeric](38,8)     NULL,
  D10_24_14     [numeric](38,8)     NULL,
  D11_25_14     [numeric](38,8)     NULL,
  D11_27_14     [numeric](38,8)     NULL,
  D12_23_14     [numeric](38,8)     NULL,

-- new fields I added to needed to prepare for geodatbase and Esri
   MyCoreName      [nvarchar](255)        NULL,
   MyLabel         [nvarchar](255)        NULL,
   AnalyteList     [nvarchar](255)        NULL,

   MyLatLong       [nvarchar](255)        NULL,
   MyLatitude      [nvarchar](255)        NULL,
   POINT_Y         [numeric](38,8)        NULL,
   POINT_X         [numeric](38,8)        NULL,

   RawUniq         [uniqueidentifier] NOT NULL,
PRIMARY KEY (MyAnalyteCode,mShore)
)
--
select *  FROM MihalkaRaw
-- 63 rows
/*
*/
-- 63
-- Insert from table 'MihalkaRawVarChars' above into MihalkaRaw
-------
--   

--  INSERT INTO MihalkaRaw
SELECT 
MyAnalyteCode,
CAST(mShore as int),
--
CAST(D04_21_14 as numeric(38,8)),
CAST(D04_26_14 as numeric(38,8)),
CAST(D04_29_14 as numeric(38,8)),
CAST(D05_01_14 as numeric(38,8)),
CAST(D05_06_14 as numeric(38,8)),
CAST(D05_10_14 as numeric(38,8)),
CAST(D05_13_14 as numeric(38,8)),
CAST(D05_25_14 as numeric(38,8)),
CAST(D05_27_14 as numeric(38,8)),
CAST(D05_30_14 as numeric(38,8)),
CAST(D06_08_14 as numeric(38,8)),
CAST(D06_12_14 as numeric(38,8)),
CAST(D06_20_14 as numeric(38,8)),
CAST(D06_24_14 as numeric(38,8)),
CAST(D06_28_14 as numeric(38,8)),
CAST(D06_29_14 as numeric(38,8)),

CAST(D07_02_14 as numeric(38,8)),
CAST(D07_06_14 as numeric(38,8)),
CAST(D07_10_14 as numeric(38,8)),
CAST(D07_14_14 as numeric(38,8)),
CAST(D07_18_14 as numeric(38,8)),
CAST(D07_21_14 as numeric(38,8)),
CAST(D07_24_14 as numeric(38,8)),
CAST(D07_26_14 as numeric(38,8)),
CAST(D07_29_14 as numeric(38,8)),
CAST(D08_02_14 as numeric(38,8)),
CAST(D08_09_14 as numeric(38,8)),
CAST(D08_13_14 as numeric(38,8)),
CAST(D08_16_14 as numeric(38,8)),
CAST(D08_21_14 as numeric(38,8)),
CAST(D08_24_14 as numeric(38,8)),

CAST(D09_01_14 as numeric(38,8)),
CAST(D09_03_14 as numeric(38,8)),
CAST(D09_18_14 as numeric(38,8)),
CAST(D09_21_14 as numeric(38,8)),
CAST(D09_25_14 as numeric(38,8)),
CAST(D10_24_14 as numeric(38,8)),
CAST(D11_25_14 as numeric(38,8)),
CAST(D11_27_14 as numeric(38,8)),
CAST(REPLACE(D12_23_14,' ','') as numeric(38,8)), -- some weird space(s) found, remove

NULL,NULL, --MyCoreName ,MyLabel    
NULL,      --AnalyteList
NULL,      -- MyLatLong  
NULL,      -- MyLatitude 
NULL,NULL, -- POINT_Y,POINT_X    
newid()    -- RawUniq    

FROM MihalkaRawVarChars
ORDER BY MyAnalyteCode,mShore
--63  rows affected

select * from MihalkaRaw order by MyAnalyteCode,mShore

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--------------------------------------------------------------------------
--  DROP TABLE [dbo].[MihalkaFCStation]
CREATE TABLE [dbo].[MihalkaFCStation](
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
	[GeoUniq] [uniqueidentifier] NOT NULL,
	[StatUniq] [uniqueidentifier] NOT NULL,
	[RawUniq] [uniqueidentifier] NOT NULL,

 PRIMARY KEY (pkStation)
 ) 

select * from MihalkaFCStation order by mShore

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- load the FCStation table using INSERTS
--   delete from MihalkaFCStation
declare @MiddleName nvarchar(255) = 'KeauhouBay_DMihalka_YWeeklyAprToDec2014_'
----------------------------
-- 001m
INSERT INTO MihalkaFCStation VALUES (
'19_5620_001m_' + @MiddleName + 'KYK', -- pkStation
'BoatRamp 001m', -- Label
NULL,            -- TablePage
'001m',          -- fkStation1
NULL,            -- fkStation2
1,               -- mShore
--
3440,            -- dmStA
4699,3799,7110,	 -- dmStAA,dmStBott,dmStClas
4660,			 -- dmAccuracy
8855,			 -- dmStReef
7777,			 -- dmStRule
333,			 -- dmStType
--
NULL,NULL,       -- fkEPA, fkUSGS
'Yes',           -- Embayment
NULL,NULL,       -- VolumeBay,CrossArea 
195620,          -- AttachSt
NULL,NULL,NULL,NULL,NULL,'19.56196, -155.96213',NULL, -- dmAccu4610-4670
'4/21/2014 06:20:01 AM','12/23/2014 8:00:01 AM',      -- StartDate,EndDate
NULL,NULL,NULL,NULL,NULL,    -- 5 extra fields
--
-155.96213, 19.56196,   -- XField, YField Station#1 001m
--
90,                     -- Rotation
0,                      -- Normalize
0,                      -- Weight
0,NULL,                 -- PageQuery/S
--					    
newid(),newid(),newid() -- GeoUniq,StatUniq,RawUniq
)
----------------------------
-- 010m
INSERT INTO MihalkaFCStation VALUES (
'19_5620_010m_' + @MiddleName + 'KYK', -- pkStation
'ParkingLotAdj 010m', -- Label
NULL,            -- TablePage
'010m',          -- fkStation1
NULL,            -- fkStation2
10,              -- mShore
--
3440,            -- dmStA
4699,3799,7110,	 -- dmStAA,dmStBott,dmStClas
4660,			 -- dmAccuracy
8855,			 -- dmStReef
7777,			 -- dmStRule
333,			 -- dmStType
--
NULL,NULL,       -- fkEPA, fkUSGS
'Yes',           -- Embayment
NULL,NULL,       -- VolumeBay,CrossArea 
195620,          -- AttachSt
NULL,NULL,'19d33m43.10sN 155d57m43.43sW',NULL,NULL,'19.56193, -155.96221',NULL,  -- dmAccu4610-4670
'4/21/2014 06:20:02 AM','12/23/2014 8:00:02 AM',      -- StartDate,EndDate
NULL,NULL,NULL,NULL,NULL,    -- 5 extra fields
--
-155.96221, 19.56193,   -- XField, YField Station#1 010m
--
-90,                    -- Rotation
0,                      -- Normalize
0,                      -- Weight
0,NULL,                 -- PageQueryI/S
--					    
newid(),newid(),newid() -- GeoUniq,StatUniq,RawUniq
)
----------------------------
-- 50m
INSERT INTO MihalkaFCStation VALUES (
'19_5618_050m_' + @MiddleName + 'KYK', -- pkStation
'Boat 050m',     -- Label
NULL,            -- TablePage
'050m',          -- fkStation1
NULL,            -- fkStation2
50,              -- mShore
--
3440,            -- dmStA
4699,3799,7110,	 -- dmStAA,dmStBott,dmStClas
4660,			 -- dmAccuracy
8855,			 -- dmStReef
7777,			 -- dmStRule
333,			 -- dmStType
--
NULL,NULL,       -- fkEPA, fkUSGS
'Yes',           -- Embayment
NULL,NULL,       -- VolumeBay,CrossArea 
195618,          -- AttachSt
NULL,NULL,'19d33m42.63sN 155d57m44.68sW',NULL,NULL, '19.5618, -155.96258',NULL,  -- dmAccu4610-4670
'4/21/2014 06:20:03 AM','12/23/2014 8:00:03 AM',      -- StartDate,EndDate
NULL,NULL,NULL,NULL,NULL,    -- 5 extra fields
--
-155.96258, 19.5618,   -- XField, YField Station#1 050m
--
90,                     -- Rotation
0,                      -- Normalize
0,                      -- Weight
0,NULL,                 -- PageQueryI/S
--					    
newid(),newid(),newid() -- GeoUniq,StatUniq,RawUniq
)
----------------------------
-- 100m
INSERT INTO MihalkaFCStation VALUES (
'19_5616_100m_' + @MiddleName + 'KYK', -- pkStation
'Anelakai 100m', -- Label
NULL,            -- TablePage
'100m',          -- fkStation1
NULL,            -- fkStation2
100,             -- mShore
--
3440,            -- dmStA
4699,3799,7110,	 -- dmStAA,dmStBott,dmStClas
4660,			 -- dmAccuracy
8855,			 -- dmStReef
7777,			 -- dmStRule
333,			 -- dmStType
--
NULL,NULL,       -- fkEPA, fkUSGS
'Yes',           -- Embayment
NULL,NULL,       -- VolumeBay,CrossArea 
195618,          -- AttachSt
NULL,NULL,'19d33m42.05sN 155d57m46.38sW',NULL,NULL,'19.56163, -155.96301',NULL,  -- dmAccu4610-4670
'4/21/2014 06:20:04 AM','12/23/2014 8:00:04 AM',      -- StartDate,EndDate
NULL,NULL,NULL,NULL,NULL,    -- 5 extra fields
--
-155.96301, 19.56163,   -- XField, YField Station#1 100m
--
-270,                   -- Rotation
0,                      -- Normalize
0,                      -- Weight
0,NULL,                 -- PageQueryI/S
--					    
newid(),newid(),newid() -- GeoUniq,StatUniq,RawUniq
)
----------------------------
-- 250m
INSERT INTO MihalkaFCStation VALUES (
'19_5611_250m_' + @MiddleName + 'KYK', -- pkStation
'Fish 250m', -- Label
NULL,            -- TablePage
'250m',          -- fkStation1
NULL,            -- fkStation2
250,             -- mShore
--
3440,            -- dmStA
4699,3799,7110,	 -- dmStAA,dmStBott,dmStClas
4660,			 -- dmAccuracy
8855,			 -- dmStReef
7777,			 -- dmStRule
333,			 -- dmStType
--
NULL,NULL,       -- fkEPA, fkUSGS
'Yes',           -- Embayment
NULL,NULL,       -- VolumeBay,CrossArea 
195616,          -- AttachSt
NULL,NULL,'19d33m40.37sN 155d57m51.19sW',NULL,NULL,'19.56114, -155.96434',NULL,  -- dmAccu4610-4670
'4/21/2014 06:20:05 AM','12/23/2014 8:00:05 AM',      -- StartDate,EndDate
NULL,NULL,NULL,NULL,NULL,    -- 5 extra fields
--
-155.96434, 19.561114,   -- XField, YField Station#1 250m
--
90,                     -- Rotation
0,                      -- Normalize
0,                      -- Weight
0,NULL,                 -- PageQueryI/S
--					    
newid(),newid(),newid() -- GeoUniq,StatUniq,RawUniq
)
----------------------------
-- 500m
INSERT INTO MihalkaFCStation VALUES (
'19_5604_500m_' + @MiddleName + 'KYK', -- pkStation
'Rays 500m',     -- Label
NULL,            -- TablePage
'500m',          -- fkStation1
NULL,            -- fkStation2
500,             -- mShore
--
3440,            -- dmStA
4699,3799,7110,	 -- dmStAA,dmStBott,dmStClas
4660,			 -- dmAccuracy
8855,			 -- dmStReef
7777,			 -- dmStRule
333,			 -- dmStType
--
NULL,NULL,       -- fkEPA, fkUSGS
'Yes',           -- Embayment
NULL,NULL,       -- VolumeBay,CrossArea 
195604,          -- AttachSt
NULL,NULL,'19d33m37.55sN 155d57m59.20sW',NULL,NULL,'19.56035, -155.96658',NULL,  -- dmAccu4610-4670
'4/21/2014 06:20:06 AM','12/23/2014 8:00:06 AM',      -- StartDate,EndDate
NULL,NULL,NULL,NULL,NULL,    -- 5 extra fields
--
-155.96658, 19.56035,   -- XField, YField Station#1 500m
--
-270,                   -- Rotation
0,                      -- Normalize
0,                      -- Weight
0,NULL,                 -- PageQueryI/S
--					    
newid(),newid(),newid() -- GeoUniq,StatUniq,RawUniq
)
----------------------------
-- 800m 
INSERT INTO MihalkaFCStation VALUES (
'19_5594_800m_' + @MiddleName + 'KYK', -- pkStation
'Kaukalaelae 800m', -- Label
NULL,               -- TablePage
'800m',             -- fkStation1
NULL,               -- fkStation2
800,                -- mShore
--
3440,            -- dmStA
4699,3799,7110,	 -- dmStAA,dmStBott,dmStClas
4660,			 -- dmAccuracy
8855,			 -- dmStReef
7777,			 -- dmStRule
333,			 -- dmStType
--
NULL,NULL,       -- fkEPA, fkUSGS
'Yes',           -- Embayment
NULL,NULL,       -- VolumeBay,CrossArea 
195594,          -- AttachSt
NULL,NULL,'19d33m34.14sN 155d58m8.79sW' ,NULL,NULL,'19.55939, -155.96929',NULL,  -- dmAccu4610-4670
'4/21/2014 06:20:07 AM','12/23/2014 8:00:07 AM',      -- StartDate,EndDate
NULL,NULL,NULL,NULL,NULL,    -- 5 extra fields
--
-155.96929, 19.55939,   -- XField, YField Station#1 800m
--
90,                     -- Rotation
0,                      -- Normalize
0,                      -- Weight
0,NULL,                 -- PageQueryI/S
--					    
newid(),newid(),newid() -- GeoUniq,StatUniq,RawUniq
)
--
select * from MihalkaFCStation order by mShore
-- 7


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

select * from MihalkaFCStation order by mShore
select * from MihalkaRaw order by mShore

--   DROP TABLE MihalkaTBSample_MinTemp
CREATE TABLE MihalkaTBSample_MinTemp (
  StationNum  [int]              NOT NULL,
  DateColumnM [nvarchar](255)    NOT NULL,
  mShore      [int]              NOT NULL,
  SampleDate  [datetime2](7)     NOT NULL,
--
  mShoreTm    [nvarchar](255)        NULL,
  SampUniq    [uniqueidentifier] NOT NULL,

PRIMARY KEY (DateColumnM, mShore)
)

--  delete from MihalkaTBSample_MinTemp
-- let's really touch all this work this guy did! 40 weeks, 7 stations

-- D04_21_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D04_21_14',001,'04/21/14 6:20:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D04_21_14',010,'04/21/14 6:20:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D04_21_14',050,'04/21/14 6:20:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D04_21_14',100,'04/21/14 6:20:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D04_21_14',250,'04/21/14 6:20:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D04_21_14',500,'04/21/14 6:20:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D04_21_14',800,'04/21/14 6:20:07 AM','800m', newid()
-- D04_26_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D04_26_14',001,'04/26/14 7:58:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D04_26_14',010,'04/26/14 7:58:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D04_26_14',050,'04/26/14 7:58:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D04_26_14',100,'04/26/14 7:58:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D04_26_14',250,'04/26/14 7:58:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D04_26_14',500,'04/26/14 7:58:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D04_26_14',800,'04/26/14 7:58:07 AM','800m', newid()
-- D04_29_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D04_29_14',001,'04/29/14 7:55:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D04_29_14',010,'04/29/14 7:55:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D04_29_14',050,'04/29/14 7:55:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D04_29_14',100,'04/29/14 7:55:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D04_29_14',250,'04/29/14 7:55:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D04_29_14',500,'04/29/14 7:55:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D04_29_14',800,'04/29/14 7:55:07 AM','800m', newid()
-- D05_01_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D05_01_14',001,'05/01/14 6:35:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D05_01_14',010,'05/01/14 6:35:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D05_01_14',050,'05/01/14 6:35:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D05_01_14',100,'05/01/14 6:35:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D05_01_14',250,'05/01/14 6:35:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D05_01_14',500,'05/01/14 6:35:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D05_01_14',800,'05/01/14 6:35:07 AM','800m', newid()
-- D05_06_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D05_06_14',001,'05/06/14 7:38:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D05_06_14',010,'05/06/14 7:38:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D05_06_14',050,'05/06/14 7:38:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D05_06_14',100,'05/06/14 7:38:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D05_06_14',250,'05/06/14 7:38:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D05_06_14',500,'05/06/14 7:38:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D05_06_14',800,'05/06/14 7:38:07 AM','800m', newid()
-- D05_10_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D05_10_14',001,'05/10/14 7:37:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D05_10_14',010,'05/10/14 7:37:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D05_10_14',050,'05/10/14 7:37:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D05_10_14',100,'05/10/14 7:37:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D05_10_14',250,'05/10/14 7:37:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D05_10_14',500,'05/10/14 7:37:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D05_10_14',800,'05/10/14 7:37:07 AM','800m', newid()
-- D05_13_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D05_13_14',001,'05/13/14 7:34:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D05_13_14',010,'05/13/14 7:34:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D05_13_14',050,'05/13/14 7:34:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D05_13_14',100,'05/13/14 7:34:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D05_13_14',250,'05/13/14 7:34:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D05_13_14',500,'05/13/14 7:34:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D05_13_14',800,'05/13/14 7:34:07 AM','800m', newid()
-- D05_25_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D05_25_14',001,'05/25/14 11:25:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D05_25_14',010,'05/25/14 11:25:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D05_25_14',050,'05/25/14 11:25:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D05_25_14',100,'05/25/14 11:25:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D05_25_14',250,'05/25/14 11:25:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D05_25_14',500,'05/25/14 11:25:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D05_25_14',800,'05/25/14 11:25:07 AM','800m', newid()
-- D05_27_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D05_27_14',001,'05/27/14 9:40:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D05_27_14',010,'05/27/14 9:40:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D05_27_14',050,'05/27/14 9:40:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D05_27_14',100,'05/27/14 9:40:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D05_27_14',250,'05/27/14 9:40:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D05_27_14',500,'05/27/14 9:40:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D05_27_14',800,'05/27/14 9:40:07 AM','800m', newid()
-- D05_30_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D05_30_14',001,'05/30/14 5:39:01 PM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D05_30_14',010,'05/30/14 5:39:02 PM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D05_30_14',050,'05/30/14 5:39:03 PM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D05_30_14',100,'05/30/14 5:39:04 PM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D05_30_14',250,'05/30/14 5:39:05 PM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D05_30_14',500,'05/30/14 5:39:06 PM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D05_30_14',800,'05/30/14 5:39:07 PM','800m', newid()
-- D06_08_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D06_08_14',001,'06/08/14 4:17:01 PM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D06_08_14',010,'06/08/14 4:17:02 PM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D06_08_14',050,'06/08/14 4:17:03 PM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D06_08_14',100,'06/08/14 4:17:04 PM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D06_08_14',250,'06/08/14 4:17:05 PM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D06_08_14',500,'06/08/14 4:17:06 PM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D06_08_14',800,'06/08/14 4:17:07 PM','800m', newid()
-- D06_12_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D06_12_14',001,'06/12/14 3:23:01 PM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D06_12_14',010,'06/12/14 3:23:02 PM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D06_12_14',050,'06/12/14 3:23:03 PM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D06_12_14',100,'06/12/14 3:23:04 PM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D06_12_14',250,'06/12/14 3:23:05 PM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D06_12_14',500,'06/12/14 3:23:06 PM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D06_12_14',800,'06/12/14 3:23:07 PM','800m', newid()
-- D06_20_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D06_20_14',001,'06/20/14 4:08:01 PM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D06_20_14',010,'06/20/14 4:08:02 PM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D06_20_14',050,'06/20/14 4:08:03 PM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D06_20_14',100,'06/20/14 4:08:04 PM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D06_20_14',250,'06/20/14 4:08:05 PM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D06_20_14',500,'06/20/14 4:08:06 PM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D06_20_14',800,'06/20/14 4:08:07 PM','800m', newid()
-- D06_24_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D06_24_14',001,'06/24/14 8:05:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D06_24_14',010,'06/24/14 8:05:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D06_24_14',050,'06/24/14 8:05:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D06_24_14',100,'06/24/14 8:05:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D06_24_14',250,'06/24/14 8:05:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D06_24_14',500,'06/24/14 8:05:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D06_24_14',800,'06/24/14 8:05:07 AM','800m', newid()
-- D06_28_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D06_28_14',001,'06/28/14 8:00:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D06_28_14',010,'06/28/14 8:00:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D06_28_14',050,'06/28/14 8:00:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D06_28_14',100,'06/28/14 8:00:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D06_28_14',250,'06/28/14 8:00:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D06_28_14',500,'06/28/14 8:00:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D06_28_14',800,'06/28/14 8:00:07 AM','800m', newid()
-- D06_29_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D06_29_14',001,'06/29/14 8:05:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D06_29_14',010,'06/29/14 8:05:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D06_29_14',050,'06/29/14 8:05:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D06_29_14',100,'06/29/14 8:05:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D06_29_14',250,'06/29/14 8:05:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D06_29_14',500,'06/29/14 8:05:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D06_29_14',800,'06/29/14 8:05:07 AM','800m', newid()
-- D07_02_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D07_02_14',001,'07/02/14 5:20:01 PM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D07_02_14',010,'07/02/14 5:20:02 PM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D07_02_14',050,'07/02/14 5:20:03 PM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D07_02_14',100,'07/02/14 5:20:04 PM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D07_02_14',250,'07/02/14 5:20:05 PM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D07_02_14',500,'07/02/14 5:20:06 PM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D07_02_14',800,'07/02/14 5:20:07 PM','800m', newid()
-- D07_06_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D07_06_14',001,'07/06/14 8:00:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D07_06_14',010,'07/06/14 8:00:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D07_06_14',050,'07/06/14 8:00:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D07_06_14',100,'07/06/14 8:00:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D07_06_14',250,'07/06/14 8:00:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D07_06_14',500,'07/06/14 8:00:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D07_06_14',800,'07/06/14 8:00:07 AM','800m', newid()
-- D07_10_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D07_10_14',001,'07/10/14 8:05:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D07_10_14',010,'07/10/14 8:05:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D07_10_14',050,'07/10/14 8:05:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D07_10_14',100,'07/10/14 8:05:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D07_10_14',250,'07/10/14 8:05:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D07_10_14',500,'07/10/14 8:05:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D07_10_14',800,'07/10/14 8:05:07 AM','800m', newid()
-- D07_14_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D07_14_14',001,'07/14/14 7:55:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D07_14_14',010,'07/14/14 7:55:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D07_14_14',050,'07/14/14 7:55:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D07_14_14',100,'07/14/14 7:55:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D07_14_14',250,'07/14/14 7:55:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D07_14_14',500,'07/14/14 7:55:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D07_14_14',800,'07/14/14 7:55:07 AM','800m', newid()
-- D07_18_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D07_18_14',001,'07/18/14 8:10:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D07_18_14',010,'07/18/14 8:10:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D07_18_14',050,'07/18/14 8:10:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D07_18_14',100,'07/18/14 8:10:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D07_18_14',250,'07/18/14 8:10:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D07_18_14',500,'07/18/14 8:10:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D07_18_14',800,'07/18/14 8:10:07 AM','800m', newid()
-- D07_210_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D07_21_14',001,'07/21/14 8:10:01 PM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D07_21_14',010,'07/21/14 8:10:02 PM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D07_21_14',050,'07/21/14 8:10:03 PM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D07_21_14',100,'07/21/14 8:10:04 PM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D07_21_14',250,'07/21/14 8:10:05 PM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D07_21_14',500,'07/21/14 8:10:06 PM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D07_21_14',800,'07/21/14 8:10:07 PM','800m', newid()
-- D7_24_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D07_24_14',001,'07/24/14 8:45:01 PM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D07_24_14',010,'07/24/14 8:45:02 PM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D07_24_14',050,'07/24/14 8:45:03 PM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D07_24_14',100,'07/24/14 8:45:04 PM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D07_24_14',250,'07/24/14 8:45:05 PM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D07_24_14',500,'07/24/14 8:45:06 PM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D07_24_14',800,'07/24/14 8:45:07 PM','800m', newid()
-- D07_26_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D07_26_14',001,'07/26/14 4:55:01 PM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D07_26_14',010,'07/26/14 4:55:02 PM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D07_26_14',050,'07/26/14 4:55:03 PM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D07_26_14',100,'07/26/14 4:55:04 PM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D07_26_14',250,'07/26/14 4:55:05 PM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D07_26_14',500,'07/26/14 4:55:06 PM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D07_26_14',800,'07/26/14 4:55:07 PM','800m', newid()
-- D07_29_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D07_29_14',001,'07/29/14 4:45:01 PM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D07_29_14',010,'07/29/14 4:45:02 PM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D07_29_14',050,'07/29/14 4:45:03 PM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D07_29_14',100,'07/29/14 4:45:04 PM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D07_29_14',250,'07/29/14 4:45:05 PM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D07_29_14',500,'07/29/14 4:45:06 PM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D07_29_14',800,'07/29/14 4:45:07 PM','800m', newid()
-- D08_02_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D08_02_14',001,'08/02/14 3:50:01 PM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D08_02_14',010,'08/02/14 3:50:02 PM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D08_02_14',050,'08/02/14 3:50:03 PM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D08_02_14',100,'08/02/14 3:50:04 PM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D08_02_14',250,'08/02/14 3:50:05 PM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D08_02_14',500,'08/02/14 3:50:06 PM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D08_02_14',800,'08/02/14 3:50:07 PM','800m', newid()
-- D08_09_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D08_09_14',001,'08/09/14 8:27:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D08_09_14',010,'08/09/14 8:27:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D08_09_14',050,'08/09/14 8:27:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D08_09_14',100,'08/09/14 8:27:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D08_09_14',250,'08/09/14 8:27:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D08_09_14',500,'08/09/14 8:27:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D08_09_14',800,'08/09/14 8:27:07 AM','800m', newid()
-- D08_13_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D08_13_14',001,'08/13/14 7:56:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D08_13_14',010,'08/13/14 7:56:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D08_13_14',050,'08/13/14 7:56:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D08_13_14',100,'08/13/14 7:56:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D08_13_14',250,'08/13/14 7:56:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D08_13_14',500,'08/13/14 7:56:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D08_13_14',800,'08/13/14 7:56:07 AM','800m', newid()
-- D08_16_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D08_16_14',001,'08/16/14 4:18:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D08_16_14',010,'08/16/14 4:18:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D08_16_14',050,'08/16/14 4:18:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D08_16_14',100,'08/16/14 4:18:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D08_16_14',250,'08/16/14 4:18:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D08_16_14',500,'08/16/14 4:18:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D08_16_14',800,'08/16/14 4:18:07 AM','800m', newid()
-- D08_21_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D08_21_14',001,'08/21/14 4:35:01 PM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D08_21_14',010,'08/21/14 4:35:02 PM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D08_21_14',050,'08/21/14 4:35:03 PM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D08_21_14',100,'08/21/14 4:35:04 PM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D08_21_14',250,'08/21/14 4:35:05 PM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D08_21_14',500,'08/21/14 4:35:06 PM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D08_21_14',800,'08/21/14 4:35:07 PM','800m', newid()
-- D08_24_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D08_24_14',001,'08/24/14 12:10:01 PM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D08_24_14',010,'08/24/14 12:10:02 PM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D08_24_14',050,'08/24/14 12:10:03 PM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D08_24_14',100,'08/24/14 12:10:04 PM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D08_24_14',250,'08/24/14 12:10:05 PM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D08_24_14',500,'08/24/14 12:10:06 PM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D08_24_14',800,'08/24/14 12:10:07 PM','800m', newid()
-- D09_01_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D09_01_14',001,'09/01/14 7:55:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D09_01_14',010,'09/01/14 7:55:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D09_01_14',050,'09/01/14 7:55:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D09_01_14',100,'09/01/14 7:55:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D09_01_14',250,'09/01/14 7:55:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D09_01_14',500,'09/01/14 7:55:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D09_01_14',800,'09/01/14 7:55:07 AM','800m', newid()
-- D09_03_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D09_03_14',001,'09/03/14 7:55:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D09_03_14',010,'09/03/14 7:55:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D09_03_14',050,'09/03/14 7:55:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D09_03_14',100,'09/03/14 7:55:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D09_03_14',250,'09/03/14 7:55:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D09_03_14',500,'09/03/14 7:55:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D09_03_14',800,'09/03/14 7:55:07 AM','800m', newid()
-- D09_18_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D09_18_14',001,'09/18/14 8:14:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D09_18_14',010,'09/18/14 8:14:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D09_18_14',050,'09/18/14 8:14:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D09_18_14',100,'09/18/14 8:14:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D09_18_14',250,'09/18/14 8:14:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D09_18_14',500,'09/18/14 8:14:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D09_18_14',800,'09/18/14 8:14:07 AM','800m', newid()
-- D09_21_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D09_21_14',001,'09/21/14 4:28:01 PM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D09_21_14',010,'09/21/14 4:28:02 PM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D09_21_14',050,'09/21/14 4:28:03 PM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D09_21_14',100,'09/21/14 4:28:04 PM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D09_21_14',250,'09/21/14 4:28:05 PM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D09_21_14',500,'09/21/14 4:28:06 PM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D09_21_14',800,'09/21/14 4:28:07 PM','800m', newid()
-- D09_25_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D09_25_14',001,'09/25/14 9:00:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D09_25_14',010,'09/25/14 9:00:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D09_25_14',050,'09/25/14 9:00:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D09_25_14',100,'09/25/14 9:00:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D09_25_14',250,'09/25/14 9:00:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D09_25_14',500,'09/25/14 9:00:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D09_25_14',800,'09/25/14 9:00:07 AM','800m', newid()
-- D10_24_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D10_24_14',001,'10/24/14 4:37:01 PM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D10_24_14',010,'10/24/14 4:37:02 PM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D10_24_14',050,'10/24/14 4:37:03 PM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D10_24_14',100,'10/24/14 4:37:04 PM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D10_24_14',250,'10/24/14 4:37:05 PM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D10_24_14',500,'10/24/14 4:37:06 PM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D10_24_14',800,'10/24/14 4:37:07 PM','800m', newid()
-- D11_25_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D11_25_14',001,'11/25/14 8:45:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D11_25_14',010,'11/25/14 8:45:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D11_25_14',050,'11/25/14 8:45:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D11_25_14',100,'11/25/14 8:45:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D11_25_14',250,'11/25/14 8:45:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D11_25_14',500,'11/25/14 8:45:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D11_25_14',800,'11/25/14 8:45:07 AM','800m', newid()
-- D11_27_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D11_27_14',001,'11/27/14 8:51:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D11_27_14',010,'11/27/14 8:51:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D11_27_14',050,'11/27/14 8:51:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D11_27_14',100,'11/27/14 8:51:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D11_27_14',250,'11/27/14 8:51:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D11_27_14',500,'11/27/14 8:51:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D11_27_14',800,'11/27/14 8:51:07 AM','800m', newid()
-- D12_23_14
INSERT INTO MihalkaTBSample_MinTemp SELECT 1,'D12_23_14',001,'12/23/14 8:00:01 AM','001m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 2,'D12_23_14',010,'12/23/14 8:00:02 AM','010m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 3,'D12_23_14',050,'12/23/14 8:00:03 AM','050m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 4,'D12_23_14',100,'12/23/14 8:00:04 AM','100m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 5,'D12_23_14',250,'12/23/14 8:00:05 AM','250m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 6,'D12_23_14',500,'12/23/14 8:00:06 AM','500m', newid()
INSERT INTO MihalkaTBSample_MinTemp SELECT 7,'D12_23_14',800,'12/23/14 8:00:07 AM','800m', newid()
--

select *  from MihalkaTBSample_MinTemp


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--  DROP TABLE MihalkaTBSample
CREATE TABLE MihalkaTBSample (
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
-------------------------------------------------------------------------------
--    delete from MihalkaTBSample
-- warning must be same as one from above FCStation
 declare @MiddleName nvarchar(255) = 'KeauhouBay_DMihalka_YWeeklyAprToDec2014_'

INSERT INTO MihalkaTBSample 
 SELECT 
'19_5620_' + mShoreTm + '_' + REPLACE(SUBSTRING(CONVERT(varchar, SampleDate, 109),1,6),' ','') + 
   '_' + @MiddleName + 'KYK40Weeks', -- pkSample

'KeauhouBay ' + mShoreTm + ' ' + cast(SampleDate as nvarchar),    -- Label

DateColumnM,            -- TablePage
0,                      -- AlertTrue
'<fkIDLoc>',            -- fkIDLoc
StationNum,				-- StationNum
mShore,					-- mShore
'<<<UPDATE>>>',         -- fkStation, same as above FCStation insert
NULL,                   -- fkStation2
'KeauhouBay',           -- fkProject
newid(),				-- fkUnqID 
'<fkOrg>',              -- fkOrg
1410,					-- dmSample
SampleDate,		        -- StartDate
SampleDate,		        -- EndDate  
'No',					-- TimeMissg 
'Medium',				-- Medium
'CompStat',				-- CompStat 
NULL,					-- Comment 
195620,				    -- AttachSa
0,						-- SaFloat1
0,		             	-- SaFloat2
NULL,	             	-- SaDate3 
NULL,	             	-- SaDate4 
0,		             	-- SaLong5 
0,0,0,1,NULL,           -- cartography fields
SampUniq,             	-- SampUniq
newid()	                -- RawUniq	   
FROM MihalkaTBSample_MinTemp m												   
ORDER BY m.SampleDate
--280


--    declare @MiddleName nvarchar(255) = 'KeauhouBay_DMihalka_YWeeklyAprToDec2014_'
--
UPDATE MihalkaTBSample SET fkStation = '19_5620_001m_' + @MiddleName + 'KYK' WHERE mShore = 001
UPDATE MihalkaTBSample SET fkStation = '19_5620_010m_' + @MiddleName + 'KYK' WHERE mShore = 010
UPDATE MihalkaTBSample SET fkStation = '19_5618_050m_' + @MiddleName + 'KYK' WHERE mShore = 050
UPDATE MihalkaTBSample SET fkStation = '19_5616_100m_' + @MiddleName + 'KYK' WHERE mShore = 100
UPDATE MihalkaTBSample SET fkStation = '19_5611_250m_' + @MiddleName + 'KYK' WHERE mShore = 250
UPDATE MihalkaTBSample SET fkStation = '19_5604_500m_' + @MiddleName + 'KYK' WHERE mShore = 500
UPDATE MihalkaTBSample SET fkStation = '19_5594_800m_' + @MiddleName + 'KYK' WHERE mShore = 800
-- 40 each



----------------------------------------
----------------------------------------
----------------------------------------
--
-- work on TBResult next


select pkStation from MihalkaFCStation order by mShore
/*
19_5620_001m_KeauhouBay_DMihalka_YWeeklyAprToDec2014_KYK
19_5620_010m_KeauhouBay_DMihalka_YWeeklyAprToDec2014_KYK
19_5618_050m_KeauhouBay_DMihalka_YWeeklyAprToDec2014_KYK
19_5616_100m_KeauhouBay_DMihalka_YWeeklyAprToDec2014_KYK
19_5611_250m_KeauhouBay_DMihalka_YWeeklyAprToDec2014_KYK
19_5604_500m_KeauhouBay_DMihalka_YWeeklyAprToDec2014_KYK
19_5594_800m_KeauhouBay_DMihalka_YWeeklyAprToDec2014_KYK
*/

select * from MihalkaTBSample
select fkStation from MihalkaTBSample
-- 280
select distinct(fkStation) from MihalkaTBSample
-- 7
/*
19_5620_001m_KeauhouBay_DMihalka_YWeeklyAprToDec2014_KYK
19_5620_010m_KeauhouBay_DMihalka_YWeeklyAprToDec2014_KYK
19_5618_050m_KeauhouBay_DMihalka_YWeeklyAprToDec2014_KYK
19_5616_100m_KeauhouBay_DMihalka_YWeeklyAprToDec2014_KYK
19_5611_250m_KeauhouBay_DMihalka_YWeeklyAprToDec2014_KYK
19_5604_500m_KeauhouBay_DMihalka_YWeeklyAprToDec2014_KYK
19_5594_800m_KeauhouBay_DMihalka_YWeeklyAprToDec2014_KYK
*/
19_5620_001m_KeauhouBay_DMihalka_YWeeklyAprToDec2014_KYK

-------------------------------------------------------------------------------
select * from MihalkaRawVarChars
select * from MihalkaTBSample order by tablepage,mShore


--------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------- 
--   DROP TABLE MihalkaTBResult_FirstPass
CREATE TABLE MihalkaTBResult_FirstPass (
	mShore        [int]              NOT NULL,
	DateColumn    [nvarchar](10)     NOT NULL,
	MyAnalyteCode [nvarchar](10)     NOT NULL,
    RawUniq       [uniqueidentifier] NOT NULL,

	Result        [numeric](38,8)        NULL,

PRIMARY KEY (mShore,DateColumn,MyAnalyteCode)
)
--   DELETE FROM MihalkaTBResult_FirstPass


 INSERT INTO MihalkaTBResult_FirstPass
SELECT distinct(mShore),'D04_21_14',MyAnalyteCode,RawUniq,D04_21_14 FROM MihalkaRaw WHERE D04_21_14 is NOT NULL UNION -- 1
SELECT distinct(mShore),'D04_26_14',MyAnalyteCode,RawUniq,D04_26_14 FROM MihalkaRaw WHERE D04_26_14 is NOT NULL UNION
SELECT distinct(mShore),'D04_29_14',MyAnalyteCode,RawUniq,D04_29_14 FROM MihalkaRaw WHERE D04_29_14 is NOT NULL UNION
SELECT distinct(mShore),'D05_01_14',MyAnalyteCode,RawUniq,D05_01_14 FROM MihalkaRaw WHERE D05_01_14 is NOT NULL UNION
SELECT distinct(mShore),'D05_06_14',MyAnalyteCode,RawUniq,D05_06_14 FROM MihalkaRaw WHERE D05_06_14 is NOT NULL UNION
SELECT distinct(mShore),'D05_10_14',MyAnalyteCode,RawUniq,D05_10_14 FROM MihalkaRaw WHERE D05_10_14 is NOT NULL UNION
SELECT distinct(mShore),'D05_13_14',MyAnalyteCode,RawUniq,D05_13_14 FROM MihalkaRaw WHERE D05_13_14 is NOT NULL UNION
SELECT distinct(mShore),'D05_25_14',MyAnalyteCode,RawUniq,D05_25_14 FROM MihalkaRaw WHERE D05_25_14 is NOT NULL UNION
SELECT distinct(mShore),'D05_27_14',MyAnalyteCode,RawUniq,D05_27_14 FROM MihalkaRaw WHERE D05_27_14 is NOT NULL UNION
SELECT distinct(mShore),'D05_30_14',MyAnalyteCode,RawUniq,D05_30_14 FROM MihalkaRaw WHERE D05_30_14 is NOT NULL UNION -- 10
SELECT distinct(mShore),'D06_08_14',MyAnalyteCode,RawUniq,D06_08_14 FROM MihalkaRaw WHERE D06_08_14 is NOT NULL UNION
SELECT distinct(mShore),'D06_12_14',MyAnalyteCode,RawUniq,D06_12_14 FROM MihalkaRaw WHERE D06_12_14 is NOT NULL UNION
SELECT distinct(mShore),'D06_20_14',MyAnalyteCode,RawUniq,D06_20_14 FROM MihalkaRaw WHERE D06_20_14 is NOT NULL UNION
SELECT distinct(mShore),'D06_24_14',MyAnalyteCode,RawUniq,D06_24_14 FROM MihalkaRaw WHERE D06_24_14 is NOT NULL UNION
SELECT distinct(mShore),'D06_28_14',MyAnalyteCode,RawUniq,D06_28_14 FROM MihalkaRaw WHERE D06_28_14 is NOT NULL UNION
SELECT distinct(mShore),'D06_29_14',MyAnalyteCode,RawUniq,D06_29_14 FROM MihalkaRaw WHERE D06_29_14 is NOT NULL UNION
SELECT distinct(mShore),'D07_02_14',MyAnalyteCode,RawUniq,D07_02_14 FROM MihalkaRaw WHERE D07_02_14 is NOT NULL UNION
SELECT distinct(mShore),'D07_06_14',MyAnalyteCode,RawUniq,D07_06_14 FROM MihalkaRaw WHERE D07_06_14 is NOT NULL UNION
SELECT distinct(mShore),'D07_10_14',MyAnalyteCode,RawUniq,D07_10_14 FROM MihalkaRaw WHERE D07_10_14 is NOT NULL UNION
SELECT distinct(mShore),'D07_14_14',MyAnalyteCode,RawUniq,D07_14_14 FROM MihalkaRaw WHERE D07_14_14 is NOT NULL UNION -- 20
SELECT distinct(mShore),'D07_18_14',MyAnalyteCode,RawUniq,D07_18_14 FROM MihalkaRaw WHERE D07_18_14 is NOT NULL UNION -- 21
SELECT distinct(mShore),'D07_21_14',MyAnalyteCode,RawUniq,D07_21_14 FROM MihalkaRaw WHERE D07_21_14 is NOT NULL UNION
SELECT distinct(mShore),'D07_24_14',MyAnalyteCode,RawUniq,D07_24_14 FROM MihalkaRaw WHERE D07_24_14 is NOT NULL UNION
SELECT distinct(mShore),'D07_26_14',MyAnalyteCode,RawUniq,D07_26_14 FROM MihalkaRaw WHERE D07_26_14 is NOT NULL UNION
SELECT distinct(mShore),'D07_29_14',MyAnalyteCode,RawUniq,D07_29_14 FROM MihalkaRaw WHERE D07_29_14 is NOT NULL UNION
SELECT distinct(mShore),'D08_02_14',MyAnalyteCode,RawUniq,D08_02_14 FROM MihalkaRaw WHERE D08_02_14 is NOT NULL UNION
SELECT distinct(mShore),'D08_09_14',MyAnalyteCode,RawUniq,D08_09_14 FROM MihalkaRaw WHERE D08_09_14 is NOT NULL UNION
SELECT distinct(mShore),'D08_13_14',MyAnalyteCode,RawUniq,D08_13_14 FROM MihalkaRaw WHERE D08_13_14 is NOT NULL UNION
SELECT distinct(mShore),'D08_16_14',MyAnalyteCode,RawUniq,D08_16_14 FROM MihalkaRaw WHERE D08_16_14 is NOT NULL UNION
SELECT distinct(mShore),'D08_21_14',MyAnalyteCode,RawUniq,D08_21_14 FROM MihalkaRaw WHERE D08_21_14 is NOT NULL UNION -- 30
SELECT distinct(mShore),'D08_24_14',MyAnalyteCode,RawUniq,D08_24_14 FROM MihalkaRaw WHERE D08_24_14 is NOT NULL UNION
SELECT distinct(mShore),'D09_01_14',MyAnalyteCode,RawUniq,D09_01_14 FROM MihalkaRaw WHERE D09_01_14 is NOT NULL UNION
SELECT distinct(mShore),'D09_03_14',MyAnalyteCode,RawUniq,D09_03_14 FROM MihalkaRaw WHERE D09_03_14 is NOT NULL UNION
SELECT distinct(mShore),'D09_18_14',MyAnalyteCode,RawUniq,D09_18_14 FROM MihalkaRaw WHERE D09_18_14 is NOT NULL UNION
SELECT distinct(mShore),'D09_21_14',MyAnalyteCode,RawUniq,D09_21_14 FROM MihalkaRaw WHERE D09_21_14 is NOT NULL UNION
SELECT distinct(mShore),'D09_25_14',MyAnalyteCode,RawUniq,D09_25_14 FROM MihalkaRaw WHERE D09_25_14 is NOT NULL UNION
SELECT distinct(mShore),'D10_24_14',MyAnalyteCode,RawUniq,D10_24_14 FROM MihalkaRaw WHERE D10_24_14 is NOT NULL UNION
SELECT distinct(mShore),'D11_25_14',MyAnalyteCode,RawUniq,D11_25_14 FROM MihalkaRaw WHERE D11_25_14 is NOT NULL UNION
SELECT distinct(mShore),'D11_27_14',MyAnalyteCode,RawUniq,D11_27_14 FROM MihalkaRaw WHERE D11_27_14 is NOT NULL UNION
SELECT distinct(mShore),'D12_23_14',MyAnalyteCode,RawUniq,D12_23_14 FROM MihalkaRaw WHERE D12_23_14 is NOT NULL      -- 40

select * from MihalkaTBResult_FirstPass order by mShore
-- 2048 rows



-----------------------------------------------------------------------------------------
-- now TBResult effort
--

--  DROP TABLE MihalkaTBResult
CREATE TABLE MihalkaTBResult(
	--[OBJECTID] [int] NOT NULL,
	[fkSample] [nvarchar](255) NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
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
--
	[RawUniq] [uniqueidentifier]  NOT NULL,
	[ResUniq] [uniqueidentifier]  NOT NULL,
	[SampUniq] [uniqueidentifier] NOT NULL

PRIMARY KEY (fkSample,dmRAll)-- per my schema in gdb
)

select * from MihalkaRawVarChars
select * from MihalkaTBSample order by tablepage,mShore

--
--   DROP TABLE MihalkaTBResult_Intermediate1
CREATE TABLE MihalkaTBResult_Intermediate1 (
    fkSample      [nvarchar](255)        NULL,
	dmRAll        [int]              NOT NULL,
    fkUnqID       [nvarchar](255)        NULL,
	RawUniq       [uniqueidentifier]  NOT NULL,
--
	mShore        [int]            NOT NULL,
	DateColumn    [nvarchar](10)   NOT NULL,
	MyAnalyteCode [nvarchar](10)   NOT NULL,
	Result        [numeric](38,8)      NULL,

PRIMARY KEY (mShore,DateColumn,MyAnalyteCode)
)

-- populate intermediate from the first pull
 INSERT INTO MihalkaTBResult_Intermediate1
SELECT NULL, cast(substring(MyAnalyteCode,5,4) as int), NULL, RawUniq, mShore, DateColumn, MyAnalyteCode, Result
FROM MihalkaTBResult_FirstPass
--2048

select * from MihalkaTBResult_Intermediate1
select * from MihalkaTBSample

-- assign fkSample from TBSample.pkSample
 UPDATE MihalkaTBResult_Intermediate1 
SET fkSample = samp.pkSample
FROM MihalkaTBResult_Intermediate1 i
RIGHT JOIN MihalkaTBSample samp
ON i.DateColumn = samp.TablePage and i.mShore = samp.mShore
-- 2048

-- assign fkUnqID from TBSample.pkSample
 UPDATE MihalkaTBResult_Intermediate1 
SET fkUnqID = samp.fkUnqID
FROM MihalkaTBResult_Intermediate1 i
RIGHT JOIN MihalkaTBSample samp
ON i.DateColumn = samp.TablePage and i.mShore = samp.mShore
-- 2048

select * from MihalkaTBResult_Intermediate1 order by fkSample
--------------------------------------------------------
--    DELETE FROM MihalkaTBResult 
--  INSERT INTO MihalkaTBResult 
SELECT  
fkSample, 
MyAnalyteCode,    -- Label
newid(),          -- fkIDLoc
newid(),          -- fkUnqID, fill this in later
Result, 
NULL,             -- Stddev
dmRAll,		      -- dmRAll
6460,			  -- dmRAMethod
6299,      		  -- dmR11546
6370,			  -- dmRAnlyt
6430,			  -- dmRBEACH
NULL,			  -- Grade
MyAnalyteCode,	  -- Comments
195620,		      -- AttachR
NULL,             -- RFloat1
NULL,             -- RFloat2
NULL,             -- RData1
NULL,             -- RData2
NULL,             -- RLong5
RawUniq,          -- RawUniq 
newid(),          -- ResUniq 
newid()           -- SampUniq

FROM MihalkaTBResult_Intermediate1
ORDER by fkSample
-- 2048


-- set domain for domain dmR11546 for analytes in this list
UPDATE MihalkaTBResult SET dmR11546 = dmRAll
WHERE dmRAll in (6210,6220,6230,6240,6250,6260,6270,6272,6280)
-- 502

select * from MihalkaTBResult 
--ORDER by fkSample 
where  dmRall = 6368
order by dmRall
-- 2048

-----------------------------------------
-- get pkStation from MihalkaFCStation, relationship requires some lower level code to
-- be sure the right records are updated. probably could be done with an update with inner join but this is
-- more clear since we get update counts and can verify easier (for me anyway)
 DECLARE @pkSample varchar(255), @SampUniq uniqueidentifier, @fkUnqID uniqueidentifier
DECLARE @cursorInsert CURSOR SET @cursorInsert = CURSOR FOR
   SELECT pkSample, fkUnqID, SampUniq FROM MihalkaTBSample
OPEN @cursorInsert
FETCH NEXT FROM @cursorInsert INTO @pkSample, @fkUnqID, @SampUniq
WHILE @@FETCH_STATUS = 0
   BEGIN
   --SELECT @pkSample, @fkUnqID, @SampUniq, @TablePage, @mShore
   --SELECT fkSample FROM MihalkaTBResult WHERE fkSample = @pkSample
   UPDATE MihalkaTBResult SET fkUnqID = @fkUnqID WHERE fkSample = @pkSample
   FETCH NEXT FROM @cursorInsert INTO @pkSample, @fkUnqID, @SampUniq
   END
CLOSE @cursorInsert
DEALLOCATE @cursorInsert

-----------------------------------------

SELECT * FROM MihalkaTBResult

-----------------------------------------
-- Run the analyte utility program to fill in label


-----------------------------------------
-- V1 for thesis map displays 
SELECT Count(*) as 'TBResult Count' FROM MihalkaTBResult

SELECT Label, Count(dmRAll) as 'TBResult rows' FROM MihalkaTBResult
GROUP by Label, dmRAll ORDER by 1


-- V2 thesis map displays

SELECT 'May-Dec2014 Weekly' as 'Keauhou Bay,D.Mihalka', Count(*) as 'TBResult #rows' FROM MihalkaTBResult
SELECT Label, Count(dmRAll) as '#rows', round(exp(avg(log(Result))),3) as '~gmean',round(stdev(Result),2) as 'stdev',cast(min(Result) as decimal (10,2)) as 'min',cast(max(Result) as decimal (10,2)) as 'max' FROM MihalkaTBResult 
WHERE Result!=0 GROUP by Label, dmRAll ORDER by Label


