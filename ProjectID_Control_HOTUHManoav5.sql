-- TO import HOTS text data

-- last upate 04/20/2018
use WHWQ4
-

/****** Script for SelectTopNRows command from SSMS  ******/
-- this is for a raw file from HOTS with Analyte added 
--  drop TABLE [dbo].[HOTSRaw]

--  DROP TABLE HOTSRawVarChars
CREATE TABLE HOTSRawVarChars (
   RawIID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
   BottleID   [varchar](50)     NOT NULL,
   TextDate   [varchar](50)     NOT NULL,
   TextTime   [varchar](50)     NOT NULL,
   Press_dbar [numeric](38, 8)  NOT NULL,
   Result     [numeric](38, 8)  NOT NULL,
   --
   Analyte    [nvarchar](255)   NOT NULL, --  append Analyte to last position in a text file to import into this table 
)
GO


/*
do Microsoft SQL Server Management Studio import
Source type is flat file source, use all defaults
Destination is SQL Server Native Client 11.0
Choose HOTSRaw from drop down in destination column (or type in)
Then 'Edit Mappings' to make sure BottleID,TextDate,TextTime,Press_dbar, and Result fields are correct, ignore all others
7394 rows imported
*/

-- Add Analyte Code to the end of each row in the data selected from HOTS
-- http://hahana.soest.hawaii.edu/hot/hot-dogs/bextraction.html
--

----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------
select * from HOTSRawVarChars

-----------------------------------------------
--   DROP TABLE HOTSRaw 
CREATE TABLE HOTSRaw (
   RawIID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,-- let ms make unique id
   BottleID   [varchar](50)     NOT NULL,
   TextDate   [varchar](50)     NOT NULL,
   TextTime   [varchar](50)     NOT NULL,
   Press_dbar [numeric](38, 8)  NOT NULL,
   Result     [numeric](38, 8)  NOT NULL,
   Analyte      [nvarchar](255) NOT NULL, --  append Analyte to last position in a text file to import into this table
  
 -- new fields I added to needed to prepare for geodatbase and Esri
   MyCoreName   [nvarchar](255)     NULL,
   MyLabel      [nvarchar](255)     NULL,
   EsriDateTime [datetime2](7)      NULL, -- added to get data format correct
   Resultumol   [numeric](38, 8)    NULL, -- added to convert from umol/kg
)
GO

-- copy over into our working table
 INSERT INTO HOTSRaw
SELECT BottleID,TextDate,TextTime,Press_dbar,Result,Analyte,NULL,NULL,NULL,NULL	FROM HOTSRawVarChars  
-- 7394

select Analyte from HOTSRaw


-- HOTSRaw
SELECT * FROM HOTSRaw

 SELECT count(*) num,Analyte FROM HOTSRaw
GROUP BY Analyte
ORDER BY num DESC
/*
num	Analyte
2738	Sali6350
2738	Temp6280
605	COxy6272
417	OxyD6270
282	NaNi6230
275	Sili6360
115	ChlA6250
84	pHyd6390
70	TDNi6210
70	TPho6240
*/

/* remove unknown dates */
-- some dates have this this pattern for date and time, 
-- both will be set at same record to this value, same count 153 records out of total 7394
-- going to delete these as plain just need a date for my system
--SELECT count(*) FROM HOTSRaw
SELECT * FROM HOTSRaw WHERE TextDate = ' -00009' OR TextTime  = ' -00009'
--153
-- just delete these unknown date/times 153 rows, need a date
DELETE FROM HOTSRaw WHERE TextDate = ' -00009' OR TextTime  = ' -00009'
--153
----------
SELECT * FROM HOTSRaw where Result < 0
--10
/*
RawIID	BottleID	TextDate	TextTime	Press_dbar	Result	Analyte	MyCoreName	MyLabel	EsriDateTime	Resultumol
595	0810200622	 031297	 070732	4.50000000	-0.01000000	NaNi6230	NULL	NULL	NULL	NULL
625	1070200922	 081499	 075717	4.60000000	-0.01000000	NaNi6230	NULL	NULL	NULL	NULL
636	1110200622	 020300	 070624	4.40000000	-0.01000000	NaNi6230	NULL	NULL	NULL	NULL
649	1170200124	 072500	 171937	5.00000000	-0.01000000	NaNi6230	NULL	NULL	NULL	NULL
650	1170200224	 072500	 201335	4.10000000	-0.02000000	NaNi6230	NULL	NULL	NULL	NULL
652	1180200324	 082200	 194603	1.90000000	-0.01000000	NaNi6230	NULL	NULL	NULL	NULL
656	1190200720	 101800	 100516	4.90000000	-0.01000000	NaNi6230	NULL	NULL	NULL	NULL
727	1640200224	 103004	 184424	4.80000000	-0.02000000	NaNi6230	NULL	NULL	NULL	NULL
728	1640200324	 103004	 221753	4.60000000	-0.01000000	NaNi6230	NULL	NULL	NULL	NULL
3620	1560200314	 022404	 214957	4.00000000	-9.00000000	Sali6350	NULL	NULL	NULL	NULL
*/
DELETE FROM HOTSRaw where Result < 0
--10


