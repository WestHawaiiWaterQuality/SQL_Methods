-- create script for Parsons Journal Article 
-- Kealakekua and Honokohau
-- last update 04/07/2018

use whwq4
-

/* Parsons transcription table create, match exactly what Parsons et al. has in:
Michael L Parsons, William J Walsh, Chelsie J Settlemier, Darla J White, Josh M Ballauer, Paula M Ayotte, Kara M Osada, 
and Brent Carman. 2008. "A Multivariate Assessment of the Coral Ecosystem Health of Two Embayments on the Lee of the 
Island of Hawai'I." Marine Pollution Bulletin 56 (6): 1138-1149. doi:10.1016/j.marpolbul.2008.03.004.
http://www.ncbi.nlm.nih.gov/pubmed/18456287.
*/
--  DROP table ParsonsTranscribedValues
CREATE TABLE ParsonsTranscribedValues (
  ParsonsTransectNameCode [char](3) NOT NULL, --(H,K)(N,S)(I,O) (Honokahau,Kealakekua)(North,South)(Inside,Outside)

  Salinity          [numeric](38, 8)       NULL,--Sali6350
  SDSalinity        [numeric](38, 8)       NULL,-- all analytes have SD=standard deviation
										   
  Temperature       [numeric](38, 8)       NULL,--Temp6280
  SDTemperature     [numeric](38, 8)       NULL,
										   
  NitrateNitrite    [numeric](38, 8)       NULL,--NaNi6230
  SDNitrateNitrite  [numeric](38, 8)       NULL,
										   
  Phosphate         [numeric](38, 8)       NULL,--TPho6240
  SDPhosphate       [numeric](38, 8)       NULL,
										   
  Silicate          [numeric](38, 8)       NULL,--Sili6360
  SDSilicate        [numeric](38, 8)       NULL,
										   
  Ammonium          [numeric](38, 8)       NULL,--AmmN6220
  SDAmmonium        [numeric](38, 8)       NULL,
										   
  TDN               [numeric](38, 8)       NULL,--TDNi6210
  SDTDN             [numeric](38, 8)       NULL,
										   
  N15               [numeric](38, 8)       NULL,--N15i6388
  SDN15             [numeric](38, 8)       NULL,
										   
  ChlorophyllA      [numeric](38, 8)       NULL,--ChlA6250
  SDChlorophyllA    [numeric](38, 8)       NULL,
										   
  Pheophytin        [numeric](38, 8)       NULL,--Pheo6398
  SDPheophytin      [numeric](38, 8)       NULL,

  RawUniq           [uniqueidentifier] NOT NULL,

PRIMARY KEY (ParsonsTransectNameCode)
)

--  delete from ParsonsTranscribedValues
-- Table 1 Page 6
INSERT INTO ParsonsTranscribedValues VALUES 
-- H=Honokahau (N=North S=South) (I=Inside O=Outside)
('HNI',34.5,0.04, 26.3,0.27, 0.36,0.035, 0.00,0.005, 1.51,0.300, 0.02,0.016, 3.29,0.201,  2.46,0.492,  0.11,0.012,  0.14,0.005,newid()),
('HNO',34.6,0.01, 26.5,0.02, 0.35,0.020, 0.00,0.003, 1.98,0.513, 0.09,0.028, 3.42,0.253,  1.29,0.710,  0.13,0.0019, 0.14,0.002,newid()),
('HSI',34.3,0.12, 26.5,0.07, 0.40,0.043, 0.00,0.007, 1.55,0.283, 0.03,0.032, 3.47,0.450,  2.00,0.779,  0.10,0.0080, 0.17,0.012,newid()),
('HSO',34.4,0.08, 26.6,0.08, 0.36,0.059, 0.01,0.022, 2.11,1.004, 0.08,0.087, 3.63,0.334,  2.50,0.449,  0.12,0.0020, 0.15,0.011,newid()),
-- K=Kealakekua (N=North S=South) (I=Inside O=Outside)
('KNI',34.7,0.06, 27.0,0.04, 0.41,0.006, 0.03,0.040, 3.04,1.070, 0.37,0.155, 3.45,0.227,  2.71,0.207,  0.13,0.004,  0.17,0.003,newid()),  
('KNO',34.6,0.01, 26.9,0.01, 0.45,0.033, 0.00,0.000, 3.17,0.624, 0.23,0.081, 3.43,0.188,  3.01,0.111,  0.12,0.006,  0.13,0.006,newid()),
('KSI',34.5,0.02, 27.0,0.06, 0.31,0.012, 0.00,0.000, 2.58,0.347, 0.38,0.057, 3.41,0.716,  2.333,0.477, 0.13,0.010,  0.20,0.006,newid()),
('KSO',34.7,0.06, 27.1,0.09, 0.36,0.089, 0.01,0.007, 2.58,0.389, 0.24,0.141, 0.286,0.147, 2.86,0.434,  0.11,0.006,  0.14,0.024,newid())
-- 8 rows affected
select * from ParsonsTranscribedValues


