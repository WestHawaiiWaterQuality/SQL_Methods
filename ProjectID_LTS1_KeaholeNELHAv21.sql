-- create script for NELHA 
-- last update 04/03/2018

USE WHWQ4
-

-------------------
/*
There are six files, one for each raw NELHA file, they insert into NELHARaw (defined below).
So that must be done before this can run, NELHARaw is assumed already populated at this point.
FileNames: NELHAImport Handling Transect1 01-1rawdata.sql,NELHAImport Handling Transect2 02-2rawdata.sql,NELHAImport Handling Transect3 03-3rawdata.sql
NELHAImport Handling Transect4 04-4rawdata.sql,NELHAImport Handling Transect5 05-5rawdata.sql,NELHAImport Handling Transect6 06-6rawdata.sql

*/
-------------------
--  <<<<DROP TABLE NELHARaw>>>> this is populated transect by transect with separate files
-- to populate, should have 2940 rows
-- do not drop or you have to walk through all six files to repopulate
>>>CREATE TABLE NELHARaw (<>>
   [EsriDateTime] [datetime2](7)   NOT NULL, -- pk
   [AMorPM]       [nvarchar](3)    NOT NULL,

   [Transect]     [int]            NOT NULL,
   [mShore]       [int]            NOT NULL,
   [NewOrOld]     [nvarchar](3)    NOT NULL,
   							   
   [SampTimeHHMM] [nvarchar](255)  NOT NULL,
   [LatituteN]    [nvarchar](255)      NULL,
   [LongitudeN]   [nvarchar](255)      NULL,
   [SiteId]       [nvarchar](255)  NOT NULL,
   -- analytes
   [Phos6391] [numeric](38,8)          NULL,--P043-
   [NaNi6230] [numeric](38,8)          NULL,
   [AmmN6220] [numeric](38,8)          NULL,
   [Sili6360] [numeric](38,8)          NULL,
   [TDPh6386] [numeric](38,8)          NULL,--
   [TDNi6210] [numeric](38,8)          NULL,
   [TPho6240] [numeric](38,8)          NULL,
   [TtOC6392] [numeric](38,8)          NULL,
   [Turb6260] [numeric](38,8)          NULL,
   [Sali6350] [numeric](38,8)          NULL,
   [Temp6280] [numeric](38,8)          NULL,
   [pHyd6390] [numeric](38,8)          NULL,
   [OxyD6270] [numeric](38,8)          NULL,
   [ChlA6250] [numeric](38,8)          NULL,
   [Coli6420] [nvarchar](255)          NULL,
   [Ecci6410] [nvarchar](255)          NULL,
									    
-- My Fields						    
-- location fields to populate		    
   POINT_Y         [numeric](38,8)     NULL,
   POINT_X         [numeric](38,8)     NULL,
   MyLatLong       [nvarchar](255)     NULL,
   MyLatitude      [nvarchar](255)     NULL,
   MyLabel         [nvarchar](255)     NULL,
   MyLocationLabel [nvarchar](255)     NULL,
   MyCoreName      [nvarchar](255)     NULL,
   -- 								  
   MyStartDate     [datetime2](7)      NULL,
   MyEndDate       [datetime2](7)      NULL,

-- for pkStation, pkSample names
   MyAnalyteList   [nvarchar](255)     NULL,
   MyTransectName  [nvarchar](255)     NULL,
   MyDateRange     [nvarchar](255)     NULL,
   MyQuarterCount  [nvarchar](255)     NULL,
 
 -- tracking
   RawUniq      [uniqueidentifier] NOT NULL,
   GeoUniq      [uniqueidentifier]     NULL,
   RawIdentityI [int]              NOT NULL,
   RawIdentityA [int]              NOT NULL,

PRIMARY KEY (EsriDateTime)
)


select * from NELHARaw order by EsriDateTime
select transect,mShore,EsriDateTime from NELHARaw order by EsriDateTime

select distinct(Transect)
FROM NELHARaw order by Transect
-- 6 transects
/*
Transect
1
2
3
4
5
6
*/

-------------------------
select distinct(mShore), NewOrOld
FROM NELHARaw 
group by mShore,NewOrOld
order by mShore,NewOrOld
-- 10 distances from shore Old=(8,23,38,53,69), New=(1,10,50,100,500)
/*
1	New
8	Old
10	New
23	Old
38	Old
50	New
53	Old
69	Old
100	New
500	New
*/

select distinct(SiteID)
FROM NELHARaw order by SiteId
-- 60 same as pkStation for now
select distinct(Transect),mShore
FROM NELHARaw 
GROUP by Transect, mShore
order by Transect, mShore
-- 60

select count(*),Transect
from NELHARaw
GROUP by Transect
ORDER BY Transect
-- all 490, very symmetrical
/*
Count	Transect
490	1
490	2
490	3
490	4
490	5
490	6
*/
select count(*),mShore
from NELHARaw
GROUP by mShore
ORDER BY mShore
/*
(No column name)	mShore
252	1
336	8
252	10
336	23
336	38
252	50
336	53
336	69
252	100
252	500
*/


-- create our own identity attribute
Declare @myRow varchar(255), @MyRawUniq varchar(255)
Declare @cursorInsert CURSOR
set @cursorInsert = CURSOR FOR
Select ROW_NUMBER() OVER(ORDER BY Esridatetime),RawUniq from NELHARaw
OPEN @cursorInsert
FETCH NEXT FROM @cursorInsert into @myRow, @MyRawUniq
WHILE @@FETCH_STATUS = 0
BEGIN
UPDATE NELHARaw set RawIdentityA = @myRow where RawUniq = @MyRawUniq
FETCH NEXT FROM @cursorInsert INTO @myRow, @MyRawUniq
END
CLOSE @cursorInsert
DEALLOCATE @cursorInsert

select * from NELHARaw order by RawIdentityA
select * from NELHARaw order by EsriDateTime


---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
-- the two biological fields need normalization, these analytes are only taken at the stations
-- close to shore
select distinct(Ecci6410)
from NELHARaw
/*
2
3
NULL
4
<1
no sample
1
9
*/
select count(distinct(Ecci6410))
from NELHARaw
-- 7
select COUNT(*)
from NELHARaw WHERE Ecci6410 IS NULL
-- 2615
-- less than 1 means below the detection limits
UPDATE NELHARaw SET Ecci6410='0' WHERE Ecci6410 = '<1'
-- 279 rows
-- 'no sample' is just null
UPDATE NELHARaw SET Ecci6410=NULL WHERE Ecci6410 = 'no sample'
-- 2 rows
UPDATE NELHARaw SET Ecci6410=NULL WHERE Ecci6410 = 'NULL'
-- 0 rows ok

