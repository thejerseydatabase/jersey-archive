-- Shortens "Six Nations Championship" to just "Six Nations".

update competitions
set name = 'Six Nations'
where slug = 'six-nations-championship' and sport_slug = 'rugby-union';