----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
-- insert the transcribed values into a working raw table

--  DROP table ParsonsRaw
CREATE TABLE ParsonsRaw (
  pkTransectName        [char](3)   NOT NULL,-- three digit code assigned by MParsons to identify transect name
  KealakekuaOrHonokohau [char](1)   NOT NULL,-- K or H
  NorthOrSouth          [char](1)   NOT NULL,-- N or S
  InsideOrOutside       [char](1)   NOT NULL,-- I or O

-- analytes with stddev for each
  Sali6350   [numeric](38, 8) NOT NULL,--Sali6350
  SDSali6350 [numeric](38, 8) NOT NULL,
			 				  
  Temp6280   [numeric](38, 8) NOT NULL,--Temp6280
  SDTemp6280 [numeric](38, 8) NOT NULL,
			 				 
  NaNi6230   [numeric](38, 8) NOT NULL,--NaNi6230
  SDNaNi6230 [numeric](38, 8) NOT NULL,
			 				  
  TPho6240   [numeric](38, 8) NOT NULL,--TPho6240
  SDTPho6240 [numeric](38, 8) NOT NULL,
			 				  
  Sili6360   [numeric](38, 8) NOT NULL,--Sili6360
  SDSili6360 [numeric](38, 8) NOT NULL,
			 				  
  AmmN6220   [numeric](38, 8) NOT NULL,--AmmN6220
  SDAmmN6220 [numeric](38, 8) NOT NULL,
			 				  
  TDNi6210   [numeric](38, 8) NOT NULL,--TDNi6210
  SDTDNi6210 [numeric](38, 8) NOT NULL,
			 				  
  N15i6388   [numeric](38, 8) NOT NULL,--N15i6388
  SDN15i6388 [numeric](38, 8) NOT NULL,
			 				 
  ChlA6250   [numeric](38, 8) NOT NULL,--ChlA6250
  SDChlA6250 [numeric](38, 8) NOT NULL,
			 				 
  Pheo6398   [numeric](38, 8) NOT NULL,--Pheo6398
  SDPheo6398 [numeric](38, 8) NOT NULL,

-- new fields I added to needed to prepare for geodatbase and Esri
   mShore          [int]              NOT NULL,
--
   StartDate       [datetime2]            NULL,
   EndDate         [datetime2]            NULL,
   MyCoreName      [nvarchar](255)        NULL,
   MyLabel         [nvarchar](255)        NULL,
   AnalyteList     [nvarchar](255)        NULL,

   MyLatLong       [nvarchar](255)        NULL,
   MyLatitude      [nvarchar](255)        NULL,
   POINT_Y         [numeric](38, 8)       NULL,
   POINT_X         [numeric](38, 8)       NULL,

   RawUniq         [uniqueidentifier] NOT NULL,

PRIMARY KEY (pkTransectName)
)

-- DELETE from ParsonsRaw
--  INSERT INTO ParsonsRaw
SELECT
ParsonsTransectNameCode,
SUBSTRING(ParsonsTransectNameCode, 1, 1), -- K or H Kealakekua or Honokahua
SUBSTRING(ParsonsTransectNameCode, 2, 1), -- N or S North or South
SUBSTRING(ParsonsTransectNameCode, 3, 1), -- I or O Inside or Outside

Salinity     ,--Sali6350
SDSalinity   ,--stddev

Temperature  ,--Temp6280
SDTemperature,

NitrateNitrite,--NaNi6230
SDNitrateNitrite,

Phosphate     ,--TPho6240
SDPhosphate   ,

Silicate      ,--Sili6360
SDSilicate    ,

Ammonium      ,--AmmN6220
SDAmmonium    ,

TDN           ,--TDNi6210
SDTDN         ,

N15           ,--N15i6388
SDN15         ,

ChlorophyllA  ,--ChlA6250
SDChlorophyllA,

Pheophytin    ,--Pheo6398 Pheophtin
SDPheophytin  ,

-- my fields to be updated later
-1,        --mShore
NULL,NULL, --StartDate,EndDate
NULL,      --MyCoreName,
NULL,      --MyLabel,
NULL,      --AnalyteList,
NULL,      --MyLatLong
NULL,      --MyLatitude
NULL,NULL, --POINT_Y, POINT_X
RawUniq

