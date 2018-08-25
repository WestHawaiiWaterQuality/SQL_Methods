-- create script for Kiholo Buoy
-- last update 04/07/2018

use whwq4
-
/* Kiholo: http://oos.soest.hawaii.edu/erddap/tabledap/wqb03_agg.graph

Dataset Title: 	PacIOOS Water Quality Buoy 03 (WQB-03): Kiholo Bay, Big Island, Hawaii
Institution: 	University of Hawaii   (Dataset ID: wqb03_agg)
Range: 	longitude = -155.9294 to -155.9294°E, latitude = 19.8631 to 19.8631°N, depth = 1.0 to 1.0, time = 2014-03-01T10:00:00Z to 2014-03-25T21:00:00Z
Information: 	Summary ? | License ? | FGDC | ISO 19115 | Metadata | Background (external link) | Data Access Form


*/

--  DROP table KiholoRawVarChars
 CREATE TABLE KiholoRawVarChars (
KihIID INT NOT NULL IDENTITY(1,1) PRIMARY KEY, -- field I added

PacIOOSTimeUTC     [nvarchar] (255) NULL,
temperature        [nvarchar] (255) NULL,--Temp6280
conductivitySm1    [nvarchar] (255) NULL,--Cond6394 Conductivity
salinity1e3        [nvarchar] (255) NULL,--Sali6350 Salinity

oxygenkgm3         [nvarchar] (255) NULL,--OxyD6270 Dissolved Oxygen
oxygen_saturation1 [nvarchar] (255) NULL,--O2sa6366 Oxygen Saturation
oxygen_satconckgm3 [nvarchar] (255) NULL,--O2sc6367 Oxygen Saturation Concentration

turbidityNTU       [nvarchar] (255) NULL,--Turb6260 Turbidity
chlorophyllkgm3    [nvarchar] (255) NULL,--ChlA6250
cdomQSDE           [nvarchar] (255) NULL,--CDOM6397 Chromophoric Dissolved Organic Matter
nitratemmolm3      [nvarchar] (255) NULL --Nate6393 NO3
)

-- now use MSSMS to import the raw file 'KiholoI_SO8859-1FileType_AllMar01ToMar252014.csv' from PacIOOS into 
-- this table fields of import file editted like this since there names are very long with parenthesis and units
--time (UTC),temperature (Celsius),conductivity (S m-1),salinity (1e-3),oxygen (kg m-3),oxygen_saturation (1),
--oxygen_saturation_concentration (kg m-3),turbidity (NTU),chlorophyll (kg m-3),cdom (QSDE),nitrate (mmol m-3)

