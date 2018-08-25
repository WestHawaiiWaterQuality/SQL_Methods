-- create script for Waiakailio 
-- last update 04/02/2018


use whwq4
-

/*
DRAFT ENVIRONMENTAL ASSESSMENT
Kohala Shoreline, LLC Project June 2015
FileName: 2015-07-08-HA-DEA-Kohala-Shoreline-LLC-Project.pdf from State of Hawaii archives
Project Name: Kohala Shoreline, LLC Project
Applicant: Kohala Shoreline, LLC c/o Carlsmith Ball 121 Waianuenue Avenue Hilo HI 96720
Consultant: Geometrician Associates PO Box 396 Hilo HI 96721 Ron Terry 808-969-7090

*/

/* Waiakailio R Source to extract Table2. The PDF file came from the State of Hawaii archive website (can just google pdf name)
# WaiakailioBay/Kohala EIS with water values in Table2, 
# RStudio 1.0.153 "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/604.5.6 (KHTML, like Gecko)"
# +Install pdftools Package v1.5 "Text Extraction and Converting of PDF Documents"
pdf_file <- "~/Dropbox/WestHawaiiWaterQuality/Data/20_0747_WaiakailioBayKohala_EIS/2015-07-08-HA-DEA-Kohala-Shoreline-LLC-Project.pdf"
# pull in PDF
text <- pdf_text(pdf_file)
# parse file for table2
chemData <- grep("TABLE 2. Water chemistry", text) # three transects in ug/L
cat(text[chemData])
# write to text file with tab separators
write.table(text[chemData], "~/Dropbox/WestHawaiiWaterQuality/Data/20_0747_WaiakailioBayKohala_EIS/2015-07-08-HA-DEA-Kohala-Shoreline-LLC-ProjectTable2ChemData2.txt",  sep="\t")
This file was renamed and editted for import, final file: ImportToSQLTable2_Final.txt
*/

/*
"1"	"TABLE 2. Water chemistry measurements (in Î¼g/L at three locations off of the Kohala coastline collected December 17, 2009 as part of
the Kohala Shoreline LLC project. DFS=distance from shore, BDL= below detection limit.
                          DFS     DEPTH PO4       NO3-      NH4+      Si     TOP      TON        TP       TN    TURB SALINITY CHL a TEMP      O2      pH
TRANSECT                  (m)      (ft) (Î¼g/L)     (Î¼g/L)   (Î¼g/L)    (Î¼g/L) (Î¼g/L)    (Î¼g/L)   (Î¼g/L)   (Î¼g/L) (NTU) (o/oo) (Î¼g/L) (deg.C) (%sat.)
*/
--  DROP TABLE WaiakailioRawVarChars
CREATE TABLE WaiakailioRawVarChars (
    WaiIID INT NOT NULL IDENTITY(1,1) PRIMARY KEY, -- field I added
	[Transect] [nvarchar](255) NULL,
	[mShore] [nvarchar](255) NULL,
	[PO4] [nvarchar](255) NULL,          -- PO436396
	[NO3] [nvarchar](255) NULL,			 -- Nate6393
	[NH4] [nvarchar](255) NULL,			 -- AmmN6220
	[Si] [nvarchar](255) NULL,			 -- Sili6360
	[TOPh] [nvarchar](255) NULL,		 -- DOgP6368
	[TON] [nvarchar](255) NULL,			 -- DOgN6369
	[TP] [nvarchar](255) NULL,			 -- TPho6240
	[TN] [nvarchar](255) NULL,			 -- TDNi6210
	[TURB] [nvarchar](255) NULL,		 -- Turb6260
	[SALINITY] [nvarchar](255) NULL,	 -- Sali6350
	[CHLa] [nvarchar](255) NULL,		 -- ChlA6250
	[TEMP] [nvarchar](255) NULL,		 -- Temp6280
	[O2] [nvarchar](255) NULL,			 -- OxyS6367
	[pH] [nvarchar](255) NULL			 -- pHyd6390
)
GO