FROM ParsonsTranscribedValues
ORDER BY RawUniq
-- 8 rows
select * from ParsonsRaw
/*
pkTransectName	KealakekuaOrHonokohau	NorthOrSouth	InsideOrOutside	Salinity	SDSalinity	Temperature	SDTemperature	NitrateNitrite	SDNitrateNitrite	Phosphate	SDPhosphate	Silicate	SDSilicate	Ammonium	SDAmmonium	TDN	SDTDN	N15	SDN15	ChlorophyllA	SDChlorophyllA	Pheophytin	SDPheophytin	mShore	StartDate	EndDate	MyCoreName	MyLabel	AnalyteList	MyLatLong	MyLatitude	POINT_Y	POINT_X	RawUniq
HNI	H	N	I	34.50000000	0.04000000	26.30000000	0.27000000	0.36000000	0.03500000	0.00000000	0.00500000	1.51000000	0.30000000	0.02000000	0.01600000	3.29000000	0.20100000	2.46000000	0.49200000	0.11000000	0.01200000	0.14000000	0.00500000	-1	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5470B6CD-9F44-49CB-BB37-178B262FD502
HNO	H	N	O	34.60000000	0.01000000	26.50000000	0.02000000	0.35000000	0.02000000	0.00000000	0.00300000	1.98000000	0.51300000	0.09000000	0.02800000	3.42000000	0.25300000	1.29000000	0.71000000	0.13000000	0.00190000	0.14000000	0.00200000	-1	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	BBA5C6A1-ACC0-4638-90A3-7DF8A011B272
HSI	H	S	I	34.30000000	0.12000000	26.50000000	0.07000000	0.40000000	0.04300000	0.00000000	0.00700000	1.55000000	0.28300000	0.03000000	0.03200000	3.47000000	0.45000000	2.00000000	0.77900000	0.10000000	0.00800000	0.17000000	0.01200000	-1	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	706AC437-78AE-4A8C-8468-2F9D3657F827
HSO	H	S	O	34.40000000	0.08000000	26.60000000	0.08000000	0.36000000	0.05900000	0.01000000	0.02200000	2.11000000	1.00400000	0.08000000	0.08700000	3.63000000	0.33400000	2.50000000	0.44900000	0.12000000	0.00200000	0.15000000	0.01100000	-1	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	C69ECDF2-D4CC-4033-936C-6381DFF15EAD
KNI	K	N	I	34.70000000	0.06000000	27.00000000	0.04000000	0.41000000	0.00600000	0.03000000	0.04000000	3.04000000	1.07000000	0.37000000	0.15500000	3.45000000	0.22700000	2.71000000	0.20700000	0.13000000	0.00400000	0.17000000	0.00300000	-1	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	67D79457-33ED-4157-8E78-8929E25972B8
KNO	K	N	O	34.60000000	0.01000000	26.90000000	0.01000000	0.45000000	0.03300000	0.00000000	0.00000000	3.17000000	0.62400000	0.23000000	0.08100000	3.43000000	0.18800000	3.01000000	0.11100000	0.12000000	0.00600000	0.13000000	0.00600000	-1	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	A2D98453-2E33-409B-8E37-BB4F4F8E467C
KSI	K	S	I	34.50000000	0.02000000	27.00000000	0.06000000	0.31000000	0.01200000	0.00000000	0.00000000	2.58000000	0.34700000	0.38000000	0.05700000	3.41000000	0.71600000	2.33300000	0.47700000	0.13000000	0.01000000	0.20000000	0.00600000	-1	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	DECCA691-B356-4F78-AAD1-EC82BDE62B9D
KSO	K	S	O	34.70000000	0.06000000	27.10000000	0.09000000	0.36000000	0.08900000	0.01000000	0.00700000	2.58000000	0.38900000	0.24000000	0.14100000	0.28600000	0.14700000	2.86000000	0.43400000	0.11000000	0.00600000	0.14000000	0.02400000	-1	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2C835D90-D542-4360-8F94-E1A9C3CCCC54
*/



/* development only
select sum(NaNi6230),avg(NaNi6230) from ParsonsRaw
-- 3.00000000	0.37500000
select sum(Sali6350),avg(Sali6350) from ParsonsRaw
-- 276.30000000	34.53750000
select sum(Ammn6220),avg(Ammn6220) from ParsonsRaw
-- 1.44000000	0.18000000
*/

---------------------------------------------
---------------------------------------------
---------------------------------------------
  
-- my geocoding effort for each of the transects
-- Honokahou
UPDATE ParsonsRaw SET POINT_Y=19.67037, POINT_X=-156.02887 WHERE pkTransectName = 'HNI'
UPDATE ParsonsRaw SET POINT_Y=19.67043, POINT_X=-156.02948 WHERE pkTransectName = 'HNO'
UPDATE ParsonsRaw SET POINT_Y=19.66849, POINT_X=-156.02946 WHERE pkTransectName = 'HSI'
UPDATE ParsonsRaw SET POINT_Y=19.66851, POINT_X=-156.02999 WHERE pkTransectName = 'HSO'
-- Kealakekua
UPDATE ParsonsRaw SET POINT_Y=19.48240, POINT_X=-155.93084 WHERE pkTransectName = 'KNI'
UPDATE ParsonsRaw SET POINT_Y=19.47938, POINT_X=-155.93339 WHERE pkTransectName = 'KNO'
UPDATE ParsonsRaw SET POINT_Y=19.46905, POINT_X=-155.92192 WHERE pkTransectName = 'KSI'
UPDATE ParsonsRaw SET POINT_Y=19.46131, POINT_X=-155.92521 WHERE pkTransectName = 'KSO'