PacIOOSTimeUTC,temperature,conductivitySm1,salinity1e3,oxygenkgm3,oxygen_saturation1,oxygen_satconckgm3,turbidityNTU,chlorophyllkgm3,cdomQSDE,nitratemmolm3
-- Input: Flat File, rename extension from "csv" to "txt" since imported seems to like txt file better for this project
-- Dest is SQL Native Client
-- make sure to choose the above table to import into (don't use recommended default), type in if not presented
-- Edit Mappings - make sure all nvarchar just to be sure. No conversion on initial read.
-- 73 rows transferred

-- clean up this data, 589 total records, 
-- NaN means Not a Number in PacIOOS database
UPDATE KiholoRawVarChars SET PacIOOSTimeUTC     = NULL WHERE PacIOOSTimeUTC     = 'NaN' -- 0 all
UPDATE KiholoRawVarChars SET temperature        = NULL WHERE temperature        = 'NaN' -- till last
UPDATE KiholoRawVarChars SET conductivitySm1    = NULL WHERE conductivitySm1    = 'NaN' -- 
UPDATE KiholoRawVarChars SET salinity1e3        = NULL WHERE salinity1e3        = 'NaN' -- 
UPDATE KiholoRawVarChars SET oxygenkgm3         = NULL WHERE oxygenkgm3         = 'NaN' -- 
UPDATE KiholoRawVarChars SET oxygen_saturation1 = NULL WHERE oxygen_saturation1 = 'NaN' -- 
UPDATE KiholoRawVarChars SET oxygen_satconckgm3 = NULL WHERE oxygen_satconckgm3 = 'NaN' -- 
UPDATE KiholoRawVarChars SET turbidityNTU       = NULL WHERE turbidityNTU       = 'NaN' -- 
UPDATE KiholoRawVarChars SET chlorophyllkgm3    = NULL WHERE chlorophyllkgm3    = 'NaN' -- 
UPDATE KiholoRawVarChars SET cdomQSDE           = NULL WHERE cdomQSDE           = 'NaN' -- 
UPDATE KiholoRawVarChars SET nitratemmolm3      = NULL WHERE nitratemmolm3      = 'NaN' -- 49 rows
DELETE FROM KiholoRawVarChars WHERE PacIOOSTimeUTC = 'UTC' -- non-data row, delete
SELECT * FROM KiholoRawVarChars
SELECT count(*) FROM KiholoRawVarChars 
-- 589 (but minus one row for second line of header from PacIOOS) so really 588 rows of data

-- bug in ArcGIS does not like all zeros, so just a second
UPDATE KiholoRawVarChars SET 
PacIOOSTimeUTC = LEFT(PacIOOSTimeUTC, 10) + 'T12:00:01Z'
WHERE PacIOOSTimeUTC LIKE '%T12:00:00Z%'




-------------------------------------------------------------------------
-------------------------------------------------------------------------
-------------------------------------------------------------------------
-------------------------------------------------------------------------
--  DROP table KiholoRaw
CREATE TABLE KiholoRaw (
   EsriDateTime   [datetime2](7)  NOT NULL,
   
   Temp6280       [numeric](38, 8) NOT NULL,
   Cond6394       [numeric](38, 8) NOT NULL,
   Sali6350       [numeric](38, 8) NOT NULL,
   								  
   F_OxyD6270     [float]          NOT NULL,
   OxyD6270       [numeric](38, 8) NOT NULL,
   								  
   O2sa6366       [numeric](38, 8) NOT NULL,
    								       								  								 
   F_O2sc6367     [float]          NOT NULL,
   O2sc6367       [numeric](38, 8) NOT NULL,

   Turb6260       [numeric](38, 8) NOT NULL,
   								 
   F_CDOM6397     [float]          NOT NULL,
   CDOM6397       [numeric](38, 8) NOT NULL,
   					
   Clos6420       [numeric](38, 8) NOT NULL,
   
   F_Nate6393     [float]             NULL,
   Nate6393       [numeric](38, 8)    NULL,

-- new fields I added to needed to prepare for geodatbase and Esri
   mShore          [int]              NOT NULL,
   MinDate         [datetime2]            NULL,
   MaxDate         [datetime2]            NULL,
   MyCoreName      [nvarchar](255)        NULL,
   MyLabel         [nvarchar](255)    NOT NULL,
   AnalyteList     [nvarchar](255)        NULL,

   MyLatLong       [nvarchar](255)    NOT NULL,
   MyLatitude      [nvarchar](255)    NOT NULL,
   POINT_Y         [numeric](38, 8)   NOT NULL,
   POINT_X         [numeric](38, 8)   NOT NULL,

   RawUniq         [uniqueidentifier] NOT NULL,
   KihIID          [int]              NOT NULL,

PRIMARY KEY (EsriDateTime)
)

select * from KiholoRawVarChars
select * from KiholoRaw

-------
--     delete from KiholoRaw
--  INSERT INTO KiholoRaw
SELECT 
CAST(PacIOOSTimeUTC AS datetime2 ),
CAST(temperature     AS numeric(38,8)), -- Temp6280
CAST(conductivitySm1 AS numeric(38,8)), -- Cond6394
CAST(salinity1e3     AS numeric(38,8)), -- Sali6350

CAST(oxygenkgm3 as float), --F_OxyD6270
-1,                        -- numeric(38,8) for laterconversion to liters (from cubix meters)

oxygen_saturation1,        -- O2sa6366

CAST(oxygen_satconckgm3 AS float), -- O2sc6367
-1,                                -- O2sc6367

CAST(turbidityNTU as numeric(38,8)), -- Turb6260

CAST(chlorophyllkgm3 AS float),   -- F_CDOM6397
-1,                               -- CDOM6397

CAST(cdomQSDE AS numeric(38,8)), -- Clos6420

CAST(nitratemmolm3 AS float),    -- F_Nate6393  
1,                               -- Nate6393
--
-1,    -- mShore will update next
NULL,NULL,    -- MinDate,MaxDate
NULL,  -- MyCoreName
'KiholoBay_PacIOOSWaterQualityBuoy03',
NULL,  -- AnalyteList
'19.8631, -155.9294', -- MylatLong simple geocode effort since all one location
'19_8631',
19.8631,    -- POINT_Y
-155.9294,  -- POINT X
newid(),    -- RawUniq
KihIID

FROM KiholoRawVarChars
ORDER BY KihIID
-- 588 rows affected


select * from KiholoRaw
ORDER BY EsriDateTime
select * from KiholoRawVarChars
ORDER BY PacIOOSTimeUTC


------------------------------------------
------------------------------------------
-- AnalyteList (include the declare when you Execute

declare @allAnalyteList nvarchar(255) = 'ResultsTemp6280Cond6394Sali6350OxyD6270O2sa6366O2sc6367Turb6260CDOM6397Clos6240Nate6393'
-- all except last 49 rows have all but Nate6393 
declare @date49 datetime2 = '2014-03-23 21:00:00.0000000'
declare @allButLast49AnalyteList nvarchar(255) = 'ResultsTemp6280Cond6394Sali6350OxyD6270O2sa6366O2sc6367Turb6260CDOM6397Clos6240'
UPDATE KiholoRaw SET AnalyteList = @allAnalyteList FROM KiholoRaw
WHERE EsriDateTime < @date49
-- 539
UPDATE KiholoRaw SET AnalyteList = @allButLast49AnalyteList FROM KiholoRaw
WHERE EsriDateTime >= @date49
-- 49 as expected from above replacement 'NaN' test

/*
-----------------
--  DROP TABLE HoursFromBeginning 
CREATE TABLE HoursFromBeginning (
   EsriDateTime  [datetime2] NOT NULL,
   MinDate       [datetime2] NOT NULL,
   MaxDate       [datetime2] NOT NULL,
   HoursSinceMin [int]           NULL,
PRIMARY KEY (MinDate)
)
INSERT INTO HoursFromBeginning
Select EsriDateTime, Min(EsriDateTime),Max(EsriDateTime),NULL FROM KiholoRaw
group by EsriDateTime
select * from HoursFromBeginning

UPDATE HoursFromBeginning SET MinDate = CAST(DATEDIFF(hour, MinDate, EsriDateTime) as int)
select * from HoursFromBeginning

SELECT esridatetime, DATEDIFF(hh, CAST(MinDate as date), GETDATE()) FROM HoursFromBeginning
-- 587 hours
*/

------------------------------------------
------------------------------------------
-----------------------
-----------------------
-- mult by 1000 to convert from cubic meters to liters
--time,temperature,conductivity,salinity,oxygen,  oxygen_saturation,oxygen_saturation_concentration,turbidity,chlorophyll,cdom,    nitrate
--UTC,         Celsius,  S m-1,      1e-3,    kg m-3,  1,                kg m-3,                         NTU,      kg m-3,     QSDE,    mmol m-3
--EsriDateTime,Temp6280, Cond6394,   Sali6350,OxyD6270,O2sa6366,        O2sc6367                       ,Turb6260 ,CDOM6397   ,Clos6240,Nate6393

-- convert cubic meters (stored in a float) to liters (stored as numeric(38,8)
-- had to use float as numeric "8" means only 8 digits of precision which is insufficient
--
--SELECT CONVERT(numeric(38,8), F_CDOM6397*1000.0) FROM KiholoRaw

UPDATE KiholoRaw SET OxyD6270 = CONVERT(numeric(38,8), F_OxyD6270 * 1000.0) FROM KiholoRaw
UPDATE KiholoRaw SET O2sc6367 = CONVERT(numeric(38,8), F_O2sc6367 * 1000.0) FROM KiholoRaw
UPDATE KiholoRaw SET CDOM6397 = CONVERT(numeric(38,8), F_CDOM6397 * 1000.0) FROM KiholoRaw
UPDATE KiholoRaw SET Nate6393 = CONVERT(numeric(38,8), F_Nate6393 * 1000.0) FROM KiholoRaw
-- 588
select * from KiholoRaw

-- from Google measuring, the closest shore 1200m (the metadata says 1.2 km because that is from the include the bay
UPDATE KiholoRaw SET mShore = 1200 -- meters

------------------------------------------

-- make core name 
UPDATE KiholoRaw SET MyCoreName = 
   MyLatitude                                        + '_' +
   SUBSTRING(CAST(EsriDateTime as nvarchar),9,2) + 
      SUBSTRING(CAST(EsriDateTime as nvarchar),12,2) + '_' +
   'JAdolf'                                          + '_' + 
   '1200m'            + '_' +
   MyLabel 


--
select MyCoreName from KiholoRaw

/* development

select distinct(CONVERT(date, EsriDateTime)) dt from KiholoRaw order by dt
/*
2014-03-01
2014-03-02
2014-03-03
2014-03-04
2014-03-05
2014-03-06
2014-03-07
2014-03-08
2014-03-09
2014-03-10
2014-03-11
2014-03-12
2014-03-13
2014-03-14
2014-03-15
2014-03-16
2014-03-17
2014-03-18
2014-03-19
2014-03-20
2014-03-21
2014-03-22
2014-03-23
2014-03-24
2014-03-25
*/

select distinct(EsriDateTime) from KiholoRaw
--25
SELECT * FROM KiholoRaw 
--order by Temp6280 desc
--order by Temp6280 desc
order by Turb6260 desc
*/

-- ok now all the fields have been converted for use in ArcGIS
-- the raw file is ready to make our tables and feature classes from


-------------------------------------------------------------------------
-------------------------------------------------------------------------
-------------------------------------------------------------------------
-------------------------------------------------------------------------

--   DROP TABLE [dbo].[KiholoFCStation]
CREATE TABLE [dbo].[KiholoFCStation](
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
-- FCStation is populated from KiholoRaw and the names/location information I have assembled
--   DELETE from KiholoFCStation
 INSERT INTO KiholoFCStation VALUES (
'19_8631_1200m_KiholoBayBuoy_JAdolf_YMarch01To252014_Hourly',
'KiholoBay Buoy',         
NULL,            -- TablePage
NULL,            -- fkStation1 
NULL,            -- fkStation2
1200,            -- measured from bay within bay
3499,            -- dmStA  n/a value
6440,            -- dmStAA 
3780,            -- dmStA, dmStAA, dmStBott  the n/a value for these domains
7140,            -- dmStClas not applicable value
4650,            -- dmAccuracy from Google MyMaps geocoding
8823,            -- dmStReef Kiholo has special reef protection from State Law 11-54(7)
7777,            -- dmRule  not applicable values
755,             -- dmStType Environment Impact Report
NULL,NULL,       
'Yes',            -- yes an embayment
NULL,NULL,
'198631',                    -- AttachSt is latitude as int number
NULL,NULL,NULL,NULL,NULL,    -- no GPS coordinates supplied, so all these NULL to track geocoding                
'19.8631, -155.9294',        -- dmAccu4650 my Google geocode effort
NULL,NULL,
'2014-03-01 10:00:00 AM', 
'2014-03-25 21:00:00 PM',   -- startDate and EndDate are the same
NULL,NULL,NULL,NULL,NULL,   -- 5 extra fields
--
-155.9294,  -- POINT X
19.8631,    -- POINT_Y
0,                           -- Rotation
0,                           -- Normalize
0,                           -- Weight
0,NULL,                      -- PageQueryI/S
--
newid(),                     -- GeoUniq set only since can't set to null on table create
newid(),                     -- StatUniq is assigned here when making a new record
newid()                      -- RawUniq
)
-- 1

select * from KiholoRaw
select * from KiholoFCStation
--



------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- FCStation complete and many preparations compete, move to insert data from KiholoRaw and other tables
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- Now work on the TBSample table
-- the pkSample name pieces are available to include fully formed names
-- there are xx sample, with up to 7 analytes recorded per sample

--   DROP TABLE KiholoTBSample
CREATE TABLE KiholoTBSample (
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
	[RawUniq] [uniqueidentifier] NULL

PRIMARY KEY (pkSample)
)
GO


--   DELETE FROM KiholoTBSample
--  INSERT INTO KiholoTBSample
SELECT 
'19_8631_' + REPLACE(REPLACE(REPLACE(SUBSTRING(CAST(EsriDateTime as nvarchar),1,13), '-', ''),' ',''),':','') + '_1200m_KiholoBayBuoy_JAdolf_YMarch01To252014_Hourly' + '_' + AnalyteList,  -- pkSample
'KiholoBay Buoy WQB-03',-- Label
NULL,                    -- TablePage 
0,                       -- AlertTrue
'PacIOOS',               -- fkIDLoc
NULL,                    -- Transect
mShore,                  -- mShore
'19_8631_1200m_KiholoBayBuoy_JAdolf_YMarch01To252014_Hourly', -- fkStation, same as FCStation code
'WQB-03',                -- fkStation2, station as known to Kiholo
'PacIOOS',
newid(),                 -- fkUniqID is the new if generated in this new row creation of the insert
'<<fkOrg>>',             -- *** GET ****
1410,                    -- dmSample, laboratory
EsriDateTime, 
EsriDateTime, 
'Have Time, Hourly Samples',      -- TimeMissg field
NULL,NULL,               -- Medium, CompStat
NULL,                    -- no Comment yet
REPLACE(MyLatitude,'_',''), -- attach code
NULL,NULL,NULL,NULL,NULL,   -- 5 extras
0,0,0,1,NULL,               -- cartography fields
newid(),
RawUniq                     -- important for tracing to save source row id

FROM KiholoRaw raw
ORDER BY raw.EsriDateTime 
-- 588
select * from KiholoTBSample
-- 588
-----------------------
-----------------------
select EsriDateTime from KiholoRaw




/*
-- inner join should be all, outer join should be none as pkStation and fkStation must match, no nulls allowed
select A_sta.*, B_samp.*
from KiholoFCStation A_sta
INNER JOIN KiholoTBSample B_samp ON
A_sta.pkStation = B_samp.fkStation
-- 588
select A_sta.*, B_samp.*
from KiholoFCStation A_sta
full outer JOIN KiholoTBSample B_samp ON
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
-- move to populate KiholoTBResult

--   DROP TABLE KiholoTBResult
CREATE TABLE KiholoTBResult (
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
--   delete from KiholoTBResult
--------------------------------------------------------------------------------
 -- 1 of 10
 INSERT INTO KiholoTBResult
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
FROM KiholoRaw raw
INNER JOIN KiholoTBSample samp
ON raw.RawUniq = samp.RawUniq AND Temp6280 IS NOT NULL
ORDER BY KihIID
-- 588
--------------------------------------------------------------------------------
-- 2 
INSERT INTO KiholoTBResult
SELECT 
samp.pkSample,
'Cond6394 - Conductivity',
samp.fkIDLoc,
samp.fkUnqID,
Cond6394,
NULL,-- Stddev
6394,--dmRAll
6465,--dmRAMethod
6299,--dmR11546
6394,--dmRAnlyt
6499,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM KiholoRaw raw
INNER JOIN KiholoTBSample samp
ON raw.RawUniq = samp.RawUniq AND Cond6394 IS NOT NULL
ORDER BY KihIID
-- 588
--------------------------------------------------------------------------------
-- 3 
INSERT INTO KiholoTBResult
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
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM KiholoRaw raw
INNER JOIN KiholoTBSample samp
ON raw.RawUniq = samp.RawUniq AND Sali6350 IS NOT NULL
ORDER BY KihIID
-- 588
--------------------------------------------------------------------------------
-- 4
INSERT INTO KiholoTBResult
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
6299,--dmRAnlyt
6499,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM KiholoRaw raw
INNER JOIN KiholoTBSample samp
ON raw.RawUniq = samp.RawUniq AND OxyD6270 IS NOT NULL
ORDER BY KihIID
-- 588
--------------------------------------------------------------------------------
-- 5
INSERT INTO KiholoTBResult
SELECT 
samp.pkSample,
'O2sa6366 - Oxygen_Saturation_PacIOOS',
samp.fkIDLoc,
samp.fkUnqID,
O2sa6366,
NULL,-- Stddev
6366,--dmRAll
6465,--dmRAMethod
6299,--dmR11546
6366,--dmRAnlyt
6496,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM KiholoRaw raw
INNER JOIN KiholoTBSample samp
ON raw.RawUniq = samp.RawUniq AND O2sa6366 IS NOT NULL
ORDER BY KihIID
-- 588
select sum(O2sa6366) FROM KiholoRaw raw
WHERE raw.O2sa6366 IS NOT NULL
select sum(Result) FROM KiholoTBResult
WHERE dmRall = 6366
--586.60840000  both
--------------------------------------------------------------------------------
-- 6
INSERT INTO KiholoTBResult
SELECT 
samp.pkSample,
'O2sc6367 - Oxygen_Saturation_Conc_PacIOOS',
samp.fkIDLoc,
samp.fkUnqID,
O2sc6367,
NULL,-- Stddev
6367,--dmRAll
6465,--dmRAMethod
6299,--dmR11546
6367,--dmRAnlyt
6499,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM KiholoRaw raw
INNER JOIN KiholoTBSample samp
ON raw.RawUniq = samp.RawUniq AND O2sc6367 IS NOT NULL
ORDER BY KihIID
-- 588
--------------------------------------------------------------------------------
-- 7
INSERT INTO KiholoTBResult
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
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM KiholoRaw raw
INNER JOIN KiholoTBSample samp
ON raw.RawUniq = samp.RawUniq AND Turb6260 IS NOT NULL
ORDER BY KihIID
-- 588
--------------------------------------------------------------------------------
-- 8
INSERT INTO KiholoTBResult
SELECT 
samp.pkSample,
'CDOM6397 - Chromophoric Dissolved Organic Matter',
samp.fkIDLoc,
samp.fkUnqID,
CDOM6397,
NULL,-- Stddev
6397,--dmRAll
6465,--dmRAMethod
6299,--dmR11546
6397,--dmRAnlyt
6499,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM KiholoRaw raw
INNER JOIN KiholoTBSample samp
ON raw.RawUniq = samp.RawUniq AND CDOM6397 IS NOT NULL
ORDER BY KihIID
-- 588
--------------------------------------------------------------------------------
-- 9
INSERT INTO KiholoTBResult
SELECT 
samp.pkSample,
'Clos6420 - Clostridium perfringens',
samp.fkIDLoc,
samp.fkUnqID,
Clos6420,
NULL,-- Stddev
6420,--dmRAll
6465,--dmRAMethod
6299,--dmR11546
6299,--dmRAnlyt
6420,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM KiholoRaw raw
INNER JOIN KiholoTBSample samp
ON raw.RawUniq = samp.RawUniq AND Clos6420 IS NOT NULL
ORDER BY KihIID
-- 588
--------------------------------------------------------------------------------
-- 10
INSERT INTO KiholoTBResult
SELECT 
samp.pkSample,
'Nate6393 - NO3',
samp.fkIDLoc,
samp.fkUnqID,
Nate6393,
NULL,-- Stddev
6393,--dmRAll
6465,--dmRAMethod
6299,--dmR11546
6393,--dmRAnlyt
6420,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM KiholoRaw raw
INNER JOIN KiholoTBSample samp
ON raw.RawUniq = samp.RawUniq AND Nate6393 IS NOT NULL
ORDER BY KihIID
-- 539

select * from KiholoTBResult
-- 5831 rows

-- V1 thesis map displays
SELECT Count(*) as 'TBResult Count' FROM KiholoTBResult
SELECT Label, Count(dmRAll) as 'by Analyte Count' FROM KiholoTBResult GROUP by Label, dmRAll ORDER by 2 DESC

-- V2 thesis map displays
SELECT 'Kiholo Bay Buoy March 2014' as 'J.Adolf PacIOOS mmol', Count(*) as 'TBResult #rows' FROM KiholoTBResult
SELECT Label, Count(dmRAll) as '#rows', round(exp(avg(log(Result))),3) as '~gmean',round(stdev(Result),2) as 'stdev',cast(min(Result) as decimal (10,2)) as 'min',cast(max(Result) as decimal (10,2)) as 'max' 
FROM KiholoTBResult WHERE Result>0 AND dmRAll not in (6393,6397) GROUP by Label, dmRAll ORDER by Label




--/*
--------------------------------------------------------------------------------
--/* development only
select sum(Nate6393),avg(Nate6393) from KiholoRaw
-- 176875800.00000000	328155.47309833
select sum(Result),avg(Result) from KiholoTBResult WHERE dmRAll = 6393 -- Nate6393
-- 176875800.00000000	328155.47309833

select sum(Sali6350),avg(Sali6350) from KiholoRaw
select sum(Result),avg(Result) from KiholoTBResult WHERE dmRAll = 6350 -- Sali6350
-- 19687.47000000	33.48209183

select sum(O2sa6366),avg(O2sa6366) from KiholoRaw
select sum(Result),avg(Result) from KiholoTBResult WHERE dmRAll = 6366 -- O2sa6366
-- 586.60840000	0.99763333
--
select sum(O2sc6367),avg(O2sc6367) from KiholoRaw
-- 3987.82928800	6.78202259
select sum(Result),avg(Result) from KiholoTBResult WHERE dmRAll = 6367  -- O2sc6367
-- 3987.82928800	6.78202259
select * from KiholoTBResult WHERE dmRAll = 6367 -- O2sc6367

select sum(Nate6393),avg(Nate6393) from KiholoRaw
select sum(Result),avg(Result) from KiholoTBResult WHERE dmRAll = 6393 -- Nate6393
-- 176875800.00000000	328155.47309833
-- 176875800.00000000	328155.47309833
--*/

SELECT 
   SUM(Temp6280)   + 
   SUM(Cond6394)   + 
   SUM(Sali6350)   + 
   				  
   SUM(OxyD6270)   + 
   SUM(O2sa6366)   + 
   SUM(O2sc6367)   +

   SUM(Turb6260)   + 
   SUM(CDOM6397)   +
   SUM(Clos6420)   + 
   SUM(Nate6393) 
   FROM KiholoRaw
-- 176922664.48052400
SELECT SUM(RESULT) FROM KiholoTBResult WHERE dmRAll in (
   6280,
   6394,
   6350,
   		  
   6270,
   6366,
   6367,

   6260,
   6397,
   6420,
   6393
   )
-- 176922664.48052400
----- ok good, all accounted for

------

-- select * from KiholoTBResult order by dmRAll
SELECT COUNT(*) FROM KiholoTBResult
-- 5381
SELECT * FROM KiholoTBResult

/* development only
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
select r.*, s.* 
From KiholoTBResult r
inner join KiholoTBSample  s
ON r.fkUnqID = s.fkUnqID
-- 5831
select s.*, r.* 
From KiholoTBSample s
inner join  KiholoTBResult r
ON s.fkUnqID = r.fkUnqID
-- 5831 as expect for inner join

select r.*, s.* 
From KiholoTBResult r
left join KiholoTBSample  s
ON r.fkUnqID = s.fkUnqID
-- 5831

--select pkSample, fkSample, r.label
select s.*,r.*
From KiholoTBSample s
left join  KiholoTBResult r
ON r.fkUnqID = NULL
-- must be 588 because that is the row count in TBSample
select * from KiholoTBResult where fkUnqID is null
--0
select * from KiholoTBSample where fkUnqID is null
--0
select count(*) from KiholoTBSample
--588
select count(*) from KiholoTBResult
--5831

select r.*, s.* 
From KiholoTBResult r
right join KiholoTBSample  s
ON r.fkUnqID = s.fkUnqID
-- 5831
select pkSample, fkSample, r.label
From KiholoTBSample s
right join  KiholoTBResult r
ON s.fkUnqID = NULL
-- 5831 nothing interesting here

select r.*, s.* 
From KiholoTBResult r
full outer join KiholoTBSample  s
ON r.fkUnqID = s.fkUnqID
-- 5831
select s.*, r.* 
From KiholoTBSample s
full outer join  KiholoTBResult r
ON s.fkUnqID = r.fkUnqID
-- 5831 not interesting

----
select r.*, s.* 
From KiholoTBResult r
full outer join KiholoTBSample  s
ON s.fkUnqID = r.fkUnqID
WHERE r.fkUnqID IS NULL OR s.fkUnqID IS NULL
-- 0 good
select s.*, r.* 
From KiholoTBSample s
full outer join  KiholoTBResult r
ON s.fkUnqID = r.fkUnqID
WHERE s.fkUnqID IS NULL OR r.fkUnqID IS NULL
-- 0 good

select pkSample, dmRall
FROM KiholoTBSample samp
LEFT JOIN KiholoTBResult res
ON samp.pkSample = res.fkSample
GROUP BY pkSample, dmRall
*/
