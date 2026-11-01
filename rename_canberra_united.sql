-- Canberra United is a women's-only team at the moment (no men's A-League
-- side), so its A-League Women entry should read "Canberra United Women"
-- like every other club in that competition (Sydney FC Women, Adelaide
-- United Women, etc.) rather than "Canberra United FC". Renaming the slug
-- to match that same pattern too, not just the display name.
--
-- Safe to re-run.

update teams
set name = 'Canberra United Women', slug = 'canberra-united-women'
where competition_slug = 'a-league-women' and slug = 'canberra-united-fc';