select * from ParsonsRaw
/*

*/
---------------------------------------------------
---------------------------------------------------
---------------------------------------------------
--
-- put together lat/long fields now that have POINTs
/* make our fields for later insertions into our tables */
-- arrange Lat/Long
UPDATE ParsonsRaw SET
MyLatLong  = str(POINT_Y, 7, 4) + ' , ' + str(POINT_X, 9, 4),
MyLatitude = CAST( REPLACE( str( CAST(POINT_Y AS DECIMAL (7,4)),7,4),'.','_') AS varchar)
-- 8
select * from ParsonsRaw

-- create label for each
-- Honokahou
UPDATE ParsonsRaw SET MyLabel= 'Honokahou North Inside 10mIsobath'  WHERE pkTransectName = 'HNI'
UPDATE ParsonsRaw SET MyLabel= 'Honokahou North Outside 10mIsobath' WHERE pkTransectName = 'HNO'
UPDATE ParsonsRaw SET MyLabel= 'Honokahou South Inside 10mIsobath'  WHERE pkTransectName = 'HSI'
UPDATE ParsonsRaw SET MyLabel= 'Honokahou South Outside 10mIsobath' WHERE pkTransectName = 'HSO'

-- Kealakekua
UPDATE ParsonsRaw SET MyLabel='Kealakekua North Inside 10mIsobath'  WHERE pkTransectName = 'KNI'
UPDATE ParsonsRaw SET MyLabel='Kealakekua North Outside 10mIsobath' WHERE pkTransectName = 'KNO'
UPDATE ParsonsRaw SET MyLabel='Kealakekua South Inside 10mIsobath'  WHERE pkTransectName = 'KSI'
UPDATE ParsonsRaw SET MyLabel='Kealakekua South Outside 10mIsobath' WHERE pkTransectName = 'KSO'
--
select * from ParsonsRaw

----------------
-- Honokahou
UPDATE ParsonsRaw SET mShore=360 WHERE pkTransectName = 'HNI'
UPDATE ParsonsRaw SET mShore=500 WHERE pkTransectName = 'HNO'
UPDATE ParsonsRaw SET mShore=428 WHERE pkTransectName = 'HSI'
UPDATE ParsonsRaw SET mShore=517 WHERE pkTransectName = 'HSO'

-- Kealakekua
UPDATE ParsonsRaw SET mShore=400 WHERE pkTransectName = 'KNI' -- fix length later
UPDATE ParsonsRaw SET mShore=400 WHERE pkTransectName = 'KNO'
UPDATE ParsonsRaw SET mShore=400 WHERE pkTransectName = 'KSI'
UPDATE ParsonsRaw SET mShore=400 WHERE pkTransectName = 'KSO'
--

-- 
--
-- unique times
-- Honokahou
UPDATE ParsonsRaw SET StartDate = '2004-06-01 12:00:01', EndDate = '2005-08-31 23:59:51' WHERE pkTransectName = 'HNI'
UPDATE ParsonsRaw SET StartDate = '2004-06-01 12:00:02', EndDate = '2005-08-31 23:59:52' WHERE pkTransectName = 'HNO'
UPDATE ParsonsRaw SET StartDate = '2004-06-01 12:00:03', EndDate = '2005-08-31 23:59:53' WHERE pkTransectName = 'HSI'
UPDATE ParsonsRaw SET StartDate = '2004-06-01 12:00:04', EndDate = '2005-08-31 23:59:54' WHERE pkTransectName = 'HSO'

-- Kealakekua
UPDATE ParsonsRaw SET StartDate = '2004-06-01 12:00:05', EndDate = '2005-08-31 23:59:55' WHERE pkTransectName = 'KNI'
UPDATE ParsonsRaw SET StartDate = '2004-06-01 12:00:06', EndDate = '2005-08-31 23:59:56' WHERE pkTransectName = 'KNO'
UPDATE ParsonsRaw SET StartDate = '2004-06-01 12:00:07', EndDate = '2005-08-31 23:59:57' WHERE pkTransectName = 'KSI'
UPDATE ParsonsRaw SET StartDate = '2004-06-01 12:00:08', EndDate = '2005-08-31 23:59:58' WHERE pkTransectName = 'KSO'

-- analyte list determined simply by looking at data, pHyd6390Temp6280 are missing in other than tr3&4
UPDATE ParsonsRaw SET AnalyteList = 'Sali6350Temp6280NaNi6230TPho6240Sili6360AmmN6220TDNi6210N15i6388ChlA6250Pheo6398' FROM ParsonsRaw
-- 8

-- make core name 
UPDATE ParsonsRaw SET MyCoreName = 
   MyLatitude               + '_' +
   pkTransectName           + '_' +
   'MParsons'               + '_' + 
   'YJun2004ToAug2005GMean' + '_' +
   MyLabel         
