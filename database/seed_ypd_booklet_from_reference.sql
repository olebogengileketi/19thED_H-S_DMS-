-- Seed YPD booklet content from the reference ypd-booklet app
-- Only inserts into empty tables; safe to run once.
USE `19edypd_db`;

-- Update the single booklet meta row with reference content
UPDATE ypd_booklet_meta SET district_name = '19th Episcopal District', booklet_title = 'Grow, Glow, and Go: A History of the YPD', subtitle = 'Young People''s Division — 19th Episcopal District, AME Church', foreword = 'This booklet preserves the story of our District''s Young People''s Division — its leaders, milestones, and the young people who carried its mission forward. Compiled and maintained by the Office of the Historiographer/Statistician.', historiographer_name = 'Test User', published_year = 2026 WHERE id = (SELECT id FROM (SELECT MIN(id) AS id FROM ypd_booklet_meta) x);
INSERT INTO ypd_booklet_meta (district_name, booklet_title, subtitle, foreword, historiographer_name, published_year) SELECT '19th Episcopal District', 'Grow, Glow, and Go: A History of the YPD', 'Young People''s Division — 19th Episcopal District, AME Church', 'This booklet preserves the story of our District''s Young People''s Division — its leaders, milestones, and the young people who carried its mission forward. Compiled and maintained by the Office of the Historiographer/Statistician.', 'Test User', 2026 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM ypd_booklet_meta);

-- ypd_history_entries (5 rows)
INSERT INTO `ypd_history_entries` (`era_label`, `title`, `body`, `sort_order`)
SELECT t.* FROM (
    SELECT 'Founding' AS `era_label`, 'Origins under the Women''s Missionary Society' AS `title`, 'The Young People''s and Children''s Division (YPD) was organized in October 1915 under the auspices of the Women''s Missionary Society (WMS) of the African Methodist Episcopal Church, continuing a pattern in the AME Church of forming a youth auxiliary alongside each senior organization. The WMS itself traces to 1874 and the Women''s Parent Mite Missionary Society.' AS `body`, '1' AS `sort_order`
    UNION ALL
    SELECT 'Mission' AS `era_label`, 'Purpose and Training Focus' AS `title`, 'The YPD provides youth training and leadership development across the life of the Church, with specific programs in Evangelism, Christian Social Relations, and Education, designed to connect young people to the Church''s mission and deepen their knowledge of AME history and scripture.' AS `body`, '2' AS `sort_order`
    UNION ALL
    SELECT 'Structure' AS `era_label`, 'From Local Church to Connectional Body' AS `title`, 'The YPD is organized at the Local Church, Area, Conference Branch, Episcopal District, and Connectional levels. This booklet documents the story of the YPD at the 19th Episcopal District level — its officers, milestones, and members over time.' AS `body`, '3' AS `sort_order`
    UNION ALL
    SELECT 'Growth' AS `era_label`, 'Expansion and Development' AS `title`, 'Throughout the decades, the YPD has grown from a small auxiliary to a major force within the AME Church, developing programs that address youth needs while maintaining connection to the Church''s founding principles of social justice, education, and spiritual growth.' AS `body`, '4' AS `sort_order`
    UNION ALL
    SELECT 'Modern Era' AS `era_label`, 'Contemporary Mission and Impact' AS `title`, 'Today''s YPD continues to adapt to meet the needs of new generations while honoring its rich heritage. Programs now include digital ministry, community service initiatives, leadership conferences, and partnerships with other denominational youth organizations.' AS `body`, '5' AS `sort_order`
) t WHERE NOT EXISTS (SELECT 1 FROM `ypd_history_entries`);

-- ypd_officers (4 rows)
INSERT INTO `ypd_officers` (`full_name`, `position`, `term_start`, `term_end`, `bio`, `sort_order`)
SELECT t.* FROM (
    SELECT 'Rev. Dr. Sarah Johnson' AS `full_name`, 'District President' AS `position`, '2023' AS `term_start`, '2026' AS `term_end`, 'Leading the 19th Episcopal District YPD with a focus on youth empowerment and digital ministry initiatives. Previously served as Conference Branch President for 8 years.' AS `bio`, '1' AS `sort_order`
    UNION ALL
    SELECT 'Michelle Williams' AS `full_name`, 'Historiographer/Statistician' AS `position`, '2022' AS `term_start`, '2026' AS `term_end`, 'Responsible for maintaining the District''s historical records and membership statistics. Passionate about preserving YPD history for future generations.' AS `bio`, '2' AS `sort_order`
    UNION ALL
    SELECT 'James Thompson' AS `full_name`, 'Vice President' AS `position`, '2023' AS `term_start`, '2026' AS `term_end`, 'Coordinating district-wide youth programs and conventions. Has been active in YPD leadership for over 15 years.' AS `bio`, '3' AS `sort_order`
    UNION ALL
    SELECT 'Patricia Davis' AS `full_name`, 'Secretary' AS `position`, '2023' AS `term_start`, '2026' AS `term_end`, 'Managing district communications and meeting records. Also serves as the newsletter editor for the District.' AS `bio`, '4' AS `sort_order`
) t WHERE NOT EXISTS (SELECT 1 FROM `ypd_officers`);

