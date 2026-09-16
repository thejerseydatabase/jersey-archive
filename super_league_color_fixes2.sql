-- Second round of Super League fallback swatch colour corrections.

update teams set primary_color = '#C8102E', secondary_color = '#FFFFFF'
  where slug = 'leigh-leopards' and competition_slug = 'super-league';

update teams set primary_color = '#003DA5', secondary_color = '#FFFFFF'
  where slug = 'toulouse-olympique' and competition_slug = 'super-league';

update teams set primary_color = '#000000', secondary_color = '#FFD200'
  where slug = 'york-knights' and competition_slug = 'super-league';

update teams set primary_color = '#000000', secondary_color = '#8A1538'
  where slug = 'bradford-bulls' and competition_slug = 'super-league';
