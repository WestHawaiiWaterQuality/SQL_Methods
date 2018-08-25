-- Common Analyte actions across all Projects

use whwq4
-

--   drop table Analytes
CREATE TABLE Analytes (
   Label  [nvarchar](255) NOT NULL,
   CodeT  [nvarchar](255) NOT NULL,
   CodeI  [int]           NOT NULL,

PRIMARY KEY (Label)
)
--
--   DELETE FROM Analytes
INSERT INTO Analytes VALUES ('TDNi6210 - Total Nitrogen'                        , 'TDNi6210', 6210)
INSERT INTO Analytes VALUES ('AmmN6220 - Ammonia Nitrogen'                      , 'AmmN6220', 6220)
INSERT INTO Analytes VALUES ('NaNi6230 - Nitrate+Nitrite Nitrogen'              , 'NaNi6230', 6230)
INSERT INTO Analytes VALUES ('TPho6240 - Total Phosphorus'                      , 'TPho6240', 6240)
INSERT INTO Analytes VALUES ('ChlA6250 - Chlorophyll a'                         , 'ChlA6250', 6250)
INSERT INTO Analytes VALUES ('Turb6260 - Turbidity'                             , 'Turb6260', 6260)
INSERT INTO Analytes VALUES ('OxyD6270 - Dissolved Oxygen'                      , 'OxyD6270', 6270)
INSERT INTO Analytes VALUES ('COxy6272 - CTD Oxygen'                            , 'COxy6272', 6272)
INSERT INTO Analytes VALUES ('Temp6280 - Temperature C'                         , 'Temp6280', 6280)
INSERT INTO Analytes VALUES ('Sali6350 - Salinity'                              , 'Sali6350', 6350)
INSERT INTO Analytes VALUES ('Sili6360 - Silicates'                             , 'Sili6360', 6360)
INSERT INTO Analytes VALUES ('O2mc6364 - Mass_Concentration_of_Oxygen_CWB'      , 'O2mc6364', 6364)
INSERT INTO Analytes VALUES ('O2fs6365 - Fractional_Saturation_of_Oxygen_CWB'   , 'O2fs6365', 6365)
INSERT INTO Analytes VALUES ('O2sa6366 - Oxygen_Saturation_PacIOOS'             , 'O2sa6366', 6366)
INSERT INTO Analytes VALUES ('O2sc6367 - Oxygen_Saturation_Conc_PacIOOS'        , 'O2sc6367', 6367)
INSERT INTO Analytes VALUES ('DOgP6368 - Dissolved Organic Phosphorus'          , 'DOgP6368', 6368)
INSERT INTO Analytes VALUES ('DOgN6369 - Dissolved Organic Nitrogen'            , 'DOgN6369', 6369)
INSERT INTO Analytes VALUES ('Wind6381 - Wind Direction'                        , 'Wind6381', 6381)
INSERT INTO Analytes VALUES ('WdSw6382 - Wind Swell'                            , 'WdSw6382', 6382)
INSERT INTO Analytes VALUES ('WdCp6383 - Wind Chop Inches'                      , 'WdCp6383', 6383)
INSERT INTO Analytes VALUES ('Swel6384 - Swell Direction'                       , 'Swel6384', 6384)
INSERT INTO Analytes VALUES ('SwHt6385 - Swell Height Inches'                   , 'SwHt6385', 6385)
INSERT INTO Analytes VALUES ('TDPh6386 - Total Dissolved Phosphorus'            , 'TDPh6386', 6386)
INSERT INTO Analytes VALUES ('Colo6387 - Color'                                 , 'Colo6387', 6387)
INSERT INTO Analytes VALUES ('N15i6388 - 15N'                                   , 'N15i6388', 6388)
INSERT INTO Analytes VALUES ('H4Si6389 - H4Sio4 Silicic Acid'                   , 'H4Si6389', 6389)
INSERT INTO Analytes VALUES ('pHyd6390 - pH'                                    , 'pHyd6390', 6390)
INSERT INTO Analytes VALUES ('Phos6391 - Phosphorus PO4'                        , 'Phos6391', 6391)
INSERT INTO Analytes VALUES ('TtOC6392 - Total Organic Carbon'                  , 'TtOC6392', 6392)
INSERT INTO Analytes VALUES ('Nate6393 - NO3'                                   , 'Nate6393', 6393)
INSERT INTO Analytes VALUES ('Cond6394 - Conductivity'                          , 'Cond6394', 6394)
INSERT INTO Analytes VALUES ('Pho06395 - 0-Phosphate'                           , 'Pho06395', 6395)
INSERT INTO Analytes VALUES ('PO436396 - PO43 Phosphate'                        , 'PO436396', 6396)
INSERT INTO Analytes VALUES ('CDOM6397 - Chromophoric Dissolved Organic Matter' , 'CDOM6397', 6397)
INSERT INTO Analytes VALUES ('Pheo6398 - Pheophytin'                            , 'Pheo6398', 6398)
INSERT INTO Analytes VALUES ('Ecci6410 - Enterococci'                           , 'Ecci6410', 6410)
INSERT INTO Analytes VALUES ('Clos6420 - Clostridium perfringens'               , 'Clos6420', 6420)
--