FROM ParsonsRaw
-- 8
UPDATE ParsonsRaw SET MyCoreName = REPLACE(REPLACE(MyCoreName, ' ',''),'-','')
--
select MyCoreName from ParsonsRaw


-- select MyCoreName,AnalyteList from ParsonsRaw
select * from ParsonsRaw
-- 8
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--  DROP TABLE [dbo].[ParsonsFCStation]
CREATE TABLE [dbo].[ParsonsFCStation](
	[pkStation] [nvarchar](255) NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
	[TablePage] [nvarchar](255) NULL,
	[fkStation1] [nvarchar](255) NULL,
	[fkStation2] [nvarchar](255) NULL,
	[mShore] [int] NULL,
--
	[dmStA] [int] NOT NULL,
	[dmStAA] [int] NOT NULL,
	[dmStBott] [int] NULL,
	[dmStClas] [int] NOT NULL,
	[dmAccuracy] [int] NOT NULL,
	[dmStReef] [int] NULL,
	[dmStRule] [int] NOT NULL,
	[dmStType] [int] NOT NULL,
--
	[fkEPA] [nvarchar](255) NULL,
	[fkUSGS] [nvarchar](255) NULL,
	[Embayment] [nvarchar](255) NULL,
	[VolumeBay] [numeric](38, 8) NULL,
	[CrossArea] [numeric](38, 8) NULL,
	[AttachSt] [int] NULL,
--
	[dmAccu4610] [nvarchar](255) NULL,
	[dmAccu4620] [nvarchar](255) NULL,
	[dmAccu4630] [nvarchar](255) NULL,
	[dmAccu4640] [nvarchar](255) NULL,
	[dmAccu4650] [nvarchar](255) NULL,
	[dmAccu4660] [nvarchar](255) NULL,
	[dmAccu4670] [nvarchar](255) NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NOT NULL,
--
	[StFloat1] [numeric](38, 8) NULL,
	[StFloat2] [numeric](38, 8) NULL,
	[StDate3] [datetime2](7) NULL,
	[StDate4] [datetime2](7) NULL,
	[StLong5] [int] NULL,
--
	[XField] [numeric](38, 8)    NOT NULL, -- Longtitude
	[YField] [numeric](38, 8)    NOT NULL, -- Latitude
--
	[Rotation] [int]             NOT NULL,
	[Normalize] [int]            NOT NULL,
	[Weight] [int]               NOT NULL,
	[PageQuery]  [int]               NULL,
	[PageQueryS] [nvarchar](255)     NULL,
--
	[GeoUniq] [uniqueidentifier] NOT NULL,
	[StatUniq] [uniqueidentifier] NOT NULL,
	[RawUniq] [uniqueidentifier] NOT NULL,

 PRIMARY KEY (pkStation)
 ) 

-- 
-- FCStation is populated from ParsonsRaw and the names/location information I have assembled
--  DELETE from ParsonsFCStation
 INSERT INTO ParsonsFCStation 
SELECT 
MyCoreName,        -- pkStation
MyLabel,           -- Label
'Table1 Page1142', -- TablePage
pkTransectName,    -- fkStation1 
NULL,              -- fkStation2
--
mShore,
IIF(KealakekuaOrHonokohau='H', 3440, 3499), -- dmStA Honokohau is called listed in the law 11-54(6)
IIF(KealakekuaOrHonokohau='H', 6470, 6460), -- dmStAA Honokohau and K are called out
IIF(KealakekuaOrHonokohau='H', 3725, 3770), -- dmStBott Honokohau and K are called out
7110,                -- dmStClas 
4650,                -- dmAccuracy from Google MyMaps geocoding
IIF(KealakekuaOrHonokohau='H', 8821, 8822), -- dmStReef Honokohau and K are called out
7777,                -- dmRule  not applicable values
444,                 -- dmStType Environment Impact Report
NULL,                 -- fkEPA
NULL,                 -- fkUSGS         
'Yes',                -- yes both are embayments
NULL,                 -- VolumeBay
NULL,                 -- CrossArea
REPLACE(MyLatitude,'_',''),  -- AttachSt is latitude as int number
--
NULL,                        -- dmAccu4610 no GPS coordinates supplied, so all these NULL to track geocoding
NULL,                        -- dmAccu4620
NULL,                        -- dmAccu4630
NULL,                        -- dmAccu4640
MyLatLong,                   -- dmAccu4650 my Google geocode effort
NULL,                        -- dmAccu4660
NULL,                        -- dmAccu4670
CAST(StartDate as datetime), -- StartDate and EndDate is set as entire month of Aug2003
CAST(EndDate as datetime),   -- EndDate
NULL,NULL,NULL,NULL,NULL,    -- 5 extra fields
POINT_X,POINT_Y,             -- XField, YField
--
ROW_NUMBER() OVER(ORDER BY POINT_Y ASC)%2, -- Rotation
0,                           -- Normalize
0,                           -- Weight
0,NULL,                      -- PageQuery/S
--
newid(),                  -- GeoUniq set only since can't set to null on table create
newid(),                  -- StatUniq is assigned here when making a new record
RawUniq                   -- tracer backwards
FROM ParsonsRaw
ORDER BY RawUniq
-- 8
select * from ParsonsFCStation
-- 8


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- FCStation complete and many preparations compete, move to insert data from ParsonsRaw and other tables
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- Now work on the TBSample table
-- the pkSample name pieces are available to include fully formed names
-- there are xx sample, with up to 7 analytes recorded per sample