select * from WaiakailioRawVarChars
UPDATE WaiakailioRawVarChars SET PO4     	= NULL WHERE PO4       = 'NULL'--0
UPDATE WaiakailioRawVarChars SET NO3     	= NULL WHERE NO3       = 'NULL'--0
UPDATE WaiakailioRawVarChars SET NH4     	= NULL WHERE NH4       = 'NULL'--1
UPDATE WaiakailioRawVarChars SET Si      	= NULL WHERE Si        = 'NULL'--0 all rest zero, only one in NH4
UPDATE WaiakailioRawVarChars SET TOPh    	= NULL WHERE TOPh      = 'NULL'
UPDATE WaiakailioRawVarChars SET TON     	= NULL WHERE TON       = 'NULL'
UPDATE WaiakailioRawVarChars SET TP      	= NULL WHERE TP        = 'NULL'
UPDATE WaiakailioRawVarChars SET TN      	= NULL WHERE TN        = 'NULL'
UPDATE WaiakailioRawVarChars SET TURB    	= NULL WHERE TURB      = 'NULL'
UPDATE WaiakailioRawVarChars SET SALINITY	= NULL WHERE SALINITY  = 'NULL'
UPDATE WaiakailioRawVarChars SET CHLa    	= NULL WHERE CHLa      = 'NULL'
UPDATE WaiakailioRawVarChars SET TEMP    	= NULL WHERE TEMP      = 'NULL'
UPDATE WaiakailioRawVarChars SET O2      	= NULL WHERE O2        = 'NULL'
UPDATE WaiakailioRawVarChars SET pH         = NULL WHERE pH        = 'NULL'
select * from WaiakailioRawVarChars ORDER BY WaiIID
/*
WaiIID	Transect	mShore	PO4	NO3	NH4	Si	TOPh	TON	TP	TN	TURB	SALINITY	CHLa	TEMP	O2	pH
1	1	0	1.24	1.68	11.90	137.7	10.54	156.2	11.78	169.8	0.49	34.557	0.50	25.35	97.40	8.18
2	1	1	0.62	3.08	4.76	128.4	9.30	134.7	9.92	142.5	0.65	34.549	0.24	25.46	99.43	8.19
3	1	2	0.93	0.70	1.96	135.7	8.99	112.6	9.92	115.2	0.20	34.543	0.14	25.48	99.34	8.21
4	1	3	1.24	3.92	3.22	128.7	8.68	113.0	9.92	120.1	0.25	34.594	0.12	25.53	100.23	8.16
5	1	4	1.55	2.66	0.84	99.8	9.92	133.1	11.47	136.6	0.19	34.575	0.09	25.51	100.53	8.17
6	1	5	1.86	7.42	6.30	150.6	10.85	164.6	12.71	178.4	0.24	34.576	0.09	25.53	99.53	8.16
7	1	10	1.86	7.28	4.34	145.8	10.54	146.2	12.40	157.8	0.28	34.601	0.09	25.56	99.34	8.16
8	1	50	3.41	4.62	NULL	118.3	9.92	139.6	13.33	144.2	0.18	34.626	0.07	25.58	100.32	8.16
9	1	100	1.86	0.28	0.70	84.30	9.61	125.2	11.47	126.1	0.14	34.653	0.06	25.59	101.23	8.20
10	1	200	1.55	0.14	2.10	43.84	9.92	117.0	11.47	119.3	0.09	34.647	0.03	25.61	100.34	8.24
11	2	0	1.24	290.1	0.70	5101.8	15.81	174.7	17.05	465.5	0.27	27.474	0.17	24.99	95.34	8.29
12	2	1	1.24	144.2	7.28	2606.8	10.85	183.3	12.09	334.7	0.42	31.148	0.20	25.28	97.34	8.29
13	2	2	1.86	20.16	5.60	518.7	10.54	131.3	12.40	157.1	0.40	34.050	0.24	25.43	98.34	8.18
14	2	3	3.72	7.84	1.54	243.6	10.23	131.0	13.95	140.4	0.48	34.468	0.05	25.49	99.84	8.09
15	2	4	4.03	1.54	2.94	122.5	9.30	123.9	13.33	128.4	0.26	34.601	0.06	25.53	99.98	8.20
16	2	5	1.24	0.98	5.32	119.7	8.99	116.2	10.23	122.5	0.23	34.607	0.03	25.53	99.76	8.19
17	2	10	0.62	0.42	1.68	52.83	8.99	128.7	9.61	130.8	0.08	34.655	0.02	25.76	100.23	8.20
18	2	50	1.24	0.70	0.28	49.46	8.68	115.5	9.92	116.5	0.08	34.656	0.05	25.67	101.24	8.14
19	2	100	0.93	0.42	0.84	46.93	8.37	105.6	9.30	106.8	0.08	34.662	0.03	25.68	101.23	8.20
20	2	200	1.55	0.14	0.70	43.56	7.75	104.4	9.30	105.3	0.09	34.646	0.03	25.59	101.24	8.24
21	3	0	3.72	49.56	3.22	800.6	8.68	107.4	12.40	160.2	1.11	33.927	0.17	25.27	96.34	8.24
22	3	1	1.55	48.44	11.06	742.1	8.68	131.7	10.23	191.2	0.75	33.979	0.14	25.29	97.83	8.25
23	3	2	2.79	45.50	0.98	748.3	8.37	88.76	11.16	135.2	0.68	33.970	0.18	25.31	99.82	8.17
24	3	3	1.86	19.60	2.24	400.7	7.75	120.4	9.61	142.2	0.84	34.418	0.12	25.45	99.10	8.19
25	3	4	2.79	10.78	5.04	268.4	8.37	121.5	11.16	137.3	0.55	34.499	0.12	25.49	99.39	8.20
26	3	5	1.55	5.60	6.02	125.9	8.37	113.3	9.92	124.9	0.25	34.607	0.09	25.53	100.20	8.05
27	3	10	1.55	4.48	3.78	108.2	7.75	87.50	9.30	95.7	60.24	34.629	0.08	25.57	100.35	8.05
28	3	50	3.10	3.78	5.74	56.20	8.99	93.52	12.09	103.0	0.09	34.664	0.10	25.58	101.24	8.06
29	3	100	3.72	0.28	2.24	63.23	7.75	121.10	11.47	123.6	0.11	34.655	0.04	25.57	100.23	8.08
30	3	200	1.86	0.28	0.70	43.84	7.13	108.1	8.99	109.1	0.08	34.666	0.03	25.45	101.32	8.24
*/



-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- my working table
--  DROP TABLE WaiakailioRaw
CREATE TABLE WaiakailioRaw (
   Transect  [int]            NOT NULL, -- pk+
   mShore    [int]            NOT NULL, -- pk

   PO436396  [numeric](38,8)  NOT NULL,  --PO4
   Nate6393  [numeric](38,8)  NOT NULL,  --NO3 
   AmmN6220  [numeric](38,8)      NULL,  --NH4 only one NULL in column
   Sili6360  [numeric](38,8)  NOT NULL,  --Si 
   DOgP6368  [numeric](38,8)  NOT NULL,  --TOPh
   DOgN6369  [numeric](38,8)  NOT NULL,  --TON
   TPho6240  [numeric](38,8)  NOT NULL,  --TP 
   TDNi6210  [numeric](38,8)  NOT NULL,  --TN
   Turb6260  [numeric](38,8)  NOT NULL,  --TURB
   Sali6350  [numeric](38,8)  NOT NULL,  --SALINITY
   ChlA6250  [numeric](38,8)  NOT NULL,  --CHLa
   Temp6280  [numeric](38,8)  NOT NULL,	-- TEMP
   OxyS6367  [numeric](38,8)  NOT NULL,  --O2
   pHyd6390  [numeric](38,8)  NOT NULL,  --pH

   WaiIID    [int]            NOT NULL,

  -- new fields I added to needed to prepare for geodatbase and Esri
   MyCoreName      [nvarchar](255)        NULL,
   MyLabel         [nvarchar](255)        NULL,
   AnalyteList     [nvarchar](255)        NULL,
   TablePage       [nvarchar](255)        NULL,
   fkStation1      [nvarchar](255)        NULL,
   Embayment       [nvarchar](255)        NULL,

   StartDate       [datetime2](7)         NULL,
   EndDate         [datetime2](7)         NULL,

   MyLatLong       [nvarchar](255)        NULL,
   MyLatitude      [nvarchar](255)        NULL,
   POINT_Y         [numeric](38,8)        NULL,
   POINT_X         [numeric](38,8)        NULL,

   RawUniq         [uniqueidentifier] NOT NULL,

PRIMARY KEY (Transect,mShore)
)
--
--Select * from WaiakailioRaw  
select * from WaiakailioRawVarChars
-- 
--    delete from WaiakailioRaw
--  INSERT INTO WaiakailioRaw
SELECT 
CAST(Transect as int),
CAST(mShore as int),
CAST(PO4       as numeric(38,8)),--1
CAST(NO3       as numeric(38,8)),
CAST(NH4       as numeric(38,8)),
CAST(Si        as numeric(38,8)),
CAST(TOPh      as numeric(38,8)),--5
CAST(TON       as numeric(38,8)),
CAST(TP        as numeric(38,8)),
CAST(TN        as numeric(38,8)),
CAST(TURB      as numeric(38,8)),
CAST(SALINITY  as numeric(38,8)),--10
CAST(CHLa      as numeric(38,8)),
CAST(TEMP      as numeric(38,8)),
CAST(O2        as numeric(38,8)),
CAST(pH        as numeric(38,8)),--14
WaiIID,
NULL,NULL,NULL,NULL, -- MyCoreName, MyLabel, AnalyteList,TablePage,
NULL,NULL,           -- fkStation1,Embayment
NULL,NULL,           -- StartDate,EndDate
NULL,NULL,NULL,NULL, -- location fields all null here, geocoded values will update to these next
newid()
FROM WaiakailioRawVarChars
ORDER BY WaiIID
-- 30 rows copied
select * from WaiakailioRaw
--  30

