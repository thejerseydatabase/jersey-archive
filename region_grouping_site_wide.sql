-- Extends the country/region grouping (built for rugby league and
-- football) to every other sport's "More competitions" section:
-- cricket, rugby union, AFL, Gridiron, baseball, and ice hockey.
-- Basketball, netball, field hockey and volleyball currently have no
-- "more"-tier competitions at all, so there's nothing to tag there yet.
--
-- A few explicitly multi-country competitions (Súper Rugby Américas,
-- the Caribbean Premier Leagues, the European T20 Premier League) are
-- grouped by region rather than a single country, same as you asked —
-- everything else gets its actual country. Safe to re-run.

-- ============ Cricket ============
update competitions set region_group = 'Australia' where slug in ('dean-jones-cup','australia-domestic','australia-domestic-women');
update competitions set region_group = 'England' where slug in ('county-championship','one-day-cup','england-domestic');
update competitions set region_group = 'India' where slug = 'wpl';
update competitions set region_group = 'Afghanistan' where slug = 'afghanistan-domestic';
update competitions set region_group = 'Bangladesh' where slug = 'bpl';
update competitions set region_group = 'Ireland' where slug = 'ireland-domestic';
update competitions set region_group = 'Nepal' where slug = 'nepal-domestic';
update competitions set region_group = 'Canada' where slug in ('canada-t10','canada-t20');
update competitions set region_group = 'South Africa' where slug = 'sa20';
update competitions set region_group = 'Sri Lanka' where slug = 'lpl';
update competitions set region_group = 'UAE' where slug = 'ilt20';
update competitions set region_group = 'USA' where slug = 'mlc';
update competitions set region_group = 'Caribbean' where slug in ('cpl','wcpl');
update competitions set region_group = 'New Zealand' where slug in ('new-zealand-domestic','new-zealand-domestic-women');
update competitions set region_group = 'Belgium' where slug = 'eut20-belgium';
update competitions set region_group = 'Europe' where slug = 'etpl';
update competitions set region_group = 'Pakistan' where slug = 'psl';

-- ============ Rugby union ============
update competitions set region_group = 'South Africa' where slug = 'currie-cup';
update competitions set region_group = 'Americas' where slug = 'super-rugby-americas';
update competitions set region_group = 'USA' where slug in ('mlr','wer');
update competitions set region_group = 'Japan' where slug = 'japan-rugby-league-one';
update competitions set region_group = 'England' where slug in ('pwr','rfu-championship');
update competitions set region_group = 'France' where slug in ('top-14','pro-d2');
update competitions set region_group = 'Italy' where slug = 'serie-a-elite';
update competitions set region_group = 'Scotland' where slug = 'scottish-premiership-rugby';
update competitions set region_group = 'Australia' where slug in ('shute-shield','queensland-premier-rugby');
update competitions set region_group = 'New Zealand' where slug = 'super-rugby-aupiki';

-- ============ AFL ============
update competitions set region_group = 'Australia' where slug = 'vfl';

-- ============ Gridiron ============
update competitions set region_group = 'Canada' where slug = 'cfl';

-- ============ Baseball ============
update competitions set region_group = 'Australia' where slug = 'abl';
update competitions set region_group = 'Japan' where slug = 'npb';

-- ============ Ice hockey ============
update competitions set region_group = 'Australia' where slug in ('aihl','awihl');
