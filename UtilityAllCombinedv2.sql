-- Utility to Combine all the tables
-- merge all data tables
       CWB,48,10655, 50014
     NELHA,60,2940,29698
      HOTS, 1,   1, 7123
    Kiholo, 1, 588, 5831
   Mihalka, 7, 280, 2048
      Ooma,69,  69,  940
Waiakailio,30,  30,  419
   Hokulia,35,  35,  380
   Keopuka,24,  24,  336
     Abaya,16,  16,  160
   Parsons, 8,   8,   80
--           299,   14646,  89906
89906
---------------------------299
        CWBTBSample     10655 rows
       OomaTBSample        69 rows
    HokuliaTBSample        35 rows
    KeopukaTBSample        24 rows
     KiholoTBSample       588 rows
      AbayaTBSample        16 rows
       HOTSTBSample         1 row 
    MihalkaTBSample       280 rows
      NELHATBSample      2940 rows
    ParsonsTBSample         8 rows
 WaiakailioTBSample        30 rows
---------------------------14626

USE WHWQ4
-


SELECT '       CWBTBResult', COUNT(*) FROM        CWBTBResult  -- 50014
SELECT '      OomaTBResult', COUNT(*) FROM       OomaTBResult  --   940
SELECT '   HokuliaTBResult', COUNT(*) FROM    HokuliaTBResult  --   380
SELECT '   KeopukaTBResult', COUNT(*) FROM    KeopukaTBResult  --   336
--															   --
SELECT '    KiholoTBResult', COUNT(*) FROM     KiholoTBResult  --  5831
SELECT '     AbayaTBResult', COUNT(*) FROM      AbayaTBResult  --   160
SELECT '   MihalkaTBResult', COUNT(*) FROM    MihalkaTBResult  --  2048
--
SELECT '     NELHATBResult', COUNT(*) FROM      NELHATBResult  -- 29698
SELECT '   ParsonsTBResult', COUNT(*) FROM    ParsonsTBResult  --    80
SELECT 'WaiakailioTBResult', COUNT(*) FROM WaiakailioTBResult  --   419
--
SELECT 'AllCombined', COUNT(*) FROM AllCombinedFCStation
--299
SELECT 'AllCombined', COUNT(*) FROM AllCombinedTBSample
--14646
SELECT 'AllCombined', COUNT(*) FROM AllCombinedTBResult
-- 89906


SELECT '       CWBTBResult', COUNT(*) FROM        CWBTBResult   
SELECT '      OomaTBResult', COUNT(*) FROM       OomaTBResult   
SELECT '   HokuliaTBResult', COUNT(*) FROM    HokuliaTBResult   
SELECT '   KeopukaTBResult', COUNT(*) FROM    KeopukaTBResult   
SELECT '    KiholoTBResult', COUNT(*) FROM     KiholoTBResult   
SELECT '     AbayaTBResult', COUNT(*) FROM      AbayaTBResult   
 
SELECT '     NELHATBResult', COUNT(*) FROM      NELHATBResult   
SELECT '   ParsonsTBResult', COUNT(*) FROM    ParsonsTBResult   
SELECT 'WaiakailioTBResult', COUNT(*) FROM WaiakailioTBResult  
SELECT '   MihalkaTBResult', COUNT(*) FROM    MihalkaTBResult   
SELECT '      HOTSTBResult', COUNT(*) FROM       HOTSTBResult   
--																
SELECT 'AllCombined', COUNT(*) FROM AllCombinedTBResult
-- 94981



use WHWQ4
-

select count(*) FROM AllCombinedTBSample
select count(*) FROM AllCombinedTBResult

-------------------------------------------------------------------------
-------------------------------------------------------------------------
---------
use WHWQ4

  DROP TABLE AllCombinedFCStationOnePerSite156
