-- ============================================================
-- seed_reference_data.sql
-- 19edypd_db — Seed: conferences, areas, churches
-- Generated from: 19th Episcopal District Membership Stats 2026.csv
-- Generated on:   2026-08-12
--
-- Run this ONCE on a fresh database (after create_all_tables.sql)
-- before importing members via import_members.php.
--
-- All church names are preserved exactly as they appear in the CSV
-- (including capitalisation and spacing) because import_members.php
-- does a case-sensitive exact match on local_church_name.
-- ============================================================

USE `19edypd_db`;

SET foreign_key_checks = 0;

-- ============================================================
-- 1. Conferences  (5 rows)
-- ============================================================
TRUNCATE TABLE conferences;

INSERT INTO conferences (conference_id, district_id, conference_name) VALUES (1, 19, 'Natal Conference');
INSERT INTO conferences (conference_id, district_id, conference_name) VALUES (2, 19, 'West Conference');
INSERT INTO conferences (conference_id, district_id, conference_name) VALUES (3, 19, 'Orangia Conference');
INSERT INTO conferences (conference_id, districtconference_name) VALUES (4, 19, 'Mangena Maake Mokone Memorial Conference');
INSERT INTO conferences (conference_id, district_id, conference_name) VALUES (5, 19, 'East Conference');

-- ============================================================
-- 2. Areas
--    Natal  : named areas (Doroth D, Ih Bonner, Ingrid Mpantsha, Victoria)
--    Others : numeric IDs from CSV stored as area_name
-- ============================================================
TRUNCATE TABLE areas;

-- Natal Conference
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (1, 19, 1, 'Doroth D');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (2, 19, 1, 'Ih Bonner');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (3, 19, 1, 'Ingrid Mpantsha');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (4, 19, 1, 'Victoria');

-- West Conference
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (5, 19, 2, '1');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (6, 19, 2, '2');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (7, 19, 2, '3');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (8, 19, 2, '4');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (9, 19, 2, '5');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (10, 19, 2, '6');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (11, 19, 2, '7');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (12, 19, 2, '9');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (13, 19, 2, '10');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (14, 19, 2, '11');

-- Orangia Conference
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (15, 19, 3, '1');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (16, 19, 3, '2');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (17, 19, 3, '3');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (18, 19, 3, '4');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (19, 19, 3, '6');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (20, 19, 3, '8');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (21, 19, 3, '9');

-- Mangena Maake Mokone Memorial Conference
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (22, 19, 4, '1');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (23, 19, 4, '2');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (24, 19, 4, '3');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (25, 19, 4, '4');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (26, 19, 4, '5');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (27, 19, 4, '6');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (28, 19, 4, '7');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (29, 19, 4, '8');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (30, 19, 4, '9');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (31, 19, 4, '10');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (32, 19, 4, '11');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (33, 19, 4, '12');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (34, 19, 4, '13');

-- East Conference
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (35, 19, 5, '1');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (36, 19, 5, '2');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (37, 19, 5, '3');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (38, 19, 5, '4');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (39, 19, 5, '5');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (40, 19, 5, '6');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (41, 19, 5, '7');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (42, 19, 5, '8');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (43, 19, 5, '9');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (44, 19, 5, '10');
INSERT INTO areas (area_id, district_id, conference_id, area_name) VALUES (45, 19, 5, '11');

-- ============================================================
-- 3. Churches
--    church area_id is resolved from the area table above.
--    Names are preserved verbatim (exact match required at import).
-- ============================================================
TRUNCATE TABLE churches;

-- Natal Conference (15 churches)
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (1, 19, 1, 4, 'Bethel');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (2, 19, 1, 2, 'David Temple AME');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (3, 19, 1, 4, 'Ebeneza Temple');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (4, 19, 1, 4, 'Hw Henning');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (5, 19, 1, 4, 'J.L Davis Hollycross');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (6, 19, 1, 4, 'J.l Davis Magwa');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (7, 19, 1, 3, 'Jericho Crcuit');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (8, 19, 1, 2, 'Joel Memorial  AME');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (9, 19, 1, 2, 'Jones Temple AME');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (10, 19, 1, 3, 'Mt. Zion');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (11, 19, 1, 2, 'Philimons Temple AME');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (12, 19, 1, 2, 'Richard Allen AME');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (13, 19, 1, 3, 'St. Matthews');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (14, 19, 1, 3, 'Trinity');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (15, 19, 1, 2, ' Joel Memorial AME');