-- remove strange spaces in these fields
UPDATE HOTSRaw SET 
BottleID = REPLACE(BottleID, ' ', ''),
TextDate = REPLACE(TextDate, ' ', ''),
TextTime = REPLACE(TextTime, ' ', '')
--7384

--
select * from HOTSRaw

-- get dates in datetime2 for Esri
 UPDATE HOTSRaw 
 SET EsriDateTime =
 --SELECT
    CONVERT(datetime2,  
    SUBSTRING(TextDate,1,2)+'/'+SUBSTRING(TextDate,3,2)+'/'+SUBSTRING(TextDate,5,2)
    + ' ' +
    SUBSTRING(TextTime,1,2)+':'+SUBSTRING(TextTime,3,2)+':'+SUBSTRING(TextTime,5,2)
    )
FROM HOTSRaw
-----
select EsriDateTime FROM HOTSRaw
select * FROM HOTSRaw
--------

/* don't do anything with value
-- same the values that are in molecular weight
UPDATE HOTSRaw 
SET Resultumol = Result
FROM HOTSRaw
WHERE Analyte in (
 'NaNi6230'
,'TDNi6210'
,'TPho6240'
,'COxy6272'
,'Sili6360'
--,'Temp6280'--not umol
--,'Sali6350'
--,'pHyd6390'
,'OxyD6270'
--,'ChlA6250'
)
--1676 rows affected
*/
/*
-- set original to really weird number just in case, will do conversion next
UPDATE HOTSRaw 
SET Result = -999.99
FROM HOTSRaw
WHERE Analyte in (
 'NaNi6230'
,'TDNi6210'
,'TPho6240'
,'COxy6272'
,'Sili6360'
--,'Temp6280'
--,'Sali6350'
--,'pHyd6390'
,'OxyD6270'
--,'ChlA6250'
)
*/

select * from HOTSRaw



-------------------------------------------------

SELECT count(*) num,Analyte FROM HOTSRaw
GROUP BY Analyte
ORDER BY num DESC
/*
num	Analyte
2686	Sali6350
2686	Temp6280
591	COxy6272
400	OxyD6270
278	NaNi6230
271	Sili6360
113	ChlA6250
80	pHyd6390
68	TDNi6210
68	TPho6240
*/

----------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- make the dates unique by adding a few seconds
DECLARE @RawIID int, @EsriDateTime datetime2, @RowCount integer=0
DECLARE @cursorInsert CURSOR SET @cursorInsert = CURSOR FOR
   SELECT RawIID, EsriDateTime FROM HOTSRaw
OPEN @cursorInsert
FETCH NEXT FROM @cursorInsert INTO @RawIID, @EsriDateTime
--
WHILE @@FETCH_STATUS = 0
   BEGIN
   set @RowCount = @RowCount + 1
   UPDATE HOTSRaw 
   SET EsriDateTime = cast(DATEADD(ss,@RowCount,EsriDateTime) as datetime2)
   WHERE HOTSRaw.RawIID IN (SELECT @RawIID FROM HOTSRaw)
   FETCH NEXT FROM @cursorInsert INTO @RawIID, @EsriDateTime
   END
CLOSE @cursorInsert
DEALLOCATE @cursorInsert
--
select distinct(EsriDateTime) from HOTSRaw
select EsriDateTime from HOTSRaw


--------------------------------------------------------------------------
--  DROP TABLE [dbo].[HOTSFCStation]
CREATE TABLE [dbo].[HOTSFCStation](
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
	[GeoUniq] [uniqueidentifier]  NOT NULL,
	[StatUniq] [uniqueidentifier] NOT NULL,
	[RawUniq] [uniqueidentifier]  NOT NULL,

 PRIMARY KEY (pkStation)
 ) 

 SELECT min(EsriDateTime),max(EsriDateTime) FROM HOTSRaw
 -- 1988-10-31 01:57:04.0000000	2016-11-28 01:05:55.0000000

 --    delete from HOTSFCStation
