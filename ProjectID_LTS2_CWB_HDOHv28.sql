-- create script for Clean Water Branch

-- last update 04/07/2018
-
USE whwq4

/* CWB Raw Create, read in the entire file as varchar fields, 
   address conversion once into a table.
   This data comes from PacIOOS at http://oos.soest.hawaii.edu/erddap/tabledap/cwb_water_quality.html
   Selected all data for all time past earliest date listed on page as 1973-06-04T21:00:00:00Z 
   location_id = 1200 to 1253 (which is all of the Kona side sites)
   */

--  DROP table CWBRawVarChars
CREATE TABLE CWBRawVarChars (
 cwbIID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,

 timeUTC           [nvarchar](255) NULL, -- allow all NULLS since we don't know what we are going to get
 longitude         [nvarchar](255) NULL,
 latitude          [nvarchar](255) NULL,
 location_id       [nvarchar](255) NULL,
 location_name     [nvarchar](255) NULL, 
 enterococcus      [nvarchar](255) NULL, --Ecci6410
 clostridium_perf  [nvarchar](255) NULL, --Clos6420
 Alert             [nvarchar](255) NULL, -- 0/1/NULL to indicate an Alert was issued
 temperature       [nvarchar](255) NULL, --Temp6280
 salinity          [nvarchar](255) NULL, --Sali6350
 turbidity         [nvarchar](255) NULL, --Turb6260
 ph                [nvarchar](255) NULL, --pHyd6390
 massoxygen        [nvarchar](255) NULL, --OxyF6364
 fracsatoxygen     [nvarchar](255) NULL, --OxyS6365
)

-- Now do the MS Management Studio Import
-- Flat File into the table above, make sure all varchar on import field mapping
-- all field come in as varchar for now, and into this table above, ignore the identity field on field mappings

-------------------------
-- special test to see if we imported any NULLs before we set analyte fields to NULL
-- otherwise would have lost information.
select COUNT(*) from CWBRawVarChars
where enterococcus is NULL 
or clostridium_perf is NULL
or temperature is NULL
or Alert is NULL
or temperature is NULL
or salinity is NULL
or ph is NULL
or massoxygen is NULL
or fracsatoxygen is NULL
-- count is 0! as it should be from a professional outfit like PacIOOS
--PacIOOS did use NaN as marker in all records, so we can replace with NULL
-- without losing information
--DROP table CWBRawVarCharsBK

-- clean up this data, 10655 total records, the 'NaN' means "Not a Number"
-- well whatever, we can't use that in SQL or Esri so convert to NULLs
-- we already know there are no other NULLs previously set 
-- for this fields from above count NULLs test
UPDATE CWBRawVARChars SET timeUTC          = NULL WHERE timeUTC          = 'NaN'
UPDATE CWBRawVARChars SET longitude        = NULL WHERE longitude        = 'NaN'
UPDATE CWBRawVARChars SET latitude         = NULL WHERE latitude         = 'NaN'
UPDATE CWBRawVARChars SET location_id      = NULL WHERE location_id      = 'NaN'
UPDATE CWBRawVARChars SET location_name    = NULL WHERE location_name    = 'NaN'
UPDATE CWBRawVARChars SET enterococcus     = NULL WHERE enterococcus     = 'NaN'  -- 845   look at all these NULLs!!!!!
UPDATE CWBRawVARChars SET clostridium_perf = NULL WHERE clostridium_perf = 'NaN'  -- 5008
UPDATE CWBRawVARChars SET Alert            = NULL WHERE Alert            = 'NaN'  -- 845
UPDATE CWBRawVARChars SET temperature      = NULL WHERE temperature      = 'NaN'  -- 4695
UPDATE CWBRawVARChars SET salinity         = NULL WHERE salinity         = 'NaN'  -- 2948
UPDATE CWBRawVARChars SET turbidity        = NULL WHERE turbidity        = 'NaN'  -- 5261
UPDATE CWBRawVARChars SET ph               = NULL WHERE ph               = 'NaN'  -- 5344
UPDATE CWBRawVARChars SET massoxygen       = NULL WHERE massoxygen       = 'NaN'  -- 4950
UPDATE CWBRawVARChars SET fracsatoxygen    = NULL WHERE fracsatoxygen    = 'NaN'  -- 6186
--
SELECT * FROM CWBRawVarChars

-- establish important counts and make sure coordinated across CWBLocationCode and CWBLocationName
select DISTINCT(location_id) from CWBRawVarChars
-- 48
select COUNT(DISTINCT(location_id)) from CWBRawVarChars
-- 48

select DISTINCT(location_name) from CWBRawVarChars
-- 48
select COUNT(DISTINCT(location_name)) from CWBRawVarChars
-- 48

---------------------------------------------------------
---------------------------------------------------------
---------------------------------------------------------
---------------------------------------------------------
---------------------------------------------------------
---------------------------------------------------------
/* try to find some patterns in the data 
*/
/*
select COUNT(*) from CWBRawVarChars
where 
--Alert = 1--240
(enterococcus is NULL AND  clostridium_perf is NULL) -- 844
--(enterococcus is NULL OR   clostridium_perf is NULL)  -- 5009
--((enterococcus is NULL AND  clostridium_perf is NULL) AND Alert = 1) -- 0 this is the most telling
--((enterococcus is NULL OR   clostridium_perf is NULL) AND Alert = 1)  -- 45
((enterococcus is NULL AND  clostridium_perf is NULL) AND Alert = 0) -- 0 this is also telling
((enterococcus is NULL OR   clostridium_perf is NULL) AND Alert = 0)  -- 4119
-- don't know what all this means other than these 2 are the only ones involved in Alerts
-----------
select DISTINCT(Alert) from CWBRawVarChars
-- NULL, 0 and 1

/*
testonly for perspective

select COUNT(*) from CWBRawVarChars
where 
--(1 = 1) -- 10655
--(Alert = 1) -- 240
--(Alert = 0) -- 9570
(Alert is NULL) -- 845
(enterococcus is NULL) -- 845
(clostridium_perf is NULL) --5008
--(enterococcus is NULL and clostridium_perf is NULL and Alert = 1) -- 0 so these are the only things that cause Alerts!
--(enterococcus is NULL and Alert = 1)  -- 0
--(clostridium_perf is NULL and Alert = 1)  -- 45
--(clostridium_perf is not NULL and Alert = 1)  -- 195
(enterococcus is not NULL and Alert = 1)  -- 240
--(enterococcus is NULL or clostridium_perf is NULL and Alert = 1)  -- 890
--(enterococcus is NULL and clostridium_perf is NULL and Alert = 0) -- 0
--(enterococcus is NULL or clostridium_perf is NULL and Alert = 0)  -- 4964
--(enterococcus is NULL and clostridium_perf is NULL and Alert is NULL) -- 844
--(enterococcus is NULL or clostridium_perf is NULL and Alert is NULL)  -- 845
--(enterococcus is NULL and clostridium_perf is NULL and Alert is not NULL) -- 0
(enterococcus is NULL or clostridium_perf is NULL and Alert is not NULL)  -- 5009
*/
-- 
------------
/*
--- testonly section
-- can I do a geomean of the entire dataset? no
--SELECT COUNT(*) FROM CWBRawVarChars 
--where enterococcus is NULL
-- select COUNT(*),max(ecci6410),min(ecci6410),avg(ecci6410) FROM [WHWQ4].[dbo].[CWBRaw]
-- where Ecci6410 is not null and ecci6410 > 0
--select exp(avg(log(ecci6410)))
--  from CWBRaw
--  where Ecci6410 is not null
--select exp(avg(log(ecci6410)))
--  from CWBRaw
--  where Ecci6410 is not null and Ecci6410 > 0
-- select exp(avg(log(Sali6350))),max(Sali6350),min(Sali6350),avg(Sali6350)
--  from CWBRaw
--  where Sali6350 is not null and Sali6350 > 20
select exp(avg(log([Turb6260]))),max([Turb6260]),min([Turb6260]),avg([Turb6260]),COUNT([Turb6260])
  from CWBRaw
  where [Turb6260] is not null and [Turb6260] > 5
  */
 */ 


---- this table has numeric data types ready for ArcGIS
-- set fields not null to force errors
--  DROP table CWBRaw
CREATE TABLE CWBRaw (
 PacIOOSTimeUTC   [datetime2](7)    NOT NULL, -- for Esri datetime2
 CWBLocationCode  [nvarchar](255)   NOT NULL,
 CWBLocationName  [nvarchar](255)   NOT NULL,
 MyLabel          [nvarchar](255)       NULL,
								     
 pkSampleR1       [nvarchar](255)       NULL,
 pkSampleR2       [nvarchar](255)       NULL,
 pkSampleR3       [nvarchar](255)       NULL,
								     
 PacIOOS_POINT_Y  [numeric](38, 8)      NULL,
 PacIOOS_POINT_X  [numeric](38, 8)      NULL,
 								       
 Ecci6410       [numeric](38, 8)        NULL,-- any can be NULL
 Clos6420       [numeric](38, 8)        NULL,
 Alrt6361       [int]                   NULL,
 Temp6280       [numeric](38, 8)        NULL,
 Sali6350       [numeric](38, 8)        NULL,
 Turb6260       [numeric](38, 8)        NULL,
 pHyd6390       [numeric](38, 8)        NULL,
 O2mc6364       [numeric](38, 8)        NULL,
 O2fs6365       [numeric](38, 8)        NULL,

 AlertCount     [int]                   NULL,
 RecordCount    [int]                   NULL,
 TempMyLabel    [nvarchar](255)     NOT NULL,
-- tracking
 RawUniq         [uniqueidentifier] NOT NULL,
 RawIdentity     [int]              NOT NULL,

PRIMARY KEY(PacIOOSTimeUTC,CWBLocationCode)
)
select * from CWBRaw
-------

-- cast varchars to numeric and other massaging we need into CWBRaw
--   DELETE FROM CWBRaw
--  INSERT INTO CWBRaw
 SELECT 
CAST(timeUTC AS datetime2), -- PacIOOSTimeUTC
location_id,                -- CWBLocationCode pk
location_name,              -- CWBLocationName
'temp',                     -- MyLabel
NULL,NULL,NULL,             -- pkSample R1,R2,R3
latitude,                   -- PacIOOS_POINT_Y
longitude,                  -- PacIOOS_POINT_X

-- Analytes convert to decimal 38,8 that esri likes
CAST(enterococcus      AS numeric(38,8)),--1
CAST(clostridium_perf  AS numeric(38,8)),
CAST(Alert             AS int          ),--Alrt6361 except for Alert which is NOT an analyte but PacIOOS treated as such
CAST(temperature       AS numeric(38,8)),
CAST(salinity          AS numeric(38,8)),--5
CAST(turbidity         AS numeric(38,8)),
CAST(ph                AS numeric(38,8)),
CAST(massoxygen        AS numeric(38,8)),
CAST(fracsatoxygen     AS numeric(38,8)),--9
--
-1,-1,         -- AlertCount, RecordCount
'temp',        -- TempMyLabel
newid(),       -- RawUniq
cwbIID         -- copy iid from import
FROM CWBRawVarChars
ORDER BY cwbIID
-- (10655 rows affected)
select * from CWBRaw
-- 10655
----------------------------------------------
-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
/*
-- test again
-- SELECT * FROM CWBRawVarChars
-- SELECT * from CWBRaw
select DISTINCT(CWBLocationCode) from CWBRaw
-- 48
select COUNT(DISTINCT(CWBLocationCode)) from CWBRaw
-- 48
select DISTINCT(CWBLocationName) from CWBRaw
-- 48
select COUNT(DISTINCT(CWBLocationName)) from CWBRaw
-- 48
select DISTINCT(MyLabel) from CWBRaw
-- 48
select COUNT(DISTINCT(MyLabel)) from CWBRaw
-- 48
*/

-- clean up their names with lower case and no space since we are going to use for a filename/label
UPDATE CWBRAW SET TempMyLabel = REPLACE(REPLACE(CWBLocationName, '-', ''), '.', '') -- scrub out '-' and '.' 
select * from CWBRaw

UPDATE CWBRaw SET MyLabel = 'KahaluuBeach'              WHERE TempMyLabel =  RTRIM('Kahaluu Beach Park               ')--1066
UPDATE CWBRaw SET MyLabel = 'HapunaBeach'               WHERE TempMyLabel =  RTRIM('Hapuna Beach                     ')--480
UPDATE CWBRaw SET MyLabel = 'MagicSands'                WHERE TempMyLabel =  RTRIM('Magic Sands                      ')--469
UPDATE CWBRaw SET MyLabel = 'KawaihaeLST'               WHERE TempMyLabel =  RTRIM('Kawaihae LST Landing             ')--182
UPDATE CWBRaw SET MyLabel = 'Milolii'                   WHERE TempMyLabel =  RTRIM('Milolii                          ')--96
UPDATE CWBRaw SET MyLabel = 'KuaBay'                    WHERE TempMyLabel =  RTRIM('Kua Bay                          ')--141
UPDATE CWBRaw SET MyLabel = 'HonaunauRef'               WHERE TempMyLabel =  RTRIM('Honaunau Bay (City of Refuge)    ')--47
UPDATE CWBRaw SET MyLabel = 'KeauhouBay'                WHERE TempMyLabel =  RTRIM('Keauhou Bay                      ')--344
UPDATE CWBRaw SET MyLabel = 'Mahukona'                  WHERE TempMyLabel =  RTRIM('MAHUKONA LANDING                 ')--47
UPDATE CWBRaw SET MyLabel = 'KailuaPierA'               WHERE TempMyLabel =  RTRIM('Kailua Pier Sta A                ')--289
															  