-- West Conference (32 churches)
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (16, 19, 2, 5, 'A.M Senatle');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (17, 19, 2, 9, 'AK Senatle');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (18, 19, 2, 11, 'Allen Temple');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (19, 19, 2, 7, 'Baberming Temple');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (20, 19, 2, 14, 'Bethel Chapel');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (21, 19, 2, 5, 'Bethel DK');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (22, 19, 2, 10, 'Bethel Mogale City');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (23, 19, 2, 10, 'Ebenezer');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (24, 19, 2, 14, 'Ebenezer Chapel');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (25, 19, 2, 9, 'Edith Bryant');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (26, 19, 2, 8, 'Emmanuel');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (27, 19, 2, 5, 'F.H Gow');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (28, 19, 2, 8, 'HJ BRYANT');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (29, 19, 2, 8, 'KS MALINGA');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (30, 19, 2, 13, 'Letsapa memorial');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (31, 19, 2, 8, 'MT ARARAT');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (32, 19, 2, 13, 'MTG Seate');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (33, 19, 2, 7, 'Makhene memorial');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (34, 19, 2, 12, 'Mareka Memorial');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (35, 19, 2, 14, 'Montshioa Chapel');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (36, 19, 2, 13, 'Moshoette memorial');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (37, 19, 2, 13, 'Mount Sinai');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (38, 19, 2, 10, 'Mt.Zion');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (39, 19, 2, 5, 'R.R Wright Chapel');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (40, 19, 2, 11, 'Robinson Chapel');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (41, 19, 2, 8, 'SP MAAROHANYE');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (42, 19, 2, 8, 'ST FRANCIS');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (43, 19, 2, 7, 'Sebedia chapel');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (44, 19, 2, 7, 'Second Bethel');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (45, 19, 2, 11, 'St Paul');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (46, 19, 2, 5, 'Thelma Mentor Chapel');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (47, 19, 2, 9, 'Tilo Memorial');

-- Orangia Conference (29 churches)
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (48, 19, 3, 15, 'AG MOKAU');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (49, 19, 3, 16, 'BETHEL MEMORIAL');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (50, 19, 3, 20, 'BETHEL OD');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (51, 19, 3, 20, 'BETHEL WESSELSBRON');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (52, 19, 3, 20, 'Bethel Wesselsbron');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (53, 19, 3, 21, 'Bethel, Frankfort');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (54, 19, 3, 15, 'DG MING');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (55, 19, 3, 19, 'DG MING MAKHAMBULENG CHAPEL');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (56, 19, 3, 15, 'EBENEZER');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (57, 19, 3, 16, 'EMMANUEL BOTHAVILLE');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (58, 19, 3, 20, 'EMMANUEL BULTFONTEIN');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (59, 19, 3, 16, 'FC JAMES BLOEM');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (60, 19, 3, 16, 'FLOYD FLAKE ALLEN TEMPLE');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (61, 19, 3, 18, 'J.L DAVIS DENEYSVILLE');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (62, 19, 3, 17, 'MABOTE VILJOENSKROON');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (63, 19, 3, 19, 'MT HOREB HARRISMITH');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (64, 19, 3, 15, 'MT HOREB WELKOM');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (65, 19, 3, 19, 'MT PISGAH BETHLEHEM');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (66, 19, 3, 16, 'MT ZION BLOEM');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (67, 19, 3, 20, 'MT ZION HOOPSTAD');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (68, 19, 3, 18, 'MT ZION LINDLEY');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (69, 19, 3, 17, 'NEW GABASHANE VREDEFORT');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (70, 19, 3, 20, 'NJ LEMPE');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (71, 19, 3, 19, 'SABATA MACHESA CHAPEL MAKONG');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (72, 19, 3, 17, 'ST LEONARD PARYS');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (73, 19, 3, 19, 'ST PAUL CHAPEL NAMAHADI');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (74, 19, 3, 18, 'TRINITY SASOLBURG');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (75, 19, 3, 21, 'Tabernacle, Reitz');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (76, 19, 3, 18, 'XABA CHAPEL HEILBRON');