SELECT * FROM WaiakailioRawVarChars
select * from WaiakailioRaw


---------------------------------------------
select distinct(Transect), mShore FROM WaiakailioRaw GROUP BY Transect,mShore ORDER BY Transect,mShore
/*
Transect	mShore
1	0
1	1
1	2
1	3
1	4
1	5
1	10
1	50
1	100
1	200
2	0
2	1
2	2
2	3
2	4
2	5
2	10
2	50
2	100
2	200
3	0
3	1
3	2
3	3
3	4
3	5
3	10
3	50
3	100
3	200
*/
select * from WaiakailioRaw

---------------------------------------------
---------------------------------------------

-- my geocoding effort for each of the stations on the 3 transects
-- set the Y,X based on (Figure -2-, page141)(Figure 3, page 143)

UPDATE WaiakailioRaw SET POINT_Y=20.07464, POINT_X=-155.85945  WHERE  Transect=1 AND mShore=000
UPDATE WaiakailioRaw SET POINT_Y=20.07464, POINT_X=-155.85945  WHERE  Transect=1 AND mShore=001
UPDATE WaiakailioRaw SET POINT_Y=20.07465, POINT_X=-155.85943  WHERE  Transect=1 AND mShore=002
UPDATE WaiakailioRaw SET POINT_Y=20.07464, POINT_X=-155.85944  WHERE  Transect=1 AND mShore=003
UPDATE WaiakailioRaw SET POINT_Y=20.07463, POINT_X=-155.85946  WHERE  Transect=1 AND mShore=004
UPDATE WaiakailioRaw SET POINT_Y=20.07460, POINT_X=-155.85952  WHERE  Transect=1 AND mShore=005
UPDATE WaiakailioRaw SET POINT_Y=20.07460, POINT_X=-155.85952  WHERE  Transect=1 AND mShore=010
UPDATE WaiakailioRaw SET POINT_Y=20.07439, POINT_X=-155.85984  WHERE  Transect=1 AND mShore=050
UPDATE WaiakailioRaw SET POINT_Y=20.07439, POINT_X=-155.85984  WHERE  Transect=1 AND mShore=100
UPDATE WaiakailioRaw SET POINT_Y=20.07363, POINT_X=-155.86101  WHERE  Transect=1 AND mShore=200
--
UPDATE WaiakailioRaw SET POINT_Y=20.07291, POINT_X=-155.85828  WHERE  Transect=2 AND mShore=000
UPDATE WaiakailioRaw SET POINT_Y=20.07289, POINT_X=-155.85832  WHERE  Transect=2 AND mShore=001
UPDATE WaiakailioRaw SET POINT_Y=20.07289, POINT_X=-155.85832  WHERE  Transect=2 AND mShore=002 
UPDATE WaiakailioRaw SET POINT_Y=20.07289, POINT_X=-155.85832  WHERE  Transect=2 AND mShore=003
UPDATE WaiakailioRaw SET POINT_Y=20.07289, POINT_X=-155.85832  WHERE  Transect=2 AND mShore=004
UPDATE WaiakailioRaw SET POINT_Y=20.07289, POINT_X=-155.85832  WHERE  Transect=2 AND mShore=005
UPDATE WaiakailioRaw SET POINT_Y=20.07285, POINT_X=-155.85837  WHERE  Transect=2 AND mShore=010
UPDATE WaiakailioRaw SET POINT_Y=20.07263, POINT_X=-155.85868  WHERE  Transect=2 AND mShore=050
UPDATE WaiakailioRaw SET POINT_Y=20.07236, POINT_X=-155.85906  WHERE  Transect=2 AND mShore=100
UPDATE WaiakailioRaw SET POINT_Y=20.07182, POINT_X=-155.85981  WHERE  Transect=2 AND mShore=200
--
UPDATE WaiakailioRaw SET POINT_Y=20.06609, POINT_X=-155.85300  WHERE  Transect=3 AND mShore=000
UPDATE WaiakailioRaw SET POINT_Y=20.06609, POINT_X=-155.85300  WHERE  Transect=3 AND mShore=001
UPDATE WaiakailioRaw SET POINT_Y=20.06609, POINT_X=-155.85300  WHERE  Transect=3 AND mShore=002
UPDATE WaiakailioRaw SET POINT_Y=20.06608, POINT_X=-155.85302  WHERE  Transect=3 AND mShore=003
UPDATE WaiakailioRaw SET POINT_Y=20.06607, POINT_X=-155.85303  WHERE  Transect=3 AND mShore=004
UPDATE WaiakailioRaw SET POINT_Y=20.06605, POINT_X=-155.85304  WHERE  Transect=3 AND mShore=005
UPDATE WaiakailioRaw SET POINT_Y=20.06576, POINT_X=-155.85335  WHERE  Transect=3 AND mShore=010
UPDATE WaiakailioRaw SET POINT_Y=20.06576, POINT_X=-155.85335  WHERE  Transect=3 AND mShore=050
UPDATE WaiakailioRaw SET POINT_Y=20.06543, POINT_X=-155.85369  WHERE  Transect=3 AND mShore=100
UPDATE WaiakailioRaw SET POINT_Y=20.06475, POINT_X=-155.85437  WHERE  Transect=3 AND mShore=200
-- 1 row updated, 30 times, Transeect,mShore is primary key

