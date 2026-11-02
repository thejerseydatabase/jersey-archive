-- Adds the Welsh Premier Division (WRU Premiership) clubs, skipping
-- Neath since a team row for them already exists (1991-92 jersey
-- already uploaded). Rather than guess which competition_slug Neath
-- already lives under and risk creating a second "Welsh Premiership"
-- competition row (and so an accidental duplicate, same mistake as the
-- Hull City/Chelsea FC ones fixed earlier this session), this looks up
-- Neath's actual competition_slug at runtime and reuses it. Only
-- creates a brand new "wru-premiership" competition as a fallback, in
-- the unlikely case Neath isn't found at all.
--
-- Colors: researched per club, confidence varies a lot - several of
-- these are small amateur clubs with almost no color info findable
-- online.
--   Confident: Cross Keys (black/white), Pontypridd (black/white,
--     multiple sources incl. their own site).
--   Reasonable but dated/secondary sources: Ystrad Rhondda (royal
--     blue/blue hoops, black shorts), Llanelli Wanderers (scarlet/white,
--     as a Scarlets feeder club), Beddau (green/gold, an older listing).
--   Essentially placeholders, not verified anywhere - double check
--     these if you know the real ones: Bargoed, Brecon, Cardiff Met,
--     Llangennech, Merthyr (conflicting info found - NOT black/amber,
--     that's Newport's), Narberth, Newbridge.
--
-- Safe to re-run.

do $$
declare
  comp_slug text;
begin
  select t.competition_slug into comp_slug
  from teams t
  join competitions c on c.slug = t.competition_slug
  where c.sport_slug = 'rugby-union' and t.name ilike '%neath%'
  limit 1;

  if comp_slug is null then
    insert into competitions (slug, sport_slug, name, tier, region_group) values
      ('wru-premiership', 'rugby-union', 'WRU Premiership', 'more', 'Wales')
    on conflict (slug) do nothing;
    comp_slug := 'wru-premiership';
  end if;

  insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
    ('bargoed', comp_slug, 'Bargoed RFC', '#002664', '#FFFFFF'),
    ('beddau', comp_slug, 'Beddau RFC', '#00843D', '#FFD700'),
    ('brecon', comp_slug, 'Brecon RFC', '#000000', '#FFFFFF'),
    ('cardiff-met', comp_slug, 'Cardiff Met RFC', '#002664', '#FFD700'),
    ('cross-keys', comp_slug, 'Cross Keys RFC', '#000000', '#FFFFFF'),
    ('llanelli-wanderers', comp_slug, 'Llanelli Wanderers RFC', '#CE1126', '#FFFFFF'),
    ('llangennech', comp_slug, 'Llangennech RFC', '#CE1126', '#FFFFFF'),
    ('merthyr', comp_slug, 'Merthyr RFC', '#6A0032', '#FFD700'),
    ('narberth', comp_slug, 'Narberth RFC', '#002664', '#FFFFFF'),
    ('newbridge', comp_slug, 'Newbridge RFC', '#CE1126', '#000000'),
    ('pontypridd', comp_slug, 'Pontypridd RFC', '#000000', '#FFFFFF'),
    ('ystrad-rhondda', comp_slug, 'Ystrad Rhondda RFC', '#002664', '#000000')
  on conflict (competition_slug, slug) do update
    set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
end $$;
