-- Renames the cricket competition "Women's Premier League" to "WPL",
-- matching how the site already shortens its sibling T20 leagues
-- (IPL, BBL, PSL, etc.) rather than spelling them out.

update competitions
set name = 'WPL'
where slug = 'wpl' and sport_slug = 'cricket';