------------------------------------------------
-- just one station
--
  INSERT INTO HOTSFCStation VALUES (
'20_7500_ALOHAStation_UHManoa_Y1988To2016',
'UHManoa ALOHA Station Lat=22.75 Long=-158.00', -- Label
NULL,    -- TablePage
NULL,    -- fkStation1
NULL,	 -- fkStation2
100000,  -- mShore 100km
3499,	 -- dmStA
4699,	 -- dmStAA
3799,    -- dmStBott
7110,    -- dmStClas
4650,    -- dmAccuracy
8855,    -- dmStReef
7777,    -- dmStRule
700,	 -- dmStType
NULL,NULL, -- fkEPA, fkUSGS
'No',      -- Embayment
NULL,NULL, -- VolumeBay,CrossArea
2075,      -- AttachSt
NULL,NULL,NULL,NULL,NULL,NULL,NULL, -- -- dmAccu4610-4670 not used at this site
'1988-10-31 01:57:04',	'2016-11-28 01:05:55',   -- StartDate,EndDate
NULL,NULL,NULL,NULL,NULL,    -- 5 extra fields
-158.00,22.75,               -- XField, YField
--
0,                           -- Rotation
0,                           -- Normalize
0,                           -- Weight
0,NULL,                      -- PageQuery/S
--
newid(),                     -- GeoUniq set only since can't set to null on table create
newid(),                     -- StatUniq is assigned here when making a new record
newid()                      -- tracer backwards
)


-----------------------
-----------------------
-------------------------------------------------
--  DROP TABLE HOTSTBResult
CREATE TABLE HOTSTBResult(
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
	[SampUniq] [uniqueidentifier] NULL,
--
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NOT NULL,
	[Rotation] [int] NOT NULL,
	[Normalize] [int] NOT NULL,
	[Weight] [int] NOT NULL,
	[PageQuery] [int] NOT NULL,
	[PageQueryS] [nvarchar](255) NULL,

PRIMARY KEY (fkSample,dmRAll)-- per my schema in gdb
)

select fkUnqID from HOTSTBSample

select * from HOTSRaw
--
--    DELETE FROM HOTSTBResult 
--  INSERT INTO HOTSTBResult 
SELECT 
'20_7500_'+ LEFT(cast(EsriDateTime as varchar),4) +
    '_ALOHAStation_UHManoa_Y1988To2016_' + Analyte + '_' + 
	'_' +BottleID, -- needed to make unique 
Analyte,          -- Label
'20_7500_ALOHAStation_UHManoa_Y1988To2016',  -- fkIDLoc
'26EF130D-54B9-4465-BD0D-A54439EE04F2',      -- fkUnqID
Result, 
NULL,             -- Stddev
cast(substring(Analyte,5,4) as int), -- dmRAll
6460,			  -- dmRAMethod
6299,             -- dmR11546
6370,			  -- dmRAnlyt
6430,			  -- dmRBEACH
NULL,			  -- Grade
'BottleI='+BottleID+'_'+' Press_dbar='+cast(press_dbar as varchar)+' TextDate='+TextDate+'_'+' TextTime='+TextTime,       	  -- Comments
2275,		      -- AttachR
NULL,             -- RFloat1
NULL,             -- RFloat2
NULL,             -- RData1
NULL,             -- RData2
NULL,             -- RLong5
newid(),
newid(),
NULL,
EsriDateTime,     -- StartDate
EsriDateTime,     -- EndDate
0,		          -- Rotation
0,		          -- Normalize
0,	              -- Weight
0,		          -- PageQuery
NULL              -- PageQueryS
FROM HOTSRaw raw
WHERE Result is not NULL and Result > 0
ORDER by raw.EsriDateTime
-- 7123


-- set domain for domain dmR11546 for analytes in this list
UPDATE HOTSTBResult SET dmR11546 = dmRAll
WHERE dmRAll in (6210,6220,6230,6240,6250,6260,6270,6272,6280)
-- 4087

select * from HOTSTBResult 
ORDER by fkSample
--


-- V1 thesis maps displays
SELECT Count(*) as 'TBResult Count' FROM HOTSTBResult

SELECT Label,
--',', 
Count(dmRAll) as 'TBResult rows' FROM HOTSTBResult
GROUP by Label, dmRAll ORDER by 2 DESC

