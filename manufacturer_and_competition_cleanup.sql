-- Two independent, low-risk cleanups:
--
-- 1. Merges "Classic" into "Classic Sportswear" on every jersey already
--    tagged with it, so the same real-world manufacturer doesn't show as
--    two different ones just because the dropdown used to offer the
--    shorter name. (The dropdown itself is already fixed in code.)
--
-- 2. A first pass at competition sort_order, so the competitions most
--    people will actually be uploading to lead the list instead of
--    whatever's alphabetically first. This only touches competitions
--    matched by name — anything whose name doesn't match exactly is
--    silently skipped (no error, no harm), so if a competition here is
--    named slightly differently on your site, just let me know and I'll
--    fix the match. Nothing here touches cricket, since that was already
--    hand-ordered earlier (International/IPL/BBL/Australia Domestic).
--
-- Safe to re-run either section.

update jerseys set manufacturer = 'Classic Sportswear' where manufacturer = 'Classic';

-- Football / soccer
update competitions set sort_order = 1 where name = 'Premier League';
update competitions set sort_order = 2 where name = 'A-League' or name = 'A-League Men';
update competitions set sort_order = 3 where name = 'MLS';
update competitions set sort_order = 4 where name = 'Bundesliga';
update competitions set sort_order = 5 where name = 'Serie A';
update competitions set sort_order = 6 where name ilike 'International%' and sport_slug = (select slug from sports where name ilike '%football%' or name ilike '%soccer%' limit 1);
update competitions set sort_order = 7 where name = 'A-League Women';

-- Rugby league
update competitions set sort_order = 1 where name = 'NRL';
update competitions set sort_order = 2 where name = 'Super League';
update competitions set sort_order = 3 where name = 'NRLW';
update competitions set sort_order = 4 where name ilike 'State of Origin%';
update competitions set sort_order = 5 where name = 'RFL Championship';
update competitions set sort_order = 6 where name = 'QLD Cup';
update competitions set sort_order = 7 where name = 'NSW Cup';

-- Basketball
update competitions set sort_order = 1 where name = 'NBA';
update competitions set sort_order = 2 where name = 'NBL';
update competitions set sort_order = 3 where name = 'WNBL';

-- Rugby union
update competitions set sort_order = 1 where name = 'Super Rugby Pacific';
update competitions set sort_order = 2 where name = 'Gallagher Premiership';
update competitions set sort_order = 3 where name = 'NPC';
update competitions set sort_order = 4 where name = 'Super Rugby Pacific Women';

-- Aussie rules
update competitions set sort_order = 1 where name = 'AFL';
update competitions set sort_order = 2 where name = 'AFLW';

-- Ice hockey
update competitions set sort_order = 1 where name = 'NHL';
update competitions set sort_order = 2 where name = 'AIHL';