select * from WaiakailioRaw

/*
Transect	mShore	PO436396	Nate6393	AmmN6220	Sili6360	DOgP6368	DOgN6369	TPho6240	TDNi6210	Turb6260	Sali6350	ChlA6250	Temp6280	OxyS6367	pHyd6390	WaiIID	MyCoreName	MyLabel	AnalyteList	TablePage	MyLatLong	MyLatitude	POINT_Y	POINT_X	RawUniq
1	0	1.24000000	1.68000000	11.90000000	137.70000000	10.54000000	156.20000000	11.78000000	169.80000000	0.49000000	34.55700000	0.50000000	25.35000000	97.40000000	8.18000000	1	NULL	NULL	NULL	NULL	NULL	NULL	20.07464000	-155.85945000	19B5F97F-E43F-47EB-B895-9539DC7AEED9
1	1	0.62000000	3.08000000	4.76000000	128.40000000	9.30000000	134.70000000	9.92000000	142.50000000	0.65000000	34.54900000	0.24000000	25.46000000	99.43000000	8.19000000	2	NULL	NULL	NULL	NULL	NULL	NULL	20.07464000	-155.85945000	00E8614F-853B-49D3-88C7-C3362C9F7DC2
1	2	0.93000000	0.70000000	1.96000000	135.70000000	8.99000000	112.60000000	9.92000000	115.20000000	0.20000000	34.54300000	0.14000000	25.48000000	99.34000000	8.21000000	3	NULL	NULL	NULL	NULL	NULL	NULL	20.07465000	-155.85943000	EF56D77D-BA8D-416C-B17B-2111F66FD126
1	3	1.24000000	3.92000000	3.22000000	128.70000000	8.68000000	113.00000000	9.92000000	120.10000000	0.25000000	34.59400000	0.12000000	25.53000000	100.23000000	8.16000000	4	NULL	NULL	NULL	NULL	NULL	NULL	20.07464000	-155.85944000	1292B8EF-9E10-49EE-80BE-103E530FA50E
1	4	1.55000000	2.66000000	0.84000000	99.80000000	9.92000000	133.10000000	11.47000000	136.60000000	0.19000000	34.57500000	0.09000000	25.51000000	100.53000000	8.17000000	5	NULL	NULL	NULL	NULL	NULL	NULL	20.07463000	-155.85946000	644E960B-4F6A-4310-9358-C635B05D757E
1	5	1.86000000	7.42000000	6.30000000	150.60000000	10.85000000	164.60000000	12.71000000	178.40000000	0.24000000	34.57600000	0.09000000	25.53000000	99.53000000	8.16000000	6	NULL	NULL	NULL	NULL	NULL	NULL	20.07460000	-155.85952000	D5BDBCEE-23FA-4358-8D2D-DFBA0260063E
1	10	1.86000000	7.28000000	4.34000000	145.80000000	10.54000000	146.20000000	12.40000000	157.80000000	0.28000000	34.60100000	0.09000000	25.56000000	99.34000000	8.16000000	7	NULL	NULL	NULL	NULL	NULL	NULL	20.07460000	-155.85952000	783A5E86-0584-44AE-9B2D-0D3594EDAD42
1	50	3.41000000	4.62000000	NULL	118.30000000	9.92000000	139.60000000	13.33000000	144.20000000	0.18000000	34.62600000	0.07000000	25.58000000	100.32000000	8.16000000	8	NULL	NULL	NULL	NULL	NULL	NULL	20.07439000	-155.85984000	DD6749D3-BF91-407D-81FC-D0C93389FFBE
1	100	1.86000000	0.28000000	0.70000000	84.30000000	9.61000000	125.20000000	11.47000000	126.10000000	0.14000000	34.65300000	0.06000000	25.59000000	101.23000000	8.20000000	9	NULL	NULL	NULL	NULL	NULL	NULL	20.07439000	-155.85984000	7D45E763-29CC-4A17-B439-F0033AF56AAD
1	200	1.55000000	0.14000000	2.10000000	43.84000000	9.92000000	117.00000000	11.47000000	119.30000000	0.09000000	34.64700000	0.03000000	25.61000000	100.34000000	8.24000000	10	NULL	NULL	NULL	NULL	NULL	NULL	20.07363000	-155.86101000	93BB9CFD-1F90-41B6-82BC-B2E9026F04FF
2	0	1.24000000	290.10000000	0.70000000	5101.80000000	15.81000000	174.70000000	17.05000000	465.50000000	0.27000000	27.47400000	0.17000000	24.99000000	95.34000000	8.29000000	11	NULL	NULL	NULL	NULL	NULL	NULL	20.07291000	-155.85828000	E371893C-5694-408E-ACEE-4E8B766F7A93
2	1	1.24000000	144.20000000	7.28000000	2606.80000000	10.85000000	183.30000000	12.09000000	334.70000000	0.42000000	31.14800000	0.20000000	25.28000000	97.34000000	8.29000000	12	NULL	NULL	NULL	NULL	NULL	NULL	20.07289000	-155.85832000	B8CE5874-DDC2-407B-8DC4-6FFFE171B594
2	2	1.86000000	20.16000000	5.60000000	518.70000000	10.54000000	131.30000000	12.40000000	157.10000000	0.40000000	34.05000000	0.24000000	25.43000000	98.34000000	8.18000000	13	NULL	NULL	NULL	NULL	NULL	NULL	20.07289000	-155.85832000	A3783C9B-AAE8-4233-8C99-1B0094B28E94
2	3	3.72000000	7.84000000	1.54000000	243.60000000	10.23000000	131.00000000	13.95000000	140.40000000	0.48000000	34.46800000	0.05000000	25.49000000	99.84000000	8.09000000	14	NULL	NULL	NULL	NULL	NULL	NULL	20.07289000	-155.85832000	55B15F7E-4A79-48FB-9FEB-BEF2679C6DDB
2	4	4.03000000	1.54000000	2.94000000	122.50000000	9.30000000	123.90000000	13.33000000	128.40000000	0.26000000	34.60100000	0.06000000	25.53000000	99.98000000	8.20000000	15	NULL	NULL	NULL	NULL	NULL	NULL	20.07289000	-155.85832000	DD7B5ECA-6F9E-4201-A3D1-FE164A794922
2	5	1.24000000	0.98000000	5.32000000	119.70000000	8.99000000	116.20000000	10.23000000	122.50000000	0.23000000	34.60700000	0.03000000	25.53000000	99.76000000	8.19000000	16	NULL	NULL	NULL	NULL	NULL	NULL	20.07289000	-155.85832000	BA92C1F6-9D95-48F8-9341-CFD6EA89AA3D
2	10	0.62000000	0.42000000	1.68000000	52.83000000	8.99000000	128.70000000	9.61000000	130.80000000	0.08000000	34.65500000	0.02000000	25.76000000	100.23000000	8.20000000	17	NULL	NULL	NULL	NULL	NULL	NULL	20.07285000	-155.85837000	ABD002EA-C1A9-4E97-88DD-405DCDD41F80
2	50	1.24000000	0.70000000	0.28000000	49.46000000	8.68000000	115.50000000	9.92000000	116.50000000	0.08000000	34.65600000	0.05000000	25.67000000	101.24000000	8.14000000	18	NULL	NULL	NULL	NULL	NULL	NULL	20.07263000	-155.85868000	F6C156E2-E3D3-4353-BB44-4C0A4244B6FA
2	100	0.93000000	0.42000000	0.84000000	46.93000000	8.37000000	105.60000000	9.30000000	106.80000000	0.08000000	34.66200000	0.03000000	25.68000000	101.23000000	8.20000000	19	NULL	NULL	NULL	NULL	NULL	NULL	20.07236000	-155.85906000	69C7407F-60BA-4417-AFD6-73F7992981B1
2	200	1.55000000	0.14000000	0.70000000	43.56000000	7.75000000	104.40000000	9.30000000	105.30000000	0.09000000	34.64600000	0.03000000	25.59000000	101.24000000	8.24000000	20	NULL	NULL	NULL	NULL	NULL	NULL	20.07182000	-155.85981000	6C9E8A45-D331-4B42-B39D-C96A979FDB70
3	0	3.72000000	49.56000000	3.22000000	800.60000000	8.68000000	107.40000000	12.40000000	160.20000000	1.11000000	33.92700000	0.17000000	25.27000000	96.34000000	8.24000000	21	NULL	NULL	NULL	NULL	NULL	NULL	20.06609000	-155.85300000	9F3B98B2-5757-4F8C-AC67-D28D5E0ED772
3	1	1.55000000	48.44000000	11.06000000	742.10000000	8.68000000	131.70000000	10.23000000	191.20000000	0.75000000	33.97900000	0.14000000	25.29000000	97.83000000	8.25000000	22	NULL	NULL	NULL	NULL	NULL	NULL	20.06609000	-155.85300000	D34DBF9B-6E92-4231-A23E-C6261F71FC56
3	2	2.79000000	45.50000000	0.98000000	748.30000000	8.37000000	88.76000000	11.16000000	135.20000000	0.68000000	33.97000000	0.18000000	25.31000000	99.82000000	8.17000000	23	NULL	NULL	NULL	NULL	NULL	NULL	20.06609000	-155.85300000	9C4E652E-E908-43FA-8822-FAC36895147C
3	3	1.86000000	19.60000000	2.24000000	400.70000000	7.75000000	120.40000000	9.61000000	142.20000000	0.84000000	34.41800000	0.12000000	25.45000000	99.10000000	8.19000000	24	NULL	NULL	NULL	NULL	NULL	NULL	20.06608000	-155.85302000	4A939BFE-6A5A-47F0-A77A-231EF1F4BF60
3	4	2.79000000	10.78000000	5.04000000	268.40000000	8.37000000	121.50000000	11.16000000	137.30000000	0.55000000	34.49900000	0.12000000	25.49000000	99.39000000	8.20000000	25	NULL	NULL	NULL	NULL	NULL	NULL	20.06607000	-155.85303000	F2ED4ADE-A0F3-42B7-B88D-D78D4B69D387
3	5	1.55000000	5.60000000	6.02000000	125.90000000	8.37000000	113.30000000	9.92000000	124.90000000	0.25000000	34.60700000	0.09000000	25.53000000	100.20000000	8.05000000	26	NULL	NULL	NULL	NULL	NULL	NULL	20.06605000	-155.85304000	95949FD4-997A-4117-99AE-CD887596E0DF
3	10	1.55000000	4.48000000	3.78000000	108.20000000	7.75000000	87.50000000	9.30000000	95.70000000	60.24000000	34.62900000	0.08000000	25.57000000	100.35000000	8.05000000	27	NULL	NULL	NULL	NULL	NULL	NULL	20.06576000	-155.85335000	F27C879D-7DB2-47F8-AC44-41487FA3E132
3	50	3.10000000	3.78000000	5.74000000	56.20000000	8.99000000	93.52000000	12.09000000	103.00000000	0.09000000	34.66400000	0.10000000	25.58000000	101.24000000	8.06000000	28	NULL	NULL	NULL	NULL	NULL	NULL	20.06576000	-155.85335000	39CCF533-9D4B-42CA-B221-8BAB726A000B
3	100	3.72000000	0.28000000	2.24000000	63.23000000	7.75000000	121.10000000	11.47000000	123.60000000	0.11000000	34.65500000	0.04000000	25.57000000	100.23000000	8.08000000	29	NULL	NULL	NULL	NULL	NULL	NULL	20.06543000	-155.85369000	4C933F1E-AC38-44F0-8B12-FDEC5E6C80EA
3	200	1.86000000	0.28000000	0.70000000	43.84000000	7.13000000	108.10000000	8.99000000	109.10000000	0.08000000	34.66600000	0.03000000	25.45000000	101.32000000	8.24000000	30	NULL	NULL	NULL	NULL	NULL	NULL	20.06475000	-155.85437000	5DCBC651-E44A-4B1C-9E2D-3208BA02916A

*/