-- Mangena Maake Mokone Memorial Conference (61 churches)
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (77, 19, 4, 34, 'Aganang');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (78, 19, 4, 25, 'Agnes B Hilderbrand');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (79, 19, 4, 32, 'Anna Senatle');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (80, 19, 4, 23, 'Antioch Solomondale');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (81, 19, 4, 30, 'BETHEL AME CHURCH');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (82, 19, 4, 27, 'Bethel');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (83, 19, 4, 22, 'Charls Rathogwa Memorial');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (84, 19, 4, 33, 'Chirwa Memorial');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (85, 19, 4, 33, 'Chirwa Memorial ');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (86, 19, 4, 25, 'DG Ming Chapel');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (87, 19, 4, 27, 'DM Robinson');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (88, 19, 4, 22, 'E.M. Makhuvha');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (89, 19, 4, 27, 'Ebenezer');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (90, 19, 4, 29, 'Edith Ming');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (91, 19, 4, 26, 'Emmauel temple');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (92, 19, 4, 24, 'FC Cummings');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (93, 19, 4, 24, 'FC James Chapel');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (94, 19, 4, 31, 'Fh Gouw');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (95, 19, 4, 25, 'GINYA MEMORIAL');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (96, 19, 4, 22, 'H..B. Senatle');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (97, 19, 4, 34, 'H.J Brayant');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (98, 19, 4, 34, 'H.j Brayant');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (99, 19, 4, 23, 'HE Malaka Memorial');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (100, 19, 4, 24, 'Hickamn Chapel');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (101, 19, 4, 25, 'John E. Hunter Memorial');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (102, 19, 4, 23, 'John E. Hunter-Seshego');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (103, 19, 4, 32, 'KwaMhlanga');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (104, 19, 4, 31, 'Lake Bethesda');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (105, 19, 4, 28, 'Lebala temple');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (106, 19, 4, 30, 'MOUNT HOREB AMEC');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (107, 19, 4, 28, 'Mable D. Ming');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (108, 19, 4, 33, 'Madiga Memorial');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (109, 19, 4, 22, 'Mara Curcuit');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (110, 19, 4, 28, 'Mathibe memorial');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (111, 19, 4, 33, 'Mogwase AME');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (112, 19, 4, 31, 'Mokone Temple');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (113, 19, 4, 33, 'Monnakato');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (114, 19, 4, 27, 'Mount Olivet');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (115, 19, 4, 31, 'Mount Zion');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (116, 19, 4, 32, 'Mt Sinai');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (117, 19, 4, 32, 'Nellmapius');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (118, 19, 4, 29, 'New Bethel');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (119, 19, 4, 26, 'Nkosi Memorial');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (120, 19, 4, 26, 'Ntwane memorial');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (121, 19, 4, 29, 'Polokwane Circuit');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (122, 19, 4, 34, 'R.C Kgopong');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (123, 19, 4, 30, 'RICHARD MPONYA AME');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (124, 19, 4, 29, 'SPS Chesane');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (125, 19, 4, 25, 'SS Manyane');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (126, 19, 4, 22, 'Sibasa Circuit');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (127, 19, 4, 22, 'Songozwi Curcuit');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (128, 19, 4, 23, 'T.R Kgarose');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (129, 19, 4, 33, 'Thabazimbi  AME');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (130, 19, 4, 32, 'The Ark');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (131, 19, 4, 32, 'The Diamond');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (132, 19, 4, 24, 'Thomas Morumodi');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (133, 19, 4, 29, 'Thorometjane');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (134, 19, 4, 31, 'WN Nduna');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (135, 19, 4, 28, 'William White');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (136, 19, 4, 31, 'Wn Nduna');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (137, 19, 4, 28, 'jerusalema E Ncha');

