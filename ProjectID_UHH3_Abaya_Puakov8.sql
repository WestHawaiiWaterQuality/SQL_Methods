-- create script for Abaya Puako Journal/Thesis
-- last update 4/27/2018
-

/*
Read data from LAbaya thesis found at:
Abaya, Leilani M. 2016. "Identifying Hotspots of Sewage Pollution in Coastal Areas with Coral Reefs.
"ProQuest Dissertations Publishing. https://search.proquest.com/docview/1825633770.
*/

/* Abaya Raw Create */
--  DROP table AbayaChemRaw
CREATE TABLE AbayaChemRaw(
   acrIID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
   Station      [int]           NOT NULL, -- 1-16

   NaNi6230     [numeric](38,8) NOT NULL,
   SENaNi6230   [numeric](38,8) NOT NULL, -- SE means standard error, table provides with each analyte
								 
   AmmN6220     [numeric](38,8) NOT NULL,
   SEAmmN6220   [numeric](38,8) NOT NULL,
								
   TDNi6210     [numeric](38,8) NOT NULL,
   SETDNi6210   [numeric](38,8) NOT NULL,
							 
   Phos6391     [numeric](38,8) NOT NULL,
   SEPhos6391   [numeric](38,8) NOT NULL,
								
   TPho6240     [numeric](38,8) NOT NULL,
   SETPho6240   [numeric](38,8) NOT NULL,
								
   H4Si6389     [numeric](38,8) NOT NULL,
   SEH4Si6389   [numeric](38,8) NOT NULL,
								
   Sali6350     [numeric](38,8) NOT NULL,
   SESali6350	[numeric](38,8) NOT NULL
)
/*
-- now use MSSMS to import the raw file from PacIOOS into this table
-- fields of import file editted like this
--"5"	"Table 3. Average ± SE and [range] of NO3- + NO2-, NH4+, TDN, PO43-, TPho6240, H4Si6389 concentrations (µmol/L), and salinity for
--shoreline stations at Puakō, Hawaiʻi. Superscript letters indicate significant groupings from One-way ANOVA and post-hoc
--Tukey’s tests. α = 0.05; n = 4.
-- Station       NO3- + NO2-          NH4+            TDN              PO43-            TPho6240             H4Si6389         Salinity
 
 --Station,NO3plusNO2,AmmN6220,TDN,Phos6391,TPho6240,H4Si6389,Salinity
*/
select * from AbayaChemRaw
/*
Station,NaNi6230,SENaNi6230,AmmN6220,SEAmmN6220,TDNi6210,SETDNi6210,Phos6391,SEPhos6391,TPho6240,SETPho6240,H4Si6389,SEH4Si6389,Sali6350,SESali6350
1,27.87,4.09,20.83,0.15,41,7,0.44,0.04,0.70,0.12,133,23,27.58,1.44
2,149.94,12.79,0.49,0.11,159,13,2.24,0.24,2.86,0.26,581,155,7.12,0.61
3,137.12,35.39,1.95,0.30,154,39,3.81,0.92,4.28,0.72,377,124,16.26,3.96
4,196.05,28.14,1.3,0.05,221,26,7.42,1.11,8.25,1.36,501,113,15.25,2.30
5,46.92,8.73,1.32,0.16,70,12,1.34,0.17,1.74,0.28,179,41,24.98,2.35
6,26.78,11.48,1.22,0.10,44,16,0.66,0.21,0.85,0.22,95,43,30.77,2.31
7,134.56,54.94,1.69,0.65,131,43,3.08,0.44,3.41,0.50,447,132,21.98,0.97
8,39.15,14.53,2.40,0.97,59,19,0.70,0.23,1.01,0.21,253,83,20.60,4.90
9,69.74,9.06,1.00,0.33,85,7,1.37,0.13,1.80,0.17,342,90,15.28,2.31
10,56.72,17.48,0.95,0.27,73,19,1.14,0.31,1.48,0.16,354,76,15.03,3.60
11,16.52,1.21,0.96,0.30,29,4,0.49,0.04,0.76,0.22,108,27,28.30,0.93
12,35.80,4.37,1.34,025,46,5,0.99,0.11,1.26,0.29,260,105,24.50,0.96
13,34.89,4.73,1.21,0.19,49,7,1.64,0.28,1.89,0.17,207,23,23.96,2.00
14,89.08,5.48,1.15,0.29,101,7,2.61,0.17,2.91,0.27,652,174,6.43,0.63
15,13.37,2.80,1.07,0.17,22,3,0.39,0.09,0.57,0.21,120,24,29.94,0.70
16,38.5,7.2,0.63,0.31,46,4,0.81,0.13,1.14,0.30,323,86,17.13,3.44
*/


