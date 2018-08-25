-- Utility functions and scratch area for CWB data

1203,'KahaluuBeachPark'    ,1066
1200,'HapunaBeach'         ,480
1215,'MagicSands'          ,469
1238,'KawaihaeLSTLanding'  ,182
1220,'Milolii'             ,96
1252,'KuaBay'              ,141
1201,'HonaunauBayRefuge'   ,47
1213,'KeauhouBay'          ,344
1216,'MahukonaLanding'     ,47
1204,'KailuaPierStationA'  ,289					  ,
1229,'HonaunauBayEmbaymt'  ,1
1236,'AnaehoomaluBay'      ,965
1225,'SpencerBeachPark'    ,399
1202,'HonuapoLanding'      ,78
1212,'KealakekuaBayCanoe'  ,94
1210,'KawaihaeHarborPier'  ,87
1253,'PineTrees'           ,117
1219,'MaunakeaHotelBeach'  ,83
1218,'MaunakeaOff4thGreen' ,45
1205,'KailuaPierStationA1' ,1081					  ,
1226,'OldKonaAirport'      ,24
1230,'KealakekuaBayEmbay'  ,128
1244,'HonaunauBay2Step'    ,75
1208,'KailuaPierStationD'  ,926
1243,'MaunaKeaBeachSouth'  ,139
1237,'OTEC_NELHA'          ,174
1224,'PunaluuBeachPark'    ,1141
1249,'HoloholokaiBeachPark',114
1234,'KeaholePointOceanic' ,156
1235,'BanyansSurfingArea'  ,225					  ,
1206,'KailuaPierStationB'  ,104
1214,'KonaHiltonShoreLine' ,121
1221,'PuakoBoatRamp'       ,151
1247,'Waiulaula'           ,48
1251,'Hualalai4Seasons'    ,25
1217,'MaunakeaBchOutfall'  ,44
1233,'HonokahauHarborEmbay',25
1211,'KealakekuaBayCurio'  ,258
1209,'KauhakoBayHookena'   ,97
1246,'Pelekane'            ,80					  ,
1222,'PuakoMiddleofLot'    ,1010
1250,'PauoaBay'            ,107
1231,'KeauhouBayEmbayment' ,31
1241,'KonaCoastBeachPark'  ,113
1240,'KealakekuaBay'       ,10
1207,'KailuaPierStationC'  ,93
1223,'PuakoBeachLotsFarEnd',114
1245,'HonaunauBayBoatRamp' ,11

select  distinct(CWBLocationCode),MyLabel as 'Location',
 count(*) as 'Row Count',
 cast (min(pacioostimeutc) as date) as 'Earliest Date',
 cast (max(pacioostimeutc) as date) as 'Latest Date'
FROM cwbraw
GROUP by CWBLocationCode ,MyLabel
ORDER by 3 desc

select  distinct(CWBLocationCode),MyLabel as 'Location',
count(*) as 'Row Count',
CONVERT(varchar(12), min(pacioostimeutc),100) as 'Earliest Date',
CONVERT(varchar(12), max(pacioostimeutc),100) as 'Latest Date'
FROM cwbraw
GROUP by CWBLocationCode ,MyLabel
ORDER by 3 desc



SELECT  distinct(CWBLocationCode) as 'CWB Site#', ',',
MyLabel as 'Location', ',',
count(*) as 'Row Count', ',',
CONVERT(varchar(12), min(pacioostimeutc),100) as 'Earliest Date', ',',
CONVERT(varchar(12), max(pacioostimeutc),100) as 'Latest Date'
FROM cwbraw
GROUP by CWBLocationCode ,MyLabel
ORDER by 5 desc


SELECT COUNT(*) FROM CWBRaw WHERE
NULL = Ecci6410




select * from CWBFCStation_TEMP
select CWBLocationCode, ',',MyLabel, ',',AlertCount from CWBFCStation_TEMP order by AlertCount desc

select CWBLocationCode,MyLabel,AlertCount from CWBFCStation_TEMP order by AlertCount desc

 DROP  TABLE CWBFCStationX
CREATE TABLE CWBFCStationX (
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
	[XSectArea] [numeric](38, 8) NULL,
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
	[EndDate] [datetime2](7) NULL,
	[StFloat1] [numeric](38, 8) NULL,
	[StFloat2] [numeric](38, 8) NULL,
	[StDate3] [datetime2](7) NULL,
	[StDate4] [datetime2](7) NULL,
	[StLong5] [int] NULL,
	[GeoUniq] [uniqueidentifier] NOT NULL,
	[StatUniq] [uniqueidentifier] NOT NULL,
	[RawUniq] [uniqueidentifier] NOT NULL,

--- My fields needed to get this into Esri (or at least an easy way)
	[POINT_Y] [numeric](38, 8)   NOT NULL,
	[POINT_X] [numeric](38, 8)   NOT NULL,
PRIMARY KEY (fkStation1)
)
INSERT INTO CWBFCStationX SELECT * FROM CWBFCStation
UPDATE CWBFCStationX  SET POINT_X = -156.3