-- same for coliform
select distinct(Coli6420)
from NELHARaw
/*
2
3
6
NULL
29
<1
no sample
1
*/
select count(distinct(Coli6420))
from NELHARaw
-- 7
select COUNT(*)
from NELHARaw WHERE Coli6420 IS NULL
-- 2615 same as Ecci!
UPDATE NELHARaw SET Coli6420='0' WHERE Coli6420 = '<1'
-- 294 rows
UPDATE NELHARaw SET Coli6420=NULL WHERE Coli6420 = 'no sample'
-- 2 rows
UPDATE NELHARaw SET Coli6420=NULL WHERE Coli6420 = 'NULL'
-- 0 rows


---------------------------------------------------------
---------------------------------------------------------
---------------------------------------------------------
---------------------------------------------------------
---------------------------------------------------------
---------------------------------------------------------
-- My geocoding effort

--  DROP table NELHAMyGeocodedLocations_temp
CREATE TABLE NELHAMyGeocodedLocations_temp (
  Transect    [int]             NOT NULL,--pk+
  mShore      [int]             NOT NULL,--pk
  mShoreT     [nvarchar](4)         NULL,
  
  POINT_Y     [numeric](38,8)   NOT NULL,
  POINT_X     [numeric](38,8)   NOT NULL,
  
  -- other fields needed for names related to location
  MyLatLong   [nvarchar](255)        NULL,
  MyLatitude  [nvarchar](255)        NULL,
  
  GeoUniq     [uniqueidentifier] NOT NULL,
  NewOrOld    [nvarchar](3)          NULL,
  StartDate   [datetime2](7)         NULL,
  EndDate     [datetime2](7)         NULL,

PRIMARY KEY (Transect, mShore)
) 