---------------------------------------------------------
---------------------------------------------------------
---------------------------------------------------------
---------------------------------------------------------
---------------------------------------------------------
--  DROP table AbayaBioRaw
CREATE TABLE AbayaBioRaw (
  abrIID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
  Station        [int]            NOT NULL, -- also a PK

  Ecci6410	     [numeric](38, 8) NOT NULL,
  SEEcci6410     [numeric](38, 8) NOT NULL,

  Clos6420       [numeric](38, 8) NOT NULL,
  SEClos6420     [numeric](38, 8) NOT NULL,

  N15i6388       [numeric](38, 8) NOT NULL,
  SEN15i6388     [numeric](38, 8) NOT NULL,
)
/*
 --"2"	"Table 1. Average ± SE and [range] of Enterococcus (MPN/100 mL), C.
--perfringens (CFU/100 mL), and δ15N in macroalgal tissue (‰) for shoreline
--stations at Puakō, Hawaiʻi. Superscript letters indicate significant groupings
--from One-way ANOVA and post-hoc Tukey’s tests. α = 0.05; n = 4.
--                                       Clostridium
--   Station      Enterococcus           perfringens                   δ15N
*/

Biology Table
select * from AbayaBioRaw
/*
Station,Ecci6410,SEEcci6410,Clos6420,SEClos6420,N15i6388,SEN15i6388
1,18,8,2,1,6.38,0.15
2,74,25,2,1,7.54,0.18
3,349,162,5,2,10.55,0.15  
4,237,178,6,2,11.88,0.32  
5,1107,861,4,1,7.21,2.01  
6,1051,570,6,2,7.77,1.30  
7,170,32,12,5,8.35,0.74
8,738,603,7,1,5.48,0.37
9,216,120,3,0,4.79,0.53
10,122,30,5,1,4.54,0.70
11,315,107,8,3,6.02,0.30  
12,676,251,5,2,6.43,0.65
13,2777,1806,2,1,7.74,1.92
14,80,36,10,5,5.94,0.47
15,454,132,9,3,4.24,0.51
16,699,554,3,1,4.23,0.44
*/


/* development only
-- 2 rows per station, station name is either TOP or BOT
Select * from AbayaBioRaw
Select * from AbayaChemRaw
Select SUM(Ecci6410) FROM AbayaBioRaw
-- 9083.00000000
Select SUM(Clos6420) FROM AbayaBioRaw
-- 89.00000000
Select SUM(N15i6388) FROM AbayaBioRaw
-- 109.09000000
Select AVG(NaNi6230), SUM(NaNi6230) FROM AbayaChemRaw
-- 69.56312500	1113.01000000 
*/