---------------------------------------------------
---------------------------------------------------
---------------------------------------------------
--
-- put together lat/long fields now that have POINTs


/* make our fields for later insertions into our tables */
--
UPDATE WaiakailioRaw SET
MyLatLong  = str(POINT_Y, 7, 4) + ' , ' + str(POINT_X, 9, 4),
MyLatitude = CAST( REPLACE( str( CAST(POINT_Y AS DECIMAL (7,4)),7,4),'.','_') AS varchar),
TablePage  = 'Table2 Page 120',
StartDate = '2009-12-17 12:00:01 AM',
EndDate   = '2009-12-17 10:00:00 PM'
-- 30
select * from WaiakailioRaw
-- 30

-- now name assembly
/*
Transect	mShore	PO436396	Nate6393	AmmN6220	Sili6360	DOgP6368	DOgN6369	TPho6240	TDNi6210	Turb6260	Sali6350	ChlA6250	Temp6280	OxyS6367	pHyd6390	WaiIID	MyCoreName	MyLabel	MyLatLong	MyLatitude	POINT_Y	POINT_X	RawUniq

Waiakailio_SDollar_
YDec2009
PO436396Nate6393AmmN6220Sili6360DOgP6368DOgN6369TPho6240TDNi6210Turb6260Sali6350ChlA6250Temp6280OxyS6367pHyd6390
--without AmmN6220
PO436396Nate6393Sili6360DOgP6368DOgN6369TPho6240TDNi6210Turb6260Sali6350ChlA6250Temp6280OxyS6367pHyd6390
*/