UPDATE CWBRaw SET MyLabel = 'Honaunau'                  WHERE TempMyLabel =  RTRIM('HONAUNAU BAY (EMBAYMENT)         ')--1
UPDATE CWBRaw SET MyLabel = 'Anaehoomalu'               WHERE TempMyLabel =  RTRIM('Anaehoomalu Bay                  ')--965
UPDATE CWBRaw SET MyLabel = 'SpencerBeach'              WHERE TempMyLabel =  RTRIM('Spencer Beach Park               ')--399
UPDATE CWBRaw SET MyLabel = 'Honuapo'                   WHERE TempMyLabel =  RTRIM('Honuapo Landing                  ')--78
UPDATE CWBRaw SET MyLabel = 'KealakekuaCanoe'           WHERE TempMyLabel =  RTRIM('Kealakekua Bay (Canoe Landing)   ')--94
UPDATE CWBRaw SET MyLabel = 'KawaihaePier'              WHERE TempMyLabel =  RTRIM('KAWAIHAE HARBOR PIER             ')--87
UPDATE CWBRaw SET MyLabel = 'PineTrees'                 WHERE TempMyLabel =  RTRIM('Pine Trees                       ')--117
UPDATE CWBRaw SET MyLabel = 'MaunakeaBeach'             WHERE TempMyLabel =  RTRIM('MAUNA KEA HOTEL BEACH            ')--83
UPDATE CWBRaw SET MyLabel = 'Maunakea4th'               WHERE TempMyLabel =  RTRIM('MAUNA KEA HOTELOFF 4TH GREEN     ')--45
UPDATE CWBRaw SET MyLabel = 'KailuaPierA1'              WHERE TempMyLabel =  RTRIM('Kailua Pier Sta A1               ')--1081
															  
UPDATE CWBRaw SET MyLabel = 'OldAirport'                WHERE TempMyLabel =  RTRIM('Old Kona Airport                 ')--24
UPDATE CWBRaw SET MyLabel = 'Kealakekua'                WHERE TempMyLabel =  RTRIM('Kealakekua Bay (Embayment)       ')--128
UPDATE CWBRaw SET MyLabel = '2Step'                     WHERE TempMyLabel =  RTRIM('Honaunau Bay  2 Step             ')--75
UPDATE CWBRaw SET MyLabel = 'KailuaPierD'               WHERE TempMyLabel =  RTRIM('Kailua Pier Sta D                ')--926
UPDATE CWBRaw SET MyLabel = 'MaunaKeaSouth'             WHERE TempMyLabel =  RTRIM('Mauna Kea Beach South End        ')--139
UPDATE CWBRaw SET MyLabel = 'OTEC_NELHA'                WHERE TempMyLabel =  RTRIM('OTEC                             ')--174
UPDATE CWBRaw SET MyLabel = 'Punaluu'                   WHERE TempMyLabel =  RTRIM('Punaluu Beach Park               ')--1141
UPDATE CWBRaw SET MyLabel = 'Holoholokai'               WHERE TempMyLabel =  RTRIM('Holoholokai Beach Park           ')--114
UPDATE CWBRaw SET MyLabel = 'KeaholeOcean'              WHERE TempMyLabel =  RTRIM('KEAHOLE POINT (OCEANIC)          ')--156
UPDATE CWBRaw SET MyLabel = 'BanyansSurf'               WHERE TempMyLabel =  RTRIM('Banyan''s Surfing Area           ')--225
															  
UPDATE CWBRaw SET MyLabel = 'KailuaPierB'               WHERE TempMyLabel =  RTRIM('KAILUA PIER STATION B            ')--104
UPDATE CWBRaw SET MyLabel = 'KonaHilton'                WHERE TempMyLabel =  RTRIM('KONA HILTON SHORELINE            ')--121
UPDATE CWBRaw SET MyLabel = 'PuakoRamp'                 WHERE TempMyLabel =  RTRIM('Puako Boat Ramp                  ')--151
UPDATE CWBRaw SET MyLabel = 'Waiulaula'                 WHERE TempMyLabel =  RTRIM('Waiulaula                        ')--48
UPDATE CWBRaw SET MyLabel = 'Hualalai4Seas'             WHERE TempMyLabel =  RTRIM('Hualalai 4 Seasons               ')--25
UPDATE CWBRaw SET MyLabel = 'MaunaKea'                  WHERE TempMyLabel =  RTRIM('MAUNA KEA BEACH HOTELOUTFALL     ')--44
UPDATE CWBRaw SET MyLabel = 'Honokahau'                 WHERE TempMyLabel =  RTRIM('HONOKAHAU BOAT HARBOR (EMBAYMENT)')--25
UPDATE CWBRaw SET MyLabel = 'KealaCurio'                WHERE TempMyLabel =  RTRIM('Kealakekua Bay (Curio Stand)     ')--258
UPDATE CWBRaw SET MyLabel = 'KauhakoHookena'            WHERE TempMyLabel =  RTRIM('Kauhako Bay  Hookena             ')--97
UPDATE CWBRaw SET MyLabel = 'Pelekane'                  WHERE TempMyLabel =  RTRIM('Pelekane                         ')--80
															  
UPDATE CWBRaw SET MyLabel = 'PuakoMiddle'               WHERE TempMyLabel =  RTRIM('Puako Middle of Lot              ')--1010
UPDATE CWBRaw SET MyLabel = 'PauoaBay'                  WHERE TempMyLabel =  RTRIM('Pauoa Bay                        ')--107
UPDATE CWBRaw SET MyLabel = 'Keauhou'                   WHERE TempMyLabel =  RTRIM('KEAUHOU BAY (EMBAYMENT)          ')--31
UPDATE CWBRaw SET MyLabel = 'KonaCoast'                 WHERE TempMyLabel =  RTRIM('Kona Coast Beach Park            ')--113
UPDATE CWBRaw SET MyLabel = 'Y'                         WHERE TempMyLabel =  RTRIM('Y                                ')--10
UPDATE CWBRaw SET MyLabel = 'KailuaPierC'               WHERE TempMyLabel =  RTRIM('KAILUA PIER STATION C            ')--93
UPDATE CWBRaw SET MyLabel = 'PuakoFarEnd'               WHERE TempMyLabel =  RTRIM('PUAKO BEACH LOTSFAR END OF LOT   ')--114
UPDATE CWBRaw SET MyLabel = 'BoatRamp'                  WHERE TempMyLabel =  RTRIM('Honaunau Bay  Boat Ramp          ')--11
------------------------------------------------------
------------------------------------------------------
select MyLabel from CWBRaw
select MyLabel from CWBRaw
where MyLabel = 'temp'
-- none. good all accounted for
-------------------------------------------------------------------------
-------------------------------------------------------------------------
-------------------------------------------------------------------------

-- this is a shorted FCStation for working purposes, want to get the distinct stations
-- into a table for working to prepare for FCStation, TBSample
--  DROP  TABLE CWBFCStationGeoCode_Temp
CREATE TABLE CWBFCStationGeoCode_Temp (
 CWBLocationCode [nvarchar](255)    NOT NULL,
 MyLabel         [nvarchar](255)    NOT NULL,
 mShore          [int]                  NULL,

 -- dates will be manually set from EIS document
 StartDate       [datetime2](7)         NULL,
 EndDate         [datetime2](7)         NULL,
 tStartDate      [nvarchar](255)        NULL,--text version of StartDate for name strings
 tEndDate        [nvarchar](255)        NULL,
 									    
 RecordCount     [int]                  NULL,
 tRecordCount    [nvarchar](255)        NULL,
 									    
 AlertCount      [int]                  NULL,
 tAlertCount     [nvarchar](255)        NULL,
 									    
 POINT_Y         [numeric](38,8)        NULL,
 POINT_X         [numeric](38,8)        NULL,
 MyLatLong       [nvarchar](255)        NULL,
 MyLatitude      [nvarchar](255)        NULL,
 PacIOOSLLUsed   [nvarchar](255)        NULL,
 --									    
 pkStationT      [nvarchar](255)        NULL,
 pkSampleT       [nvarchar](255)        NULL,
									    
-- for pkStation, pkSample names	    
 MyAnalyteList	 [nvarchar](255)        NULL,
 
 GeoUniq         [uniqueidentifier]     NULL,
 RawUniq         [uniqueidentifier]     NULL,

PRIMARY KEY (CWBLocationCode)
)

-- perform the most basic insert to get distinct location codes
--    DELETE FROM  CWBFCStationGeoCode_Temp
--  INSERT INTO CWBFCStationGeoCode_Temp
Select DISTINCT(CWBLocationCode), MyLabel,
NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
FROM CWBRaw 
GROUP BY CWBLocationCode, MyLabel
ORDER BY CWBLocationCode, MyLabel
-- 48 rows

-- common updates
UPDATE CWBFCStationGeoCode_Temp SET RawUniq = newid()
UPDATE CWBFCStationGeoCode_Temp SET mShore  = 1   -- assumption 1meter from shore since no data otherwise
SELECT * FROM CWBFCStationGeoCode_Temp
--48

---------------------------------------------------
---------------------------------------------------
---------------------------------------------------
---------------------------------------------------
---------------------------------------------------
-- process to acquire record and alert counts
-- need separate table since this is an aggregative selection

--  DROP table CWBSampleCounts_temp
CREATE TABLE CWBSampleCounts_temp (
  CWBLocationCode  [int]           NOT NULL,
  RecordCount      [nvarchar](255) NOT NULL,

PRIMARY KEY (CWBLocationCode)
)

--  INSERT INTO CWBSampleCounts_temp
SELECT DISTINCT(CWBLocationCode), COUNT(CWBLocationCode)
from CWBRaw
GROUP BY CWBLocationCode
ORDER BY CWBLocationCode 
-- 48 rows, 48 distinct sites in the raw PacIOOS database
--
-- update record/sample count first
UPDATE CWBFCStationGeoCode_Temp SET 
RecordCount = counts.RecordCount, tRecordCount = RIGHT('0000' + LTRIM(str(counts.RecordCount)), 4) + 'Samples_'
FROM CWBSampleCounts_temp counts
WHERE CWBFCStationGeoCode_Temp.CWBLocationCode = counts.CWBLocationCode AND counts.RecordCount IS NOT NULL
-- 48
-- take care of NULL values
UPDATE CWBFCStationGeoCode_Temp SET tRecordCount = 'Samples_NaN' FROM CWBSampleCounts_temp counts WHERE tRecordCount IS NULL
--0 (as expected)

-- Now Alert counts
--   DROP table CWBAlertCounts_temp
CREATE TABLE CWBAlertCounts_temp (
   CWBLocationCode  [int]          NOT NULL,
   AlertCount      [nvarchar](255) NOT NULL,

PRIMARY KEY (CWBLocationCode)
)

--  INSERT INTO CWBAlertCounts_temp
SELECT DISTINCT(CWBLocationCode), COUNT(CWBLocationCode)
from CWBRaw
WHERE Alrt6361 = 1
GROUP BY CWBLocationCode
ORDER BY CWBLocationCode
--33 out of 48 has alerts
UPDATE CWBFCStationGeoCode_Temp SET 
AlertCount = counts.AlertCount, tAlertCount = RIGHT('000'  + LTRIM(str(ISNULL(counts.AlertCount, 0),3)) , 3) + 'Alerts_' 
FROM CWBAlertCounts_temp counts
WHERE CWBFCStationGeoCode_Temp.CWBLocationCode = counts.CWBLocationCode AND counts.AlertCount IS NOT NULL
--33
-- take care of NULL values with searchable text
UPDATE CWBFCStationGeoCode_Temp SET tAlertCount = 'NaNAlerts' FROM CWBAlertCounts_temp WHERE (tAlertCount IS NULL)
-- 15
select * from CWBFCStationGeoCode_Temp

select CWBLocationCode,MyLabel,AlertCount from CWBFCStationGeoCode_Temp order by AlertCount desc
-- 48