-- ypd_timeline_events (5 rows)
INSERT INTO `ypd_timeline_events` (`event_date`, `title`, `description`, `sort_order`)
SELECT t.* FROM (
    SELECT '1915' AS `event_date`, 'YPD organized under the Women''s Missionary Society' AS `title`, 'The Young People''s and Children''s Division is founded to give the AME Church''s youth a structured place in the Church''s mission and leadership pipeline.' AS `description`, '1' AS `sort_order`
    UNION ALL
    SELECT '1950' AS `event_date`, '19th District YPD Formal Establishment' AS `title`, 'The 19th Episcopal District formally establishes its YPD structure with appointed officers and regular conferences.' AS `description`, '2' AS `sort_order`
    UNION ALL
    SELECT '1985' AS `event_date`, 'First District Youth Convention' AS `title`, 'The 19th District holds its first dedicated youth convention, bringing together YPD members from across the district for worship and leadership training.' AS `description`, '3' AS `sort_order`
    UNION ALL
    SELECT '2000' AS `event_date`, 'Millennium Youth Leadership Summit' AS `title`, 'A special summit focused on preparing YPD leaders for the new century with emphasis on technology and modern ministry methods.' AS `description`, '4' AS `sort_order`
    UNION ALL
    SELECT '2020' AS `event_date`, 'Digital Ministry Transition' AS `title`, 'In response to global challenges, the District YPD successfully transitions to hybrid meetings and digital programming, maintaining youth engagement.' AS `description`, '5' AS `sort_order`
) t WHERE NOT EXISTS (SELECT 1 FROM `ypd_timeline_events`);

-- ypd_achievements (4 rows)
INSERT INTO `ypd_achievements` (`title`, `description`, `achievement_date`, `category`, `sort_order`)
SELECT t.* FROM (
    SELECT 'Community Food Drive Initiative' AS `title`, 'District YPD members organized a comprehensive food drive serving over 500 families across the district, demonstrating commitment to community service.' AS `description`, '2023' AS `achievement_date`, 'Outreach' AS `category`, '1' AS `sort_order`
    UNION ALL
    SELECT 'Youth Leadership Scholarship Program' AS `title`, 'Established a scholarship fund supporting 10 outstanding YPD members pursuing higher education with focus on community leadership.' AS `description`, '2022' AS `achievement_date`, 'Education' AS `category`, '2' AS `sort_order`
    UNION ALL
    SELECT 'Regional Conference Host' AS `title`, 'Successfully hosted the connectional YPD regional conference, welcoming delegates from 12 districts with exemplary organization and hospitality.' AS `description`, '2021' AS `achievement_date`, 'Leadership' AS `category`, '3' AS `sort_order`
    UNION ALL
    SELECT 'Digital Ministry Innovation Award' AS `title`, 'Recognized for excellence in digital ministry during the pandemic transition, developing online worship and fellowship programs.' AS `description`, '2020' AS `achievement_date`, 'Innovation' AS `category`, '4' AS `sort_order`
) t WHERE NOT EXISTS (SELECT 1 FROM `ypd_achievements`);

-- ypd_statistics (8 rows)
INSERT INTO `ypd_statistics` (`category`, `label`, `value`, `unit`, `year`, `sort_order`)
SELECT t.* FROM (
    SELECT 'Membership' AS `category`, 'Active YPD Members' AS `label`, '450.0' AS `value`, 'members' AS `unit`, '2024' AS `year`, '1' AS `sort_order`
    UNION ALL
    SELECT 'Chapters' AS `category`, 'Local Chapters in District' AS `label`, '24.0' AS `value`, 'chapters' AS `unit`, '2024' AS `year`, '2' AS `sort_order`
    UNION ALL
    SELECT 'Leadership' AS `category`, 'Trained Youth Leaders' AS `label`, '85.0' AS `value`, 'leaders' AS `unit`, '2024' AS `year`, '3' AS `sort_order`
    UNION ALL
    SELECT 'Programs' AS `category`, 'Annual Programs Hosted' AS `label`, '36.0' AS `value`, 'programs' AS `unit`, '2024' AS `year`, '4' AS `sort_order`
    UNION ALL
    SELECT 'Outreach' AS `category`, 'Community Service Hours' AS `label`, '2500.0' AS `value`, 'hours' AS `unit`, '2024' AS `year`, '5' AS `sort_order`
    UNION ALL
    SELECT 'Scholarships' AS `category`, 'Scholarships Awarded' AS `label`, '12.0' AS `value`, 'students' AS `unit`, '2024' AS `year`, '6' AS `sort_order`
    UNION ALL
    SELECT 'Membership' AS `category`, 'Active YPD Members' AS `label`, '420.0' AS `value`, 'members' AS `unit`, '2023' AS `year`, '7' AS `sort_order`
    UNION ALL
    SELECT 'Chapters' AS `category`, 'Local Chapters in District' AS `label`, '22.0' AS `value`, 'chapters' AS `unit`, '2023' AS `year`, '8' AS `sort_order`
) t WHERE NOT EXISTS (SELECT 1 FROM `ypd_statistics`);

-- photos (3 rows)
INSERT INTO `photos` (`filename`, `caption`, `related_type`, `related_id`)
SELECT t.* FROM (
    SELECT 'ypd_convention_2023.jpg' AS `filename`, '2023 District YPD Convention group photo' AS `caption`, NULL AS `related_type`, NULL AS `related_id`
    UNION ALL
    SELECT 'leadership_team_2024.jpg' AS `filename`, '2024 District Leadership Team' AS `caption`, NULL AS `related_type`, NULL AS `related_id`
    UNION ALL
    SELECT 'youth_summit_2022.jpg' AS `filename`, 'Youth Leadership Summit participants' AS `caption`, NULL AS `related_type`, NULL AS `related_id`
) t WHERE NOT EXISTS (SELECT 1 FROM `photos`);