--   DROP TABLE ParsonsTBSample
CREATE TABLE ParsonsTBSample (
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

select * from ParsonsRaw

--   DELETE FROM ParsonsTBSample
--  INSERT INTO ParsonsTBSample
SELECT 
MyCoreName + '_' + AnalyteList,  -- pkSample
MyLabel,           -- LabelName
'Table1 Page1142', -- TablePage
0,                 -- AlertTrue
'MParsons',        -- fkIDLoc
-1,                -- Transect
mShore,             -- mShore
MyCoreName,         -- pkStation, same as FCStation code
pkTransectName,     -- fkStation2, station as known to Parsons
'UHHilo',
newid(),            -- fkUniqID is the new if generated in this new row creation of the insert
'<<fkOrg>>',        -- *** GET ****
1420,               -- dmSample, laboratory
StartDate, 
EndDate,            -- 
'Yes',              -- TimeMissg field
NULL,NULL,          -- Medium, CompStat
NULL,               -- no Comment yet
REPLACE(MyLatitude,'_',''), -- attach code
NULL,NULL,NULL,NULL,NULL,   -- 5 extras
0,0,0,1,NULL,               -- cartography fields
newid(),
RawUniq                     -- important for tracing to save source row id
FROM ParsonsRaw
ORDER BY (MyCoreName + '_' + AnalyteList)
-- 8 rows affected
select * from ParsonsTBSample
-- 8
-----------------------
-----------------------

/*
-- inner join should be all, outer join should be none as pkStation and fkStation must match, no nulls allowed
select A_sta.*, B_samp.*
from ParsonsFCStation A_sta
INNER JOIN ParsonsTBSample B_samp ON
A_sta.pkStation = B_samp.fkStation
-- 8
select A_sta.*, B_samp.*
from ParsonsFCStation A_sta
full outer JOIN ParsonsTBSample B_samp ON
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
-- move to populate ParsonsTBResult

--  DROP TABLE ParsonsTBResult
CREATE TABLE ParsonsTBResult (
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
--  delete from ParsonsTBResult
--------------------------------------------------------------------------------
 -- 1/10
 INSERT INTO ParsonsTBResult
SELECT 
samp.pkSample,
'Sali6350 - Salinity',
samp.fkIDLoc,
samp.fkUnqID,
Sali6350,
SDSali6350,-- Stddev
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
FROM ParsonsRaw raw
INNER JOIN ParsonsTBSample samp
ON raw.RawUniq = samp.RawUniq and Sali6350 IS NOT NULL
ORDER BY RawUniq
-- 8
select * from ParsonsTBResult order by dmRAll
--------------------------------------------------------------------------------
-- 2
INSERT INTO ParsonsTBResult
SELECT 
samp.pkSample,
'Temp6280 - Temperature C',
samp.fkIDLoc,
samp.fkUnqID,
Temp6280,
SDTemp6280,-- Stddev
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
FROM ParsonsRaw raw
INNER JOIN ParsonsTBSample samp
ON raw.RawUniq = samp.RawUniq and Temp6280 IS NOT NULL
ORDER BY RawUniq
-- 8
--------------------------------------------------------------------------------
-- 3
INSERT INTO ParsonsTBResult
SELECT 
samp.pkSample,
'NaNi6230 - Nitrate+Nitrite Nitrogen',
samp.fkIDLoc,
samp.fkUnqID,
NaNi6230,
SDNaNi6230,-- Stddev
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
FROM ParsonsRaw raw
INNER JOIN ParsonsTBSample samp
ON raw.RawUniq = samp.RawUniq and NaNi6230 IS NOT NULL
ORDER BY RawUniq
-- 8
--------------------------------------------------------------------------------
-- 4
INSERT INTO ParsonsTBResult
SELECT 
samp.pkSample,
'TPho6240 - Total Phosphorus',
samp.fkIDLoc,
samp.fkUnqID,
TPho6240,
SDTPho6240,-- Stddev
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
FROM ParsonsRaw raw
INNER JOIN ParsonsTBSample samp
ON raw.RawUniq = samp.RawUniq and TPho6240 IS NOT NULL
ORDER BY RawUniq
--8
--------------------------------------------------------------------------------
-- 5
INSERT INTO ParsonsTBResult
SELECT 
samp.pkSample,
'Sili6360 - Silicates',
samp.fkIDLoc,
samp.fkUnqID,
Sili6360,
SDSili6360,-- Stddev
6360,--dmRAll
6465,--dmRAMethod
6299,--dmR11546
6360,--dmRAnlyt
6499,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM ParsonsRaw raw
INNER JOIN ParsonsTBSample samp
ON raw.RawUniq = samp.RawUniq and Sili6360 IS NOT NULL
ORDER BY RawUniq
-- 8
--------------------------------------------------------------------------------
-- 6
INSERT INTO ParsonsTBResult
SELECT 
samp.pkSample,
'AmmN6220 - Ammonia Nitrogen',
samp.fkIDLoc,
samp.fkUnqID,
AmmN6220,
SDAmmN6220,-- Stddev
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
FROM ParsonsRaw raw
INNER JOIN ParsonsTBSample samp
ON raw.RawUniq = samp.RawUniq and AmmN6220 IS NOT NULL
ORDER BY RawUniq
-- 
--------------------------------------------------------------------------------
-- 7
INSERT INTO ParsonsTBResult
SELECT 
samp.pkSample,
'TDNi6210 - Total Nitrogen',
samp.fkIDLoc,
samp.fkUnqID,
TDNi6210,
SDTDNi6210,-- Stddev
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
FROM ParsonsRaw raw
INNER JOIN ParsonsTBSample samp
ON raw.RawUniq = samp.RawUniq and TDNi6210 IS NOT NULL
ORDER BY RawUniq
-- 35
--------------------------------------------------------------------------------
-- 8
INSERT INTO ParsonsTBResult
SELECT 
samp.pkSample,
'N15i6388 - 15N',
samp.fkIDLoc,
samp.fkUnqID,
N15i6388,
SDN15i6388,-- Stddev
6388,--dmRAll
6465,--dmRAMethod
6299,--dmR11546
6388,--dmRAnlyt
6499,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM ParsonsRaw raw
INNER JOIN ParsonsTBSample samp
ON raw.RawUniq = samp.RawUniq and N15i6388 IS NOT NULL
ORDER BY RawUniq
-- 8
--------------------------------------------------------------------------------
-- 9
INSERT INTO ParsonsTBResult
SELECT 
samp.pkSample,
'ChlA6250 - Chlorophyll a',
samp.fkIDLoc,
samp.fkUnqID,
ChlA6250,
SDChlA6250,-- Stddev
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
FROM ParsonsRaw raw
INNER JOIN ParsonsTBSample samp
ON raw.RawUniq = samp.RawUniq and ChlA6250 IS NOT NULL
ORDER BY RawUniq
-- 
--------------------------------------------------------------------------------
-- 10
INSERT INTO ParsonsTBResult
SELECT 
samp.pkSample,
'Pheo6398 - Pheophytin',
samp.fkIDLoc,
samp.fkUnqID,
Pheo6398,
SDPheo6398,-- Stddev
6398,--dmRAll
6465,--dmRAMethod
6250,--dmR11546
6398,--dmRAnlyt
6499,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM ParsonsRaw raw
INNER JOIN ParsonsTBSample samp
ON raw.RawUniq = samp.RawUniq and Pheo6398 IS NOT NULL
ORDER BY RawUniq
-- 

select * from ParsonsTBResult
-- 80 rows
--




-- V1 thesis figures
SELECT Count(*) as 'TBResult Count' FROM ParsonsTBResult
SELECT Label, Count(dmRAll) as 'TBResult rows' FROM ParsonsTBResult GROUP by Label, dmRAll ORDER by 2 DESC
SELECT Count(*) as 'TBResult Count' FROM ParsonsTBResult

SELECT Count(*) as 'TBResult Count' FROM ParsonsTBResult
--where fkSample LIKE '%Honok%'
where fkSample LIKE '%Keala%'
SELECT Label, Count(dmRAll) as 'TBResult rows' FROM ParsonsTBResult 
--where fkSample LIKE '%Honok%'
where fkSample LIKE '%Keala%'
GROUP by Label, dmRAll ORDER by 2 DESC



-- V2 thesis figures - BOTH
SELECT 'Honokohau Harbor and Kealakekua Bay' as 'M.Parsons', Count(*) as 'TBResult #rows' FROM ParsonsTBResult
SELECT Label, Count(dmRAll) as '#rows', round(exp(avg(log(Result))),3) as '~gmean',round(stdev(Result),2) as 'stdev',cast(min(Result) as decimal (10,2)) as 'min',cast(max(Result) as decimal (10,2)) as 'max' FROM ParsonsTBResult 
WHERE Result<>0 GROUP by Label, dmRAll ORDER by Label

-- V2 thesis figures
SELECT 'Honokohau Harbor' as 'M.Parsons', Count(*) as 'TBResult #rows' FROM ParsonsTBResult WHERE fkSample LIKE '%Honokahou%'
SELECT Label, Count(dmRAll) as '#rows', round(exp(avg(log(Result))),3) as '~gmean',round(stdev(Result),2) as 'stdev',cast(min(Result) as decimal (10,2)) as 'min',cast(max(Result) as decimal (10,2)) as 'max' FROM ParsonsTBResult 
WHERE Result<>0 AND fkSample LIKE '%Honokahou%' GROUP by Label, dmRAll ORDER by Label

-- V2 thesis figures
SELECT 'Kealakekua Bay' as 'M.Parsons', Count(*) as 'TBResult #rows' FROM ParsonsTBResult WHERE fkSample LIKE '%Kealakekua%'
SELECT Label, Count(dmRAll) as '#rows', round(exp(avg(log(Result))),3) as '~gmean',round(stdev(Result),2) as 'stdev',cast(min(Result) as decimal (10,2)) as 'min',cast(max(Result) as decimal (10,2)) as 'max' FROM ParsonsTBResult 
WHERE Result<>0 AND fkSample LIKE '%Kealakekua%' GROUP by Label, dmRAll ORDER by Label

select * from ParsonsTBResult

--------------------------------------------------------------------------------

/* development only
select sum(NaNi6230),avg(NaNi6230) from ParsonsRaw
select sum(Result),avg(Result) from ParsonsTBResult WHERE dmRAll = 6230 -- NaNi6230
-- 3.00000000	0.37500000

select count(*),sum(Sali6350),avg(Sali6350) from ParsonsRaw WHERE Sali6350 IS NOT NULL
-- select Transect,mShore,Sali6350 from ParsonsRaw WHERE Sali6350 IS NOT NULL ORDER BY Transect,mShore
-- 8	276.30000000	34.53750000
select count(Result),sum(Result),avg(Result) from ParsonsTBResult WHERE dmRAll = 6350 -- Sali6350
-- 8	276.30000000	34.53750000

select sum(Ammn6220),avg(Ammn6220) from ParsonsRaw
-- 1.44000000	0.18000000
select sum(Result),avg(Result) from ParsonsTBResult WHERE dmRAll = 6220 -- Ammn6220
-- 1.44000000	0.18000000
--*/

/*
SELECT 
   SUM(Sali6350) +
   SUM(Temp6280) + 
   SUM(NaNi6230) + 
   SUM(TPho6240) + 
   SUM(Sili6360) + 
   SUM(AmmN6220) + 
   SUM(TDNi6210) + 
   SUM(N15i6388) + 
   SUM(ChlA6250) + 
   SUM(Pheo6398)
   FROM ParsonsRaw
 --558.94900000
SELECT SUM(Result) FROM ParsonsTBResult
-- 558.94900000
*/

-- select * from ParsonsTBResult order by dmRAll
SELECT COUNT(*) FROM ParsonsTBResult
-- 80 = 8 rows * 10 analytes
SELECT * FROM ParsonsTBResult

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
/*
select r.*, s.* 
From ParsonsTBResult r
inner join ParsonsTBSample  s
ON r.fkUnqID = s.fkUnqID
-- 80
select s.*, r.* 
From ParsonsTBSample s
inner join  ParsonsTBResult r
ON s.fkUnqID = r.fkUnqID
-- 80 as expect for inner join

select r.*, s.* 
From ParsonsTBResult r
left join ParsonsTBSample  s
ON r.fkUnqID = s.fkUnqID
-- 80
*/

--select pkSample, fkSample, r.label
select s.*,r.*
From ParsonsTBSample s
left join  ParsonsTBResult r
ON r.fkUnqID = NULL
-- must be 8 DON LOOK
select * from ParsonsTBResult where fkUnqID is null
--0
select * from ParsonsTBSample where fkUnqID is null
--0
select count(*) from ParsonsTBSample
--8
select count(*) from ParsonsTBResult
--80

select r.*, s.* 
From ParsonsTBResult r
right join ParsonsTBSample  s
ON r.fkUnqID = s.fkUnqID
-- 80
select pkSample, fkSample, r.label
From ParsonsTBSample s
right join  ParsonsTBResult r
ON s.fkUnqID = NULL
-- 80

select r.*, s.* 
From ParsonsTBResult r
full outer join ParsonsTBSample  s
ON r.fkUnqID = s.fkUnqID
-- 80
select s.*, r.* 
From ParsonsTBSample s
full outer join  ParsonsTBResult r
ON s.fkUnqID = r.fkUnqID
-- 80

----
select r.*, s.* 
From ParsonsTBResult r
full outer join ParsonsTBSample  s
ON s.fkUnqID = r.fkUnqID
WHERE r.fkUnqID IS NULL OR s.fkUnqID IS NULL
-- 0
select s.*, r.* 
From ParsonsTBSample s
full outer join  ParsonsTBResult r
ON s.fkUnqID = r.fkUnqID
WHERE s.fkUnqID IS NULL OR r.fkUnqID IS NULL
-- 0