-- analyte list determined simply by looking at data, pHyd6390Temp6280 are missing in other than tr3&4
UPDATE WaiakailioRaw SET
AnalyteList = 'PO436396Nate6393AmmN6220Sili6360DOgP6368DOgN6369TPho6240TDNi6210Turb6260Sali6350ChlA6250Temp6280OxyS6367pHyd6390'
FROM WaiakailioRaw
-- 30
UPDATE WaiakailioRaw SET
AnalyteList = 'PO436396Nate6393Sili6360DOgP6368DOgN6369TPho6240TDNi6210Turb6260Sali6350ChlA6250Temp6280OxyS6367pHyd6390'
FROM WaiakailioRaw
WHERE Transect = 1 AND mShore = 50
-- 1 , only 1 null in all the data, SDollar is very consistent!

---------
--

-- make label,flStation1, and embayments names from Google Maps and Google MyMaps names shown
UPDATE WaiakailioRaw SET MyLabel = 
   RIGHT('000'+LTRIM(str(mShore)),3) + 'm ' + -- 000m,001m,003m,004m,005m,010m,050m,100m or 500m at Waiakailio
   'Keawewai Gulch North KohalaTr' + CAST(Transect as char(1)),
fkStation1 = 'TRANSECT 1 (NORTH)',
Embayment = 'Yes'
WHERE Transect = 1
-- 10
UPDATE WaiakailioRaw SET MyLabel = 
   RIGHT('000'+LTRIM(str(mShore)),3) + 'm ' + 
   'Waiakailio Bay North KohalaTr' + CAST(Transect as char(1)),
fkStation1 = 'TRANSECT 2 (CENTER)',
Embayment = 'No'
WHERE Transect = 2
-- 10
UPDATE WaiakailioRaw SET MyLabel = 
   RIGHT('000'+LTRIM(str(mShore)),3) + 'm ' +
   'Kaiopae Gulch North KohalaTr' + CAST(Transect as char(1)),
fkStation1 = 'TRANSECT 3 (SOUTH)',
Embayment = 'No'
WHERE Transect = 3
-- 10

---------------------------------
-- make core name 
UPDATE WaiakailioRaw SET MyCoreName = 
   MyLatitude + '_' +
   RIGHT('000'+LTRIM(str(mShore)),3) + 'm_' + -- 000m,001m,003m,004m,005m,010m,050m,100m,200m
   REPLACE(SUBSTRING(MyLabel,5,LEN(MyLabel)), ' ','') + '_'  +
   'YDec172009_'                            +
   'SDollar' + '_'                          +
   'EISKohalaShorelineLLC'           
FROM WaiakailioRaw
-- 30
select MyCoreName from WaiakailioRaw

--
select MyCoreName from WaiakailioRaw
select MyCoreName,AnalyteList from WaiakailioRaw
select * from WaiakailioRaw
--
--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- make the dates unique by adding a few seconds
DECLARE @RawUniq uniqueidentifier, @StartDate datetime2, @EndDate datetime2, @RowCount integer=0
DECLARE @cursorInsert CURSOR SET @cursorInsert = CURSOR FOR
   SELECT RawUniq, StartDate, EndDate FROM WaiakailioRaw
OPEN @cursorInsert
FETCH NEXT FROM @cursorInsert INTO @RawUniq, @StartDate, @EndDate
--
WHILE @@FETCH_STATUS = 0
   BEGIN
   set @RowCount = @RowCount + 1
   UPDATE WaiakailioRaw 
   SET StartDate = DATEADD(ss,@RowCount,StartDate),EndDate = DATEADD(ss,@RowCount,EndDate)
   WHERE WaiakailioRaw.RawUniq IN (SELECT @RawUniq FROM WaiakailioRaw)
   FETCH NEXT FROM @cursorInsert INTO @RawUniq, @StartDate, @EndDate
   END
CLOSE @cursorInsert
DEALLOCATE @cursorInsert
--
select StartDate,EndDate from WaiakailioRaw

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--  DROP TABLE [dbo].[WaiakailioFCStation]
CREATE TABLE [dbo].[WaiakailioFCStation](
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
	[GeoUniq] [uniqueidentifier] NOT NULL,
	[StatUniq] [uniqueidentifier] NOT NULL,
	[RawUniq] [uniqueidentifier] NOT NULL,

 PRIMARY KEY (pkStation)
 ) 

-- 
-- FCStation is populated from WaiakailioRaw and the names/location information I have assembled
--    DELETE from WaiakailioFCStation
--  INSERT INTO WaiakailioFCStation
 SELECT 