SELECT chem.*, bio.*
FROM AbayaChemRaw chem, AbayaBioRaw bio
WHERE chem.station = bio.station
ORDER BY chem.station
/*
acrIID	Station	NaNi6230	SENaNi6230	AmmN6220	SEAmmN6220	TDNi6210	SETDNi6210	Phos6391	SEPhos6391	TPho6240	SETPho6240	H4Si6389	SEH4Si6389	Sali6350	SESali6350	abrIID	Station	Ecci6410	SEEcci6410	Clos6420	SEClos6420	N15i6388	SEN15i6388
1	1	27.87000000	4.09000000	20.83000000	0.15000000	41.00000000	7.00000000	0.44000000	0.04000000	0.70000000	0.12000000	133.00000000	23.00000000	27.58000000	1.44000000	1	1	18.00000000	8.00000000	2.00000000	1.00000000	6.38000000	0.15000000
2	2	149.94000000	12.79000000	0.49000000	0.11000000	159.00000000	13.00000000	2.24000000	0.24000000	2.86000000	0.26000000	581.00000000	155.00000000	7.12000000	0.61000000	2	2	74.00000000	25.00000000	2.00000000	1.00000000	7.54000000	0.18000000
3	3	137.12000000	35.39000000	1.95000000	0.30000000	154.00000000	39.00000000	3.81000000	0.92000000	4.28000000	0.72000000	377.00000000	124.00000000	16.26000000	3.96000000	3	3	349.00000000	162.00000000	5.00000000	2.00000000	10.55000000	0.15000000
4	4	196.05000000	28.14000000	1.30000000	0.05000000	221.00000000	26.00000000	7.42000000	1.11000000	8.25000000	1.36000000	501.00000000	113.00000000	15.25000000	2.30000000	4	4	237.00000000	178.00000000	6.00000000	2.00000000	11.88000000	0.32000000
5	5	46.92000000	8.73000000	1.32000000	0.16000000	70.00000000	12.00000000	1.34000000	0.17000000	1.74000000	0.28000000	179.00000000	41.00000000	24.98000000	2.35000000	5	5	1107.00000000	861.00000000	4.00000000	1.00000000	7.21000000	2.01000000
6	6	26.78000000	11.48000000	1.22000000	0.10000000	44.00000000	16.00000000	0.66000000	0.21000000	0.85000000	0.22000000	95.00000000	43.00000000	30.77000000	2.31000000	6	6	1051.00000000	570.00000000	6.00000000	2.00000000	7.77000000	1.30000000
7	7	134.56000000	54.94000000	1.69000000	0.65000000	131.00000000	43.00000000	3.08000000	0.44000000	3.41000000	0.50000000	447.00000000	132.00000000	21.98000000	0.97000000	7	7	170.00000000	32.00000000	12.00000000	5.00000000	8.35000000	0.74000000
8	8	39.15000000	14.53000000	2.40000000	0.97000000	59.00000000	19.00000000	0.70000000	0.23000000	1.01000000	0.21000000	253.00000000	83.00000000	20.60000000	4.90000000	8	8	738.00000000	603.00000000	7.00000000	1.00000000	5.48000000	0.37000000
9	9	69.74000000	9.06000000	1.00000000	0.33000000	85.00000000	7.00000000	1.37000000	0.13000000	1.80000000	0.17000000	342.00000000	90.00000000	15.28000000	2.31000000	9	9	216.00000000	120.00000000	3.00000000	0.00000000	4.79000000	0.53000000
10	10	56.72000000	17.48000000	0.95000000	0.27000000	73.00000000	19.00000000	1.14000000	0.31000000	1.48000000	0.16000000	354.00000000	76.00000000	15.03000000	3.60000000	10	10	122.00000000	30.00000000	5.00000000	1.00000000	4.54000000	0.70000000
11	11	16.52000000	1.21000000	0.96000000	0.30000000	29.00000000	4.00000000	0.49000000	0.04000000	0.76000000	0.22000000	108.00000000	27.00000000	28.30000000	0.93000000	11	11	315.00000000	107.00000000	8.00000000	3.00000000	6.02000000	0.30000000
12	12	35.80000000	4.37000000	1.34000000	25.00000000	46.00000000	5.00000000	0.99000000	0.11000000	1.26000000	0.29000000	260.00000000	105.00000000	24.50000000	0.96000000	12	12	676.00000000	251.00000000	5.00000000	2.00000000	6.43000000	0.65000000
13	13	34.89000000	4.73000000	1.21000000	0.19000000	49.00000000	7.00000000	1.64000000	0.28000000	1.89000000	0.17000000	207.00000000	23.00000000	23.96000000	2.00000000	13	13	2777.00000000	1806.00000000	2.00000000	1.00000000	7.74000000	1.92000000
14	14	89.08000000	5.48000000	1.15000000	0.29000000	101.00000000	7.00000000	2.61000000	0.17000000	2.91000000	0.27000000	652.00000000	174.00000000	6.43000000	0.63000000	14	14	80.00000000	36.00000000	10.00000000	5.00000000	5.94000000	0.47000000
15	15	13.37000000	2.80000000	1.07000000	0.17000000	22.00000000	3.00000000	0.39000000	0.09000000	0.57000000	0.21000000	120.00000000	24.00000000	29.94000000	0.70000000	15	15	454.00000000	132.00000000	9.00000000	3.00000000	4.24000000	0.51000000
16	16	38.50000000	7.20000000	0.63000000	0.31000000	46.00000000	4.00000000	0.81000000	0.13000000	1.14000000	0.30000000	323.00000000	86.00000000	17.13000000	3.44000000	16	16	699.00000000	554.00000000	3.00000000	1.00000000	4.23000000	0.44000000
*/


--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--  drop table AbayaRaw
Select * from AbayaBioRaw  
-- 16
Select * from AbayaChemRaw 
-- 16
-- I want to combine these Bio and Chem tables into one table AbayaRaw
-- to then perform processing to get into the table formats we need for the geodatabase scheme

