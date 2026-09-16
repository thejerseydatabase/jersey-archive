-- Adds the International (Women) competition with a shortlist of the
-- better-known women's national teams from your list — not every nation
-- that plays women's football, since uploads for most of those are
-- unlikely any time soon and it's easy to add more later. Colours match
-- each team's men's counterpart where the flag/kit identity is shared.

insert into competitions (slug, sport_slug, name, tier) values
  ('international-women','football','International (Women)','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('usa-women','international-women','USA Women','#002868','#BF0D3E'),
  ('england-women','international-women','England Women','#FFFFFF','#CF081F'),
  ('germany-women','international-women','Germany Women','#FFFFFF','#000000'),
  ('brazil-women','international-women','Brazil Women','#FFDF00','#009739'),
  ('france-women','international-women','France Women','#002654','#FFFFFF'),
  ('spain-women','international-women','Spain Women','#C60B1E','#FFC400'),
  ('netherlands-women','international-women','Netherlands Women','#FF6C00','#FFFFFF'),
  ('canada-women','international-women','Canada Women','#FF0000','#FFFFFF'),
  ('norway-women','international-women','Norway Women','#BA0C2F','#00205B'),
  ('italy-women','international-women','Italy Women','#0F4C81','#FFFFFF'),
  ('argentina-women','international-women','Argentina Women','#75AADB','#FFFFFF'),
  ('colombia-women','international-women','Colombia Women','#FCD116','#003893'),
  ('china-women','international-women','China Women','#DE2910','#FFDE00'),
  ('scotland-women','international-women','Scotland Women','#00205B','#FFFFFF'),
  ('switzerland-women','international-women','Switzerland Women','#D52B1E','#FFFFFF'),
  ('mexico-women','international-women','Mexico Women','#006847','#FFFFFF'),
  ('wales-women','international-women','Wales Women','#C8102E','#FFFFFF'),
  ('new-zealand-women','international-women','New Zealand Women','#FFFFFF','#000000')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