-------------

-- V2 thesis maps displays
SELECT 'ALOHA Station Latitute=22.75N Longtitude=-158W' as 'UH Manoa', Count(*) as 'TBResult #rows' FROM HOTSTBResult

SELECT Label, Count(dmRAll) as '#rows', round(exp(avg(log(Result))),3) as '~gmean',round(stdev(Result),2) as 'stdev',cast(min(Result) as decimal (10,2)) as 'min',cast(max(Result) as decimal (10,2)) as 'max' FROM HOTSTBResult 
WHERE Result<>0  AND dmRAll IN   (6280,6272,6270,6360,6250,6390,6210,6240)
--WHERE Result<>0  AND dmRAll IN (6280,6272,6270,6230,6360,6250,6390,6210,6240)
--(6350,6230)
GROUP by Label, dmRAll ORDER by Label

SELECT 'UHManoa ALOHA station(0-5m)Latitute=22.75N Longtitude=-158W' as 'UH Manoa', Count(*) as 'TBResult #rows' FROM HOTSTBResult
SELECT Label, Count(dmRAll) as '#rows', round(exp(avg(log(Result))),3) as '~gmean',round(stdev(Result),2) as 'stdev',cast(min(Result) as decimal (10,2)) as 'min',cast(max(Result) as decimal (10,2)) as 'max' FROM HOTSTBResult 
WHERE Result > 0 GROUP by Label, dmRAll ORDER by Label

select YEAR(StartDate) as 'Year', count(*)
FROM  HOTSTBResult res 
GROUP by YEAR(StartDate) 
ORDER by YEAR(StartDate) DESC
 
SELECT 'UHManoa ALOHA station(0-5m)Latitute=22.75N Longtitude=-158W' as 'UH Manoa', Count(*) as 'TBResult #rows' FROM HOTSTBResult

use whwq4
SELECT TOP (20) YEAR(StartDate) as 'Year',Label,dmRAll,Count(dmRAll) as 'rows',round(exp(avg(log(Result))),3) as '~gmean', round(stdev(Result),2) as 'stdev',cast(min(Result) as decimal (10,2)) as 'min', cast(max(Result) as decimal (10,2)) as 'max'  FROM  HOTSTBResult res WHERE Result > 0 AND dmRAll not in (6280,6350,6272) GROUP by Label,YEAR(StartDate),dmRAll ORDER by 4 desc
SELECT TOP (30) YEAR(StartDate) as 'Year',Label,dmRAll,Count(dmRAll) as 'rows',round(exp(avg(log(Result))),3) as '~gmean', round(stdev(Result),2) as 'stdev',cast(min(Result) as decimal (10,2)) as 'min', cast(max(Result) as decimal (10,2)) as 'max'  FROM  HOTSTBResult res WHERE Result > 0 AND dmRAll not in (6280,6350,6272) GROUP by Label,YEAR(StartDate),dmRAll ORDER by 4 desc

SELECT TOP (20) YEAR(StartDate) as 'Year',Label,dmRAll,Count(dmRAll) as 'rows',round(exp(avg(log(Result))),3) as '~gmean', 
round(stdev(Result),2) as 'stdev',cast(min(Result) as decimal (10,2)) as 'min', cast(max(Result) as decimal (10,2)) as 'max'  
FROM  HOTSTBResult res WHERE Result > 0
AND dmRAll  not in 
 (6280,6350,6272,6270) 
--(6280,6350,6272) 
--(6280,6350,6272,6270) 
GROUP by Label,YEAR(StartDate),dmRAll ORDER by 4 desc


AND dmRAll not in (6280,6350,6272)
--AND YEAR(StartDate) > 2009  OR YEAR(StartDate) < 1989 
, Label, YEAR(StartDate) DESC
 









DEVELOPMENT ONLY
--------------------
--------------------
--------------------
-- this data is already in TBResults style format but we need to get a TBSample
-- but figuring out common sample dates

/* dates */
SELECT * FROM HOTSRaw 
SELECT distinct(textdate),EsriDateTime,Analyte FROM HOTSRaw
order by EsriDateTime,Analyte
SELECT distinct(textdate),Analyte FROM HOTSRaw
order by textdate,Analyte
SELECT distinct(textdate) FROM HOTSRaw
order by textdate desc
----
SELECT distinct(textdate) FROM HOTSRaw
WHERE Analyte NOT IN ('Sali6350','Temp6280')
order by textdate desc
SELECT distinct(textdate) FROM HOTSRaw
WHERE Analyte     IN ('Sali6350','Temp6280')
order by textdate desc
----
SELECT COUNT(distinct(textdate)) FROM HOTSRaw
WHERE Analyte NOT IN ('Sali6350','Temp6280')
SELECT COUNT(distinct(textdate)) FROM HOTSRaw
WHERE Analyte     IN ('Sali6350','Temp6280')