-- declare @TBResultTable nvarchar(255)='MihalkaTBResult'
-- declare @TBResultTable nvarchar(255)='HOTSTBResult'
EXEC('UPDATE ' + @TBResultTable + ' SET Label =''TDNi6210 - Total Nitrogen''                        WHERE Label =''TDNi6210''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''AmmN6220 - Ammonia Nitrogen''                      WHERE Label =''AmmN6220''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''NaNi6230 - Nitrate+Nitrite Nitrogen''              WHERE Label =''NaNi6230''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''TPho6240 - Total Phosphorus''                      WHERE Label =''TPho6240''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''ChlA6250 - Chlorophyll a''                         WHERE Label =''ChlA6250''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''Turb6260 - Turbidity''                             WHERE Label =''Turb6260''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''OxyD6270 - Dissolved Oxygen''                      WHERE Label =''OxyD6270''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''COxy6272 - CTD Oxygen''                            WHERE Label =''COxy6272''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''Temp6280 - Temperature C''                         WHERE Label =''Temp6280''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''Sali6350 - Salinity''                              WHERE Label =''Sali6350''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''Sili6360 - Silicates''                             WHERE Label =''Sili6360''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''O2mc6364 - Mass_Concentration_of_Oxygen_CWB''      WHERE Label =''O2mc6364''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''O2fs6365 - Fractional_Saturation_of_Oxygen_CWB''   WHERE Label =''O2fs6365''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''O2sa6366 - Oxygen_Saturation_PacIOOS''             WHERE Label =''O2sa6366''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''O2sc6367 - Oxygen_Saturation_Conc_PacIOOS''        WHERE Label =''O2sc6367''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''DOgP6368 - Dissolved Organic Phosphorus''          WHERE Label =''DOgP6368''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''DOgN6369 - Dissolved Organic Nitrogen''            WHERE Label =''DOgN6369''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''Wind6381 - Wind Direction''                        WHERE Label =''Wind6381''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''WdSw6382 - Wind Swell''                            WHERE Label =''WdSw6382''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''WdCp6383 - Wind Chop Inches''                      WHERE Label =''WdCp6383''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''Swel6384 - Swell Direction''                       WHERE Label =''Swel6384''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''SwHt6385 - Swell Height Inches''                   WHERE Label =''SwHt6385''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''TDPh6386 - Total Dissolved Phosphorus''            WHERE Label =''TDPh6386''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''Colo6387 - Color''                                 WHERE Label =''Colo6387''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''N15i6388 - 15N''                                   WHERE Label =''N15i6388''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''H4Si6389 - H4Sio4 Silicic Acid''                   WHERE Label =''H4Si6389''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''pHyd6390 - pH''                                    WHERE Label =''pHyd6390''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''Phos6391 - Phosphorus PO4''                        WHERE Label =''Phos6391''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''TtOC6392 - Total Organic Carbon''                  WHERE Label =''TtOC6392''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''Nate6393 - NO3''                                   WHERE Label =''Nate6393''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''Cond6394 - Conductivity''                          WHERE Label =''Cond6394''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''Pho06395 - 0-Phosphate''                           WHERE Label =''Pho06395''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''PO436396 - PO43 Phosphate''                        WHERE Label =''PO436396''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''CDOM6397 - Chromophoric Dissolved Organic Matter'' WHERE Label =''CDOM6397''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''Pheo6398 - Pheophytin''                            WHERE Label =''Pheo6398''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''Ecci6410 - Enterococci''                           WHERE Label =''Ecci6410''')
EXEC('UPDATE ' + @TBresultTable + ' SET Label =''Clos6420 - Clostridium perfringens''               WHERE Label =''Clos6420''')
--


--


select * from Analytes order by codeI
select count(*) from Analytes
-- 37

select distinct(res.dmRAll) from
AllCombinedTBResult res
INNER JOIN Analytes an
ON  res.dmRAll = an.CodeI
--order by 1
-- 37
select distinct(res.Label) from
AllCombinedTBResult res
INNER JOIN Analytes an
ON  res.Label = an.Label
--order by 1
-- 37