MyCoreName,  -- pkStation
MyLabel,     -- Label
TablePage,   -- TablePage
fkStation1,  -- fkStation1 
NULL,        -- fkStation2
mShore,      -- mShore
3499,        -- dmStA
6499,        -- dmStAA 
3780,        -- dmStBott use Kiholocode
7110,        -- dmStClas not applicable value
4650,        -- dmAccuracy from Google MyMaps geocoding
8823,        -- dmReef - not applicable value
7777,        -- dmRule - not applicable value
700,         -- dmStType Environment Impact Report
NULL,        -- fkEPA
NULL,        -- fkUSGS   
Embayment,   -- Embayment assigned by transect above
NULL,        -- VolumeBay
NULL,        -- CrossArea
REPLACE(MyLatitude,'_',''),  -- AttachSt is latitude as int number
NULL,        -- dmAccu4610, -- no GPS coordinates supplied, so all these NULL to track geocoding
NULL,        -- dmAccu4620
NULL,        -- dmAccu4630
NULL,        -- dmAccu4640
MyLatLong,   -- dmAccu4650 my Google geocode effort
NULL,        -- dmAccu4660
NULL,        -- dmAccu4670
CAST(StartDate as datetime), -- StartDate and EndDate is set as entire month of Dec2009
CAST(EndDate as datetime),   -- EndDate
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
FROM WaiakailioRaw
ORDER BY Transect,mShore 
-- 30
select * from WaiakailioFCStation
-- 30
select StartDate,EndDate from WaiakailioFCStation

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

------------------------------------------------------------------------------
------------------------------------------------------------------------------


-- FCStation complete and many preparations compete, move to insert data from WaiakailioRaw and other tables
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- Now work on the TBSample table
-- the pkSample name pieces are available to include fully formed names
-- there are xx sample, with up to 7 analytes recorded per sample