CREATE TABLE AllCombinedFCStationOnePerSite156 (
--
--   DROP TABLE AllCombinedFCStationOnePerSite
-- CREATE TABLE AllCombinedFCStationOnePerSite (
--
   DROP TABLE AllCombinedFCStation
 CREATE TABLE AllCombinedFCStation (
--    DROP TABLE AllCombinedFCStationT
-- CREATE TABLE AllCombinedFCStationT (
--
--   DROP TABLE 
--CREATE TABLE  (
--
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
	[XField] [numeric](38, 8) NOT NULL,
	[YField] [numeric](38, 8) NOT NULL,
	[Rotation] [int] NOT NULL,
	[Normalize] [int] NOT NULL,
	[Weight] [int] NOT NULL,
	[PageQuery] [int] NOT NULL,
	[PageQueryS] [nvarchar](255) NULL,
	[GeoUniq] [uniqueidentifier] NOT NULL,
	[StatUniq] [uniqueidentifier] NOT NULL,
	[RawUniq] [uniqueidentifier] NOT NULL,
PRIMARY KEY (pkStation)
--PRIMARY KEY (StartDate)
--PRIMARY KEY (EndDate)
--PRIMARY KEY (RawUniq)
)
GO
--

select count(*) FROM AllCombinedFCStation
select count(*) FROM AllCombinedFCStationOnePerSite
select count(*) FROM AllCombinedFCStationOnePerSite156
select count(*) FROM AllCombinedTBSample
select count(*) FROM AllCombinedTBResult

---------------------------------
--
--
-- delete FROM AllCombinedFCStation;delete FROM AllCombinedFCStationOnePerSite;delete FROM AllCombinedFCStationOnePerSite156

-- delete FROM AllCombinedTBSample;delete FROM AllCombinedTBResult

---------------------------------

-- declare @FCStation nvarchar(255)='AllCombinedFCStationT'
-- declare @FCStation nvarchar(255)='AllCombinedFCStation'
EXEC('DELETE FROM ' + @FCStation)
EXEC('INSERT INTO ' + @FCStation + 
' SELECT  pkStation ,Label ,TablePage ,fkStation1,fkStation2,mShore,dmStA,dmStAA ,dmStBott ,dmStClas ,dmAccuracy,dmStReef,dmStRule ,dmStType ,fkEPA ,fkUSGS ,Embayment ,VolumeBay ,CrossArea ,AttachSt ,dmAccu4610,dmAccu4620,dmAccu4630,dmAccu4640,dmAccu4650,dmAccu4660,dmAccu4670,StartDate ,EndDate ,StFloat1 ,StFloat2 ,StDate3 ,StDate4 ,StLong5 ,XField ,YField ,Rotation ,[Normalize] ,[Weight] ,PageQuery ,PageQueryS,GeoUniq ,StatUniq ,RawUniq
FROM      NELHAFCStation')
EXEC('INSERT INTO ' + @FCStation + 
' SELECT  pkStation ,Label ,TablePage ,fkStation1,fkStation2,mShore,dmStA,dmStAA ,dmStBott ,dmStClas ,dmAccuracy,dmStReef,dmStRule ,dmStType ,fkEPA ,fkUSGS ,Embayment ,VolumeBay ,CrossArea ,AttachSt ,dmAccu4610,dmAccu4620,dmAccu4630,dmAccu4640,dmAccu4650,dmAccu4660,dmAccu4670,StartDate ,EndDate ,StFloat1 ,StFloat2 ,StDate3 ,StDate4 ,StLong5 ,XField ,YField ,Rotation ,[Normalize] ,[Weight] ,PageQuery ,PageQueryS,GeoUniq ,StatUniq ,RawUniq
FROM        CWBFCStation')
EXEC('INSERT INTO ' + @FCStation + 
' SELECT  pkStation ,Label ,TablePage ,fkStation1,fkStation2,mShore,dmStA,dmStAA ,dmStBott ,dmStClas ,dmAccuracy,dmStReef,dmStRule ,dmStType ,fkEPA ,fkUSGS ,Embayment ,VolumeBay ,CrossArea ,AttachSt ,dmAccu4610,dmAccu4620,dmAccu4630,dmAccu4640,dmAccu4650,dmAccu4660,dmAccu4670,StartDate ,EndDate ,StFloat1 ,StFloat2 ,StDate3 ,StDate4 ,StLong5 ,XField ,YField ,Rotation ,[Normalize] ,[Weight] ,PageQuery ,PageQueryS,GeoUniq ,StatUniq ,RawUniq
FROM    HokuliaFCStation')
EXEC('INSERT INTO ' + @FCStation + 
' SELECT  pkStation ,Label ,TablePage ,fkStation1,fkStation2,mShore,dmStA,dmStAA ,dmStBott ,dmStClas ,dmAccuracy,dmStReef,dmStRule ,dmStType ,fkEPA ,fkUSGS ,Embayment ,VolumeBay ,CrossArea ,AttachSt ,dmAccu4610,dmAccu4620,dmAccu4630,dmAccu4640,dmAccu4650,dmAccu4660,dmAccu4670,StartDate ,EndDate ,StFloat1 ,StFloat2 ,StDate3 ,StDate4 ,StLong5 ,XField ,YField ,Rotation ,[Normalize] ,[Weight] ,PageQuery ,PageQueryS,GeoUniq ,StatUniq ,RawUniq
FROM    KeopukaFCStation')
EXEC('INSERT INTO ' + @FCStation + 
' SELECT  pkStation ,Label ,TablePage ,fkStation1,fkStation2,mShore,dmStA,dmStAA ,dmStBott ,dmStClas ,dmAccuracy,dmStReef,dmStRule ,dmStType ,fkEPA ,fkUSGS ,Embayment ,VolumeBay ,CrossArea ,AttachSt ,dmAccu4610,dmAccu4620,dmAccu4630,dmAccu4640,dmAccu4650,dmAccu4660,dmAccu4670,StartDate ,EndDate ,StFloat1 ,StFloat2 ,StDate3 ,StDate4 ,StLong5 ,XField ,YField ,Rotation ,[Normalize] ,[Weight] ,PageQuery ,PageQueryS,GeoUniq ,StatUniq ,RawUniq
FROM     KiholoFCStation')
EXEC('INSERT INTO ' + @FCStation + 
' SELECT  pkStation ,Label ,TablePage ,fkStation1,fkStation2,mShore,dmStA,dmStAA ,dmStBott ,dmStClas ,dmAccuracy,dmStReef,dmStRule ,dmStType ,fkEPA ,fkUSGS ,Embayment ,VolumeBay ,CrossArea ,AttachSt ,dmAccu4610,dmAccu4620,dmAccu4630,dmAccu4640,dmAccu4650,dmAccu4660,dmAccu4670,StartDate ,EndDate ,StFloat1 ,StFloat2 ,StDate3 ,StDate4 ,StLong5 ,XField ,YField ,Rotation ,[Normalize] ,[Weight] ,PageQuery ,PageQueryS,GeoUniq ,StatUniq ,RawUniq
FROM       OomaFCStation')
EXEC('INSERT INTO ' + @FCStation + 
' SELECT  pkStation ,Label ,TablePage ,fkStation1,fkStation2,mShore,dmStA,dmStAA ,dmStBott ,dmStClas ,dmAccuracy,dmStReef,dmStRule ,dmStType ,fkEPA ,fkUSGS ,Embayment ,VolumeBay ,CrossArea ,AttachSt ,dmAccu4610,dmAccu4620,dmAccu4630,dmAccu4640,dmAccu4650,dmAccu4660,dmAccu4670,StartDate ,EndDate ,StFloat1 ,StFloat2 ,StDate3 ,StDate4 ,StLong5 ,XField ,YField ,Rotation ,[Normalize] ,[Weight] ,PageQuery ,PageQueryS,GeoUniq ,StatUniq ,RawUniq
FROM      AbayaFCStation')
EXEC('INSERT INTO ' + @FCStation + 
' SELECT  pkStation ,Label ,TablePage ,fkStation1,fkStation2,mShore,dmStA,dmStAA ,dmStBott ,dmStClas ,dmAccuracy,dmStReef,dmStRule ,dmStType ,fkEPA ,fkUSGS ,Embayment ,VolumeBay ,CrossArea ,AttachSt ,dmAccu4610,dmAccu4620,dmAccu4630,dmAccu4640,dmAccu4650,dmAccu4660,dmAccu4670,StartDate ,EndDate ,StFloat1 ,StFloat2 ,StDate3 ,StDate4 ,StLong5 ,XField ,YField ,Rotation ,[Normalize] ,[Weight] ,PageQuery ,PageQueryS,GeoUniq ,StatUniq ,RawUniq
FROM       HOTSFCStation')
EXEC('INSERT INTO ' + @FCStation + 
' SELECT  pkStation ,Label ,TablePage ,fkStation1,fkStation2,mShore,dmStA,dmStAA ,dmStBott ,dmStClas ,dmAccuracy,dmStReef,dmStRule ,dmStType ,fkEPA ,fkUSGS ,Embayment ,VolumeBay ,CrossArea ,AttachSt ,dmAccu4610,dmAccu4620,dmAccu4630,dmAccu4640,dmAccu4650,dmAccu4660,dmAccu4670,StartDate ,EndDate ,StFloat1 ,StFloat2 ,StDate3 ,StDate4 ,StLong5 ,XField ,YField ,Rotation ,[Normalize] ,[Weight] ,PageQuery ,PageQueryS,GeoUniq ,StatUniq ,RawUniq
FROM    MihalkaFCStation')

EXEC('INSERT INTO ' + @FCStation + 
' SELECT  pkStation ,Label ,TablePage ,fkStation1,fkStation2,mShore,dmStA,dmStAA ,dmStBott ,dmStClas ,dmAccuracy,dmStReef,dmStRule ,dmStType ,fkEPA ,fkUSGS ,Embayment ,VolumeBay ,CrossArea ,AttachSt ,dmAccu4610,dmAccu4620,dmAccu4630,dmAccu4640,dmAccu4650,dmAccu4660,dmAccu4670,StartDate ,EndDate ,StFloat1 ,StFloat2 ,StDate3 ,StDate4 ,StLong5 ,XField ,YField ,Rotation ,[Normalize] ,[Weight] ,PageQuery ,PageQueryS,GeoUniq ,StatUniq ,RawUniq
FROM    ParsonsFCStation')
EXEC('INSERT INTO ' + @FCStation + 
' SELECT  pkStation ,Label ,TablePage ,fkStation1,fkStation2,mShore,dmStA,dmStAA ,dmStBott ,dmStClas ,dmAccuracy,dmStReef,dmStRule ,dmStType ,fkEPA ,fkUSGS ,Embayment ,VolumeBay ,CrossArea ,AttachSt ,dmAccu4610,dmAccu4620,dmAccu4630,dmAccu4640,dmAccu4650,dmAccu4660,dmAccu4670,StartDate ,EndDate ,StFloat1 ,StFloat2 ,StDate3 ,StDate4 ,StLong5 ,XField ,YField ,Rotation ,[Normalize] ,[Weight] ,PageQuery ,PageQueryS,GeoUniq ,StatUniq ,RawUniq
FROM WaiakailioFCStation')
--

-- declare @FCStation nvarchar(255)='AllCombinedFCStationOnePerSite'
-- declare @FCStation nvarchar(255)='AllCombinedFCStationOnePerSite156'
EXEC('DELETE FROM ' + @FCStation)
--EXEC('INSERT INTO ' + @FCStation + ' SELECT  pkStation ,Label ,TablePage ,fkStation1,fkStation2,mShore,dmStA,dmStAA ,dmStBott ,dmStClas ,dmAccuracy,dmStReef,dmStRule ,dmStType ,fkEPA ,fkUSGS ,Embayment ,VolumeBay ,CrossArea ,AttachSt ,dmAccu4610,dmAccu4620,dmAccu4630,dmAccu4640,dmAccu4650,dmAccu4660,dmAccu4670,StartDate ,EndDate ,StFloat1 ,StFloat2 ,StDate3 ,StDate4 ,StLong5 ,XField ,YField ,Rotation ,[Normalize] ,[Weight] ,PageQuery ,PageQueryS,GeoUniq ,StatUniq ,RawUniq FROM        CWBFCStation')
EXEC('INSERT TOP (1) INTO ' + @FCStation + ' SELECT  pkStation ,Label ,TablePage ,fkStation1,fkStation2,mShore,dmStA,dmStAA ,dmStBott ,dmStClas ,dmAccuracy,dmStReef,dmStRule ,dmStType ,fkEPA ,fkUSGS ,Embayment ,VolumeBay ,CrossArea ,AttachSt ,dmAccu4610,dmAccu4620,dmAccu4630,dmAccu4640,dmAccu4650,dmAccu4660,dmAccu4670,StartDate ,EndDate ,StFloat1 ,StFloat2 ,StDate3 ,StDate4 ,StLong5 ,XField ,YField ,Rotation ,[Normalize] ,[Weight] ,PageQuery ,PageQueryS,GeoUniq ,StatUniq ,RawUniq FROM    HokuliaFCStation')
EXEC('INSERT TOP (1) INTO ' + @FCStation + ' SELECT  pkStation ,Label ,TablePage ,fkStation1,fkStation2,mShore,dmStA,dmStAA ,dmStBott ,dmStClas ,dmAccuracy,dmStReef,dmStRule ,dmStType ,fkEPA ,fkUSGS ,Embayment ,VolumeBay ,CrossArea ,AttachSt ,dmAccu4610,dmAccu4620,dmAccu4630,dmAccu4640,dmAccu4650,dmAccu4660,dmAccu4670,StartDate ,EndDate ,StFloat1 ,StFloat2 ,StDate3 ,StDate4 ,StLong5 ,XField ,YField ,Rotation ,[Normalize] ,[Weight] ,PageQuery ,PageQueryS,GeoUniq ,StatUniq ,RawUniq FROM    KeopukaFCStation')
EXEC('INSERT TOP (1) INTO ' + @FCStation + ' SELECT  pkStation ,Label ,TablePage ,fkStation1,fkStation2,mShore,dmStA,dmStAA ,dmStBott ,dmStClas ,dmAccuracy,dmStReef,dmStRule ,dmStType ,fkEPA ,fkUSGS ,Embayment ,VolumeBay ,CrossArea ,AttachSt ,dmAccu4610,dmAccu4620,dmAccu4630,dmAccu4640,dmAccu4650,dmAccu4660,dmAccu4670,StartDate ,EndDate ,StFloat1 ,StFloat2 ,StDate3 ,StDate4 ,StLong5 ,XField ,YField ,Rotation ,[Normalize] ,[Weight] ,PageQuery ,PageQueryS,GeoUniq ,StatUniq ,RawUniq FROM     KiholoFCStation')
EXEC('INSERT TOP (1) INTO ' + @FCStation + ' SELECT  pkStation ,Label ,TablePage ,fkStation1,fkStation2,mShore,dmStA,dmStAA ,dmStBott ,dmStClas ,dmAccuracy,dmStReef,dmStRule ,dmStType ,fkEPA ,fkUSGS ,Embayment ,VolumeBay ,CrossArea ,AttachSt ,dmAccu4610,dmAccu4620,dmAccu4630,dmAccu4640,dmAccu4650,dmAccu4660,dmAccu4670,StartDate ,EndDate ,StFloat1 ,StFloat2 ,StDate3 ,StDate4 ,StLong5 ,XField ,YField ,Rotation ,[Normalize] ,[Weight] ,PageQuery ,PageQueryS,GeoUniq ,StatUniq ,RawUniq FROM       OomaFCStation')
EXEC('INSERT TOP (1) INTO ' + @FCStation + ' SELECT  pkStation ,Label ,TablePage ,fkStation1,fkStation2,mShore,dmStA,dmStAA ,dmStBott ,dmStClas ,dmAccuracy,dmStReef,dmStRule ,dmStType ,fkEPA ,fkUSGS ,Embayment ,VolumeBay ,CrossArea ,AttachSt ,dmAccu4610,dmAccu4620,dmAccu4630,dmAccu4640,dmAccu4650,dmAccu4660,dmAccu4670,StartDate ,EndDate ,StFloat1 ,StFloat2 ,StDate3 ,StDate4 ,StLong5 ,XField ,YField ,Rotation ,[Normalize] ,[Weight] ,PageQuery ,PageQueryS,GeoUniq ,StatUniq ,RawUniq FROM      AbayaFCStation')
--EXEC('INSERT TOP (1) INTO ' + @FCStation + ' SELECT  pkStation ,Label ,TablePage ,fkStation1,fkStation2,mShore,dmStA,dmStAA ,dmStBott ,dmStClas ,dmAccuracy,dmStReef,dmStRule ,dmStType ,fkEPA ,fkUSGS ,Embayment ,VolumeBay ,CrossArea ,AttachSt ,dmAccu4610,dmAccu4620,dmAccu4630,dmAccu4640,dmAccu4650,dmAccu4660,dmAccu4670,StartDate ,EndDate ,StFloat1 ,StFloat2 ,StDate3 ,StDate4 ,StLong5 ,XField ,YField ,Rotation ,[Normalize] ,[Weight] ,PageQuery ,PageQueryS,GeoUniq ,StatUniq ,RawUniq FROM       HOTSFCStation')
EXEC('INSERT TOP (1) INTO ' + @FCStation + ' SELECT  pkStation ,Label ,TablePage ,fkStation1,fkStation2,mShore,dmStA,dmStAA ,dmStBott ,dmStClas ,dmAccuracy,dmStReef,dmStRule ,dmStType ,fkEPA ,fkUSGS ,Embayment ,VolumeBay ,CrossArea ,AttachSt ,dmAccu4610,dmAccu4620,dmAccu4630,dmAccu4640,dmAccu4650,dmAccu4660,dmAccu4670,StartDate ,EndDate ,StFloat1 ,StFloat2 ,StDate3 ,StDate4 ,StLong5 ,XField ,YField ,Rotation ,[Normalize] ,[Weight] ,PageQuery ,PageQueryS,GeoUniq ,StatUniq ,RawUniq FROM    MihalkaFCStation')
EXEC('INSERT TOP (1) INTO ' + @FCStation + ' SELECT  pkStation ,Label ,TablePage ,fkStation1,fkStation2,mShore,dmStA,dmStAA ,dmStBott ,dmStClas ,dmAccuracy,dmStReef,dmStRule ,dmStType ,fkEPA ,fkUSGS ,Embayment ,VolumeBay ,CrossArea ,AttachSt ,dmAccu4610,dmAccu4620,dmAccu4630,dmAccu4640,dmAccu4650,dmAccu4660,dmAccu4670,StartDate ,EndDate ,StFloat1 ,StFloat2 ,StDate3 ,StDate4 ,StLong5 ,XField ,YField ,Rotation ,[Normalize] ,[Weight] ,PageQuery ,PageQueryS,GeoUniq ,StatUniq ,RawUniq FROM      NELHAFCStation')
EXEC('INSERT TOP (1) INTO ' + @FCStation + ' SELECT  pkStation ,Label ,TablePage ,fkStation1,fkStation2,mShore,dmStA,dmStAA ,dmStBott ,dmStClas ,dmAccuracy,dmStReef,dmStRule ,dmStType ,fkEPA ,fkUSGS ,Embayment ,VolumeBay ,CrossArea ,AttachSt ,dmAccu4610,dmAccu4620,dmAccu4630,dmAccu4640,dmAccu4650,dmAccu4660,dmAccu4670,StartDate ,EndDate ,StFloat1 ,StFloat2 ,StDate3 ,StDate4 ,StLong5 ,XField ,YField ,Rotation ,[Normalize] ,[Weight] ,PageQuery ,PageQueryS,GeoUniq ,StatUniq ,RawUniq FROM    ParsonsFCStation WHERE Label LIKE ''%Honokahou%''')
EXEC('INSERT TOP (1) INTO ' + @FCStation + ' SELECT  pkStation ,Label ,TablePage ,fkStation1,fkStation2,mShore,dmStA,dmStAA ,dmStBott ,dmStClas ,dmAccuracy,dmStReef,dmStRule ,dmStType ,fkEPA ,fkUSGS ,Embayment ,VolumeBay ,CrossArea ,AttachSt ,dmAccu4610,dmAccu4620,dmAccu4630,dmAccu4640,dmAccu4650,dmAccu4660,dmAccu4670,StartDate ,EndDate ,StFloat1 ,StFloat2 ,StDate3 ,StDate4 ,StLong5 ,XField ,YField ,Rotation ,[Normalize] ,[Weight] ,PageQuery ,PageQueryS,GeoUniq ,StatUniq ,RawUniq FROM    ParsonsFCStation WHERE Label LIKE ''%Kealakekua%''')
EXEC('INSERT TOP (1) INTO ' + @FCStation + ' SELECT  pkStation ,Label ,TablePage ,fkStation1,fkStation2,mShore,dmStA,dmStAA ,dmStBott ,dmStClas ,dmAccuracy,dmStReef,dmStRule ,dmStType ,fkEPA ,fkUSGS ,Embayment ,VolumeBay ,CrossArea ,AttachSt ,dmAccu4610,dmAccu4620,dmAccu4630,dmAccu4640,dmAccu4650,dmAccu4660,dmAccu4670,StartDate ,EndDate ,StFloat1 ,StFloat2 ,StDate3 ,StDate4 ,StLong5 ,XField ,YField ,Rotation ,[Normalize] ,[Weight] ,PageQuery ,PageQueryS,GeoUniq ,StatUniq ,RawUniq FROM WaiakailioFCStation')
 
 select * from AllCombinedFCStationOnePerSite
 select * from AllCombinedFCStationOnePerSite156

UPDATE AllCombinedFCStationOnePerSite156 
SET XField = -156.56
WHERE pkStation like '%CWB%'

select * from AllCombinedFCStationOnePerSite156
WHERE pkStation not like '%CWB%'

-- redo labels since they are a mess in ArcGIS
UPDATE AllCombinedFCStationOnePerSite SET
LABEL = 'Hokulia' 
WHERE pkStation = '19_4722_500m_Hokulia_ControlDKaawaloaOffsiteSouth_DZiemannKKlein_HonRIbarra3rdCircuitCourt_Transect2'
UPDATE AllCombinedFCStationOnePerSite SET
LABEL = 'Keopuka' 
WHERE pkStation = '19_4821_100m_KeopukaLands_YApr2000_RBrock_Station27'
UPDATE AllCombinedFCStationOnePerSite SET
LABEL = 'KiholoBay' 
WHERE pkStation = '19_8631_1200m_KiholoBayBuoy_JAdolf_YMarch01To252014_Hourly'
UPDATE AllCombinedFCStationOnePerSite SET
LABEL = 'Ooma' 
WHERE pkStation = '19_7013_000m_OomaBeachsideVillage_SDollar_YNov2002ToNov2002_Transect3South_TableA4Page45_EISMay2008'
UPDATE AllCombinedFCStationOnePerSite SET
LABEL = 'Puako' 
WHERE pkStation = '19_9576_69-2014 PuakoBeachDr_LAbayaUHilo_Y4xNov2014ToJul15GMean_TLowTideSunrise_Station1Of16_001m'
UPDATE AllCombinedFCStationOnePerSite SET
LABEL = 'KeauhouBay' 
WHERE pkStation = '19_5594_800m_KeauhouBay_DMihalka_YWeeklyAprToDec2014_KYK'
UPDATE AllCombinedFCStationOnePerSite SET
LABEL = 'NELHA' 
WHERE pkStation = '19_7114_500m_KeaholePoint_KOlson_Transect6'
UPDATE AllCombinedFCStationOnePerSite SET
LABEL = 'Honokahou' 
WHERE pkStation = '19_6685_HSI_MParsons_YJun2004ToAug2005GMean_HonokahouSouthInside10mIsobath'
UPDATE AllCombinedFCStationOnePerSite SET
LABEL = 'Kealakekua' 
WHERE pkStation = '19_4613_KSO_MParsons_YJun2004ToAug2005GMean_KealakekuaSouthOutside10mIsobath'
UPDATE AllCombinedFCStationOnePerSite SET
LABEL = 'WaiakailioBay' 
WHERE pkStation = '20_0648_200m_KaiopaeGulchNorthKohalaTr3_YDec172009_SDollar_EISKohalaShorelineLLC'


------------------------------------------------------


select * FROM AllCombinedFCStation
select * FROM AllCombinedFCStationOnePerSite156
select * FROM AllCombinedFCStationOnePerSite
select * FROM AllCombinedTBSample
select * FROM AllCombinedTBResult
select count(*) FROM AllCombinedFCStation
select count(*) FROM AllCombinedFCStationOnePerSite
select count(*) FROM AllCombinedTBSample
select count(*) FROM AllCombinedTBResult

-------------------------------------------------------------------------
-------------------------------------------------------------------------
-------------------------------------------------------------------------

use whwq4
--  DROP TABLE AllCombinedTBSample
CREATE TABLE AllCombinedTBSample (
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
--PRIMARY KEY (fkUnqID)
--PRIMARY KEY (StartDate)
--PRIMARY KEY (EndDate)
)

select * FROM AllCombinedFCStation
select * FROM AllCombinedFCStationOnePerSite
select * FROM AllCombinedTBSample
select * FROM AllCombinedTBResult
select count(*) FROM AllCombinedFCStation
select count(*) FROM AllCombinedFCStationOnePerSite
select count(*) FROM AllCombinedTBSample
select count(*) FROM AllCombinedTBResult

--------------------------
--   DELETE FROM AllCombinedTBSample
--  
 INSERT INTO AllCombinedTBSample
 SELECT pkSample ,Label ,TablePage,AlertTrue,fkIDLoc ,Transect ,mShore ,fkStation,fkStation2,fkProject,fkUnqID ,fkOrg ,dmSample ,StartDate,EndDate ,TimeMissg,Medium ,CompStat ,Comment ,AttachSa ,SaFloat1 ,SaFloat2 ,SaDate3 ,SaDate4 ,SaLong5 ,Rotation ,[Normalize],[Weight],PageQuery,PageQueryS,SampUniq ,RawUniq 
 FROM        CWBTBSample
INSERT INTO AllCombinedTBSample
 SELECT pkSample ,Label ,TablePage,AlertTrue,fkIDLoc ,Transect ,mShore ,fkStation,fkStation2,fkProject,fkUnqID ,fkOrg ,dmSample ,StartDate,EndDate ,TimeMissg,Medium ,CompStat ,Comment ,AttachSa ,SaFloat1 ,SaFloat2 ,SaDate3 ,SaDate4 ,SaLong5 ,Rotation ,[Normalize],[Weight],PageQuery,PageQueryS,SampUniq ,RawUniq 
 FROM       OomaTBSample
INSERT INTO AllCombinedTBSample
 SELECT pkSample ,Label ,TablePage,AlertTrue,fkIDLoc ,Transect ,mShore ,fkStation,fkStation2,fkProject,fkUnqID ,fkOrg ,dmSample ,StartDate,EndDate ,TimeMissg,Medium ,CompStat ,Comment ,AttachSa ,SaFloat1 ,SaFloat2 ,SaDate3 ,SaDate4 ,SaLong5 ,Rotation ,[Normalize],[Weight],PageQuery,PageQueryS,SampUniq ,RawUniq 
 FROM    HokuliaTBSample
INSERT INTO AllCombinedTBSample
 SELECT pkSample ,Label ,TablePage,AlertTrue,fkIDLoc ,Transect ,mShore ,fkStation,fkStation2,fkProject,fkUnqID ,fkOrg ,dmSample ,StartDate,EndDate ,TimeMissg,Medium ,CompStat ,Comment ,AttachSa ,SaFloat1 ,SaFloat2 ,SaDate3 ,SaDate4 ,SaLong5 ,Rotation ,[Normalize],[Weight],PageQuery,PageQueryS,SampUniq ,RawUniq 
 FROM    KeopukaTBSample
INSERT INTO AllCombinedTBSample
SELECT pkSample ,Label ,TablePage,AlertTrue,fkIDLoc ,Transect ,mShore ,fkStation,fkStation2,fkProject,fkUnqID ,fkOrg ,dmSample ,StartDate,EndDate ,TimeMissg,Medium ,CompStat ,Comment ,AttachSa ,SaFloat1 ,SaFloat2 ,SaDate3 ,SaDate4 ,SaLong5 ,Rotation ,[Normalize],[Weight],PageQuery,PageQueryS,SampUniq ,RawUniq 
FROM     KiholoTBSample
INSERT INTO AllCombinedTBSample
SELECT pkSample ,Label ,TablePage,AlertTrue,fkIDLoc ,Transect ,mShore ,fkStation,fkStation2,fkProject,fkUnqID ,fkOrg ,dmSample ,StartDate,EndDate ,TimeMissg,Medium ,CompStat ,Comment ,AttachSa ,SaFloat1 ,SaFloat2 ,SaDate3 ,SaDate4 ,SaLong5 ,Rotation ,[Normalize],[Weight],PageQuery,PageQueryS,SampUniq ,RawUniq 
FROM      AbayaTBSample
INSERT INTO AllCombinedTBSample
 SELECT pkSample ,Label ,TablePage,AlertTrue,fkIDLoc ,Transect ,mShore ,fkStation,fkStation2,fkProject,fkUnqID ,fkOrg ,dmSample ,StartDate,EndDate ,TimeMissg,Medium ,CompStat ,Comment ,AttachSa ,SaFloat1 ,SaFloat2 ,SaDate3 ,SaDate4 ,SaLong5 ,Rotation ,[Normalize],[Weight],PageQuery,PageQueryS,SampUniq ,RawUniq 
 FROM       HOTSTBSample
INSERT INTO AllCombinedTBSample
SELECT pkSample ,Label ,TablePage,AlertTrue,fkIDLoc ,Transect ,mShore ,fkStation,fkStation2,fkProject,fkUnqID ,fkOrg ,dmSample ,StartDate,EndDate ,TimeMissg,Medium ,CompStat ,Comment ,AttachSa ,SaFloat1 ,SaFloat2 ,SaDate3 ,SaDate4 ,SaLong5 ,Rotation ,[Normalize],[Weight],PageQuery,PageQueryS,SampUniq ,RawUniq 
FROM    MihalkaTBSample
INSERT INTO AllCombinedTBSample
 SELECT pkSample ,Label ,TablePage,AlertTrue,fkIDLoc ,Transect ,mShore ,fkStation,fkStation2,fkProject,fkUnqID ,fkOrg ,dmSample ,StartDate,EndDate ,TimeMissg,Medium ,CompStat ,Comment ,AttachSa ,SaFloat1 ,SaFloat2 ,SaDate3 ,SaDate4 ,SaLong5 ,Rotation ,[Normalize],[Weight],PageQuery,PageQueryS,SampUniq ,RawUniq 
 FROM      NELHATBSample
INSERT INTO AllCombinedTBSample
 SELECT pkSample ,Label ,TablePage,AlertTrue,fkIDLoc ,Transect ,mShore ,fkStation,fkStation2,fkProject,fkUnqID ,fkOrg ,dmSample ,StartDate,EndDate ,TimeMissg,Medium ,CompStat ,Comment ,AttachSa ,SaFloat1 ,SaFloat2 ,SaDate3 ,SaDate4 ,SaLong5 ,Rotation ,[Normalize],[Weight],PageQuery,PageQueryS,SampUniq ,RawUniq 
 FROM    ParsonsTBSample
INSERT INTO AllCombinedTBSample
SELECT pkSample ,Label ,TablePage,AlertTrue,fkIDLoc ,Transect ,mShore ,fkStation,fkStation2,fkProject,fkUnqID ,fkOrg ,dmSample ,StartDate,EndDate ,TimeMissg,Medium ,CompStat ,Comment ,AttachSa ,SaFloat1 ,SaFloat2 ,SaDate3 ,SaDate4 ,SaLong5 ,Rotation ,[Normalize],[Weight],PageQuery,PageQueryS,SampUniq ,RawUniq 
FROM WaiakailioTBSample




------------
use WHWQ4
----  DROP TABLE AllCombinedTBResult
CREATE TABLE AllCombinedTBResult (
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
	[RawUniq] [uniqueidentifier] NULL,
	[ResUniq] [uniqueidentifier] NULL,
	[SampUniq] [uniqueidentifier] NULL,

PRIMARY KEY (fkSample,dmRAll) -- per schema
)

select * FROM AllCombinedFCStation
select * FROM AllCombinedFCStationOnePerSite
select * FROM AllCombinedTBSample
select * FROM AllCombinedTBResult
select count(*) FROM AllCombinedFCStation
select count(*) FROM AllCombinedFCStationOnePerSite
select count(*) FROM AllCombinedTBSample
select count(*) FROM AllCombinedTBResult

------------------------------
------------------------------
------------------------------
------------------------------
------------------------------
--   DELETE FROM AllCombinedTBResult
 INSERT INTO AllCombinedTBResult
SELECT * FROM        CWBTBResult UNION
SELECT * FROM       OomaTBResult UNION
SELECT * FROM    HokuliaTBResult UNION
SELECT * FROM    KeopukaTBResult UNION
SELECT * FROM     KiholoTBResult UNION
SELECT * FROM      AbayaTBResult UNION
SELECT * FROM      NELHATBResult UNION
SELECT * FROM    ParsonsTBResult UNION
SELECT * FROM WaiakailioTBResult
 -- MihalkaTBResult needs special handling
INSERT INTO AllCombinedTBResult
SELECT fkSample ,Label,fkIDLoc ,fkUnqID ,Result,Stddev,dmRAll,dmRAMeth,dmR11546 ,dmRAnlyt ,dmRBEACH ,Grade,Comments ,AttachR ,RFloat1 ,RFloat2 ,RDate3,RDate4,RLong5,RawUniq ,ResUniq ,SampUniq
FROM   MihalkaTBResult
--select count(*)  FROM   MihalkaTBResult
 -- HOTSTBResult needs special handling
INSERT INTO AllCombinedTBResult
SELECT fkSample ,Label,fkIDLoc ,fkUnqID ,Result,Stddev,dmRAll,dmRAMeth,dmR11546 ,dmRAnlyt ,dmRBEACH ,Grade,Comments ,AttachR ,RFloat1 ,RFloat2 ,RDate3,RDate4,RLong5,RawUniq ,ResUniq ,SampUniq
FROM   HOTSTBResult
--select * FROM HOTSTBResult
select count(*)  FROM HOTSTBResult
-----
select count(*) from AllCombinedTBResult
select * from AllCombinedTBResult
------------------------------
------------------------------
------------------------------
------------------------------


SELECT '       CWBTBResult', COUNT(*) FROM        CWBTBResult
SELECT '      OomaTBResult', COUNT(*) FROM       OomaTBResult
SELECT '   HokuliaTBResult', COUNT(*) FROM    HokuliaTBResult
SELECT '   KeopukaTBResult', COUNT(*) FROM    KeopukaTBResult
SELECT '    KiholoTBResult', COUNT(*) FROM     KiholoTBResult
SELECT '     AbayaTBResult', COUNT(*) FROM      AbayaTBResult
SELECT '   MihalkaTBResult', COUNT(*) FROM    MihalkaTBResult
SELECT '     NELHATBResult', COUNT(*) FROM      NELHATBResult
SELECT '   ParsonsTBResult', COUNT(*) FROM    ParsonsTBResult
SELECT 'WaiakailioTBResult', COUNT(*) FROM WaiakailioTBResult
 





select * FROM AllCombinedFCStation
select * FROM AllCombinedFCStationOnePerSite
select * FROM AllCombinedTBSample
select * FROM AllCombinedTBResult
select count(*) FROM AllCombinedFCStation
select count(*) FROM AllCombinedFCStationOnePerSite
select count(*) FROM AllCombinedTBSample
select count(*) FROM AllCombinedTBResult



SELECT 'EIS Combined' as '', Count(*) as 'TBResult #rows' 
FROM AllCombinedTBResult 

SELECT Label, Count(*) as 'TBResult #rows' 
FROM AllCombinedTBResult 
GROUP by Label, dmRAll ORDER by 2 desc

WHERE (fkSample like '%SDollar%' OR fkSample like '%Brock%' OR fkSample like '%Ziemann%')
SELECT top (20) Label, Count(dmRAll) as '#rows', 
round(exp(avg(log(Result))),3) as '~gmean',round(stdev(Result),2) as 'stdev',
cast(min(Result) as decimal (10,2)) as 'min',cast(max(Result) as decimal (10,2)) as 'max' 
FROM AllCombinedTBResult WHERE Result>0 
--AND (fkSample like '%SDollar%' OR fkSample like '%Brock%' OR fkSample like '%Ziemann%' OR fkSample like '%Parsons%' OR fkSample like '%Abaya%')
--AND (fkSample like '%SDollar%' OR fkSample like '%Brock%' OR fkSample like '%Ziemann%' OR fkSample like '%Parsons%')
--AND (fkSample like '%SDollar%')
--AND (fkSample like '%SDollar%' OR fkSample like '%Brock%')
AND (fkSample like '%SDollar%' OR fkSample like '%Brock%' OR fkSample like '%Ziemann%')
GROUP by Label, dmRAll ORDER by 2 desc