select * from NELHAMyGeocodedLocations_temp order by Transect,mShore
/* */
--  delete from NELHAMyGeocodedLocations_temp				    
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (1, 8  , '008m','19.73209' ,'-156.05717', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (1, 1  , '001m','19.73203' ,'-156.05714', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (1, 23 , '023m','19.73220' ,'-156.05723', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (1, 10 , '010m','19.73212' ,'-156.05719', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (1, 38 , '038m','19.73233' ,'-156.05730', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (1, 50 , '050m','19.73245' ,'-156.05736', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (1, 53 , '053m','19.73245' ,'-156.05736', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (1, 100, '100m','19.73284' ,'-156.05757', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (1, 69 , '069m','19.73258' ,'-156.05743', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (1, 500, '500m','19.73606' ,'-156.05928', NULL,NULL,newid(),NULL,NULL,NULL)
-- t2
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (2, 8  , '008m','19.73129' ,'-156.05982', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (2, 1  , '001m','19.73122' ,'-156.05976', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (2, 23 , '023m','19.73139' ,'-156.05991', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (2, 10 , '010m','19.73128' ,'-156.05983', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (2, 38 , '038m','19.73148' ,'-156.06001', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (2, 50 , '050m','19.73154' ,'-156.06008', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (2, 53 , '053m','19.73158' ,'-156.06011', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (2, 100, '100m','19.73188' ,'-156.06040', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (2, 69 , '069m','19.73169' ,'-156.06021', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (2, 500, '500m','19.73453' ,'-156.06300', NULL,NULL,newid(),NULL,NULL,NULL)
-- t3													  '		 								  
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (3, 8  , '008m','19.72757' ,'-156.06192', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (3, 1  , '001m','19.72758' ,'-156.06185', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (3, 23 , '023m','19.72755' ,'-156.06206', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (3, 10 , '010m','19.72757' ,'-156.06194', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (3, 38 , '038m','19.72754' ,'-156.06220', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (3, 50 , '050m','19.72751' ,'-156.06233', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (3, 53 , '053m','19.72752' ,'-156.06234', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (3, 100, '100m','19.72747' ,'-156.06279', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (3, 69 , '069m','19.72751' ,'-156.06249', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (3, 500, '500m','19.72701' ,'-156.06646', NULL,NULL,newid(),NULL,NULL,NULL)
-- t4													  ' 										
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (4, 8  , '008m','19.72637' ,'-156.06081', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (4, 1  , '001m','19.72642' ,'-156.06076', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (4, 23 , '023m','19.72627' ,'-156.06091', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (4, 10 , '010m','19.72635' ,'-156.06082', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (4, 38 , '038m','19.72618' ,'-156.06101', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (4, 50 , '050m','19.72610' ,'-156.06109', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (4, 53 , '053m','19.72608' ,'-156.06112', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (4, 100, '100m','19.72579' ,'-156.06144', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (4, 69 , '069m','19.72598' ,'-156.06122', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (4, 500, '500m','19.72329' ,'-156.06422', NULL,NULL,newid(),NULL,NULL,NULL)
-- t5													  ' 								  	   
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (5, 8  , '008m','19.72178' ,'-156.05755', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (5, 1  , '001m','19.72183' ,'-156.05750', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (5, 23 , '023m','19.72178' ,'-156.05755', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (5, 10 , '010m','19.72176' ,'-156.05757', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (5, 38 , '038m','19.72178' ,'-156.05755', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (5, 50 , '050m','19.72156' ,'-156.05789', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (5, 53 , '053m','19.72178' ,'-156.05755', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (5, 100, '100m','19.72126' ,'-156.05826', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (5, 69 , '069m','19.72178' ,'-156.05755', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (5, 500, '500m','19.71905' ,'-156.06124', NULL,NULL,newid(),NULL,NULL,NULL)
-- t6
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (6, 8  , '008m','19.72178' ,'-156.05755', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (6, 1  , '001m','19.71223' ,'-156.04981', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (6, 23 , '023m','19.72178' ,'-156.05755', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (6, 10 , '010m','19.71223' ,'-156.04981', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (6, 38 , '038m','19.72178' ,'-156.05755', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (6, 50 , '050m','19.71216' ,'-156.05018', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (6, 53 , '053m','19.72178' ,'-156.05755', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (6, 100, '100m','19.71207' ,'-156.05066', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (6, 69 , '069m','19.72178' ,'-156.05755', NULL,NULL,newid(),NULL,NULL,NULL)
INSERT INTO NELHAMyGeocodedLocations_temp VALUES (6, 500, '500m','19.71140' ,'-156.05440', NULL,NULL,newid(),NULL,NULL,NULL)

-- needs dates for time spans in FCStation
select min(EsriDateTime),max(EsriDateTime) from NELHARaw
--where NewOrOld = 'New'
where NewOrOld = 'Old'

-- get dates for new series
UPDATE NELHAMyGeocodedLocations_temp SET 
NewOrOld = 'New',
StartDate='2007-09-26 08:32:01', EndDate='2017-11-30 10:39:01'
WHERE mShore IN (1,10,50,100,500)
-- 30 half, good

-- get dates for old series
UPDATE NELHAMyGeocodedLocations_temp SET
NewOrOld = 'Old',
StartDate='1993-07-26 09:26:01', EndDate='2007-04-16 11:30:01'
WHERE mShore IN (8,23,38,53,69)
-- 30 other half, good

select count(*) FROM NELHAMyGeocodedLocations_temp
-- 60
select * from NELHAMyGeocodedLocations_temp

--
select * from NELHARaw

-- create location names
UPDATE NELHAMyGeocodedLocations_temp SET
MyLatLong  = CAST(POINT_Y as nvarchar) + ', ' + CAST(POINT_X as nvarchar),
MyLatitude = CAST( REPLACE( str( CAST(POINT_Y AS DECIMAL (7,4)),7,4),'.','_') AS varchar)
-- 60

select * from NELHAMyGeocodedLocations_temp

-- do this join manually
Declare @myRow varchar(255), @MyGeoUniq varchar(255), @MyPOINT_Y numeric(38,8), @MyPOINT_X numeric(38,8)
Declare @MyTransect int, @MymShore int, @DMyLatLong varchar(255), @DMyLatitude varchar(255)
Declare @cursorInsert CURSOR
set @cursorInsert = CURSOR FOR
 Select ROW_NUMBER() OVER (ORDER BY Transect,mShore),
        GeoUniq,
		POINT_Y,POINT_X,
		Transect,mShore,
		MyLatLong,MyLatitude 
		FROM NELHAMyGeocodedLocations_temp
OPEN @cursorInsert
FETCH NEXT FROM @cursorInsert into @myRow, @MyGeoUniq, @MyPOINT_Y, @MyPOINT_X,@MyTransect,@MymShore,@DMyLatLong,@DMyLatitude
WHILE @@FETCH_STATUS = 0
BEGIN
 UPDATE NELHARaw SET GeoUniq=@MyGeoUniq, 
                     POINT_Y=@MyPOINT_Y, POINT_X=@MyPOINT_X, 
					 MyLatLong=@DMyLatLong, MyLatitude=@DMyLatitude
 WHERE 
   Transect = @MyTransect AND mShore = @MymShore
  select @myRow, @MyGeoUniq,@MyPOINT_Y,@MyPOINT_X,@MyTransect,@MymShore
FETCH NEXT FROM @cursorInsert INTO @myRow, @MyGeoUniq, @MyPOINT_Y, @MyPOINT_X,@MyTransect,@MymShore,@DMyLatLong,@DMyLatitude
END
CLOSE @cursorInsert
DEALLOCATE @cursorInsert
--

select Transect,mShore,POINT_Y,POINT_X,MyLatLong,MyLatitude,GeoUniq from NELHAMyGeocodedLocations_temp ORDER BY Transect,mShore
--


-- file in name fields for later usage constructing the pkStation and pkSample
-- transect name/number
UPDATE NELHARaw SET 
MyTransectName = 'NELHATransect' + LTRIM(str(Transect))
FROM NELHARaw raw
-- 2940
-- location/distance from shore
UPDATE NELHARaw SET 
MyLocationLabel = RIGHT('000' + LTRIM(str(mShore)), 3) + 'm'
FROM NELHARaw raw
-- 2940

-- set quarters by new/old setting
-- old data 93-2007 was for 56 quarters, new 2007-2017 42 quarters
UPDATE NELHARaw SET MyQuarterCount = '56Quarters' FROM NELHARaw WHERE NewOrOld = 'Old'
-- 1680
UPDATE NELHARaw SET MyQuarterCount = '42Quarters' FROM NELHARaw WHERE NewOrOld = 'New'
-- 1260  1260+1680=2940 good

--
/*
select exp(avg(log(Sali6350))),max(Sali6350),min(Sali6350),avg(Sali6350),COUNT(Sali6350),SUM(Sali6350)
  from NELHARaw
  where Sali6350 is not null
-- 34.7068832326369	35.85200000	24.90000000	34.70923938	2938	101975.74530000
select exp(avg(log(Sali6350))) * .90 FROM NELHARaw WHERE Sali6350 IS NOT NULL
-- 31.2361949093732
UPDATE NELHARaw SET SalinityLE32 = 1 FROM NELHARaw WHERE Sali6350 <= 31.2361949093732
-- 2 rows affected!
select exp(avg(log(Sali6350))) * .95 FROM NELHARaw WHERE Sali6350 IS NOT NULL
-- 32.971539
UPDATE NELHARaw SET SalinityLE32 = 1 FROM NELHARaw WHERE Sali6350 <= 32.971539
-- 2 rows affected!
select exp(avg(log(Sali6350))) * .98 FROM NELHARaw WHERE Sali6350 IS NOT NULL
-- 34.0127455679841
UPDATE NELHARaw SET SalinityLE32 = 1 FROM NELHARaw WHERE Sali6350 <= 34.0127455679841
-- 123 rows affected
select exp(avg(log(Sali6350))) * .99 FROM NELHARaw WHERE Sali6350 IS NOT NULL
-- 34.3598144003105
UPDATE NELHARaw SET SalinityLE32 = 1 FROM NELHARaw WHERE Sali6350 <= 34.3598144003105
-- 366 rows affected
select exp(avg(log(Sali6350))) * .999 FROM NELHARaw WHERE Sali6350 IS NOT NULL
-- 34.6721763494042
UPDATE NELHARaw SET SalinityLE32 = 1 FROM NELHARaw WHERE Sali6350 <= 34.6721763494042
-- 1127 rows affected
-- let's go with the 4 9's since that is a substantial number 1245 out of total 2940
-- but not too many
select exp(avg(log(Sali6350))) * .9999 FROM NELHARaw WHERE Sali6350 IS NOT NULL
-- 34.7034125443136
UPDATE NELHARaw SET SalinityLE32 = 1 FROM NELHARaw WHERE Sali6350 <= 34.7034125443136
-- 1245 rows affected
--UPDATE NELHARaw SET SalinityLE32 = 1 FROM NELHARaw WHERE Sali6350 <= 32.0
-- 2 rows affected!
--UPDATE NELHARaw SET SalinityLE32 = 1 FROM NELHARaw WHERE Sali6350 <= 33.0
-- 2 rows affected!
--UPDATE NELHARaw SET SalinityLE32 = 1 FROM NELHARaw WHERE Sali6350 <= 34.0
-- 120 rows affected!
--UPDATE NELHARaw SET SalinityLE32 = 1 FROM NELHARaw WHERE Sali6350 <= 34.5
-- 636 rows affected!
--UPDATE NELHARaw SET SalinityLE32 = 1 FROM NELHARaw WHERE Sali6350 <= 34.75
-- 1419 rows affected!
--UPDATE NELHARaw SET SalinityLE32 = 1 FROM NELHARaw WHERE Sali6350 <= 35.0
-- 2425 rows affected!
*/



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
-- transect and mshore are the label
 UPDATE NELHARaw SET 
MyLabel = MyTransectName + ' ' + MyLocationLabel + NewOrOld
FROM NELHARaw raw
-- 2940
-- date/time, since NELHA so highly structured we just really have only one date
-- but that is ok since he took all samples quarterly
UPDATE NELHARaw SET 
MyStartDate = Esridatetime,
MyEndDate   = Esridatetime
FROM NELHARaw raw
-- 2940
select * from NELHARaw
--
UPDATE NELHARaw SET 
MyDateRange = SUBSTRING(convert(varchar, MyStartDate, 107),1,3) + SUBSTRING(convert(varchar, MyStartDate, 107),9,4)
FROM NELHARaw raw
-- 2940
select MyDateRange from NELHARaw


--
select * from NELHARaw
-- create the corename
-- make core name 
 UPDATE NELHARaw SET MyCoreName = 
   MyLatitude + '_' +
   RIGHT('000'+LTRIM(str(mShore)),3) + 'm' + '_' +
   'KeaholePoint'    + '_' + 
   'KOlson'   + '_' + 
   'Transect' + str(Transect,1) + '_' +
   'T' + MyQuarterCount         + '_' + 
   'Y' +  MyDateRange
FROM NELHARaw
--2940
UPDATE NELHARaw SET MyCoreName = REPLACE(REPLACE(MyCoreName, ' ',''),'-','')
--2940
			 
select MyCoreName from NELHARaw
select * from NELHAMyGeocodedLocations_temp



--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- make the dates unique by adding a few seconds
DECLARE @GeoUniq uniqueidentifier, @StartDate datetime2, @EndDate datetime2, @RowCount integer=0
DECLARE @cursorInsert CURSOR SET @cursorInsert = CURSOR FOR
   SELECT GeoUniq, StartDate, EndDate FROM NELHAMyGeocodedLocations_temp
OPEN @cursorInsert
FETCH NEXT FROM @cursorInsert INTO @GeoUniq, @StartDate, @EndDate
--
WHILE @@FETCH_STATUS = 0
   BEGIN
   set @RowCount = @RowCount + 1
   UPDATE NELHAMyGeocodedLocations_temp 
   SET StartDate = DATEADD(ss,@RowCount,StartDate),EndDate = DATEADD(ss,@RowCount,EndDate)
   WHERE NELHAMyGeocodedLocations_temp.GeoUniq IN (SELECT @GeoUniq FROM NELHAMyGeocodedLocations_temp)
   FETCH NEXT FROM @cursorInsert INTO @GeoUniq, @StartDate, @EndDate
   END
CLOSE @cursorInsert
DEALLOCATE @cursorInsert
--
select StartDate,EndDate from NELHAMyGeocodedLocations_temp
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- populate FCStation

--  DROP  TABLE NELHAFCStation
CREATE TABLE NELHAFCStation (
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

 -- SELECT MyCoreName, COUNT(MyCoreName) FROM NELHARaw GROUP BY MyCoreName HAVING COUNT(MyCoreName)>1
 -- select * from NELHARaw order by MyCoreName 
 -- delete from NELHaRaw where EsriDateTime = '2017-11-28 12:03:00.0000000'
 -- delete from NELHaRaw where MyCoreName='19_7276_001m_NELHA_NELHATransect3001mNew_KOlson_Transect3_T42Quarters_YOct2013'
 select * from NELHARaw

 --  DELETE from NELHAFCStation
--  INSERT INTO NELHAFCStation 
SELECT 
MyLatitude + '_' + mShoreT + '_KeaholePoint_KOlson_Transect' + str(Transect,1),-- pkStation, temp unique
replace(str(transect),' ','') + '/' + mShoreT,   -- Label
NULL,                  -- TablePage
NULL,                  -- fkStation1
NewOrOld,              -- fkStation2 something anyway
mShore,                -- mShore
3499,                  -- dmStA
6499,                  -- dmStAA 
3799,                  -- dmStBott
7110,                  -- dmStClas not applicable value
4660,                  -- dmAccuracy from Google MyMaps geocoding
8855,                  -- dmReef - not applicable value
7777,                  -- dmRule - not applicable value
555,                   -- dmStType
NULL,                  -- fkEPA
NULL,                  -- fkUSGS   
'No',                  -- Embayment
NULL,                  -- VolumeBay
NULL,                  -- CrossArea
197320,                -- AttachSt
--
NULL,                  -- dmAccu4610
CAST(IIF(NewOrOld='New', MyLatLong, NULL) as nvarchar),  -- dmAccu4620, used documentation from NELHA for new stations, but I converted to decimal since that is all I use
NULL,                  -- dmAccu4630
NULL,                  -- dmAccu4640
CAST(IIF(NewOrOld='New', NULL, MyLatLong) as nvarchar),  -- dmAccu4650 I geocoded all the old stations 
NULL,                  -- dmAccu4660
NULL,                  -- dmAccu4670
StartDate,             -- StartDate fill in later
EndDate,               -- EndDate
--
NULL,NULL,NULL,NULL,NULL,    -- 5 extra fields
POINT_X,POINT_Y,             -- XField, YField
--
IIF(mShore in (1,8),90,IIF(mShore in (10,23),180,IIF(mShore in (38,50),270,IIF(mShore in (53,100),-90,0)))),
0,                           -- Normalize
0,                           -- Weight
0,NULL,                      -- PageQuery/S
--
GeoUniq, -- tracer to geocode table
newid(), -- StatUniq is assigned here since making a new record
GeoUniq  -- RawUniq tracer backwards

FROM NELHAMyGeocodedLocations_temp
ORDER by Transect, mShore
-- 60



SELECT count(*) FROM NELHAMyGeocodedLocations_temp geo
-- 60 
SELECT count(*) FROM NELHARaw raw
-- 2940
SELECT distinct(GeoUniq) FROM NELHAMyGeocodedLocations_temp geo
-- 60
SELECT distinct(GeoUniq) FROM NELHARaw raw
-- 60

--
select * from NELHAFCStation order by pkStation desc
--

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- Next is preparation for inserting into TBSample
-- the goal is develop a string of analytes not null for each sample of the raw data
-- this will be used for the pkSample multi-part name string of the TBSample table

--   DROP TABLE NELHADateWithAnalyte_temp
CREATE TABLE NELHADateWithAnalyte_temp (
    [Transect] [int]            NOT NULL,
	[mShore]   [int]            NOT NULL,
	[NewOrOld] [nvarchar](3)    NOT NULL,

	[tPhos6391] [nvarchar](255)   NULL,
	[tNaNi6230] [nvarchar](255)   NULL,
	[tAmmN6220] [nvarchar](255)   NULL,
	[tSili6360] [nvarchar](255)   NULL,
	[tTDPh6386] [nvarchar](255)   NULL,--5
--			  
	[tTDNi6210] [nvarchar](255)   NULL,
	[tTPho6240] [nvarchar](255)   NULL,
	[tTtOC6392] [nvarchar](255)   NULL,
	[tTurb6260] [nvarchar](255)   NULL,
	[tSali6350] [nvarchar](255)   NULL,--10
--		  
	[tSali9999] [nvarchar](255)   NULL,
	[tTemp6280] [nvarchar](255)   NULL,
	[tpHyd6390] [nvarchar](255)   NULL,
	[tOxyD6270] [nvarchar](255)   NULL,
	[tChlA6250] [nvarchar](255)   NULL,--15
--
	[tColi6420] [nvarchar](255)  NULL,
	[tEcci6410] [nvarchar](255)  NULL,--17
-- my fields
A_RawUniq      [uniqueidentifier] NOT NULL,
A_NewUniq      [uniqueidentifier] NOT NULL,
--PRIMARY KEY (Transect, mShore, NewOrOld)
--PRIMARY KEY (A_RawUniq)
)

-- do the most basic import, assign null to all analyte char fields
--  INSERT into NELHADateWithAnalyte_temp
SELECT 
Transect,
mShore,
NewOrOld,
NULL,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,NULL,
NULL,NULL,
RawUniq, -- pk
newid()
FROM NELHARaw
-- 2950

-- fill in this table so it can be used later to make TBSample
 UPDATE NELHADateWithAnalyte_temp SET 
tPhos6391 = 'Phos6391' FROM NELHARaw raw 
WHERE raw.Phos6391 IS NOT NULL AND raw.RawUniq = NELHADateWithAnalyte_temp.A_RawUniq
-- 2939 (all but one!)
select tPhos6391 from NELHADateWithAnalyte_temp

UPDATE NELHADateWithAnalyte_temp SET tNaNi6230 = 'NaNi6230' FROM NELHARaw raw 
WHERE raw.NaNi6230 IS NOT NULL AND raw.RawUniq = NELHADateWithAnalyte_temp.A_RawUniq
-- 2939

UPDATE NELHADateWithAnalyte_temp SET tAmmN6220 = 'AmmN6220' FROM NELHARaw raw 
WHERE raw.AmmN6220 IS NOT NULL AND raw.RawUniq = NELHADateWithAnalyte_temp.A_RawUniq
-- 2910 like almost all (-30)

UPDATE NELHADateWithAnalyte_temp SET tSili6360 = 'Sili6360' FROM NELHARaw raw 
WHERE raw.Sili6360 IS NOT NULL AND raw.RawUniq = NELHADateWithAnalyte_temp.A_RawUniq
-- 2939
UPDATE NELHADateWithAnalyte_temp SET tTDPh6386 = 'TDPh6386' FROM NELHARaw raw 
WHERE raw.TDPh6386 IS NOT NULL AND raw.RawUniq = NELHADateWithAnalyte_temp.A_RawUniq
-- 1595
UPDATE NELHADateWithAnalyte_temp SET tTDNi6210 = 'TDNi6210' FROM NELHARaw raw 
WHERE raw.TDNi6210 IS NOT NULL AND raw.RawUniq = NELHADateWithAnalyte_temp.A_RawUniq
-- 1599

UPDATE NELHADateWithAnalyte_temp SET tTPho6240 = 'TPho6240' FROM NELHARaw raw 
WHERE raw.TPho6240 IS NOT NULL AND raw.RawUniq = NELHADateWithAnalyte_temp.A_RawUniq
-- 336
UPDATE NELHADateWithAnalyte_temp SET tTtOC6392 = 'TtOC6392' FROM NELHARaw raw 
WHERE raw.TtOC6392 IS NOT NULL AND raw.RawUniq = NELHADateWithAnalyte_temp.A_RawUniq
-- 275
UPDATE NELHADateWithAnalyte_temp SET tTurb6260 = 'Turb6260' FROM NELHARaw raw 
WHERE raw.Turb6260 IS NOT NULL AND raw.RawUniq = NELHADateWithAnalyte_temp.A_RawUniq
-- 2880 like almost all then
-- take a look some funcs
select count(*),min(esridatetime),max(esridatetime) FROM NELHARaw WHERE Turb6260 IS  NULL
-- 60	2004-03-11 09:24:00.000	2004-05-24 11:04:00.000 broken meter noted in annual report

UPDATE NELHADateWithAnalyte_temp SET tSali6350 = 'Sali6350' FROM NELHARaw raw 
WHERE raw.Sali6350 IS NOT NULL AND raw.RawUniq = NELHADateWithAnalyte_temp.A_RawUniq
-- 2938

UPDATE NELHADateWithAnalyte_temp SET tTemp6280 = 'Temp6280' FROM NELHARaw raw 
WHERE raw.Temp6280 IS NOT NULL AND raw.RawUniq = NELHADateWithAnalyte_temp.A_RawUniq
-- 2936

UPDATE NELHADateWithAnalyte_temp SET tpHyd6390  = 'pHyd6390' FROM NELHARaw raw 
WHERE raw.pHyd6390 IS NOT NULL AND raw.RawUniq = NELHADateWithAnalyte_temp.A_RawUniq
-- 1596
SELECT count(*),min(esridatetime),max(esridatetime) FROM NELHARaw WHERE pHyd6390 IS  NULL
-- 1344 1900-01-04 09:21:00.000	2007-04-16 11:21:00.000

UPDATE NELHADateWithAnalyte_temp SET tOxyD6270 = 'OxyD6270' FROM NELHARaw raw 
WHERE raw.OxyD6270 IS NOT NULL AND raw.RawUniq = NELHADateWithAnalyte_temp.A_RawUniq
-- 1588
SELECT count(*),min(esridatetime),max(esridatetime) FROM NELHARaw WHERE OxyD6270 IS  NULL
-- 1352	1900-01-04 09:21:00.000	2007-04-16 11:21:00.000

UPDATE NELHADateWithAnalyte_temp SET tChlA6250 = 'ChlA6250' FROM NELHARaw raw 
WHERE raw.ChlA6250 IS NOT NULL AND raw.RawUniq = NELHADateWithAnalyte_temp.A_RawUniq
-- 1582
SELECT count(*),min(esridatetime),max(esridatetime) FROM NELHARaw WHERE ChlA6250 IS  NULL
-- 1358	1900-01-04 09:21:00.000	2017-11-28 10:56:00.000
UPDATE NELHADateWithAnalyte_temp SET tColi6420 = 'Coli6420' FROM NELHARaw raw 
WHERE raw.Coli6420 IS NOT NULL AND raw.RawUniq = NELHADateWithAnalyte_temp.A_RawUniq
-- 323
UPDATE NELHADateWithAnalyte_temp SET tEcci6410 = 'Ecci6410' FROM NELHARaw raw 
WHERE raw.Ecci6410 IS NOT NULL AND raw.RawUniq = NELHADateWithAnalyte_temp.A_RawUniq
-- 323
SELECT count(*),min(esridatetime),max(esridatetime) FROM NELHARaw WHERE Coli6420 IS NULL OR Ecci6410 IS  NULL
-- 2617	1900-01-04 09:21:00.000	2017-11-30 10:39:00.000
--
-- text fields filled in with Analyte name if not null
select * from NELHADateWithAnalyte_temp

-- this is the final assemblage from above effort
 UPDATE NELHARaw SET MyAnalyteList =
RTRIM(
ISNULL(tPhos6391,'')+
ISNULL(tNaNi6230,'')+
ISNULL(tAmmN6220,'')+
ISNULL(tSili6360,'')+
ISNULL(tTDPh6386,'')+
ISNULL(tTDNi6210,'')+
ISNULL(tTPho6240,'')+
ISNULL(tTtOC6392,'')+
ISNULL(tTurb6260,'')+
ISNULL(tSali6350,'')+
ISNULL(tSali9999,'')+
ISNULL(tTemp6280,'')+
ISNULL(tpHyd6390,'')+
ISNULL(tOxyD6270,'')+
ISNULL(tChlA6250,'')+
ISNULL(tColi6420,'')+
ISNULL(tEcci6410,''))
FROM NELHADateWithAnalyte_temp
WHERE NELHARaw.RawUniq = NELHADateWithAnalyte_temp.A_RawUniq
--2940
select MyAnalyteList from NELHARaw


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- Now work on the TBSample table
-- the pkSample name pieces are available to include fully formed names
-- there are 10655 sample, with up to 7 analytes recorded per sample

--  DROP TABLE NELHATBSample
CREATE TABLE NELHATBSample (
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

------------------------------------------
--   DELETE FROM NELHATBSample
--  INSERT INTO NELHATBSample
SELECT 
MyCoreName + '_' + MyAnalyteList,
MyLabel,                 -- LabelName
NULL,                    -- TitlePage
0,                       -- Alert not applicable at this site
'KOlson',                -- fkIDLoc
Transect,
mShore, 
MyLatitude + '_' + RIGHT('000' + LTRIM(str(mShore)), 3) + 'm' + '_KeaholePoint_KOlson_Transect' + str(Transect,1),-- fkStation, temp unique                -- 
NULL,                    -- fkStatio2
'KeaholePoint',          --
newid(),                 -- fkUniqID is the new if generated in this new row creation of the insert
'<<fkOrg>>',             -- *** GET ****
1420,                    -- laboratory method domain field
MyStartDate,MyEndDate,
'Has Local Time',         -- and make such comment in TimeMissg field, we have time - local
NULL,NULL,
NULL,                    -- no Comment yet
197320,                  -- attach is same as FCStation and is Lat of Transect#1, Station#1 1m (new)
NULL,NULL,NULL,NULL,NULL,
0,0,0,1,NULL,               -- cartography fields
newid(),
RawUniq                  -- for tracing to save source row id

FROM NELHARaw
ORDER BY RawIdentityA -- maintain order (if that means anything)
--2940

select * from NELHATBSample order by pkSample
select * from NELHATBSample 
order by pkSample


-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------
--
/*
-- situation where we I have designed the sample and station both the same as the raw but with different
-- primary fields pkStation and pkSample from and within respective tables
UPDATE NELHATBSample SET fkStation = stat.pkStation
FROM NELHAFCStation stat
INNER JOIN NELHATBSample samp
ON stat.RawUniq = samp.RawUniq
-- 2940
select * from NELHATBSample
select distinct(fkStation) from NELHATBSample
select count(distinct(fkStation)) from NELHATBSample
-- 2940
*/

------------------------------------------------
------------------------------------------------
/*
-- row count is the same in FCStation and TBSample for this site
-- integrity check, should match the row count I have been seeing all along
SELECT count(raw.RawUniq)
from NELHATBSample samp, NELHARaw raw
where samp.RawUniq = raw.RawUniq
-- 2940 rows good!
SELECT count(raw.RawUniq)
from NELHAFCStation station, NELHARaw raw
where station.RawUniq = raw.RawUniq
-- 2940 good
SELECT count(samp.RawUniq)
from NELHAFCStation station, NELHATBSample samp
where samp.RawUniq = station.RawUniq
-- 2940 rows good! these 2 going to ersi
*/

/*
-- again, make sure we have row level integrity
-- select * from NELHATBSample
-- select * from NELHAFCStation
declare @testguid uniqueidentifier = '2DD7EF93-D015-4C40-AD44-97E39A027748'  -- samp
--declare @testguid uniqueidentifier = '1FF16811-BD9E-4981-ABAA-066E9CBE46F9'  -- station
SELECT * from NELHARaw             where RawUniq  = @testguid
SELECT * from NELHATBSample        where RawUniq  = @testguid
SELECT * from NELHAFCStation       where RawUniq  = @testguid
-- should be exactly 1 row each if test from FCStation...and the same one!...
-- this was last tested 1/25/2018
------------------------
-- integrity tests over, continue populating fields we need from other tables
*/

select * from NELHATBSample
---------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--  DROP TABLE NELHATBResult
CREATE TABLE NELHATBResult (
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
	[RawUniq] [uniqueidentifier] NULL,
	[ResUniq] [uniqueidentifier] NULL,
	[SampUniq] [uniqueidentifier] NULL

PRIMARY KEY (fkSample,dmRAll)
)
GO

--  DELETE FROM  NELHATBResult
--   
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 1/16
 INSERT INTO NELHATBResult
SELECT 
samp.pkSample,
'Phos6391 - Phosphorus PO4',
samp.fkIDLoc,
samp.fkUnqID,
raw.Phos6391,
NULL, --stdev
6391, -- dmRAll
6464, -- dmRAMethod
6310, -- dmR11546
6391, -- dmRAnlyt
6430, -- dmRBEACH
NULL, -- Grade
NULL, --Comments
NULL, NULL, NULL, NULL, NULL, NULL,  
raw.RawUniq, newid(), 
samp.SampUniq  -- SampUniq 
FROM NELHARaw raw,NELHATBSample samp
WHERE raw.RawUniq = samp.RawUniq and raw.Phos6391 IS NOT NULL
ORDER BY raw.RawIdentityA
-- 2939
SELECT 
samp.pkSample,
'Phos6391 - Phosphorus PO4',
samp.fkIDLoc,
samp.fkUnqID,
raw.Phos6391,
NULL, --stdev
6391, -- dmRAll
6464, -- dmRAMethod
6310, -- dmR11546
6391, -- dmRAnlyt
6430, -- dmRBEACH
NULL, -- Grade
NULL, --Comments
NULL, NULL, NULL, NULL, NULL, NULL,  
raw.RawUniq, newid(), 
samp.SampUniq  -- SampUniq 
FROM NELHARaw raw INNER JOIN NELHATBSample samp
ON raw.RawUniq = samp.RawUniq and raw.Phos6391 IS NOT NULL
ORDER BY raw.RawIdentityA
-- 2939
--------------------------------------------------------------------------------
--2
INSERT INTO NELHATBResult
SELECT 
samp.pkSample,
'NaNi6230 - Nitrate+Nitrite Nitrogen',
samp.fkIDLoc,
samp.fkUnqID,
raw.NaNi6230,
NULL, --stdev
6230, -- dmRAll
6464, -- dmRAMethod
6230, -- dmR11546
6370, -- dmRAnlyt
6430, -- dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, NULL, NULL, NULL, NULL, NULL,  
raw.RawUniq, newid(), 
samp.SampUniq  -- SampUniq 
FROM NELHARaw raw INNER JOIN NELHATBSample samp
ON raw.RawUniq = samp.RawUniq and raw.NaNi6230 IS NOT NULL
ORDER BY raw.RawIdentityA
-- 2939
select sum(NaNi6230) FROM NELHARaw raw
WHERE raw.NaNi6230 IS NOT NULL
select sum(Result) FROM NELHATBResult
WHERE dmRall = 6230
--15538.63763000  both
--------------------------------------------------------------------------------
--3
INSERT INTO NELHATBResult
SELECT 
samp.pkSample,
'AmmN6220 - Ammonia Nitrogen',
samp.fkIDLoc,
samp.fkUnqID,
raw.AmmN6220,
NULL, --stdev
6220, -- dmRAll
6464, -- dmRAMethod
6220, -- dmR11546
6370, -- dmRAnlyt
6430, -- dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, NULL, NULL, NULL, NULL, NULL,  
raw.RawUniq, newid(), 
samp.SampUniq  -- SampUniq 
FROM NELHARaw raw INNER JOIN NELHATBSample samp
ON raw.RawUniq = samp.RawUniq and raw.AmmN6220 IS NOT NULL
ORDER BY raw.RawIdentityA
-- 2910
--------------------------------------------------------------------------------
--4
INSERT INTO NELHATBResult
SELECT 
samp.pkSample,
'Sili6360 - Silicates',
samp.fkIDLoc,
samp.fkUnqID,
raw.Sili6360,
NULL, --stdev
6360, -- dmRAll
6464, -- dmRAMethod
6310, -- dmR11546
6360, -- dmRAnlyt
6430, -- dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, NULL, NULL, NULL, NULL, NULL,  
raw.RawUniq, newid(), 
samp.SampUniq  -- SampUniq 
FROM NELHARaw raw INNER JOIN NELHATBSample samp
ON raw.RawUniq = samp.RawUniq and raw.Sili6360 IS NOT NULL
ORDER BY raw.RawIdentityA
-- 2939
--------------------------------------------------------------------------------
--5
INSERT INTO NELHATBResult
SELECT 
samp.pkSample,
'TDPh6386 - Total Dissolved Phosphorus',
samp.fkIDLoc,
samp.fkUnqID,
raw.TDPh6386,
NULL, --stdev
6386, -- dmRAll
6464, -- dmRAMethod
6299, -- dmR11546
6386, -- dmRAnlyt
6430, -- dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, NULL, NULL, NULL, NULL, NULL,  
raw.RawUniq, newid(), 
samp.SampUniq  -- SampUniq 
FROM NELHARaw raw INNER JOIN NELHATBSample samp
ON raw.RawUniq = samp.RawUniq and raw.TDPh6386 IS NOT NULL
ORDER BY raw.RawIdentityA
-- 1595
--------------------------------------------------------------------------------
--6
INSERT INTO NELHATBResult
SELECT 
samp.pkSample,
'TDNi6210 - Total Nitrogen',
samp.fkIDLoc,
samp.fkUnqID,
raw.TDNi6210, 
NULL, --stdev
6210, -- dmRAll
6464, -- dmRAMethod
6210, -- dmR11546
6370, -- dmRAnlyt
6430, -- dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, NULL, NULL, NULL, NULL, NULL,  
raw.RawUniq, newid(), 
samp.SampUniq  -- SampUniq 
FROM NELHARaw raw INNER JOIN NELHATBSample samp
ON raw.RawUniq = samp.RawUniq and raw.TDNi6210 IS NOT NULL
ORDER BY raw.RawIdentityA
-- 1599
--------------------------------------------------------------------------------
--7
INSERT INTO NELHATBResult
SELECT 
samp.pkSample,
'TPho6240 - Total Phosphorus',
samp.fkIDLoc,
samp.fkUnqID,
raw.TPho6240, 
NULL, --stdev
6240, -- dmRAll
6464, -- dmRAMethod
6240, -- dmR11546
6370, -- dmRAnlyt
6430, -- dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, NULL, NULL, NULL, NULL, NULL,  
raw.RawUniq, newid(), 
samp.SampUniq  -- SampUniq 
FROM NELHARaw raw INNER JOIN NELHATBSample samp
ON raw.RawUniq = samp.RawUniq and raw.TPho6240 IS NOT NULL
ORDER BY raw.RawIdentityA
-- 336
--------------------------------------------------------------------------------
--8
INSERT INTO NELHATBResult
SELECT 
samp.pkSample,
'TtOC6392 - Total Organic Carbon',
samp.fkIDLoc,
samp.fkUnqID,
raw.TtOC6392, 
NULL, --stdev
6392, -- dmRAll
6464, -- dmRAMethod
6310, -- dmR11546
6392, -- dmRAnlyt
6430, -- dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, NULL, NULL, NULL, NULL, NULL,  
raw.RawUniq, newid(), 
samp.SampUniq  -- SampUniq 
FROM NELHARaw raw INNER JOIN NELHATBSample samp
ON raw.RawUniq = samp.RawUniq and raw.TtOC6392 IS NOT NULL
ORDER BY raw.RawIdentityA
-- 275
--------------------------------------------------------------------------------
--9
INSERT INTO NELHATBResult
SELECT 
samp.pkSample,
'Turb6260 - Turbidity',
samp.fkIDLoc,
samp.fkUnqID,
raw.Turb6260, 
NULL, --stdev
6260, -- dmRAll
6464, -- dmRAMethod
6260, -- dmR11546
6370, -- dmRAnlyt
6430, -- dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, NULL, NULL, NULL, NULL, NULL,  
raw.RawUniq, newid(), 
samp.SampUniq  -- SampUniq 
FROM NELHARaw raw INNER JOIN NELHATBSample samp
ON raw.RawUniq = samp.RawUniq and raw.Turb6260 IS NOT NULL
ORDER BY raw.RawIdentityA
-- 2880
--------------------------------------------------------------------------------
--10
INSERT INTO NELHATBResult
SELECT 
samp.pkSample,
'Sali6350 - Salinity',
samp.fkIDLoc,
samp.fkUnqID,
raw.Sali6350, 
NULL, --stdev
6350, -- dmRAll
6464, -- dmRAMethod
6310, -- dmR11546
6350, -- dmRAnlyt
6430, -- dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, NULL, NULL, NULL, NULL, NULL,  
raw.RawUniq, newid(), 
samp.SampUniq  -- SampUniq 
FROM NELHARaw raw INNER JOIN NELHATBSample samp
ON raw.RawUniq = samp.RawUniq and raw.Sali6350 IS NOT NULL
ORDER BY raw.RawIdentityA
-- 2938
--------------------------------------------------------------------------------
--11
INSERT INTO NELHATBResult
SELECT 
samp.pkSample,
'Temp6280 - Temperature C',
samp.fkIDLoc,
samp.fkUnqID,
raw.Temp6280, 
NULL, --stdev
6280, -- dmRAll
6464, -- dmRAMethod
6280, -- dmR11546
6370, -- dmRAnlyt
6430, -- dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, NULL, NULL, NULL, NULL, NULL,  
raw.RawUniq, newid(), 
samp.SampUniq  -- SampUniq 
FROM NELHARaw raw INNER JOIN NELHATBSample samp
ON raw.RawUniq = samp.RawUniq and raw.Temp6280 IS NOT NULL
ORDER BY raw.RawIdentityA
-- 2936
--------------------------------------------------------------------------------
--12
INSERT INTO NELHATBResult
SELECT 
samp.pkSample,
'pHyd6390 - pH',
samp.fkIDLoc,
samp.fkUnqID,
raw.pHyd6390, 
NULL, --stdev
6390, -- dmRAll
6464, -- dmRAMethod
6310, -- dmR11546
6390, -- dmRAnlyt
6430, -- dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, NULL, NULL, NULL, NULL, NULL,  
raw.RawUniq, newid(), 
samp.SampUniq  -- SampUniq 
FROM NELHARaw raw INNER JOIN NELHATBSample samp
ON raw.RawUniq = samp.RawUniq and raw.pHyd6390 IS NOT NULL
ORDER BY raw.RawIdentityA
-- 1596
--------------------------------------------------------------------------------
--13
INSERT INTO NELHATBResult
SELECT 
samp.pkSample,
'OxyD6270 - Dissolved Oxygen',
samp.fkIDLoc,
samp.fkUnqID,
raw.OxyD6270, 
NULL, --stdev
6270, -- dmRAll
6464, -- dmRAMethod
6270, -- dmR11546
6310, -- dmRAnlyt
6430, -- dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, NULL, NULL, NULL, NULL, NULL,  
raw.RawUniq, newid(), 
samp.SampUniq  -- SampUniq 
FROM NELHARaw raw INNER JOIN NELHATBSample samp
ON raw.RawUniq = samp.RawUniq and raw.OxyD6270 IS NOT NULL
ORDER BY raw.RawIdentityA
-- 1588
--------------------------------------------------------------------------------
--14
INSERT INTO NELHATBResult
SELECT 
samp.pkSample,
'ChlA6250 - Chlorophyll a',
samp.fkIDLoc,
samp.fkUnqID,
raw.ChlA6250, 
NULL, --stdev
6250, -- dmRAll
6464, -- dmRAMethod
6250, -- dmR11546
6310, -- dmRAnlyt
6430, -- dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, NULL, NULL, NULL, NULL, NULL,  
raw.RawUniq, newid(), 
samp.SampUniq  -- SampUniq 
FROM NELHARaw raw INNER JOIN NELHATBSample samp
ON raw.RawUniq = samp.RawUniq and raw.ChlA6250 IS NOT NULL
ORDER BY raw.RawIdentityA
-- 1582
--------------------------------------------------------------------------------
--14
INSERT INTO NELHATBResult
SELECT 
samp.pkSample,
'Clos6420 - Clostridium perfringens',
samp.fkIDLoc,
samp.fkUnqID,
raw.Coli6420, 
NULL, --stdev
6420, -- dmRAll
6464, -- dmRAMethod
6310, -- dmR11546
6370, -- dmRAnlyt
6420, -- dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, NULL, NULL, NULL, NULL, NULL,  
raw.RawUniq, newid(), 
samp.SampUniq  -- SampUniq 
FROM NELHARaw raw INNER JOIN NELHATBSample samp
ON raw.RawUniq = samp.RawUniq and raw.Coli6420 IS NOT NULL
ORDER BY raw.RawIdentityA
-- 323
--------------------------------------------------------------------------------
--15
INSERT INTO NELHATBResult
SELECT 
samp.pkSample,
'Ecci6410 - Enterococci',
samp.fkIDLoc,
samp.fkUnqID,
raw.Ecci6410, 
NULL, --stdev
6410, -- dmRAll
6464, -- dmRAMethod
6310, -- dmR11546
6370, -- dmRAnlyt
6410, -- dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, NULL, NULL, NULL, NULL, NULL,  
raw.RawUniq, newid(), 
samp.SampUniq  -- SampUniq 
FROM NELHARaw raw INNER JOIN NELHATBSample samp
ON raw.RawUniq = samp.RawUniq and raw.Ecci6410 IS NOT NULL
ORDER BY raw.RawIdentityA
-- 323

SELECT COUNT(*) FROM NELHATBResult
-- 29,698 rows
SELECT * FROM NELHATBResult order by fkSample,dmRAll

----------
--
SELECT COUNT(*) FROM NELHATBResult
SELECT * FROM NELHATBResult


-- V1 thesis maps
SELECT Count(*) as 'TBResult Count' FROM NELHATBResult
--WHERE fkSample LIKE '%T56Quarters%'
--WHERE fkStation = 'New'
--WHERE fkSample LIKE '%T42Quarters%'

SELECT Label, Count(dmRAll) as 'TBResult rows' FROM NELHATBResult
--WHERE fkSample LIKE '%T56Quarters%'
--WHERE fkSample LIKE '%T42Quarters%'
--WHERE fkStation = 'New'
GROUP by Label, dmRAll ORDER by 2 DESC

-- V2 for thesis maps
use WHWQ4
SELECT 'Old 1993-2007' as 'NELHA 56 Quarters', Count(*) as 'TBResult #rows' FROM NELHATBResult WHERE fkSample LIKE '%T56Quarters%'
SELECT Label, Count(dmRAll) as '#rows', round(exp(avg(log(Result))),3) as '~gmean',round(stdev(Result),2) as 'stdev',cast(min(Result) as decimal (10,2)) as 'min',cast(max(Result) as decimal (10,2)) as 'max' 
FROM NELHATBResult WHERE Result != 0 AND fkSample LIKE '%T56Quarters%' GROUP by Label, dmRAll ORDER by Label

SELECT 'New 2007-2017' as 'NELHA 42 Quarters', Count(*) as 'TBResult #rows' FROM NELHATBResult WHERE fkSample LIKE '%T42Quarters%'
SELECT Label, Count(dmRAll) as '#rows', round(exp(avg(log(Result))),3) as '~gmean',round(stdev(Result),2) as 'stdev',cast(min(Result) as decimal (10,2)) as 'min',cast(max(Result) as decimal (10,2)) as 'max' 
FROM NELHATBResult WHERE Result != 0 and fkSample LIKE '%T42Quarters%' GROUP by Label, dmRAll ORDER by Label


select * FROM NELHATBResult