-- East Conference (59 churches)
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (138, 19, 5, 41, 'Amission Mokoena  Memorial');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (139, 19, 5, 41, 'Bethel');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (140, 19, 5, 36, 'Bryant Memorial');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (141, 19, 5, 44, 'C.D Nthoba');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (142, 19, 5, 37, 'C.G Henning Snr Temple.');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (143, 19, 5, 45, 'C.L Opperman');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (144, 19, 5, 43, 'Calvary Chapel');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (145, 19, 5, 38, 'Charlotte Maxeke');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (146, 19, 5, 43, 'Coan Chapel');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (147, 19, 5, 44, 'D Hunter');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (148, 19, 5, 36, 'D.M Robinson');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (149, 19, 5, 44, 'DM Robinson');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (150, 19, 5, 42, 'DWAI DWAI MEMORIAL');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (151, 19, 5, 39, 'Diepsloot AME');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (152, 19, 5, 38, 'E.M Gordon');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (153, 19, 5, 43, 'Emmanuel Chapel');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (154, 19, 5, 37, 'Emmanuel Temple');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (155, 19, 5, 42, 'Emmanuel Temple AMEC');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (156, 19, 5, 40, 'FM GOW MEMORIAL');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (157, 19, 5, 45, 'FM Gow');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (158, 19, 5, 39, 'First AME');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (159, 19, 5, 37, 'GD Robinson');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (160, 19, 5, 40, 'Grace AME Church');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (161, 19, 5, 36, 'H.B Senatle');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (162, 19, 5, 36, 'HB Senatle');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (163, 19, 5, 38, 'I.H Bonner');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (164, 19, 5, 45, 'JP Mthombeni');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (165, 19, 5, 42, 'Jappie Tantsi Memorial AMEC');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (166, 19, 5, 37, 'Jordan Temple');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (167, 19, 5, 37, 'JordanTemple');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (168, 19, 5, 45, 'Kabkoweni');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (169, 19, 5, 45, 'Kabokweni');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (170, 19, 5, 35, 'L.W Ntloko Memoria');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (171, 19, 5, 35, 'L.W Ntloko Memorial');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (172, 19, 5, 38, 'M.M Mokone Memorial');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (173, 19, 5, 38, 'M.M.Mokone Memorial');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (174, 19, 5, 45, 'MS Khoza');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (175, 19, 5, 45, 'Masibambisane');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (176, 19, 5, 39, 'Mokone Memorial');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (177, 19, 5, 43, 'Nazareth Chapel');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (178, 19, 5, 35, 'O.L Sherman');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (179, 19, 5, 41, 'Peraseverance Duduza');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (180, 19, 5, 41, 'Perseverance  Duduza');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (181, 19, 5, 41, 'Perseverance Duduza');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (182, 19, 5, 41, 'Perseverance Tsakane');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (183, 19, 5, 40, 'R.R Wright Temple');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (184, 19, 5, 42, 'RS Thelela AMEC');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (185, 19, 5, 37, 'Robinson Temple');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (186, 19, 5, 38, 'Second Bethel');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (187, 19, 5, 44, 'Senatle-Ming, Rust-ter-Vaal');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (188, 19, 5, 39, 'Sims Tabernacle');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (189, 19, 5, 40, 'Sir Thomas A.M.E');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (190, 19, 5, 35, 'St. Peter');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (191, 19, 5, 35, 'Theo Mareka');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (192, 19, 5, 36, 'Trinity');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (193, 19, 5, 39, 'WM Ndlazi');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (194, 19, 5, 36, 'Wedel');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (195, 19, 5, 36, 'Wedela');
INSERT INTO churches (church_id, district_id, conference_id, area_id, local_church_name) VALUES (196, 19, 5, 43, 'Z.S Mthembu Tabernacle');

SET foreign_key_checks = 1;

-- ============================================================
-- Verify counts
-- ============================================================
SELECT 'conferences' AS tbl, COUNT(*) AS row_count FROM conferences
UNION ALL SELECT 'areas', COUNT(*) FROM areas
UNION ALL SELECT 'churches', COUNT(*) FROM churches;