------------------------------------------------------
------------------------------------------------------
-- My geocoding since their data is often very wrong
 -- populate my geocoded locations for sites I have geocoded with Google MyMaps, which is most
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.99104, POINT_X=-155.82639,GeoUniq=newid() WHERE CWBLocationCode = '1200'--480
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.42152, POINT_X=-155.91130,GeoUniq=newid() WHERE CWBLocationCode = '1201'--47
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.08463, POINT_X=-155.55000,GeoUniq=newid() WHERE CWBLocationCode = '1202'--78
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.57932, POINT_X=-155.96703,GeoUniq=newid() WHERE CWBLocationCode = '1203'--1066
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.63965, POINT_X=-155.99495,GeoUniq=newid() WHERE CWBLocationCode = '1204'--289
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.63937, POINT_X=-155.99667,GeoUniq=newid() WHERE CWBLocationCode = '1205'--1081
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.63845, POINT_X=-155.99672,GeoUniq=newid() WHERE CWBLocationCode = '1206'--1104
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.63854, POINT_X=-155.99698,GeoUniq=newid() WHERE CWBLocationCode = '1207'--93
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.63958, POINT_X=-155.99744,GeoUniq=newid() WHERE CWBLocationCode = '1208'--926
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.37950, POINT_X=-155.89825,GeoUniq=newid() WHERE CWBLocationCode = '1209'--97
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=20.03734, POINT_X=-155.82993,GeoUniq=newid() WHERE CWBLocationCode = '1210'--87
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.47554, POINT_X=-155.91973,GeoUniq=newid() WHERE CWBLocationCode = '1211'--258
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.47119, POINT_X=-155.92046,GeoUniq=newid() WHERE CWBLocationCode = '1212'--94
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.92477, POINT_X=-155.89078,GeoUniq=newid() WHERE CWBLocationCode = '1214'--121
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.56193, POINT_X=-155.96227,GeoUniq=newid() WHERE CWBLocationCode = '1213'--344
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.59456, POINT_X=-155.97212,GeoUniq=newid() WHERE CWBLocationCode = '1215'--469
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=20.18381, POINT_X=-155.90079,GeoUniq=newid() WHERE CWBLocationCode = '1216'--47
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=20.01032, POINT_X=-155.82535,GeoUniq=newid() WHERE CWBLocationCode = '1218'--45
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=20.00613, POINT_X=-155.82557,GeoUniq=newid() WHERE CWBLocationCode = '1219'--83
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.18222, POINT_X=-155.90794,GeoUniq=newid() WHERE CWBLocationCode = '1220'--96
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.97414, POINT_X=-155.83171,GeoUniq=newid() WHERE CWBLocationCode = '1221'--151
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.96866, POINT_X=-155.84568,GeoUniq=newid() WHERE CWBLocationCode = '1222'--1010
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.97244, POINT_X=-155.83541,GeoUniq=newid() WHERE CWBLocationCode = '1223'--114
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.13585, POINT_X=-155.50470,GeoUniq=newid() WHERE CWBLocationCode = '1224'--141
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=20.02402, POINT_X=-155.82280,GeoUniq=newid() WHERE CWBLocationCode = '1225'--399
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.42282, POINT_X=-155.91118,GeoUniq=newid() WHERE CWBLocationCode = '1226'--24
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.42611, POINT_X=-155.91721,GeoUniq=newid() WHERE CWBLocationCode = '1229'--1
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.56060, POINT_X=-155.96631,GeoUniq=newid() WHERE CWBLocationCode = '1231'--31
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.66833, POINT_X=-156.03117,GeoUniq=newid() WHERE CWBLocationCode = '1233'--25
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.73027, POINT_X=-156.06500,GeoUniq=newid() WHERE CWBLocationCode = '1234'--156
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.60644, POINT_X=-155.97671,GeoUniq=newid() WHERE CWBLocationCode = '1235'--225
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.91422, POINT_X=-155.88765,GeoUniq=newid() WHERE CWBLocationCode = '1236'--965
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.71584, POINT_X=-156.04975,GeoUniq=newid() WHERE CWBLocationCode = '1237'--174
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=20.03146, POINT_X=-155.82979,GeoUniq=newid() WHERE CWBLocationCode = '1238'--182
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.67186, POINT_X=-156.02632,GeoUniq=newid() WHERE CWBLocationCode = '1239'--0  <<<<<<<<<<<<<<<<<<<<<
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.47339, POINT_X=-155.91927,GeoUniq=newid() WHERE CWBLocationCode = '1240'--10
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.78153, POINT_X=-156.04138,GeoUniq=newid() WHERE CWBLocationCode = '1241'--113
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.63815, POINT_X=-156.00369,GeoUniq=newid() WHERE CWBLocationCode = '1242'--0  <<<<<<<<<<<<<<<<<<<<<
--	   
-- these the ones I used the PacIOOS coords
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=20.014720, POINT_X=-155.82944, PacIOOSLLUsed='20.014720,-155.82944',GeoUniq=newid() WHERE CWBLocationCode = '1217'--44
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=20.014720, POINT_X=-155.82944, PacIOOSLLUsed='19.471697,-155.93077',GeoUniq=newid() WHERE CWBLocationCode = '1230'--128
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=20.003610, POINT_X=-155.82510, PacIOOSLLUsed='20.003610 -155.82510',GeoUniq=newid() WHERE CWBLocationCode = '1243'--139
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.421453, POINT_X=-155.91140, PacIOOSLLUsed='19.421453 -155.91140',GeoUniq=newid() WHERE CWBLocationCode = '1244'--176
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.422945, POINT_X=-155.91100, PacIOOSLLUsed='19.422945 -155.91100',GeoUniq=newid() WHERE CWBLocationCode = '1245'--11
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=20.027512, POINT_X=-155.82446, PacIOOSLLUsed='20.027512 -155.82446',GeoUniq=newid() WHERE CWBLocationCode = '1246'--80
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=20.013636, POINT_X=-155.82501, PacIOOSLLUsed='20.013636 -155.82501',GeoUniq=newid() WHERE CWBLocationCode = '1247'--48
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.955917, POINT_X=-155.86047, PacIOOSLLUsed='19.955917 -155.86047',GeoUniq=newid() WHERE CWBLocationCode = '1249'--114
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.952723, POINT_X=-155.86111, PacIOOSLLUsed='19.952723 -155.86111',GeoUniq=newid() WHERE CWBLocationCode = '1250'--107
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.830110, POINT_X=-155.95667, PacIOOSLLUsed='19.830110 -155.95667',GeoUniq=newid() WHERE CWBLocationCode = '1251'--25
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.810223, POINT_X=-156.00667, PacIOOSLLUsed='19.810223 -156.00667',GeoUniq=newid() WHERE CWBLocationCode = '1252'--141
UPDATE CWBFCStationGeoCode_Temp SET POINT_Y=19.695583, POINT_X=-156.04486, PacIOOSLLUsed='19.695583 -156.04486',GeoUniq=newid() WHERE CWBLocationCode = '1253'--117
--

select * from CWBFCStationGeoCode_Temp

/* make our fields for later insertions into our tables */
--
UPDATE CWBFCStationGeoCode_Temp SET
MyLatLong  = str(POINT_Y, 7, 4) + ' , ' + str(POINT_X, 9, 4),
MyLatitude = CAST( REPLACE( str( CAST(POINT_Y AS DECIMAL (7,4)),7,4),'.','_') AS varchar)
-- 35
select * from CWBFCStationGeoCode_Temp


/*
-- there should be nothing NULL in point location fields at this points
select count(*) from CWBFCStationGeoCode_Temp
WHERE POINT_Y IS NULL OR POINT_X IS NULL
-- 0
-- count how many have geocoded values that I did
select count(*) from CWBFCStationGeoCode_Temp
WHERE PacIOOSLLUsed IS NULL 
-- 36
-- how many were coded using PacIOOS locations + Mine = should be all
select count(*) from CWBFCStationGeoCode_Temp
WHERE PacIOOSLLUsed IS NOT NULL 
-- 12
*/

/* development only
SELECT geo.CWBLocationCode, raw.CWBLocationCode
FROM CWBMyGeocodedLocations_temp geo
RIGHT JOIN CWBRaw raw ON geo.CWBLocationCode = raw.CWBLocationCode
 --'1217' missing, no documentation provided on this one by state - 'MAUNA KEA BEACH HOTEL=OUTFALL'
SELECT COUNT(*),MIN(PacIOOSTimeUTC),MAX(PacIOOSTimeUTC) FROM CWBRaw WHERE CWBLocationCode = 1217
 -- 44	1973-06-12 23:25:00.0000000	1994-08-08 19:23:00.0000000
SELECT COUNT(*) FROM CWBRaw WHERE CWBLocationCode = 1217 AND Alrt6361 = 1
-- 1
SELECT * FROM CWBRaw WHERE CWBLocationCode = 1217 AND Alrt6361 = 1
/*
PacIOOSTimeUTC	latlongPacIOOS	CWBLocationCode	CWBLocationName	Ecci6410	Clos6420	Alrt6361	Temp6280	Sali6350	Turb6260	pHyd6390	O2mc6364   O2fs6365	MyLatLong	MyLatitude	MyLabel	POINT_Y	POINT_X	MyLocalTime	RawUniq	RawIdentity
1992-09-28 16:11:00.0000000	20.014723, -155.82944	1217	MAUNA KEA BEACH HOTEL-OUTFALL	152.00000000	NULL	1	NULL	34.00000000	NULL	NULL	NULL	NULL	20.014723, -155.82944	20_0147	MaunakeaBchOutfall	NULL	NULL	NULL	24960785-8B84-4395-9E0D-4AD456787E9D	1638
Ecc6410 = 152 is the reason
*/

SELECT * FROM CWBRaw 
WHERE PacIOOSTimeUTC BETWEEN '1992-07-01' and '1992-12-31'
AND  CWBLocationCode = 1217
*/

---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
--get min/max dates in separate table for later merge

--  DROP table CWBLocCountsMinMaxDates_temp
CREATE TABLE CWBLocCountsMinMaxDates_temp (
 CWBLocationCode  [nvarchar](255) NOT NULL,
 StartDate    [datetime2](7)      NOT NULL,
 EndDate      [datetime2](7)      NOT NULL,
 tStartDate   [nvarchar](255)         NULL,
 tEndDate     [nvarchar](255)         NULL,

PRIMARY KEY (CWBLocationCode)
)
--  INSERT INTO CWBLocCountsMinMaxDates_temp
SELECT
DISTINCT(raw.CWBLocationCode), Min(raw.PacIOOSTimeUTC), Max(raw.PacIOOSTimeUTC), NULL, NULL
FROM CWBRaw raw 
GROUP BY raw.CWBLocationCode
ORDER BY raw.CWBLocationCode
-- 48 rows
select * from CWBLocCountsMinMaxDates_temp

-- update and convert datetime to date only because we want to put named month-year in the pkSample and fkStation string
 UPDATE CWBLocCountsMinMaxDates_temp SET
tStartDate = SUBSTRING(CONVERT(varchar, StartDate, 109),1,11),
tEndDate   = SUBSTRING(CONVERT(varchar, EndDate,   109),1,11)
from CWBLocCountsMinMaxDates_temp
-- 48
select * from CWBLocCountsMinMaxDates_temp


-- move these over into out temp FCStation
 UPDATE CWBFCStationGeoCode_Temp SET
StartDate  = dates.StartDate,
EndDate    = dates.EndDate,
tStartDate = REPLACE(dates.tStartDate, ' ',''),
tEndDate   = REPLACE(dates.tEndDate,   ' ','')
FROM CWBLocCountsMinMaxDates_temp dates
WHERE CWBFCStationGeoCode_Temp.CWBLocationCode = dates.CWBLocationCode
--48
select * from CWBFCStationGeoCode_Temp
--

---------------------------------------------------------
---------------------------------------------------------
---------------------------------------------------------
---------------------------------------------------------
---------------------------------------------------------
---------------------------------------------------------

--
-- 19_xxxx_NameOfSite_0000Sample_000Alerts_YStartMonthYearToEndMonthYear_CWB12xx
/*RTRIM('19_9912_
HapunaBeach_
0480Samples_
07Alerts_
YApr1987ToNov2017_
CWB1200
 */

UPDATE CWBFCStationGeoCode_Temp SET 
pkStationT = MyLatitude + '_' + MyLabel + '_' + tRecordCount + tAlertCount + 
			'Y'+ tStartDate + 'To' + tEndDate + '_'  + 'CWB' + CWBLocationCode

UPDATE CWBFCStationGeoCode_Temp SET
pkSampleT = MyLatitude + '_DATEGOESHERE_' + MyLabel + '_' + tRecordCount + tAlertCount + 
			'Y'+ tStartDate + 'To' + tEndDate + '_'  + 'CWB' + CWBLocationCode
             
--48
select pkStationT,pkSampleT from CWBFCStationGeoCode_Temp

UPDATE CWBRaw SET pkSampleR1 = pkSampleT
FROM CWBFCStationGeoCode_Temp temp
WHERE CWBRaw.CWBLocationCode = temp.CWBLocationCode

UPDATE CWBRaw SET CWBRaw.RecordCount = temp.RecordCount
FROM CWBFCStationGeoCode_Temp temp
WHERE CWBRaw.CWBLocationCode = temp.CWBLocationCode
UPDATE CWBRaw SET CWBRaw.RecordCount = 0 WHERE CWBRaw.RecordCount is NULL
--
UPDATE CWBRaw SET CWBRaw.AlertCount = temp.AlertCount
FROM CWBFCStationGeoCode_Temp temp
WHERE CWBRaw.CWBLocationCode = temp.CWBLocationCode
UPDATE CWBRaw SET CWBRaw.AlertCount = 0 WHERE CWBRaw.AlertCount is NULL

select pkSampleR1, pkSampleR2, pkSampleR3 from CWBRaw