---- this table has numeric data types ready for ArcGIS
-- set fields not null to force errors
--   DROP table AbayaRaw
CREATE TABLE AbayaRaw (
   Station         [int]             NOT NULL,
   StartDate       [datetime2](7)    NOT NULL,
   EndDate         [datetime2](7)    NOT NULL,
-- biology		   				    
   Ecci6410	       [numeric](38, 8)  NOT NULL,
   SEEcci6410      [numeric](38, 8)  NOT NULL,
   Clos6420        [numeric](38, 8)  NOT NULL,
   SEClos6420      [numeric](38, 8)  NOT NULL,
   N15i6388        [numeric](38, 8)  NOT NULL,
   SEN15i6388	   [numeric](38, 8)  NOT NULL, 

-- chemistry	   
   NaNi6230        [numeric](38,8)       NULL,
   SENaNi6230      [numeric](38,8)       NULL, -- SE means standard error, for each analyte

   AmmN6220        [numeric](38,8)       NULL,
   SEAmmN6220      [numeric](38,8)       NULL,

   TDNi6210        [numeric](38,8)       NULL,
   SETDNi6210      [numeric](38,8)       NULL,

   Phos6391        [numeric](38,8)       NULL,
   SEPhos6391      [numeric](38,8)       NULL,

   TPho6240        [numeric](38,8)       NULL,
   SETPho6240      [numeric](38,8)       NULL,

   H4Si6389        [numeric](38,8)       NULL,
   SEH4Si6389      [numeric](38,8)       NULL,

   Sali6350        [numeric](38,8)       NULL,
   SESali6350	   [numeric](38,8)       NULL,  

  -- new fields I added to needed to prepare for geodatbase and Esri
   MyCoreName      [nvarchar](255)        NULL,
   MyLabel         [nvarchar](255)        NULL,
   AnalyteList     [nvarchar](255)        NULL,

   MyLatLong       [nvarchar](255)        NULL,
   MyLatitude      [nvarchar](255)        NULL,
   POINT_Y         [float]                NULL,
   POINT_X         [float]                NULL,

   RawUniq         [uniqueidentifier] NOT NULL,

   acrIIDCopy      [int]                  NULL,
   abrIIDCopy      [int]              NOT NULL,

PRIMARY KEY (Station)
)
--
Select * from AbayaBioRaw  
-- 16
Select * from AbayaChemRaw 
-- 16


-----------------------------------------------------
-----------------------------------------------------
-----------------------------------------------------
-- absorb biologic values first
 
 --  delete from AbayaRaw
--  INSERT INTO AbayaRaw
SELECT 
Station,
'2014-11-01 06:00:00 AM',  -- i know she worked a low tide nearest to sunrise
'2015-07-31 06:00:00 AM',  -- so 6am is my best guess for this since the entire data set is a geomean over 9 months
Ecci6410, SEEcci6410, -- 3 pairs bio
Clos6420, SEClos6420,
N15i6388, SEN15i6388,
NULL,NULL, -- seven pairs of nulls for analytes from Chem
NULL,NULL,
NULL,NULL,
NULL,NULL,
NULL,NULL,
NULL,NULL,
NULL,NULL, --7
-- my fields
NULL,NULL,NULL, -- MyLabel,MyCoreName,AnalyteList
NULL,NULL,NULL,NULL, -- location fields all null here, geocoded values will update to these
newid(),
NULL, abrIID
FROM AbayaBioRaw
ORDER BY abrIID -- maintain order using iid
-- 16
select * from AbayaRaw

-- fill in the chemistry values matching on 1-16 station number
 UPDATE AbayaRaw
SET 
NaNi6230 = chem.NaNi6230, SENaNi6230 = chem.SENaNi6230,
AmmN6220 = chem.AmmN6220, SEAmmN6220 = chem.SEAmmN6220,
TDNi6210 = chem.TDNi6210, SETDNi6210 = chem.SETDNi6210,
Phos6391 = chem.Phos6391, SEPhos6391 = chem.SEPhos6391,
TPho6240 = chem.TPho6240, SETPho6240 = chem.SETPho6240,
H4Si6389 = chem.H4Si6389, SEH4Si6389 = chem.SEH4Si6389,
Sali6350 = chem.Sali6350, SESali6350 = chem.SESali6350,
acrIIDCopy = chem.acrIID
FROM AbayaChemRaw chem
WHERE AbayaRaw.Station = chem.Station
-- 16
select * from AbayaRaw
-- 16

/* development only
select sum(NaNi6230),avg(NaNi6230) from AbayaRaw
-- 1113.01000000	69.56312500
select sum(Sali6350),avg(Sali6350) from AbayaRaw
-- 325.11000000	20.31937500
select sum(Ecci6410),avg(Ecci6410) from AbayaRaw
-- 9083.00000000	567.68750000
*/

/*
select acrIIDCopy, abrIIDCopy
FROM AbayaRaw
WHERE acrIIDCopy = abrIIDCopy
-- 16 ok
select acrIIDCopy, abrIIDCopy
FROM AbayaRaw
WHERE acrIIDCopy != abrIIDCopy
-- 0 ok
*/

---------------------------------------------
---------------------------------------------
---------------------------------------------
-- my geocoding effort for each of the sixteen stations