SELECT COUNT(distinct(textdate)) FROM HOTSRaw
SELECT COUNT(textdate) FROM HOTSRaw
----
SELECT count(*) num,Analyte FROM HOTSRaw
GROUP BY Analyte
ORDER BY num DESC



SELECT COUNT(distinct(textdate)) FROM HOTSRaw
SELECT COUNT(textdate) FROM HOTSRaw

---SELECT distinct(Analyte), max(EsriDateTime),min(EsriDateTime) FROM HOTSRaw
----GROUP BY  Analyte, EsriDateTime bust
--ORDER BY EsriDateTime, max(EsriDateTime),min(EsriDateTime)

SELECT distinct(Analyte) FROM HOTSRaw
GROUP BY  Analyte
ORDER BY Analyte




------
-- these are the rows for TBSample
SELECT COUNT(distinct(textdate)) FROM HOTSRaw
SELECT distinct(textdate) td FROM HOTSRaw
ORDER BY td desc

use whwq4
--drop TABLE [dbo].[HOTSRaw_Intermediate]
CREATE TABLE [dbo].[HOTSRaw_Intermediate] (
	[pkSample] [nvarchar](255) NOT NULL,
	[fkIDLoc] [nvarchar](255)   NULL, -- allow all NULL while we build
	[fkStation] [nvarchar](255) NULL,
	[fkProject] [nvarchar](255) NULL,
	[fkUnqID] [nvarchar](255)   NULL,
	[fkOrg] [nvarchar](255)     NULL,
	[StartDate] [datetime2](7)  NULL,
	[EndDate] [datetime2](7)    NULL,
	[Comment] [nvarchar](255)   NULL,
) ON [PRIMARY]
GO
use whwq4
--delete from  HOTSRaw_Intermediate
INSERT INTO HOTSRaw_Intermediate
SELECT distinct(textdate) td,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL FROM HOTSRaw

select * from  HOTSRaw_Intermediate
select * from  HOTSRaw WHERE TextDate in ('052606','040513','022098','022604') order by textdate

UPDATE Table SET col1, col2
SELECT col1, col2 
FROM other_table 
WHERE sql = 'cool'
WHERE Table.id = other_table.id
line up cols


UPDATE HOTSRaw_Intermediate SET pkSample
SELECT '22_7500_Long158_ALOHAStation_UHManoa_Y88To16Monthly_D' + TextDate
from hotsraw
select * from HOTSRaw_Intermediate
,
fkIDLoc='HOTS',
fkProject = '22_7500_Long158_ALOHAStation_UHManoa_Y88To16Monthly_ChlA6250COxy6272NaNi6230OxyD6270pHyd6390Sali6350Sili6360TDNi6210Temp6280TPho6240'
,fkUnqID =newid(),
fkOrg = '22_7500_Long158_ALongtermOligotrophicHabitatAssessment_NorthPacificSubtropicalGyre_UHManoa_Y88To16Monthly'
,StartDate = EsriDateTime,
EndDate = EsriDateTime,
Comment = BottleID + ' ' + Analyte + ' ' + TextDate + ' ' + TextTime + ' ' + CAST(press_dbar as nvarchar)


select distinct(Analyte),textdate 
from hotsraw
group by textdate,Analyte
order by textdate

select AS [Mon DD, YY] from hotsraw
SELECT CONVERT(VARCHAR(12), CONVERT(date, EsriDateTime), 107) AS [Mon DD, YYYY]
from hotsraw

--INSERT INTO [dbo].[TBRESULT_HOTS] VALUES
 ('fkSample'
 ,'fkIDLoc'
 ,'fkUnqID'
 ,Result
 ,NULL
 ,NULL,NULL,NULL
 ,CAST(SUBSTRING(Analyte, 5, 4) as int)
 ,6462
 ,CAST(SUBSTRING(Analyte, 5, 4) as int)
 ,6370
 ,6430
 ,NULL
 ,Analyte + ' BottleID:' + BottleID
 ,
,NULL,NULL
,NULL,NULL
,NULL
,newid(), newid()