UPDATE CWBRaw SET pkSampleR2 =
REPLACE(pkSampleR1, 'DATEGOESHERE', SUBSTRING(CAST(PacIOOSTimeUTC as nvarchar) ,1,16)) 
--REPLACE(pkSampleR1, 'DATEGOESHERE', SUBSTRING(CAST(PacIOOSTimeUTC as nvarchar) ,1,10)) 
-- 
UPDATE CWBRaw SET pkSampleR3 =
REPLACE(REPLACE(REPLACE(pkSampleR2, '-', ''),' ',''),':','')
select * FROM CWBRaw


-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------
-- ok now all the fields have been converted for use in ArcGIS
-- the raw file is ready to make our tables and feature classes from
SELECT * FROM CWBRaw 
ORDER BY CWBLocationCode desc
--10655
select * from CWBFCStationGeoCode_Temp
ORDER BY CWBLocationCode desc
--48
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--  DROP  TABLE CWBFCStation
CREATE TABLE CWBFCStation (
	--[OBJECTID] [int] NOT NULL,
	--[Shape] [geometry] NULL,
	--[GDB_GEOMATTR_DATA] [varbinary](max) NULL,
	[pkStation] [nvarchar](255) NULL,     -- remove NOT for now and use fkStation1 during construction
	[Label] [nvarchar](255) NOT NULL,
	[TablePage] [nvarchar](255) NULL,
	[fkStation1] [nvarchar](255) NOT NULL, -- NOT since this is the PK for now (CWB#)
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

PRIMARY KEY (fkStation1)
)

SELECT * FROM CWBFCStationGeoCode_Temp
--
-- the next section are hand carved inserts set by unique properties of each site 
-- DONLOOK more documentation here
--  delete from CWBFCStation
 INSERT INTO CWBFCStation 
SELECT 
pkStationT,              -- pkStation
MyLabel,				 -- Label
NULL,				     -- TablePage
CWBLocationCode,		 -- fkStation1
str(AlertCount),         -- fkStation2
1,						 -- mShore
3499,					 -- dmStA
6499,					 -- dmStAA
3799,					 -- dmStBott
7110,					 -- dmStClas
4660,					 -- dmAccuracy
8855,					 -- dmStReef
7777,					 -- dmStRule
111,					 -- dmStType
NULL,					 -- fkEPA
NULL,					 -- fkUSGS
'No' ,					 -- Embayment
NULL,					 -- VolumeBay
NULL,					 -- CrossArea
REPLACE(MyLatitude,'_',''), -- AttachSt
NULL,					 -- HICWBTier
MyLatLong,				 -- dmAccu4610
NULL,					 -- dmAccu4620
NULL,					 -- dmAccu4630
NULL,					 -- dmAccu4640
NULL,					 -- dmAccu4650
MyLatLong,				 -- dmAccu4660
NULL,					 -- dmAccu4670
StartDate, 				 -- StartDate
EndDate,				 -- EndDate
NULL,					 -- StFloat1 
NULL,					 -- StFloat2 
NULL,					 -- StDate3
NULL,					 -- StDate4
NULL,	     			 -- StLong5
POINT_X,POINT_Y,         -- XField, YField
--
0,                                          -- Rotation
IIF(RecordCount is not NULL,RecordCount,0), -- Normalize
IIF(AlertCount is not NULL,AlertCount,0),   -- Weight
0,NULL,                      -- PageQuery/S
--
newid(),                     -- GeoUniq set only since can't set to null on table create
newid(),                     -- StatUniq is assigned here when making a new record
RawUniq                      -- tracer backwards
FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1200
--

 -- and the other 47 lined up for easy editting															  
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6470,3799,7110,4660,8855,7777,111,NULL,NULL,'Yes',NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1201--2
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4650,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1202
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4660,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1203
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6450,3799,7110,4660,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1204
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6450,3799,7110,4660,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1205
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6450,3799,7110,4650,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1206
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6450,3799,7110,4650,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1207
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6450,3799,7110,4660,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1208
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4650,8855,7777,111,NULL,NULL,'Yes',NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1209--10
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4650,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1210
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6460,3799,7110,4660,8855,7777,111,NULL,NULL,'Yes',NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1211
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3440,6499,3799,7110,4660,8855,7777,111,NULL,NULL,'Yes',NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1213
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3440,6499,3799,7110,4660,8855,7777,111,NULL,NULL,'Yes',NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1212
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3440,6499,3799,7110,4660,8855,7777,111,NULL,NULL,'Yes',NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1214
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4660,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1215
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4650,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1216
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4650,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1217
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4650,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1218
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4650,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1219--20
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4660,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1220
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6410,3799,7110,4660,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1221
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6410,3799,7110,4650,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1222
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6410,3799,7110,4650,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1223
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4660,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1224
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4660,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1225
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4660,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1226
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6470,3799,7110,4660,8855,7777,111,NULL,NULL,'Yes',NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1229
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4660,8855,7777,111,NULL,NULL,'Yes',NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1230
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3440,6499,3799,7110,4660,8855,7777,111,NULL,NULL,'Yes',NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1231--30
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4660,8855,7777,111,NULL,NULL,'Yes',NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1233
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4660,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1234
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4660,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1235
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6430,3799,7110,4660,8855,7777,111,NULL,NULL,'Yes',NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1236
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4660,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1237
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3420,6499,3799,7110,4660,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1238
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6460,3799,7110,4660,8855,7777,111,NULL,NULL,'Yes',NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1240
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4650,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1241
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4650,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1243
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6470,3799,7110,4650,8855,7777,111,NULL,NULL,'Yes',NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1244--40
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4699,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1245
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4650,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1246
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6420,3799,7110,4650,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1247
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4650,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1249
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4650,8855,7777,111,NULL,NULL,'Yes',NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1250
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4650,8855,7777,111,NULL,NULL,'No', NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1251
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4650,8855,7777,111,NULL,NULL,'Yes',NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1252
INSERT INTO CWBFCStation SELECT pkStationT,MyLabel,NULL,CWBLocationCode,str(AlertCount),1,3499,6499,3799,7110,4650,8855,7777,111,NULL,NULL,'No' ,NULL,NULL,REPLACE(MyLatitude,'_',''), NULL,MyLatLong, NULL,NULL,NULL,NULL,MyLatLong,NULL,StartDate,EndDate,NULL,NULL,NULL,NULL,AlertCount,POINT_X,POINT_Y,(CWBLocationCode * 90) % 360,IIF(RecordCount is not NULL,RecordCount,0),IIF(AlertCount is not NULL,AlertCount,0),0,NULL,newid(),newid(),RawUniq  FROM CWBFCStationGeoCode_Temp WHERE CWBLocationCode = 1253--48
--
--
select * from CWBFCStation
-- 48 rows

-- all CWB considered 1 meter from shore (based on pictures and lack of any other distance information)
UPDATE CWBFCStation SET pkStation = pkStation + '_001m'
--19_0846_HonuapoLanding_0078Samples_001Alerts_YJan281991ToAug92012_CWB1202_001m
UPDATE CWBFCStation SET TablePage='oos.soest.hawaii.edu/erddap/tabledap/cwb_water_quality.html'
UPDATE CWBFCStation SET fkStation2 = '0' WHERE fkStation2 IS NULL

/*
-- again, make sure we have row level integrity
declare @testguid uniqueidentifier = '5FE2F38E-B021-4E8E-A6C5-0072C40DF033'
select * from CWBFCStationGeoCode_Temp where RawUniq  = @testguid
select * from CWBRaw             where RawUniq  = @testguid
select * from CWBFCStation       where RawUniq  = @testguid
-- should be exactly 1 row each...and the same one!...
-- this was last tested 1/25/2018
*/

-- make the StartDate and EndDate unique
select pkStation from CWBFCStation where StartDate = '1976-03-08 23:40:00.0000000'
UPDATE CWBFCStation SET StartDate = '1976-03-08 23:40:01.00000' WHERE StartDate = '1976-03-08 23:40:00.0000000' AND pkStation = '19_3795_KauhakoHookena_0097Samples_002Alerts_YMar81976ToAug162017_CWB1209_001m'
UPDATE CWBFCStation SET StartDate = '1976-03-08 23:40:02.00000' WHERE StartDate = '1976-03-08 23:40:00.0000000' AND pkStation = '19_4755_KealaCurio_0258Samples_001Alerts_YMar81976ToAug162017_CWB1211_001m'
--

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- Next is preparation for inserting into TBSample
-- the goal is develop a string of analytes without null(NaN) for each sample of the raw data
-- this will be used for the pkSample multi-part name string of the TBSample table

--   DROP TABLE CWBDateWithAnalyte_temp
CREATE TABLE CWBDateWithAnalyte_temp (
A_PacIOOSTimeUTC    [datetime2](7)     NOT NULL,
A_CWBLocationCode   [nvarchar](255)    NOT NULL,
--
tEcci6410      [nvarchar](255)    NULL,
tClos6420      [nvarchar](255)    NULL,
tAlrt6361True  [nvarchar](255)    NULL,
tAlrt6361False [nvarchar](255)    NULL,
tAlrt6361Null  [nvarchar](255)    NULL,
tTemp6280      [nvarchar](255)    NULL,
tSali6350      [nvarchar](255)    NULL,
tTurb6260      [nvarchar](255)    NULL,
tpHyd6390      [nvarchar](255)    NULL,
tO2mc6364      [nvarchar](255)    NULL,
tO2fs6365      [nvarchar](255)    NULL,
-- my fields
alertTrue      [int]              NOT NULL,
A_RawUniq      [uniqueidentifier] NOT NULL,
A_NewUniq      [uniqueidentifier] NOT NULL,
)


-- most basic initial insert comes directly from CWBRaw with straight insert
--  INSERT into CWBDateWithAnalyte_temp
SELECT DISTINCT(PacIOOSTimeUTC) dt, CWBLocationCode, NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 0,raw.RawUniq,newid()
from CWBRaw raw
ORDER BY dt, CWBLocationCode
-- 10655

select * from CWBDateWithAnalyte_temp

-- Alert status first in the list we are creating for the pkSample in TBSample
UPDATE CWBDateWithAnalyte_temp 
SET tAlrt6361True='YES_ALERT_', alertTrue = 1
from CWBRaw raw, CWBDateWithAnalyte_temp dwa
where Alrt6361 is not NULL  AND Alrt6361 = '1'
and raw.PacIOOSTimeUTC = dwa.A_PacIOOSTimeUTC
-- 240
UPDATE CWBDateWithAnalyte_temp 
SET tAlrt6361False='Not_Alert_'
from CWBRaw raw, CWBDateWithAnalyte_temp dwa
where Alrt6361 is not NULL AND Alrt6361 = '0'
and raw.PacIOOSTimeUTC = dwa.A_PacIOOSTimeUTC
-- 9571
UPDATE CWBDateWithAnalyte_temp 
SET tAlrt6361Null='NaN_Alert_'
from CWBRaw raw, CWBDateWithAnalyte_temp dwa
where Alrt6361 is NULL
and raw.PacIOOSTimeUTC = dwa.A_PacIOOSTimeUTC
-- 846 nulls
select * from CWBDateWithAnalyte_temp


-- update CWBDateWithAnalyte_temp set tEcci6410=NULL
UPDATE CWBDateWithAnalyte_temp 
SET tEcci6410='Ecci6410'
from CWBRaw raw, CWBDateWithAnalyte_temp dwa
where Ecci6410 is not NULL
and raw.PacIOOSTimeUTC = dwa.A_PacIOOSTimeUTC
-- 9811
UPDATE CWBDateWithAnalyte_temp 
SET tClos6420='Clos6420'
from CWBRaw raw, CWBDateWithAnalyte_temp dwa
where Clos6420 is not NULL
and raw.PacIOOSTimeUTC = dwa.A_PacIOOSTimeUTC
-- 5648
UPDATE CWBDateWithAnalyte_temp 
SET tSali6350='Sali6350'
from CWBRaw raw, CWBDateWithAnalyte_temp dwa
where Sali6350 is not NULL
and raw.PacIOOSTimeUTC = dwa.A_PacIOOSTimeUTC
-- 7712
UPDATE CWBDateWithAnalyte_temp 
SET tTurb6260='Turb6260'
from CWBRaw raw, CWBDateWithAnalyte_temp dwa
where Turb6260 is not NULL
and raw.PacIOOSTimeUTC = dwa.A_PacIOOSTimeUTC
-- 5399
UPDATE CWBDateWithAnalyte_temp 
SET tpHyd6390='pHyd6390'
from CWBRaw raw, CWBDateWithAnalyte_temp dwa
where pHyd6390 is not NULL
and raw.PacIOOSTimeUTC = dwa.A_PacIOOSTimeUTC
-- 5316
UPDATE CWBDateWithAnalyte_temp 
SET tO2mc6364='O2mc6364'
from CWBRaw raw, CWBDateWithAnalyte_temp dwa
where O2mc6364 is not NULL
and raw.PacIOOSTimeUTC = dwa.A_PacIOOSTimeUTC
-- 5722
UPDATE CWBDateWithAnalyte_temp 
SET tO2fs6365='O2fs6365'
from CWBRaw raw, CWBDateWithAnalyte_temp dwa
where O2fs6365 is not NULL
and raw.PacIOOSTimeUTC = dwa.A_PacIOOSTimeUTC
-- 4469


select * from CWBDateWithAnalyte_temp
-- 10655 rows, now! final construction complete to allow assemblage of list of analytes by date

------------------------------------------
-- create single string of analyes available by date in a new table from above
--   DROP Table CWBAnalyteNamesByDate_temp 
CREATE TABLE CWBAnalyteNamesByDate_temp (
   D_PacIOOSTimeUTC   [datetime2](7)     NOT NULL,
   D_CWBLocationCode  [nvarchar](255)    NOT NULL,
   D_alertTrue        [int]              NOT NULL,
   AnalyteList        [nvarchar](255)    NOT NULL,
   D_RawUniq          [uniqueidentifier] NOT NULL,
   D_NewUniq          [uniqueidentifier] NOT NULL,
   ANDNewUniq         [uniqueidentifier] NOT NULL
)

-- create analyte list by pull non-NULL strings, this makes looking at the data more informative and
-- saves the user from having to figure out since we have all the information assembled
--  INSERT INTO CWBAnalyteNamesByDate_temp
SELECT 
dwa.A_PacIOOSTimeUTC,
dwa.A_CWBLocationCode,
dwa.alertTrue,
RTRIM(
ISNULL(tAlrt6361True,'')+
ISNULL(tAlrt6361False,'')+
ISNULL(tAlrt6361Null,'')+
ISNULL(tEcci6410,'')+
ISNULL(tClos6420,'')+
ISNULL(tTemp6280,'')+
ISNULL(tSali6350,'')+
ISNULL(tTurb6260,'')+
ISNULL(tpHyd6390,'')+
ISNULL(tO2mc6364,'')+
ISNULL(tO2fs6365,'')),
dwa.A_RawUniq, dwa.A_NewUniq, newid()
FROM CWBDateWithAnalyte_temp dwa
ORDER BY dwa.A_PacIOOSTimeUTC, dwa.A_CWBLocationCode
-- 10655 rows affected

-- test for count, been keeping track for alert count in entire table is 240
select * from CWBAnalyteNamesByDate_temp
where D_alertTrue = 1 ORDER BY D_PacIOOSTimeUTC desc
-- 240 good




-- FCStation complete and many preparations compete, move to insert data from CWBRaw and other tables
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- Now work on the TBSample table
-- the pkSample name pieces are available to include fully formed names
-- there are 10655 sample, with up to 7 analytes recorded per sample
--  DROP TABLE CWBTBSample
CREATE TABLE CWBTBSample (
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

-- my working fields
	[AnalyteListForpkSample] [nvarchar](255) NOT NULL,
PRIMARY KEY (pkSample)
)
GO

/*
-- DROP TABLE CWBTBSample2
CREATE TABLE CWBTBSample2 (
	--[OBJECTID] [int] NOT NULL,
	[pkSample] [nvarchar](255) NOT NULL,
		[RawUniq] [uniqueidentifier] NULL
PRIMARY KEY (pkSample)
)
GO
*/
/*
-- INSERT INTO CWBTBSample
SELECT 
raw.pkSampleR3,newid()
FROM CWBRaw raw
where PacIOOSTimeUTC > '2010-01-01' and CWBLocationCode not in ( 1203,1235,1208,1237,1241,1252)
*/

-------------------------------
-------------------------------
--    DELETE FROM CWBTBSample
--  INSERT INTO CWBTBSample
SELECT 
raw.pkSampleR3,
RTRIM(raw.MyLabel + ' (' + raw.CWBLocationCode + ')'), -- LabelName
NULL,                    -- TablePage
raw.AlertCount,          --
'CleanWaterBranch',      -- fkIDLoc
-1,1,                    -- no transect and always 1 meter from shore for CWB
'PacIOOS',               -- 
raw.CWBLocationCode,     -- 4 digit code assigned by Clean Water Branch for a station
'CWB',                   --
newid(),                 -- fkUniqID is the new if generated in this new row creation of the insert
'<<fkOrg>>',             -- 
1410,                    --d mRAMethod, in the field
raw.PacIOOSTimeUTC,      -- StartDate/EndDate
raw.PacIOOSTimeUTC,      -- use PacIOOS time, was going to convert to local but decided to leave alone
'Time exists in UTC format from PacIOOS', -- and make such comment in TimeMissg field
NULL,NULL,
NULL,                    -- no Comment yet
REPLACE(str(YField),'_',''),
NULL,NULL,NULL,NULL,NULL,
0,0,0,1,NULL,               -- cartography fields
newid(),
raw.RawUniq,             -- important for tracing to save source row id
'<<getlist>>'            --
FROM CWBRaw raw
LEFT JOIN CWBFCStation stat 
ON raw.CWBLocationCode = stat.fkStation1
ORDER BY raw.pkSampleR3
-- 10655 affected

--select * from CWBRaw where pkSampleR3 = '19_1359_19730613_PunaluuBeachPark_0141Samples_001Alerts_YJun131973ToAug92012_CWB1224'
--select * from CWBRaw where pkSampleR3 = '19_4755_1979082019_KealakekuaBayCurio_0258Samples_001Alerts_YMar81976ToAug162017_CWB1211'

--select * from CWBRaw where pkSampleR3 = '19_1359_19730613_PunaluuBeachPark_0141Samples_001Alerts_YJun131973ToAug92012_CWB1224'
--select * from CWBRaw where pkSampleR3 = '19_4755_1979082019_KealakekuaBayCurio_0258Samples_001Alerts_YMar81976ToAug162017_CWB1211'


select * from CWBRaw 
where CWBLocationCode = 1224 order by PacIOOSTimeUTC
-- 10655
select * from CWBTBSample

/*
-- integrity check, should match the 10655 row count I have been seeing all along
SELECT count(raw.RawUniq)
from CWBTBSample samp, CWBRaw raw
where samp.RawUniq = raw.RawUniq
-- 10655 rows good!
SELECT count(raw.RawUniq)
from CWBFCStation station, CWBRaw raw
where station.RawUniq = raw.RawUniq
-- 48 good DONLOOK
SELECT count(samp.RawUniq)
from CWBFCStation station, CWBTBSample samp
where samp.RawUniq = station.RawUniq
-- 48 rows good! these 2 going to ersi

-- again, make sure we have row level integrity
--select * from CWBTBSample
--select * from CWBFCStation
--declare @testguid uniqueidentifier = '5A1DC6EA-88F8-43CF-92F6-633A740F9C62'
declare @testguid uniqueidentifier = '707DC9F1-FB47-4E53-9180-00CC1179ADE0'
SELECT * from CWBRaw             where RawUniq  = @testguid
SELECT * from CWBTBSample        where RawUniq  = @testguid
SELECT * from CWBFCStation       where RawUniq  = @testguid
-- should be exactly 1 row each if test from FCStation...and the same one!...
-- this was last tested 1/25/2018
-- integrity tests over, continue populating fields we need from other tables
*/


-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------
-- IMPORTANT!
-- pull over assembled fields from temp table we prepared for
UPDATE CWBTBSample SET
CWBTBSample.AnalyteListForpkSample = analy.AnalyteList 
FROM CWBTBSample samp, CWBAnalyteNamesByDate_temp analy
where samp.RawUniq = analy.D_RawUniq
-- 10655 rows affected


--  DROP TABLE CWBAnalyteNamesByDate_temp ; DROP TABLE CWBFCStationGeoCode_Temp
--  DROP TABLE CWBAlertCounts_temp  ;DROP TABLE CWBLocCountsMinMaxDates_temp
select * from CWBTBSample


----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
-- now fill in the fields of CWBTBSample from other tables - CWBFCStation, CWBFCStationGeoCode_Temp
/*
Next update sequence adapted from this post
-- https://stackoverflow.com/questions/14618703/update-query-using-subquery-in-sql-server
*/

-- get pkStation from CWBFCStation, relationship requires some lower level code to
-- be sure the right records are updated. probably could be done with an update with inner join but this is
-- more clear since we get update counts and can verify easier (for me anyway)
DECLARE @Station varchar(255), @RawUniqueID varchar(255), @CWBLocationCode varchar(255), @LabelName varchar(255)
DECLARE @cursorInsert CURSOR SET @cursorInsert = CURSOR FOR
   SELECT pkStation, RawUniq, fkStation1, Label FROM CWBFCStation
OPEN @cursorInsert
FETCH NEXT FROM @cursorInsert INTO @Station ,@RawUniqueID, @CWBLocationCode, @LabelName
--
WHILE @@FETCH_STATUS = 0
   BEGIN
   UPDATE CWBTBSample 
   SET fkStation = @station 
   WHERE CWBTBSample.fkStation2 IN (SELECT @CWBLocationCode FROM CWBFCStation)
   --SELECT @station,@CWBLocationCode,fkStation2,LabelName,RawUniq,@RawUniqueID FROM CWBTBSample 
     --WHERE RawUniq = @RawUniqueID
	 --WHERE fkStation2 = @CWBLocationCode
   --SELECT @Station ,@RawUniqueID, @CWBLocationCode, @LabelName
   --SELECT TOP (1) pkStation, @rawuniqueid, RawUniq FROM CWBFCStation WHERE RawUniq = @rawuniqueid
   FETCH NEXT FROM @cursorInsert INTO @Station ,@RawUniqueID, @CWBLocationCode, @LabelName
   END
CLOSE @cursorInsert
DEALLOCATE @cursorInsert
--

select * from CWBTBSample

-----------------------------
-- this is what we have been building up for, to assemble the pkSample field
-- final pkSample is corename + analyte list
UPDATE CWBTBSample SET pkSample = pkSample + '_' + AnalyteListForpkSample
-- 10655
select * from CWBTBSample


-- make the StartDate and EndDate unique
select pkSample from CWBTBSample where StartDate = '1976-03-08 23:40:00.0000000'
UPDATE CWBTBSample SET StartDate = '1976-03-08 23:40:01.00000' WHERE StartDate = '1976-03-08 23:40:00.0000000' AND pkSample = '19_3795_197603082340_KauhakoBayHookena_0097Samples_002Alerts_YMar81976ToAug162017_CWB1209_NaN_Alert_Turb6260'
select pkSample from CWBTBSample where StartDate = '1973-09-10 22:00:00.0000000'
UPDATE CWBTBSample SET StartDate = '1973-09-10 22:00:00.0000000' WHERE StartDate = '1973-09-10 22:00:00.0000000' AND pkSample = '19_1359_197309102200_PunaluuBeachPark_0141Samples_001Alerts_YJun131973ToAug92012_CWB1224_NaN_Alert_Turb6260pHyd6390OxyD6270'
UPDATE CWBTBSample SET StartDate = '1973-09-10 22:00:01.0000000' WHERE StartDate = '1973-09-10 22:00:00.0000000' AND pkSample = '19_5619_197309102200_KeauhouBay_0344Samples_008Alerts_YJun131973ToJul272017_CWB1213_NaN_Alert_Turb6260pHyd6390OxyD6270'
UPDATE CWBTBSample SET StartDate = '1973-09-10 22:00:02.0000000' WHERE StartDate = '1973-09-10 22:00:00.0000000' AND pkSample = '19_5946_197309102200_MagicSands_0469Samples_004Alerts_YJun131973ToOct182017_CWB1215_NaN_Alert_Turb6260pHyd6390OxyD6270'
UPDATE CWBTBSample SET StartDate = '1973-09-10 22:00:03.0000000' WHERE StartDate = '1973-09-10 22:00:00.0000000' AND pkSample = '19_6396_197309102200_KailuaPierStationD_0926Samples_035Alerts_YJun131973ToNov22017_CWB1208_NaN_Alert_Turb6260pHyd6390OxyD6270'
UPDATE CWBTBSample SET StartDate = '1973-09-10 22:00:04.0000000' WHERE StartDate = '1973-09-10 22:00:00.0000000' AND pkSample = '20_0240_197309102200_SpencerBeachPark_0399Samples_010Alerts_YJun121973ToJul262017_CWB1225_NaN_Alert_Turb6260pHyd6390OxyD6270'
UPDATE CWBTBSample SET StartDate = '1973-09-10 22:00:05.0000000' WHERE StartDate = '1973-09-10 22:00:00.0000000' AND pkSample = '20_1838_197309102200_MahukonaLanding_0047Samples_001Alerts_YJun121973ToDec211998_CWB1216_NaN_Alert_Turb6260pHyd6390OxyD6270'
select pkSample from CWBTBSample where StartDate = '1974-12-09 22:00:00.0000000'
UPDATE CWBTBSample SET StartDate = '1974-12-09 22:00:01.0000000' WHERE StartDate = '1974-12-09 22:00:00.0000000' AND pkSample = '19_4215_197412092200_HonaunauBayRefuge_0047Samples_NaNAlertsYJun131973ToSep212009_CWB1201_NaN_Alert_Turb6260'
UPDATE CWBTBSample SET StartDate = '1974-12-09 22:00:02.0000000' WHERE StartDate = '1974-12-09 22:00:00.0000000' AND pkSample = '19_5619_197412092200_KeauhouBay_0344Samples_008Alerts_YJun131973ToJul272017_CWB1213_NaN_Alert_Turb6260'
UPDATE CWBTBSample SET StartDate = '1974-12-09 22:00:03.0000000' WHERE StartDate = '1974-12-09 22:00:00.0000000' AND pkSample = '19_5946_197412092200_MagicSands_0469Samples_004Alerts_YJun131973ToOct182017_CWB1215_NaN_Alert_Turb6260'
UPDATE CWBTBSample SET StartDate = '1974-12-09 22:00:04.0000000' WHERE StartDate = '1974-12-09 22:00:00.0000000' AND pkSample = '19_6396_197412092200_KailuaPierStationD_0926Samples_035Alerts_YJun131973ToNov22017_CWB1208_NaN_Alert_Turb6260'
select pkSample from CWBTBSample where StartDate = '2002-08-26 19:26:00.0000000'
UPDATE CWBTBSample SET StartDate = '2002-08-26 19:26:01.0000000' WHERE StartDate = '2002-08-26 19:26:00.0000000' AND pkSample = '19_5619_200208261926_KeauhouBay_0344Samples_008Alerts_YJun131973ToJul272017_CWB1213_Not_Alert_Ecci6410Clos6420Sali6350Turb6260OxyD6270'
UPDATE CWBTBSample SET StartDate = '2002-08-26 19:26:02.0000000' WHERE StartDate = '2002-08-26 19:26:00.0000000' AND pkSample = '19_5793_200208261926_KahaluuBeachPark_1066Samples_031Alerts_YApr271987ToNov22017_CWB1203_Not_Alert_Ecci6410Clos6420Sali6350Turb6260OxyD6270'
select pkSample from CWBTBSample where StartDate = '1993-11-29 20:40:00.0000000'
UPDATE CWBTBSample SET StartDate = '1993-11-29 20:40:01.0000000' WHERE StartDate = '1993-11-29 20:40:00.0000000' AND pkSample = '19_0846_199311292040_HonuapoLanding_0078Samples_001Alerts_YJan281991ToAug92012_CWB1202_Not_Alert_Ecci6410Sali6350'
UPDATE CWBTBSample SET StartDate = '1993-11-29 20:40:02.0000000' WHERE StartDate = '1993-11-29 20:40:00.0000000' AND pkSample = '19_6385_199311292040_KailuaPierStationB_0104Samples_001Alerts_YDec81975ToAug22007_CWB1206_Not_Alert_Ecci6410Sali6350'
select pkSample from CWBTBSample where StartDate = '1992-04-13 21:31:00.0000000'
UPDATE CWBTBSample SET StartDate = '1992-04-13 21:31:01.0000000' WHERE StartDate = '1992-04-13 21:31:00.0000000' AND pkSample = '19_5946_199204132131_MagicSands_0469Samples_004Alerts_YJun131973ToOct182017_CWB1215_Not_Alert_Ecci6410Sali6350Turb6260pHyd6390OxyD6270'
UPDATE CWBTBSample SET StartDate = '1992-04-13 21:31:02.0000000' WHERE StartDate = '1992-04-13 21:31:00.0000000' AND pkSample = '19_6394_199204132131_KailuaPierStationA1_1081Samples_018Alerts_YApr31990ToNov22017_CWB1205_Not_Alert_Ecci6410Sali6350Turb6260pHyd6390OxyD6270'
select pkSample from CWBTBSample where StartDate = '1999-11-29 16:30:00.0000000'
UPDATE CWBTBSample SET StartDate = '1999-11-29 16:30:01.0000000' WHERE StartDate = '1999-11-29 16:30:00.0000000' AND pkSample = '19_5946_199911291630_MagicSands_0469Samples_004Alerts_YJun131973ToOct182017_CWB1215_Not_Alert_Ecci6410Clos6420Sali6350'
UPDATE CWBTBSample SET StartDate = '1999-11-29 16:30:02.0000000' WHERE StartDate = '1999-11-29 16:30:00.0000000' AND pkSample = '19_6394_199911291630_KailuaPierStationA1_1081Samples_018Alerts_YApr31990ToNov22017_CWB1205_Not_Alert_Ecci6410Clos6420Sali6350'
select pkSample from CWBTBSample where StartDate = '1973-06-13 22:00:00.0000000'
select pkSample from CWBTBSample where EndDate = '1973-06-13 22:00:00.0000000'
UPDATE CWBTBSample SET StartDate = '1973-06-13 22:00:01.0000000' WHERE StartDate = '1973-06-13 22:00:00.0000000' AND pkSample = '19_1359_197306132200_PunaluuBeachPark_0141Samples_001Alerts_YJun131973ToAug92012_CWB1224_NaN_Alert_Turb6260pHyd6390OxyD6270'
UPDATE CWBTBSample SET StartDate = '1973-06-13 22:00:02.0000000' WHERE StartDate = '1973-06-13 22:00:00.0000000' AND pkSample = '19_6396_197306132200_KailuaPierStationD_0926Samples_035Alerts_YJun131973ToNov22017_CWB1208_NaN_Alert_Turb6260pHyd6390OxyD6270'
select pkSample from CWBTBSample where StartDate = '1999-11-29 22:30:00.0000000'
UPDATE CWBTBSample SET StartDate = '1999-11-29 22:30:01.0000000' WHERE StartDate = '1999-11-29 22:30:00.0000000' AND pkSample = '19_5946_199911292230_MagicSands_0469Samples_004Alerts_YJun131973ToOct182017_CWB1215_Not_Alert_Ecci6410Clos6420Sali6350'
UPDATE CWBTBSample SET StartDate = '1999-11-29 22:30:02.0000000' WHERE StartDate = '1999-11-29 22:30:00.0000000' AND pkSample = '19_6394_199911292230_KailuaPierStationA1_1081Samples_018Alerts_YApr31990ToNov22017_CWB1205_Not_Alert_Ecci6410Clos6420Sali6350'
select pkSample from CWBTBSample where StartDate = '1973-12-10 22:00:00.0000000'
UPDATE CWBTBSample SET StartDate = '1973-12-10 22:00:01.0000000' WHERE StartDate = '1973-12-10 22:00:00.0000000' AND pkSample = '19_5619_197312102200_KeauhouBay_0344Samples_008Alerts_YJun131973ToJul272017_CWB1213_NaN_Alert_Turb6260pHyd6390OxyD6270'
UPDATE CWBTBSample SET StartDate = '1973-12-10 22:00:02.0000000' WHERE StartDate = '1973-12-10 22:00:00.0000000' AND pkSample = '19_6396_197312102200_KailuaPierStationD_0926Samples_035Alerts_YJun131973ToNov22017_CWB1208_NaN_Alert_Turb6260pHyd6390OxyD6270'
UPDATE CWBTBSample SET StartDate = '1973-12-10 22:00:03.0000000' WHERE StartDate = '1973-12-10 22:00:00.0000000' AND pkSample = '20_0240_197312102200_SpencerBeachPark_0399Samples_010Alerts_YJun121973ToJul262017_CWB1225_NaN_Alert_Turb6260pHyd6390OxyD6270 '
select pkSample from CWBTBSample where StartDate = '1993-11-22 19:08:00.0000000'
UPDATE CWBTBSample SET StartDate = '1993-11-22 19:08:01.0000000' WHERE StartDate = '1993-11-22 19:08:00.0000000' AND pkSample = '19_6396_199311221908_KailuaPierStationD_0926Samples_035Alerts_YJun131973ToNov22017_CWB1208_Not_Alert_Ecci6410Sali6350'
UPDATE CWBTBSample SET StartDate = '1993-11-22 19:08:02.0000000' WHERE StartDate = '1993-11-22 19:08:00.0000000' AND pkSample = '19_6397_199311221908_KailuaPierStationA_0289Samples_016Alerts_YJul241989ToJul272017_CWB1204_Not_Alert_Ecci6410Sali6350'
select pkSample from CWBTBSample where StartDate = '1995-10-24 18:10:00.0000000'
UPDATE CWBTBSample SET StartDate = '1995-10-24 18:10:01.0000000' WHERE StartDate = '1995-10-24 18:10:00.0000000' AND pkSample = '19_6394_199510241810_KailuaPierStationA1_1081Samples_018Alerts_YApr31990ToNov22017_CWB1205_Not_Alert_Ecci6410Clos6420Sali6350'
UPDATE CWBTBSample SET StartDate = '1995-10-24 18:10:02.0000000' WHERE StartDate = '1995-10-24 18:10:00.0000000' AND pkSample = '19_6397_199510241810_KailuaPierStationA_0289Samples_016Alerts_YJul241989ToJul272017_CWB1204_Not_Alert_Ecci6410Clos6420Sali6350'
select pkSample from CWBTBSample where StartDate = '2015-01-22 10:00:00.0000000'
UPDATE CWBTBSample SET StartDate = '2015-01-22 10:00:01.0000000' WHERE StartDate = '2015-01-22 10:00:00.0000000' AND pkSample = '19_5793_201501221000_KahaluuBeachPark_1066Samples_031Alerts_YApr271987ToNov22017_CWB1203_Not_Alert_Ecci6410Clos6420'
UPDATE CWBTBSample SET StartDate = '2015-01-22 10:00:02.0000000' WHERE StartDate = '2015-01-22 10:00:00.0000000' AND pkSample = '19_7158_201501221000_OTEC_NELHA_0174Samples_007Alerts_YOct231989ToAug292017_CWB1237_Not_Alert_Ecci6410Clos6420     '
select pkSample from CWBTBSample where StartDate = '2017-04-19 10:00:00.0000000'
UPDATE CWBTBSample SET StartDate = '2017-04-19 10:00:01.0000000' WHERE StartDate = '2017-04-19 10:00:00.0000000' AND pkSample = '19_5793_201704191000_KahaluuBeachPark_1066Samples_031Alerts_YApr271987ToNov22017_CWB1203_Not_Alert_Ecci6410Clos6420'
UPDATE CWBTBSample SET StartDate = '2017-04-19 10:00:02.0000000' WHERE StartDate = '2017-04-19 10:00:00.0000000' AND pkSample = '19_7158_201704191000_OTEC_NELHA_0174Samples_007Alerts_YOct231989ToAug292017_CWB1237_Not_Alert_Ecci6410Clos6420     '
select pkSample from CWBTBSample where StartDate = '1999-01-04 19:40:00.0000000'
UPDATE CWBTBSample SET StartDate = '1999-01-04 19:40:01.0000000' WHERE StartDate = '1999-01-04 19:40:00.0000000' AND pkSample = '19_6394_199901041940_KailuaPierStationA1_1081Samples_018Alerts_YApr31990ToNov22017_CWB1205_Not_Alert_Ecci6410Clos6420Sali6350Turb6260OxyD6270'
UPDATE CWBTBSample SET StartDate = '1999-01-04 19:40:02.0000000' WHERE StartDate = '1999-01-04 19:40:00.0000000' AND pkSample = '19_9142_199901041940_AnaehoomaluBay_0965Samples_012Alerts_YAug221995ToNov22017_CWB1236_Not_Alert_Ecci6410Clos6420Sali6350Turb6260OxyD6270'
select pkSample from CWBTBSample where StartDate = '2001-08-28 19:00:00.0000000'
UPDATE CWBTBSample SET StartDate = '2001-08-28 19:00:01.0000000' WHERE StartDate = '2001-08-28 19:00:00.0000000'  AND pkSample = '19_5793_200108281900_KahaluuBeachPark_1066Samples_031Alerts_YApr271987ToNov22017_CWB1203_Not_Alert_Ecci6410Clos6420Sali6350OxyD6270'
UPDATE CWBTBSample SET StartDate = '2001-08-28 19:00:02.0000000' WHERE StartDate = '2001-08-28 19:00:00.0000000' AND pkSample = '19_9142_200108281900_AnaehoomaluBay_0965Samples_012Alerts_YAug221995ToNov22017_CWB1236_Not_Alert_Ecci6410Clos6420Sali6350OxyD6270'
select pkSample from CWBTBSample where StartDate = '2014-03-04 22:00:00.0000000'
UPDATE CWBTBSample SET StartDate = '2014-03-04 22:00:01.0000000' WHERE StartDate = '2014-03-04 22:00:00.0000000' AND pkSample = '19_9142_201403042200_AnaehoomaluBay_0965Samples_012Alerts_YAug221995ToNov22017_CWB1236_Not_Alert_Ecci6410Clos6420'
--UPDATE CWBTBSample SET StartDate = '2014-03-04 22:00:02.0000000' WHERE StartDate = '2014-03-04 22:00:00.0000000' AND pkSample = ''
select pkSample from CWBTBSample where StartDate = '1994-04-18 19:50:00.000000' 
UPDATE CWBTBSample SET StartDate = '1994-04-18 19:50:01.000000' WHERE StartDate = '1994-04-18 19:50:00.000000' AND pkSample = '19_9142_201403042200_AnaehoomaluBay_0965Samples_012Alerts_YAug221995ToNov22017_CWB1236_Not_Alert_Ecci6410Clos6420'
UPDATE CWBTBSample SET StartDate = '1994-04-18 19:50:02.000000' WHERE StartDate = '1994-04-18 19:50:00.000000' AND pkSample = '19_9248_199404181950_KonaHiltonShoreLine_0121Samples_NaNAlertsYDec41990ToDec161998_CWB1214_Not_Alert_Ecci6410Sali6350'
select pkSample from CWBTBSample where StartDate = '2016-03-31 10:00:00.0000000'
UPDATE CWBTBSample SET StartDate = '2016-03-31 10:00:01.0000000' WHERE StartDate = '2016-03-31 10:00:00.0000000' AND pkSample = '19_7158_201603311000_OTEC_NELHA_0174Samples_007Alerts_YOct231989ToAug292017_CWB1237_Not_Alert_Ecci6410Clos6420'
UPDATE CWBTBSample SET StartDate = '2016-03-31 10:00:02.0000000' WHERE StartDate = '2016-03-31 10:00:00.0000000' AND pkSample = '19_9687_201603311000_PuakoMiddleofLot_1010Samples_017Alerts_YMar91987ToNov22017_CWB1222_Not_Alert_Ecci6410Clos6420'
select pkSample from CWBTBSample where StartDate = '1991-01-09 20:40:00.0000000'
UPDATE CWBTBSample SET StartDate = '1991-01-09 20:40:01.0000000' WHERE StartDate = '1991-01-09 20:40:00.0000000' AND pkSample = '19_9687_199101092040_PuakoMiddleofLot_1010Samples_017Alerts_YMar91987ToNov22017_CWB1222_Not_Alert_Ecci6410'
UPDATE CWBTBSample SET StartDate = '1991-01-09 20:40:02.0000000' WHERE StartDate = '1991-01-09 20:40:00.0000000' AND pkSample = '19_9724_199101092040_PuakoBeachLotsFarEnd_0114Samples_003Alerts_YMar91987ToDec71998_CWB1223_Not_Alert_Ecci6410'
select pkSample from CWBTBSample where StartDate = '1993-04-26 20:00:00.0000000'
UPDATE CWBTBSample SET StartDate = '1993-04-26 20:00:01.0000000' WHERE StartDate = '1993-04-26 20:00:00.0000000' AND pkSample = '19_9687_199304262000_PuakoMiddleofLot_1010Samples_017Alerts_YMar91987ToNov22017_CWB1222_Not_Alert_Ecci6410'
UPDATE CWBTBSample SET StartDate = '1993-04-26 20:00:02.0000000' WHERE StartDate = '1993-04-26 20:00:00.0000000' AND pkSample = '19_9724_199304262000_PuakoBeachLotsFarEnd_0114Samples_003Alerts_YMar91987ToDec71998_CWB1223_Not_Alert_Ecci6410'
UPDATE CWBTBSample SET StartDate = '1993-04-26 20:00:03.0000000' WHERE StartDate = '1993-04-26 20:00:00.0000000' AND pkSample = '20_0103_199304262000_MaunakeaOff4thGreen_0045Samples_NaNAlertsYApr101990ToOct21995_CWB1218_Not_Alert_Ecci6410'
select pkSample from CWBTBSample where StartDate = '1999-12-08 19:10:00.000000' 
UPDATE CWBTBSample SET StartDate = '1999-12-08 19:10:01.000000' WHERE StartDate = '1999-12-08 19:10:00.000000' AND pkSample = '19_9687_199912081910_PuakoMiddleofLot_1010Samples_017Alerts_YMar91987ToNov22017_CWB1222_Not_Alert_Ecci6410Clos6420Sali6350'
UPDATE CWBTBSample SET StartDate = '1999-12-08 19:10:02.000000' WHERE StartDate = '1999-12-08 19:10:00.000000' AND pkSample = '19_9741_199912081910_PuakoBoatRamp_0151Samples_003Alerts_YApr101990ToOct302012_CWB1221_Not_Alert_Ecci6410Clos6420Sali6350'
select pkSample from CWBTBSample where StartDate = '2000-03-28 19:10:00.0000000'
UPDATE CWBTBSample SET StartDate = '2000-03-28 19:10:01.0000000' WHERE StartDate = '2000-03-28 19:10:00.0000000' AND pkSample = '19_9142_200003281910_AnaehoomaluBay_0965Samples_012Alerts_YAug221995ToNov22017_CWB1236_Not_Alert_Ecci6410Clos6420Sali6350'
UPDATE CWBTBSample SET StartDate = '2000-03-28 19:10:02.0000000' WHERE StartDate = '2000-03-28 19:10:00.0000000' AND pkSample = '19_9741_200003281910_PuakoBoatRamp_0151Samples_003Alerts_YApr101990ToOct302012_CWB1221_Not_Alert_Ecci6410Clos6420Sali6350'
select pkSample from CWBTBSample where StartDate = '2000-03-28 19:55:00.000000' 
UPDATE CWBTBSample SET StartDate = '2000-03-28 19:55:01.000000' WHERE StartDate = '2000-03-28 19:55:00.000000' AND pkSample = '19_6394_200003281955_KailuaPierStationA1_1081Samples_018Alerts_YApr31990ToNov22017_CWB1205_Not_Alert_Ecci6410Clos6420Sali6350'
UPDATE CWBTBSample SET StartDate = '2000-03-28 19:55:02.000000' WHERE StartDate = '2000-03-28 19:55:00.000000' AND pkSample = '19_9741_200003281955_PuakoBoatRamp_0151Samples_003Alerts_YApr101990ToOct302012_CWB1221_Not_Alert_Ecci6410Clos6420Sali6350'
select pkSample from CWBTBSample where StartDate = '1992-01-13 20:45:00.0000000'
UPDATE CWBTBSample SET StartDate = '1992-01-13 20:45:01.0000000' WHERE StartDate = '1992-01-13 20:45:00.0000000' AND pkSample = '19_9687_199201132045_PuakoMiddleofLot_1010Samples_017Alerts_YMar91987ToNov22017_CWB1222_Not_Alert_Ecci6410Sali6350Turb6260pHyd6390OxyD6270'
UPDATE CWBTBSample SET StartDate = '1992-01-13 20:45:02.0000000' WHERE StartDate = '1992-01-13 20:45:00.0000000' AND pkSample = '19_9910_199201132045_HapunaBeach_0480Samples_007Alerts_YApr271987ToNov22017_CWB1200_Not_Alert_Ecci6410Sali6350Turb6260pHyd6390OxyD6270'
select pkSample from CWBTBSample where StartDate = '1992-02-11 00:00:00.0000000'
UPDATE CWBTBSample SET StartDate = '1992-02-11 00:00:01.0000000' WHERE StartDate = '1992-02-11 00:00:00.0000000' AND pkSample = '19_6394_199202110000_KailuaPierStationA1_1081Samples_018Alerts_YApr31990ToNov22017_CWB1205_Not_Alert_NaN_Alert_Ecci6410Sali6350Turb6260pHyd6390OxyD6270'
UPDATE CWBTBSample SET StartDate = '1992-02-11 00:00:02.0000000' WHERE StartDate = '1992-02-11 00:00:00.0000000' AND pkSample = '19_9910_199202110000_HapunaBeach_0480Samples_007Alerts_YApr271987ToNov22017_CWB1200_Not_Alert_NaN_Alert_Ecci6410Sali6350Turb6260pHyd6390OxyD6270'
select pkSample from CWBTBSample where StartDate = '1995-10-24 21:40:00.0000000'
UPDATE CWBTBSample SET StartDate = '1995-10-24 21:40:01.0000000' WHERE StartDate = '1995-10-24 21:40:00.0000000' AND pkSample = '19_1359_199510242140_PunaluuBeachPark_0141Samples_001Alerts_YJun131973ToAug92012_CWB1224_Not_Alert_Ecci6410Sali6350'
UPDATE CWBTBSample SET StartDate = '1995-10-24 21:40:02.0000000' WHERE StartDate = '1995-10-24 21:40:00.0000000' AND pkSample = '19_9910_199510242140_HapunaBeach_0480Samples_007Alerts_YApr271987ToNov22017_CWB1200_Not_Alert_Ecci6410Sali6350'
select pkSample from CWBTBSample where StartDate = '2002-08-26 20:15:00.0000000'
UPDATE CWBTBSample SET StartDate = '2002-08-26 20:15:01.0000000' WHERE StartDate = '2002-08-26 20:15:00.0000000' AND pkSample = '19_5946_200208262015_MagicSands_0469Samples_004Alerts_YJun131973ToOct182017_CWB1215_Not_Alert_Ecci6410Clos6420Sali6350Turb6260OxyD6270'
UPDATE CWBTBSample SET StartDate = '2002-08-26 20:15:02.0000000' WHERE StartDate = '2002-08-26 20:15:00.0000000' AND pkSample = '19_9910_200208262015_HapunaBeach_0480Samples_007Alerts_YApr271987ToNov22017_CWB1200_Not_Alert_Ecci6410Clos6420Sali6350Turb6260OxyD6270'
select pkSample from CWBTBSample where StartDate = '1999-12-08 18:45:00.000000' 
UPDATE CWBTBSample SET StartDate = '1999-12-08 18:45:01.000000' WHERE StartDate = '1999-12-08 18:45:00.000000' AND pkSample = '19_9741_199912081845_PuakoBoatRamp_0151Samples_003Alerts_YApr101990ToOct302012_CWB1221_Not_Alert_Ecci6410Clos6420Sali6350'
UPDATE CWBTBSample SET StartDate = '1999-12-08 18:45:02.000000' WHERE StartDate = '1999-12-08 18:45:00.000000' AND pkSample = '20_0061_199912081845_MaunakeaHotelBeach_0083Samples_NaNAlertsYApr101990ToDec81999_CWB1219_Not_Alert_Ecci6410Clos6420Sali6350'
select pkSample from CWBTBSample where StartDate = '1993-10-12 19:15:00.0000000'
UPDATE CWBTBSample SET StartDate = '1993-10-12 19:15:01.0000000' WHERE StartDate = '1993-10-12 19:15:00.0000000' AND pkSample = '19_9910_199310121915_HapunaBeach_0480Samples_007Alerts_YApr271987ToNov22017_CWB1200_Not_Alert_Ecci6410Sali6350'
UPDATE CWBTBSample SET StartDate = '1993-10-12 19:15:02.0000000' WHERE StartDate = '1993-10-12 19:15:00.0000000' AND pkSample = '20_0103_199310121915_MaunakeaOff4thGreen_0045Samples_NaNAlertsYApr101990ToOct21995_CWB1218_Not_Alert_Ecci6410Sali6350'
select pkSample from CWBTBSample where StartDate = '1991-11-12 20:07:00.0000000'
UPDATE CWBTBSample SET StartDate = '1991-11-12 20:07:01.0000000' WHERE StartDate = '1991-11-12 20:07:00.0000000' AND pkSample = '20_0061_199111122007_MaunakeaHotelBeach_0083Samples_NaNAlertsYApr101990ToDec81999_CWB1219_Not_Alert_Ecci6410'
UPDATE CWBTBSample SET StartDate = '1991-11-12 20:07:02.0000000' WHERE StartDate = '1991-11-12 20:07:00.0000000' AND pkSample = '20_0147_199111122007_MaunakeaBchOutfall_0044Samples_001Alerts_YJun121973ToAug81994_CWB1217_Not_Alert_Ecci6410'
select pkSample from CWBTBSample where StartDate = '1974-04-15 22:00:00.0000000'
UPDATE CWBTBSample SET StartDate = '1974-04-15 22:00:01.0000000' WHERE StartDate = '1974-04-15 22:00:00.0000000' AND pkSample = '19_1359_197404152200_PunaluuBeachPark_0141Samples_001Alerts_YJun131973ToAug92012_CWB1224_NaN_Alert_Turb6260'
UPDATE CWBTBSample SET StartDate = '1974-04-15 22:00:02.0000000' WHERE StartDate = '1974-04-15 22:00:00.0000000' AND pkSample = '20_0240_197404152200_SpencerBeachPark_0399Samples_010Alerts_YJun121973ToJul262017_CWB1225_NaN_Alert_Turb6260'
select pkSample from CWBTBSample where StartDate = '2000-03-28 18:45:00.0000000'
UPDATE CWBTBSample SET StartDate = '2000-03-28 18:45:01.0000000' WHERE StartDate = '2000-03-28 18:45:00.0000000' AND pkSample = '19_9741_200003281845_PuakoBoatRamp_0151Samples_003Alerts_YApr101990ToOct302012_CWB1221_Not_Alert_Ecci6410Clos6420Sali6350'
UPDATE CWBTBSample SET StartDate = '2000-03-28 18:45:02.0000000' WHERE StartDate = '2000-03-28 18:45:00.0000000' AND pkSample = '20_0240_200003281845_SpencerBeachPark_0399Samples_010Alerts_YJun121973ToJul262017_CWB1225_Not_Alert_Ecci6410Clos6420Sali6350'
select pkSample from CWBTBSample where StartDate = '2002-04-29 19:50:00.0000000'
UPDATE CWBTBSample SET StartDate = '2002-04-29 19:50:01.0000000' WHERE StartDate = '2002-04-29 19:50:00.0000000' AND pkSample = '19_6064_200204291950_BanyansSurfingArea_0225Samples_017Alerts_YJul241989ToAug162017_CWB1235_Not_Alert_Ecci6410Clos6420Sali6350Turb6260OxyD6270'
UPDATE CWBTBSample SET StartDate = '2002-04-29 19:50:02.0000000' WHERE StartDate = '2002-04-29 19:50:00.0000000' AND pkSample = '20_0240_200204291950_SpencerBeachPark_0399Samples_010Alerts_YJun121973ToJul262017_CWB1225_Not_Alert_Ecci6410Clos6420Sali6350Turb6260OxyD6270'
select pkSample from CWBTBSample where StartDate = '2002-08-26 20:00:00.0000000'
UPDATE CWBTBSample SET StartDate = '2002-08-26 20:00:01.0000000' WHERE StartDate = '2002-08-26 20:00:00.0000000' AND pkSample = '19_5793_200208262000_KahaluuBeachPark_1066Samples_031Alerts_YApr271987ToNov22017_CWB1203_Not_Alert_Ecci6410Clos6420Sali6350Turb6260OxyD6270'
UPDATE CWBTBSample SET StartDate = '2002-08-26 20:00:02.0000000' WHERE StartDate = '2002-08-26 20:00:00.0000000' AND pkSample = '20_0240_200208262000_SpencerBeachPark_0399Samples_010Alerts_YJun121973ToJul262017_CWB1225_Not_Alert_Ecci6410Clos6420Sali6350Turb6260OxyD6270'
select pkSample from CWBTBSample where StartDate = '1996-03-13 19:20:00.0000000'
UPDATE CWBTBSample SET StartDate = '1996-03-13 19:20:01.0000000' WHERE StartDate = '1996-03-13 19:20:00.0000000' AND pkSample = '20_0061_199603131920_MaunakeaHotelBeach_0083Samples_NaNAlertsYApr101990ToDec81999_CWB1219_Not_Alert_Ecci6410Sali6350'
UPDATE CWBTBSample SET StartDate = '1996-03-13 19:20:02.0000000' WHERE StartDate = '1996-03-13 19:20:00.0000000' AND pkSample = '20_0315_199603131920_KawaihaeLSTLanding_0182Samples_007Alerts_YMay191995ToApr262017_CWB1238_Not_Alert_Ecci6410Sali6350'
select pkSample from CWBTBSample where StartDate = '1996-08-26 19:45:00.0000000'
UPDATE CWBTBSample SET StartDate = '1996-08-26 19:45:01.0000000' WHERE StartDate = '1996-08-26 19:45:00.0000000' AND pkSample = '19_9142_199608261945_AnaehoomaluBay_0965Samples_012Alerts_YAug221995ToNov22017_CWB1236_Not_Alert_Ecci6410Clos6420Sali6350'
UPDATE CWBTBSample SET StartDate = '1996-08-26 19:45:02.0000000' WHERE StartDate = '1996-08-26 19:45:00.0000000' AND pkSample = '19_9248_199608261945_KonaHiltonShoreLine_0121Samples_NaNAlertsYDec41990ToDec161998_CWB1214_Not_Alert_Ecci6410Clos6420Sali6350'
--
-- start and end the same at this site
UPDATE CWBTBSample SET EndDate = StartDate


/*
select count(*) 
FROM [WHWQ4].[dbo].[CWBTBSample]
where year(StartDate) = '2010'
 and pkSample like '%YES_ALERT%' 
 */
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- now work on TBResult
--   DROP TABLE CWBTBResult
CREATE TABLE CWBTBResult (
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


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- delete from CWBTBResult
-- 1/8
 INSERT INTO CWBTBResult
SELECT 
samp.pkSample,
'Ecci6410 - Enterococci',
samp.fkIDLoc,
samp.fkUnqID,
raw.Ecci6410,  -- Result
NULL,
6410,
6451, --dmRAMeth
6299,
6399,
6410,
NULL, -- Grade
'CWB#'+raw.CWBLocationCode + ' AlertCount=' + str(raw.AlertCount) + ' RecordCount=' + str(raw.RecordCount), -- Comment
NULL, NULL, NULL, NULL, NULL, NULL,  
raw.RawUniq, newid(), 
samp.SampUniq  -- SampUniq 
FROM CWBRaw raw, CWBTBSample samp
WHERE raw.RawUniq = samp.RawUniq and raw.Ecci6410 IS NOT NULL
ORDER BY raw.PacIOOSTimeUTC, raw.CWBLocationCode
-- 9810
--------------------------------------------------------------------------------
-- 2 
INSERT INTO CWBTBResult
SELECT 
samp.pkSample,
'Clos6420 - Clostridium perfringens',
samp.fkIDLoc,
samp.fkUnqID,
raw.Clos6420,  -- Result
NULL,
6420,
6451, --dmRAMeth
6299,
6399,
6420,
NULL, -- Grade
'CWB#'+raw.CWBLocationCode + ' AlertCount=' + str(raw.AlertCount) + ' RecordCount=' + str(raw.RecordCount), -- Comment
NULL, NULL, NULL, NULL, NULL, NULL,  
raw.RawUniq, newid(), 
samp.SampUniq  -- SampUniq 
FROM CWBRaw raw, CWBTBSample samp
WHERE raw.RawUniq = samp.RawUniq and raw.Clos6420 IS NOT NULL
ORDER BY raw.PacIOOSTimeUTC, raw.CWBLocationCode
-- 5647
--------------------------------------------------------------------------------
-- 3
INSERT INTO CWBTBResult
SELECT 
samp.pkSample,
'Temp6280 - Temperature C',
samp.fkIDLoc,
samp.fkUnqID,
raw.Temp6280,  -- Result
NULL,
6280,
6451, --dmRAMethod
6280,
6399,
6499,
NULL, -- Grade
'CWB#'+raw.CWBLocationCode + ' AlertCount=' + str(raw.AlertCount) + ' RecordCount=' + str(raw.RecordCount), -- Comment
NULL, NULL, NULL, NULL, NULL, NULL,  
raw.RawUniq, newid(), 
samp.SampUniq  -- SampUniq 
FROM CWBRaw raw, CWBTBSample samp
WHERE raw.RawUniq = samp.RawUniq and raw.Temp6280 IS NOT NULL
ORDER BY raw.PacIOOSTimeUTC, raw.CWBLocationCode
-- 5961
--------------------------------------------------------------------------------
-- 4
INSERT INTO CWBTBResult
SELECT 
samp.pkSample,
'Sali6350 - Salinity',
samp.fkIDLoc,
samp.fkUnqID,
raw.Sali6350,
NULL,
6350,
6451,--dmRAMeth
6299,
6350,
6499,
NULL, -- Grade
'CWB#'+raw.CWBLocationCode + ' AlertCount=' + str(raw.AlertCount) + ' RecordCount=' + str(raw.RecordCount), -- Comment
NULL, NULL, NULL, NULL, NULL, NULL,  
raw.RawUniq, newid(), 
samp.SampUniq  -- SampUniq 
FROM CWBRaw raw, CWBTBSample samp
WHERE raw.RawUniq = samp.RawUniq and raw.Sali6350 IS NOT NULL
ORDER BY raw.PacIOOSTimeUTC, raw.CWBLocationCode
-- 7707
--------------------------------------------------------------------------------
-- 5
INSERT INTO CWBTBResult
SELECT 
samp.pkSample,
'Turb6260 - Turbidity',
samp.fkIDLoc,
samp.fkUnqID,
raw.Turb6260,
NULL,
6260,
6451,--dmRAMeth
6260,
6399,
6499,
NULL, -- Grade
'CWB#'+raw.CWBLocationCode + ' AlertCount=' + str(raw.AlertCount) + ' RecordCount=' + str(raw.RecordCount), -- Comment
NULL, NULL, NULL, NULL, NULL, NULL,  
raw.RawUniq, newid(), 
samp.SampUniq  -- SampUniq 
FROM CWBRaw raw, CWBTBSample samp
WHERE raw.RawUniq = samp.RawUniq and raw.Turb6260 IS NOT NULL
ORDER BY raw.PacIOOSTimeUTC, raw.CWBLocationCode
-- 5394
--------------------------------------------------------------------------------
-- 6
INSERT INTO CWBTBResult
SELECT 
samp.pkSample,
'pHyd6390 - pH',
samp.fkIDLoc,
samp.fkUnqID,
raw.pHyd6390,
NULL,
6390,
6451,--dmRAMeth
6299,
6390,
6499,
NULL, -- Grade
'CWB#'+raw.CWBLocationCode + ' AlertCount=' + str(raw.AlertCount) + ' RecordCount=' + str(raw.RecordCount), -- Comment
NULL, NULL, NULL, NULL, NULL, NULL,  
raw.RawUniq, newid(), 
samp.SampUniq  -- SampUniq 
FROM CWBRaw raw, CWBTBSample samp
WHERE raw.RawUniq = samp.RawUniq and raw.pHyd6390 IS NOT NULL
ORDER BY raw.PacIOOSTimeUTC, raw.CWBLocationCode
-- 5311
select sum(pHyd6390) FROM CWBRaw raw
WHERE raw.pHyd6390 IS NOT NULL
select sum(Result) FROM CWBTBResult
WHERE dmRall = 6390
--43436.94878000  both
--------------------------------------------------------------------------------
-- 7
INSERT INTO CWBTBResult
SELECT 
samp.pkSample,
'O2mc6364 - Mass_Concentration_of_Oxygen_CWB',
samp.fkIDLoc,
samp.fkUnqID,
raw.O2mc6364,
NULL,
6364,
6451,--dmRAMeth
6299,
6364,
6499,
NULL, -- Grade
'CWB#'+raw.CWBLocationCode + ' AlertCount=' + str(raw.AlertCount) + ' RecordCount=' + str(raw.RecordCount), -- Comment
NULL, NULL, NULL, NULL, NULL, NULL,  
raw.RawUniq, newid(), 
samp.SampUniq  -- SampUniq 
FROM CWBRaw raw, CWBTBSample samp
WHERE raw.RawUniq = samp.RawUniq and raw.O2mc6364 IS NOT NULL
ORDER BY raw.PacIOOSTimeUTC, raw.CWBLocationCode
-- 5715
--------------------------------------------------------------------------------
-- 8
INSERT INTO CWBTBResult
SELECT 
samp.pkSample,
'O2fs6365 - Fractional_Saturation_of_Oxygen_CWB',
samp.fkIDLoc,
samp.fkUnqID,
raw.O2fs6365,
NULL,
6365,
6451,--dmRAMeth
6299,
6365,
6499,
NULL, -- Grade
'CWB#'+raw.CWBLocationCode + ' AlertCount=' + str(raw.AlertCount) + ' RecordCount=' + str(raw.RecordCount), -- Comment
NULL, NULL, NULL, NULL, NULL, NULL,  
raw.RawUniq, newid(), 
samp.SampUniq  -- SampUniq 
FROM CWBRaw raw, CWBTBSample samp
WHERE raw.RawUniq = samp.RawUniq and raw.O2fs6365 IS NOT NULL
ORDER BY raw.PacIOOSTimeUTC, raw.CWBLocationCode
-- 4469

SELECT COUNT(*) FROM CWBTBResult
-- 50014 rows

-------------------------------------

-- thesis map displays

SELECT '1983-2017 EPA&BEACHAct' as 'Clean Water Branch HDOH', Count(*) as 'TBResult #rows' FROM CWBTBResult
SELECT Label, Count(dmRAll) as '#rows', round(exp(avg(log(Result))),3) as '~gmean',round(stdev(Result),2) as 'stdev',cast(min(Result) as decimal (10,2)) as 'min',cast(max(Result) as decimal (10,2)) as 'max' FROM CWBTBResult 
WHERE Result<>0 GROUP by Label, dmRAll ORDER by Label

select YEAR(StartDate) as 'Year', count(distinct(cast(StartDate as date))) as 'Number of Alerts'
FROM CWBTBSample WHERE AlertTrue = 1 GROUP by YEAR(StartDate) ORDER by YEAR(StartDate) DESC
 





SELECT * FROM CWBFCStation
SELECT * FROM CWBTBResult
SELECT * FROM CWBRaw
SELECT * FROM CWBTBSample

SELECT Count(*) as 'TBResult Count' FROM CWBTBResult

SELECT Label, Count(dmRAll) as 'TBResult rows' FROM CWBTBResult
--WHERE fkSample LIKE '%YES_ALERT%'
--WHERE fkSample LIKE '%Not_Alert%'
--WHERE fkSample NOT LIKE '%Nan_Alert%'
GROUP by Label, dmRAll ORDER by 2 DESC
-----------------------

select
  SUM(Ecci6410) +
  SUM(Clos6420) +
  SUM(Temp6280) +
  SUM(Sali6350) +
  SUM(Turb6260) +
  SUM(pHyd6390) +
  SUM(O2mc6364) +
  SUM(O2fs6365)
   from CWBRaw
-- 1105163.94058000

select SUM(RESULT) FROM CWBTBResult WHERE dmRall in (
6410,
6420,
6280,
6350,
6260,
6390,
6364,
6365
)
-- 1105163.94058000