UPDATE AbayaRaw SET MyLabel='LalamiloBungalo' , POINT_Y=19.98305, POINT_X=-155.82886 WHERE Station=16
UPDATE AbayaRaw SET MyLabel='LookoutSouth'    , POINT_Y=19.97620, POINT_X=-155.83135 WHERE Station=15
UPDATE AbayaRaw SET MyLabel='1610 PuakoBchDr' , POINT_Y=19.97279, POINT_X=-155.83727 WHERE Station=14
UPDATE AbayaRaw SET MyLabel='1642 PuakoBchDr' , POINT_Y=19.97338, POINT_X=-155.83873 WHERE Station=13
UPDATE AbayaRaw SET MyLabel='1666 PuakoBchDr' , POINT_Y=19.97270, POINT_X=-155.84044 WHERE Station=12
UPDATE AbayaRaw SET MyLabel='1688 PuakoBchDr' , POINT_Y=19.97145, POINT_X=-155.84278 WHERE Station=11
UPDATE AbayaRaw SET MyLabel='1708 PuakoBchDr' , POINT_Y=19.97038, POINT_X=-155.84368 WHERE Station=10
-- matches to CWB station #1222
-- 19.96901, -155.84537
UPDATE AbayaRaw SET MyLabel='1736 PuakoBchDr' , POINT_Y=19.96901, POINT_X=-155.84537 WHERE Station=09
UPDATE AbayaRaw SET MyLabel='1778 PuakoBchDr' , POINT_Y=19.96804, POINT_X=-155.84752 WHERE Station=08
UPDATE AbayaRaw SET MyLabel='1836 PuakoBchDr' , POINT_Y=19.96681, POINT_X=-155.85230 WHERE Station=07
UPDATE AbayaRaw SET MyLabel='1874 PuakoBchDr' , POINT_Y=19.96546, POINT_X=-155.85453 WHERE Station=06
UPDATE AbayaRaw SET MyLabel='1890 PuakoBchDr' , POINT_Y=19.96403, POINT_X=-155.85561 WHERE Station=05
UPDATE AbayaRaw SET MyLabel='1914 PuakoBchDr' , POINT_Y=19.96261, POINT_X=-155.85625 WHERE Station=04
UPDATE AbayaRaw SET MyLabel='1952 PuakoBchDr' , POINT_Y=19.96056, POINT_X=-155.85775 WHERE Station=03
UPDATE AbayaRaw SET MyLabel='1964 PuakoBchDr' , POINT_Y=19.95894, POINT_X=-155.85829 WHERE Station=02
UPDATE AbayaRaw SET MyLabel='2014 PuakoBchDr' , POINT_Y=19.95761, POINT_X=-155.85833 WHERE Station=01
---------------------------------------------------
---------------------------------------------------
---------------------------------------------------
--
-- put together lat/long fields now that have POINTs
 UPDATE AbayaRaw SET
MyLatLong  = str(POINT_Y, 7, 4) + ' , ' + str(POINT_X, 9, 4),
MyLatitude = CAST( REPLACE( str( CAST(POINT_Y AS DECIMAL (7,4)),7,4),'.','_') AS varchar)
select * from AbayaRaw


-- 
-- now the final name assembly
/*
Station,NaNi6230,SENaNi6230,AmmN6220,SEAmmN6220,TDNi6210,SETDNi6210,Phos6391,SEPhos6391,TPho6240,SETPho6240,H4Si6389,SEH4Si6389,Sali6350,SESali6350
Puako_LAbaya_UHHilo_
YNov14ToJul15Gmean_
TLowTideSunrise_
NaNi6230AmmN6220TDNi6210TPho6240H4Si6389Sali6350Ecci6410Clos6420N15i6388
*/

-- make core name and apply analyte list, LAbaya did all analytes at all stations so don't have to
-- figure out like other data sets
UPDATE AbayaRaw SET 
MyCoreName = MyLatitude + '_' + MyLabel + '_LAbayaUHilo_Y4xNov2014ToJul15GMean_TLowTideSunrise_' +
             'Station' + LTRIM(str(Station,2)) + 'Of16',
AnalyteList = 'NaNi6230AmmN6220TDNi6210TPho6240H4Si6389Sali6350Ecci6410Clos6420N15i6388'
-- 16

select MyCoreName from AbayaRaw


--select MyCoreName,AnalyteList from AbayaRaw
select * from AbayaRaw
--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- make the dates unique by adding a few seconds
DECLARE @RawUniq uniqueidentifier, @StartDate datetime2, @EndDate datetime2, @RowCount integer=0
DECLARE @cursorInsert CURSOR SET @cursorInsert = CURSOR FOR
   SELECT RawUniq, StartDate, EndDate FROM AbayaRaw
OPEN @cursorInsert
FETCH NEXT FROM @cursorInsert INTO @RawUniq, @StartDate, @EndDate
--
WHILE @@FETCH_STATUS = 0
   BEGIN
   set @RowCount = @RowCount + 1
   UPDATE AbayaRaw 
   SET StartDate = DATEADD(ss,@RowCount,StartDate),EndDate = DATEADD(ss,@RowCount,EndDate)
   WHERE AbayaRaw.RawUniq IN (SELECT @RawUniq FROM AbayaRaw)
   FETCH NEXT FROM @cursorInsert INTO @RawUniq, @StartDate, @EndDate
   END
