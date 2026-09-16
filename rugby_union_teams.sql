-- Adds four rugby union competitions under the existing rugby-union
-- sport: the English Premiership and RFU Championship, Super Rugby
-- Pacific, and International (Men) with 46 nations. Safe to re-run.
--
-- Colours reuse the same national palette as the equivalent football/
-- cricket/basketball entries where the identity is the same flag/kit
-- colours; smaller unions and English club sides are lower-confidence
-- placeholders.

insert into competitions (slug, sport_slug, name, tier) values
  ('premiership-rugby','rugby-union','Premiership','top'),
  ('rfu-championship','rugby-union','RFU Championship','more'),
  ('super-rugby-pacific','rugby-union','Super Rugby Pacific','top'),
  ('international-rugby-union-men','rugby-union','International (Men)','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('bath','premiership-rugby','Bath','#002664','#000000'),
  ('bristol-bears','premiership-rugby','Bristol Bears','#002664','#00AEEF'),
  ('exeter-chiefs','premiership-rugby','Exeter Chiefs','#000000','#FFFFFF'),
  ('gloucester','premiership-rugby','Gloucester','#CE1126','#FFFFFF'),
  ('harlequins','premiership-rugby','Harlequins','#000000','#EC008C'),
  ('leicester-tigers','premiership-rugby','Leicester Tigers','#00693E','#CE1126'),
  ('newcastle-falcons','premiership-rugby','Newcastle Falcons','#000000','#F57F17'),
  ('northampton-saints','premiership-rugby','Northampton Saints','#000000','#00693E'),
  ('sale-sharks','premiership-rugby','Sale Sharks','#002664','#0033A0'),
  ('saracens','premiership-rugby','Saracens','#000000','#CE1126')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('ampthill','rfu-championship','Ampthill','#000000','#FFD700'),
  ('bedford-blues','rfu-championship','Bedford Blues','#002664','#FFFFFF'),
  ('caldy','rfu-championship','Caldy','#00693E','#FFFFFF'),
  ('cambridge','rfu-championship','Cambridge','#87CEEB','#000000'),
  ('chinnor','rfu-championship','Chinnor','#000000','#FFD700'),
  ('cornish-pirates','rfu-championship','Cornish Pirates (formerly Penzance and Newlyn)','#000000','#FFD700'),
  ('coventry','rfu-championship','Coventry','#002664','#87CEEB'),
  ('doncaster-knights','rfu-championship','Doncaster Knights','#6A0032','#FFFFFF'),
  ('ealing-trailfinders','rfu-championship','Ealing Trailfinders','#003893','#FFD700'),
  ('hartpury-university','rfu-championship','Hartpury University','#00693E','#FFFFFF'),
  ('london-scottish','rfu-championship','London Scottish','#00205B','#FFFFFF'),
  ('nottingham','rfu-championship','Nottingham','#00693E','#FFFFFF'),
  ('richmond','rfu-championship','Richmond','#CE1126','#000000'),
  ('worcester','rfu-championship','Worcester','#FFD700','#000000')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('act-brumbies','super-rugby-pacific','ACT Brumbies','#FFD700','#002664'),
  ('queensland-reds','super-rugby-pacific','Queensland Reds','#CE1126','#FFFFFF'),
  ('new-south-wales-waratahs','super-rugby-pacific','New South Wales Waratahs','#00AEEF','#002664'),
  ('western-force','super-rugby-pacific','Western Force','#002664','#B87333'),
  ('fijian-drua','super-rugby-pacific','Fijian Drua','#002664','#00AEEF'),
  ('blues','super-rugby-pacific','Blues','#002664','#FFFFFF'),
  ('chiefs','super-rugby-pacific','Chiefs','#CE1126','#000000'),
  ('crusaders','super-rugby-pacific','Crusaders','#CE1126','#000000'),
  ('highlanders','super-rugby-pacific','Highlanders','#002664','#FFD700'),
  ('hurricanes','super-rugby-pacific','Hurricanes','#FFD700','#000000')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('argentina','international-rugby-union-men','Argentina','#75AADB','#FFFFFF'),
  ('australia','international-rugby-union-men','Australia','#FFD700','#00843D'),
  ('england','international-rugby-union-men','England','#FFFFFF','#CF081F'),
  ('fiji','international-rugby-union-men','Fiji','#71C5E8','#FFFFFF'),
  ('france','international-rugby-union-men','France','#002654','#FFFFFF'),
  ('ireland','international-rugby-union-men','Ireland','#169B62','#FFFFFF'),
  ('italy','international-rugby-union-men','Italy','#0F4C81','#FFFFFF'),
  ('japan','international-rugby-union-men','Japan','#BC002D','#FFFFFF'),
  ('new-zealand','international-rugby-union-men','New Zealand','#000000','#FFFFFF'),
  ('south-africa','international-rugby-union-men','South Africa','#007A4D','#FFB612'),
  ('scotland','international-rugby-union-men','Scotland','#00205B','#FFFFFF'),
  ('wales','international-rugby-union-men','Wales','#C8102E','#FFFFFF'),
  ('canada','international-rugby-union-men','Canada','#FF0000','#FFFFFF'),
  ('chile','international-rugby-union-men','Chile','#D52B1E','#FFFFFF'),
  ('georgia','international-rugby-union-men','Georgia','#FFFFFF','#FF0000'),
  ('namibia','international-rugby-union-men','Namibia','#003580','#D21034'),
  ('portugal','international-rugby-union-men','Portugal','#FF0000','#046A38'),
  ('romania','international-rugby-union-men','Romania','#FCD116','#002B7F'),
  ('samoa','international-rugby-union-men','Samoa','#002B7F','#CE1126'),
  ('spain','international-rugby-union-men','Spain','#C60B1E','#FFC400'),
  ('andorra','international-rugby-union-men','Andorra','#0018A8','#FEDF00'),
  ('austria','international-rugby-union-men','Austria','#ED2939','#FFFFFF'),
  ('bosnia-and-herzegovina','international-rugby-union-men','Bosnia and Herzegovina','#002395','#FECB00'),
  ('bulgaria','international-rugby-union-men','Bulgaria','#FFFFFF','#00966E'),
  ('croatia','international-rugby-union-men','Croatia','#FF0000','#FFFFFF'),
  ('cyprus','international-rugby-union-men','Cyprus','#FFFFFF','#D57800'),
  ('czech-republic','international-rugby-union-men','Czech Republic','#D7141A','#11457E'),
  ('denmark','international-rugby-union-men','Denmark','#C60C30','#FFFFFF'),
  ('finland','international-rugby-union-men','Finland','#002F6C','#FFFFFF'),
  ('greece','international-rugby-union-men','Greece','#0D5EAF','#FFFFFF'),
  ('hungary','international-rugby-union-men','Hungary','#CD2A3E','#436F4D'),
  ('latvia','international-rugby-union-men','Latvia','#9E3039','#FFFFFF'),
  ('lithuania','international-rugby-union-men','Lithuania','#FDB913','#006A44'),
  ('luxembourg','international-rugby-union-men','Luxembourg','#ED2939','#00A1DE'),
  ('malta','international-rugby-union-men','Malta','#CE1126','#FFFFFF'),
  ('moldova','international-rugby-union-men','Moldova','#0033A0','#FFD200'),
  ('monaco','international-rugby-union-men','Monaco','#CE1126','#FFFFFF'),
  ('montenegro','international-rugby-union-men','Montenegro','#C40308','#D4AF37'),
  ('norway','international-rugby-union-men','Norway','#BA0C2F','#00205B'),
  ('poland','international-rugby-union-men','Poland','#DC143C','#FFFFFF'),
  ('serbia','international-rugby-union-men','Serbia','#C6363C','#0C4076'),
  ('slovakia','international-rugby-union-men','Slovakia','#0B4EA2','#EE1C25'),
  ('slovenia','international-rugby-union-men','Slovenia','#005DA4','#FFFFFF'),
  ('sweden','international-rugby-union-men','Sweden','#006AA7','#FECC02'),
  ('switzerland','international-rugby-union-men','Switzerland','#D52B1E','#FFFFFF'),
  ('ukraine','international-rugby-union-men','Ukraine','#005BBB','#FFD500')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