--  DROP TABLE WaiakailioTBSample
CREATE TABLE WaiakailioTBSample (
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


select StartDate,mShore,Transect  from WaiakailioRaw
order by StartDate


--     DELETE FROM WaiakailioTBSample
--  INSERT INTO WaiakailioTBSample
SELECT 
MyCoreName + '_' + AnalyteList,  -- pkSample
MyLabel,     -- LabelName
TablePage,   -- TablePage 
0,           -- AlertTrue
'SJDollar',  -- fkIDLoc
Transect,    -- Transect
mShore,      -- mShore
MyCoreName,  -- pkStation, same as FCStation code
NULL,        -- fkStation2, station as known to Waiakailio
'SJDollar',
newid(),     -- fkUniqID is the new if generated in this new row creation of the insert
'<<fkOrg>>', -- *** GET ****
1420,        -- dmSample, laboratory
StartDate, 
EndDate,     -- 
'Yes',       -- TimeMissg field
NULL,NULL,   -- Medium, CompStat
NULL,        -- no Comment yet
REPLACE(MyLatitude,'_',''), -- attach code
NULL,NULL,NULL,NULL,NULL,   -- 5 extras
0,0,0,1,NULL,               -- cartography fields
newid(),
RawUniq                     -- important for tracing to save source row id
FROM WaiakailioRaw
ORDER BY Transect,mShore
-- 30 rows affected
select * from WaiakailioTBSample
-- 30
-----------------------
-----------------------

/*
-- inner join should be all, outer join should be none as pkStation and fkStation must match, no nulls allowed
select A_sta.*, B_samp.*
from WaiakailioFCStation A_sta
INNER JOIN WaiakailioTBSample B_samp ON
A_sta.pkStation = B_samp.fkStation
--30
select A_sta.*, B_samp.*
from WaiakailioFCStation A_sta
full outer JOIN WaiakailioTBSample B_samp ON
A_sta.pkStation = B_samp.fkStation
WHERE A_sta.pkStation IS NULL OR B_samp.fkStation IS NULL
-- 0 rows good
*/
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- move to populate WaiakailioTBResult

--  DROP TABLE WaiakailioTBResult
CREATE TABLE WaiakailioTBResult (
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
--  delete from WaiakailioTBResult
--------------------------------------------------------------------------------
-- 1/14  
 INSERT INTO WaiakailioTBResult
SELECT 
samp.pkSample,
'PO436396 - PO43 Phosphate',
samp.fkIDLoc,
samp.fkUnqID,
PO436396,
NULL,-- Stddev
6396,--dmRAll
6465,--dmRAMethod
6299,--dmR11546
6396,--dmRAnlyt
6499,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM WaiakailioRaw raw
INNER JOIN WaiakailioTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and PO436396 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 30
--------------------------------------------------------------------------------
-- 2
INSERT INTO WaiakailioTBResult
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
6499,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM WaiakailioRaw raw
INNER JOIN WaiakailioTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and Nate6393 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 30
--------------------------------------------------------------------------------
-- 3
INSERT INTO WaiakailioTBResult
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
FROM WaiakailioRaw raw
INNER JOIN WaiakailioTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and AmmN6220 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 29
--------------------------------------------------------------------------------
-- 4
INSERT INTO WaiakailioTBResult
SELECT 
samp.pkSample,
'Sili6360 - Silicates',
samp.fkIDLoc,
samp.fkUnqID,
Sili6360,
NULL,-- Stddev
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
FROM WaiakailioRaw raw
INNER JOIN WaiakailioTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and Sili6360 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
--  30
--------------------------------------------------------------------------------
-- 5
INSERT INTO WaiakailioTBResult
SELECT 
samp.pkSample,
'DogP6368 - Dissolved Organic Phosphorus',
samp.fkIDLoc,
samp.fkUnqID,
DogP6368,
NULL,-- Stddev
6368,--dmRAll
6465,--dmRAMethod
6299,--dmR11546
6368,--dmRAnlyt
6499,--dmRBEACH
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM WaiakailioRaw raw
INNER JOIN WaiakailioTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and DogP6368 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 30
select sum(DogP6368) FROM WaiakailioRaw raw
WHERE raw.DogP6368 IS NOT NULL
select sum(Result) FROM WaiakailioTBResult
WHERE dmRall = 6368
-- 279.62000000 both
--------------------------------------------------------------------------------
-- 6
INSERT INTO WaiakailioTBResult
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
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM WaiakailioRaw raw
INNER JOIN WaiakailioTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and DogN6369 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 30
--------------------------------------------------------------------------------
-- 7
INSERT INTO WaiakailioTBResult
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
FROM WaiakailioRaw raw
INNER JOIN WaiakailioTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and TPho6240 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 30
--------------------------------------------------------------------------------
-- 8
INSERT INTO WaiakailioTBResult
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
FROM WaiakailioRaw raw
INNER JOIN WaiakailioTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and TDNi6210 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 30
--------------------------------------------------------------------------------
-- 9
INSERT INTO WaiakailioTBResult
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
FROM WaiakailioRaw raw
INNER JOIN WaiakailioTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and Turb6260 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 30
--------------------------------------------------------------------------------
-- 10
INSERT INTO WaiakailioTBResult
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
FROM WaiakailioRaw raw
INNER JOIN WaiakailioTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and Sali6350 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 30
--------------------------------------------------------------------------------
-- 11
INSERT INTO WaiakailioTBResult
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
FROM WaiakailioRaw raw
INNER JOIN WaiakailioTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and ChlA6250 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 30
--------------------------------------------------------------------------------
-- 12
INSERT INTO WaiakailioTBResult
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
FROM WaiakailioRaw raw
INNER JOIN WaiakailioTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and Temp6280 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 30
--------------------------------------------------------------------------------
-- 13
INSERT INTO WaiakailioTBResult
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
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM WaiakailioRaw raw
INNER JOIN WaiakailioTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and OxyS6367 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 30
--------------------------------------------------------------------------------
-- 14
INSERT INTO WaiakailioTBResult
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
NULL, -- Grade
NULL, -- Comments
NULL, -- AttachR
NULL, 
NULL,NULL,NULL,raw.mShore,  
raw.RawUniq,   -- from raw
newid(),       -- ResUniq, get own new 
samp.SampUniq  -- SampUniq 
FROM WaiakailioRaw raw
INNER JOIN WaiakailioTBSample samp
ON (raw.Transect = samp.Transect AND raw.mShore = samp.mShore) and pHyd6390 IS NOT NULL
ORDER BY raw.Transect,raw.mShore
-- 30
---------------------


select * from WaiakailioTBResult
-- 419 rows


-- V1 thesis maps
USE WHWQ4


SELECT Count(*) as 'TBResult Count' FROM WaiakailioTBResult
SELECT Label, Count(dmRAll) as 'TBResult rows' FROM WaiakailioTBResult GROUP by Label, dmRAll ORDER by 2 DESC


-- V2 thesis maps
SELECT Count(*) as 'TBResult #rows' FROM WaiakailioTBResult
SELECT Label, Count(dmRAll) as '#rows', round(exp(avg(log(Result))),3) as '~gmean' 
FROM WaiakailioTBResult 
GROUP by Label, dmRAll ORDER by 2 DESC

-- V3 thesis maps
SELECT 'Waiakailio Bay December 2009' as 'S.J.Dollar', Count(*) as 'TBResult #rows' FROM WaiakailioTBResult
SELECT Label, Count(dmRAll) as '#rows', round(exp(avg(log(Result))),3) as '~gmean',round(stdev(Result),2) as 'stdev',cast(min(Result) as decimal (10,2)) as 'min',cast(max(Result) as decimal (10,2)) as 'max' 
FROM WaiakailioTBResult WHERE Result>0 AND dmRAll not in (6393,6397) GROUP by Label, dmRAll ORDER by Label





/*
select exp(avg(log(Sali6350))),max(Sali6350),min(Sali6350),avg(Sali6350),COUNT(Sali6350),SUM(Sali6350)


SELECT '12/17/2009' as 'Waiakailio,S.J.Dollar', Count(*) as 'TBResult #rows' FROM WaiakailioTBResult
SELECT Label, Count(dmRAll) as '#rows', round(exp(avg(log(Result))),3) as '~gmean',
round(stdev(Result),2) as 'stdev',cast(min(Result) as decimal (10,2)) as 'min',cast(max(Result) as decimal (10,2)) as 'max' FROM WaiakailioTBResult GROUP by Label, dmRAll ORDER by Label



--------------------------------------------------------------------------------

/*
SELECT 
SUM(PO436396) +
SUM(Nate6393) +
SUM(AmmN6220) +
SUM(Sili6360) +
SUM(DOgP6368) +
SUM(DOgN6369) +
SUM(TPho6240) +
SUM(TDNi6210) +
SUM(Turb6260) +
SUM(Sali6350) +
SUM(ChlA6250) +
SUM(Temp6280) +
SUM(OxyS6367) +
SUM(pHyd6390) 
FROM WaiakailioRaw
-- 28289.54200000
SELECT SUM(Result) FROM WaiakailioTBResult
-- 28289.54200000

*/


-- select * from WaiakailioTBResult order by dmRAll
SELECT COUNT(*) FROM WaiakailioTBResult
-- 380 rows 3*10 + 10*35 = 380
SELECT * FROM WaiakailioTBResult

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
/*
select r.*, s.* 
From WaiakailioTBResult r
inner join WaiakailioTBSample  s
ON r.fkUnqID = s.fkUnqID
-- 380
select s.*, r.* 
From WaiakailioTBSample s
inner join  WaiakailioTBResult r
ON s.fkUnqID = r.fkUnqID
-- 380 as expect for inner join

select r.*, s.* 
From WaiakailioTBResult r
left join WaiakailioTBSample  s
ON r.fkUnqID = s.fkUnqID
-- 380

--select pkSample, fkSample, r.label
select s.*,r.*
From WaiakailioTBSample s
left join  WaiakailioTBResult r
ON r.fkUnqID = NULL
-- must be 35 DON LOOK
select * from WaiakailioTBResult where fkUnqID is null
--0
select * from WaiakailioTBSample where fkUnqID is null
--0
select count(*) from WaiakailioTBSample
--35
select count(*) from WaiakailioTBResult
--380

select r.*, s.* 
From WaiakailioTBResult r
right join WaiakailioTBSample  s
ON r.fkUnqID = s.fkUnqID
-- 380
select pkSample, fkSample, r.label
From WaiakailioTBSample s
right join  WaiakailioTBResult r
ON s.fkUnqID = NULL
-- 380

select r.*, s.* 
From WaiakailioTBResult r
full outer join WaiakailioTBSample  s
ON r.fkUnqID = s.fkUnqID
-- 380
select s.*, r.* 
From WaiakailioTBSample s
full outer join  WaiakailioTBResult r
ON s.fkUnqID = r.fkUnqID
-- 380

----
select r.*, s.* 
From WaiakailioTBResult r
full outer join WaiakailioTBSample  s
ON s.fkUnqID = r.fkUnqID
WHERE r.fkUnqID IS NULL OR s.fkUnqID IS NULL
-- 0
select s.*, r.* 
From WaiakailioTBSample s
full outer join  WaiakailioTBResult r
ON s.fkUnqID = r.fkUnqID
WHERE s.fkUnqID IS NULL OR r.fkUnqID IS NULL
-- 0
*/