CLOSE @cursorInsert
DEALLOCATE @cursorInsert
--
select StartDate,EndDate from AbayaRaw

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--  DROP  TABLE AbayaFCStation
CREATE TABLE AbayaFCStation (
	--[OBJECTID] [int] NOT NULL,
	--[Shape] [geometry] NULL,
	--[GDB_GEOMATTR_DATA] [varbinary](max) NULL,

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

--
select * from AbayaFCStation
--
--    delete from AbayaFCStation
-- INSERT INTO AbayaFCStation 
SELECT 
MyCoreName + '_001m',                    -- pkStation
LTRIM(str(Station,2)) + '.' + MyLabel,   -- Label
'Chem Table3Page27,Bio Table1Page25',    -- TablePage
Station,                                 -- fkStation1
NULL,                                    -- fkStation2
1,           -- mShore, 1 meter from shore is my assumption and above in pkStation
3499,        -- dmStA not applicable here
6410,        -- dmStAA - Puako Bay is called out in the law in a list that matches this domain
3740,        -- dmStBott - Puako is called out as special bottom classification
7110,        -- dmStClas classAA

4650,        -- dmAccuracy, I did all geocoding, doc said they used a GPS but not provided in journal
8810,        -- dmStReef Puako is called out and have this special number in domain
7777,        -- dmStRule, does not apply here
444,         -- dmStType, journal
NULL,NULL,   -- fkEPA, fkUSGS
'Yes',       -- embayment - Puako Bay
NULL,NULL,   -- VolueBay,CrossArea
REPLACE(MyLatitude,'_',''), -- AttachSt
NULL,NULL,NULL,NULL,MyLatLong,NULL,NULL, -- dmAccu4610-4670, I did all geocode, just place in right field
StartDate,EndDate,
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
FROM AbayaRaw
ORDER BY Station
-- 16 rows
select * from AbayaFCStation
-- 16

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- FCStation complete and many preparations compete, move to insert data from AbayaRaw and other tables
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- Now work on the TBSample table
-- the pkStation name pieces are available to include fully formed names
-- there are xx sample, with up to 7 analytes recorded per sample

--   DROP TABLE AbayaTBSample
CREATE TABLE AbayaTBSample (
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

select * from AbayaRaw

--   DELETE FROM AbayaTBSample
--  INSERT INTO AbayaTBSample
SELECT 
MyCoreName + '_' + AnalyteList,
MyLabel,                -- LabelName
'Chem Table3Page27,Bio Table1Page25',  -- TablePage 
-99,                     -- AlertTrue
'UHHilo',                -- fkIDLoc
0,                       -- Transect no info abt
1,                       -- mShore=1
MyCoreName + '_001m',    -- same as into FCStation pkStation
Station,                 -- fkStation2, station as known to Abaya
'UHHilo',
newid(),                 -- fkUniqID is the new if generated in this new row creation of the insert
'<<fkOrg>>',             -- *** GET ****
1420,                    -- dmSample, laboratory
StartDate, 
EndDate,                 -- 
'Yes',                   --  TimeMissg field
NULL,NULL,               -- Medium, CompStat
NULL,                    -- no Comment yet
REPLACE(MyLatitude,'_',''), -- attach code
NULL,NULL,NULL,NULL,NULL,   -- 5 extras
0,0,0,1,NULL,               -- cartography fields
newid(),
RawUniq                     -- important for tracing to save source row id
FROM AbayaRaw
ORDER BY (MyCoreName + '_' + AnalyteList)
-- 16 rows affected
select * from AbayaTBSample
-- 16
-----------------------
-----------------------



/*
select A_sta.*, B_samp.*
from AbayaFCStation A_sta
INNER JOIN AbayaTBSample B_samp ON
A_sta.pkStation = B_samp.fkStation
-- 16
select A_sta.*, B_samp.*
from AbayaFCStation A_sta
full outer JOIN AbayaTBSample B_samp ON
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
-- move to populate AbayaTBResult

--   DROP TABLE AbayaTBResult
CREATE TABLE AbayaTBResult (
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

  PRIMARY KEY (fkSample,dmRAll)-- per my schema in gdb
)
GO


-- designed to run from here, grab entire set of next 10 TBResult inserts and exec
--  delete from AbayaTBResult
--------------------------------------------------------------------------------
 -- 1/10
INSERT INTO AbayaTBResult
SELECT 
samp.pkSample,
'Ecci6410 - Enterococci',
samp.fkIDLoc,
samp.fkUnqID,
Ecci6410,
SEEcci6410,
6410,
6465,--dmRAMethod
6310,
6370,
6410,
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL, NULL,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM AbayaRaw raw, AbayaTBSample samp
WHERE raw.Station = samp.fkStation2 and Ecci6410 IS NOT NULL
ORDER BY raw.Station
-- 16
--select * from AbayaTBResult
--------------------------------------------------------------------------------
--2  
INSERT INTO AbayaTBResult
SELECT 
samp.pkSample,
'Clos6420 - Clostridium perfringens',
samp.fkIDLoc,
samp.fkUnqID,
Clos6420,
SEClos6420,
6420,
6465,--dmRAMethod
6310,
6370,
6420,
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL, NULL,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM AbayaRaw raw, AbayaTBSample samp
WHERE raw.Station = samp.fkStation2 and Clos6420 IS NOT NULL
ORDER BY raw.Station
-- 16
--select * from AbayaTBResult
--------------------------------------------------------------------------------
--3  
INSERT INTO AbayaTBResult
SELECT 
samp.pkSample,
'N15i6388 - 15N',
samp.fkIDLoc,
samp.fkUnqID,
N15i6388,
SEN15i6388,
6388,
6465,--dmRAMethod
6310,
6388,
6430,
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL, NULL,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM AbayaRaw raw, AbayaTBSample samp
WHERE raw.Station = samp.fkStation2 and N15i6388 IS NOT NULL
ORDER BY raw.Station
-- 16
-- select * from AbayaTBResult order by dmRAll
--------------------------------------------------------------------------------
--4  
INSERT INTO AbayaTBResult
SELECT 
samp.pkSample,
'NaNi6230 - Nitrate+Nitrite Nitrogen',
samp.fkIDLoc,
samp.fkUnqID,
NaNi6230,
SENaNi6230,
6230,
6465,--dmRAMethod
6230,
6370,
6430,
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NaNi6230, -- save here since we need to convert from micromoles yet
NULL,NULL,NULL, NULL,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM AbayaRaw raw, AbayaTBSample samp
WHERE raw.Station = samp.fkStation2 and NaNi6230 IS NOT NULL
ORDER BY raw.Station
-- 16
-- select * from AbayaTBResult order by dmRAll
--------------------------------------------------------------------------------
--5  
INSERT INTO AbayaTBResult
SELECT 
samp.pkSample,
'Ammn6220 - Ammonia Nitrogen',
samp.fkIDLoc,
samp.fkUnqID,
Ammn6220,
SEAmmn6220,
6220,
6465,--dmRAMethod
6220,
6370,
6430,
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
Ammn6220, -- save here since we need to convert from micromoles yet
NULL,NULL,NULL, NULL,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM AbayaRaw raw, AbayaTBSample samp
WHERE raw.Station = samp.fkStation2 and Ammn6220 IS NOT NULL
ORDER BY raw.Station
-- 16
-- select * from AbayaTBResult order by dmRAll
--------------------------------------------------------------------------------
--6  
INSERT INTO AbayaTBResult
SELECT 
samp.pkSample,
'TDNi6210 - Total Nitrogen',
samp.fkIDLoc,
samp.fkUnqID,
TDNi6210,
SETDNi6210,
6210,
6465,--dmRAMethod
6210,
6370,
6430,
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
TDNi6210, -- save here since we need to convert from micromoles yet
NULL,NULL,NULL, NULL,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM AbayaRaw raw, AbayaTBSample samp
WHERE raw.Station = samp.fkStation2 and TDNi6210 IS NOT NULL
ORDER BY raw.Station
-- 16
-- select * from AbayaTBResult order by dmRAll
--------------------------------------------------------------------------------
--7  
INSERT INTO AbayaTBResult
SELECT 
samp.pkSample,
'Phos6391 - Phosphorus PO4',
samp.fkIDLoc,
samp.fkUnqID,
Phos6391,
SEPhos6391,
6391,
6465,--dmRAMethod
6310,
6391,
6430,
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
Phos6391, -- save here since we need to convert from micromoles yet
NULL,NULL,NULL, NULL,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM AbayaRaw raw, AbayaTBSample samp
WHERE raw.Station = samp.fkStation2 and Phos6391 IS NOT NULL
ORDER BY raw.Station
-- 16
select sum(Phos6391) FROM AbayaRaw raw
WHERE raw.Phos6391 IS NOT NULL
select sum(Result) FROM AbayaTBResult
WHERE dmRall = 6391
--29.13000000  both
-- select * from AbayaTBResult order by dmRAll
--------------------------------------------------------------------------------
--8  
INSERT INTO AbayaTBResult
SELECT 
samp.pkSample,
'TPho6240 - Total Phosphorus',
samp.fkIDLoc,
samp.fkUnqID,
TPho6240,
SETPho6240,
6240,
6465,--dmRAMethod
6240,
6370,
6430,
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
TPho6240, -- save here since we need to convert from micromoles yet
NULL,NULL,NULL, NULL,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM AbayaRaw raw, AbayaTBSample samp
WHERE raw.Station = samp.fkStation2 and TPho6240 IS NOT NULL
ORDER BY raw.Station
-- 16
-- select * from AbayaTBResult order by dmRAll
--------------------------------------------------------------------------------
--9  
INSERT INTO AbayaTBResult
SELECT 
samp.pkSample,
'H4Si6389 - H4Sio4 Silicic Acid',
samp.fkIDLoc,
samp.fkUnqID,
H4Si6389,
SEH4Si6389,
6389,
6465,--dmRAMethod
6310,
6389,
6430,
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
H4Si6389, -- save here since we need to convert from micromoles yet
NULL,NULL,NULL, NULL,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM AbayaRaw raw, AbayaTBSample samp
WHERE raw.Station = samp.fkStation2 and H4Si6389 IS NOT NULL
ORDER BY raw.Station
-- 16
-- select * from AbayaTBResult order by dmRAll
--------------------------------------------------------------------------------
--10  
INSERT INTO AbayaTBResult
SELECT 
samp.pkSample,
'Sali6350 - Salinity',
samp.fkIDLoc,
samp.fkUnqID,
Sali6350,
SESali6350,
6350,
6465,--dmRAMethod
6310,
6350,
6430,
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
Sali6350, -- save here since we need to convert from micromoles yet
NULL,NULL,NULL, NULL,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM AbayaRaw raw, AbayaTBSample samp
WHERE raw.Station = samp.fkStation2 and Sali6350 IS NOT NULL
ORDER BY raw.Station
-- 16


-- V1 thesis map displays
SELECT Count(*) as 'TBResult Count' FROM AbayaTBResult
SELECT Label, Count(dmRAll) as 'TBResult rows' FROM AbayaTBResult GROUP by Label, dmRAll ORDER by 2 DESC
-- 16

-- V2 thesis map displays
SELECT 'Puako Nov2014-July2015' as 'L.Abaya', Count(*) as 'TBResult #rows' FROM AbayaTBResult;
SELECT Label, Count(dmRAll) as '#rows', round(exp(avg(log(Result))),3) as '~gmean', round(stdev(Result),2) as 'stdev',cast(min(Result) as decimal (10,2)) 
as 'min',cast(max(Result) as decimal (10,2)) as 'max' FROM AbayaTBResult 
WHERE Result<>0 GROUP by Label, dmRAll ORDER by Label


-- select * from AbayaTBResult order by dmRAll
SELECT COUNT(*) FROM AbayaTBResult
-- 160 rows! 10 analytes x 16 stations
SELECT * FROM AbayaTBResult

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
/*
select r.*, s.* 
From AbayaTBResult r
inner join AbayaTBSample  s
ON r.fkUnqID = s.fkUnqID
-- 160
select s.*, r.* 
From AbayaTBSample s
inner join  AbayaTBResult r
ON s.fkUnqID = r.fkUnqID
-- 160 as expect for inner join

select r.*, s.* 
From AbayaTBResult r
left join AbayaTBSample  s
ON r.fkUnqID = s.fkUnqID
-- 160

--select pkStation, fkSample, r.label
select s.*,r.*
From AbayaTBSample s
left join  AbayaTBResult r
ON r.fkUnqID = NULL
-- DON LOOK
select * from AbayaTBResult where fkUnqID is null
select * from AbayaTBSample where fkUnqID is null
select count(*) from AbayaTBSample
select count(*) from AbayaTBResult

select r.*, s.* 
From AbayaTBResult r
right join AbayaTBSample  s
ON r.fkUnqID = s.fkUnqID
-- 160
select pkStation, fkSample, r.label
From AbayaTBSample s
right join  AbayaTBResult r
ON s.fkUnqID = NULL
-- 160

select r.*, s.* 
From AbayaTBResult r
full outer join AbayaTBSample  s
ON r.fkUnqID = s.fkUnqID
-- 160
select s.*, r.* 
From AbayaTBSample s
full outer join  AbayaTBResult r
ON s.fkUnqID = r.fkUnqID
-- 160

----
select r.*, s.* 
From AbayaTBResult r
full outer join AbayaTBSample  s
ON s.fkUnqID = r.fkUnqID
WHERE r.fkUnqID IS NULL OR s.fkUnqID IS NULL
-- 0
select s.*, r.* 
From AbayaTBSample s
full outer join  AbayaTBResult r
ON s.fkUnqID = r.fkUnqID
WHERE s.fkUnqID IS NULL OR r.fkUnqID IS NULL
-- 0

-