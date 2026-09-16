-- Colour corrections for a few fallback team swatches (only visible until
-- each team's real logo is uploaded). Safe to re-run.

update teams set primary_color = '#00457C', secondary_color = '#D0202F'
  where slug = 'new-zealand-warriors' and competition_slug in ('nrl','nrlw');

update teams set primary_color = '#00AEEF', secondary_color = '#00263A'
  where slug = 'gold-coast-titans' and competition_slug in ('nrl','nrlw');

update teams set primary_color = '#E2231A', secondary_color = '#FFFFFF'
  where slug = 'dolphins' and competition_slug = 'nrl';

update teams set primary_color = '#000000', secondary_color = '#E4007C'
  where slug = 'penrith-panthers' and competition_slug = 'nrl';

update teams set primary_color = '#3E1F55', secondary_color = '#FDB714'
  where slug = 'melbourne-storm' and competition_slug = 'nrl';
