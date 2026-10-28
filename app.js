(function(){

  var ICON_SHIRT = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" width="17" height="17"><path d="M8 3 5 5 2 8l3 3 2-1.5V21h10V9.5L19 11l3-3-3-3-3-2-2 2h-4z"/></svg>';
  var ICON_STAR = '<svg viewBox="0 0 24 24" fill="currentColor" width="21" height="21"><path d="M12 2.5l3.09 6.26 6.91 1-5 4.87L18.18 21.5 12 18.27 5.82 21.5 7 14.63l-5-4.87 6.91-1z"/></svg>';
  var ICON_PHOTO = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" width="26" height="26"><rect x="3" y="5" width="18" height="14" rx="2"/><circle cx="9" cy="11" r="2"/><path d="M3 17l5-4 4 3 3-2 6 5"/><path d="M17 3v4M15 5h4"/></svg>';
  var ICON_PENCIL = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" width="13" height="13"><path d="M12 20h9"/><path d="M16.5 3.5a2.12 2.12 0 0 1 3 3L7 19l-4 1 1-4 12.5-12.5z"/></svg>';
  var ICON_FLAG = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" width="13" height="13"><path d="M4 15s1-1 4-1 5 2 8 2 4-1 4-1V3s-1 1-4 1-5-2-8-2-4 1-4 1z"/><path d="M4 22V3"/></svg>';
  // Per-sport homepage icons — a sport not listed here (a brand new one
  // just added, say) falls back to the generic jersey icon rather than
  // erroring or showing nothing.
  var SPORT_ICONS = {
    cricket: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" width="17" height="17"><path d="M7 4v16M12 4v16M17 4v16"/><path d="M6 5h3M11 5h3M16 5h3"/></svg>',
    basketball: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" width="17" height="17"><circle cx="12" cy="12" r="9"/><path d="M12 3v18M3 12h18M5.5 5.5c2 2.5 2 12.5 0 15M18.5 5.5c-2 2.5-2 12.5 0 15"/></svg>',
    'american-football': '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" width="17" height="17"><ellipse cx="12" cy="12" rx="9" ry="5"/><path d="M7 12h10M9.5 10v4M12 10v4M14.5 10v4"/></svg>',
    'ice-hockey': '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" width="17" height="17"><path d="M19 3 9 19h4"/><ellipse cx="7" cy="20" rx="4" ry="1.4"/></svg>',
    'rugby-league': '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" width="17" height="17"><ellipse cx="12" cy="12" rx="5" ry="9" transform="rotate(45 12 12)"/><path d="M8.5 15.5 15.5 8.5"/></svg>',
    'rugby-union': '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" width="17" height="17"><ellipse cx="12" cy="12" rx="5" ry="9" transform="rotate(45 12 12)"/><path d="M8.5 15.5 15.5 8.5"/></svg>',
    football: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" width="17" height="17"><circle cx="12" cy="12" r="9"/><path d="M12 7l3 2.2-1.1 3.6H10.1L9 9.2z"/><path d="M12 7V4M15 9.2l2.6-1.7M13.9 12.8l1.6 2.9M10.1 12.8l-1.6 2.9M9 9.2 6.4 7.5"/></svg>',
    baseball: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" width="17" height="17"><circle cx="12" cy="12" r="9"/><path d="M6 6c3 2 3 10 0 12M18 6c-3 2-3 10 0 12"/></svg>',
    afl: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" width="17" height="17"><path d="M5 21V5M19 21V5M3 5h4M17 5h4"/></svg>',
    netball: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" width="17" height="17"><ellipse cx="12" cy="6" rx="5" ry="1.6"/><circle cx="12" cy="16" r="5"/></svg>',
    volleyball: '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" width="17" height="17"><circle cx="12" cy="8" r="5"/><path d="M12 3c-2 2-2 8 0 10M8.5 4.5c1.5 2 6 2 7 0M8.5 11.5c1.5-2 6-2 7 0"/><path d="M3 20h18M3 20v-3M21 20v-3"/></svg>',
    'field-hockey': '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" width="17" height="17"><path d="M15 3v13c0 2-1.5 3-3 3s-2.5-1-2.5-2.2c0-1.3 1-2 2.2-2"/><circle cx="6" cy="20" r="1.6" fill="currentColor" stroke="none"/></svg>'
  };
  function sportIcon(sportSlug){ return SPORT_ICONS[sportSlug] || ICON_SHIRT; }
  // International formats paired with their domestic equivalent right
  // after (Test/First Class, ODI/One Day, T20I/T20, T10I/T10) — the "I"
  // suffix always means international. "All Formats" is last, for kit
  // that isn't tied to one (training tops, warm-ups) — a free-typed type
  // like "Training 2" can't be detected as training-related up front, so
  // this is a manual pick rather than something the form infers.
  var FORMATS_BY_SPORT = { cricket: ['Test','First Class','ODI','One Day','T20I','T20','T10I','T10','All Formats'] };
  // Keyed by sport slug (not name) since that's what f-sport's <option
  // value> holds. One big, obviously-recognisable club/country plus one
  // Australian one, mirroring the site's own Australia-first audience,
  // so "Manchester United, Melbourne Storm" (a football club shown while
  // uploading a cricket jersey) stops being the example no matter what's
  // selected.
  var TEAM_PLACEHOLDER_BY_SPORT = {
    'rugby-league': 'e.g. Penrith Panthers, Melbourne Storm',
    'cricket': 'e.g. Australia, Melbourne Stars',
    'football': 'e.g. Manchester United, Melbourne Victory',
    'rugby-union': 'e.g. Australia, Crusaders',
    'afl': 'e.g. Collingwood Magpies, Richmond Tigers',
    'american-football': 'e.g. Dallas Cowboys, Kansas City Chiefs',
    'basketball': 'e.g. Boston Celtics, Melbourne United',
    'baseball': 'e.g. New York Yankees, Perth Heat',
    'ice-hockey': 'e.g. Toronto Maple Leafs, Melbourne Ice',
    'netball': 'e.g. NSW Swifts, Melbourne Vixens',
    'field-hockey': 'e.g. Australia, Netherlands',
    'volleyball': 'e.g. Australia, Brazil',
    'lacrosse': 'e.g. Australia, Canada',
    'gaelic-football': 'e.g. Dublin, Kerry'
  };
  var DEFAULT_TEAM_PLACEHOLDER = 'e.g. Manchester United, Melbourne Storm';
  var COMPETITION_PLACEHOLDER_BY_SPORT = {
    'rugby-league': 'e.g. NRL, International',
    'cricket': 'e.g. International, BBL',
    'football': 'e.g. Premier League, International',
    'rugby-union': 'e.g. Super Rugby Pacific, International',
    'afl': 'e.g. AFL, AFLW',
    'american-football': 'e.g. NFL, CFL',
    'basketball': 'e.g. NBA, NBL',
    'baseball': 'e.g. ABL, International',
    'ice-hockey': 'e.g. NHL, International',
    'netball': 'e.g. International, Suncorp Super Netball',
    'field-hockey': 'e.g. International',
    'volleyball': 'e.g. AVL, International',
    'lacrosse': 'e.g. International',
    'gaelic-football': 'e.g. All-Ireland Championship'
  };
  var DEFAULT_COMPETITION_PLACEHOLDER = 'e.g. NRL, Premier League';
  // Every sport gets these (Training always last — see below); sports in
  // the per-slug list also get those on top, before Training. Indigenous
  // jerseys are a rugby league/union/AFL/netball thing (and a few others)
  // — not something football, cricket etc. have, so it's opt-in per
  // sport rather than shown everywhere (a one-off special jersey can
  // still be typed in via "+ Add a new one…"). Same story for ANZAC.
  var CURATED_TYPES_BASE = ['Home','Away','Third','Alternate','Heritage'];
  var CURATED_TYPES = CURATED_TYPES_BASE.concat(['Training']); // pre-mount placeholder only, see viewUpload
  var EXTRA_TYPES_BY_SPORT = {
    'rugby-league': ['Indigenous','ANZAC','Nines'],
    'rugby-union': ['Indigenous','ANZAC'],
    afl: ['Indigenous','ANZAC'],
    netball: ['Indigenous'],
    'field-hockey': ['Indigenous']
  };
  // A sport listed here replaces the global CURATED_TYPES_BASE list
  // entirely instead of just adding to it — cricket doesn't use
  // Heritage/Third the way other sports do, and has Charity that others
  // don't. Training is appended after these, same as everywhere else. A
  // one-off type outside this list is still addable via "+ Add a new
  // one…" on the upload form.
  var CURATED_TYPES_OVERRIDE_BY_SPORT = {
    cricket: ['Home','Away','Charity','Indigenous','Alternate']
  };
  // Picking "Training" reveals a second field for which kind, so
  // "pre-match", "warm up", "captain's run" etc. don't fragment into
  // inconsistent one-off type values — stored as "Training - Warm Up"
  // and collapsed back to the "Training" family by baseJerseyType() for
  // browsing, same way "Home V1"/"Home V2" collapse to "Home". Retro
  // isn't in here — that's a genuine match jersey, already covered by
  // the separate "Heritage" type. The plain numbered options exist for
  // "just another training top, nothing distinguishes it" — composeTrainingType()
  // below stores those as "Training 2" etc. rather than "Training - Training 2",
  // reserving the " - " form for an actually-named kind like Pre-match.
  var TRAINING_SUBTYPES = ['Training 2','Training 3','Training 4','Training 5','Pre-match','Warm Up','Captain\'s Run','Travel'];
  // A subtype that already starts with "Training" (the plain numbered
  // options above, or anyone typing their own "Training 6") is used as-is;
  // anything else is a genuinely distinct kind, so it's qualified with the
  // "Training - " prefix the rest of the app (baseJerseyType, etc.) expects.
  function composeTrainingType(sub){
    if(!sub) return 'Training';
    return /^training\b/i.test(sub) ? sub : 'Training - ' + sub;
  }
  // Applies to a single upload (front/back/other angles for one jersey)
  // and to a later "add more photos" proposal on an already-approved
  // one — plenty of headroom for every real angle someone would
  // photograph, while stopping an accidental hundred-photo batch drop.
  var MAX_UPLOAD_PHOTOS = 4;
  // A jersey only counts as "highest rated" once at least this many people
  // have rated it — otherwise a single 5-star vote in the site's early
  // days would shoot straight to the top of the list ahead of everything
  // else. Revisit upward once ratings pick up.
  var MIN_RATINGS_FOR_HIGHEST_RATED = 5;
  // Fixed lead-in, well-known kit makers across every sport on the site —
  // shown up front regardless of whether they've been used yet, so an
  // already-real brand doesn't get re-added as "new" just because nobody's
  // uploaded that sport/brand combo before. After these, the form fills in
  // with whatever's actually used most in the selected sport, then anything
  // else already used anywhere else on the site.
  // The 8 biggest global brands first, then the two rugby league-specific
  // ones right after (still common enough to skip the alphabet), then
  // everything else A-Z.
  var MFR_TOP = ['Adidas','Nike','Puma','Umbro','Kappa','Macron','Under Armour','New Balance'];
  var MFR_SECONDARY = ['Classic Sportswear','Dynasty Sport'];
  var MFR_REST = [
    'Joma','Hummel','Errea','Uhlsport','Mizuno','Asics','Canterbury','BLK','ISC',
    'O\'Neills','Castore','Kukri','Le Coq Sportif','Diadora','Lotto','Legea',
    'Fanatics','Majestic','New Era','CCM','Bauer','Champion'
  ].sort();
  var PRIORITY_MANUFACTURERS = MFR_TOP.concat(MFR_SECONDARY, MFR_REST);

  // Reputation tiers by upload points — adjust thresholds/colors/labels here.
  var TIERS = [
    {min:0,    label:'Rookie',       color:'#8FAA98'},
    {min:25,   label:'Reserve',      color:'#5FA8D9'},
    {min:50,   label:'Squad Player', color:'#3FC7D1'},
    {min:100,  label:'Starter',      color:'#3FD1A8'},
    {min:250,  label:'Specialist',   color:'#A8D14A'},
    {min:500,  label:'Captain',      color:'#F0B429'},
    {min:1000, label:'All-Star',     color:'#F0914B'},
    {min:2000, label:'Veteran',      color:'#E4645C'},
    {min:3000, label:'Legend',       color:'#B084E8'},
    {min:4000, label:'Hall of Famer',color:'#8A5CD1'},
    {min:5000, label:'G.O.A.T.',     color:'#FFD700'}
  ];
  function tierFor(points){
    for(var i=TIERS.length-1; i>=0; i--){ if(points >= TIERS[i].min) return TIERS[i]; }
    return TIERS[0];
  }
  function pointsChip(points){
    var t = tierFor(points);
    return '<span style="color:'+t.color+';font-weight:700;" title="'+t.label+' tier">('+points+')</span>';
  }

  var currentUser = null, currentProfile = null, pendingCount = 0;
  var unreadMsgCount = 0, unreadMsgLink = null;
  // Remembers which sport pages had "More competitions" expanded, so
  // navigating back to one (e.g. after clicking into a team from the
  // expanded list) shows it already open instead of re-collapsing —
  // a fresh visit still starts collapsed and needs the click.
  var expandedSportComps = {};
  // Same idea, for the homepage's own "More sports" toggle - no per-page
  // keying needed since there's only one home page.
  var expandedHomeSports = false;

  /* ================= helpers ================= */
  function esc(s){ return String(s == null ? '' : s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;'); }
  // Strips apostrophes/periods too (not just accents+case) - search is
  // substring-based, so "O'Neills" needs to become "oneills" or typing
  // "on" (a natural way to start that name) would never match, since
  // "on" doesn't appear contiguously in "o'neills".
  function normalizeText(s){ return (s || '').toString().normalize('NFD').replace(/[̀-ͯ]/g,'').toLowerCase().replace(/[‘’'.]/g,'').trim(); }
  function fmtDate(iso){ try{ return new Date(iso).toLocaleDateString(undefined,{year:'numeric',month:'short',day:'numeric'}); }catch(e){ return ''; } }
  function slugify(s){ return String(s).toLowerCase().trim().replace(/[^a-z0-9]+/g,'-').replace(/(^-|-$)/g,'') || 'x'; }
  // Every photo/logo upload runs through this before it ever reaches
  // Supabase Storage — re-encodes it as WebP, which came out 60-90%+
  // smaller than a typical phone-camera JPEG or a PNG in testing, with no
  // visible quality loss at the sizes these ever get displayed. Also caps
  // the long edge at MAX_UPLOAD_DIMENSION, since nothing on the site ever
  // shows a single jersey photo bigger than that anyway. Resolves to the
  // ORIGINAL file (untouched) if anything goes wrong — a format the
  // browser can't decode, canvas support missing, whatever — so a
  // compression hiccup never blocks someone's upload; and if the
  // re-encoded version somehow comes out bigger (can happen with a very
  // small or already heavily-compressed source), it keeps the original
  // rather than uploading the bigger file.
  var MAX_UPLOAD_DIMENSION = 2000;
  // Used to be 0.82, reasoned as "lower than a logo's 0.92 needs, since
  // a logo's sharp edges/text show lossy ringing more than a photo's
  // soft gradients do" - but a jersey photo is full of exactly that
  // kind of sharp detail too (sponsor text, crests, numbers, piping),
  // so 0.82 was visibly artifacting on any photo with a lot of that -
  // "some uploads look HQ, some don't" from the very same uploader was
  // this, not inconsistent source quality. Matches LOGO_WEBP_QUALITY now.
  var UPLOAD_WEBP_QUALITY = 0.92;
  var LOGO_WEBP_QUALITY = 0.92;
  function compressImageForUpload(file, quality){
    return new Promise(function(resolve){
      if(!file || !/^image\//.test(file.type) || file.type === 'image/svg+xml'){ resolve(file); return; }
      var img = new Image();
      var url = URL.createObjectURL(file);
      img.onload = function(){
        URL.revokeObjectURL(url);
        try {
          var w = img.naturalWidth, h = img.naturalHeight;
          if(!w || !h){ resolve(file); return; }
          var scale = Math.min(1, MAX_UPLOAD_DIMENSION / Math.max(w, h));
          var canvas = document.createElement('canvas');
          canvas.width = Math.max(1, Math.round(w * scale));
          canvas.height = Math.max(1, Math.round(h * scale));
          var ctx = canvas.getContext('2d');
          ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
          canvas.toBlob(function(blob){
            if(!blob || blob.size >= file.size){ resolve(file); return; }
            var newName = file.name.replace(/\.[^.\/]+$/, '') + '.webp';
            resolve(new File([blob], newName, {type: 'image/webp'}));
          }, 'image/webp', quality || UPLOAD_WEBP_QUALITY);
        } catch(e){ resolve(file); }
      };
      img.onerror = function(){ URL.revokeObjectURL(url); resolve(file); };
      img.src = url;
    });
  }
  // Same idea as footballkitarchive's own file naming (e.g.
  // "fc-augsburg-2026-27-third-kit") instead of an opaque
  // "front-0-1789703338930" — readable if someone saves the image
  // straight off the site. photoLabel/idx are only appended when
  // needed to keep multiple photos of the same jersey from colliding.
  function jerseyPhotoFileName(teamName, season, type, photoLabel, idx, ext){
    var base = [slugify(teamName), slugify(season), slugify(type), 'kit'].join('-');
    var suffix = photoLabel ? '-' + slugify(photoLabel) : '';
    if(photoLabel === 'Other' && idx) suffix += '-' + idx;
    return base + suffix + '.' + ext;
  }
  function hashStr(s){ var h=0; for(var i=0;i<s.length;i++){ h=(h*31+s.charCodeAt(i))>>>0; } return h; }
  function hashColors(name){
    var h = hashStr(name), hue = h % 360, hue2 = (hue + 150) % 360;
    return { primary: 'hsl('+hue+',48%,28%)', secondary: 'hsl('+hue2+',70%,58%)' };
  }

  // Strips a trailing gender marker so a men's/women's pair of the same
  // club (e.g. "Adelaide United" / "Adelaide United Women") is recognised
  // as siblings even when the names aren't byte-identical. Deliberately
  // narrow — only known marker tokens, nothing that could misfire on an
  // unrelated club that happens to share a word.
  // Season is text now ("2024-25" for split-year comps), so sorting can't
  // just subtract the values — pull the leading year out to compare.
  // That alone used to leave "2024" and "2024-25" tied (both just parse
  // to 2024), so which one displayed first came down to whatever order
  // they happened to arrive from the DB in, not anything chronological.
  // A split season starts the same year as its leading number but runs
  // on into the next one, so it's the more recent of the two, same as
  // 2024-25 being newer than 2024 but older than 2025 - +0.5 places it
  // exactly between its two years without needing a second pass.
  // "Unknown" (the upload form's "I'm not sure of the exact year" option)
  // has no digits to parse, so it used to fall through to the 0 fallback -
  // the oldest possible key, burying it at the very bottom of every
  // newest-first list instead of surfacing it for a moderator to
  // investigate. Infinity instead puts it at the very top everywhere.
  function seasonSortKey(s){
    var str = String(s);
    if(str === 'Unknown') return Infinity;
    var base = parseInt(str, 10) || 0;
    return /-/.test(str) ? base + 0.5 : base;
  }

  // The propose-logo form always builds years_used as "YYYY-YYYY" (see
  // wireProposeLogoPanel), but the free-text pencil-edit on Logo History
  // takes anything typed - "1978-90" (a shortened end year) crept back
  // in that way and now reads inconsistently next to properly-built
  // entries like "2014-2018". Expands a short two-digit end year back
  // to four digits using the start year's century (rolling over to the
  // next century if the short year is earlier than the start year's own
  // last two digits, e.g. "1999-02" -> "1999-2002"); anything else
  // (already four digits, a single year, free text) passes through
  // unchanged.
  function normalizeYearsUsed(str){
    if(!str) return str;
    var trimmed = str.trim();
    var m = trimmed.match(/^(\d{4})-(\d{1,2})$/);
    if(!m) return trimmed;
    var startYear = Number(m[1]);
    var endYear = Math.floor(startYear / 100) * 100 + Number(m[2]);
    if(endYear < startYear) endYear += 100;
    return startYear + '-' + endYear;
  }

  // Canonical jersey-type ordering, per sport (and for the NBA, per era —
  // Association/Icon/Statement/Classic/City only from 2017-18 on; earlier
  // seasons still used Home/Away/Alternate/Heritage). Each entry is a
  // priority slot; a jersey whose type isn't recognised for that sport
  // just falls in after all named slots, in upload order.
  // "Road" is the major-USA-sports term for an away jersey (NFL/NHL/MLB/
  // classic-era NBA); international/other sports don't use it, so it's
  // only added as an "away" synonym on those specific lists (and the
  // generic fallback, which is what classic-era NBA/NBL/WNBL and non-NHL
  // ice hockey fall back to).
  var GENERIC_TYPE_ORDER = [
    ['home','primary'], ['away','road'], ['third'], ['alternate'],
    ['indigenous','first nations'], ['heritage']
  ];
  var SPORT_TYPE_ORDERS = {
    football: [['home','primary'], ['away'], ['third'], ['fourth'], ['alternate'], ['gk','goalkeeper']],
    'rugby-league': [['home','primary'], ['away'], ['indigenous','first nations'], ['alternate'], ['heritage']],
    'rugby-union': [['home','primary'], ['away','alternate']],
    afl: [['home','primary'], ['away'], ['clash']],
    'american-football': [['home','primary'], ['away','road'], ['throwback','heritage'], ['alternate']],
    baseball: [['home','primary'], ['away','road'], ['third'], ['fourth'], ['alternate'], ['city connect']]
  };
  var NBA_MODERN_TYPE_ORDER = [['association'], ['icon'], ['statement'], ['classic'], ['city']];
  var NHL_TYPE_ORDER = [['home','primary'], ['away','road'], ['third'], ['alternate'], ['heritage classic'], ['reverse retro']];
  function typeOrderGroupsFor(sportSlug, compSlug, seasonLabel){
    if(sportSlug === 'basketball' && compSlug === 'nba' && seasonSortKey(seasonLabel) >= 2017) return NBA_MODERN_TYPE_ORDER;
    if(compSlug === 'nhl') return NHL_TYPE_ORDER;
    return SPORT_TYPE_ORDERS[sportSlug] || GENERIC_TYPE_ORDER;
  }
  function typeSortIndex(orderGroups, typeStr){
    var t = String(typeStr || '').trim().toLowerCase();
    for(var i=0; i<orderGroups.length; i++){ if(orderGroups[i].indexOf(t) > -1) return i; }
    return orderGroups.length;
  }
  // Stable sort (guaranteed by the spec) — ties (unrecognised types, or two
  // of the same recognised type) keep whatever order the query gave them,
  // which is upload order since callers select with a created_at tiebreak.
  function sortJerseysByType(jerseys, sportSlug, compSlug, seasonLabel){
    var groups = typeOrderGroupsFor(sportSlug, compSlug, seasonLabel);
    return jerseys.slice().sort(function(a, b){ return typeSortIndex(groups, a.type) - typeSortIndex(groups, b.type); });
  }

  // Used to flag the SAME team appearing under more than one competition
  // (an old competition name vs. the current one, most often) - not to
  // match loosely-similar names. It used to also strip "Women"/"WFC"/
  // "(Women)"/"(Men)" before comparing, which was well-intentioned but
  // backfired: "Wellington Phoenix Women" and the men's "Wellington
  // Phoenix" are different teams entirely (different competition,
  // different squad), not the same team under a renamed competition, and
  // stripping the gender marker made them register as a match. Exact name
  // (post-trim) only, now.
  function normalizeTeamName(name){
    return String(name).trim();
  }

  // A real RFC4122 uuid (unlike getClientToken's fallback below, which
  // only ever needs to be unique, not valid uuid syntax) - used so a
  // jersey's id can be generated client-side before its row exists yet.
  // crypto.randomUUID needs a secure context (https/localhost), which
  // this site always is; the manual fallback covers a browser old
  // enough to lack it.
  function genUUID(){
    if(crypto.randomUUID) return crypto.randomUUID();
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c){
      var r = Math.random() * 16 | 0, v = c === 'x' ? r : (r & 0x3 | 0x8);
      return v.toString(16);
    });
  }

  // A per-browser random id (not tied to identity) so anonymous report
  // submissions can still be rate-limited server-side without requiring
  // sign-in. Clearing site data resets it — that's an accepted gap for
  // "basic" spam protection, not a security boundary.
  function getClientToken(){
    try {
      var t = localStorage.getItem('jd_client_token');
      if(!t){
        t = (crypto.randomUUID ? crypto.randomUUID() : (Date.now().toString(36) + Math.random().toString(36).slice(2)));
        localStorage.setItem('jd_client_token', t);
      }
      return t;
    } catch(e){ return null; }
  }

  // Routed through a Cloudflare Worker (img.thejerseydatabase.com) that
  // caches these at Cloudflare's edge. Supabase Storage's own domain can't
  // be proxied directly through Cloudflare (it's already on Cloudflare
  // under Supabase's own account, and Cloudflare blocks cross-account
  // CNAMEs), so the Worker re-fetches from Supabase only on a cache miss
  // and serves everything else straight from the edge - cutting out most
  // of the repeat bandwidth from the same photo being viewed by many
  // different visitors.
  var IMAGE_CDN_HOST = 'https://img.thejerseydatabase.com';
  function toCdnUrl(supabaseUrl){
    return supabaseUrl.replace(SUPABASE_URL, IMAGE_CDN_HOST);
  }

  function publicImageUrl(path){
    return toCdnUrl(supabaseClient.storage.from('jersey-photos').getPublicUrl(path).data.publicUrl);
  }

  function publicLogoUrl(path){
    return toCdnUrl(supabaseClient.storage.from('team-logos').getPublicUrl(path).data.publicUrl);
  }

  function teamSwatch(team, opts){
    var large = opts && opts.large;
    var sizeClass = large ? ' team-swatch-lg' : '';
    if(team.logo_path){
      // Only the large header version is independently clickable — the
      // small grid version is already inside a card that links to the
      // team page, and stacking a zoom action on top of that would fight
      // the card's own click-to-navigate behavior.
      var triggerClass = large ? ' lightbox-trigger' : '';
      return '<div class="team-swatch team-swatch-logo'+sizeClass+'"><img class="'+triggerClass.trim()+'" src="'+esc(publicLogoUrl(team.logo_path))+'" alt="" loading="lazy"></div>';
    }
    return '<div class="team-swatch'+sizeClass+'"><div class="a" style="background:'+esc(team.primary_color)+'"></div><div class="b" style="background:'+esc(team.secondary_color)+'"></div></div>';
  }

  // Competitions have no fallback colors to swatch, unlike teams — just
  // render nothing until a logo actually exists.
  function compLogoSwatch(comp, opts){
    if(!comp.logo_path) return '';
    var large = opts && opts.large;
    var sizeClass = large ? ' team-swatch-lg' : '';
    var triggerClass = large ? ' lightbox-trigger' : '';
    return '<div class="team-swatch team-swatch-logo'+sizeClass+'"><img class="'+triggerClass.trim()+'" src="'+esc(publicLogoUrl(comp.logo_path))+'" alt="" loading="lazy"></div>';
  }

  // The photo labeled "Front" should always be what a visitor sees first,
  // no matter which order the files were actually dropped/uploaded in —
  // sort_order alone isn't enough since that just reflects upload order.
  var IMAGE_LABEL_ORDER = {Front: 0, Back: 1, Other: 2};
  function sortImagesForDisplay(images){
    return (images || []).slice().sort(function(a, b){
      var la = IMAGE_LABEL_ORDER.hasOwnProperty(a.label) ? IMAGE_LABEL_ORDER[a.label] : 2;
      var lb = IMAGE_LABEL_ORDER.hasOwnProperty(b.label) ? IMAGE_LABEL_ORDER[b.label] : 2;
      return (la - lb) || (a.sort_order - b.sort_order);
    });
  }

  function jerseyThumb(jersey, team){
    var images = sortImagesForDisplay(jersey.jersey_images);
    if(images.length){
      return '<img src="'+esc(publicImageUrl(images[0].storage_path))+'" alt="" loading="lazy">';
    }
    return '<div class="thumb-placeholder" style="background:linear-gradient(135deg,'+esc(team.primary_color)+','+esc(team.secondary_color)+')"><span>No photo yet</span></div>';
  }

  // Short, human "how long ago" label for the Latest Updates page — falls
  // back to a plain date once something's more than a week old, since
  // "23d ago" stops being a useful way to picture when that was.
  function relativeTimeLabel(iso){
    var d = new Date(iso);
    var mins = Math.floor((Date.now() - d.getTime()) / 60000);
    if(mins < 1) return 'just now';
    if(mins < 60) return mins + 'm ago';
    var hours = Math.floor(mins / 60);
    if(hours < 24) return hours + 'h ago';
    var days = Math.floor(hours / 24);
    if(days < 7) return days + 'd ago';
    return d.toLocaleDateString(undefined, {year:'numeric', month:'short', day:'numeric'});
  }

  function jerseyCard(jersey, team, opts){
    opts = opts || {};
    var yearType = jersey.season + ' · ' + jersey.type + (jersey.format ? ' · ' + jersey.format : '');
    var primary = opts.showTeam ? team.name : yearType;
    var secondary = opts.showTeam ? yearType : (jersey.manufacturer || 'Unlisted');
    var dateHtml = opts.ts ? '<span>'+esc(relativeTimeLabel(opts.ts))+'</span>' : '';
    var pendingBadge = jersey.status === 'rejected' ? '<span class="pending-badge is-rejected">Rejected</span>'
      : (jersey.status && jersey.status !== 'approved' ? '<span class="pending-badge">Pending</span>' : '');
    // Surfaces an extra-competition tag (a World Cup jersey filed under
    // a country's normal International team, say) right on the card —
    // otherwise there's no visual difference on a season/search grid
    // between a jersey worn only domestically and one also worn at a
    // major tournament; only shows up when the query fetching this
    // jersey actually joined jersey_competitions.
    var tags = (jersey.jersey_competitions || []).map(function(t){ return t.competitions && t.competitions.name; }).filter(Boolean);
    var tagBadge = tags.length
      ? '<span class="tag-badge" title="Also worn in: '+esc(tags.join(', '))+'">'+esc(tags[0])+(tags.length>1 ? ' +'+(tags.length-1) : '')+'</span>'
      : '';
    return '<a class="jersey-card" href="#/jersey/'+jersey.id+'" data-format="'+esc(jersey.format || '')+'">' + pendingBadge + tagBadge +
      '<div class="jersey-thumb">'+jerseyThumb(jersey, team)+'</div>' +
      '<div class="jersey-label"><strong>'+esc(primary)+'</strong><span>'+esc(secondary)+'</span>'+dateHtml+'</div>' +
    '</a>';
  }

  // Shares the jersey-card markup/CSS so a logo slots into the same
  // "Recently added" grid as jerseys instead of needing its own layout.
  function logoCard(logo, team, opts){
    // Recently Added now includes history-only logos too (not just
    // whatever's actually live), so "New logo" needs to be honest about
    // which kind this is - otherwise a backdated/historical add reads as
    // if it just became the team's current logo when it didn't.
    var label = (opts && opts.label) || (logo.is_current === false
      ? (logo.years_used ? 'Logo added · '+logo.years_used : 'Logo added (historical)')
      : 'New logo');
    var dateHtml = (opts && opts.ts) ? '<span>'+esc(relativeTimeLabel(opts.ts))+'</span>' : '';
    var sportSlug = team.competitions.sport_slug;
    return '<a class="jersey-card" href="#/sport/'+sportSlug+'/'+team.competition_slug+'/team/'+team.slug+'">' +
      '<div class="jersey-thumb"><img src="'+esc(publicLogoUrl(logo.storage_path))+'" alt="" loading="lazy"></div>' +
      '<div class="jersey-label"><strong>'+esc(team.name)+'</strong><span>'+esc(label)+'</span>'+dateHtml+'</div>' +
    '</a>';
  }

  function compLogoCard(logo, comp, opts){
    var label = (opts && opts.label) || (logo.is_current === false
      ? (logo.years_used ? 'Logo added · '+logo.years_used : 'Logo added (historical)')
      : 'New logo');
    var dateHtml = (opts && opts.ts) ? '<span>'+esc(relativeTimeLabel(opts.ts))+'</span>' : '';
    return '<a class="jersey-card" href="#/sport/'+comp.sport_slug+'/'+comp.slug+'">' +
      '<div class="jersey-thumb"><img src="'+esc(publicLogoUrl(logo.storage_path))+'" alt="" loading="lazy"></div>' +
      '<div class="jersey-label"><strong>'+esc(comp.name)+'</strong><span>'+esc(label)+'</span>'+dateHtml+'</div>' +
    '</a>';
  }

  async function fetchRating(jerseyId){
    var r = await supabaseClient.from('jersey_ratings').select('*').eq('jersey_id', jerseyId).maybeSingle();
    if(r.error) throw r.error;
    return r.data || {avg_rating:0, rating_count:0};
  }

  function ratingWidgetHtml(rating, myValue){
    var canRate = currentUser && !(currentProfile && currentProfile.is_banned);
    var rounded = myValue || Math.round(rating.rating_count ? rating.avg_rating : 0);
    var stars = '';
    for(var i=1;i<=5;i++){
      stars += '<button type="button" class="star-btn'+(i<=rounded?' is-filled':'')+'" data-value="'+i+'"'+(canRate?'':' disabled')+' aria-label="Rate '+i+' star">'+ICON_STAR+'</button>';
    }
    var summary = rating.rating_count ? (rating.avg_rating+' · '+rating.rating_count+' rating'+(rating.rating_count===1?'':'s')) : 'Not yet rated — be the first';
    if(!currentUser) summary += ' — sign in to rate';
    else if(!canRate) summary += ' — your account is banned from rating';
    return '<div class="stars-row">'+stars+'</div><p class="rating-summary">'+summary+'</p>';
  }

  // Shared between the jersey page's initial render and the "Send"
  // button's refresh (see wireViewEvents) so both build the exact same
  // markup from a fresh fetch, same split as fetchRating/ratingWidgetHtml
  // above.
  async function jerseyMessagesThreadHtml(jerseyId){
    var msgRes = await supabaseClient.from('jersey_messages').select('*').eq('jersey_id', jerseyId).order('created_at');
    var messages = msgRes.data || [];
    var senderIds = messages.map(function(m){ return m.sender_id; }).filter(function(v,i,a){ return a.indexOf(v) === i; });
    var senderInfo = {};
    if(senderIds.length){
      var sendersRes = await supabaseClient.from('profiles').select('id, username, is_admin').in('id', senderIds);
      (sendersRes.data || []).forEach(function(p){ senderInfo[p.id] = p; });
    }
    return messages.length ? messages.map(function(m){
      var sender = senderInfo[m.sender_id];
      var name = sender ? sender.username : 'unknown';
      var roleTag = sender && sender.is_admin ? ' <span class="chip is-active" style="pointer-events:none;padding:2px 8px;">Moderator</span>' : '';
      return '<div class="jersey-message"><div class="jersey-message-meta"><strong>'+esc(name)+'</strong>'+roleTag+' <span class="field-hint">'+fmtDate(m.created_at)+'</span></div><p>'+esc(m.message)+'</p></div>';
    }).join('') : '<p class="field-hint">No messages yet.</p>';
  }

  // Same shape as jerseyMessagesThreadHtml, for a logo proposal's own
  // thread instead - kind is 'team' or 'competition', matching which
  // proposal_id column is set.
  async function logoMessagesThreadHtml(kind, proposalId){
    var col = kind === 'team' ? 'team_logo_proposal_id' : 'competition_logo_proposal_id';
    var msgRes = await supabaseClient.from('logo_messages').select('*').eq(col, proposalId).order('created_at');
    var messages = msgRes.data || [];
    var senderIds = messages.map(function(m){ return m.sender_id; }).filter(function(v,i,a){ return a.indexOf(v) === i; });
    var senderInfo = {};
    if(senderIds.length){
      var sendersRes = await supabaseClient.from('profiles').select('id, username, is_admin').in('id', senderIds);
      (sendersRes.data || []).forEach(function(p){ senderInfo[p.id] = p; });
    }
    return messages.length ? messages.map(function(m){
      var sender = senderInfo[m.sender_id];
      var name = sender ? sender.username : 'unknown';
      var roleTag = sender && sender.is_admin ? ' <span class="chip is-active" style="pointer-events:none;padding:2px 8px;">Moderator</span>' : '';
      return '<div class="jersey-message"><div class="jersey-message-meta"><strong>'+esc(name)+'</strong>'+roleTag+' <span class="field-hint">'+fmtDate(m.created_at)+'</span></div><p>'+esc(m.message)+'</p></div>';
    }).join('') : '<p class="field-hint">No messages yet.</p>';
  }

  // A logo proposal has nowhere else to live - unlike a jersey, it
  // never gets its own public page once approved (it just becomes
  // team.logo_path / a team_logos row, not a separately addressable
  // thing), so this is purely a private destination for the proposer
  // and admins to have the same kind of conversation a jersey's own
  // page already supports. Not linked from anywhere public.
  async function viewLogoProposal(kind, id){
    setCrumbs([{label:'Home', href:'#/'},{label:'Moderate', href:'#/moderate'},{label:'Logo proposal', href:'#'}]);
    var table = kind === 'team' ? 'team_logo_proposals' : 'competition_logo_proposals';
    var selectCols = kind === 'team'
      ? '*, teams(name, slug, competition_slug, competitions(sport_slug))'
      : '*, competitions(name, slug, sport_slug)';
    var res = await supabaseClient.from(table).select(selectCols).eq('id', id).maybeSingle();
    if(res.error) throw res.error;
    if(!res.data) return '<div class="empty-note">That logo proposal doesn&rsquo;t exist (it may have since been rejected).</div>';
    var p = res.data;
    var isUploader = !!(currentUser && p.proposed_by === currentUser.id);
    var isAdmin = currentProfile && currentProfile.is_admin;
    if(!isUploader && !isAdmin) return '<div class="empty-note">Not authorized.</div>';

    var subjectName = kind === 'team' ? (p.teams ? p.teams.name : 'a team') : (p.competitions ? p.competitions.name : 'a competition');
    var statusHtml = p.status && p.status !== 'pending'
      ? '<div class="pending-banner">This proposal is '+esc(p.status)+'.</div>'
      : '<div class="pending-banner">This proposal is pending review &mdash; only you and moderators can see this page.</div>';

    var threadHtml = await logoMessagesThreadHtml(kind, id);
    if(currentUser){
      await supabaseClient.from('logo_message_reads').upsert(
        {kind: kind, proposal_id: id, user_id: currentUser.id, last_read_at: new Date().toISOString()},
        {onConflict: 'kind,proposal_id,user_id'}
      );
    }
    var messagesHtml = '<div class="jersey-messages-block">' +
      '<label class="rate-label">Messages</label>' +
      '<div class="jersey-messages-thread" id="logo-messages-thread">'+threadHtml+'</div>' +
      (currentProfile && currentProfile.is_banned
        ? '<p class="field-hint">Your account is banned from sending messages.</p>'
        : '<div class="jersey-message-form"><textarea id="logo-message-input" rows="2" placeholder="'+(isAdmin ? 'Ask the proposer something, e.g. ‘Can you find a higher-res version?’' : 'Reply to the moderator…')+'"></textarea><button class="btn btn-secondary" id="logo-message-send" type="button" data-kind="'+kind+'" data-proposal-id="'+id+'">Send</button></div>') +
    '</div>';

    // Lets a moderator handle the whole "this logo's wrong, let's sort
    // it out" conversation in one place rather than bouncing back to
    // Moderate for the actual approve/reject - swap in a better photo
    // (same new-path-then-repoint approach as the crop tool, since
    // upload(..., {upsert:true}) onto an existing path doesn't work on
    // this project), then approve or reject right here, reusing the
    // exact same setLogo/addLogoToHistory calls Moderate's own
    // approve button uses.
    var refId = kind === 'team' ? p.team_id : p.competition_slug;
    var makeCurrentId = 'lp-make-current';
    var willReplace = p.make_current !== false;
    // years_used is stored as "YYYY-YYYY" or a single "YYYY" (see
    // wireProposeLogoPanel) - split back into the same two number
    // fields that form uses, so editing it here doesn't need its own
    // free-text parsing rules.
    var yearParts = (p.years_used || '').split('-');
    var yearFirst = yearParts[0] || '';
    var yearLast = yearParts.length > 1 ? yearParts[1] : '';
    var adminActionsHtml = (isAdmin && (!p.status || p.status === 'pending'))
      ? '<div class="jersey-messages-block" style="margin-top:18px;">' +
          '<label class="rate-label">Moderator actions</label>' +
          '<div class="field" style="margin-top:10px;"><label>Replace this photo <small>upload a better quality image before approving &mdash; the old one is removed once this is saved</small></label>' +
            '<div class="dropzone" id="lp-replace-dropzone" tabindex="0" role="button" aria-label="Replace this photo">' +
              ICON_PHOTO +
              '<p>Drop a replacement image here, or click to choose</p>' +
              '<input type="file" id="lp-replace-input" accept="image/*" style="display:none;">' +
            '</div>' +
          '</div>' +
          '<div style="margin-top:8px;"><button class="btn btn-secondary" id="lp-crop-btn" type="button" data-kind="'+kind+'" data-id="'+id+'" data-path="'+esc(p.storage_path)+'">Crop this photo</button></div>' +
          '<p class="field-hint" id="lp-replace-status" hidden></p>' +
          '<div style="display:flex;gap:12px;flex-wrap:wrap;margin-top:14px;">' +
            '<div class="field" style="flex:1;min-width:120px;"><label for="lp-year-first">First used <small>optional</small></label>' +
              '<input type="number" id="lp-year-first" value="'+esc(yearFirst)+'" placeholder="e.g. 2016" min="1850" max="2100"></div>' +
            '<div class="field" style="flex:1;min-width:160px;"><label for="lp-year-last">Last used <small>leave blank if only used for one year</small></label>' +
              '<input type="number" id="lp-year-last" value="'+esc(yearLast)+'" placeholder="e.g. 2025" min="1850" max="2100"></div>' +
          '</div>' +
          '<div class="field" style="margin-top:10px;"><label for="lp-note-input">Special occasion <small>optional &mdash; e.g. &ldquo;60th Anniversary&rdquo;</small></label>' +
            '<input type="text" id="lp-note-input" value="'+esc(p.note || '')+'" placeholder="e.g. 60th Anniversary"></div>' +
          '<div style="margin-top:8px;"><button class="btn btn-secondary" id="lp-years-save-btn" type="button" data-kind="'+kind+'" data-id="'+id+'">Save years &amp; note</button> <span class="field-hint" id="lp-years-status" hidden></span></div>' +
          '<label class="field-hint" style="display:block;margin-top:14px;cursor:pointer;"><input type="checkbox" id="'+makeCurrentId+'" '+(willReplace ? 'checked' : '')+' style="vertical-align:middle;margin-right:6px;">Make this the current logo</label>' +
          '<div style="margin-top:12px;display:flex;gap:10px;flex-wrap:wrap;">' +
            '<button class="btn" id="lp-approve-btn" type="button" data-kind="'+kind+'" data-id="'+id+'" data-ref-id="'+esc(refId)+'" data-path="'+esc(p.storage_path)+'" data-years="'+esc(p.years_used || '')+'" data-note="'+esc(p.note || '')+'" data-proposed-by="'+esc(p.proposed_by || '')+'" data-make-current-id="'+makeCurrentId+'">Approve</button>' +
            '<button class="btn btn-reject" id="lp-reject-btn" type="button" data-kind="'+kind+'" data-id="'+id+'" data-path="'+esc(p.storage_path)+'">Reject</button>' +
          '</div>' +
        '</div>'
      : '';

    return statusHtml +
      '<div class="jersey-thumb" style="max-width:220px;"><img class="lightbox-trigger" src="'+esc(publicLogoUrl(p.storage_path))+'" alt="" loading="lazy"></div>' +
      '<div class="spec-list" style="margin-top:18px;">' +
        '<div class="spec-item"><span>Logo for</span><div class="spec-value-row"><strong>'+esc(subjectName)+'</strong></div></div>' +
        (p.years_used ? '<div class="spec-item"><span>Years used</span><div class="spec-value-row"><strong>'+esc(p.years_used)+'</strong></div></div>' : '') +
        (p.note ? '<div class="spec-item"><span>Note</span><div class="spec-value-row"><strong>'+esc(p.note)+'</strong></div></div>' : '') +
      '</div>' +
      adminActionsHtml +
      messagesHtml;
  }

  function renderReportButton(pageType, pageRef, pageLabel){
    var uid = pageType + '-' + pageRef;
    return '<div class="report-block">' +
      '<button class="report-btn" type="button" data-page-type="'+pageType+'" data-page-ref="'+esc(pageRef)+'" data-page-label="'+esc(pageLabel)+'" data-target="report-panel-'+esc(uid)+'">'+ICON_FLAG+' Report a problem</button>' +
      '<div class="report-panel" id="report-panel-'+esc(uid)+'" hidden></div>' +
    '</div>';
  }

  function wireReportButtons(){
    document.querySelectorAll('.report-btn').forEach(function(btn){
      btn.addEventListener('click', function(){
        var panel = document.getElementById(btn.dataset.target);
        var uid = btn.dataset.pageType + '-' + btn.dataset.pageRef;
        if(!panel.dataset.wired){
          panel.dataset.wired = '1';
          panel.innerHTML =
            '<textarea class="report-textarea" rows="3" placeholder="What’s wrong? e.g. wrong season, misspelled team name, incorrect logo..."></textarea>' +
            '<label class="field-hint" style="display:block;margin-bottom:8px;cursor:pointer;">' +
              '<input type="checkbox" id="report-attach-toggle-'+esc(uid)+'" style="vertical-align:middle;margin-right:6px;">Attach an image (optional — e.g. the correct logo)' +
            '</label>' +
            '<div id="report-attach-area-'+esc(uid)+'" hidden></div>' +
            '<div class="hp-field" aria-hidden="true"><label>Leave this field blank<input type="text" tabindex="-1" autocomplete="off" id="report-hp-'+esc(uid)+'"></label></div>' +
            '<button class="btn" type="button" data-submit>Submit report</button>' +
            '<p class="field-hint" id="report-msg-'+esc(uid)+'" hidden></p>';
          var textarea = panel.querySelector('textarea');
          var submitBtn = panel.querySelector('[data-submit]');
          var honeypot = document.getElementById('report-hp-'+uid);
          var msg = document.getElementById('report-msg-'+uid);
          var attachToggle = document.getElementById('report-attach-toggle-'+uid);
          var attachArea = document.getElementById('report-attach-area-'+uid);
          var attachedFile = null;
          attachToggle.addEventListener('change', function(){
            attachArea.hidden = !attachToggle.checked;
            if(attachToggle.checked && !attachArea.dataset.wired){
              attachArea.dataset.wired = '1';
              attachArea.innerHTML = '<input type="file" accept="image/*" style="margin-bottom:10px;">';
              attachArea.querySelector('input[type=file]').addEventListener('change', function(e){
                attachedFile = e.target.files[0] || null;
              });
            }
          });
          submitBtn.addEventListener('click', async function(){
            var message = textarea.value.trim();
            if(!message) return;
            if(honeypot.value){ msg.hidden = false; msg.className = 'field-hint is-match'; msg.textContent = 'Thanks — reported.'; textarea.value = ''; return; }
            submitBtn.disabled = true; submitBtn.textContent = 'Submitting…';
            var attachmentPath = null;
            try {
              if(attachedFile){
                var ext = (attachedFile.name.split('.').pop() || 'jpg').toLowerCase();
                attachmentPath = 'report-' + Date.now() + '.' + ext;
                var up = await supabaseClient.storage.from('report-attachments').upload(attachmentPath, attachedFile);
                if(up.error) throw up.error;
              }
              var res = await supabaseClient.from('reports').insert({
                page_type: btn.dataset.pageType, page_ref: btn.dataset.pageRef, page_label: btn.dataset.pageLabel,
                message: message, attachment_path: attachmentPath, reported_by: currentUser ? currentUser.id : null,
                client_token: getClientToken()
              });
              if(res.error) throw res.error;
              msg.hidden = false;
              msg.className = 'field-hint is-match'; msg.textContent = 'Thanks — reported.';
              textarea.value = ''; attachedFile = null; attachToggle.checked = false; attachArea.hidden = true;
            } catch(err) {
              msg.hidden = false;
              msg.className = 'field-error'; msg.textContent = 'Error: ' + (err.message || err);
            } finally {
              submitBtn.disabled = false; submitBtn.textContent = 'Submit report';
            }
          });
        }
        panel.hidden = !panel.hidden;
      });
    });
  }

  function setCrumbs(items){
    document.getElementById('crumbs').innerHTML = items.map(function(it,i){
      if(i === items.length-1) return '<span class="current">'+esc(it.label)+'</span>';
      return '<a href="'+it.href+'">'+esc(it.label)+'</a><span class="sep">/</span>';
    }).join('');
  }

  function errorBox(err){
    return '<div class="empty-note is-error">Something went wrong loading this page:<br><code>'+esc(err.message || err)+'</code></div>';
  }

  /* ================= views ================= */
  // Used on both the homepage (site-wide) and each sport page (scoped to
  // that sport's competitions) to show a small "just uploaded" gallery —
  // mixes in newly-approved team logos alongside jerseys, most recent first.
  async function recentJerseysHtml(compSlugs){
    // 12, not 6 - with a steady stream of uploads, a 6-item window gets
    // pushed out within a day or two, so most visitors never see it. 12
    // (shown as two rows of six at desktop width, fewer per row on
    // anything narrower, since .jersey-grid already wraps responsively)
    // gives a better sense of what's actually just been added.
    var RECENT_LIMIT = 12;
    // status filter matters here even though RLS already hides pending/
    // rejected rows from a normal visitor - an admin viewing this same
    // grid can see every status, so without it "Recently added" would
    // mix in their own pending/rejected submissions right alongside
    // actually-approved ones.
    var jq = supabaseClient.from('jerseys').select('*, jersey_images(*), teams!inner(*), jersey_competitions(competitions(name))').eq('status', 'approved').order('approved_at', {ascending:false}).limit(RECENT_LIMIT);
    // Every logo that's actually been added, not just whichever one is
    // currently live - a history-only add (e.g. a backdated logo) is
    // still something that just happened and belongs in "recently added".
    var lq = supabaseClient.from('team_logos').select('*, teams!inner(*, competitions!inner(sport_slug))').order('approved_at', {ascending:false}).limit(RECENT_LIMIT);
    var cq = supabaseClient.from('competition_logos').select('*, competitions!inner(*)').order('approved_at', {ascending:false}).limit(RECENT_LIMIT);
    if(compSlugs){ jq = jq.in('teams.competition_slug', compSlugs); lq = lq.in('teams.competition_slug', compSlugs); cq = cq.in('competition_slug', compSlugs); }
    var results = await Promise.all([jq, lq, cq]);
    var jRes = results[0], lRes = results[1], cRes = results[2];
    var items = (jRes.data || []).map(function(j){ return {ts: j.approved_at, html: jerseyCard(j, j.teams, {showTeam:true})}; })
      .concat((lRes.data || []).map(function(l){ return {ts: l.approved_at, html: logoCard(l, l.teams)}; }))
      .concat((cRes.data || []).map(function(l){ return {ts: l.approved_at, html: compLogoCard(l, l.competitions)}; }));
    items.sort(function(a,b){ return new Date(b.ts) - new Date(a.ts); });
    items = items.slice(0, RECENT_LIMIT);
    if(!items.length) return '';
    var cards = items.map(function(i){ return i.html; }).join('');
    return '<div class="section-head" style="margin-top:34px;"><h2>Recently added</h2></div><div class="jersey-grid">'+cards+'</div>';
  }

  // Same shape as recentJerseysHtml (site-wide on the home page, or
  // scoped to a sport's competitions) but ranked by rating instead of
  // recency, and only counting jerseys that clear
  // MIN_RATINGS_FOR_HIGHEST_RATED. Starts from the ratings side (a short
  // list even once the site's busy, since most jerseys won't clear the
  // threshold) rather than pulling every jersey first, so this stays
  // cheap however big the site gets.
  async function highestRatedHtml(compSlugs){
    var ratingsRes = await supabaseClient.from('jersey_ratings').select('*')
      .gte('rating_count', MIN_RATINGS_FOR_HIGHEST_RATED)
      .order('avg_rating', {ascending:false}).order('rating_count', {ascending:false})
      .limit(60);
    var candidates = ratingsRes.data || [];
    if(!candidates.length) return '';
    var ratingByJersey = {};
    candidates.forEach(function(r){ ratingByJersey[r.jersey_id] = r; });
    var jq = supabaseClient.from('jerseys').select('*, jersey_images(*), teams!inner(*), jersey_competitions(competitions(name))')
      .in('id', candidates.map(function(r){ return r.jersey_id; }));
    if(compSlugs) jq = jq.in('teams.competition_slug', compSlugs);
    var jRes = await jq;
    var jerseys = (jRes.data || []).sort(function(a,b){
      var ra = ratingByJersey[a.id], rb = ratingByJersey[b.id];
      return (rb.avg_rating - ra.avg_rating) || (rb.rating_count - ra.rating_count);
    }).slice(0, 6);
    if(!jerseys.length) return '';
    var cards = jerseys.map(function(j){ return jerseyCard(j, j.teams, {showTeam:true}); }).join('');
    return '<div class="section-head" style="margin-top:34px;"><h2>Highest rated</h2></div><div class="jersey-grid">'+cards+'</div>';
  }

  function sportCard(s){
    return '<a class="sport-card" href="#/sport/'+s.slug+'">' +
      '<div class="sport-icon">'+sportIcon(s.slug)+'</div>' +
      '<div><div class="sport-name">'+esc(s.name)+'</div></div>' +
    '</a>';
  }
  async function viewHome(){
    setCrumbs([{label:'Home', href:'#/'}]);
    var res = await supabaseClient.from('sports').select('*').order('sort_order');
    if(res.error) throw res.error;
    var sports = res.data || [];
    // Same top/more split as a sport's own "More competitions" - the
    // curated main grid stays exactly as it looks today, and anything
    // niche (Lacrosse, Gaelic Football, ...) sits one click away instead
    // of crowding it or needing its own hidden page.
    var topSports = sports.filter(function(s){ return s.tier !== 'more'; });
    var moreSports = sports.filter(function(s){ return s.tier === 'more'; });
    var cards = topSports.map(sportCard).join('');
    var moreSportsHtml = moreSports.length
      ? '<button class="chip more-toggle" id="more-sports-btn" type="button">'+(expandedHomeSports ? 'Show fewer ↑' : 'More sports ↓')+'</button>' +
        '<div id="more-sports"'+(expandedHomeSports ? '' : ' hidden')+' style="margin-top:12px;"><div class="sport-grid">'+moreSports.map(sportCard).join('')+'</div></div>'
      : '';
    var recentHtml = await recentJerseysHtml(null);
    var highestRatedSectionHtml = await highestRatedHtml(null);
    // 12 is enough to show the home page is alive without turning it
    // into an endless feed — anyone who wants to see everything else
    // that's gone up recently gets a dedicated page instead, same idea
    // as FKA's "Latest Updates" button under its own recent grid.
    var updatesButtonHtml = recentHtml
      ? '<div style="text-align:center;margin-top:22px;"><a class="btn" href="#/updates">Latest Updates</a></div>'
      : '';
    return '<header class="hero">' +
        '<p class="eyebrow">The Jersey Database &mdash; Archive</p>' +
        '<h1>Every jersey.<br>Filed by hand, found in three clicks.</h1>' +
        '<p class="sub">Pick a sport, then drill into competition, team and season &mdash; or search straight to it.</p>' +
      '</header>' +
      '<div class="section-head"><h2>Browse by sport</h2></div>' +
      '<div class="sport-grid">'+(cards || '<div class="empty-note">No sports found &mdash; has schema.sql been run?</div>')+'</div>' +
      moreSportsHtml +
      recentHtml + highestRatedSectionHtml + updatesButtonHtml;
  }

  // Full "what's gone up recently" feed — jerseys and logos together,
  // most recent first — for anyone who wants more than the 6-item taster
  // under the home page's (or, with sportSlug, a sport page's) recent
  // grid. Same source data as recentJerseysHtml, just a much higher cap
  // and its own page instead of a small inline grid.
  async function viewUpdates(sportSlug){
    var sport = null, compSlugs = null;
    if(sportSlug){
      var sportRes = await supabaseClient.from('sports').select('*').eq('slug', sportSlug).single();
      if(sportRes.error) throw sportRes.error;
      sport = sportRes.data;
      var compRes = await supabaseClient.from('competitions').select('slug').eq('sport_slug', sportSlug);
      if(compRes.error) throw compRes.error;
      compSlugs = (compRes.data || []).map(function(c){ return c.slug; });
    }
    setCrumbs(sportSlug
      ? [{label:'Home', href:'#/'},{label:sport.name, href:'#/sport/'+sportSlug},{label:'Latest Updates', href:'#'}]
      : [{label:'Home', href:'#/'},{label:'Latest Updates', href:'#'}]);
    var LIMIT = 60;
    var jq = supabaseClient.from('jerseys').select('*, jersey_images(*), teams!inner(*), jersey_competitions(competitions(name))').eq('status', 'approved').order('approved_at', {ascending:false}).limit(LIMIT);
    var lq = supabaseClient.from('team_logos').select('*, teams!inner(*, competitions!inner(sport_slug))').order('approved_at', {ascending:false}).limit(LIMIT);
    var cq = supabaseClient.from('competition_logos').select('*, competitions!inner(*)').order('approved_at', {ascending:false}).limit(LIMIT);
    if(compSlugs){
      jq = jq.in('teams.competition_slug', compSlugs);
      lq = lq.in('teams.competition_slug', compSlugs);
      cq = cq.in('competition_slug', compSlugs);
    }
    var results = compSlugs && !compSlugs.length ? [{data:[]}, {data:[]}, {data:[]}] : await Promise.all([jq, lq, cq]);
    var jRes = results[0], lRes = results[1], cRes = results[2];
    var items = (jRes.data || []).map(function(j){ return {ts: j.approved_at, html: jerseyCard(j, j.teams, {showTeam:true, ts:j.approved_at})}; })
      .concat((lRes.data || []).map(function(l){ return {ts: l.approved_at, html: logoCard(l, l.teams, {ts:l.approved_at})}; }))
      .concat((cRes.data || []).map(function(l){ return {ts: l.approved_at, html: compLogoCard(l, l.competitions, {ts:l.approved_at})}; }));
    items.sort(function(a,b){ return new Date(b.ts) - new Date(a.ts); });
    items = items.slice(0, LIMIT);
    return '<div class="section-head"><h2>'+(sport ? esc(sport.name)+' &mdash; Latest Updates' : 'Latest Updates')+'</h2><span class="count">'+items.length+'</span></div>' +
      (items.length
        ? '<div class="jersey-grid">'+items.map(function(i){ return i.html; }).join('')+'</div>'
        : '<div class="empty-note">Nothing added yet.</div>');
  }

  async function viewSport(sportSlug){
    var sportRes = await supabaseClient.from('sports').select('*').eq('slug', sportSlug).single();
    if(sportRes.error) throw sportRes.error;
    var sport = sportRes.data;
    setCrumbs([{label:'Home', href:'#/'},{label:sport.name, href:'#/sport/'+sportSlug}]);

    var compRes = await supabaseClient.from('competitions').select('*').eq('sport_slug', sportSlug).order('sort_order').order('name');
    if(compRes.error) throw compRes.error;
    var comps = compRes.data || [];

    function compCard(c){
      return '<a class="comp-card" href="#/sport/'+sportSlug+'/'+c.slug+'"><strong>'+esc(c.name)+'</strong></a>';
    }
    // Once there are enough "more" competitions that a general visitor
    // wouldn't recognise most of them by name alone (a country's own
    // domestic league, say), grouping them by country — alphabetised,
    // with an "Other" bucket last for anything not yet tagged — beats
    // one long alphabetical wall mixing NRL-adjacent stuff in with
    // Norway's or Nigeria's competitions. Competitions with no
    // region_group set just fall into "Other", so this degrades
    // gracefully for sports that haven't been tagged yet.
    function moreCompsByRegion(list){
      var groups = {};
      list.forEach(function(c){
        var g = c.region_group || 'Other';
        (groups[g] = groups[g] || []).push(c);
      });
      var groupNames = Object.keys(groups).sort(function(a,b){
        if(a==='Other') return 1;
        if(b==='Other') return -1;
        return a.localeCompare(b);
      });
      return groupNames.map(function(g){
        // sort_order lets a competition (3. Liga under Bundesliga 2, say)
        // be pinned next to a sibling it wouldn't otherwise sort next to -
        // a leading digit or article beats plain alphabetical order.
        var sorted = groups[g].slice().sort(function(a,b){ return (a.sort_order - b.sort_order) || a.name.localeCompare(b.name); });
        return '<div class="region-comp-group"><h4 class="extra-kits-label">'+esc(g)+'</h4><div class="comp-grid">'+sorted.map(compCard).join('')+'</div></div>';
      }).join('');
    }
    // With only a handful of competitions the top/more split just adds an
    // extra click for no reason — only bother hiding anything once there
    // are enough to actually need it.
    var compsHtml;
    if(comps.length <= 4){
      compsHtml = '<div class="comp-grid">'+comps.map(compCard).join('')+'</div>';
    } else {
      var top = comps.filter(function(c){ return c.tier === 'top'; });
      var more = comps.filter(function(c){ return c.tier !== 'top'; });
      var isExpanded = !!expandedSportComps[sportSlug];
      compsHtml = '<div class="comp-grid">'+top.map(compCard).join('')+'</div>' +
        (more.length ? '<button class="chip more-toggle" id="more-comps-btn" type="button">'+(isExpanded ? 'Show fewer ↑' : 'More competitions ↓')+'</button>' +
          '<div id="more-comps"'+(isExpanded ? '' : ' hidden')+' style="margin-top:12px;">'+moreCompsByRegion(more)+'</div>' : '');
    }

    var compSlugs = comps.map(function(c){ return c.slug; });
    var recentHtml = comps.length ? await recentJerseysHtml(compSlugs) : '';
    var highestRatedSectionHtml = comps.length ? await highestRatedHtml(compSlugs) : '';
    var updatesButtonHtml = recentHtml
      ? '<div style="text-align:center;margin-top:22px;"><a class="btn" href="#/sport/'+sportSlug+'/updates">Latest Updates</a></div>'
      : '';

    return '<header class="hero" style="padding-bottom:26px;"><p class="eyebrow">Sport</p><h1>'+esc(sport.name)+'</h1></header>' +
      '<section class="block"><div class="section-head"><h2>Competitions</h2></div>' +
        (comps.length ? compsHtml : '<div class="empty-note">No competitions yet for '+esc(sport.name)+'.</div>') +
      '</section>' +
      recentHtml + highestRatedSectionHtml + updatesButtonHtml;
  }

  // A jersey "in" a competition is either owned by a team that belongs to
  // it directly, or explicitly tagged onto it via jersey_competitions (the
  // same physical jersey also worn in an extra competition — a club's
  // league kit also worn in a cup, a country's regular kit also worn at a
  // World Cup). Competition/season pages need both sources merged.
  async function fetchCompetitionJerseys(compSlug, opts){
    opts = opts || {};
    var directQ = supabaseClient.from('jerseys').select('*, jersey_images(*), teams!inner(*), jersey_competitions(competitions(name))')
      .eq('teams.competition_slug', compSlug).order('created_at', {ascending:true});
    if(opts.season) directQ = directQ.eq('season', opts.season);
    var directRes = await directQ;
    if(directRes.error) throw directRes.error;
    var direct = directRes.data || [];

    var tagRes = await supabaseClient.from('jersey_competitions').select('jersey_id').eq('competition_slug', compSlug);
    if(tagRes.error) throw tagRes.error;
    var directIds = {};
    direct.forEach(function(j){ directIds[j.id] = true; });
    var extraIds = (tagRes.data || []).map(function(r){ return r.jersey_id; }).filter(function(id){ return !directIds[id]; });

    var extra = [];
    if(extraIds.length){
      var extraQ = supabaseClient.from('jerseys').select('*, jersey_images(*), teams(*), jersey_competitions(competitions(name))')
        .in('id', extraIds).order('created_at', {ascending:true});
      if(opts.season) extraQ = extraQ.eq('season', opts.season);
      var extraRes = await extraQ;
      if(extraRes.error) throw extraRes.error;
      extra = extraRes.data || [];
    }
    return direct.concat(extra);
  }

  async function viewCompetition(sportSlug, compSlug){
    var res = await supabaseClient.from('competitions').select('*, sports(*)').eq('slug', compSlug).single();
    if(res.error) throw res.error;
    var comp = res.data, sport = comp.sports;
    setCrumbs([{label:'Home', href:'#/'},{label:sport.name, href:'#/sport/'+sportSlug},{label:comp.name, href:'#'}]);

    var teamsRes = await supabaseClient.from('teams').select('*').eq('competition_slug', compSlug).order('name');
    if(teamsRes.error) throw teamsRes.error;
    var teams = teamsRes.data || [];
    // Promotion/relegation comps (Super League etc.) keep a relegated club's
    // full history right where it is rather than moving it — is_active just
    // controls which section of this page it shows up in. is_upcoming is
    // for an announced-but-not-yet-playing expansion club (Perth Bears,
    // Tasmania Devils) — it gets its own section regardless of is_active.
    var upcomingTeams = teams.filter(function(t){ return t.is_upcoming; });
    var activeTeams = teams.filter(function(t){ return !t.is_upcoming && t.is_active !== false; });
    var formerTeams = teams.filter(function(t){ return !t.is_upcoming && t.is_active === false; });

    // A team with nothing logged yet looks identical to one with a full
    // history until you click in — a count on the card itself saves that
    // click, especially useful on the huge international rosters where
    // most teams currently have nothing uploaded.
    var jerseyCountByTeam = {};
    function teamCard(t, startHidden){
      var note = (t.is_upcoming && t.history_note) ? '<span class="upcoming-note">'+esc(t.history_note)+'</span>' : '';
      var formatsAttr = t.formats && t.formats.length ? ' data-formats="'+esc(t.formats.join(','))+'"' : '';
      var hideAttr = startHidden ? ' hidden data-paginated-overflow' : '';
      var count = jerseyCountByTeam[t.id] || 0;
      var countHtml = '<span class="team-jersey-count">'+(count ? count+' jersey'+(count===1?'':'s') : 'No jerseys yet')+'</span>';
      return '<a class="team-card" href="#/sport/'+sportSlug+'/'+compSlug+'/team/'+t.slug+'"'+formatsAttr+hideAttr+'>'+teamSwatch(t)+'<div class="team-info"><h3>'+esc(t.name)+'</h3>'+note+countHtml+'</div></a>';
    }
    // A competition with a huge team list (the ~100+ countries under an
    // International comp) is a long scroll to a flat grid — past this
    // size, only the first batch renders visible and the rest sit
    // behind a "Show all" button. Small/mid comps (NFL, MLB and the
    // like, usually 30-40ish teams) stay exactly as they were, one flat
    // grid, no button.
    var TEAM_GRID_PAGE_SIZE = 20, TEAM_GRID_PAGE_THRESHOLD = 40;
    function teamGridHtml(list, gridId){
      var idAttr = gridId ? ' id="'+gridId+'"' : '';
      if(list.length <= TEAM_GRID_PAGE_THRESHOLD){
        return '<div class="team-grid"'+idAttr+'>'+list.map(function(t){ return teamCard(t); }).join('')+'</div>';
      }
      var cards = list.slice(0, TEAM_GRID_PAGE_SIZE).map(function(t){ return teamCard(t); }).join('') +
        list.slice(TEAM_GRID_PAGE_SIZE).map(function(t){ return teamCard(t, true); }).join('');
      return '<div class="team-grid"'+idAttr+'>'+cards+'</div>' +
        '<button class="btn btn-secondary show-all-teams-btn" type="button" style="margin-top:12px;">Show all '+list.length+' teams</button>';
    }

    // Season-by-season mini galleries underneath the team list, most recent
    // season first, so a visitor who wants "this year's kits" doesn't have
    // to hunt through the team grid first — same idea as footballkitarchive's
    // league pages. Only seasons that actually have jerseys logged show up.
    var seasonJerseys = await fetchCompetitionJerseys(compSlug);
    seasonJerseys.forEach(function(j){ jerseyCountByTeam[j.teams.id] = (jerseyCountByTeam[j.teams.id] || 0) + 1; });
    var bySeasonAll = {};
    seasonJerseys.forEach(function(j){ (bySeasonAll[j.season] = bySeasonAll[j.season] || []).push(j); });
    var seasonYears = Object.keys(bySeasonAll).sort(function(a,b){ return seasonSortKey(b) - seasonSortKey(a); });
    var seasonGalleriesHtml = seasonYears.length
      ? '<div class="section-head" style="margin-top:34px;"><h2>Browse by season</h2></div>' + seasonYears.map(function(y){
          var js = bySeasonAll[y];
          var cards = js.slice(0, 6).map(function(j){ return jerseyCard(j, j.teams, {showTeam:true}); }).join('');
          var seeAll = js.length > 6 ? ' <a class="spec-link" href="#/sport/'+sportSlug+'/'+compSlug+'/season/'+y+'" style="margin-left:14px;">See all '+js.length+' jerseys &rarr;</a>' : '';
          return '<div class="season-group"><h3><a class="spec-link" href="#/sport/'+sportSlug+'/'+compSlug+'/season/'+y+'">'+y+' season</a>'+seeAll+'</h3><div class="jersey-grid">'+cards+'</div></div>';
        }).join('')
      : '';

    // Surfaces whatever's actually popular in this competition, using the
    // same jersey list the season galleries already fetched — helps drive
    // traffic to the jerseys people rate highly, not just the newest ones.
    var topRatedHtml = '';
    if(seasonJerseys.length){
      var jerseyIds = seasonJerseys.map(function(j){ return j.id; });
      var ratingsRes = await supabaseClient.from('jersey_ratings').select('*').in('jersey_id', jerseyIds);
      var ratingsByJersey = {};
      (ratingsRes.data || []).forEach(function(r){ ratingsByJersey[r.jersey_id] = r; });
      var rated = seasonJerseys.filter(function(j){
        var r = ratingsByJersey[j.id];
        return r && r.rating_count >= MIN_RATINGS_FOR_HIGHEST_RATED;
      }).sort(function(a,b){
        var ra = ratingsByJersey[a.id], rb = ratingsByJersey[b.id];
        return (rb.avg_rating - ra.avg_rating) || (rb.rating_count - ra.rating_count);
      }).slice(0, 6);
      if(rated.length){
        var topCards = rated.map(function(j){ return jerseyCard(j, j.teams, {showTeam:true}); }).join('');
        topRatedHtml = '<div class="section-head" style="margin-top:34px;"><h2>Highest rated</h2></div><div class="jersey-grid">'+topCards+'</div>';
      }
    }

    var compLogoButtonsHtml = (comp.logo_path ? '<button class="btn btn-secondary" id="comp-logo-history-toggle" data-comp-slug="'+comp.slug+'" type="button">Logo history</button>' : '') +
      ((currentUser && !(currentProfile && currentProfile.is_banned)) ? '<button class="btn btn-secondary" id="propose-comp-logo-toggle" data-comp-slug="'+comp.slug+'" type="button">'+(comp.logo_path ? '+ Update logo' : '+ Add logo')+'</button>' : '');
    var compLogoBlock = compLogoButtonsHtml
      ? '<div class="add-photos-block">' +
          '<div style="display:flex;gap:10px;flex-wrap:wrap;">'+compLogoButtonsHtml+'</div>' +
          (comp.logo_path ? '<div id="comp-logo-history-panel" hidden></div>' : '') +
          (currentUser ? '<div id="propose-comp-logo-panel" hidden></div>' : '') +
        '</div>'
      : '';

    // Some competitions (international cricket especially) mix teams with
    // very different real-world status — every Test nation also plays
    // ODI/T20I, but plenty of countries are T20I-only, and a single
    // alphabetical grid buries the likes of the USA a long way from
    // Australia. Where teams carry a `formats` tag, filter chips switch
    // which formats show (a team can match more than one). Independently,
    // any competition that mixes men's and women's teams (the merged
    // internationals, rugby union's international, WPL/WCPL...) splits
    // into men's/women's columns side by side.
    var formatOrder = FORMATS_BY_SPORT[sportSlug] || [];
    var hasFormatTags = activeTeams.some(function(t){ return t.formats && t.formats.length; });
    // A competition whose own name/slug already says "Women" is entirely
    // women's teams by definition - without this, a club whose own name
    // doesn't happen to include the word "Women" (Canberra United FC,
    // unlike its A-League Women siblings) would wrongly land in a bogus
    // "Men's" column below purely because its name doesn't match.
    var compIsWomensOnly = /\bwomen\b/i.test(comp.name) || /-women\b/.test(comp.slug);
    var menTeams = compIsWomensOnly ? [] : activeTeams.filter(function(t){ return !/\bwomen\b/i.test(t.name); });
    var womenTeams = compIsWomensOnly ? activeTeams : activeTeams.filter(function(t){ return /\bwomen\b/i.test(t.name); });
    var formatChipsHtml = '';
    if(hasFormatTags){
      var presentFormats = formatOrder.filter(function(f){
        return activeTeams.some(function(t){ return t.formats && t.formats.indexOf(f) > -1; });
      });
      formatChipsHtml = '<div class="filter-row" id="team-format-filter-row">' +
          '<button class="chip team-format-filter-chip is-active" data-format="" type="button">All Formats</button>' +
          presentFormats.map(function(f){ return '<button class="chip team-format-filter-chip" data-format="'+esc(f)+'" type="button">'+esc(f)+'</button>'; }).join('') +
        '</div>';
    }
    // Some competitions (NBL1's North/South/Central/West) run as
    // separate regional conferences rather than one flat table — grouped
    // the same way "more competitions" is grouped by country on a sport
    // page, alphabetically, with any untagged team falling into its own
    // "Other" bucket at the end so a partially-tagged competition still
    // renders sensibly.
    function teamsByConference(list){
      var groups = {};
      list.forEach(function(t){
        var g = t.conference || 'Other';
        (groups[g] = groups[g] || []).push(t);
      });
      var groupNames = Object.keys(groups).sort(function(a,b){
        if(a==='Other') return 1;
        if(b==='Other') return -1;
        return a.localeCompare(b);
      });
      return groupNames.map(function(g){
        var sorted = groups[g].slice().sort(function(a,b){ return a.name.localeCompare(b.name); });
        return '<div class="conference-group"><h4 class="extra-kits-label">'+esc(g)+(g==='Other'?'':' Conference')+'</h4>'+teamGridHtml(sorted)+'</div>';
      }).join('');
    }
    var hasConferences = activeTeams.some(function(t){ return t.conference; });
    var showGenderSplit = menTeams.length && womenTeams.length;
    var teamsGridHtml = formatChipsHtml + (hasConferences
      ? teamsByConference(activeTeams)
      : (showGenderSplit
        ? '<div class="gender-split-grid">' +
            '<div><h4 class="extra-kits-label">Men&rsquo;s &middot; <span id="men-count">'+menTeams.length+'</span></h4>'+teamGridHtml(menTeams, 'men-team-grid')+'</div>' +
            '<div><h4 class="extra-kits-label">Women&rsquo;s &middot; <span id="women-count">'+womenTeams.length+'</span></h4>'+teamGridHtml(womenTeams, 'women-team-grid')+'</div>' +
          '</div>'
        : teamGridHtml(activeTeams)));

    return '<div class="section-head" style="align-items:center;">' +
        '<div style="display:flex;align-items:center;gap:2px;">'+compLogoSwatch(comp, {large:true})+'<h2 style="margin-left:2px;">'+esc(comp.name)+'</h2></div>' +
        '<span class="count">'+(activeTeams.length ? activeTeams.length+' teams' : seasonJerseys.length+' jersey'+(seasonJerseys.length===1?'':'s'))+'</span>' +
      '</div>' +
      compLogoBlock +
      (activeTeams.length
        ? '<div class="filter-row"><input type="text" id="team-filter" placeholder="Filter teams..."></div>'+teamsGridHtml
        // A competition with no teams of its own (a World Cup-style extra
        // tag, tagged onto jerseys whose real team lives elsewhere) isn't
        // "empty" if jerseys are tagged onto it — only say so when it
        // genuinely has neither.
        : (seasonJerseys.length ? '' : '<div class="empty-note">No teams logged in '+esc(comp.name)+' yet.</div>')) +
      (upcomingTeams.length
        ? '<div class="section-head" style="margin-top:34px;"><h2>New expansion teams</h2><span class="count">'+upcomingTeams.length+'</span></div><div class="team-grid">'+upcomingTeams.map(function(t){ return teamCard(t); }).join('')+'</div>'
        : '') +
      (formerTeams.length
        ? '<div class="section-head" style="margin-top:34px;"><h2>Former teams</h2><span class="count">'+formerTeams.length+'</span></div><div class="team-grid">'+formerTeams.map(function(t){ return teamCard(t); }).join('')+'</div>'
        : '') +
      seasonGalleriesHtml +
      topRatedHtml +
      renderReportButton('competition', comp.slug, comp.name);
  }

  async function viewTeam(sportSlug, compSlug, teamSlug){
    var teamRes = await supabaseClient.from('teams').select('*, competitions(*, sports(*))').eq('competition_slug', compSlug).eq('slug', teamSlug).single();
    if(teamRes.error) throw teamRes.error;
    var team = teamRes.data, comp = team.competitions, sport = comp.sports;
    setCrumbs([{label:'Home', href:'#/'},{label:sport.name, href:'#/sport/'+sportSlug},{label:comp.name, href:'#/sport/'+sportSlug+'/'+compSlug},{label:team.name, href:'#'}]);

    var jRes = await supabaseClient.from('jerseys').select('*, jersey_images(*), jersey_competitions(competitions(name))').eq('team_id', team.id).order('season', {ascending:false}).order('created_at', {ascending:true});
    if(jRes.error) throw jRes.error;
    var jerseys = jRes.data || [];
    var bySeason = {};
    jerseys.forEach(function(j){ (bySeason[j.season] = bySeason[j.season] || []).push(j); });
    var years = Object.keys(bySeason).sort(function(a,b){ return seasonSortKey(b) - seasonSortKey(a); });
    // Match jerseys and training/pre-match kits are kept in separate tabs
    // rather than mixed into every season group — a team that brings out
    // one or two training tops a season is fine either way, but some
    // clubs log 10-20 of them, which buries the actual match kits in a
    // wall of cards if they're inline. "Training & other" only appears
    // as a tab at all when the team has at least one.
    var TRAINING_TYPES_BASE = ['training','pre-season','warm-up','pre-match'];
    function isTrainingType(t){ return TRAINING_TYPES_BASE.indexOf(baseJerseyType(t).toLowerCase()) > -1; }
    var mainJerseys = jerseys.filter(function(j){ return !isTrainingType(j.type); });
    var trainingJerseys = jerseys.filter(function(j){ return isTrainingType(j.type); });
    function seasonGroups(list, showSeasonLink){
      var by = {};
      list.forEach(function(j){ (by[j.season] = by[j.season] || []).push(j); });
      var ys = Object.keys(by).sort(function(a,b){ return seasonSortKey(b) - seasonSortKey(a); });
      return ys.map(function(y){
        var sorted = showSeasonLink ? sortJerseysByType(by[y], sportSlug, compSlug, y) : by[y];
        var cards = sorted.map(function(j){ return jerseyCard(j, team); }).join('');
        var heading = showSeasonLink
          ? '<a class="spec-link" href="#/sport/'+sportSlug+'/'+compSlug+'/season/'+y+'">'+y+'</a>'
          : y;
        return '<div class="season-group"><h3>'+heading+'</h3><div class="jersey-grid">'+cards+'</div></div>';
      }).join('');
    }
    var mainGroupsRaw = seasonGroups(mainJerseys, true);
    // Only falls back to a fallback string when a training tab exists
    // (so it reads as "no match kits yet, but see the Training tab")
    // — with no training jerseys either, an empty string here correctly
    // falls through to the page's own "No jerseys logged yet" below.
    var groups = trainingJerseys.length
      ? '<div class="jersey-tabs" id="team-jersey-tabs">' +
          '<button class="chip is-active" data-tab="team-tab-main" type="button">Match jerseys <span class="count">'+mainJerseys.length+'</span></button>' +
          '<button class="chip" data-tab="team-tab-training" type="button">Training &amp; other <span class="count">'+trainingJerseys.length+'</span></button>' +
        '</div>' +
        '<div id="team-tab-main">'+(mainGroupsRaw || '<div class="empty-note">No match jerseys logged yet.</div>')+'</div>' +
        '<div id="team-tab-training" hidden>'+seasonGroups(trainingJerseys, false)+'</div>'
      : mainGroupsRaw;

    var normalizedTeamName = normalizeTeamName(team.name);
    var siblingRes = await supabaseClient.from('teams').select('*, competitions(*)').ilike('name', normalizedTeamName+'%').neq('id', team.id);
    var siblings = (siblingRes.error ? [] : siblingRes.data || []).filter(function(t){
      return t.competitions.sport_slug === sportSlug && normalizeTeamName(t.name).toLowerCase() === normalizedTeamName.toLowerCase();
    });
    var siblingsHtml = siblings.length
      ? '<p class="also-see">Also see: ' + siblings.map(function(t){
          return '<a class="spec-link" href="#/sport/'+sportSlug+'/'+t.competitions.slug+'/team/'+t.slug+'">'+esc(t.competitions.name)+'</a>';
        }).join(' &middot; ') + '</p>'
      : '';

    // Cricket (and anything else with a Format field) can have a team's
    // jerseys spread across several formats — Test, ODI, T20I and so on
    // all live on this same page, so a quick filter jumps between them
    // instead of needing separate pages per format.
    var sportFormats = FORMATS_BY_SPORT[sportSlug];
    var formatsPresent = sportFormats
      ? sportFormats.filter(function(f){ return jerseys.some(function(j){ return j.format === f; }); })
      : [];
    var formatFilterHtml = formatsPresent.length > 1
      ? '<div class="filter-row" id="format-filter-row">' +
          '<button class="chip format-filter-chip is-active" data-format="" type="button">All formats</button>' +
          formatsPresent.map(function(f){ return '<button class="chip format-filter-chip" data-format="'+esc(f)+'" type="button">'+esc(f)+'</button>'; }).join('') +
        '</div>'
      : '';

    var isAdmin = currentProfile && currentProfile.is_admin;
    var isActiveTeam = team.is_active !== false;
    var statusBadge = team.is_upcoming
      ? '<p class="former-badge">Not yet competing in '+esc(comp.name)+' &mdash; upcoming expansion team.</p>'
      : (!isActiveTeam ? '<p class="former-badge">No longer competing in '+esc(comp.name)+'.</p>' : '');

    // Explains gaps in a team's timeline — folded, merged, or promoted away
    // and back — without needing a separate "defunct teams" table; it's
    // just a free-text note an admin can add, same edit affordance as
    // everything else on this page.
    var historyEditData = {table:'teams', matchCol:'id', matchVal:team.id, field:'history_note', current:team.history_note || '', multiline:true};
    var historyEditBtn = isAdmin ? ' <button class="edit-pencil-btn" type="button" data-edit=\''+esc(JSON.stringify(historyEditData))+'\'>'+ICON_PENCIL+'</button>' : '';
    var historyHtml = (team.history_note || isAdmin)
      ? '<div class="notes-block"><div class="spec-value-row">'+(team.history_note ? esc(team.history_note) : '<em style="color:var(--text-dim2);">No history note</em>')+historyEditBtn+'</div></div>'
      : '';

    // Tucked away at the bottom rather than a prominent box — this is only
    // needed for promotion/relegation competitions (Super League, the
    // English football pyramid, etc.), and only rarely even then. An admin
    // picks the right competition rather than the app guessing it, since
    // getting it wrong in an unfamiliar one is easy.
    var adminSettingsBlock = isAdmin
      ? '<div class="admin-settings-block">' +
          '<button class="chip" id="admin-settings-toggle" type="button">Admin: team settings</button>' +
          '<div id="admin-settings-panel" hidden>' +
            '<label class="rate-label">Competition</label>' +
            renderCompetitionMoveControl('team-page', team.id, sportSlug, compSlug) +
            '<label class="rate-label" style="margin-top:14px;">Status</label>' +
            '<div style="display:flex;gap:8px;flex-wrap:wrap;">' +
              (team.is_upcoming ? '<button class="btn btn-secondary" id="toggle-upcoming-btn" data-team-id="'+team.id+'" type="button">Move to active roster</button>' : '') +
              '<button class="btn btn-secondary" id="toggle-active-btn" data-team-id="'+team.id+'" data-active="'+isActiveTeam+'" type="button">'+(isActiveTeam ? 'Mark as former team' : 'Mark as active team')+'</button>' +
            '</div>' +
          '</div>' +
        '</div>'
      : '';

    // Signed-in users can always propose a logo, whether the team has one
    // yet or is getting an update/replacement — approval (setTeamLogo)
    // already keeps the old one in history rather than losing it.
    var logoButtonsHtml = (team.logo_path ? '<button class="btn btn-secondary" id="logo-history-toggle" data-team-id="'+team.id+'" type="button">Logo history</button>' : '') +
      ((currentUser && !(currentProfile && currentProfile.is_banned)) ? '<button class="btn btn-secondary" id="propose-logo-toggle" data-team-id="'+team.id+'" type="button">'+(team.logo_path ? '+ Update logo' : '+ Add logo')+'</button>' : '');
    var logoBlock = logoButtonsHtml
      ? '<div class="add-photos-block">' +
          '<div style="display:flex;gap:10px;flex-wrap:wrap;">'+logoButtonsHtml+'</div>' +
          (team.logo_path ? '<div id="logo-history-panel" hidden></div>' : '') +
          (currentUser ? '<div id="propose-logo-panel" hidden></div>' : '') +
        '</div>'
      : '';

    return '<div class="section-head" style="align-items:center;">'+teamSwatch(team, {large:true})+'<h2 style="margin-left:2px;">'+esc(team.name)+'</h2></div>' +
      statusBadge +
      siblingsHtml +
      historyHtml +
      logoBlock +
      formatFilterHtml +
      (groups || '<div class="empty-note">No jerseys logged yet.</div>') +
      renderReportButton('team', team.id, team.name) +
      adminSettingsBlock;
  }

  async function viewSeason(sportSlug, compSlug, year){
    var compRes = await supabaseClient.from('competitions').select('*, sports(*)').eq('slug', compSlug).single();
    if(compRes.error) throw compRes.error;
    var comp = compRes.data, sport = comp.sports;
    setCrumbs([{label:'Home', href:'#/'},{label:sport.name, href:'#/sport/'+sportSlug},{label:comp.name, href:'#/sport/'+sportSlug+'/'+compSlug},{label:year+' season', href:'#'}]);

    var jerseys = await fetchCompetitionJerseys(compSlug, {season: year});
    var byTeam = {};
    jerseys.forEach(function(j){ (byTeam[j.teams.id] = byTeam[j.teams.id] || {team:j.teams, jerseys:[]}).jerseys.push(j); });

    var groups = Object.keys(byTeam).map(function(id){ return byTeam[id]; })
      .sort(function(a,b){ return a.team.name.localeCompare(b.team.name); })
      .map(function(entry){
        var sorted = sortJerseysByType(entry.jerseys, sportSlug, compSlug, year);
        var cards = sorted.map(function(j){ return jerseyCard(j, entry.team); }).join('');
        return '<div class="season-group"><h3><a class="spec-link" href="#/sport/'+sportSlug+'/'+compSlug+'/team/'+entry.team.slug+'">'+esc(entry.team.name)+'</a></h3><div class="jersey-grid">'+cards+'</div></div>';
      }).join('');

    return '<div class="section-head"><h2>'+esc(comp.name)+' &mdash; '+year+'</h2></div>' +
      (groups || '<div class="empty-note">No jerseys logged for '+year+' yet.</div>');
  }

  async function viewJerseyDetail(id){
    var res = await supabaseClient.from('jerseys').select('*, jersey_images(*), teams(*, competitions(*, sports(*)))').eq('id', id).single();
    if(res.error) throw res.error;
    var j = res.data, team = j.teams, comp = team.competitions, sport = comp.sports;
    setCrumbs([
      {label:'Home', href:'#/'},{label:sport.name, href:'#/sport/'+sport.slug},
      {label:comp.name, href:'#/sport/'+sport.slug+'/'+comp.slug},
      {label:team.name, href:'#/sport/'+sport.slug+'/'+comp.slug+'/team/'+team.slug},
      {label:j.season+' '+j.type, href:'#'}
    ]);

    // Extra competitions this same jersey was also worn in — its home
    // competition is comp above; anything here is a tag on top, e.g. a
    // country's regular kit also worn at a World Cup.
    var extraCompsRes = await supabaseClient.from('jersey_competitions').select('competitions(*)').eq('jersey_id', id);
    var extraComps = (extraCompsRes.data || []).map(function(r){ return r.competitions; }).filter(Boolean);

    var images = j.jersey_images && j.jersey_images.length ? sortImagesForDisplay(j.jersey_images) : null;
    var mainHtml = images ? '<img class="lightbox-trigger" src="'+esc(publicImageUrl(images[0].storage_path))+'" alt="">' : jerseyThumb(j, team);
    var thumbs = images ? images.map(function(img,i){
      return '<button class="gallery-thumb'+(i===0?' is-active':'')+'" data-idx="'+i+'" type="button" title="'+esc(img.label)+'"><img src="'+esc(publicImageUrl(img.storage_path))+'" alt="" loading="lazy"></button>';
    }).join('') : '';

    var rating = await fetchRating(id);
    var myRatingVal = null;
    var inCollection = false;
    if(currentUser){
      var mine = await supabaseClient.from('ratings').select('value').eq('jersey_id', id).eq('user_id', currentUser.id).maybeSingle();
      if(!mine.error && mine.data) myRatingVal = mine.data.value;
      var colRes = await supabaseClient.from('collection_items').select('id').eq('jersey_id', id).eq('user_id', currentUser.id).maybeSingle();
      inCollection = !colRes.error && !!colRes.data;
    }

    var uploaderHtml = '';
    if(j.uploaded_by){
      var uploaderRes = await supabaseClient.from('profiles').select('username,points').eq('id', j.uploaded_by).maybeSingle();
      if(!uploaderRes.error && uploaderRes.data){
        uploaderHtml = '<span>uploaded by <a class="spec-link" href="#/user/'+encodeURIComponent(uploaderRes.data.username)+'">'+esc(uploaderRes.data.username)+'</a> '+pointsChip(uploaderRes.data.points)+'</span>';
      }
    }

    // A moderator-only courtesy credit for a contribution that doesn't
    // fit uploaded_by/proposed_by - e.g. merging a duplicate
    // submission's extra photo into this jersey, where the photo row
    // itself ends up attributed to whichever admin re-uploaded it, not
    // whoever actually found it. Public once added - shown right next
    // to "uploaded by", same as any other credit on the site.
    var acRes = await supabaseClient.from('jersey_additional_credits').select('*').eq('jersey_id', id).order('created_at');
    var additionalCredits = acRes.error ? [] : (acRes.data || []);
    var acUserIds = additionalCredits.map(function(c){ return c.user_id; });
    var acUsernames = {};
    if(acUserIds.length){
      var acProfRes = await supabaseClient.from('profiles').select('id, username').in('id', acUserIds);
      (acProfRes.data || []).forEach(function(p){ acUsernames[p.id] = p.username; });
    }
    var additionalCreditsHtml = additionalCredits.map(function(c){
      var uname = acUsernames[c.user_id] || 'unknown';
      return '<span>also credited: <a class="spec-link" href="#/user/'+encodeURIComponent(uname)+'">'+esc(uname)+'</a>'+(c.note ? ' &mdash; '+esc(c.note) : '')+'</span>';
    }).join('');

    var pendingBanner = j.status === 'rejected'
      ? '<div class="pending-banner">This submission was rejected &mdash; only you and moderators can see it.' + (j.rejection_reason ? '<br><strong>Reason:</strong> '+esc(j.rejection_reason) : ' No reason was given.') + '</div>'
      : (j.status && j.status !== 'approved'
        ? '<div class="pending-banner">This jersey is '+esc(j.status)+' &mdash; only you and moderators can see it until it’s approved.</div>' : '');

    var isAdmin = currentProfile && currentProfile.is_admin;
    // A small private back-and-forth scoped to this one jersey - lets a
    // moderator ask "can you find a better photo?" instead of either
    // approving as-is or flat-out rejecting over something fixable.
    // RLS on jersey_messages already restricts this to the uploader and
    // admins; the isUploader/isAdmin check here just avoids querying
    // (and rendering an empty section) for anyone else.
    var isUploader = !!(currentUser && j.uploaded_by === currentUser.id);
    var messagesHtml = '';
    if(isUploader || isAdmin){
      var threadHtml = await jerseyMessagesThreadHtml(j.id);
      // Viewing the thread marks it read - the topbar's unread badge
      // (see refreshAuthUI/my_unread_jersey_messages) is what actually
      // tells either side a reply came in, so this is what clears it.
      var readUpsert = await supabaseClient.from('jersey_message_reads').upsert(
        {jersey_id: j.id, user_id: currentUser.id, last_read_at: new Date().toISOString()}, {onConflict:'jersey_id,user_id'}
      );
      if(!readUpsert.error && unreadMsgCount) await refreshAuthUI();
      messagesHtml = '<div class="jersey-messages-block">' +
        '<label class="rate-label">Messages</label>' +
        '<div class="jersey-messages-thread" id="jersey-messages-thread">'+threadHtml+'</div>' +
        (currentProfile && currentProfile.is_banned
          ? '<p class="field-hint">Your account is banned from sending messages.</p>'
          : '<div class="jersey-message-form"><textarea id="jersey-message-input" rows="2" placeholder="'+(isAdmin ? 'Ask the uploader something, e.g. ‘Can you find a clearer photo?’' : 'Reply to the moderator…')+'"></textarea><button class="btn btn-secondary" id="jersey-message-send" type="button" data-jersey-id="'+j.id+'">Send</button></div>') +
      '</div>';
    }
    // Lets the uploader fix their own mistake (wrong season, wrong
    // type, a typo) without having to delete and re-upload from
    // scratch, same as several users have apparently been doing. Scoped
    // tight on purpose: jersey-table fields only (Season/Jersey type/
    // Manufacturer/Format/Notes/Image credit), never Competition or
    // Team - those edit a *shared* competitions/teams row, not this
    // jersey alone, so they stay admin-only regardless. RLS backs this
    // up independently either way ("users can edit their own jerseys,
    // admins can moderate any" only allows it while status='pending').
    var canSelfEdit = isUploader && j.status === 'pending';
    function specItem(label, valueHtml, editData){
      var allowed = editData && (isAdmin || (canSelfEdit && editData.table === 'jerseys'));
      var editBtn = allowed ? ' <button class="edit-pencil-btn" type="button" data-edit=\''+esc(JSON.stringify(editData))+'\'>'+ICON_PENCIL+'</button>' : '';
      return '<div class="spec-item"><span>'+esc(label)+'</span><div class="spec-value-row"><strong>'+valueHtml+'</strong>'+editBtn+'</div></div>';
    }
    var notesEditData = {table:'jerseys', matchCol:'id', matchVal:j.id, field:'notes', current:j.notes || '', multiline:true};
    var notesEditBtn = (isAdmin || canSelfEdit) ? ' <button class="edit-pencil-btn" type="button" data-edit=\''+esc(JSON.stringify(notesEditData))+'\'>'+ICON_PENCIL+'</button>' : '';
    var notesHtml = (j.notes || isAdmin || canSelfEdit)
      ? '<div class="notes-block"><div class="spec-value-row">'+(j.notes ? esc(j.notes) : '<em style="color:var(--text-dim2);">No notes</em>')+notesEditBtn+'</div></div>'
      : '';
    var creditEditData = {table:'jerseys', matchCol:'id', matchVal:j.id, field:'image_credit', current:j.image_credit || ''};
    var creditEditBtn = (isAdmin || canSelfEdit) ? ' <button class="edit-pencil-btn" type="button" data-edit=\''+esc(JSON.stringify(creditEditData))+'\'>'+ICON_PENCIL+'</button>' : '';
    var creditHtml = (j.image_credit || isAdmin || canSelfEdit)
      ? '<div class="notes-block"><div class="spec-value-row"><span style="color:var(--text-dim2);">Image credit: </span>'+(j.image_credit ? esc(j.image_credit) : '<em style="color:var(--text-dim2);">None given</em>')+creditEditBtn+'</div></div>'
      : '';

    return pendingBanner + '<div class="detail-grid">' +
      '<div class="jersey-gallery"><div class="gallery-main" id="gallery-main">'+mainHtml+'</div>' +
      (thumbs ? '<div class="gallery-thumbs" id="gallery-thumbs" data-images=\''+esc(JSON.stringify(images))+'\'>'+thumbs+'</div>' : '') +
      '</div>' +
      '<div>' +
        '<h1 class="detail-title">'+j.season+' '+esc(team.name)+' '+esc(j.type)+'</h1>' +
        '<p class="detail-sub">'+esc(comp.name)+' &middot; '+esc(sport.name)+'</p>' +
        '<div class="spec-list">' +
          specItem('Sport', '<a class="spec-link" href="#/sport/'+sport.slug+'">'+esc(sport.name)+'</a>', null) +
          specItem(extraComps.length ? 'Competitions' : 'Competition',
            [comp].concat(extraComps).map(function(c){ return '<a class="spec-link" href="#/sport/'+sport.slug+'/'+c.slug+'">'+esc(c.name)+'</a>'; }).join(' &middot; '),
            {table:'competitions', matchCol:'slug', matchVal:comp.slug, field:'name', current:comp.name}) +
          specItem('Team', '<a class="spec-link" href="#/sport/'+sport.slug+'/'+comp.slug+'/team/'+team.slug+'">'+esc(team.name)+'</a>', {table:'teams', matchCol:'id', matchVal:team.id, field:'name', current:team.name}) +
          specItem('Season', '<a class="spec-link" href="#/sport/'+sport.slug+'/'+comp.slug+'/season/'+j.season+'">'+j.season+'</a>', {table:'jerseys', matchCol:'id', matchVal:j.id, field:'season', current:j.season}) +
          specItem('Jersey type', '<a class="spec-link" href="#/type/'+encodeURIComponent(j.type)+'/'+encodeURIComponent(sport.slug)+'/'+encodeURIComponent(comp.slug)+'">'+esc(j.type)+'</a>', {table:'jerseys', matchCol:'id', matchVal:j.id, field:'type', current:j.type}) +
          specItem('Manufacturer', j.manufacturer ? '<a class="spec-link" href="#/manufacturer/'+encodeURIComponent(j.manufacturer)+'">'+esc(j.manufacturer)+'</a>' : 'Unlisted', {table:'jerseys', matchCol:'id', matchVal:j.id, field:'manufacturer', current:j.manufacturer || ''}) +
          (j.format ? specItem('Format', '<a class="spec-link" href="#/format/'+encodeURIComponent(j.format)+'">'+esc(j.format)+'</a>', {table:'jerseys', matchCol:'id', matchVal:j.id, field:'format', current:j.format}) : '') +
        '</div>' +
        notesHtml +
        creditHtml +
        '<div class="stat-row"><span>logged '+fmtDate(j.created_at)+'</span>'+uploaderHtml+additionalCreditsHtml+'</div>' +
        '<div class="rate-block"><span class="rate-label">Rate this jersey</span><div id="rating-widget" data-jersey-id="'+j.id+'">'+ratingWidgetHtml(rating, myRatingVal)+'</div></div>' +
        (j.status === 'approved' ? (
          '<div class="collection-block">' +
            (!currentUser
              ? '<p class="field-hint">Sign in to add this to your collection.</p>'
              : (currentProfile && currentProfile.is_banned)
                ? '<p class="field-hint">Your account is banned from using collections.</p>'
                : '<button class="btn btn-secondary collection-toggle-btn" type="button" data-jersey-id="'+j.id+'" data-in-collection="'+(inCollection?'true':'false')+'">'+(inCollection?'&#10003; In your collection':'+ Add to your collection')+'</button> ' +
                  '<button type="button" class="help-icon-btn" id="collection-help-btn" title="Keep track of jerseys you personally own &mdash; add any jersey to your collection, then see everything you&rsquo;ve collected on your profile page." aria-label="What&rsquo;s this?">?</button>' +
                  '<p class="field-hint collection-help-text" id="collection-help-text" hidden>Keep track of jerseys you personally own &mdash; add any jersey to your collection, then see everything you&rsquo;ve collected on your profile page.</p>') +
          '</div>'
        ) : '') +
        // Open to anyone once the jersey's approved (an extra photo goes
        // through its own pending/review step first - see
        // wireAddPhotosPanel). Before approval, only the uploader or an
        // admin can add one at all (jersey_images RLS enforces the same
        // split), and since it's going straight onto a submission that
        // isn't live yet anyway, it's added immediately rather than
        // needing a second moderation pass on top of the jersey's own.
        ((j.status === 'approved' || isUploader || isAdmin) ? (
          !currentUser
            ? '<div class="add-photos-block"><p class="field-hint">Sign in to add more photos to this jersey.</p></div>'
            : (currentProfile && currentProfile.is_banned)
              ? '<div class="add-photos-block"><p class="field-hint">Your account is banned from adding photos.</p></div>'
              : '<div class="add-photos-block"><button class="btn btn-secondary" id="add-photos-toggle" data-jersey-id="'+j.id+'" data-immediate="'+(j.status !== 'approved' ? 'true' : 'false')+'" type="button">+ Add more photos</button><div id="add-photos-panel" hidden></div></div>'
        ) : '') +
        renderReportButton('jersey', j.id, j.season+' '+team.name+' '+j.type) +
        messagesHtml +
        (isAdmin ? renderJerseyAdminBlock(j, images, sport.slug, additionalCredits, acUsernames, team) : '') +
      '</div>' +
    '</div>';
  }

  // Keeps at most one photo labeled Front and one labeled Back within a
  // set (used by both upload pickers, which hold photos in a local
  // array before anything's saved) — picking Front on a second photo
  // bumps whichever one already had it over to this photo's old label,
  // instead of ending up with two "Front" photos and an ambiguous main
  // image. "Other" has no such cap; any number of photos can share it.
  function reassignPhotoLabel(list, idx, newLabel){
    var oldLabel = list[idx].label;
    if(newLabel !== oldLabel && (newLabel === 'Front' || newLabel === 'Back')){
      var conflictIdx = list.findIndex(function(p, i){ return i !== idx && p.label === newLabel; });
      if(conflictIdx > -1) list[conflictIdx].label = oldLabel;
    }
    list[idx].label = newLabel;
  }
  // Same swap, for editing an already-saved jersey's photos (moderation
  // queue, jersey detail admin block) — two DB writes instead of a local
  // mutation, scoped to whichever set of <select> elements is passed in
  // (one jersey's photos) so it never swaps across two different jerseys.
  function wirePhotoLabelSwap(selects, onSaved){
    var arr = Array.prototype.slice.call(selects);
    arr.forEach(function(sel){ sel.dataset.prev = sel.value; });
    arr.forEach(function(sel){
      sel.addEventListener('change', async function(){
        var newLabel = sel.value, oldLabel = sel.dataset.prev;
        if(newLabel === oldLabel) return;
        var conflict = (newLabel === 'Front' || newLabel === 'Back')
          ? arr.filter(function(o){ return o !== sel; }).find(function(o){ return o.value === newLabel; })
          : null;
        sel.disabled = true;
        if(conflict) conflict.disabled = true;
        var updates = [supabaseClient.from('jersey_images').update({label: newLabel}).eq('id', sel.dataset.imageId)];
        if(conflict) updates.push(supabaseClient.from('jersey_images').update({label: oldLabel}).eq('id', conflict.dataset.imageId));
        var results = await Promise.all(updates);
        var err = results.filter(function(r){ return r.error; })[0];
        if(err){
          sel.disabled = false; if(conflict) conflict.disabled = false;
          alert('Error: ' + err.error.message);
          return;
        }
        (onSaved || render)();
      });
    });
  }

  // Lets a moderator tighten a photo's framing in place instead of
  // rejecting/asking for a re-upload over a crop that's otherwise fine.
  // Downloads the file through the authenticated storage client (not an
  // <img crossorigin> pointed at the public CDN URL) so the canvas never
  // risks being tainted by a cross-origin read — same bucket, just
  // sidestepping any CORS question entirely. Saving re-uploads to the
  // exact same storage_path with upsert, so every place that already
  // links to this photo (approved jersey page, moderation queue) picks
  // up the cropped version with no DB change needed.
  // Shared by both crop entry points below - bucket is which storage
  // bucket the image lives in, and onSaved(newPath) is handed the
  // freshly-uploaded cropped file's path to repoint whichever DB row
  // owns it (a jersey_images row for a jersey photo, a logo proposal
  // row for a logo). Keeps the actual drag/crop/canvas mechanics in one
  // place rather than duplicated per entity type.
  async function openImageCropModal(bucket, storagePath, onSaved){
    var overlay = document.createElement('div');
    overlay.className = 'crop-modal';
    overlay.innerHTML =
      '<div class="crop-modal-inner">' +
        '<div class="crop-stage"><div class="crop-loading">Loading image&hellip;</div></div>' +
        '<p class="field-hint">Drag the box to choose what to keep, then save.</p>' +
        '<div class="crop-modal-actions">' +
          '<button class="btn btn-secondary" type="button" data-crop-cancel>Cancel</button>' +
          '<button class="btn" type="button" data-crop-save disabled>Save crop</button>' +
        '</div>' +
      '</div>';
    document.body.appendChild(overlay);
    var stage = overlay.querySelector('.crop-stage');
    var saveBtn = overlay.querySelector('[data-crop-save]');
    var objectUrl = null;
    function closeModal(){ if(objectUrl) URL.revokeObjectURL(objectUrl); overlay.remove(); }
    overlay.querySelector('[data-crop-cancel]').addEventListener('click', closeModal);
    // pointerdown, not click - a click event's target resolves to the
    // nearest common ancestor of its mousedown and mouseup targets, so a
    // drag that starts on the rect/a handle but ends (pointerup) over
    // the backdrop was firing a click targeted at the overlay itself,
    // silently closing the whole modal mid-drag. pointerdown always
    // targets exactly what was under the cursor at press time, so this
    // only fires on an actual backdrop click.
    overlay.addEventListener('pointerdown', function(e){ if(e.target === overlay) closeModal(); });

    var dl = await supabaseClient.storage.from(bucket).download(storagePath);
    if(dl.error){ stage.innerHTML = '<div class="empty-note">Couldn\'t load image: '+esc(dl.error.message)+'</div>'; return; }
    objectUrl = URL.createObjectURL(dl.data);
    stage.innerHTML = '<img id="crop-img" src="'+objectUrl+'" alt="">' +
      '<div class="crop-rect">' +
        '<div class="crop-handle" data-handle="nw"></div><div class="crop-handle" data-handle="ne"></div>' +
        '<div class="crop-handle" data-handle="sw"></div><div class="crop-handle" data-handle="se"></div>' +
      '</div>';
    var img = stage.querySelector('#crop-img');
    var rect = stage.querySelector('.crop-rect');
    var box = {x:0, y:0, w:0, h:0};

    function setRectBox(x, y, w, h){
      var stageW = stage.clientWidth, stageH = stage.clientHeight;
      w = Math.max(30, Math.min(w, stageW));
      h = Math.max(30, Math.min(h, stageH));
      x = Math.max(0, Math.min(x, stageW - w));
      y = Math.max(0, Math.min(y, stageH - h));
      box = {x:x, y:y, w:w, h:h};
      rect.style.left = x+'px'; rect.style.top = y+'px'; rect.style.width = w+'px'; rect.style.height = h+'px';
    }
    function initRect(){
      var w = stage.clientWidth * 0.8, h = stage.clientHeight * 0.8;
      setRectBox((stage.clientWidth - w) / 2, (stage.clientHeight - h) / 2, w, h);
      saveBtn.disabled = false;
    }
    if(img.complete && img.naturalWidth) initRect(); else img.addEventListener('load', initRect);

    var dragMode = null, startPt = null, startBox = null;
    function onPointerMove(e){
      var dx = e.clientX - startPt.x, dy = e.clientY - startPt.y;
      if(dragMode === 'move'){ setRectBox(startBox.x + dx, startBox.y + dy, startBox.w, startBox.h); return; }
      var x = startBox.x, y = startBox.y, w = startBox.w, h = startBox.h;
      if(dragMode.indexOf('n') > -1){ y = startBox.y + dy; h = startBox.h - dy; }
      if(dragMode.indexOf('s') > -1){ h = startBox.h + dy; }
      if(dragMode.indexOf('w') > -1){ x = startBox.x + dx; w = startBox.w - dx; }
      if(dragMode.indexOf('e') > -1){ w = startBox.w + dx; }
      setRectBox(x, y, w, h);
    }
    function onPointerUp(){
      dragMode = null;
      document.removeEventListener('pointermove', onPointerMove);
      document.removeEventListener('pointerup', onPointerUp);
    }
    function startDrag(mode){
      return function(e){
        e.preventDefault();
        dragMode = mode; startPt = {x:e.clientX, y:e.clientY}; startBox = {x:box.x, y:box.y, w:box.w, h:box.h};
        document.addEventListener('pointermove', onPointerMove);
        document.addEventListener('pointerup', onPointerUp);
      };
    }
    rect.addEventListener('pointerdown', function(e){ if(e.target === rect) startDrag('move')(e); });
    rect.querySelectorAll('.crop-handle').forEach(function(h){ h.addEventListener('pointerdown', startDrag(h.dataset.handle)); });

    saveBtn.addEventListener('click', async function(){
      saveBtn.disabled = true; saveBtn.textContent = 'Saving…';
      try {
        var scaleX = img.naturalWidth / stage.clientWidth, scaleY = img.naturalHeight / stage.clientHeight;
        var canvas = document.createElement('canvas');
        canvas.width = Math.max(1, Math.round(box.w * scaleX));
        canvas.height = Math.max(1, Math.round(box.h * scaleY));
        var ctx = canvas.getContext('2d');
        ctx.drawImage(img, box.x*scaleX, box.y*scaleY, box.w*scaleX, box.h*scaleY, 0, 0, canvas.width, canvas.height);
        var ext = (storagePath.match(/\.(\w+)$/) || [,''])[1].toLowerCase();
        var mime = ext === 'png' ? 'image/png' : ext === 'webp' ? 'image/webp' : 'image/jpeg';
        var blob = await new Promise(function(resolve){ canvas.toBlob(resolve, mime, 0.92); });
        // upload(..., {upsert:true}) onto an existing path fails RLS on
        // this project even with a maximally permissive policy (upsert
        // clearly isn't going through a plain UPDATE the way the docs
        // suggest) - uploading to a new path and only then repointing
        // the DB row sidesteps that entirely, using just a plain insert
        // (new path, never conflicts) and a plain table update, both of
        // which already work everywhere else in the app. It's also
        // safer than overwrite-in-place would have been: if anything
        // fails before the DB row is repointed, the original photo is
        // untouched instead of silently gone.
        var newPath = storagePath.replace(/(\.\w+)$/, '-crop-' + Date.now() + '$1');
        var up = await supabaseClient.storage.from(bucket).upload(newPath, blob, {contentType: mime});
        if(up.error) throw up.error;
        if(onSaved){
          var upd = await onSaved(newPath);
          if(upd && upd.error) throw upd.error;
        }
        await supabaseClient.storage.from(bucket).remove([storagePath]); // best-effort cleanup of the old file
        closeModal();
        render();
      } catch(err){
        alert('Error: ' + err.message);
        saveBtn.disabled = false; saveBtn.textContent = 'Save crop';
      }
    });
  }
  function openCropModal(storagePath, imageId){
    return openImageCropModal('jersey-photos', storagePath, imageId ? function(newPath){
      return supabaseClient.from('jersey_images').update({storage_path: newPath}).eq('id', imageId);
    } : null);
  }
  function openLogoCropModal(storagePath, kind, proposalId){
    var table = kind === 'team' ? 'team_logo_proposals' : 'competition_logo_proposals';
    return openImageCropModal('team-logos', storagePath, function(newPath){
      return supabaseClient.from(table).update({storage_path: newPath}).eq('id', proposalId);
    });
  }
  function wireCropButtons(scope){
    (scope || document).querySelectorAll('.photo-crop-btn').forEach(function(btn){
      btn.addEventListener('click', function(){ openCropModal(btn.dataset.path, btn.dataset.imageId); });
    });
  }

  // Swapping in an entirely different (clearer) photo for an existing
  // Logo History entry - including the current logo - without creating
  // a new history row the way proposing a fresh logo would. Same
  // bucket/onSaved shape as openImageCropModal, but a dropzone instead
  // of a crop stage, since this replaces the file rather than
  // re-cropping the one already there.
  async function openImageReplaceModal(bucket, storagePath, onSaved){
    var overlay = document.createElement('div');
    overlay.className = 'crop-modal';
    overlay.innerHTML =
      '<div class="crop-modal-inner">' +
        '<div class="dropzone" id="replace-modal-dropzone" tabindex="0" role="button" aria-label="Replace photo">' +
          ICON_PHOTO +
          '<p>Drop a replacement image here, or click to choose</p>' +
          '<input type="file" id="replace-modal-input" accept="image/*" style="display:none;">' +
        '</div>' +
        '<p class="field-hint" id="replace-modal-status" hidden></p>' +
        '<div class="crop-modal-actions">' +
          '<button class="btn btn-secondary" type="button" data-replace-cancel>Cancel</button>' +
        '</div>' +
      '</div>';
    document.body.appendChild(overlay);
    function closeModal(){ overlay.remove(); }
    overlay.querySelector('[data-replace-cancel]').addEventListener('click', closeModal);
    overlay.addEventListener('pointerdown', function(e){ if(e.target === overlay) closeModal(); });

    var dropzone = overlay.querySelector('#replace-modal-dropzone');
    var input = overlay.querySelector('#replace-modal-input');
    var statusEl = overlay.querySelector('#replace-modal-status');

    async function doReplace(file){
      if(!file || !/^image\//.test(file.type)) return;
      statusEl.hidden = false; statusEl.textContent = 'Uploading…';
      dropzone.setAttribute('aria-disabled', 'true');
      try {
        var compressed = await compressImageForUpload(file, LOGO_WEBP_QUALITY);
        var ext = (compressed.name.split('.').pop() || 'png').toLowerCase();
        var newPath = storagePath.replace(/(\.\w+)$/, '-replace-' + Date.now() + '$1');
        var up = await supabaseClient.storage.from(bucket).upload(newPath, compressed);
        if(up.error) throw up.error;
        if(onSaved){
          var upd = await onSaved(newPath);
          if(upd && upd.error) throw upd.error;
        }
        await supabaseClient.storage.from(bucket).remove([storagePath]); // best-effort cleanup of the old file
        closeModal();
        render();
      } catch(err){
        statusEl.textContent = 'Error: ' + (err.message || err);
        dropzone.removeAttribute('aria-disabled');
      }
    }
    dropzone.addEventListener('click', function(){ input.click(); });
    dropzone.addEventListener('keydown', function(e){ if(e.key === 'Enter' || e.key === ' '){ e.preventDefault(); input.click(); } });
    input.addEventListener('change', function(){ var f = input.files[0]; input.value = ''; doReplace(f); });
    dropzone.addEventListener('dragover', function(e){ e.preventDefault(); dropzone.classList.add('is-dragover'); });
    dropzone.addEventListener('dragleave', function(){ dropzone.classList.remove('is-dragover'); });
    dropzone.addEventListener('drop', function(e){
      e.preventDefault();
      dropzone.classList.remove('is-dragover');
      if(e.dataTransfer && e.dataTransfer.files && e.dataTransfer.files[0]) doReplace(e.dataTransfer.files[0]);
    });
  }
  function openLogoReplaceModal(storagePath, kind, logoId){
    var t = logoTables(kind);
    return openImageReplaceModal('team-logos', storagePath, function(newPath){
      return supabaseClient.from(t.history).update({storage_path: newPath}).eq('id', logoId);
    });
  }

  // Tucked away like the team page's own admin panel — fixes a mislabeled
  // front/back photo (which also fixes which one shows as the main image,
  // since that's always whichever is labeled "Front") and reassigns a
  // jersey to a different team/sport entirely, for the rare case one gets
  // approved under the wrong one and can't just be re-uploaded.
  function renderJerseyAdminBlock(j, images, sportSlug, additionalCredits, acUsernames, team){
    // Delete only shows once there's more than one photo, since a jersey
    // always needs at least one — that's the same condition already
    // gating whether this grid renders at all, so there's never a way
    // to delete down to zero from here.
    // Crop always shows, even for a single photo — label/delete stay
    // gated to images.length > 1 as before (a lone photo can't conflict
    // with another, and a jersey always needs at least one left).
    var relabelHtml = (images && images.length)
      ? '<label class="rate-label">Photos</label><div class="logo-history-grid lightbox-group">' + images.map(function(img){
          return '<div class="logo-history-item"><img class="lightbox-trigger" src="'+esc(publicImageUrl(img.storage_path))+'" alt="" loading="lazy">' +
            (images.length > 1 ? (
              '<select class="photo-label-select" data-image-id="'+img.id+'">' +
                ['Front','Back','Other'].map(function(l){ return '<option value="'+l+'"'+(img.label===l?' selected':'')+'>'+l+'</option>'; }).join('') +
              '</select>'
            ) : '') +
            '<button type="button" class="photo-crop-btn" data-path="'+esc(img.storage_path)+'" data-image-id="'+img.id+'">Crop</button>' +
            (images.length > 1 ? '<button type="button" class="photo-delete-btn" data-image-id="'+img.id+'" title="Delete this photo">&#10005;</button>' : '') +
          '</div>';
        }).join('') + '</div>'
      : '';
    // Lets an admin give someone public credit for a contribution that
    // doesn't fit uploaded_by/proposed_by - e.g. merging a duplicate
    // submission's extra photo in by re-uploading it as yourself, where
    // the photo row ends up attributed to the admin, not whoever
    // actually found it. The point award is a separate deliberate
    // choice, not automatic - photo contributions have never earned
    // points on their own regardless of how they're added.
    var creditListHtml = (additionalCredits && additionalCredits.length)
      ? additionalCredits.map(function(c){
          var uname = (acUsernames && acUsernames[c.user_id]) || 'unknown';
          return '<div class="spec-value-row" style="margin-top:6px;"><span>'+esc(uname)+(c.note ? ' &mdash; '+esc(c.note) : '')+'</span>' +
            '<button type="button" class="btn btn-reject delete-credit-btn" data-credit-id="'+c.id+'" style="padding:2px 8px;font-size:12px;">Remove</button></div>';
        }).join('')
      : '';
    return '<div class="admin-settings-block">' +
        '<button class="chip" id="admin-settings-toggle" type="button">Admin: fix photos/team</button>' +
        '<div id="admin-settings-panel" hidden data-sport-slug="'+esc(sportSlug)+'">' +
          relabelHtml +
          '<label class="rate-label" style="margin-top:14px;">Wrong team or sport?</label>' +
          renderJerseyReassignControl('jersey-reassign', j.id) +
          '<label class="rate-label" style="margin-top:14px;">Also used in <small>one extra competition this same jersey was also worn in, e.g. a World Cup</small></label>' +
          '<select id="jersey-extra-comp"><option value="">Loading&hellip;</option></select>' +
          '<label class="rate-label" style="margin-top:14px;">Additional credit <small>for a contribution that doesn&rsquo;t fit the uploader field, e.g. a photo you merged in yourself</small></label>' +
          creditListHtml +
          '<div style="display:flex;gap:8px;flex-wrap:wrap;margin-top:8px;">' +
            '<input type="text" id="jersey-credit-username" placeholder="Username" style="flex:1;min-width:110px;">' +
            '<input type="text" id="jersey-credit-note" placeholder="Note, e.g. added back photo" style="flex:2;min-width:160px;">' +
          '</div>' +
          '<label class="field-hint" style="display:block;margin-top:8px;cursor:pointer;"><input type="checkbox" id="jersey-credit-point" style="vertical-align:middle;margin-right:6px;">Also award them a point</label>' +
          '<button type="button" class="btn btn-secondary" id="jersey-credit-add-btn" data-jersey-id="'+j.id+'" style="margin-top:8px;">Add credit</button>' +
          '<p class="field-hint" id="jersey-credit-msg" hidden></p>' +
          '<label class="rate-label" style="margin-top:14px;">Danger zone</label>' +
          '<button type="button" class="btn btn-reject delete-jersey-btn" data-jersey-id="'+j.id+'" data-redirect="#/sport/'+esc(sportSlug)+'/'+esc(team.competition_slug)+'/team/'+esc(team.slug)+'">Delete this jersey</button>' +
          '<p class="field-hint">Permanently removes it and its photos &mdash; e.g. an approved duplicate. Can&rsquo;t be undone.</p>' +
        '</div>' +
      '</div>';
  }

  // One optional extra competition per jersey (the jersey's own home
  // competition is excluded — that's set via team/reassign, not here).
  // Saves immediately on change — picking "None" deletes the tag.
  async function wireJerseyExtraCompsControl(jerseyId, sportSlug){
    var select = document.getElementById('jersey-extra-comp');
    if(!select) return;
    var jRes = await supabaseClient.from('jerseys').select('teams(competition_slug)').eq('id', jerseyId).single();
    var primaryCompSlug = jRes.data && jRes.data.teams ? jRes.data.teams.competition_slug : null;
    var compsRes = await supabaseClient.from('competitions').select('*').eq('sport_slug', sportSlug).order('name');
    var comps = (compsRes.error ? [] : compsRes.data || []).filter(function(c){ return c.slug !== primaryCompSlug; });
    var tagRes = await supabaseClient.from('jersey_competitions').select('competition_slug').eq('jersey_id', jerseyId);
    var current = (tagRes.data && tagRes.data[0]) ? tagRes.data[0].competition_slug : '';

    select.innerHTML = '<option value="">&mdash; None &mdash;</option>' +
      comps.map(function(c){ return '<option value="'+esc(c.slug)+'"'+(c.slug===current?' selected':'')+'>'+esc(c.name)+'</option>'; }).join('');
    select.addEventListener('change', async function(){
      select.disabled = true;
      var del = await supabaseClient.from('jersey_competitions').delete().eq('jersey_id', jerseyId);
      if(del.error){ select.disabled = false; alert('Error: ' + del.error.message); return; }
      if(select.value){
        var ins = await supabaseClient.from('jersey_competitions').insert({jersey_id: jerseyId, competition_slug: select.value});
        if(ins.error){ select.disabled = false; alert('Error: ' + ins.error.message); return; }
      }
      select.disabled = false;
    });
  }

  // A competition's card grid, capped so a type/manufacturer page that
  // cuts across every team on the site doesn't turn into one giant
  // unscannable wall once there are thousands of jerseys — first batch
  // shown, the rest sits hidden behind a "Show more" button (wired via
  // the global .show-more-btn click delegate) rather than paging out to
  // another URL, so it stays in place.
  var JERSEY_GRID_PAGE_SIZE = 12;
  function limitedJerseyGrid(cards){
    if(cards.length <= JERSEY_GRID_PAGE_SIZE) return '<div class="jersey-grid">'+cards.join('')+'</div>';
    var visible = cards.slice(0, JERSEY_GRID_PAGE_SIZE).join('');
    var rest = cards.slice(JERSEY_GRID_PAGE_SIZE);
    return '<div class="jersey-grid">'+visible+'</div>' +
      '<div class="jersey-grid" hidden>'+rest.join('')+'</div>' +
      '<button class="btn btn-secondary show-more-btn" type="button">Show '+rest.length+' more</button>';
  }
  // A whole sport's jerseys collapsed to a small flat gallery (most
  // recent first) with a "View all" that expands to the complete list
  // grouped by season — used on type/manufacturer pages (and search)
  // where one sport section could otherwise be hundreds or thousands of
  // jerseys deep before a visitor sees anything else. Each season
  // group's own grid still goes through limitedJerseyGrid, in case a
  // single season alone has a huge count.
  var SPORT_GALLERY_PREVIEW = 5;
  // prioritySportSlug/priorityCompSlug: when someone reaches this list by
  // clicking a jersey type/manufacturer FROM a specific jersey, that
  // jersey's own sport is shown first, with everything else following
  // underneath — more useful than a flat alphabetical dump when you
  // clicked through wanting "more like this one" specifically.
  // priorityCompSlug no longer changes the grouping itself (sport
  // sections are no longer split by competition), but is still accepted
  // so existing call sites don't need updating.
  function renderGroupedBySport(jerseys, prioritySportSlug, priorityCompSlug){
    var bySport = {};
    jerseys.forEach(function(j){ var s=j.teams.competitions.sports; (bySport[s.slug]=bySport[s.slug]||{sport:s,jerseys:[]}).jerseys.push(j); });
    var sportOrder = Object.keys(bySport).sort(function(a,b){
      if(prioritySportSlug && a === prioritySportSlug) return -1;
      if(prioritySportSlug && b === prioritySportSlug) return 1;
      return bySport[a].sport.name.localeCompare(bySport[b].sport.name);
    });
    // A jump-to-section nav across the top once there's more than one
    // sport in the results — otherwise finding (say) Rugby Union means
    // scrolling past every other sport's jerseys first. Scrolls in
    // place via JS (wired through .anchor-nav-btn) rather than a real
    // #hash link, since a hash change would trigger the router and
    // re-render the whole page out from under it.
    var anchorNav = sportOrder.length > 1
      ? '<div class="anchor-nav">'+sportOrder.map(function(slug){
          return '<button class="chip anchor-nav-btn" type="button" data-scroll-target="sport-block-'+slug+'">'+esc(bySport[slug].sport.name)+'</button>';
        }).join('')+'</div>'
      : '';
    var blocks = sportOrder.map(function(slug){
      var entry = bySport[slug];
      var sorted = entry.jerseys.slice().sort(function(a,b){ return seasonSortKey(b.season)-seasonSortKey(a.season); });
      var previewHtml = '<div class="jersey-grid sport-preview-grid">'+sorted.slice(0, SPORT_GALLERY_PREVIEW).map(function(j){ return jerseyCard(j, j.teams, {showTeam:true}); }).join('')+'</div>';
      var expandedHtml = '';
      if(sorted.length > SPORT_GALLERY_PREVIEW){
        var bySeason = {};
        sorted.forEach(function(j){ (bySeason[j.season] = bySeason[j.season] || []).push(j); });
        var seasons = Object.keys(bySeason).sort(function(a,b){ return seasonSortKey(b)-seasonSortKey(a); });
        var seasonGroupsHtml = seasons.map(function(y){
          var cards = bySeason[y].map(function(j){ return jerseyCard(j, j.teams, {showTeam:true}); });
          return '<div class="season-group"><h3>'+esc(y)+'</h3>'+limitedJerseyGrid(cards)+'</div>';
        }).join('');
        expandedHtml = '<div class="sport-full-list" hidden>'+seasonGroupsHtml+'</div>' +
          '<button class="btn btn-secondary show-sport-all-btn" type="button">View all '+sorted.length+'</button>';
      }
      return '<section class="block" id="sport-block-'+slug+'"><div class="section-head"><h2><a class="spec-link" href="#/sport/'+slug+'">'+esc(entry.sport.name)+'</a></h2><span class="count">'+sorted.length+'</span></div>'+previewHtml+expandedHtml+'</section>';
    }).join('');
    return anchorNav + blocks;
  }

  // Search matching: strips accents/diacritics (so typing "sao tome"
  // finds "São Tomé") and punctuation, then expands a small set of
  // common sports shorthand so things like "NY Knicks" or "Man Utd"
  // find "New York Knicks" / "Manchester United" even though those
  // exact words never appear together in the raw query.
  var SEARCH_ALIASES = {
    'ny':'new york', 'nyc':'new york', 'la':'los angeles', 'sf':'san francisco',
    'gb':'green bay', 'kc':'kansas city', 'philly':'philadelphia',
    'utd':'united', 'intl':'international', 'int':'international'
  };
  // A few German club names are now shown shorter than their official
  // name (Bundesliga/2. Bundesliga — "FC Bayern Munich" is just "Bayern
  // Munich" on the site now), so a search for the old/official form
  // needs a full-phrase mapping rather than the word-by-word aliases
  // above — those only swap one word for another, they can't also drop
  // an extra word like "FC" or "1." that the shortened name no longer has.
  var SEARCH_PHRASE_ALIASES = {
    'man utd':'manchester united', 'man city':'manchester city', 'psg':'paris saint germain',
    'hull kr':'hull kingston rovers',
    'fc bayern munich':'bayern munich', 'fc bayern munchen':'bayern munich', 'bayern munchen':'bayern munich',
    '1 fsv mainz 05':'fsv mainz', 'fsv mainz 05':'fsv mainz',
    'sv werder bremen':'werder bremen',
    'fc schalke 04':'schalke 04',
    'tsg 1899 hoffenheim':'tsg hoffenheim',
    '1 fc union berlin':'union berlin', 'fc union berlin':'union berlin',
    'hertha bsc':'hertha berlin',
    'arminia bielefeld':'bielefeld',
    'vfl bochum':'bochum',
    'eintracht braunschweig':'braunschweig',
    'darmstadt 98':'darmstadt',
    '1 fc kaiserslautern':'kaiserslautern', 'fc kaiserslautern':'kaiserslautern',
    '1 fc magdeburg':'magdeburg', 'fc magdeburg':'magdeburg',
    '1 fc nurnberg':'fc nurnberg'
  };
  function normalizeSearchText(s){
    return String(s||'').toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g,'')
      .replace(/['’]/g,'').replace(/[^a-z0-9]+/g,' ').trim();
  }
  function expandSearchAliases(normalized){
    var expanded = normalized.split(' ').map(function(w){ return SEARCH_ALIASES[w] || w; }).join(' ');
    // Replaced in place, not appended — appending would leave the raw
    // abbreviation ("kr") as its own token that then has to literally
    // appear in the target name too, which it doesn't ("Hull Kingston
    // Rovers" has no "kr" substring), breaking the very match this is
    // meant to make.
    Object.keys(SEARCH_PHRASE_ALIASES).forEach(function(key){
      if(expanded.indexOf(key) > -1) expanded = expanded.split(key).join(SEARCH_PHRASE_ALIASES[key]);
    });
    return expanded;
  }
  function searchTextMatches(haystackRaw, queryRaw){
    var q = normalizeSearchText(queryRaw);
    if(!q) return false;
    var haystack = normalizeSearchText(haystackRaw);
    if(haystack.indexOf(q) > -1) return true;
    var expandedQ = expandSearchAliases(q);
    if(expandedQ !== q && haystack.indexOf(expandedQ) > -1) return true;
    // Token-subset match: every word of the (expanded) query shows up
    // somewhere in the name, in any order — catches "knicks ny" as well
    // as "ny knicks", and partial multi-word names generally.
    var tokens = expandedQ.split(' ').filter(Boolean);
    return tokens.length > 1 && tokens.every(function(t){ return haystack.indexOf(t) > -1; });
  }
  function editDistance(a, b){
    var m = a.length, n = b.length;
    var dp = [];
    for(var j=0;j<=n;j++) dp[j] = j;
    for(var i=1;i<=m;i++){
      var prev = dp[0];
      dp[0] = i;
      for(var k=1;k<=n;k++){
        var tmp = dp[k];
        dp[k] = a[i-1] === b[k-1] ? prev : 1 + Math.min(prev, dp[k], dp[k-1]);
        prev = tmp;
      }
    }
    return dp[n];
  }

  // Groups matched teams into one section per sport (so searching
  // "Broncos" shows a Rugby League section and an NFL section rather
  // than one long mixed list) — same idea as renderGroupedBySport but
  // for the Teams section, which has no jerseys to key off yet.
  function groupTeamsBySport(teamMatches){
    var bySport = {};
    teamMatches.forEach(function(t){
      var sport = t.competitions.sports;
      (bySport[sport.slug] = bySport[sport.slug] || {sport:sport, teams:[]}).teams.push(t);
    });
    var groups = Object.keys(bySport).sort(function(a,b){
      return bySport[a].sport.name.localeCompare(bySport[b].sport.name);
    }).map(function(slug){
      var entry = bySport[slug];
      var rows = entry.teams.map(function(t){
        var c = t.competitions, sport = c.sports;
        return '<a class="team-row-compact" href="#/sport/'+sport.slug+'/'+c.slug+'/team/'+t.slug+'">'+teamSwatch(t)+'<span class="team-row-name">'+esc(t.name)+'</span><span class="team-row-comp">'+esc(c.name)+'</span></a>';
      }).join('');
      return '<div class="season-group"><h3><a class="spec-link" href="#/sport/'+slug+'">'+esc(entry.sport.name)+'</a></h3><div class="team-list-compact">'+rows+'</div></div>';
    }).join('');
    // Two columns (sport 1 left, sport 2 right, sport 3 back on the
    // left, etc.) instead of stacking every sport in one long column —
    // a broad search can match a dozen different sports.
    return '<div class="sport-team-columns">'+groups+'</div>';
  }

  // Supabase/PostgREST caps how many rows a single request can return
  // (commonly 1000) — a plain .select() over a table bigger than that
  // silently truncates instead of erroring. The teams table in
  // particular has grown well past that with everything added this
  // year, so anything that needs "every row" pages through with
  // .range() until a page comes back short, rather than trusting one
  // request to have gotten everything.
  async function fetchAllRows(table, selectStr, applyFilters){
    var pageSize = 1000, all = [], from = 0;
    while(true){
      var q = supabaseClient.from(table).select(selectStr);
      if(applyFilters) q = applyFilters(q);
      var res = await q.range(from, from + pageSize - 1);
      if(res.error) throw res.error;
      var rows = res.data || [];
      all = all.concat(rows);
      if(rows.length < pageSize) break;
      from += pageSize;
    }
    return all;
  }

  async function viewSearch(term){
    setCrumbs([{label:'Home', href:'#/'},{label:'Search: '+term, href:'#'}]);

    // Matched by name so a team with nothing uploaded yet still shows up
    // and can be clicked into (and uploaded to) instead of the search
    // looking like a dead end just because it has zero jerseys so far.
    var teamRows = await fetchAllRows('teams', '*, competitions(*, sports(*))');
    // Guards against a team whose competition/sport link is broken (a
    // stale or orphaned row) — such a team can't be linked to safely, so
    // it's excluded here rather than throwing and blanking the whole
    // page over one bad record.
    var allTeams = teamRows.filter(function(t){ return t.competitions && t.competitions.sports; });
    var teamMatches = allTeams.filter(function(t){
      return searchTextMatches(t.name, term) || searchTextMatches(t.competitions.name, term);
    }).sort(function(a,b){ return a.name.localeCompare(b.name); });

    var jerseyRows = await fetchAllRows('jerseys', '*, jersey_images(*), teams(*, competitions(*, sports(*))), jersey_competitions(competitions(name))');
    var matches = jerseyRows.filter(function(j){
      var t = j.teams, c = t && t.competitions;
      if(!t || !c || !c.sports) return false;
      return searchTextMatches(t.name, term) || searchTextMatches(c.name, term) ||
        String(j.season).indexOf(term) > -1 || searchTextMatches(j.type, term) ||
        searchTextMatches(j.manufacturer||'', term);
    });

    if(!matches.length && !teamMatches.length){
      // Closest team name by edit distance, offered as a "did you mean"
      // when it's close enough to plausibly be what was meant to be typed.
      var nq = normalizeSearchText(term);
      var suggestion = null, bestDist = Infinity;
      if(nq.length >= 3){
        allTeams.forEach(function(t){
          var d = editDistance(nq, normalizeSearchText(t.name));
          if(d < bestDist){ bestDist = d; suggestion = t; }
        });
      }
      var maxDist = Math.max(2, Math.floor(nq.length * 0.34));
      var suggestHtml = (suggestion && bestDist <= maxDist)
        ? '<p class="empty-note">Did you mean <a class="spec-link" href="#/search/'+encodeURIComponent(suggestion.name)+'">'+esc(suggestion.name)+'</a>?</p>'
        : '';
      return '<div class="section-head"><h2>Results for &ldquo;'+esc(term)+'&rdquo;</h2><span class="count">0 results</span></div><div class="empty-note">Nothing matches yet.</div>'+suggestHtml;
    }

    var teamsHtml = teamMatches.length
      ? '<div class="section-head"><h2>Teams</h2><span class="count">'+teamMatches.length+'</span></div>'+groupTeamsBySport(teamMatches)
      : '';

    var jerseysHtml = matches.length
      ? '<div class="section-head" style="margin-top:'+(teamsHtml ? '34px' : '0')+';"><h2>Jerseys</h2><span class="count">'+matches.length+'</span></div>'+renderGroupedBySport(matches)
      : '';

    return '<div class="section-head"><h2>Results for &ldquo;'+esc(term)+'&rdquo;</h2></div>' + teamsHtml + jerseysHtml;
  }

  async function viewManufacturers(){
    setCrumbs([{label:'Home', href:'#/'},{label:'Manufacturers', href:'#/manufacturers'}]);
    var rows = await fetchAllRows('jerseys', 'manufacturer');
    var counts = {};
    rows.forEach(function(j){
      var m = (j.manufacturer || '').trim();
      if(!m) return;
      counts[m] = (counts[m] || 0) + 1;
    });
    var names = Object.keys(counts).sort(function(a,b){ return counts[b]-counts[a] || a.localeCompare(b); });
    var chips = names.map(function(m){
      return '<a class="chip" href="#/manufacturer/'+encodeURIComponent(m)+'">'+esc(m)+' &middot; '+counts[m]+'</a>';
    }).join('');
    return '<div class="section-head"><h2>Browse by manufacturer</h2></div>' +
      (chips ? '<div class="chip-row">'+chips+'</div>' : '<div class="empty-note">No manufacturers logged yet.</div>');
  }

  // Ranked by points (same tally that already drives the tier chip next
  // to a signed-in user's own name) - no profile pictures, just who's
  // actually contributed, highest first. Reachable only from a user's
  // own page (see viewUserProfile's "Full leaderboard" link), not from
  // the main nav - a flat list of every contributor doesn't need a
  // permanent slot up there.
  async function viewContributors(){
    setCrumbs([{label:'Home', href:'#/'},{label:'Contributors', href:'#/contributors'}]);
    var res = await supabaseClient.from('profiles').select('username, points')
      .eq('is_banned', false).not('username', 'is', null).gt('points', 0)
      .order('points', {ascending:false});
    if(res.error) throw res.error;
    var rows = res.data || [];
    if(!rows.length){
      return '<div class="section-head"><h2>Contributors</h2></div><div class="empty-note">Nobody&rsquo;s had an upload approved yet.</div>';
    }
    var listHtml = rows.map(function(p, i){
      return '<a class="contributor-row" href="#/user/'+encodeURIComponent(p.username)+'">' +
          '<span class="contributor-rank">'+(i+1)+'</span>' +
          '<span class="contributor-name">'+esc(p.username)+'</span>' +
          '<span class="contributor-points">'+pointsChip(p.points)+'</span>' +
        '</a>';
    }).join('');
    return '<div class="section-head"><h2>Contributors</h2><span class="count">'+rows.length+'</span></div>' +
      '<div class="contributor-list">'+listHtml+'</div>';
  }

  async function viewManufacturer(name){
    setCrumbs([{label:'Home', href:'#/'},{label:'Manufacturers', href:'#/manufacturers'},{label:name, href:'#'}]);
    var jerseys = await fetchAllRows('jerseys', '*, jersey_images(*), teams(*, competitions(*, sports(*))), jersey_competitions(competitions(name))', function(q){ return q.eq('manufacturer', name); });
    if(!jerseys.length){
      return '<div class="section-head"><h2>'+esc(name)+'</h2><span class="count">0 jerseys</span></div><div class="empty-note">Nothing matches yet.</div>';
    }
    return '<div class="section-head"><h2>'+esc(name)+'</h2><span class="count">'+jerseys.length+' jersey'+(jerseys.length===1?'':'s')+'</span></div>'+renderGroupedBySport(jerseys);
  }

  // Only cricket sets a format today, so this is effectively cricket-only
  // in practice, but it isn't sport-scoped in the route (same as
  // viewManufacturer) since nothing stops another sport from adopting
  // formats later.
  async function viewFormat(name){
    setCrumbs([{label:'Home', href:'#/'},{label:name, href:'#'}]);
    var jerseys = await fetchAllRows('jerseys', '*, jersey_images(*), teams(*, competitions(*, sports(*))), jersey_competitions(competitions(name))', function(q){ return q.eq('format', name); });
    if(!jerseys.length){
      return '<div class="section-head"><h2>'+esc(name)+'</h2><span class="count">0 jerseys</span></div><div class="empty-note">Nothing matches yet.</div>';
    }
    return '<div class="section-head"><h2>'+esc(name)+'</h2><span class="count">'+jerseys.length+' jersey'+(jerseys.length===1?'':'s')+'</span></div>'+renderGroupedBySport(jerseys);
  }

  // "Home V1"/"Home V2" (a different sponsor/badge era of the same base
  // kit) and "GK"/"GK 1"/"GK 2" all collapse to one family ("Home", "GK")
  // for browsing purposes — clicking any one of them shows every jersey
  // in that family, not just the exact string clicked. Falls back to the
  // original string if stripping the suffix would leave nothing.
  //
  // Same idea for the different words sports/clubs use for what's
  // functionally the same kind of jersey: AFL's "Dreamtime" guernsey,
  // "First Nations", and "Indigenous" are all the same special-edition
  // jersey honouring Indigenous culture; "Clash" (AFL again, and
  // occasionally other sports) is just an away-colours kit worn when the
  // normal one would clash with the opponent's; and the NRL's Cowboys
  // call their ANZAC Day jersey "Defence" rather than "ANZAC" like most
  // other clubs. A team might use a different one of these words each
  // year, so without this clicking into whichever one shows on a given
  // season would miss every other year that used a different word for
  // the same thing. Each jersey still displays its own actual type text
  // everywhere else (jerseyCard etc.) - this only affects the
  // browse/grouping family.
  var TYPE_SYNONYMS = {'first nations':'Indigenous', 'dreamtime':'Indigenous', 'clash':'Away', 'defence':'ANZAC'};
  function baseJerseyType(t){
    var s = String(t || '');
    var stripped = s.replace(/\s+(v\.?\s*\d+|\d+)$/i, '').replace(/\s+-\s+.+$/, '').trim();
    var base = stripped || s;
    return TYPE_SYNONYMS[base.toLowerCase()] || base;
  }

  async function viewTypes(){
    setCrumbs([{label:'Home', href:'#/'},{label:'Types', href:'#/types'}]);
    var rows = await fetchAllRows('jerseys', 'type');
    var counts = {};
    rows.forEach(function(j){
      var t = (j.type || '').trim();
      if(!t) return;
      var base = baseJerseyType(t);
      counts[base] = (counts[base] || 0) + 1;
    });
    var names = Object.keys(counts).sort(function(a,b){ return counts[b]-counts[a] || a.localeCompare(b); });
    var chips = names.map(function(t){
      return '<a class="chip" href="#/type/'+encodeURIComponent(t)+'">'+esc(t)+' &middot; '+counts[t]+'</a>';
    }).join('');
    return '<div class="section-head"><h2>Browse by type</h2></div>' +
      (chips ? '<div class="chip-row">'+chips+'</div>' : '<div class="empty-note">No jersey types logged yet.</div>');
  }

  async function viewType(name, originSportSlug, originCompSlug){
    setCrumbs([{label:'Home', href:'#/'},{label:'Types', href:'#/types'},{label:name, href:'#'}]);
    var targetBase = baseJerseyType(name);
    var allJerseys = await fetchAllRows('jerseys', '*, jersey_images(*), teams(*, competitions(*, sports(*))), jersey_competitions(competitions(name))');
    var jerseys = allJerseys.filter(function(j){ return baseJerseyType(j.type) === targetBase; });
    if(!jerseys.length){
      return '<div class="section-head"><h2>'+esc(targetBase)+'</h2><span class="count">0 jerseys</span></div><div class="empty-note">Nothing matches yet.</div>';
    }
    return '<div class="section-head"><h2>'+esc(targetBase)+'</h2><span class="count">'+jerseys.length+' jersey'+(jerseys.length===1?'':'s')+'</span></div>'+renderGroupedBySport(jerseys, originSportSlug, originCompSlug);
  }

  function viewHelp(){
    setCrumbs([{label:'Home', href:'#/'},{label:'Help', href:'#/help'}]);
    return '<header class="hero" style="border:none;padding:0 0 8px;margin-bottom:0;">' +
        '<h1>Help</h1>' +
        '<p class="sub">How to browse the archive, upload a jersey, and everything else you might want to know.</p>' +
      '</header>' +
      '<div class="help-content">' +

        '<div class="section-head"><h2>Finding a jersey</h2></div>' +
        '<p>Start from <a class="spec-link" href="#/">the homepage</a> and pick a sport, then a competition, then a team &mdash; each page drills down further, and every team page groups its jerseys by season. If you already know what you&rsquo;re after, the search box at the top of every page matches team and season.</p>' +
        '<p>You can also browse straight to a <a class="spec-link" href="#/manufacturers">manufacturer</a> or <a class="spec-link" href="#/types">jersey type</a> to see everything logged for it, across every sport.</p>' +

        '<div class="section-head" style="margin-top:30px;"><h2>Uploading a jersey</h2></div>' +
        '<ol>' +
          '<li>Sign in with your email at the top right &mdash; it&rsquo;s a magic link, no password to remember.</li>' +
          '<li>Go to <a class="spec-link" href="#/upload">Upload</a> and pick the sport, then the competition and team (or use &ldquo;+ Add a new one&hellip;&rdquo; if yours isn&rsquo;t listed yet).</li>' +
          '<li>Fill in the season (a single year like 2024, or a split year like 2024-25 for competitions that span two calendar years &mdash; use a dash, not a slash: 2024-25, not 2024/25) and jersey type. Manufacturer is required too &mdash; pick &ldquo;Unknown&rdquo; if you genuinely can&rsquo;t tell, but most current jerseys are easy to identify, so it&rsquo;s worth a proper look first.</li>' +
          '<li>Attach at least one photo &mdash; front, back, and any other angle all help, and you can label each one.</li>' +
          '<li>Submit. After it&rsquo;s approved, the sport/competition/team/season/manufacturer stay filled in so you can upload the next kit for the same team (say, the away or alternate jersey) without retyping everything &mdash; just swap the photo and jersey type.</li>' +
        '</ol>' +

        '<div class="section-head" style="margin-top:30px;"><h2>Didn&rsquo;t get your sign-in email?</h2></div>' +
        '<p>If you try to sign in and get an error instead of the email arriving &mdash; especially something mentioning a &ldquo;rate limit&rdquo; &mdash; it&rsquo;s not your account, and nothing&rsquo;s wrong on your end. There&rsquo;s a cap on how many sign-in emails the whole site can send out per hour, shared across everyone trying to sign in at the same time, and it&rsquo;s occasionally possible to land right when that cap&rsquo;s been reached. Just wait about an hour and try again &mdash; it&rsquo;ll go through once the next window opens up. If it keeps happening well after that, <a class="spec-link" href="https://thejerseydatabase.com/contact.html" target="_blank" rel="noopener">get in touch</a>.</p>' +

        '<div class="section-head" style="margin-top:30px;"><h2>Uploading training or warm-up kit</h2></div>' +
        '<p>Pick &ldquo;Training&rdquo; as the jersey type &mdash; a sub-field then appears so you can say which one it is (a specific kind like warm up or captain&rsquo;s run, or just a number if it&rsquo;s another plain training top).</p>' +
        '<p>For cricket specifically, also set Format to &ldquo;All Formats&rdquo; rather than Test, ODI, T20, etc. &mdash; training kit isn&rsquo;t tied to any one match format, and picking a specific one (like ODI) narrows the Competition field down to only ODI competitions, which can hide the one you actually want.</p>' +

        '<div class="section-head" style="margin-top:30px;"><h2>A jersey worn in more than one competition</h2></div>' +
        '<p>Some jerseys aren&rsquo;t just worn in one place &mdash; a country&rsquo;s regular kit might also be what they wore at a World Cup, or a club&rsquo;s league kit might also have been worn in a cup competition. Rather than uploading the same photos twice under two different teams, tick &ldquo;Was this jersey also worn in another competition?&rdquo; on the upload form and pick the extra one (or add it if it&rsquo;s not listed &mdash; this is also how to log a jersey worn only in something like a trial match). The jersey still lives under its real team and competition, but now shows up on both competitions&rsquo; pages too, and a small badge naming the extra competition appears on its card wherever it&rsquo;s shown &mdash; so you can tell it apart from a jersey worn only domestically at a glance, not just by opening it.</p>' +
        '<p>This is also why competitions like the FIFA World Cup, Rugby League World Cup, and other major tournaments aren&rsquo;t options in the main Competition field &mdash; they only exist to be tagged on this way, keeping a country&rsquo;s full jersey history together under its real International team instead of splitting it across two pages.</p>' +
        '<p>Already uploaded something that should have this tag? Open the jersey and use &ldquo;Report a problem&rdquo;, or if you&rsquo;re still pending, admins can add it for you from the moderation queue.</p>' +

        '<div class="section-head" style="margin-top:30px;"><h2>Same team, different era</h2></div>' +
        '<p>Some clubs have played under the same name across more than one competition as the sport itself got restructured over time &mdash; the NRL replaced the ARL in 1998, for example, but a club like Newcastle or Penrith existed in both. Rather than filing every era of a club&rsquo;s history under today&rsquo;s competition, each era gets its own team entry in its own (often historical) competition, and the site links them together with an &ldquo;Also see&rdquo; note on the team page.</p>' +
        '<p>If you pick a team on the upload form that has a row in more than one competition, a hint appears under the Team field naming the others &mdash; use it to double-check you&rsquo;ve picked the competition that was actually running the season your jersey is from, rather than defaulting to whichever one is biggest or most familiar today.</p>' +

        '<div class="section-head" style="margin-top:30px;"><h2>What makes a good photo</h2></div>' +
        '<p>We&rsquo;re after the best photo you can find — the main (front) image especially should be clear and in focus, showing the whole jersey with nothing cropped off or blocking the design. A clean promo photo from an online store is ideal, but a good clear photo taken at a game works well too.</p>' +
        '<p>We understand a great photo isn&rsquo;t always out there, especially for older or obscure jerseys — do your best with what you can find. Blurry, cropped, or otherwise low-quality photos may be rejected, or replaced later if someone turns up a better one for the same jersey.</p>' +

        '<div class="section-head" style="margin-top:30px;"><h2>Why isn&rsquo;t my upload showing yet?</h2></div>' +
        '<p>Every submission &mdash; a jersey, an extra photo on an existing jersey, or a team logo &mdash; goes into a moderation queue first, so the archive stays accurate. You can always see your own pending submissions (they&rsquo;re marked &ldquo;Pending&rdquo;); once approved, they go live for everyone and you earn points for the contribution.</p>' +

        '<div class="section-head" style="margin-top:30px;"><h2>Points &amp; tiers</h2></div>' +
        '<p>You earn +1 point for every jersey upload and every team logo that gets approved. Your points total sets your tier, shown next to your name: ' +
          TIERS.map(function(t){ return '<span style="color:'+t.color+';font-weight:700;">'+t.label+'</span> ('+t.min+'+)'; }).join(', ') + '.' +
        '</p>' +

        '<div class="section-head" style="margin-top:30px;"><h2>Upload limits</h2></div>' +
        '<p>To keep things sane for everyone, there&rsquo;s an hourly cap of 100 uploads per account. That&rsquo;s far more than a normal upload session needs &mdash; it only kicks in to stop runaway/accidental spam. If you hit it, just wait a bit and carry on. Each jersey is also capped at 6 photos.</p>' +

        '<div class="section-head" style="margin-top:30px;"><h2>Spotted a mistake?</h2></div>' +
        '<p>Every jersey, team, and competition page has a &ldquo;Report a problem&rdquo; button at the bottom &mdash; use it for anything wrong (wrong season, wrong team, bad photo) and it goes straight to moderation. You can also just <a class="spec-link" href="https://thejerseydatabase.com/contact.html" target="_blank" rel="noopener">get in touch</a> directly.</p>' +

        '<div class="section-head" style="margin-top:30px;"><h2>Don&rsquo;t see your sport?</h2></div>' +
        '<p>The sport list keeps growing &mdash; if yours isn&rsquo;t here yet (Golf, Tennis, F1, Table Tennis, Cycling, Darts, whatever it is), <a class="spec-link" href="https://thejerseydatabase.com/contact.html" target="_blank" rel="noopener">get in touch</a> and it can be added.</p>' +

      '</div>';
  }

  async function viewUpload(){
    setCrumbs([{label:'Home', href:'#/'},{label:'Upload', href:'#/upload'}]);
    if(!currentUser){
      return '<div class="section-head"><h2>Upload a jersey</h2></div>' +
        '<div class="empty-note">Sign in first (top right) &mdash; it just needs an email, no password. Once you click the magic link we send you, come back to this page.</div>';
    }
    if(currentProfile && currentProfile.is_banned){
      return '<div class="section-head"><h2>Upload a jersey</h2></div>' +
        '<div class="empty-note">Your account has been banned from posting. Contact the site owner if you believe this is a mistake.</div>';
    }

    var sportsRes = await supabaseClient.from('sports').select('*').order('sort_order');
    if(sportsRes.error) throw sportsRes.error;
    var sportOptions = (sportsRes.data||[]).map(function(s){ return '<option value="'+s.slug+'">'+esc(s.name)+'</option>'; }).join('');
    // Placeholder lists for the very first render — wireUploadForm's
    // refreshMfrTypeOptions() immediately upgrades these to the
    // sport-scoped, usage-ordered versions once the page mounts.
    var typeOptions = '<option value="">Select a type</option>' +
      CURATED_TYPES.map(function(t){ return '<option value="'+t+'">'+t+'</option>'; }).join('') +
      '<option value="__new__">+ Add a new one…</option>';
    var mfrOptions = '<option value="" disabled selected>Select a manufacturer&hellip;</option>' +
      '<option value="Unknown">Unknown</option>' +
      PRIORITY_MANUFACTURERS.map(function(m){ return '<option value="'+esc(m)+'">'+esc(m)+'</option>'; }).join('') +
      '<option value="__new__">+ Add a new one…</option>';
    var thisYear = new Date().getFullYear();

    return '<div class="section-head"><h2>Upload a jersey</h2></div>' +
      '<p style="font-family:\'Courier Prime\',monospace;font-size:11.5px;color:var(--text-dim2);margin:-10px 0 10px;">* required &mdash; and at least one photo</p>' +
      '<p class="field-hint" style="margin:0 0 22px;">Please use a good quality image &mdash; a clear, full-size photo, not a small thumbnail or a screenshot of one. Blurry or low-resolution photos may be rejected.</p>' +
      '<form id="upload-form" novalidate>' +
        '<div class="upload-grid">' +
          '<div class="field"><label for="f-sport">Sport *</label><select id="f-sport" required>'+sportOptions+'</select></div>' +
          '<div class="field" id="field-format" hidden><label for="f-format">Format * <small>cricket has several</small></label><select id="f-format" required></select></div>' +
          '<div class="field"><label for="f-comp-input">Competition * <small>pick or add a new one</small></label>' +
            '<div class="combo-wrap" id="f-comp-combo-wrap">' +
              '<input type="text" id="f-comp-input" placeholder="e.g. NRL, Premier League" autocomplete="off" required>' +
              '<button type="button" class="combo-clear" id="f-comp-clear" aria-label="Clear competition" tabindex="-1" hidden>&#10005;</button>' +
              '<div class="combo-panel" id="f-comp-panel" hidden></div>' +
            '</div>' +
            '<select id="f-comp-select" class="combo-source"><option value="">Select a competition</option></select>' +
            '<div class="new-value-row" id="f-comp-new-row" hidden>' +
              '<input type="text" id="f-comp-new" placeholder="New competition name">' +
              '<button type="button" class="new-value-cancel" id="f-comp-new-cancel" aria-label="Back to list">&#10005;</button>' +
            '</div></div>' +
          '<div class="field"><label for="f-team-input">Team * <small>any level &mdash; not sure of the competition? just search the team</small></label>' +
            '<div class="combo-wrap" id="f-team-combo-wrap">' +
              '<input type="text" id="f-team-input" placeholder="e.g. Manchester United, Melbourne Storm" autocomplete="off" required>' +
              '<button type="button" class="combo-clear" id="f-team-clear" aria-label="Clear team" tabindex="-1" hidden>&#10005;</button>' +
              '<div class="combo-panel" id="f-team-panel" hidden></div>' +
            '</div>' +
            '<select id="f-team-select" class="combo-source"><option value="">Select a competition first</option></select>' +
            '<div class="new-value-row" id="f-team-new-row" hidden>' +
              '<input type="text" id="f-team-new" placeholder="New team name">' +
              '<button type="button" class="new-value-cancel" id="f-team-new-cancel" aria-label="Back to list">&#10005;</button>' +
            '</div>' +
            '<p class="field-hint is-match" id="f-team-also-see-hint" hidden></p>' +
          '</div>' +
          '<div class="field"><label for="f-season">Season * <small>a single year, or a range for split-year comps</small></label>' +
            '<input type="text" id="f-season" placeholder="e.g. '+thisYear+' or '+thisYear+'-'+String(thisYear+1).slice(-2)+'" required>' +
            '<label class="field-hint" style="display:block;margin-top:6px;cursor:pointer;">' +
              '<input type="checkbox" id="f-season-unknown" style="vertical-align:middle;margin-right:6px;">I\'m not sure of the exact year' +
            '</label>' +
          '</div>' +
          '<div class="field"><label for="f-type-input">Jersey type *</label>' +
            '<div class="combo-wrap" id="f-type-combo-wrap">' +
              '<input type="text" id="f-type-input" placeholder="e.g. Home, Away, Alternate" autocomplete="off" required>' +
              '<button type="button" class="combo-clear" id="f-type-clear" aria-label="Clear jersey type" tabindex="-1" hidden>&#10005;</button>' +
              '<div class="combo-panel" id="f-type-panel" hidden></div>' +
            '</div>' +
            '<select id="f-type-select" class="combo-source">'+typeOptions+'</select>' +
            '<div class="new-value-row" id="f-type-new-row" hidden>' +
              '<input type="text" id="f-type-new" placeholder="New jersey type">' +
              '<button type="button" class="new-value-cancel" id="f-type-new-cancel" aria-label="Back to list">&#10005;</button>' +
            '</div>' +
            // Nested inside the Jersey type field itself (not a sibling
            // grid cell) so revealing it just grows this one box downward
            // instead of pushing every field after it — Manufacturer in
            // particular — into a different grid slot.
            '<div id="f-type-sub-field" class="field" hidden style="margin-top:10px;"><label for="f-type-sub-select">Training type <small>optional &mdash; another training top? pick a number; a specific kind? pick e.g. warm up, captain&rsquo;s run</small></label>' +
              '<select id="f-type-sub-select">' +
                '<option value="">&mdash; Just &ldquo;Training&rdquo; &mdash;</option>' +
                TRAINING_SUBTYPES.map(function(t){ return '<option value="'+t+'">'+t+'</option>'; }).join('') +
                '<option value="__new__">+ Add a new one&hellip;</option>' +
              '</select>' +
              '<div class="new-value-row" id="f-type-sub-new-row" hidden>' +
                '<input type="text" id="f-type-sub-new" placeholder="New training type">' +
                '<button type="button" class="new-value-cancel" id="f-type-sub-new-cancel" aria-label="Back to list">&#10005;</button>' +
              '</div>' +
            '</div>' +
          '</div>' +
          '<div class="field"><label for="f-mfr-input">Manufacturer * <small>don&rsquo;t know it? pick &ldquo;Unknown&rdquo;</small></label>' +
            '<div class="combo-wrap" id="f-mfr-combo-wrap">' +
              '<input type="text" id="f-mfr-input" placeholder="e.g. Nike, Adidas, Puma" autocomplete="off" required>' +
              '<button type="button" class="combo-clear" id="f-mfr-clear" aria-label="Clear manufacturer" tabindex="-1" hidden>&#10005;</button>' +
              '<div class="combo-panel" id="f-mfr-panel" hidden></div>' +
            '</div>' +
            '<select id="f-mfr-select" class="combo-source">'+mfrOptions+'</select>' +
            '<div class="new-value-row" id="f-mfr-new-row" hidden>' +
              '<input type="text" id="f-mfr-new" placeholder="New manufacturer">' +
              '<button type="button" class="new-value-cancel" id="f-mfr-new-cancel" aria-label="Back to list">&#10005;</button>' +
            '</div></div>' +
          '<div class="field field-full"><p class="field-hint is-match" id="f-duplicate-hint" hidden></p></div>' +
          '<div class="field field-full">' +
            '<label style="text-transform:none;letter-spacing:normal;"><input type="checkbox" id="f-extra-comp-toggle" style="width:auto;margin-right:8px;">Was this jersey also worn in another competition? <small>e.g. a World Cup, on top of the competition above</small></label>' +
            '<div id="f-extra-comp-row" style="margin-top:8px;" hidden>' +
              '<select id="f-extra-comp"><option value="">Select a competition</option></select>' +
              '<div class="new-value-row" id="f-extra-comp-new-row" hidden>' +
                '<input type="text" id="f-extra-comp-new" placeholder="New competition name (e.g. Trial Match)">' +
                '<button type="button" class="new-value-cancel" id="f-extra-comp-new-cancel" aria-label="Back to list">&#10005;</button>' +
              '</div>' +
            '</div>' +
          '</div>' +
          '<div class="field field-full" id="field-photos"><label>Photos *</label>' +
            '<div class="dropzone" id="photo-dropzone" tabindex="0" role="button" aria-label="Add photos">' +
              ICON_PHOTO +
              '<p>Drop photos here, or click to choose</p>' +
              '<input type="file" id="f-photos-input" accept="image/*" multiple style="display:none;">' +
            '</div>' +
            '<div class="photo-previews" id="photo-previews"></div>' +
            '<p class="field-error" id="photo-error" hidden>Add at least one photo before submitting.</p>' +
          '</div>' +
          '<div class="field field-full"><label for="f-notes">Additional info <small>optional</small></label><textarea id="f-notes" placeholder="Sponsor changes, special edition, match it was worn in..."></textarea></div>' +
          '<div class="field field-full"><label for="f-credit">Image credit <small>optional</small></label><input type="text" id="f-credit" placeholder="Where the photos are from &mdash; eBay listing, Instagram handle, personal collection, etc."></div>' +
        '</div>' +
        '<div style="margin-top:20px;"><button type="submit" class="btn" id="upload-submit-btn">Add jersey</button></div>' +
      '</form>' +
      '<div id="upload-result"></div>';
  }

  async function ensureCompetition(sportSlug, name){
    // Matched by (sport, name), not slug — several sports now legitimately
    // have a competition simply named "International" (rugby league,
    // football, basketball...), and competitions.slug is a bare primary
    // key with no per-sport scoping, so a slug-only lookup could silently
    // return a DIFFERENT sport's same-named competition (this actually
    // happened: an upload picked as its competition rugby league's
    // "International" but got matched to cricket's, since both slugify
    // differently but a slug-only match found whichever existed first).
    var existing = await supabaseClient.from('competitions').select('*').eq('sport_slug', sportSlug).ilike('name', name).maybeSingle();
    if(existing.error) throw existing.error;
    if(existing.data) return existing.data;
    // Brand new competition — generate a slug that won't collide with a
    // same-named competition that already exists under a different sport.
    var baseSlug = slugify(name);
    var slug = baseSlug;
    var collision = await supabaseClient.from('competitions').select('slug').eq('slug', slug).maybeSingle();
    if(collision.error) throw collision.error;
    if(collision.data) slug = baseSlug + '-' + sportSlug;
    var ins = await supabaseClient.from('competitions').insert({slug:slug, sport_slug:sportSlug, name:name, tier:'more'}).select().single();
    if(ins.error) throw ins.error;
    return ins.data;
  }

  async function ensureTeam(compSlug, name){
    var slug = slugify(name);
    var existing = await supabaseClient.from('teams').select('*').eq('competition_slug', compSlug).eq('slug', slug).maybeSingle();
    if(existing.error) throw existing.error;
    if(existing.data) return existing.data;
    var c = hashColors(name);
    var ins = await supabaseClient.from('teams').insert({
      slug:slug, competition_slug:compSlug, name:name,
      primary_color:c.primary, secondary_color:c.secondary, created_by:currentUser.id
    }).select().single();
    if(ins.error) throw ins.error;
    return ins.data;
  }

  // Shared by the team page's admin panel and the moderation queue: lets an
  // admin reassign which competition a team currently belongs to (a club
  // moved divisions, or was filed under the wrong one at upload time)
  // without touching any of its jersey history — jerseys reference the
  // team by id, not by competition, so moving the team's row is enough.
  function renderCompetitionMoveControl(prefix, entityId, sportSlug, currentCompSlug){
    return '<div class="comp-move-row">' +
        '<select class="comp-move-select" id="'+prefix+'-comp-select" data-sport-slug="'+esc(sportSlug)+'" data-current="'+esc(currentCompSlug)+'"><option>Loading…</option></select>' +
        '<button class="btn btn-secondary" id="'+prefix+'-comp-move-btn" data-entity-id="'+entityId+'" type="button">Move</button>' +
      '</div>' +
      '<div class="comp-move-new" id="'+prefix+'-comp-new" hidden>' +
        '<input type="text" class="comp-move-new-input" id="'+prefix+'-comp-new-name" placeholder="New competition name">' +
        '<select class="comp-move-new-tier" id="'+prefix+'-comp-new-tier">' +
          '<option value="more">More competitions</option>' +
          '<option value="top">Top competitions</option>' +
        '</select>' +
      '</div>' +
      '<p class="field-hint" id="'+prefix+'-comp-move-msg" hidden></p>';
  }
  // table/matchCol let this double up for anything with a competition_slug
  // column, not just a team - a pending competition logo proposal
  // (competition_logo_proposals, matched on its own id) reuses the exact
  // same picker/create-new-competition flow to fix "proposed under the
  // wrong competition" (e.g. an ARL crest submitted under NRL) without
  // needing its own near-duplicate control.
  async function wireCompetitionMoveControl(prefix, onMoved, opts){
    var table = (opts && opts.table) || 'teams';
    var matchCol = (opts && opts.matchCol) || 'id';
    var select = document.getElementById(prefix+'-comp-select');
    var btn = document.getElementById(prefix+'-comp-move-btn');
    var newPanel = document.getElementById(prefix+'-comp-new');
    if(!select || !btn) return;
    var sportSlug = select.dataset.sportSlug, currentCompSlug = select.dataset.current;
    // Excludes tag_only competitions (World Cup etc.) — those aren't a
    // real home for a team, only something a jersey gets tagged onto
    // separately; see the note on competitionsForSport in the upload form.
    var res = await supabaseClient.from('competitions').select('*').eq('sport_slug', sportSlug).eq('tag_only', false).order('name');
    var comps = res.error ? [] : (res.data || []);
    select.innerHTML = comps.map(function(c){
      return '<option value="'+esc(c.slug)+'"'+(c.slug===currentCompSlug?' selected':'')+'>'+esc(c.name)+'</option>';
    }).join('') + '<option value="__new__">+ Create new competition…</option>';
    select.addEventListener('change', function(){ newPanel.hidden = select.value !== '__new__'; });
    btn.addEventListener('click', async function(){
      var msg = document.getElementById(prefix+'-comp-move-msg');
      var newSlug = select.value;
      if(newSlug === '__new__'){
        var nameInput = document.getElementById(prefix+'-comp-new-name');
        var tierSelect = document.getElementById(prefix+'-comp-new-tier');
        var name = nameInput.value.trim();
        if(!name){
          msg.hidden = false; msg.className = 'field-error'; msg.textContent = 'Enter a name for the new competition.';
          return;
        }
        btn.disabled = true; btn.textContent = 'Creating…';
        var compIns = await supabaseClient.from('competitions').insert({slug: slugify(name), sport_slug: sportSlug, name: name, tier: tierSelect.value});
        if(compIns.error){
          btn.disabled = false; btn.textContent = 'Move';
          msg.hidden = false; msg.className = 'field-error'; msg.textContent = 'Error: ' + compIns.error.message;
          return;
        }
        newSlug = slugify(name);
      }
      if(newSlug === currentCompSlug) return;
      btn.disabled = true; btn.textContent = 'Moving…';
      var upd = await supabaseClient.from(table).update({competition_slug: newSlug}).eq(matchCol, btn.dataset.entityId);
      btn.disabled = false; btn.textContent = 'Move';
      if(upd.error){
        msg.hidden = false; msg.className = 'field-error'; msg.textContent = 'Error: ' + upd.error.message;
        return;
      }
      onMoved(newSlug);
    });
  }

  // Fixes a jersey logged against the wrong team (and, since a team
  // belongs to exactly one sport, that also covers "wrong sport" — like
  // a jersey mistakenly filed under cricket instead of football).
  // Sport/Competition/Team cascade the same way the upload form's own
  // pickers do, just scoped to a single existing jersey's team_id.
  function renderJerseyReassignControl(prefix, jerseyId){
    return '<div class="comp-move-row">' +
        '<select class="comp-move-select" id="'+prefix+'-sport-select"><option>Loading…</option></select>' +
      '</div>' +
      '<div class="comp-move-row" style="margin-top:8px;">' +
        '<select class="comp-move-select" id="'+prefix+'-comp-select"><option>Loading…</option></select>' +
      '</div>' +
      '<div class="comp-move-row" style="margin-top:8px;">' +
        '<select class="comp-move-select" id="'+prefix+'-team-select"><option>Loading…</option></select>' +
        '<button class="btn btn-secondary" id="'+prefix+'-reassign-btn" data-jersey-id="'+jerseyId+'" type="button">Reassign</button>' +
      '</div>' +
      '<p class="field-hint" id="'+prefix+'-reassign-msg" hidden></p>';
  }
  async function wireJerseyReassignControl(prefix, currentSportSlug, onReassigned){
    var sportSel = document.getElementById(prefix+'-sport-select');
    var compSel = document.getElementById(prefix+'-comp-select');
    var teamSel = document.getElementById(prefix+'-team-select');
    var btn = document.getElementById(prefix+'-reassign-btn');
    if(!sportSel) return;

    var sportsRes = await supabaseClient.from('sports').select('*').order('sort_order');
    var sports = sportsRes.data || [];
    sportSel.innerHTML = sports.map(function(s){ return '<option value="'+esc(s.slug)+'"'+(s.slug===currentSportSlug?' selected':'')+'>'+esc(s.name)+'</option>'; }).join('');

    async function refreshComps(){
      var r = await supabaseClient.from('competitions').select('*').eq('sport_slug', sportSel.value).eq('tag_only', false).order('name');
      var comps = r.data || [];
      compSel.innerHTML = comps.map(function(c){ return '<option value="'+esc(c.slug)+'">'+esc(c.name)+'</option>'; }).join('');
      await refreshTeams();
    }
    async function refreshTeams(){
      var r = await supabaseClient.from('teams').select('id,name').eq('competition_slug', compSel.value).order('name');
      var teams = r.data || [];
      teamSel.innerHTML = teams.map(function(t){ return '<option value="'+t.id+'">'+esc(t.name)+'</option>'; }).join('');
    }
    sportSel.addEventListener('change', refreshComps);
    compSel.addEventListener('change', refreshTeams);
    await refreshComps();

    btn.addEventListener('click', async function(){
      var msg = document.getElementById(prefix+'-reassign-msg');
      var teamId = teamSel.value;
      if(!teamId){
        msg.hidden = false; msg.className = 'field-error'; msg.textContent = 'Pick a team first.';
        return;
      }
      btn.disabled = true; btn.textContent = 'Reassigning…';
      var upd = await supabaseClient.from('jerseys').update({team_id: teamId}).eq('id', btn.dataset.jerseyId);
      btn.disabled = false; btn.textContent = 'Reassign';
      if(upd.error){
        msg.hidden = false; msg.className = 'field-error'; msg.textContent = 'Error: ' + upd.error.message;
        return;
      }
      if(onReassigned) onReassigned();
    });
  }

  // Moderation queue's single "Edit upload" panel — everything about a
  // pending submission (sport/competition/team cascading the same way the
  // reassign control above does, plus the season/type/manufacturer/
  // format/notes/also-used-in fields) in one form instead of three
  // separate toggles that each opened their own. Moving a whole team to
  // a different competition (as opposed to fixing which team THIS jersey
  // is logged against) is a bigger, team-wide change with its own control
  // already on the team's own page — deliberately not folded in here.
  function renderModEditControl(prefix, j, team, comp, sport, extraCompByJersey, allComps){
    var currentExtra = extraCompByJersey[j.id];
    // Tied to the jersey's sport at render time, same as before this was
    // combined into one form - doesn't re-filter if the sport dropdown
    // below gets changed to something else before saving.
    var sameSportComps = allComps.filter(function(c){ return c.sport_slug === sport.slug && c.slug !== comp.slug; });
    return '<div class="comp-move-row">' +
        '<select class="comp-move-select" id="'+prefix+'-sport-select"><option>Loading…</option></select>' +
      '</div>' +
      '<div class="comp-move-row" style="margin-top:8px;">' +
        '<select class="comp-move-select" id="'+prefix+'-comp-select"><option>Loading…</option></select>' +
      '</div>' +
      '<div class="comp-move-new" id="'+prefix+'-comp-new" hidden>' +
        '<input type="text" class="comp-move-new-input" id="'+prefix+'-comp-new-name" placeholder="New competition name">' +
        '<select class="comp-move-new-tier" id="'+prefix+'-comp-new-tier">' +
          '<option value="more">More competitions</option>' +
          '<option value="top">Top competitions</option>' +
        '</select>' +
      '</div>' +
      '<div class="comp-move-row" style="margin-top:8px;">' +
        '<select class="comp-move-select" id="'+prefix+'-team-select"><option>Loading…</option></select>' +
      '</div>' +
      '<div class="comp-move-new" id="'+prefix+'-team-new" hidden>' +
        '<input type="text" class="comp-move-new-input" id="'+prefix+'-team-new-name" placeholder="New team name">' +
      '</div>' +
      '<div class="comp-move-row" style="margin-top:10px;">' +
        '<input type="text" class="comp-move-new-input" id="'+prefix+'-season" placeholder="Season" value="'+esc(j.season)+'">' +
        '<input type="text" class="comp-move-new-input" id="'+prefix+'-type" placeholder="Jersey type" value="'+esc(j.type)+'">' +
      '</div>' +
      '<div class="comp-move-row" style="margin-top:10px;">' +
        '<input type="text" class="comp-move-new-input" id="'+prefix+'-mfr" placeholder="Manufacturer" value="'+esc(j.manufacturer || '')+'">' +
        '<input type="text" class="comp-move-new-input" id="'+prefix+'-format" placeholder="Format (cricket only)" value="'+esc(j.format || '')+'">' +
      '</div>' +
      '<textarea class="report-textarea" id="'+prefix+'-notes" placeholder="Additional info" style="margin-top:10px;">'+esc(j.notes || '')+'</textarea>' +
      '<input type="text" class="comp-move-new-input" id="'+prefix+'-credit" placeholder="Image credit" style="margin-top:10px;width:100%;" value="'+esc(j.image_credit || '')+'">' +
      '<label class="rate-label" style="margin-top:10px;">Also used in</label>' +
      '<select id="'+prefix+'-extra-comp" style="width:100%;"><option value="">&mdash; None &mdash;</option>' +
        sameSportComps.map(function(c){ return '<option value="'+esc(c.slug)+'"'+(currentExtra && currentExtra.slug===c.slug?' selected':'')+'>'+esc(c.name)+'</option>'; }).join('') +
      '</select>' +
      '<button class="btn btn-secondary" id="'+prefix+'-save-btn" type="button">Save changes</button>' +
      '<p class="field-hint" id="'+prefix+'-msg" hidden></p>';
  }
  async function wireModEditControl(prefix, jerseyId, currentTeamId, currentSportSlug, onSaved){
    var sportSel = document.getElementById(prefix+'-sport-select');
    var compSel = document.getElementById(prefix+'-comp-select');
    var compNewPanel = document.getElementById(prefix+'-comp-new');
    var teamSel = document.getElementById(prefix+'-team-select');
    var teamNewPanel = document.getElementById(prefix+'-team-new');
    var btn = document.getElementById(prefix+'-save-btn');
    if(!sportSel) return;

    var sportsRes = await supabaseClient.from('sports').select('*').order('sort_order');
    var sports = sportsRes.data || [];
    sportSel.innerHTML = sports.map(function(s){ return '<option value="'+esc(s.slug)+'"'+(s.slug===currentSportSlug?' selected':'')+'>'+esc(s.name)+'</option>'; }).join('');

    var currentTeamRes = await supabaseClient.from('teams').select('competition_slug').eq('id', currentTeamId).single();
    var currentCompSlug = currentTeamRes.data ? currentTeamRes.data.competition_slug : null;

    async function refreshComps(){
      var r = await supabaseClient.from('competitions').select('*').eq('sport_slug', sportSel.value).eq('tag_only', false).order('name');
      var comps = r.data || [];
      // Only pre-select the jersey's actual current competition/team while
      // the sport dropdown still matches what it originally was - once a
      // moderator picks a different sport there's no "current" team to
      // default back to.
      var stillOriginalSport = sportSel.value === currentSportSlug;
      compSel.innerHTML = comps.map(function(c){ return '<option value="'+esc(c.slug)+'"'+(stillOriginalSport && c.slug===currentCompSlug?' selected':'')+'>'+esc(c.name)+'</option>'; }).join('')
        + '<option value="__new__">+ Create new competition…</option>';
      await refreshTeams();
    }
    // A brand new competition has no teams yet to pick from, so this swaps
    // the team dropdown for a plain text input in that case - same escape
    // hatch the main upload form already has, just missing here before.
    async function refreshTeams(){
      compNewPanel.hidden = compSel.value !== '__new__';
      if(compSel.value === '__new__'){
        teamSel.hidden = true; teamSel.innerHTML = '';
        teamNewPanel.hidden = false;
        return;
      }
      teamSel.hidden = false; teamNewPanel.hidden = true;
      var r = await supabaseClient.from('teams').select('id,name').eq('competition_slug', compSel.value).order('name');
      var teams = r.data || [];
      teamSel.innerHTML = teams.map(function(t){ return '<option value="'+t.id+'"'+(t.id===currentTeamId?' selected':'')+'>'+esc(t.name)+'</option>'; }).join('');
    }
    sportSel.addEventListener('change', refreshComps);
    compSel.addEventListener('change', refreshTeams);
    await refreshComps();

    btn.addEventListener('click', async function(){
      var msg = document.getElementById(prefix+'-msg');
      var season = document.getElementById(prefix+'-season').value.trim();
      var type = document.getElementById(prefix+'-type').value.trim();
      var manufacturer = document.getElementById(prefix+'-mfr').value.trim();
      var format = document.getElementById(prefix+'-format').value.trim();
      var notes = document.getElementById(prefix+'-notes').value.trim();
      var credit = document.getElementById(prefix+'-credit').value.trim();
      var creatingComp = compSel.value === '__new__';
      var newCompName = creatingComp ? document.getElementById(prefix+'-comp-new-name').value.trim() : '';
      var newTeamName = creatingComp ? document.getElementById(prefix+'-team-new-name').value.trim() : '';
      var teamId = creatingComp ? null : teamSel.value;
      if(!season || !type || (creatingComp ? (!newCompName || !newTeamName) : !teamId)){
        msg.hidden = false; msg.className = 'field-error';
        msg.textContent = creatingComp
          ? 'Season, jersey type, new competition name, and new team name can\'t be blank.'
          : 'Season, jersey type, and team can\'t be blank.';
        return;
      }
      btn.disabled = true; btn.textContent = 'Saving…';
      if(creatingComp){
        try {
          var newComp = await ensureCompetition(sportSel.value, newCompName);
          var newTeam = await ensureTeam(newComp.slug, newTeamName);
          teamId = newTeam.id;
        } catch(e){
          btn.disabled = false; btn.textContent = 'Save changes';
          msg.hidden = false; msg.className = 'field-error'; msg.textContent = 'Error: ' + (e.message || e);
          return;
        }
      }
      var upd = await supabaseClient.from('jerseys').update({
        team_id: teamId, season: season, type: type, manufacturer: manufacturer || null, format: format || null, notes: notes || null, image_credit: credit || null
      }).eq('id', jerseyId);
      if(upd.error){
        btn.disabled = false; btn.textContent = 'Save changes';
        msg.hidden = false; msg.className = 'field-error'; msg.textContent = 'Error: ' + upd.error.message;
        return;
      }
      var extraCompEl = document.getElementById(prefix+'-extra-comp');
      if(extraCompEl){
        var del = await supabaseClient.from('jersey_competitions').delete().eq('jersey_id', jerseyId);
        if(!del.error && extraCompEl.value){
          var ins = await supabaseClient.from('jersey_competitions').insert({jersey_id: jerseyId, competition_slug: extraCompEl.value});
          if(ins.error){
            btn.disabled = false; btn.textContent = 'Save changes';
            msg.hidden = false; msg.className = 'field-error'; msg.textContent = 'Error: ' + ins.error.message;
            return;
          }
        }
      }
      btn.disabled = false; btn.textContent = 'Save changes';
      if(onSaved) onSaved();
    });
  }

  // kind is 'team' or 'competition' — same shape of tables for both
  // (a live *_logos history + a logo_path pointer on the main row).
  function logoTables(kind){
    return kind === 'team'
      ? {history: 'team_logos', main: 'teams', refCol: 'team_id', idCol: 'id'}
      : {history: 'competition_logos', main: 'competitions', refCol: 'competition_slug', idCol: 'slug'};
  }
  async function setLogo(kind, refId, path, yearsUsed, proposedBy, note, proposalId){
    var t = logoTables(kind);
    // never overwrite history — the previous logo just stops being "current"
    var unmark = await supabaseClient.from(t.history).update({is_current:false}).eq(t.refCol, refId).eq('is_current', true);
    if(unmark.error) throw unmark.error;
    var histRow = {storage_path: path, is_current: true};
    if(yearsUsed) histRow.years_used = yearsUsed;
    if(proposedBy) histRow.proposed_by = proposedBy;
    if(note) histRow.note = note;
    if(proposalId) histRow.proposal_id = proposalId;
    histRow[t.refCol] = refId;
    var histIns = await supabaseClient.from(t.history).insert(histRow);
    if(histIns.error) throw histIns.error;
    var mainUpd = await supabaseClient.from(t.main).update({logo_path: path}).eq(t.idCol, refId);
    if(mainUpd.error) throw mainUpd.error;
  }
  // For a proposal submitted with "Make this the current logo" unticked -
  // a backdated/one-off logo (a past-years special edition, say) that
  // should sit in history without touching whatever's actually live now.
  async function addLogoToHistory(kind, refId, path, yearsUsed, proposedBy, note, proposalId){
    var t = logoTables(kind);
    var histRow = {storage_path: path, is_current: false};
    if(yearsUsed) histRow.years_used = yearsUsed;
    if(proposedBy) histRow.proposed_by = proposedBy;
    if(note) histRow.note = note;
    if(proposalId) histRow.proposal_id = proposalId;
    histRow[t.refCol] = refId;
    var histIns = await supabaseClient.from(t.history).insert(histRow);
    if(histIns.error) throw histIns.error;
  }
  // Restores an EXISTING history row as current (the "Make current" button
  // in Logo History) - deliberately not setLogo(), which always inserts a
  // brand new row for a newly-uploaded image. Reusing setLogo() here would
  // leave the original row behind AND add a second row for the same image,
  // showing the same logo twice.
  async function restoreLogo(kind, refId, logoId){
    var t = logoTables(kind);
    var unmark = await supabaseClient.from(t.history).update({is_current:false}).eq(t.refCol, refId).eq('is_current', true);
    if(unmark.error) throw unmark.error;
    var row = await supabaseClient.from(t.history).update({is_current:true}).eq('id', logoId).select().single();
    if(row.error) throw row.error;
    var mainUpd = await supabaseClient.from(t.main).update({logo_path: row.data.storage_path}).eq(t.idCol, refId);
    if(mainUpd.error) throw mainUpd.error;
  }
  // Deletes a non-current logo history entry (e.g. a duplicate row, like
  // the ones restoreLogo's predecessor bug could leave behind). Only
  // removes the actual file from storage if no other row for this
  // team/competition still points at the same path - a duplicate shares
  // its storage_path with the row it duplicated, and deleting the file
  // out from under that still-live row would break its image.
  async function deleteLogoHistoryEntry(kind, refId, logoId, storagePath){
    var t = logoTables(kind);
    var del = await supabaseClient.from(t.history).delete().eq('id', logoId);
    if(del.error) throw del.error;
    var stillUsed = await supabaseClient.from(t.history).select('id', {count:'exact', head:true}).eq(t.refCol, refId).eq('storage_path', storagePath);
    if(!stillUsed.error && !stillUsed.count){
      await supabaseClient.storage.from('team-logos').remove([storagePath]);
    }
  }

  async function viewModerate(){
    setCrumbs([{label:'Home', href:'#/'},{label:'Moderate', href:'#/moderate'}]);
    if(!currentUser || !currentProfile || !currentProfile.is_admin){
      return '<div class="empty-note">Not authorized.</div>';
    }
    await refreshAuthUI(); // keeps the topbar count in sync even after changes made outside the app (e.g. deleting rows directly in Supabase)

    var jRes = await supabaseClient.from('jerseys')
      .select('*, jersey_images(*), teams(id, name, competition_slug, competitions(slug, name, sport_slug, sports(slug, name)))')
      .eq('status', 'pending').order('created_at');
    if(jRes.error) throw jRes.error;
    var pendingJerseys = jRes.data || [];

    // Rejecting a jersey already strips its photos (see the reject
    // handler below) - what's left is just the bare row, kept around so
    // the uploader can see why on their own copy and so a moderator
    // doesn't lose the paper trail immediately. It still shows up
    // everywhere an admin's own view isn't filtered to "approved" only
    // (e.g. "Recently added" used to leak these - now fixed by filtering
    // there instead), so a review list here lets rejections actually get
    // cleared out once they've been seen, rather than just accumulating.
    var rejRes = await supabaseClient.from('jerseys')
      .select('id, season, type, rejection_reason, created_at, teams(name, competitions(name, sports(name)))')
      .eq('status', 'rejected').order('created_at', {ascending:false});
    if(rejRes.error) throw rejRes.error;
    var rejectedJerseys = rejRes.data || [];

    // Extra-competition tag per pending jersey (e.g. "Also used in: Rugby
    // League World Cup") — shown up front on the card, not hidden behind
    // a click, since it's easy to lose track of what was tagged at
    // upload time otherwise. All competitions fetched once so each
    // card's edit dropdown can be built synchronously, no per-card fetch.
    var extraCompByJersey = {};
    if(pendingJerseys.length){
      var jerseyIds = pendingJerseys.map(function(j){ return j.id; });
      var tagRes = await supabaseClient.from('jersey_competitions').select('jersey_id, competitions(slug, name)').in('jersey_id', jerseyIds);
      (tagRes.data || []).forEach(function(r){ extraCompByJersey[r.jersey_id] = r.competitions; });
    }

    // Same team+season+type(+format) check checkDuplicateJersey() runs at
    // upload time, but run here against every pending jersey up front so
    // moderators see it without having to re-check each one by hand - a
    // duplicate is still only a hint (not auto-rejected), since a real
    // alternate/reprint of the exact same kit is rare but does happen.
    var dupInfoByJersey = {};
    if(pendingJerseys.length){
      var dupTeamIds = pendingJerseys.map(function(j){ return j.team_id; }).filter(function(v, i, a){ return a.indexOf(v) === i; });
      var dupRes = await supabaseClient.from('jerseys')
        .select('id, team_id, season, type, format, status')
        .in('team_id', dupTeamIds).neq('status', 'rejected');
      var bySig = {};
      (dupRes.data || []).forEach(function(r){
        var sig = r.team_id + '\u0001' + r.season + '\u0001' + r.type + '\u0001' + (r.format || '');
        if(!bySig[sig]) bySig[sig] = [];
        bySig[sig].push(r);
      });
      pendingJerseys.forEach(function(j){
        var sig = j.team_id + '\u0001' + j.season + '\u0001' + j.type + '\u0001' + (j.format || '');
        var matches = (bySig[sig] || []).filter(function(r){ return r.id !== j.id; });
        if(matches.length) dupInfoByJersey[j.id] = matches.filter(function(r){ return r.status === 'approved'; })[0] || matches[0];
      });
    }
    // Message count per pending jersey (see jerseyMessagesThreadHtml /
    // the jersey page's own thread) - a jersey a moderator left a
    // question on stays pending (and so keeps showing up here) until
    // it's resolved, so this is the hint that it's not a fresh
    // submission but one already mid-conversation.
    var msgCountByJersey = {};
    if(pendingJerseys.length){
      var msgCountRes = await supabaseClient.from('jersey_messages').select('jersey_id').in('jersey_id', pendingJerseys.map(function(j){ return j.id; }));
      (msgCountRes.data || []).forEach(function(m){ msgCountByJersey[m.jersey_id] = (msgCountByJersey[m.jersey_id] || 0) + 1; });
    }
    var allCompsRes = await supabaseClient.from('competitions').select('slug, sport_slug, name').order('tier', {ascending:false}).order('name');
    var allComps = allCompsRes.data || [];

    var pendingPhotos = [];
    var photoRes = await supabaseClient.from('jersey_images')
      .select('*, jerseys(id, season, type, teams(name))')
      .eq('status', 'pending').order('id');
    if(!photoRes.error) pendingPhotos = photoRes.data || [];

    var openReports = [];
    var reportRes = await supabaseClient.from('reports').select('*').eq('status', 'open').order('created_at');
    if(!reportRes.error) openReports = reportRes.data || [];

    var pendingLogos = [];
    var logoRes = await supabaseClient.from('team_logo_proposals').select('*, teams(name)').eq('status', 'pending').order('created_at');
    if(!logoRes.error) pendingLogos = logoRes.data || [];

    var pendingCompLogos = [];
    var compLogoRes = await supabaseClient.from('competition_logo_proposals').select('*, competitions(name, sport_slug)').eq('status', 'pending').order('created_at');
    if(!compLogoRes.error) pendingCompLogos = compLogoRes.data || [];

    var uploaderIds = pendingJerseys.map(function(j){ return j.uploaded_by; })
      .concat(pendingPhotos.map(function(img){ return img.uploaded_by; }))
      .concat(openReports.map(function(r){ return r.reported_by; }))
      .concat(pendingLogos.map(function(l){ return l.proposed_by; }))
      .concat(pendingCompLogos.map(function(l){ return l.proposed_by; }))
      .filter(Boolean);
    var uploaderNames = {};
    if(uploaderIds.length){
      var profRes = await supabaseClient.from('profiles').select('id,username').in('id', uploaderIds);
      (profRes.data || []).forEach(function(p){ uploaderNames[p.id] = p.username; });
    }

    // Search-and-toggle rather than a full user list — sites like this
    // can end up with a lot of signed-up accounts, and this only ever
    // needs to find the one or two people being promoted/demoted.
    // Doesn't show for the empty-queue early return below on its own —
    // it's appended to both return paths so it's always reachable.
    // Owner-only: who can grant/revoke moderator access is a decision
    // that stays with the account that runs the site, not every
    // moderator — enforced here (hides the panel) and again server-side
    // (the profiles UPDATE policy/trigger reject a non-owner's attempt
    // regardless of what the UI shows).
    var moderatorsPanelHtml = currentProfile.is_owner ? (
      '<section class="block" id="mod-section-moderators"><div class="section-head"><h2>Moderators</h2></div>' +
      '<div class="filter-row"><input type="text" id="mod-user-search" placeholder="Search by username&hellip;"><button class="btn btn-secondary" id="mod-user-search-btn" type="button">Search</button></div>' +
      '<div id="mod-user-results"></div>' +
    '</section>') : '';

    // Any admin can ban a rule-breaker (day-to-day moderation, same tier
    // as approving/rejecting jerseys) — separate from the Moderators
    // panel above, which is owner-only because granting moderator
    // access itself is a higher-trust decision. Registered count comes
    // free from the same query style used for the pending-queue badges.
    var totalUsersRes = await supabaseClient.from('profiles').select('id', {count:'exact', head:true});
    var usersPanelHtml =
      '<section class="block" id="mod-section-users"><div class="section-head"><h2>Users</h2><span class="count">'+(totalUsersRes.count || 0)+' registered</span></div>' +
      '<div class="filter-row"><input type="text" id="ban-user-search" placeholder="Search by username&hellip;"><button class="btn btn-secondary" id="ban-user-search-btn" type="button">Search</button></div>' +
      '<div id="ban-user-results"></div>' +
    '</section>';

    var rejectedCards = rejectedJerseys.map(function(j){
      var team = j.teams, comp = team ? team.competitions : null, sport = comp ? comp.sports : null;
      return '<div class="mod-card">' +
        '<div class="mod-info">' +
          '<strong>'+j.season+' '+esc(team ? team.name : 'unknown team')+' '+esc(j.type)+'</strong>' +
          (comp && sport ? '<span>'+esc(comp.name)+' &middot; '+esc(sport.name)+'</span>' : '') +
          '<span>Rejected '+fmtDate(j.created_at)+(j.rejection_reason ? ' &mdash; '+esc(j.rejection_reason) : ' &mdash; no reason given')+'</span>' +
        '</div>' +
        '<div class="mod-actions">' +
          '<button class="btn btn-reject" data-type="rejected-jersey" data-action="delete" data-id="'+j.id+'" type="button">Delete</button>' +
        '</div>' +
      '</div>';
    }).join('');
    // Appended to both return paths below, same as usersPanelHtml/
    // moderatorsPanelHtml - clearing out old rejections shouldn't need
    // something else to also be pending first.
    var rejectedSectionHtml = rejectedJerseys.length
      ? '<section class="block" id="mod-section-rejected"><div class="section-head">' +
          '<div><h2 style="display:inline;">Rejected jerseys</h2> <span class="count">'+rejectedJerseys.length+'</span></div>' +
          '<button class="btn btn-secondary" id="delete-all-rejected-btn" type="button">Delete all</button>' +
        '</div>' +
          '<div class="mod-list">'+rejectedCards+'</div>' +
        '</section>'
      : '';

    if(!pendingJerseys.length && !pendingPhotos.length && !openReports.length && !pendingLogos.length && !pendingCompLogos.length && !rejectedJerseys.length){
      return '<div class="section-head"><h2>Moderation queue</h2></div><div class="empty-note">Nothing waiting for review.</div>' + rejectedSectionHtml + usersPanelHtml + moderatorsPanelHtml;
    }

    var jerseyCards = pendingJerseys.map(function(j){
      var team = j.teams, comp = team.competitions, sport = comp.sports;
      var uploader = uploaderNames[j.uploaded_by] || 'unknown';
      var images = sortImagesForDisplay(j.jersey_images);
      var thumb = images.length
        ? '<img class="lightbox-trigger" src="'+esc(publicImageUrl(images[0].storage_path))+'" alt="" loading="lazy">'
        : '<div class="thumb-placeholder" style="background:var(--surface-2)"><span>No photo</span></div>';
      // All submitted photos, not just the first — admin needs to check
      // every one for wrong/bad images before approving, not just the
      // thumbnail. The label dropdown lets a mislabeled front/back get
      // fixed right here, which also fixes which one shows as the main
      // image (that's always whichever one is labeled "Front"). The
      // delete button lets a bad photo be dropped from an otherwise-good
      // submission instead of rejecting the whole jersey — only shows
      // once there's more than one photo, so there's never a way to
      // delete down to zero.
      // Crop always shows, even for a single pending photo (the common
      // case) — label/delete stay gated to images.length > 1 as before.
      var allPhotosHtml = images.length
        ? '<div class="logo-history-grid lightbox-group" style="margin-top:8px;">' + images.map(function(img){
            return '<div class="logo-history-item"><img class="lightbox-trigger" src="'+esc(publicImageUrl(img.storage_path))+'" alt="" loading="lazy">' +
              (images.length > 1 ? (
                '<select class="photo-label-select" data-image-id="'+img.id+'">' +
                  ['Front','Back','Other'].map(function(l){ return '<option value="'+l+'"'+(img.label===l?' selected':'')+'>'+l+'</option>'; }).join('') +
                '</select>'
              ) : '') +
              '<button type="button" class="photo-crop-btn" data-path="'+esc(img.storage_path)+'" data-image-id="'+img.id+'">Crop</button>' +
              (images.length > 1 ? '<button type="button" class="photo-delete-btn" data-image-id="'+img.id+'" title="Delete this photo">&#10005;</button>' : '') +
            '</div>';
          }).join('') + '</div>'
        : '';
      var editId = 'mod-edit-'+j.id;
      var rejectId = 'mod-reject-'+j.id;
      var dup = dupInfoByJersey[j.id];
      var dupHtml = dup
        ? '<div class="dup-warning">&#9888; Possible duplicate &mdash; this team already has a<a href="#/jersey/'+dup.id+'" target="_blank" rel="noopener">'+(dup.status === 'approved' ? ' approved' : ' pending')+' '+esc(j.season)+' '+esc(j.type)+'</a> jersey logged.</div>'
        : '';
      return '<div class="mod-card">' +
        dupHtml +
        '<div class="jersey-thumb">'+thumb+'</div>' +
        '<div class="mod-info">' +
          '<strong>'+j.season+' '+esc(team.name)+' '+esc(j.type)+'</strong>' +
          '<span>'+esc(comp.name)+' · '+esc(sport.name)+' · by '+esc(uploader)+'</span>' +
          '<span>Manufacturer: '+esc(j.manufacturer || 'Unlisted')+'</span>' +
          (j.format ? '<span>Format: '+esc(j.format)+'</span>' : '') +
          (j.notes ? '<span>Notes: '+esc(j.notes)+'</span>' : '') +
          (j.image_credit ? '<span>Image credit: '+esc(j.image_credit)+'</span>' : '') +
          (extraCompByJersey[j.id] ? '<span>Also used in: '+esc(extraCompByJersey[j.id].name)+'</span>' : '') +
          allPhotosHtml +
          (msgCountByJersey[j.id] ? '<a class="chip" href="#/jersey/'+j.id+'" target="_blank" rel="noopener">&#128172; '+msgCountByJersey[j.id]+' message'+(msgCountByJersey[j.id]===1?'':'s')+'</a>' : '') +
          '<button class="chip mod-edit-toggle" data-target="'+editId+'" type="button">Edit upload</button>' +
          '<div class="comp-move-panel" id="'+editId+'" hidden style="max-width:420px;" data-jersey-id="'+j.id+'" data-team-id="'+team.id+'" data-sport-slug="'+esc(sport.slug)+'">' +
            renderModEditControl(editId, j, team, comp, sport, extraCompByJersey, allComps) +
          '</div>' +
        '</div>' +
        '<div class="mod-actions">' +
          // Lets a moderator reach the jersey's own page - and its
          // Messages box - without approving or rejecting first, e.g.
          // to ask for a better photo while leaving it pending. Nothing
          // here linked to the jersey itself before (only a duplicate
          // warning or an already-existing message thread happened to),
          // so there was no way to start that conversation from the
          // queue at all.
          '<a class="btn btn-secondary" href="#/jersey/'+j.id+'" target="_blank" rel="noopener" style="text-decoration:none;">View / message</a>' +
          '<button class="btn" data-type="jersey" data-action="approve" data-id="'+j.id+'" type="button">Approve</button>' +
          '<button class="btn btn-reject mod-reject-toggle" data-target="'+rejectId+'" type="button">Reject</button>' +
        '</div>' +
        '<div class="comp-move-panel" id="'+rejectId+'" hidden style="flex-basis:100%;max-width:none;">' +
          '<textarea class="report-textarea" id="reject-reason-'+j.id+'" placeholder="Why is this being rejected? Shown to the uploader on their submission."></textarea>' +
          '<button class="btn btn-reject" data-confirm-reject="'+j.id+'" type="button">Confirm reject</button>' +
          '<p class="field-hint" id="reject-msg-'+j.id+'" hidden></p>' +
        '</div>' +
      '</div>';
    }).join('');

    var photoCards = pendingPhotos.map(function(img){
      var j = img.jerseys, team = j ? j.teams : null;
      var uploader = uploaderNames[img.uploaded_by] || 'unknown';
      return '<div class="mod-card">' +
        '<div class="jersey-thumb"><img class="lightbox-trigger" src="'+esc(publicImageUrl(img.storage_path))+'" alt="" loading="lazy"></div>' +
        '<div class="mod-info">' +
          '<strong>'+esc(img.label)+' photo for '+(j ? j.season+' '+esc(team.name)+' '+esc(j.type) : 'a jersey')+'</strong>' +
          '<span>proposed by '+esc(uploader)+'</span>' +
        '</div>' +
        '<div class="mod-actions">' +
          (j ? '<a class="btn btn-secondary" href="#/jersey/'+j.id+'" target="_blank" style="text-decoration:none;">View jersey</a>' : '') +
          '<button type="button" class="photo-crop-btn" data-path="'+esc(img.storage_path)+'" data-image-id="'+img.id+'">Crop</button>' +
          '<button class="btn" data-type="photo" data-action="approve" data-id="'+img.id+'" type="button">Approve</button>' +
          '<button class="btn btn-reject" data-type="photo" data-action="reject" data-id="'+img.id+'" data-path="'+esc(img.storage_path)+'" type="button">Reject</button>' +
        '</div>' +
      '</div>';
    }).join('');

    function reportLink(r){
      if(r.page_type === 'jersey') return '#/jersey/' + r.page_ref;
      if(r.page_type === 'team') return null; // team pages need sport+comp context we don't have here
      if(r.page_type === 'competition') return null;
      return null;
    }
    var reportCards = openReports.map(function(r){
      var reporter = uploaderNames[r.reported_by] || (r.reported_by ? 'unknown' : 'anonymous');
      var link = reportLink(r);
      var thumb = r.attachment_path
        ? '<div class="jersey-thumb"><img class="lightbox-trigger" src="'+esc(toCdnUrl(supabaseClient.storage.from('report-attachments').getPublicUrl(r.attachment_path).data.publicUrl))+'" alt="" loading="lazy"></div>'
        : '';
      var useAsLogoBtn = (r.attachment_path && r.page_type === 'team')
        ? '<button class="btn" data-type="report-logo" data-action="use" data-id="'+r.id+'" data-team-id="'+esc(r.page_ref)+'" data-path="'+esc(r.attachment_path)+'" data-reported-by="'+esc(r.reported_by || '')+'" type="button">Use as team logo</button>'
        : '';
      return '<div class="mod-card">' + thumb +
        '<div class="mod-info">' +
          '<strong>'+esc(r.page_type)+': '+esc(r.page_label || r.page_ref)+'</strong>' +
          '<span>'+esc(r.message)+'</span>' +
          '<span>reported by '+esc(reporter)+' · '+fmtDate(r.created_at)+'</span>' +
        '</div>' +
        '<div class="mod-actions">' +
          (link ? '<a class="btn btn-secondary" href="'+link+'" target="_blank" style="text-decoration:none;">View</a>' : '') +
          useAsLogoBtn +
          '<button class="btn" data-type="report" data-action="resolve" data-id="'+r.id+'" type="button">Mark resolved</button>' +
        '</div>' +
      '</div>';
    }).join('');

    var logoCards = pendingLogos.map(function(l){
      var proposer = uploaderNames[l.proposed_by] || 'unknown';
      var willReplace = l.make_current !== false;
      // Each proposal's own "make current" checkbox only reflects what
      // that proposer picked, with no awareness of any other pending
      // proposal for the same team - two can easily both say "will
      // replace the current logo" at once. This lets the admin override
      // it per-submission before approving, rather than only being able
      // to control the end result via approval order.
      var makeCurrentId = 'mod-make-current-logo-'+l.id;
      return '<div class="mod-card">' +
        '<div class="jersey-thumb"><img class="lightbox-trigger" src="'+esc(publicLogoUrl(l.storage_path))+'" alt="" loading="lazy"></div>' +
        '<div class="mod-info">' +
          '<strong>Logo for '+(l.teams ? esc(l.teams.name) : 'a team')+'</strong>' +
          '<span>proposed by '+esc(proposer)+'</span>' +
          (l.years_used ? '<span>Years used: '+esc(l.years_used)+'</span>' : '') +
          (l.note ? '<span>Note: '+esc(l.note)+'</span>' : '') +
          '<label class="field-hint" style="display:block;cursor:pointer;"><input type="checkbox" id="'+makeCurrentId+'" '+(willReplace ? 'checked' : '')+' style="vertical-align:middle;margin-right:6px;">Make this the current logo</label>' +
        '</div>' +
        '<div class="mod-actions">' +
          '<a class="btn btn-secondary" href="#/logo-proposal/team/'+l.id+'" target="_blank" rel="noopener" style="text-decoration:none;">View / message</a>' +
          '<button class="btn" data-type="logo" data-action="approve" data-id="'+l.id+'" data-team-id="'+l.team_id+'" data-path="'+esc(l.storage_path)+'" data-years="'+esc(l.years_used || '')+'" data-note="'+esc(l.note || '')+'" data-make-current-id="'+makeCurrentId+'" data-proposed-by="'+esc(l.proposed_by || '')+'" type="button">Approve</button>' +
          '<button class="btn btn-reject" data-type="logo" data-action="reject" data-id="'+l.id+'" data-path="'+esc(l.storage_path)+'" type="button">Reject</button>' +
        '</div>' +
      '</div>';
    }).join('');

    var compLogoCards = pendingCompLogos.map(function(l){
      var proposer = uploaderNames[l.proposed_by] || 'unknown';
      var willReplace = l.make_current !== false;
      var makeCurrentId = 'mod-make-current-complogo-'+l.id;
      var moveId = 'mod-complogo-move-'+l.id;
      var sportSlug = l.competitions ? l.competitions.sport_slug : '';
      return '<div class="mod-card">' +
        '<div class="jersey-thumb"><img class="lightbox-trigger" src="'+esc(publicLogoUrl(l.storage_path))+'" alt="" loading="lazy"></div>' +
        '<div class="mod-info">' +
          '<strong>Logo for '+(l.competitions ? esc(l.competitions.name) : 'a competition')+'</strong>' +
          '<span>proposed by '+esc(proposer)+'</span>' +
          (l.years_used ? '<span>Years used: '+esc(l.years_used)+'</span>' : '') +
          (l.note ? '<span>Note: '+esc(l.note)+'</span>' : '') +
          '<label class="field-hint" style="display:block;cursor:pointer;"><input type="checkbox" id="'+makeCurrentId+'" '+(willReplace ? 'checked' : '')+' style="vertical-align:middle;margin-right:6px;">Make this the current logo</label>' +
          '<button class="chip mod-complogo-move-toggle" data-target="'+moveId+'" type="button">Change competition</button>' +
          '<div class="comp-move-panel" id="'+moveId+'" hidden>' +
            renderCompetitionMoveControl(moveId, l.id, sportSlug, l.competition_slug) +
          '</div>' +
        '</div>' +
        '<div class="mod-actions">' +
          '<a class="btn btn-secondary" href="#/logo-proposal/competition/'+l.id+'" target="_blank" rel="noopener" style="text-decoration:none;">View / message</a>' +
          '<button class="btn" data-type="comp-logo" data-action="approve" data-id="'+l.id+'" data-comp-slug="'+esc(l.competition_slug)+'" data-path="'+esc(l.storage_path)+'" data-years="'+esc(l.years_used || '')+'" data-note="'+esc(l.note || '')+'" data-make-current-id="'+makeCurrentId+'" data-proposed-by="'+esc(l.proposed_by || '')+'" type="button">Approve</button>' +
          '<button class="btn btn-reject" data-type="comp-logo" data-action="reject" data-id="'+l.id+'" data-path="'+esc(l.storage_path)+'" type="button">Reject</button>' +
        '</div>' +
      '</div>';
    }).join('');

    // Jump-to-section nav - reuses the same .anchor-nav-btn/scrollIntoView
    // mechanism as a sport gallery's own jump nav (see renderGroupedBySport),
    // so there's no new wiring, just section ids to scroll to. Rejected
    // jerseys only gets a chip when there's actually a section to jump to
    // (it's omitted from the DOM entirely when empty); Moderators is
    // owner-only, same gating as the panel itself.
    var modAnchorNavHtml = '<div class="anchor-nav">' +
        '<button class="chip anchor-nav-btn" type="button" data-scroll-target="mod-section-jerseys">New jerseys ('+pendingJerseys.length+')</button>' +
        '<button class="chip anchor-nav-btn" type="button" data-scroll-target="mod-section-photos">Proposed photos ('+pendingPhotos.length+')</button>' +
        '<button class="chip anchor-nav-btn" type="button" data-scroll-target="mod-section-team-logos">Team logos ('+pendingLogos.length+')</button>' +
        '<button class="chip anchor-nav-btn" type="button" data-scroll-target="mod-section-comp-logos">Competition logos ('+pendingCompLogos.length+')</button>' +
        '<button class="chip anchor-nav-btn" type="button" data-scroll-target="mod-section-reports">Reports ('+openReports.length+')</button>' +
        (rejectedJerseys.length ? '<button class="chip anchor-nav-btn" type="button" data-scroll-target="mod-section-rejected">Rejected jerseys ('+rejectedJerseys.length+')</button>' : '') +
        '<button class="chip anchor-nav-btn" type="button" data-scroll-target="mod-section-users">Users</button>' +
        (currentProfile.is_owner ? '<button class="chip anchor-nav-btn" type="button" data-scroll-target="mod-section-moderators">Moderators</button>' : '') +
      '</div>';

    return '<div class="section-head"><h2>Moderation queue</h2></div>' +
      modAnchorNavHtml +
      '<section class="block" id="mod-section-jerseys"><div class="section-head"><h2>New jerseys</h2><span class="count">'+pendingJerseys.length+' pending</span></div>' +
        (jerseyCards ? '<div class="mod-list">'+jerseyCards+'</div>' : '<div class="empty-note">None waiting.</div>') +
      '</section>' +
      '<section class="block" id="mod-section-photos"><div class="section-head"><h2>Proposed photos</h2><span class="count">'+pendingPhotos.length+' pending</span></div>' +
        (photoCards ? '<div class="mod-list">'+photoCards+'</div>' : '<div class="empty-note">None waiting.</div>') +
      '</section>' +
      '<section class="block" id="mod-section-team-logos"><div class="section-head"><h2>Team logo proposals</h2><span class="count">'+pendingLogos.length+' pending</span></div>' +
        (logoCards ? '<div class="mod-list">'+logoCards+'</div>' : '<div class="empty-note">None waiting.</div>') +
      '</section>' +
      '<section class="block" id="mod-section-comp-logos"><div class="section-head"><h2>Competition logo proposals</h2><span class="count">'+pendingCompLogos.length+' pending</span></div>' +
        (compLogoCards ? '<div class="mod-list">'+compLogoCards+'</div>' : '<div class="empty-note">None waiting.</div>') +
      '</section>' +
      '<section class="block" id="mod-section-reports"><div class="section-head"><h2>Reports</h2><span class="count">'+openReports.length+' open</span></div>' +
        (reportCards ? '<div class="mod-list">'+reportCards+'</div>' : '<div class="empty-note">None open.</div>') +
      '</section>' +
      rejectedSectionHtml +
      usersPanelHtml + moderatorsPanelHtml;
  }

  // 50 jerseys a page — a collector with hundreds of approved uploads
  // (the whole point of a profile page like this) would otherwise dump
  // every single one into one enormous grid. Not a heavily-used page,
  // so simple Previous/Next beats a full numbered pager.
  var USER_UPLOADS_PAGE_SIZE = 30;
  async function viewUserProfile(username, pageParam){
    var page = Math.max(1, parseInt(pageParam, 10) || 1);
    setCrumbs([{label:'Home', href:'#/'},{label:username, href:'#'}]);
    var profRes = await supabaseClient.from('profiles').select('*').eq('username', username).maybeSingle();
    if(profRes.error) throw profRes.error;
    if(!profRes.data) return '<div class="empty-note">No user found with that username.</div>';
    var profile = profRes.data;

    var countRes = await supabaseClient.from('jerseys').select('id', {count:'exact', head:true})
      .eq('uploaded_by', profile.id).eq('status', 'approved');
    var totalJerseys = countRes.count || 0;
    var totalPages = Math.max(1, Math.ceil(totalJerseys / USER_UPLOADS_PAGE_SIZE));
    if(page > totalPages) page = totalPages;
    var from = (page - 1) * USER_UPLOADS_PAGE_SIZE;

    var jRes = await supabaseClient.from('jerseys')
      .select('*, jersey_images(*), teams(name, slug, primary_color, secondary_color, competition_slug)')
      .eq('uploaded_by', profile.id).eq('status', 'approved').order('created_at', {ascending:false})
      .range(from, from + USER_UPLOADS_PAGE_SIZE - 1);
    if(jRes.error) throw jRes.error;
    var jerseys = jRes.data || [];
    var cards = jerseys.map(function(j){ return jerseyCard(j, j.teams, {showTeam:true}); }).join('');

    var pagerHtml = totalPages > 1
      ? '<div style="display:flex;justify-content:center;align-items:center;gap:14px;margin-top:22px;">' +
          (page > 1 ? '<a class="btn btn-secondary" href="#/user/'+encodeURIComponent(username)+'/'+(page-1)+'">&larr; Previous</a>' : '') +
          '<span class="field-hint">Page '+page+' of '+totalPages+'</span>' +
          (page < totalPages ? '<a class="btn btn-secondary" href="#/user/'+encodeURIComponent(username)+'/'+(page+1)+'">Next &rarr;</a>' : '') +
        '</div>'
      : '';

    // Contributed logos aren't part of the paginated jersey grid (a
    // separate, usually much smaller list) — shown once on page 1 only,
    // rather than repeating identically on every page.
    var logoSectionHtml = '';
    if(page === 1){
      var teamLogoRes = await supabaseClient.from('team_logo_proposals')
        .select('*, teams(name, slug, competition_slug, competitions!inner(sport_slug))')
        .eq('proposed_by', profile.id).eq('status', 'approved').order('created_at', {ascending:false});
      var compLogoRes = await supabaseClient.from('competition_logo_proposals')
        .select('*, competitions(name, slug, sport_slug)')
        .eq('proposed_by', profile.id).eq('status', 'approved').order('created_at', {ascending:false});
      var logoCards = (teamLogoRes.data || []).map(function(l){ return logoCard(l, l.teams, {label:'Team logo'}); })
        .concat((compLogoRes.data || []).map(function(l){ return compLogoCard(l, l.competitions, {label:'Competition logo'}); }))
        .join('');
      logoSectionHtml = logoCards
        ? '<div class="section-head" style="margin-top:34px;"><h2>Logos contributed</h2></div><div class="jersey-grid">'+logoCards+'</div>'
        : '';
    }

    // Jerseys this person has marked as ones they personally own (the
    // jersey detail page's "Add to your collection" toggle). Unlike
    // uploads/points/logos, this one has a per-user public/private
    // choice (collection_public, default true) - skip the query
    // entirely for a private collection unless it's the owner's own
    // profile, since nobody else is allowed to see it anyway. Shown on
    // page 1 only, same as the logo section. Filtered to approved in
    // case a collected jersey was since unapproved (reassigned, say) -
    // collection_items itself carries no status of its own to check.
    var isOwnProfile = !!(currentUser && currentUser.id === profile.id);
    var collectionSectionHtml = '';
    if(page === 1 && (isOwnProfile || profile.collection_public)){
      var colJRes = await supabaseClient.from('collection_items')
        .select('jerseys!inner(*, jersey_images(*), teams(name, slug, primary_color, secondary_color, competition_slug))')
        .eq('user_id', profile.id).eq('jerseys.status', 'approved').order('created_at', {ascending:false});
      var collectionJerseys = (colJRes.data || []).map(function(r){ return r.jerseys; }).filter(Boolean);
      var collectionCards = collectionJerseys.map(function(j){ return jerseyCard(j, j.teams, {showTeam:true}); });
      // Only the profile's own owner gets the toggle - visibility is
      // their call, nobody else's.
      var collectionToggleHtml = isOwnProfile
        ? '<label class="field-hint" style="display:block;cursor:pointer;margin:-10px 0 14px;">' +
            '<input type="checkbox" id="collection-visibility-toggle" '+(profile.collection_public ? 'checked' : '')+' style="vertical-align:middle;margin-right:6px;">' +
            'Make my collection visible to other visitors' +
          '</label>'
        : '';
      if(collectionCards.length){
        collectionSectionHtml = '<div class="section-head" style="margin-top:34px;"><h2>Collection</h2><span class="count">'+collectionCards.length+'</span></div>' +
          collectionToggleHtml + limitedJerseyGrid(collectionCards);
      } else if(isOwnProfile){
        collectionSectionHtml = '<div class="section-head" style="margin-top:34px;"><h2>Collection</h2></div>' +
          collectionToggleHtml + '<div class="empty-note">Nothing added yet &mdash; add a jersey to your collection from its own page.</div>';
      }
    }

    // A tab up top (next to the leaderboard link) rather than making
    // the collection something you only find by scrolling past however
    // many pages of uploads there are. Both panels are already in the
    // page - this just shows/hides between them client-side, no reload.
    var profileTabsHtml = collectionSectionHtml
      ? '<div class="profile-tabs">' +
          '<button class="chip profile-tab-btn is-active" data-tab="uploads" type="button">Uploads</button>' +
          '<button class="chip profile-tab-btn" data-tab="collection" type="button">Collection</button>' +
        '</div>'
      : '';

    return '<div class="section-head"><h2>'+esc(profile.username)+' '+pointsChip(profile.points)+'</h2><span class="count">'+totalJerseys+' upload'+(totalJerseys===1?'':'s')+'</span></div>' +
      '<p style="margin:-10px 0 18px;"><a class="spec-link" href="#/contributors">See the full leaderboard &rarr;</a></p>' +
      profileTabsHtml +
      '<div id="profile-tab-uploads">' +
        (cards ? '<div class="jersey-grid">'+cards+'</div>' : '<div class="empty-note">No approved uploads yet.</div>') +
        pagerHtml +
        logoSectionHtml +
      '</div>' +
      (collectionSectionHtml ? '<div id="profile-tab-collection" hidden>'+collectionSectionHtml+'</div>' : '');
  }

  function viewNotFound(){
    setCrumbs([{label:'Home', href:'#/'}]);
    return '<div class="empty-note">That page doesn&rsquo;t exist. <a href="#/" style="color:var(--accent);">Back to home</a>.</div>';
  }

  /* ================= router ================= */
  async function render(){
    var hash = location.hash.replace(/^#\/?/, '');
    var parts = hash.split('/').filter(Boolean).map(decodeURIComponent);
    var app = document.getElementById('app');
    app.innerHTML = '<p class="loading">Loading&hellip;</p>';

    try {
      var html;
      if(parts.length === 0){ html = await viewHome(); }
      else if(parts[0]==='sport' && parts.length===2){ html = await viewSport(parts[1]); }
      else if(parts[0]==='sport' && parts.length===3 && parts[2]==='updates'){ html = await viewUpdates(parts[1]); }
      else if(parts[0]==='sport' && parts.length===3){ html = await viewCompetition(parts[1], parts[2]); }
      else if(parts[0]==='sport' && parts.length===5 && parts[3]==='team'){ html = await viewTeam(parts[1], parts[2], parts[4]); }
      else if(parts[0]==='sport' && parts.length===5 && parts[3]==='season'){ html = await viewSeason(parts[1], parts[2], parts[4]); }
      else if(parts[0]==='jersey' && parts[1]){ html = await viewJerseyDetail(parts[1]); }
      else if(parts[0]==='search' && parts[1]){ html = await viewSearch(parts[1]); }
      else if(parts[0]==='manufacturers' && parts.length===1){ html = await viewManufacturers(); }
      else if(parts[0]==='manufacturer' && parts[1]){ html = await viewManufacturer(parts[1]); }
      else if(parts[0]==='contributors' && parts.length===1){ html = await viewContributors(); }
      else if(parts[0]==='format' && parts[1]){ html = await viewFormat(parts[1]); }
      else if(parts[0]==='updates' && parts.length===1){ html = await viewUpdates(); }
      else if(parts[0]==='types' && parts.length===1){ html = await viewTypes(); }
      else if(parts[0]==='type' && parts[1]){ html = await viewType(parts[1], parts[2], parts[3]); }
      else if(parts[0]==='upload'){ html = await viewUpload(); }
      else if(parts[0]==='help'){ html = viewHelp(); }
      else if(parts[0]==='moderate'){ html = await viewModerate(); }
      else if(parts[0]==='user' && parts[1]){ html = await viewUserProfile(parts[1], parts[2]); }
      else if(parts[0]==='logo-proposal' && parts[1] && parts[2]){ html = await viewLogoProposal(parts[1], parts[2]); }
      else { html = viewNotFound(); }
      app.innerHTML = html;
      wireViewEvents(parts);
    } catch(err) {
      app.innerHTML = errorBox(err);
    }
  }

  function wireViewEvents(parts){
    var teamFilter = document.getElementById('team-filter');
    if(teamFilter){
      teamFilter.addEventListener('input', function(){
        var q = teamFilter.value.toLowerCase();
        document.querySelectorAll('.team-grid .team-card').forEach(function(card){
          // an empty query means "no active search" — restore whatever the
          // pagination state was (still collapsed unless "Show all" was
          // already clicked) rather than force-revealing every card
          card.hidden = q
            ? card.querySelector('h3').textContent.toLowerCase().indexOf(q) === -1
            : card.hasAttribute('data-paginated-overflow');
        });
        // hide a format group's heading (and empty grid) once every team in it is filtered out
        document.querySelectorAll('.extra-kits-label').forEach(function(heading){
          var grid = heading.nextElementSibling;
          if(!grid || !grid.classList.contains('team-grid')) return;
          var cards = grid.querySelectorAll('.team-card');
          var allHidden = cards.length > 0 && Array.prototype.every.call(cards, function(c){ return c.hidden; });
          heading.hidden = allHidden;
          grid.hidden = allHidden;
        });
      });
    }
    document.querySelectorAll('.show-all-teams-btn').forEach(function(btn){
      btn.addEventListener('click', function(){
        var grid = btn.previousElementSibling;
        if(grid) grid.querySelectorAll('[data-paginated-overflow]').forEach(function(card){
          card.hidden = false;
          card.removeAttribute('data-paginated-overflow');
        });
        btn.remove();
      });
    });
    var jerseyTabs = document.getElementById('team-jersey-tabs');
    if(jerseyTabs){
      jerseyTabs.querySelectorAll('.chip').forEach(function(chip){
        chip.addEventListener('click', function(){
          jerseyTabs.querySelectorAll('.chip').forEach(function(c){ c.classList.remove('is-active'); });
          chip.classList.add('is-active');
          ['team-tab-main','team-tab-training'].forEach(function(id){
            var panel = document.getElementById(id);
            if(panel) panel.hidden = id !== chip.dataset.tab;
          });
        });
      });
    }
    var formatFilterRow = document.getElementById('format-filter-row');
    if(formatFilterRow){
      formatFilterRow.querySelectorAll('.format-filter-chip').forEach(function(chip){
        chip.addEventListener('click', function(){
          formatFilterRow.querySelectorAll('.format-filter-chip').forEach(function(c){ c.classList.remove('is-active'); });
          chip.classList.add('is-active');
          var wanted = chip.dataset.format;
          document.querySelectorAll('.jersey-card[data-format]').forEach(function(card){
            card.hidden = !!wanted && card.dataset.format !== wanted;
          });
          // hide a whole season group if every card in it just got hidden
          document.querySelectorAll('.season-group').forEach(function(group){
            var cards = group.querySelectorAll('.jersey-card');
            group.hidden = cards.length > 0 && Array.prototype.every.call(cards, function(c){ return c.hidden; });
          });
        });
      });
    }
    var teamFormatFilterRow = document.getElementById('team-format-filter-row');
    if(teamFormatFilterRow){
      teamFormatFilterRow.querySelectorAll('.team-format-filter-chip').forEach(function(chip){
        chip.addEventListener('click', function(){
          teamFormatFilterRow.querySelectorAll('.team-format-filter-chip').forEach(function(c){ c.classList.remove('is-active'); });
          chip.classList.add('is-active');
          var wanted = chip.dataset.format;
          document.querySelectorAll('.team-grid .team-card').forEach(function(card){
            var formats = card.dataset.formats ? card.dataset.formats.split(',') : [];
            card.hidden = !!wanted && formats.indexOf(wanted) === -1;
          });
          ['men','women'].forEach(function(side){
            var grid = document.getElementById(side+'-team-grid');
            var countEl = document.getElementById(side+'-count');
            if(!grid || !countEl) return;
            var visible = Array.prototype.filter.call(grid.querySelectorAll('.team-card'), function(c){ return !c.hidden; });
            countEl.textContent = visible.length;
          });
        });
      });
    }
    var moreBtn = document.getElementById('more-comps-btn');
    if(moreBtn){
      moreBtn.addEventListener('click', function(){
        var panel = document.getElementById('more-comps');
        panel.hidden = !panel.hidden;
        moreBtn.textContent = panel.hidden ? 'More competitions ↓' : 'Show fewer ↑';
        var parts = location.hash.replace(/^#\/?/, '').split('/').filter(Boolean).map(decodeURIComponent);
        if(parts[0]==='sport' && parts[1]){
          if(panel.hidden) delete expandedSportComps[parts[1]];
          else expandedSportComps[parts[1]] = true;
        }
      });
    }
    var moreSportsBtn = document.getElementById('more-sports-btn');
    if(moreSportsBtn){
      moreSportsBtn.addEventListener('click', function(){
        var panel = document.getElementById('more-sports');
        panel.hidden = !panel.hidden;
        moreSportsBtn.textContent = panel.hidden ? 'More sports ↓' : 'Show fewer ↑';
        expandedHomeSports = !panel.hidden;
      });
    }
    var thumbsWrap = document.getElementById('gallery-thumbs');
    if(thumbsWrap){
      var images = JSON.parse(thumbsWrap.dataset.images);
      var main = document.getElementById('gallery-main');
      thumbsWrap.querySelectorAll('.gallery-thumb').forEach(function(btn){
        btn.addEventListener('click', function(){
          thumbsWrap.querySelectorAll('.gallery-thumb').forEach(function(b){ b.classList.remove('is-active'); });
          btn.classList.add('is-active');
          main.innerHTML = '<img class="lightbox-trigger" src="'+esc(publicImageUrl(images[Number(btn.dataset.idx)].storage_path))+'" alt="">';
        });
      });
    }

    var ratingWidget = document.getElementById('rating-widget');
    if(ratingWidget && currentUser){
      ratingWidget.addEventListener('click', async function(e){
        var btn = e.target.closest('.star-btn');
        if(!btn || btn.disabled) return;
        var value = Number(btn.dataset.value);
        var jerseyId = ratingWidget.dataset.jerseyId;
        var res = await supabaseClient.from('ratings').upsert({jersey_id:jerseyId, user_id:currentUser.id, value:value}, {onConflict:'jersey_id,user_id'});
        if(res.error){ ratingWidget.insertAdjacentHTML('beforeend', '<p class="field-error">'+esc(res.error.message)+'</p>'); return; }
        var fresh = await fetchRating(jerseyId);
        ratingWidget.innerHTML = ratingWidgetHtml(fresh, value);
      });
    }

    var collectionToggleBtn = document.querySelector('.collection-toggle-btn');
    if(collectionToggleBtn && currentUser){
      collectionToggleBtn.addEventListener('click', async function(){
        collectionToggleBtn.disabled = true;
        var jerseyId = collectionToggleBtn.dataset.jerseyId;
        var inCollection = collectionToggleBtn.dataset.inCollection === 'true';
        try {
          if(inCollection){
            var del = await supabaseClient.from('collection_items').delete().eq('user_id', currentUser.id).eq('jersey_id', jerseyId);
            if(del.error) throw del.error;
          } else {
            var ins = await supabaseClient.from('collection_items').insert({user_id: currentUser.id, jersey_id: jerseyId});
            if(ins.error) throw ins.error;
          }
          collectionToggleBtn.dataset.inCollection = (!inCollection).toString();
          collectionToggleBtn.textContent = !inCollection ? '✓ In your collection' : '+ Add to your collection';
        } catch(err){
          alert('Error: ' + (err.message || err));
        }
        collectionToggleBtn.disabled = false;
      });
    }
    var collectionHelpBtn = document.getElementById('collection-help-btn');
    if(collectionHelpBtn){
      // Native title attribute already covers hover for desktop - this
      // adds a click toggle too, since title does nothing useful on touch.
      collectionHelpBtn.addEventListener('click', function(){
        var text = document.getElementById('collection-help-text');
        if(text) text.hidden = !text.hidden;
      });
    }

    var collectionVisibilityToggle = document.getElementById('collection-visibility-toggle');
    if(collectionVisibilityToggle && currentUser){
      collectionVisibilityToggle.addEventListener('change', async function(){
        collectionVisibilityToggle.disabled = true;
        var res = await supabaseClient.from('profiles').update({collection_public: collectionVisibilityToggle.checked}).eq('id', currentUser.id);
        if(res.error){
          collectionVisibilityToggle.checked = !collectionVisibilityToggle.checked;
          alert('Error: ' + res.error.message);
        }
        collectionVisibilityToggle.disabled = false;
      });
    }

    var jerseyMessageSendBtn = document.getElementById('jersey-message-send');
    if(jerseyMessageSendBtn && currentUser){
      jerseyMessageSendBtn.addEventListener('click', async function(){
        var input = document.getElementById('jersey-message-input');
        var text = input.value.trim();
        if(!text) return;
        jerseyMessageSendBtn.disabled = true;
        var jerseyId = jerseyMessageSendBtn.dataset.jerseyId;
        var res = await supabaseClient.from('jersey_messages').insert({jersey_id: jerseyId, sender_id: currentUser.id, message: text});
        if(res.error){
          jerseyMessageSendBtn.disabled = false;
          alert('Error: ' + res.error.message);
          return;
        }
        input.value = '';
        var thread = document.getElementById('jersey-messages-thread');
        if(thread) thread.innerHTML = await jerseyMessagesThreadHtml(jerseyId);
        jerseyMessageSendBtn.disabled = false;
      });
    }

    var logoMessageSendBtn = document.getElementById('logo-message-send');
    if(logoMessageSendBtn && currentUser){
      logoMessageSendBtn.addEventListener('click', async function(){
        var input = document.getElementById('logo-message-input');
        var text = input.value.trim();
        if(!text) return;
        logoMessageSendBtn.disabled = true;
        var kind = logoMessageSendBtn.dataset.kind;
        var proposalId = logoMessageSendBtn.dataset.proposalId;
        var row = {sender_id: currentUser.id, message: text, kind: kind};
        row[kind === 'team' ? 'team_logo_proposal_id' : 'competition_logo_proposal_id'] = proposalId;
        var res = await supabaseClient.from('logo_messages').insert(row);
        if(res.error){
          logoMessageSendBtn.disabled = false;
          alert('Error: ' + res.error.message);
          return;
        }
        input.value = '';
        var thread = document.getElementById('logo-messages-thread');
        if(thread) thread.innerHTML = await logoMessagesThreadHtml(kind, proposalId);
        logoMessageSendBtn.disabled = false;
      });
    }

    var lpReplaceDropzone = document.getElementById('lp-replace-dropzone');
    var lpReplaceInput = document.getElementById('lp-replace-input');
    if(lpReplaceDropzone && lpReplaceInput){
      async function doLpReplace(file){
        if(!file || !/^image\//.test(file.type)) return;
        var statusEl = document.getElementById('lp-replace-status');
        var approveBtn = document.getElementById('lp-approve-btn');
        var oldPath = approveBtn.dataset.path;
        var proposalKind = approveBtn.dataset.kind, proposalId = approveBtn.dataset.id;
        statusEl.hidden = false; statusEl.textContent = 'Uploading…';
        lpReplaceDropzone.setAttribute('aria-disabled', 'true');
        try {
          var compressed = await compressImageForUpload(file, LOGO_WEBP_QUALITY);
          var ext = (compressed.name.split('.').pop() || 'png').toLowerCase();
          var newPath = oldPath.replace(/\/[^/]+$/, '') + '/logo-' + Date.now() + '.' + ext;
          var up = await supabaseClient.storage.from('team-logos').upload(newPath, compressed);
          if(up.error) throw up.error;
          var table = proposalKind === 'team' ? 'team_logo_proposals' : 'competition_logo_proposals';
          var upd = await supabaseClient.from(table).update({storage_path: newPath}).eq('id', proposalId);
          if(upd.error) throw upd.error;
          await supabaseClient.storage.from('team-logos').remove([oldPath]); // best-effort cleanup of the old file
          render();
        } catch(err){
          statusEl.textContent = 'Error: ' + (err.message || err);
          lpReplaceDropzone.removeAttribute('aria-disabled');
        }
      }
      lpReplaceDropzone.addEventListener('click', function(){ lpReplaceInput.click(); });
      lpReplaceDropzone.addEventListener('keydown', function(e){ if(e.key === 'Enter' || e.key === ' '){ e.preventDefault(); lpReplaceInput.click(); } });
      lpReplaceInput.addEventListener('change', function(){ var f = lpReplaceInput.files[0]; lpReplaceInput.value = ''; doLpReplace(f); });
      lpReplaceDropzone.addEventListener('dragover', function(e){ e.preventDefault(); lpReplaceDropzone.classList.add('is-dragover'); });
      lpReplaceDropzone.addEventListener('dragleave', function(){ lpReplaceDropzone.classList.remove('is-dragover'); });
      lpReplaceDropzone.addEventListener('drop', function(e){
        e.preventDefault();
        lpReplaceDropzone.classList.remove('is-dragover');
        if(e.dataTransfer && e.dataTransfer.files && e.dataTransfer.files[0]) doLpReplace(e.dataTransfer.files[0]);
      });
    }

    var lpCropBtn = document.getElementById('lp-crop-btn');
    if(lpCropBtn){
      lpCropBtn.addEventListener('click', function(){
        openLogoCropModal(lpCropBtn.dataset.path, lpCropBtn.dataset.kind, lpCropBtn.dataset.id);
      });
    }

    var lpYearsSaveBtn = document.getElementById('lp-years-save-btn');
    if(lpYearsSaveBtn){
      lpYearsSaveBtn.addEventListener('click', async function(){
        var statusEl = document.getElementById('lp-years-status');
        var firstUsed = document.getElementById('lp-year-first').value.trim();
        var lastUsed = document.getElementById('lp-year-last').value.trim();
        var yearsUsed = firstUsed ? ((lastUsed && Number(lastUsed) > Number(firstUsed)) ? (firstUsed + '-' + lastUsed) : firstUsed) : null;
        var note = document.getElementById('lp-note-input').value.trim() || null;
        lpYearsSaveBtn.disabled = true;
        statusEl.hidden = false; statusEl.textContent = 'Saving…';
        try {
          var table = lpYearsSaveBtn.dataset.kind === 'team' ? 'team_logo_proposals' : 'competition_logo_proposals';
          var upd = await supabaseClient.from(table).update({years_used: yearsUsed, note: note}).eq('id', lpYearsSaveBtn.dataset.id);
          if(upd.error) throw upd.error;
          render();
        } catch(err){
          statusEl.textContent = 'Error: ' + (err.message || err);
          lpYearsSaveBtn.disabled = false;
        }
      });
    }

    var lpApproveBtn = document.getElementById('lp-approve-btn');
    if(lpApproveBtn){
      lpApproveBtn.addEventListener('click', async function(){
        var lpRejectBtn = document.getElementById('lp-reject-btn');
        lpApproveBtn.disabled = true; if(lpRejectBtn) lpRejectBtn.disabled = true;
        try {
          var logoKind = lpApproveBtn.dataset.kind;
          var proposalTable = logoKind === 'team' ? 'team_logo_proposals' : 'competition_logo_proposals';
          var makeCurrentCb = document.getElementById(lpApproveBtn.dataset.makeCurrentId);
          var willMakeCurrent = !makeCurrentCb || makeCurrentCb.checked;
          if(!willMakeCurrent) await addLogoToHistory(logoKind, lpApproveBtn.dataset.refId, lpApproveBtn.dataset.path, lpApproveBtn.dataset.years || null, lpApproveBtn.dataset.proposedBy || null, lpApproveBtn.dataset.note || null, lpApproveBtn.dataset.id);
          else await setLogo(logoKind, lpApproveBtn.dataset.refId, lpApproveBtn.dataset.path, lpApproveBtn.dataset.years || null, lpApproveBtn.dataset.proposedBy || null, lpApproveBtn.dataset.note || null, lpApproveBtn.dataset.id);
          var approveRes = await supabaseClient.from(proposalTable).update({status:'approved'}).eq('id', lpApproveBtn.dataset.id);
          if(approveRes.error) throw approveRes.error;
          await refreshAuthUI();
          render();
        } catch(err){
          alert('Error: ' + (err.message || err));
          lpApproveBtn.disabled = false; if(lpRejectBtn) lpRejectBtn.disabled = false;
        }
      });
    }

    var lpRejectBtn = document.getElementById('lp-reject-btn');
    if(lpRejectBtn){
      lpRejectBtn.addEventListener('click', async function(){
        if(!confirm('Reject this logo proposal?')) return;
        var lpApproveBtnEl = document.getElementById('lp-approve-btn');
        lpRejectBtn.disabled = true; if(lpApproveBtnEl) lpApproveBtnEl.disabled = true;
        try {
          var logoKind = lpRejectBtn.dataset.kind;
          var proposalTable = logoKind === 'team' ? 'team_logo_proposals' : 'competition_logo_proposals';
          if(lpRejectBtn.dataset.path){
            var rm = await supabaseClient.storage.from('team-logos').remove([lpRejectBtn.dataset.path]);
            if(rm.error) throw rm.error;
          }
          var delRes = await supabaseClient.from(proposalTable).delete().eq('id', lpRejectBtn.dataset.id);
          if(delRes.error) throw delRes.error;
          render();
        } catch(err){
          alert('Error: ' + (err.message || err));
          lpRejectBtn.disabled = false; if(lpApproveBtnEl) lpApproveBtnEl.disabled = false;
        }
      });
    }

    var addPhotosToggle = document.getElementById('add-photos-toggle');
    if(addPhotosToggle){
      addPhotosToggle.addEventListener('click', function(){
        var panel = document.getElementById('add-photos-panel');
        var immediate = addPhotosToggle.dataset.immediate === 'true';
        if(!panel.dataset.wired){
          panel.dataset.wired = '1';
          panel.innerHTML = renderAddPhotosPanel(immediate);
          wireAddPhotosPanel(addPhotosToggle.dataset.jerseyId, immediate);
        }
        panel.hidden = !panel.hidden;
      });
    }

    var proposeLogoToggle = document.getElementById('propose-logo-toggle');
    if(proposeLogoToggle){
      proposeLogoToggle.addEventListener('click', function(){
        var panel = document.getElementById('propose-logo-panel');
        if(!panel.dataset.wired){
          panel.dataset.wired = '1';
          panel.innerHTML = renderProposeLogoPanel();
          wireProposeLogoPanel('team', proposeLogoToggle.dataset.teamId);
        }
        panel.hidden = !panel.hidden;
      });
    }

    var proposeCompLogoToggle = document.getElementById('propose-comp-logo-toggle');
    if(proposeCompLogoToggle){
      proposeCompLogoToggle.addEventListener('click', function(){
        var panel = document.getElementById('propose-comp-logo-panel');
        if(!panel.dataset.wired){
          panel.dataset.wired = '1';
          panel.innerHTML = renderProposeLogoPanel();
          wireProposeLogoPanel('competition', proposeCompLogoToggle.dataset.compSlug);
        }
        panel.hidden = !panel.hidden;
      });
    }

    var toggleActiveBtn = document.getElementById('toggle-active-btn');
    if(toggleActiveBtn){
      toggleActiveBtn.addEventListener('click', async function(){
        var newActive = toggleActiveBtn.dataset.active !== 'true';
        var res = await supabaseClient.from('teams').update({is_active: newActive}).eq('id', toggleActiveBtn.dataset.teamId);
        if(res.error){ alert('Error: ' + res.error.message); return; }
        render();
      });
    }
    // Flips an announced-but-not-yet-playing expansion team (Perth Bears,
    // Tasmania Devils) into the normal active roster once it actually
    // starts playing — a one-way move off the "New expansion teams"
    // section, permanent (no "move back to upcoming" button, since that
    // shouldn't ever need to happen once a club has taken the field).
    var toggleUpcomingBtn = document.getElementById('toggle-upcoming-btn');
    if(toggleUpcomingBtn){
      toggleUpcomingBtn.addEventListener('click', async function(){
        if(!confirm('Move this team into the active roster? This can\'t be undone from here.')) return;
        var res = await supabaseClient.from('teams').update({is_upcoming: false}).eq('id', toggleUpcomingBtn.dataset.teamId);
        if(res.error){ alert('Error: ' + res.error.message); return; }
        render();
      });
    }

    var adminSettingsToggle = document.getElementById('admin-settings-toggle');
    if(adminSettingsToggle && parts[0]==='sport' && parts[3]==='team'){
      var teamPageSportSlug = parts[1], teamPageTeamSlug = parts[4];
      adminSettingsToggle.addEventListener('click', function(){
        var panel = document.getElementById('admin-settings-panel');
        if(!panel.dataset.wired){
          panel.dataset.wired = '1';
          panel.hidden = false;
          wireCompetitionMoveControl('team-page', function(newSlug){
            location.hash = '#/sport/'+teamPageSportSlug+'/'+newSlug+'/team/'+teamPageTeamSlug;
          });
          return;
        }
        panel.hidden = !panel.hidden;
      });
    }

    if(adminSettingsToggle && parts[0]==='jersey'){
      adminSettingsToggle.addEventListener('click', function(){
        var panel = document.getElementById('admin-settings-panel');
        if(!panel.dataset.wired){
          panel.dataset.wired = '1';
          panel.hidden = false;
          wirePhotoLabelSwap(panel.querySelectorAll('.photo-label-select'));
          panel.querySelectorAll('.photo-delete-btn').forEach(function(btn){
            btn.addEventListener('click', async function(){
              if(!confirm('Delete this photo? This can\'t be undone.')) return;
              btn.disabled = true;
              var res = await supabaseClient.from('jersey_images').delete().eq('id', btn.dataset.imageId);
              if(res.error){ btn.disabled = false; alert('Error: ' + res.error.message); return; }
              render();
            });
          });
          wireCropButtons(panel);
          wireJerseyReassignControl('jersey-reassign', panel.dataset.sportSlug, function(){ render(); });
          wireJerseyExtraCompsControl(parts[1], panel.dataset.sportSlug);
          var creditAddBtn = document.getElementById('jersey-credit-add-btn');
          if(creditAddBtn){
            creditAddBtn.addEventListener('click', async function(){
              var usernameInput = document.getElementById('jersey-credit-username');
              var noteInput = document.getElementById('jersey-credit-note');
              var pointCb = document.getElementById('jersey-credit-point');
              var msg = document.getElementById('jersey-credit-msg');
              var username = usernameInput.value.trim();
              if(!username) return;
              creditAddBtn.disabled = true;
              msg.hidden = true;
              try {
                var profRes = await supabaseClient.from('profiles').select('id, points').eq('username', username).maybeSingle();
                if(profRes.error) throw profRes.error;
                if(!profRes.data) throw new Error('No user found with that username.');
                var ins = await supabaseClient.from('jersey_additional_credits').insert({
                  jersey_id: creditAddBtn.dataset.jerseyId, user_id: profRes.data.id, note: noteInput.value.trim() || null, added_by: currentUser.id
                });
                if(ins.error) throw ins.error;
                if(pointCb.checked){
                  var pUpd = await supabaseClient.from('profiles').update({points: (profRes.data.points || 0) + 1}).eq('id', profRes.data.id);
                  if(pUpd.error) throw pUpd.error;
                }
                render();
              } catch(err){
                creditAddBtn.disabled = false;
                msg.hidden = false; msg.className = 'field-error'; msg.textContent = 'Error: ' + (err.message || err);
              }
            });
          }
          panel.querySelectorAll('.delete-credit-btn').forEach(function(btn){
            btn.addEventListener('click', async function(){
              if(!confirm('Remove this credit?')) return;
              btn.disabled = true;
              var res = await supabaseClient.from('jersey_additional_credits').delete().eq('id', btn.dataset.creditId);
              if(res.error){ btn.disabled = false; alert('Error: ' + res.error.message); return; }
              render();
            });
          });
          var deleteJerseyBtn = panel.querySelector('.delete-jersey-btn');
          if(deleteJerseyBtn){
            deleteJerseyBtn.addEventListener('click', async function(){
              if(!confirm('Permanently delete this jersey and all its photos? This can\'t be undone.')) return;
              deleteJerseyBtn.disabled = true; deleteJerseyBtn.textContent = 'Deleting…';
              try {
                var jerseyId = deleteJerseyBtn.dataset.jerseyId;
                var imgRes = await supabaseClient.from('jersey_images').select('storage_path').eq('jersey_id', jerseyId);
                if(imgRes.error) throw imgRes.error;
                var paths = (imgRes.data || []).map(function(r){ return r.storage_path; });
                if(paths.length){
                  var rm = await supabaseClient.storage.from('jersey-photos').remove(paths);
                  if(rm.error) throw rm.error;
                }
                // The jerseys row itself cascades everything else that
                // points at it (jersey_images, jersey_competitions,
                // jersey_messages, collection_items, jersey_additional_credits,
                // jersey_message_reads all use on delete cascade) - only the
                // storage files above need removing by hand first, since
                // Storage isn't tied to that cascade.
                var del = await supabaseClient.from('jerseys').delete().eq('id', jerseyId);
                if(del.error) throw del.error;
                location.hash = deleteJerseyBtn.dataset.redirect;
              } catch(err){
                deleteJerseyBtn.disabled = false; deleteJerseyBtn.textContent = 'Delete this jersey';
                alert('Error: ' + (err.message || err));
              }
            });
          }
          return;
        }
        panel.hidden = !panel.hidden;
      });
    }

    var logoHistoryToggle = document.getElementById('logo-history-toggle');
    if(logoHistoryToggle){
      var logoHistoryTeamId = logoHistoryToggle.dataset.teamId;
      logoHistoryToggle.addEventListener('click', async function(){
        var panel = document.getElementById('logo-history-panel');
        if(!panel.dataset.wired){
          panel.dataset.wired = '1';
          panel.hidden = false;
          await refreshLogoHistoryPanel('team', logoHistoryTeamId);
          return;
        }
        panel.hidden = !panel.hidden;
      });
    }

    var compLogoHistoryToggle = document.getElementById('comp-logo-history-toggle');
    if(compLogoHistoryToggle){
      var logoHistoryCompSlug = compLogoHistoryToggle.dataset.compSlug;
      compLogoHistoryToggle.addEventListener('click', async function(){
        var panel = document.getElementById('comp-logo-history-panel');
        if(!panel.dataset.wired){
          panel.dataset.wired = '1';
          panel.hidden = false;
          await refreshLogoHistoryPanel('competition', logoHistoryCompSlug);
          return;
        }
        panel.hidden = !panel.hidden;
      });
    }

    if(parts[0]==='upload' && currentUser){ wireUploadForm(); }
    if(parts[0]==='moderate'){ wireModerationActions(); }
    wireReportButtons();
    wireInlineEdits();
  }

  async function refreshLogoHistoryPanel(kind, refId){
    var t = logoTables(kind);
    var panel = document.getElementById(kind === 'team' ? 'logo-history-panel' : 'comp-logo-history-panel');
    if(!panel) return;
    panel.innerHTML = '<p class="loading">Loading…</p>';
    var res = await supabaseClient.from(t.history).select('*').eq(t.refCol, refId);
    if(res.error){ panel.innerHTML = errorBox(res.error); return; }
    var rows = res.data || [];
    // Sorted by the logo's actual year, latest first, rather than by
    // when it happened to be approved - a backdated/historical logo
    // added just now (e.g. a 2017 special edition found after the
    // fact) should still land in its real chronological spot, not at
    // the top just because it's the newest row. The current logo
    // always leads regardless, same as its own "Current" caption.
    function sortYear(r){
      if(r.years_used){
        var nums = r.years_used.match(/\d{4}/g);
        if(nums) return Math.max.apply(null, nums.map(Number));
      }
      return new Date(r.approved_at).getFullYear();
    }
    rows.sort(function(a, b){
      if(a.is_current !== b.is_current) return a.is_current ? -1 : 1;
      var diff = sortYear(b) - sortYear(a);
      return diff !== 0 ? diff : new Date(b.approved_at) - new Date(a.approved_at);
    });
    // Only ever set for a logo approved after logo_uploader_credit.sql -
    // older history rows genuinely have no record of who proposed them,
    // so those just show no credit line rather than "by unknown".
    var uploaderIds = rows.map(function(r){ return r.proposed_by; }).filter(Boolean);
    var uploaderNamesById = {};
    if(uploaderIds.length){
      var upRes = await supabaseClient.from('profiles').select('id, username').in('id', uploaderIds);
      (upRes.data || []).forEach(function(p){ uploaderNamesById[p.id] = p.username; });
    }
    var isAdmin = currentProfile && currentProfile.is_admin;
    panel.innerHTML = rows.length
      ? '<div class="logo-history-grid lightbox-group">' + rows.map(function(r){
          var caption = r.years_used ? esc(r.years_used) : (r.is_current ? 'Current' : 'Added '+fmtDate(r.approved_at));
          var noteHtml = r.note ? '<span style="display:block;color:var(--accent);font-weight:600;">'+esc(r.note)+'</span>' : '';
          var editBtn = isAdmin ? ' <button class="edit-pencil-btn" type="button" data-logo-id="'+r.id+'" data-current="'+esc(r.years_used || '')+'" data-note="'+esc(r.note || '')+'">'+ICON_PENCIL+'</button>' : '';
          // Lets an admin swap back to an older logo (e.g. a one-off
          // anniversary logo this year, back to the regular one next
          // year) without re-uploading the same image file again - the
          // image's already sitting right here in history.
          var makeCurrentBtn = (isAdmin && !r.is_current) ? ' <button class="btn btn-secondary make-current-btn" type="button" data-logo-id="'+r.id+'" data-path="'+esc(r.storage_path)+'" style="padding:2px 8px;font-size:12px;">Make current</button>' : '';
          // Only for a non-current entry - deliberately no way to delete
          // the live logo from here, so there's never a team/competition
          // left pointing at a storage_path that no longer exists.
          var deleteBtn = (isAdmin && !r.is_current) ? ' <button class="btn btn-reject delete-logo-btn" type="button" data-logo-id="'+r.id+'" data-path="'+esc(r.storage_path)+'" style="padding:2px 8px;font-size:12px;">Delete</button>' : '';
          // Swaps the image file in place (including for the current
          // logo) when a clearer photo of the same logo turns up later -
          // doesn't touch years/note/is_current, and doesn't add a new
          // history row the way proposing a fresh logo would.
          var replaceBtn = isAdmin ? ' <button class="btn btn-secondary replace-logo-btn" type="button" data-logo-id="'+r.id+'" data-path="'+esc(r.storage_path)+'" style="padding:2px 8px;font-size:12px;">Replace photo</button>' : '';
          var creditHtml = uploaderNamesById[r.proposed_by]
            ? '<span style="font-size:10.5px;color:var(--text-dim);">by '+esc(uploaderNamesById[r.proposed_by])+'</span>'
            : '';
          // Only set for a logo approved after logo_messages.sql's
          // proposal_id column was added - older/manually-added history
          // has no proposal to link back to, so no link shows for those.
          var msgLinkHtml = (isAdmin && r.proposal_id)
            ? ' <a class="spec-link" href="#/logo-proposal/'+kind+'/'+r.proposal_id+'" target="_blank" rel="noopener" style="font-size:10.5px;">View / message</a>'
            : '';
          return '<div class="logo-history-item"><img class="lightbox-trigger" src="'+esc(publicLogoUrl(r.storage_path))+'" alt="" loading="lazy">' +
            '<div class="spec-value-row"><span>'+caption+'</span>'+editBtn+makeCurrentBtn+deleteBtn+replaceBtn+'</div>' + noteHtml + creditHtml + msgLinkHtml + '</div>';
        }).join('') + '</div>'
      : '<div class="empty-note">No logo history yet.</div>';
    panel.querySelectorAll('.make-current-btn').forEach(function(btn){
      btn.addEventListener('click', async function(){
        btn.disabled = true; btn.textContent = 'Setting…';
        try {
          await restoreLogo(kind, refId, btn.dataset.logoId);
          render();
        } catch(e){
          btn.disabled = false; btn.textContent = 'Make current';
          alert('Error: ' + (e.message || e));
        }
      });
    });
    panel.querySelectorAll('.delete-logo-btn').forEach(function(btn){
      btn.addEventListener('click', async function(){
        if(!confirm('Delete this logo from history? This removes the image permanently.')) return;
        btn.disabled = true; btn.textContent = 'Deleting…';
        try {
          await deleteLogoHistoryEntry(kind, refId, btn.dataset.logoId, btn.dataset.path);
          refreshLogoHistoryPanel(kind, refId);
        } catch(e){
          btn.disabled = false; btn.textContent = 'Delete';
          alert('Error: ' + (e.message || e));
        }
      });
    });
    panel.querySelectorAll('.replace-logo-btn').forEach(function(btn){
      btn.addEventListener('click', function(){
        openLogoReplaceModal(btn.dataset.path, kind, btn.dataset.logoId);
      });
    });
    panel.querySelectorAll('.edit-pencil-btn').forEach(function(btn){
      btn.addEventListener('click', function(){
        var row = btn.closest('.spec-value-row');
        // The card itself is only ~96-128px (sized for a thumbnail), but
        // the edit input alone has a 120px min-width - without this, the
        // Save/Cancel buttons get squeezed out of the card's layout by an
        // input wider than the card, and only Cancel (last, no min-width
        // of its own) ends up visible. Spanning the full grid row while
        // editing gives the input and both buttons room to actually show.
        var card = btn.closest('.logo-history-item');
        if(card) card.classList.add('is-editing');
        row.innerHTML = '<input type="text" class="inline-edit-input" data-field="years" value="'+esc(btn.dataset.current)+'" placeholder="e.g. 1990-1999" style="display:block;margin-bottom:4px;">' +
          '<input type="text" class="inline-edit-input" data-field="note" value="'+esc(btn.dataset.note)+'" placeholder="Note, e.g. 90th Anniversary" style="display:block;margin-bottom:4px;">' +
          '<button class="inline-save-btn" type="button">Save</button>' +
          '<button class="inline-cancel-btn" type="button">Cancel</button>';
        var yearsInput = row.querySelector('[data-field="years"]');
        var noteInput = row.querySelector('[data-field="note"]');
        yearsInput.focus();
        if(yearsInput.select) yearsInput.select();
        row.querySelector('.inline-cancel-btn').addEventListener('click', function(){ refreshLogoHistoryPanel(kind, refId); });
        row.querySelector('.inline-save-btn').addEventListener('click', async function(){
          var newYears = normalizeYearsUsed(yearsInput.value.trim());
          var newNote = noteInput.value.trim();
          var upd = await supabaseClient.from(t.history).update({years_used: newYears || null, note: newNote || null}).eq('id', btn.dataset.logoId);
          if(upd.error){ alert('Error: ' + upd.error.message); return; }
          refreshLogoHistoryPanel(kind, refId);
        });
      });
    });
  }

  function wireInlineEdits(){
    document.querySelectorAll('.edit-pencil-btn').forEach(function(btn){
      btn.addEventListener('click', function(){
        var data = JSON.parse(btn.dataset.edit);
        var row = btn.closest('.spec-value-row');
        row.innerHTML =
          (data.multiline
            ? '<textarea class="inline-edit-input" rows="3">'+esc(data.current)+'</textarea>'
            : '<input type="text" class="inline-edit-input" value="'+esc(data.current)+'">') +
          '<button class="inline-save-btn" type="button">Save</button>' +
          '<button class="inline-cancel-btn" type="button">Cancel</button>';
        var input = row.querySelector('.inline-edit-input');
        input.focus();
        if(input.select) input.select();
        row.querySelector('.inline-cancel-btn').addEventListener('click', function(){ render(); });
        row.querySelector('.inline-save-btn').addEventListener('click', async function(){
          var newVal = input.value.trim();
          var payload = {};
          payload[data.field] = data.numeric ? Number(newVal) : (newVal || null);
          var res = await supabaseClient.from(data.table).update(payload).eq(data.matchCol, data.matchVal);
          if(res.error){ alert('Error: ' + res.error.message); return; }
          render();
        });
      });
    });
  }

  // immediate (true for the jersey's own uploader or an admin adding to
  // a jersey that isn't approved yet) skips the "goes through review"
  // framing, since there's no separate photo-level moderation step in
  // that case - see wireAddPhotosPanel.
  function renderAddPhotosPanel(immediate){
    return '<div class="dropzone" id="ap-dropzone" tabindex="0" role="button" aria-label="Add photos">' +
        ICON_PHOTO +
        '<p>Drop photos here, or click to choose</p>' +
        '<input type="file" id="ap-photos-input" accept="image/*" multiple style="display:none;">' +
      '</div>' +
      '<div class="photo-previews" id="ap-photo-previews"></div>' +
      '<p class="field-error" id="ap-photo-error" hidden>Add at least one photo before submitting.</p>' +
      '<div style="margin-top:14px;"><button class="btn" id="ap-submit-btn" type="button">'+(immediate ? 'Add photos' : 'Submit for review')+'</button></div>' +
      '<div id="ap-result"></div>';
  }

  function wireAddPhotosPanel(jerseyId, immediate){
    var selected = [];
    var compressionPromises = [];
    var dropzone = document.getElementById('ap-dropzone');
    var input = document.getElementById('ap-photos-input');
    var previewsEl = document.getElementById('ap-photo-previews');
    // Fetched once up front (rather than re-fetched per file) purely for
    // readable storage file names — see jerseyPhotoFileName.
    var jerseyInfo = null;
    supabaseClient.from('jerseys').select('season, type, teams(name)').eq('id', jerseyId).single()
      .then(function(res){ if(!res.error) jerseyInfo = res.data; });
    function labelForIndex(i){ return i === 0 ? 'Front' : i === 1 ? 'Back' : 'Other'; }
    function renderPreviews(){
      previewsEl.innerHTML = selected.map(function(p, i){
        return '<div class="photo-preview-item">' +
          '<div class="photo-preview-thumb"><img src="'+p.url+'" alt=""></div>' +
          '<select class="photo-label-select" data-idx="'+i+'">' +
            ['Front','Back','Other'].map(function(l){ return '<option value="'+l+'"'+(p.label===l?' selected':'')+'>'+l+'</option>'; }).join('') +
          '</select>' +
          '<button type="button" class="photo-remove-btn" data-idx="'+i+'" aria-label="Remove photo">✕</button>' +
        '</div>';
      }).join('');
      previewsEl.querySelectorAll('.photo-label-select').forEach(function(sel){
        sel.addEventListener('change', function(){ reassignPhotoLabel(selected, Number(sel.dataset.idx), sel.value); renderPreviews(); });
      });
      previewsEl.querySelectorAll('.photo-remove-btn').forEach(function(btn){
        btn.addEventListener('click', function(){
          URL.revokeObjectURL(selected[Number(btn.dataset.idx)].url);
          selected.splice(Number(btn.dataset.idx), 1);
          renderPreviews();
        });
      });
    }
    function addFiles(fileList){
      var incoming = Array.from(fileList).filter(function(file){ return /^image\//.test(file.type); });
      var room = MAX_UPLOAD_PHOTOS - selected.length;
      if(room > 0){
        incoming.slice(0, room).forEach(function(file){
          var entry = {file: file, label: labelForIndex(selected.length), url: URL.createObjectURL(file)};
          selected.push(entry);
          compressionPromises.push(compressImageForUpload(file).then(function(compressed){ entry.file = compressed; }));
        });
      }
      if(incoming.length > room) alert('A jersey can have up to '+MAX_UPLOAD_PHOTOS+' photos — added '+Math.max(room,0)+' of '+incoming.length+'.');
      renderPreviews();
    }
    dropzone.addEventListener('click', function(){ input.click(); });
    dropzone.addEventListener('keydown', function(e){ if(e.key === 'Enter' || e.key === ' '){ e.preventDefault(); input.click(); } });
    input.addEventListener('change', function(){ addFiles(input.files); input.value = ''; });
    dropzone.addEventListener('dragover', function(e){ e.preventDefault(); dropzone.classList.add('is-dragover'); });
    dropzone.addEventListener('dragleave', function(){ dropzone.classList.remove('is-dragover'); });
    dropzone.addEventListener('drop', function(e){
      e.preventDefault();
      dropzone.classList.remove('is-dragover');
      if(e.dataTransfer && e.dataTransfer.files) addFiles(e.dataTransfer.files);
    });

    document.getElementById('ap-submit-btn').addEventListener('click', async function(){
      var errorEl = document.getElementById('ap-photo-error');
      if(selected.length === 0){ errorEl.hidden = false; return; }
      errorEl.hidden = true;
      var btn = this;
      btn.disabled = true; btn.textContent = 'Submitting…';
      try {
        await Promise.all(compressionPromises);
        for(var i=0; i<selected.length; i++){
          var p = selected[i];
          var ext = (p.file.name.split('.').pop() || 'jpg').toLowerCase();
          var path = jerseyId + '/proposed-' + (jerseyInfo
            ? jerseyPhotoFileName(jerseyInfo.teams.name, jerseyInfo.season, jerseyInfo.type, p.label, i+1, ext)
            : slugify(p.label) + '-' + (i+1) + '-' + Date.now() + '.' + ext);
          var up = await supabaseClient.storage.from('jersey-photos').upload(path, p.file);
          if(up.error) throw up.error;
          var ins = await supabaseClient.from('jersey_images').insert({
            jersey_id: jerseyId, storage_path: path, label: p.label, status: immediate ? 'approved' : 'pending', uploaded_by: currentUser.id
          });
          if(ins.error) throw ins.error;
        }
        document.getElementById('ap-result').innerHTML = immediate
          ? '<p class="field-hint is-match" style="margin-top:10px;">Added.</p>'
          : '<p class="field-hint is-match" style="margin-top:10px;">Submitted for review — thanks!</p>';
        selected.forEach(function(p){ URL.revokeObjectURL(p.url); });
        selected.length = 0;
        compressionPromises.length = 0;
        renderPreviews();
        if(immediate) render();
      } catch(err) {
        document.getElementById('ap-result').innerHTML = errorBox(err);
      } finally {
        btn.disabled = false; btn.textContent = immediate ? 'Add photos' : 'Submit for review';
      }
    });
  }

  function renderProposeLogoPanel(){
    return '<p class="field-hint" style="margin:0 0 12px;">Please use a good quality image &mdash; a clear, full-size logo, not a small thumbnail or favicon. Low-resolution logos may be rejected.</p>' +
      '<div class="dropzone" id="pl-dropzone" tabindex="0" role="button" aria-label="Add a logo">' +
        ICON_PHOTO +
        '<p>Drop a logo image here, or click to choose</p>' +
        '<input type="file" id="pl-logo-input" accept="image/*" style="display:none;">' +
      '</div>' +
      '<div class="photo-previews" id="pl-logo-preview"></div>' +
      '<p class="field-error" id="pl-logo-error" hidden>Choose an image before submitting.</p>' +
      // Optional up front, rather than the only way being to go back and
      // edit it on the page afterward once it's approved - if it's a
      // one-off (an anniversary logo, say) that's going to get swapped
      // back later, this is also the easiest place to leave a note of
      // that for whoever approves it.
      // Two plain year numbers rather than one free-text field - typed
      // years_used has come through as "2016-2025", "2016-25" and just
      // "2016" for the same kind of range, with no way to tell which a
      // given entry meant without reading it carefully. Built back into
      // one consistent "YYYY-YYYY" (or just "YYYY" for a single year)
      // string in wireProposeLogoPanel, so stored data stays one shape
      // regardless of what the form looked like to fill in.
      '<div style="display:flex;gap:12px;flex-wrap:wrap;margin-top:14px;">' +
        '<div class="field" style="flex:1;min-width:120px;"><label for="pl-year-first">First used <small>optional</small></label>' +
          '<input type="number" id="pl-year-first" placeholder="e.g. 2016" min="1850" max="2100"></div>' +
        '<div class="field" style="flex:1;min-width:160px;"><label for="pl-year-last">Last used <small>leave blank if only used for one year</small></label>' +
          '<input type="number" id="pl-year-last" placeholder="e.g. 2025" min="1850" max="2100"></div>' +
      '</div>' +
      '<div class="field" style="margin-top:14px;"><label for="pl-note">Special occasion <small>optional &mdash; e.g. &ldquo;90th Anniversary&rdquo;, worth flagging if this one looks different to the regular logo either side of it</small></label>' +
        '<input type="text" id="pl-note" placeholder="e.g. 90th Anniversary"></div>' +
      '<label style="display:block;margin-top:14px;text-transform:none;letter-spacing:normal;"><input type="checkbox" id="pl-make-current" style="width:auto;margin-right:8px;">Make this the current logo <small>only tick this if it&rsquo;s what the team/competition actually uses right now &mdash; leave it unticked for a past/historical logo, which just adds it to history without changing what&rsquo;s currently shown</small></label>' +
      '<div style="margin-top:14px;"><button class="btn" id="pl-submit-btn" type="button" disabled>'+((currentProfile && currentProfile.is_admin) ? 'Add logo' : 'Submit for review')+'</button></div>' +
      '<div id="pl-result"></div>';
  }

  function wireProposeLogoPanel(kind, refId){
    var proposalTable = kind === 'team' ? 'team_logo_proposals' : 'competition_logo_proposals';
    var refCol = kind === 'team' ? 'team_id' : 'competition_slug';
    var pathPrefix = kind === 'team' ? refId : 'comp-' + refId;
    var picked = null;
    var pickedCompression = null;
    var dropzone = document.getElementById('pl-dropzone');
    var input = document.getElementById('pl-logo-input');
    var previewEl = document.getElementById('pl-logo-preview');
    var submitBtn = document.getElementById('pl-submit-btn');

    function setFile(file){
      if(!file || !/^image\//.test(file.type)) return;
      if(picked) URL.revokeObjectURL(picked.url);
      var entry = {file: file, url: URL.createObjectURL(file)};
      picked = entry;
      pickedCompression = compressImageForUpload(file, LOGO_WEBP_QUALITY).then(function(compressed){ entry.file = compressed; });
      previewEl.innerHTML = '<div class="photo-preview-item"><div class="photo-preview-thumb"><img src="'+picked.url+'" alt=""></div>' +
        '<button type="button" class="photo-remove-btn" id="pl-remove-btn" aria-label="Remove">✕</button></div>';
      document.getElementById('pl-remove-btn').addEventListener('click', function(){
        URL.revokeObjectURL(picked.url); picked = null; previewEl.innerHTML = ''; submitBtn.disabled = true;
      });
      submitBtn.disabled = false;
    }
    dropzone.addEventListener('click', function(){ input.click(); });
    dropzone.addEventListener('keydown', function(e){ if(e.key === 'Enter' || e.key === ' '){ e.preventDefault(); input.click(); } });
    input.addEventListener('change', function(){ setFile(input.files[0]); input.value = ''; });
    dropzone.addEventListener('dragover', function(e){ e.preventDefault(); dropzone.classList.add('is-dragover'); });
    dropzone.addEventListener('dragleave', function(){ dropzone.classList.remove('is-dragover'); });
    dropzone.addEventListener('drop', function(e){
      e.preventDefault();
      dropzone.classList.remove('is-dragover');
      if(e.dataTransfer && e.dataTransfer.files) setFile(e.dataTransfer.files[0]);
    });

    // An admin skips the propose-then-approve-it-yourself round trip
    // entirely - same reasoning as the jersey upload form's "immediate"
    // add-photos path. Lets a moderator swap in a replacement for a
    // low-res logo in one step, then delete the old entry from Logo
    // History, instead of proposing it and switching to Moderate to
    // approve their own submission.
    var isAdmin = currentProfile && currentProfile.is_admin;
    submitBtn.addEventListener('click', async function(){
      var errorEl = document.getElementById('pl-logo-error');
      if(!picked){ errorEl.hidden = false; return; }
      errorEl.hidden = true;
      submitBtn.disabled = true; submitBtn.textContent = isAdmin ? 'Adding…' : 'Submitting…';
      try {
        await pickedCompression;
        var ext = (picked.file.name.split('.').pop() || 'png').toLowerCase();
        var path = pathPrefix + '/logo-' + Date.now() + '.' + ext;
        var up = await supabaseClient.storage.from('team-logos').upload(path, picked.file);
        if(up.error) throw up.error;
        var firstUsed = document.getElementById('pl-year-first').value.trim();
        var lastUsed = document.getElementById('pl-year-last').value.trim();
        var yearsUsed = null;
        if(firstUsed){
          yearsUsed = (lastUsed && Number(lastUsed) > Number(firstUsed)) ? (firstUsed + '-' + lastUsed) : firstUsed;
        }
        var note = document.getElementById('pl-note').value.trim() || null;
        var makeCurrent = document.getElementById('pl-make-current').checked;
        if(isAdmin){
          if(makeCurrent) await setLogo(kind, refId, path, yearsUsed, currentUser.id, note);
          else await addLogoToHistory(kind, refId, path, yearsUsed, currentUser.id, note);
          document.getElementById('pl-result').innerHTML = '<p class="field-hint is-match" style="margin-top:10px;">Added.</p>';
        } else {
          var proposalRow = {storage_path: path, proposed_by: currentUser.id, years_used: yearsUsed, note: note, make_current: makeCurrent};
          proposalRow[refCol] = refId;
          var ins = await supabaseClient.from(proposalTable).insert(proposalRow);
          if(ins.error) throw ins.error;
          document.getElementById('pl-result').innerHTML = '<p class="field-hint is-match" style="margin-top:10px;">Submitted for review — thanks!</p>';
        }
        URL.revokeObjectURL(picked.url);
        picked = null;
        previewEl.innerHTML = '';
        if(isAdmin) render();
      } catch(err) {
        document.getElementById('pl-result').innerHTML = errorBox(err);
      } finally {
        submitBtn.disabled = false; submitBtn.textContent = isAdmin ? 'Add logo' : 'Submit for review';
      }
    });
  }

  function wireModerationActions(){
    var modUserSearchBtn = document.getElementById('mod-user-search-btn');
    if(modUserSearchBtn){
      var modUserSearchInput = document.getElementById('mod-user-search');
      var modUserResults = document.getElementById('mod-user-results');
      async function runModUserSearch(){
        var term = modUserSearchInput.value.trim();
        if(!term){ modUserResults.innerHTML = ''; return; }
        var res = await supabaseClient.from('profiles').select('id, username, is_admin').ilike('username', '%'+term+'%').order('username').limit(10);
        if(res.error){ modUserResults.innerHTML = '<div class="empty-note">Error: '+esc(res.error.message)+'</div>'; return; }
        var rows = res.data || [];
        modUserResults.innerHTML = rows.length ? rows.map(function(p){
          var isSelf = currentUser && p.id === currentUser.id;
          return '<div style="display:flex;align-items:center;justify-content:space-between;gap:10px;padding:9px 0;border-bottom:1px solid var(--line);">' +
            '<span style="display:flex;align-items:center;gap:8px;"><a class="spec-link" href="#/user/'+esc(p.username)+'">'+esc(p.username)+'</a>' +
              (p.is_admin ? '<span class="chip is-active" style="pointer-events:none;padding:2px 8px;">Moderator</span>' : '') + '</span>' +
            (isSelf
              ? '<span class="field-hint">(you)</span>'
              : '<button class="btn btn-secondary" data-user-id="'+p.id+'" data-admin="'+p.is_admin+'" type="button">'+(p.is_admin ? 'Remove moderator' : 'Make moderator')+'</button>') +
          '</div>';
        }).join('') : '<div class="empty-note">No users found.</div>';
        modUserResults.querySelectorAll('button[data-user-id]').forEach(function(btn){
          btn.addEventListener('click', async function(){
            var makeAdmin = btn.dataset.admin !== 'true';
            if(!confirm((makeAdmin ? 'Make' : 'Remove') + ' this user as a moderator?')) return;
            btn.disabled = true;
            var upd = await supabaseClient.from('profiles').update({is_admin: makeAdmin}).eq('id', btn.dataset.userId);
            if(upd.error){ btn.disabled = false; alert('Error: ' + upd.error.message); return; }
            runModUserSearch();
          });
        });
      }
      modUserSearchBtn.addEventListener('click', runModUserSearch);
      modUserSearchInput.addEventListener('keydown', function(e){ if(e.key === 'Enter'){ e.preventDefault(); runModUserSearch(); } });
    }
    var banUserSearchBtn = document.getElementById('ban-user-search-btn');
    if(banUserSearchBtn){
      var banUserSearchInput = document.getElementById('ban-user-search');
      var banUserResults = document.getElementById('ban-user-results');
      async function runBanUserSearch(){
        var term = banUserSearchInput.value.trim();
        if(!term){ banUserResults.innerHTML = ''; return; }
        var res = await supabaseClient.from('profiles').select('id, username, is_admin, is_owner, is_banned').ilike('username', '%'+term+'%').order('username').limit(10);
        if(res.error){ banUserResults.innerHTML = '<div class="empty-note">Error: '+esc(res.error.message)+'</div>'; return; }
        var rows = res.data || [];
        banUserResults.innerHTML = rows.length ? rows.map(function(p){
          var isSelf = currentUser && p.id === currentUser.id;
          // Mirrors the DB-side rule (see user_ban_system.sql) so the
          // button never offers something the server would reject anyway:
          // nobody can ban an owner, and only the owner can ban a fellow
          // admin — a plain admin can ban anyone else.
          var canAct = !isSelf && !p.is_owner && (!p.is_admin || currentProfile.is_owner);
          var badges = (p.is_owner ? ' <span class="chip is-active" style="pointer-events:none;padding:2px 8px;">Owner</span>' : '') +
            (p.is_admin ? ' <span class="chip is-active" style="pointer-events:none;padding:2px 8px;">Moderator</span>' : '') +
            (p.is_banned ? ' <span class="chip is-active" style="pointer-events:none;padding:2px 8px;background:var(--danger);border-color:var(--danger);color:var(--accent-ink);">Banned</span>' : '');
          return '<div style="display:flex;align-items:center;justify-content:space-between;gap:10px;padding:9px 0;border-bottom:1px solid var(--line);">' +
            '<span style="display:flex;align-items:center;gap:8px;"><a class="spec-link" href="#/user/'+esc(p.username)+'">'+esc(p.username)+'</a>'+badges+'</span>' +
            (canAct
              ? '<button class="btn '+(p.is_banned ? 'btn-secondary' : 'btn-reject')+'" data-ban-user-id="'+p.id+'" data-banned="'+p.is_banned+'" type="button">'+(p.is_banned ? 'Unban' : 'Ban')+'</button>'
              : (isSelf ? '<span class="field-hint">(you)</span>' : '')) +
          '</div>';
        }).join('') : '<div class="empty-note">No users found.</div>';
        banUserResults.querySelectorAll('button[data-ban-user-id]').forEach(function(btn){
          btn.addEventListener('click', async function(){
            var willBan = btn.dataset.banned !== 'true';
            if(!confirm((willBan
              ? 'Ban this user? They’ll be blocked from uploading, rating, or proposing logos, but can still browse and sign in.'
              : 'Unban this user?'))) return;
            btn.disabled = true;
            var upd = await supabaseClient.from('profiles').update({is_banned: willBan}).eq('id', btn.dataset.banUserId);
            if(upd.error){ btn.disabled = false; alert('Error: ' + upd.error.message); return; }
            runBanUserSearch();
          });
        });
      }
      banUserSearchBtn.addEventListener('click', runBanUserSearch);
      banUserSearchInput.addEventListener('keydown', function(e){ if(e.key === 'Enter'){ e.preventDefault(); runBanUserSearch(); } });
    }
    document.querySelectorAll('.mod-card').forEach(function(card){
      wirePhotoLabelSwap(card.querySelectorAll('.photo-label-select'));
    });
    document.querySelectorAll('.mod-card .photo-delete-btn').forEach(function(btn){
      btn.addEventListener('click', async function(){
        if(!confirm('Delete this photo? This can\'t be undone.')) return;
        btn.disabled = true;
        var res = await supabaseClient.from('jersey_images').delete().eq('id', btn.dataset.imageId);
        if(res.error){ btn.disabled = false; alert('Error: ' + res.error.message); return; }
        render();
      });
    });
    wireCropButtons(document);
    document.querySelectorAll('.mod-complogo-move-toggle').forEach(function(toggle){
      toggle.addEventListener('click', function(){
        var panel = document.getElementById(toggle.dataset.target);
        if(!panel.dataset.wired){
          panel.dataset.wired = '1';
          panel.hidden = false;
          wireCompetitionMoveControl(toggle.dataset.target, function(){ render(); }, {table:'competition_logo_proposals', matchCol:'id'});
          return;
        }
        panel.hidden = !panel.hidden;
      });
    });
    document.querySelectorAll('.mod-edit-toggle').forEach(function(toggle){
      toggle.addEventListener('click', function(){
        var panel = document.getElementById(toggle.dataset.target);
        if(!panel.dataset.wired){
          panel.dataset.wired = '1';
          panel.hidden = false;
          wireModEditControl(toggle.dataset.target, panel.dataset.jerseyId, panel.dataset.teamId, panel.dataset.sportSlug, function(){ render(); });
          return;
        }
        panel.hidden = !panel.hidden;
      });
    });
    document.querySelectorAll('.mod-reject-toggle').forEach(function(toggle){
      toggle.addEventListener('click', function(){
        var panel = document.getElementById(toggle.dataset.target);
        panel.hidden = !panel.hidden;
      });
    });
    document.querySelectorAll('[data-confirm-reject]').forEach(function(btn){
      btn.addEventListener('click', async function(){
        var id = btn.dataset.confirmReject;
        var msg = document.getElementById('reject-msg-'+id);
        var reason = document.getElementById('reject-reason-'+id).value.trim() || null;
        btn.disabled = true; btn.textContent = 'Rejecting…';
        try {
          // The jersey row itself is kept, not deleted — status flips to
          // 'rejected' with an optional reason so the uploader can see why
          // and fix it, rather than the submission just vanishing with no
          // explanation. The photo FILES are a different story: nobody
          // needs a rejected submission's images still sitting in storage
          // once it's been actioned, so those are actually removed.
          var imgRes = await supabaseClient.from('jersey_images').select('storage_path').eq('jersey_id', id);
          if(imgRes.error) throw imgRes.error;
          var paths = (imgRes.data || []).map(function(r){ return r.storage_path; });
          if(paths.length){
            var rm = await supabaseClient.storage.from('jersey-photos').remove(paths);
            if(rm.error) throw rm.error;
          }
          var delImgs = await supabaseClient.from('jersey_images').delete().eq('jersey_id', id);
          if(delImgs.error) throw delImgs.error;
          var upd = await supabaseClient.from('jerseys').update({status:'rejected', rejection_reason: reason}).eq('id', id);
          if(upd.error) throw upd.error;
        } catch(err){
          btn.disabled = false; btn.textContent = 'Confirm reject';
          msg.hidden = false; msg.className = 'field-error'; msg.textContent = 'Error: ' + (err.message || err);
          return;
        }
        btn.disabled = false; btn.textContent = 'Confirm reject';
        await refreshAuthUI();
        render();
      });
    });
    document.querySelectorAll('.mod-card [data-action]').forEach(function(btn){
      btn.addEventListener('click', async function(){
        var id = btn.dataset.id;
        var type = btn.dataset.type;
        var card = btn.closest('.mod-card');
        var siblingButtons = card.querySelectorAll('button');
        siblingButtons.forEach(function(b){ b.disabled = true; });
        try {
          if(type === 'report'){
            var repRes = await supabaseClient.from('reports').update({status:'resolved'}).eq('id', id);
            if(repRes.error) throw repRes.error;
          } else if(type === 'report-logo'){
            // the attachment lives in report-attachments, but team logos are
            // read from team-logos — move the bytes across buckets rather
            // than just repointing logo_path at the wrong bucket.
            var teamId = btn.dataset.teamId, oldPath = btn.dataset.path;
            var dl = await supabaseClient.storage.from('report-attachments').download(oldPath);
            if(dl.error) throw dl.error;
            var ext = (oldPath.split('.').pop() || 'png').toLowerCase();
            var newPath = teamId + '/logo-' + Date.now() + '.' + ext;
            var moveUp = await supabaseClient.storage.from('team-logos').upload(newPath, dl.data);
            if(moveUp.error) throw moveUp.error;
            await setLogo('team', teamId, newPath, null, btn.dataset.reportedBy || null);
            var repRes2 = await supabaseClient.from('reports').update({status:'resolved'}).eq('id', id);
            if(repRes2.error) throw repRes2.error;
            await supabaseClient.storage.from('report-attachments').remove([oldPath]);
          } else if(type === 'logo' || type === 'comp-logo'){
            var logoKind = type === 'logo' ? 'team' : 'competition';
            var logoProposalTable = type === 'logo' ? 'team_logo_proposals' : 'competition_logo_proposals';
            var logoRefId = type === 'logo' ? btn.dataset.teamId : btn.dataset.compSlug;
            if(btn.dataset.action === 'approve'){
              var makeCurrentCb = document.getElementById(btn.dataset.makeCurrentId);
              var willMakeCurrent = !makeCurrentCb || makeCurrentCb.checked;
              if(!willMakeCurrent) await addLogoToHistory(logoKind, logoRefId, btn.dataset.path, btn.dataset.years || null, btn.dataset.proposedBy || null, btn.dataset.note || null, id);
              else await setLogo(logoKind, logoRefId, btn.dataset.path, btn.dataset.years || null, btn.dataset.proposedBy || null, btn.dataset.note || null, id);
              // status update (not delete) so the award_logo_point trigger
              // fires and the proposer gets their point, same as a jersey.
              var logoApprove = await supabaseClient.from(logoProposalTable).update({status:'approved'}).eq('id', id);
              if(logoApprove.error) throw logoApprove.error;
            } else {
              if(btn.dataset.path){
                var logoRm = await supabaseClient.storage.from('team-logos').remove([btn.dataset.path]);
                if(logoRm.error) throw logoRm.error;
              }
              var logoDel = await supabaseClient.from(logoProposalTable).delete().eq('id', id);
              if(logoDel.error) throw logoDel.error;
            }
          } else if(type === 'photo'){
            if(btn.dataset.action === 'approve'){
              var pr = await supabaseClient.from('jersey_images').update({status:'approved'}).eq('id', id);
              if(pr.error) throw pr.error;
            } else {
              if(btn.dataset.path){
                var prm = await supabaseClient.storage.from('jersey-photos').remove([btn.dataset.path]);
                if(prm.error) throw prm.error;
              }
              var pdel = await supabaseClient.from('jersey_images').delete().eq('id', id);
              if(pdel.error) throw pdel.error;
            }
          } else if(type === 'rejected-jersey'){
            if(!confirm('Permanently delete this rejected jersey? This can\'t be undone.')){
              siblingButtons.forEach(function(b){ b.disabled = false; });
              return;
            }
            var rjdel = await supabaseClient.from('jerseys').delete().eq('id', id);
            if(rjdel.error) throw rjdel.error;
          } else {
            // the only other data-action button on a jersey card is approve —
            // reject is handled separately above via the reason panel, since
            // it needs a reason typed in first rather than firing immediately
            var r = await supabaseClient.from('jerseys').update({status:'approved'}).eq('id', id);
            if(r.error) throw r.error;
          }
          if(card) card.remove();
          await refreshAuthUI();
        } catch(err) {
          alert('Error: ' + (err.message || err));
          siblingButtons.forEach(function(b){ b.disabled = false; });
        }
      });
    });
    var deleteAllRejectedBtn = document.getElementById('delete-all-rejected-btn');
    if(deleteAllRejectedBtn){
      deleteAllRejectedBtn.addEventListener('click', async function(){
        var cards = document.querySelectorAll('.mod-card [data-type="rejected-jersey"]');
        if(!cards.length) return;
        if(!confirm('Permanently delete all '+cards.length+' rejected jerseys shown here? This can\'t be undone.')) return;
        deleteAllRejectedBtn.disabled = true; deleteAllRejectedBtn.textContent = 'Deleting…';
        var ids = [].slice.call(cards).map(function(b){ return b.dataset.id; });
        var res = await supabaseClient.from('jerseys').delete().in('id', ids);
        if(res.error){
          deleteAllRejectedBtn.disabled = false; deleteAllRejectedBtn.textContent = 'Delete all';
          alert('Error: ' + res.error.message);
          return;
        }
        render();
      });
    }
  }

  // Type-to-search front end for a "pick or add new" <select> field (see
  // the comment above syncNewVisibility, below) - the select stays
  // exactly as-is and keeps driving every bit of existing
  // population/event/draft-restore logic untouched; this just layers a
  // search box on top of it. Reads its option list straight off the
  // select itself, and stays in sync with it two ways: a property
  // override on .value catches every direct assignment (draft-restore
  // sets selectEl.value directly, with no 'change' event and, critically,
  // sometimes no actual attribute mutation for a MutationObserver to see
  // either - e.g. setting .hidden to the same value it already had is a
  // silent no-op), while a MutationObserver on childList catches a full
  // innerHTML repopulate (refreshTeams() and friends) choosing a
  // different option as selected.
  function wireComboOverlay(selectEl, wrapId, inputId, panelId, opts){
    var wrap = document.getElementById(wrapId);
    var input = document.getElementById(inputId);
    var panel = document.getElementById(panelId);
    var clearBtn = wrap.querySelector('.combo-clear');
    var newLabel = opts && opts.newLabel;
    var newInputEl = opts && opts.newInputEl;
    var activeIdx = -1;

    function options(){
      return [].slice.call(selectEl.options).filter(function(o){ return o.value && o.value !== '__new__'; })
        .map(function(o){ return {value: o.value, label: o.textContent}; });
    }
    function labelFor(v){
      if(!v) return ''; // keep the field empty so its placeholder hint shows, rather than the blank option's own label text
      var m = [].slice.call(selectEl.options).filter(function(o){ return o.value === v; })[0];
      return m ? m.textContent : '';
    }
    function syncDisplay(){
      input.value = labelFor(selectEl.value);
      if(clearBtn) clearBtn.hidden = !selectEl.value;
    }
    // A required field hidden via the `hidden` attribute or display:none
    // still blocks form submission in this browser - it's NOT exempt from
    // constraint validation just because it can't be seen. The original
    // select-based "+Add new" flow sidestepped this because a required
    // <select> is satisfied by ANY non-empty value, and '__new__' counts;
    // our combo input needs its required-ness toggled explicitly to match.
    function syncVisibility(){
      wrap.hidden = selectEl.hidden;
      if(input.hasAttribute('required')) input.required = !selectEl.hidden;
    }
    function syncAll(){ syncVisibility(); syncDisplay(); }

    // showAll skips filtering by whatever text is currently in the box -
    // used on focus, so clicking into a field that already has a value
    // picked shows every option (to pick something else) rather than
    // filtering down to just that one already-matching value, which is
    // all you'd otherwise ever see without first clearing the field.
    function renderPanel(showAll){
      var q = showAll ? '' : normalizeText(input.value);
      var matches = q ? options().filter(function(o){ return normalizeText(o.label).indexOf(q) > -1; }) : options();
      activeIdx = -1;
      var rows = matches.length
        ? matches.map(function(o,i){ return '<div class="combo-option" data-value="'+esc(o.value)+'" data-i="'+i+'">'+esc(o.label)+'</div>'; }).join('')
        : '<div class="combo-empty">No matches</div>';
      if(newLabel) rows += '<div class="combo-option is-new" data-value="__new__" data-i="'+matches.length+'">'+esc(newLabel)+'</div>';
      panel.innerHTML = rows;
    }
    function openPanel(showAll){ renderPanel(showAll); panel.hidden = false; }
    function closePanel(){ panel.hidden = true; activeIdx = -1; }
    function setActive(i){
      var rows = panel.querySelectorAll('.combo-option');
      for(var k = 0; k < rows.length; k++) rows[k].classList.remove('active');
      activeIdx = i;
      if(i > -1 && rows[i]){ rows[i].classList.add('active'); rows[i].scrollIntoView({block:'nearest'}); }
    }
    function choose(v){
      if(v === '__new__' && newInputEl) newInputEl.value = input.value.trim();
      selectEl.value = v;
      selectEl.dispatchEvent(new Event('change'));
      syncDisplay();
      closePanel();
    }

    input.addEventListener('focus', function(){ openPanel(true); });
    input.addEventListener('input', function(){ openPanel(false); });
    input.addEventListener('keydown', function(e){
      if(panel.hidden){
        if(e.key === 'ArrowDown' || e.key === 'ArrowUp'){ e.preventDefault(); openPanel(true); }
        return;
      }
      var rows = panel.querySelectorAll('.combo-option');
      if(e.key === 'ArrowDown'){ e.preventDefault(); setActive(Math.min(activeIdx + 1, rows.length - 1)); }
      else if(e.key === 'ArrowUp'){ e.preventDefault(); setActive(Math.max(activeIdx - 1, 0)); }
      else if(e.key === 'Enter'){ e.preventDefault(); if(activeIdx > -1 && rows[activeIdx]) choose(rows[activeIdx].dataset.value); }
      else if(e.key === 'Escape'){ syncDisplay(); closePanel(); }
    });
    panel.addEventListener('mousedown', function(e){
      var opt = e.target.closest('.combo-option');
      if(!opt) return;
      e.preventDefault(); // keeps the input focused so this fires instead of a blur closing the panel first
      choose(opt.dataset.value);
    });
    input.addEventListener('blur', function(){
      setTimeout(function(){ syncDisplay(); closePanel(); }, 120);
    });
    document.addEventListener('click', function(e){
      if(!panel.hidden && !wrap.contains(e.target)) closePanel();
    });
    // Clearing the typed text alone doesn't un-pick anything - the real
    // value only changes when an option (or "+ Add new") is chosen, so
    // blurring with the box emptied just snaps the old selection straight
    // back. This gives an explicit way to deliberately unset it instead.
    if(clearBtn){
      clearBtn.addEventListener('mousedown', function(e){
        e.preventDefault(); // keeps the input focused instead of blurring first
        choose('');
        input.focus();
      });
    }

    new MutationObserver(syncAll).observe(selectEl, {attributes: true, attributeFilter: ['hidden']});
    new MutationObserver(syncAll).observe(selectEl, {childList: true});

    // Catches a direct `selectEl.value = x` assignment from elsewhere
    // (draft-restore, reselectAfterSubmit) the instant it happens, rather
    // than hoping a side-effecting attribute change gets observed too.
    var nativeValueProp = Object.getOwnPropertyDescriptor(HTMLSelectElement.prototype, 'value');
    Object.defineProperty(selectEl, 'value', {
      get: function(){ return nativeValueProp.get.call(selectEl); },
      set: function(v){ nativeValueProp.set.call(selectEl, v); syncAll(); },
      configurable: true
    });

    syncAll();
  }

  function wireUploadForm(){
    var form = document.getElementById('upload-form');
    if(!form) return;
    var sportSel = document.getElementById('f-sport');
    var compSelect = document.getElementById('f-comp-select');
    var compInput = document.getElementById('f-comp-input');
    var compNewRow = document.getElementById('f-comp-new-row');
    var compNew = document.getElementById('f-comp-new');
    var teamSelect = document.getElementById('f-team-select');
    var teamInput = document.getElementById('f-team-input');
    var teamNewRow = document.getElementById('f-team-new-row');
    var teamNew = document.getElementById('f-team-new');
    var seasonInput = document.getElementById('f-season');
    var seasonUnknownCheckbox = document.getElementById('f-season-unknown');
    var typeSelect = document.getElementById('f-type-select');
    var typeNewRow = document.getElementById('f-type-new-row');
    var typeNew = document.getElementById('f-type-new');
    var typeSubField = document.getElementById('f-type-sub-field');
    var typeSubSelect = document.getElementById('f-type-sub-select');
    var typeSubNewRow = document.getElementById('f-type-sub-new-row');
    var typeSubNew = document.getElementById('f-type-sub-new');
    var mfrSelect = document.getElementById('f-mfr-select');
    var mfrNewRow = document.getElementById('f-mfr-new-row');
    var mfrNew = document.getElementById('f-mfr-new');
    var formatField = document.getElementById('field-format');
    var formatSel = document.getElementById('f-format');
    var extraCompToggle = document.getElementById('f-extra-comp-toggle');
    var extraCompRow = document.getElementById('f-extra-comp-row');
    var extraCompSel = document.getElementById('f-extra-comp');
    var extraCompNewRow = document.getElementById('f-extra-comp-new-row');
    var extraCompNew = document.getElementById('f-extra-comp-new');

    // Every "pick or add new" field is a <select> (so it looks and behaves
    // like the Sport dropdown) plus a text input that swaps in for it —
    // not sitting below it — when "+ Add a new one…" is chosen, same
    // pattern already used for the admin "move team" competition picker.
    function syncNewVisibility(selectEl, rowEl, newInputEl, requiredWhenNew){
      var isNew = selectEl.value === '__new__';
      selectEl.hidden = isNew;
      rowEl.hidden = !isNew;
      if(requiredWhenNew) newInputEl.required = isNew;
      if(isNew) newInputEl.focus();
    }
    function wireNewCancel(selectEl, rowEl, newInputEl, requiredWhenNew, onCancel){
      rowEl.querySelector('.new-value-cancel').addEventListener('click', function(){
        newInputEl.value = '';
        selectEl.value = '';
        syncNewVisibility(selectEl, rowEl, newInputEl, requiredWhenNew);
        if(onCancel) onCancel();
        saveDraft();
      });
    }
    function fieldValue(selectEl, newInputEl){
      return selectEl.value === '__new__' ? newInputEl.value.trim() : selectEl.value;
    }
    // Only relevant once "Training" is the chosen type — hidden and
    // cleared otherwise so it can't leak a leftover subtype onto a
    // Home/Away/etc. jersey.
    function refreshTypeSubVisibility(){
      var isTraining = typeSelect.value === 'Training';
      typeSubField.hidden = !isTraining;
      if(!isTraining){
        typeSubSelect.value = '';
        syncNewVisibility(typeSubSelect, typeSubNewRow, typeSubNew, false);
      }
    }

    // Text fields survive an unexpected reload (e.g. the browser discarding
    // a backgrounded tab to save memory) — photos can't be restored this
    // way (browsers block scripts from setting file input values), so this
    // only saves the typing, not the attached images.
    var DRAFT_KEY = 'jersey-archive-upload-draft';
    function saveDraft(){
      try {
        sessionStorage.setItem(DRAFT_KEY, JSON.stringify({
          sport: sportSel.value,
          comp: {v: compSelect.value, n: compNew.value},
          team: {v: teamSelect.value, n: teamNew.value},
          season: seasonInput.value,
          type: {v: typeSelect.value, n: typeNew.value},
          typeSub: {v: typeSubSelect.value, n: typeSubNew.value},
          mfr: {v: mfrSelect.value, n: mfrNew.value},
          format: formatSel.value,
          notes: document.getElementById('f-notes').value,
          credit: document.getElementById('f-credit').value
        }));
      } catch(e){}
    }
    function clearDraft(){ try{ sessionStorage.removeItem(DRAFT_KEY); }catch(e){} }
    var restoredDraft = null;
    try { restoredDraft = JSON.parse(sessionStorage.getItem(DRAFT_KEY) || 'null'); } catch(e){}
    if(restoredDraft){
      form.insertAdjacentHTML('afterbegin', '<p class="field-hint is-match" style="margin-bottom:14px;">Restored what you’d typed before the page reloaded &mdash; you’ll need to re-attach any photos.</p>');
    }

    // Photos: a managed array instead of the raw <input>, since a native
    // file input's FileList can't be edited (no removing one file from a
    // multi-select) — we track {file, label, url} ourselves and just use
    // the input to grab newly picked/dropped files.
    var selectedPhotos = [];
    // Compression runs in the background so a photo's preview appears
    // instantly — the actual submit handler awaits these before
    // uploading, so a fast typist hitting submit before compression
    // finishes still gets the compressed version, not the original.
    var photoCompressionPromises = [];
    var dropzone = document.getElementById('photo-dropzone');
    var photosInput = document.getElementById('f-photos-input');
    var previewsEl = document.getElementById('photo-previews');

    function labelForIndex(i){ return i === 0 ? 'Front' : i === 1 ? 'Back' : 'Other'; }
    function renderPhotoPreviews(){
      previewsEl.innerHTML = selectedPhotos.map(function(p, i){
        return '<div class="photo-preview-item">' +
          '<div class="photo-preview-thumb"><img src="'+p.url+'" alt=""></div>' +
          '<select class="photo-label-select" data-idx="'+i+'">' +
            ['Front','Back','Other'].map(function(l){ return '<option value="'+l+'"'+(p.label===l?' selected':'')+'>'+l+'</option>'; }).join('') +
          '</select>' +
          '<button type="button" class="photo-remove-btn" data-idx="'+i+'" aria-label="Remove photo">✕</button>' +
        '</div>';
      }).join('');
      previewsEl.querySelectorAll('.photo-label-select').forEach(function(sel){
        sel.addEventListener('change', function(){ reassignPhotoLabel(selectedPhotos, Number(sel.dataset.idx), sel.value); renderPhotoPreviews(); });
      });
      previewsEl.querySelectorAll('.photo-remove-btn').forEach(function(btn){
        btn.addEventListener('click', function(){
          URL.revokeObjectURL(selectedPhotos[Number(btn.dataset.idx)].url);
          selectedPhotos.splice(Number(btn.dataset.idx), 1);
          renderPhotoPreviews();
        });
      });
    }
    function addPhotoFiles(fileList){
      var incoming = Array.from(fileList).filter(function(file){ return /^image\//.test(file.type); });
      var room = MAX_UPLOAD_PHOTOS - selectedPhotos.length;
      if(room > 0){
        incoming.slice(0, room).forEach(function(file){
          var entry = {file: file, label: labelForIndex(selectedPhotos.length), url: URL.createObjectURL(file)};
          selectedPhotos.push(entry);
          photoCompressionPromises.push(compressImageForUpload(file).then(function(compressed){ entry.file = compressed; }));
        });
      }
      if(incoming.length > room) alert('A jersey can have up to '+MAX_UPLOAD_PHOTOS+' photos — added '+Math.max(room,0)+' of '+incoming.length+'.');
      renderPhotoPreviews();
    }
    dropzone.addEventListener('click', function(){ photosInput.click(); });
    dropzone.addEventListener('keydown', function(e){ if(e.key === 'Enter' || e.key === ' '){ e.preventDefault(); photosInput.click(); } });
    // photosInput is display:none (a real file input can't be styled, so
    // the dropzone stands in for it visually) - a hidden input can't hold
    // focus, so once the native file dialog closes the browser falls
    // back to whatever WAS focused before it opened. If that happened to
    // be a combo field (e.g. Jersey type, picked right before clicking
    // the dropzone), landing focus back on it re-triggers its "focus
    // opens the panel" handler, popping the dropdown back open for no
    // reason the person did. Sending focus to the dropzone itself - a
    // sensible place for it to land after choosing photos anyway - avoids
    // it stopping anywhere that reopens something.
    photosInput.addEventListener('change', function(){
      addPhotoFiles(photosInput.files);
      photosInput.value = '';
      dropzone.focus();
    });
    dropzone.addEventListener('dragover', function(e){ e.preventDefault(); dropzone.classList.add('is-dragover'); });
    dropzone.addEventListener('dragleave', function(){ dropzone.classList.remove('is-dragover'); });
    dropzone.addEventListener('drop', function(e){
      e.preventDefault();
      dropzone.classList.remove('is-dragover');
      if(e.dataTransfer && e.dataTransfer.files) addPhotoFiles(e.dataTransfer.files);
      // Same reopening-dropdown problem as the file-picker path above, and
      // the same fix: a drop doesn't move focus anywhere on its own, so if
      // a combo field (e.g. Jersey type) was focused before the drag
      // started, it's still focused after - sending focus to the dropzone
      // itself avoids it landing somewhere that reopens a panel.
      dropzone.focus();
    });

    // tag_only competitions (FIFA World Cup, Rugby League World Cup, etc.)
    // exist purely so a jersey can be TAGGED onto them via the "also used
    // in another competition" field — they deliberately have no teams of
    // their own, so making one of them the PRIMARY competition would
    // create a stray duplicate team instead of using the country's real
    // International (etc.) roster. Excluded here by default; only the
    // extra-competition picker (which is exactly what they're for) opts
    // back in via includeTagOnly.
    async function competitionsForSport(sportSlug, opts){
      opts = opts || {};
      // Top-tier competitions (the ones actually shown without a "more"
      // click on the site — NRL, Super League, etc.) first since they're
      // what most uploads will actually be, then alphabetical within each
      // group rather than one long A-Z list burying the popular ones.
      var q = supabaseClient.from('competitions').select('*').eq('sport_slug', sportSlug);
      if(!opts.includeTagOnly) q = q.eq('tag_only', false);
      var r = await q.order('tier', {ascending:false}).order('sort_order').order('name');
      if(r.error) throw r.error;
      var comps = r.data || [];
      // A competition with no formats tagged (every sport but cricket
      // today) always shows, format filter or not - only a competition
      // that HAS formats tagged gets narrowed, and only down to the ones
      // that actually include the one picked (an ODI shouldn't be able
      // to pick a T20 league as its competition). "All Formats" is the
      // jersey TYPE field's own catch-all for kit not tied to any one
      // format (training gear, warm-ups) - it was never meant to be a
      // real format tag, and no competition's formats array contains it,
      // so filtering by it literally would wrongly hide every
      // format-tagged competition (International included) instead of
      // showing all of them.
      if(opts.format && opts.format !== 'All Formats') comps = comps.filter(function(c){ return !c.formats || !c.formats.length || c.formats.indexOf(opts.format) > -1; });
      return comps;
    }
    // preserveSelection is only passed true from the format-change handler:
    // an International jersey's Competition/Team should carry over when
    // switching T20I/ODI/Test between uploads for the same team, since
    // International is tagged with all of them anyway. A sport switch or a
    // manual competition pick still resets to blank as before - those
    // really are a different competition/team list.
    async function refreshComps(preserveSelection){
      var formatVal = FORMATS_BY_SPORT[sportSel.value] ? formatSel.value : '';
      var prevComp = preserveSelection ? compSelect.value : '';
      var comps = await competitionsForSport(sportSel.value, {format: formatVal || undefined});
      var prevCompValid = !!prevComp && prevComp !== '__new__' && comps.some(function(c){ return c.name.toLowerCase() === prevComp.toLowerCase(); });
      compSelect.innerHTML = '<option value="">Select a competition</option>' +
        comps.map(function(c){ return '<option value="'+esc(c.name)+'">'+esc(c.name)+'</option>'; }).join('') +
        '<option value="__new__">+ Add a new competition…</option>';
      compSelect.hidden = false; compNewRow.hidden = true; compNew.value = ''; compNew.required = false;
      if(prevCompValid) compSelect.value = prevComp;
      await refreshTeams(prevCompValid);
      await refreshExtraComps();
    }
    async function refreshTeams(preserveSelection){
      var alsoSeeHint = document.getElementById('f-team-also-see-hint');
      if(alsoSeeHint) alsoSeeHint.hidden = true;
      var val = compSelect.value;
      var prevTeam = preserveSelection ? teamSelect.value : '';
      if(!val){
        teamSelect.innerHTML = '<option value="">Select a competition first</option>';
        teamSelect.hidden = false; teamNewRow.hidden = true; teamNew.required = false;
        return;
      }
      if(val === '__new__'){
        teamSelect.innerHTML = '<option value="__new__" selected>+ Add a new team…</option>';
        teamSelect.hidden = true; teamNewRow.hidden = false; teamNew.required = true;
        return;
      }
      var comps = await competitionsForSport(sportSel.value);
      var comp = comps.filter(function(c){ return c.name.toLowerCase() === val.toLowerCase(); })[0];
      if(!comp){ teamSelect.innerHTML = '<option value="">Select a competition first</option>'; return; }
      var r = await supabaseClient.from('teams').select('name').eq('competition_slug', comp.slug).order('name');
      var teams = r.data || [];
      teamSelect.innerHTML = '<option value="">Select a team</option>' +
        teams.map(function(t){ return '<option value="'+esc(t.name)+'">'+esc(t.name)+'</option>'; }).join('') +
        '<option value="__new__">+ Add a new team…</option>';
      teamSelect.hidden = false; teamNewRow.hidden = true; teamNew.value = ''; teamNew.required = false;
      if(prevTeam && prevTeam !== '__new__' && teams.some(function(t){ return t.name.toLowerCase() === prevTeam.toLowerCase(); })) teamSelect.value = prevTeam;
    }
    // Warns when the picked team also has a row under another
    // competition in the same sport (Penrith Panthers exists under both
    // NRL and ARL, say) — an old jersey is easy to file under today's
    // big obvious competition out of habit instead of the season-correct
    // historical one, and nothing else on the form flags that. Skipped
    // for "+ Add a new team…", since a brand new team can't have a
    // sibling yet.
    async function checkTeamAlsoSee(){
      var hintEl = document.getElementById('f-team-also-see-hint');
      if(!hintEl) return;
      var teamName = teamSelect.value;
      if(!teamName || teamName === '__new__'){ hintEl.hidden = true; return; }
      var comps = await competitionsForSport(sportSel.value);
      var comp = comps.filter(function(c){ return c.name.toLowerCase() === compSelect.value.toLowerCase(); })[0];
      if(!comp){ hintEl.hidden = true; return; }
      var normalized = normalizeTeamName(teamName).toLowerCase();
      var res = await supabaseClient.from('teams').select('name, competition_slug, competitions!inner(name, sport_slug)')
        .eq('competitions.sport_slug', sportSel.value).neq('competition_slug', comp.slug)
        .ilike('name', normalizeTeamName(teamName) + '%');
      var siblings = (res.error ? [] : res.data || []).filter(function(t){ return normalizeTeamName(t.name).toLowerCase() === normalized; });
      if(!siblings.length){ hintEl.hidden = true; return; }
      var names = siblings.map(function(t){ return t.competitions.name; }).filter(function(n, i, arr){ return arr.indexOf(n) === i; });
      hintEl.hidden = false;
      hintEl.textContent = '"'+teamName+'" also has a row under '+names.join(', ')+' — double check this is the season/era-correct competition for this jersey.';
    }
    // Flags a likely duplicate before it's submitted — same team, same
    // season, same jersey type (and, for sports with a format field like
    // cricket, same format — a Test and a T20I home kit are two different
    // jerseys, not a duplicate of each other) already logged, and not
    // rejected. RLS means this can only ever see an approved jersey or one
    // of the current user's own, which is fine: those are exactly the
    // cases where a "didn't realise this was already here" duplicate
    // happens.
    async function checkDuplicateJersey(){
      var hintEl = document.getElementById('f-duplicate-hint');
      if(!hintEl) return;
      var teamName = teamSelect.value;
      var seasonVal = seasonInput.value.trim();
      var typeVal = fieldValue(typeSelect, typeNew);
      if(!teamName || teamName === '__new__' || !seasonVal || !typeVal){ hintEl.hidden = true; return; }
      if(typeVal === 'Training'){
        var typeSub = fieldValue(typeSubSelect, typeSubNew);
        if(typeSub) typeVal = composeTrainingType(typeSub);
      }
      var formatVal = FORMATS_BY_SPORT[sportSel.value] ? formatSel.value : '';
      var comps = await competitionsForSport(sportSel.value);
      var comp = comps.filter(function(c){ return c.name.toLowerCase() === compSelect.value.toLowerCase(); })[0];
      if(!comp){ hintEl.hidden = true; return; }
      var teamRes = await supabaseClient.from('teams').select('id').eq('competition_slug', comp.slug).eq('slug', slugify(teamName)).maybeSingle();
      if(teamRes.error || !teamRes.data){ hintEl.hidden = true; return; }
      var query = supabaseClient.from('jerseys').select('id, status').eq('team_id', teamRes.data.id).eq('season', seasonVal).eq('type', typeVal).neq('status', 'rejected');
      if(formatVal) query = query.eq('format', formatVal);
      var res = await query.limit(1);
      if(res.error || !res.data || !res.data.length){ hintEl.hidden = true; return; }
      hintEl.hidden = false;
      hintEl.innerHTML = 'Looks like this team already has a <a class="spec-link" href="#/jersey/'+res.data[0].id+'" target="_blank" rel="noopener">'+esc(seasonVal)+' '+esc(typeVal)+(formatVal ? ' ('+esc(formatVal)+')' : '')+'</a> logged &mdash; please double check this isn&rsquo;t a duplicate before submitting.';
    }
    // One optional extra competition in the same sport (the primary one
    // picked above is excluded — that's set via the Competition field,
    // not here). Keeps whatever was already picked when re-rendered.
    async function refreshExtraComps(){
      var comps = await competitionsForSport(sportSel.value, {includeTagOnly: true});
      var primaryVal = compSelect.value.toLowerCase();
      var others = comps.filter(function(c){ return c.name.toLowerCase() !== primaryVal; });
      var prevValue = extraCompSel.value;
      extraCompSel.innerHTML = '<option value="">Select a competition</option>' +
        others.map(function(c){ return '<option value="'+esc(c.slug)+'"'+(c.slug===prevValue?' selected':'')+'>'+esc(c.name)+'</option>'; }).join('') +
        '<option value="__new__">+ Add a new competition&hellip;</option>';
      syncNewVisibility(extraCompSel, extraCompNewRow, extraCompNew, false);
    }
    // After a successful upload: re-list competitions/teams (in case one
    // was just created via "+ Add a new one…") and select the one just
    // used, rather than resetting to blank like refreshComps/refreshTeams
    // would — the whole point is to keep it selected for the next upload.
    async function reselectAfterSubmit(compName, teamName){
      var formatVal = FORMATS_BY_SPORT[sportSel.value] ? formatSel.value : '';
      var comps = await competitionsForSport(sportSel.value, {format: formatVal || undefined});
      compSelect.innerHTML = '<option value="">Select a competition</option>' +
        comps.map(function(c){ return '<option value="'+esc(c.name)+'"'+(c.name===compName?' selected':'')+'>'+esc(c.name)+'</option>'; }).join('') +
        '<option value="__new__">+ Add a new competition…</option>';
      compSelect.hidden = false; compNewRow.hidden = true; compNew.value = ''; compNew.required = false;

      var comp = comps.filter(function(c){ return c.name.toLowerCase() === compName.toLowerCase(); })[0];
      var teams = [];
      if(comp){
        var r = await supabaseClient.from('teams').select('name').eq('competition_slug', comp.slug).order('name');
        teams = r.data || [];
      }
      teamSelect.innerHTML = '<option value="">Select a team</option>' +
        teams.map(function(t){ return '<option value="'+esc(t.name)+'"'+(t.name===teamName?' selected':'')+'>'+esc(t.name)+'</option>'; }).join('') +
        '<option value="__new__">+ Add a new team…</option>';
      teamSelect.hidden = false; teamNewRow.hidden = true; teamNew.value = ''; teamNew.required = false;
      extraCompToggle.checked = false;
      extraCompRow.hidden = true;
      extraCompSel.value = '';
      await refreshExtraComps();
    }
    function refreshFormat(preferredValue){
      var formats = FORMATS_BY_SPORT[sportSel.value];
      formatField.hidden = !formats;
      formatSel.required = !!formats;
      // A real blank option, not just "whatever's listed first" - without
      // this, rebuilding the list left Test silently selected on its own
      // (nothing had explicitly chosen it), which looked exactly like a
      // leftover value from a previous upload even on a first visit.
      formatSel.innerHTML = formats
        ? '<option value="" disabled selected>Select a format&hellip;</option>' + formats.map(function(f){ return '<option>'+f+'</option>'; }).join('')
        : '';
      if(formats && preferredValue && formats.indexOf(preferredValue) > -1) formatSel.value = preferredValue;
    }
    function refreshPlaceholders(){
      teamInput.placeholder = TEAM_PLACEHOLDER_BY_SPORT[sportSel.value] || DEFAULT_TEAM_PLACEHOLDER;
      compInput.placeholder = COMPETITION_PLACEHOLDER_BY_SPORT[sportSel.value] || DEFAULT_COMPETITION_PLACEHOLDER;
    }

    // Counts how often each value of `field` (manufacturer/type) shows up
    // among approved jerseys in the given sport, so the dropdown can put
    // what's actually common in that sport ahead of the long tail — the
    // whole reason "iAthletic" (a basketball brand) shouldn't lead the
    // list on a rugby league upload.
    async function usageCounts(field, sportSlug){
      var comps = await competitionsForSport(sportSlug);
      var compSlugs = comps.map(function(c){ return c.slug; });
      if(!compSlugs.length) return {};
      var res = await supabaseClient.from('jerseys').select(field+', teams!inner(*)').eq('status', 'approved').in('teams.competition_slug', compSlugs);
      var counts = {};
      (res.data || []).forEach(function(r){
        var v = (r[field] || '').toString().trim();
        if(v) counts[v] = (counts[v] || 0) + 1;
      });
      return counts;
    }
    // Every manufacturer ever used on the site, any sport — fetched once
    // per form load and cached, so it's cheap to fall back to for "already
    // in the system somewhere, just not this sport yet" brands.
    var globalMfrListCache = null;
    async function getGlobalManufacturers(){
      if(globalMfrListCache) return globalMfrListCache;
      var rows = await fetchAllRows('jerseys', 'manufacturer', function(q){ return q.eq('status', 'approved'); });
      var seen = {};
      rows.forEach(function(r){
        var v = (r.manufacturer || '').toString().trim();
        if(v) seen[v] = true;
      });
      globalMfrListCache = Object.keys(seen);
      return globalMfrListCache;
    }
    async function refreshMfrTypeOptions(){
      var sportSlug = sportSel.value;
      var typeCounts = await usageCounts('type', sportSlug);
      var mfrCounts = await usageCounts('manufacturer', sportSlug);
      var globalMfrs = await getGlobalManufacturers();

      var curatedTypes = (CURATED_TYPES_OVERRIDE_BY_SPORT[sportSlug] || CURATED_TYPES_BASE.concat(EXTRA_TYPES_BY_SPORT[sportSlug] || []))
        .concat(['Training']);
      // Any already-used value outside the curated list normally gets its
      // own entry here so it's quick to reselect — but every training
      // variant (Training 2, Training - Pre-match, etc.) is already
      // reachable via "Training" + the subtype field below, so listing it
      // again up here would just be the same option twice.
      var typeExtra = Object.keys(typeCounts).filter(function(t){
        return curatedTypes.indexOf(t) === -1 && baseJerseyType(t).toLowerCase() !== 'training';
      }).sort();
      typeSelect.innerHTML = '<option value="">Select a type</option>' +
        curatedTypes.concat(typeExtra).map(function(t){ return '<option value="'+esc(t)+'">'+esc(t)+'</option>'; }).join('') +
        '<option value="__new__">+ Add a new one…</option>';
      typeSelect.hidden = false; typeNewRow.hidden = true; typeNew.value = ''; typeNew.required = false;
      refreshTypeSubVisibility();

      // Priority brands first, then everything else already used in this
      // sport (alphabetical, so a freshly-approved manufacturer takes its
      // proper place next time the form loads instead of just tacking
      // onto the end), then everything else already used ANYWHERE on the
      // site (also alphabetical) so a brand added for one sport doesn't
      // look "new" again just because this is its first time in a
      // different sport.
      var mfrExtra = Object.keys(mfrCounts).filter(function(m){ return PRIORITY_MANUFACTURERS.indexOf(m) === -1; }).sort();
      var listedSoFar = {};
      PRIORITY_MANUFACTURERS.concat(mfrExtra).forEach(function(m){ listedSoFar[m] = true; });
      var mfrRest = globalMfrs.filter(function(m){ return !listedSoFar[m]; }).sort();
      // Required, with "Unknown" as an explicit, real option — the old
      // blank/"Unlisted" default made it too easy to click straight past
      // this field without thinking about it, which meant a lot of
      // well-known-brand jerseys were going up with no manufacturer
      // logged at all. "Unknown" is still there for the genuinely
      // unidentifiable older jerseys; it just has to be a deliberate pick.
      mfrSelect.innerHTML = '<option value="" disabled selected>Select a manufacturer&hellip;</option>' +
        '<option value="Unknown">Unknown</option>' +
        PRIORITY_MANUFACTURERS.concat(mfrExtra).concat(mfrRest).map(function(m){ return '<option value="'+esc(m)+'">'+esc(m)+'</option>'; }).join('') +
        '<option value="__new__">+ Add a new one…</option>';
      mfrSelect.required = true;
      mfrSelect.hidden = false; mfrNewRow.hidden = true; mfrNew.value = ''; mfrNew.required = false;
    }

    // Competition/Team/Jersey type/Manufacturer already rebuild themselves
    // blank on a sport switch (refreshComps/refreshMfrTypeOptions). Season
    // is free text, so nothing else ever clears it - left alone, a cricket
    // Test season like "2025-26" would carry straight into a football
    // upload. The hints are specific to the team/comp/season/format combo
    // that's about to change, so they'd otherwise sit there stale too.
    sportSel.addEventListener('change', function(){
      // Format first - refreshComps reads formatSel.value to filter the
      // competition list, so it needs the new sport's (blank) format
      // already in place rather than the previous sport's leftover one.
      refreshFormat(); refreshComps(); refreshMfrTypeOptions(); refreshPlaceholders();
      seasonUnknownCheckbox.checked = false;
      applySeasonUnknownState();
      var alsoSeeHint = document.getElementById('f-team-also-see-hint');
      if(alsoSeeHint) alsoSeeHint.hidden = true;
      var dupHint = document.getElementById('f-duplicate-hint');
      if(dupHint) dupHint.hidden = true;
      saveDraft();
    });
    compSelect.addEventListener('change', function(){ syncNewVisibility(compSelect, compNewRow, compNew, true); refreshTeams(); refreshExtraComps(); saveDraft(); });
    teamSelect.addEventListener('change', function(){ syncNewVisibility(teamSelect, teamNewRow, teamNew, true); checkTeamAlsoSee(); checkDuplicateJersey(); saveDraft(); });
    typeSelect.addEventListener('change', function(){ syncNewVisibility(typeSelect, typeNewRow, typeNew, true); refreshTypeSubVisibility(); checkDuplicateJersey(); saveDraft(); });
    typeSubSelect.addEventListener('change', function(){ syncNewVisibility(typeSubSelect, typeSubNewRow, typeSubNew, false); checkDuplicateJersey(); saveDraft(); });
    seasonInput.addEventListener('input', checkDuplicateJersey);
    // Checking this sets the season to the literal string "Unknown"
    // rather than leaving the field blank, so an uploader who genuinely
    // doesn't know the year isn't tempted to guess one that might be
    // wrong and go unnoticed - it sorts to the very top everywhere
    // (see seasonSortKey) so it's easy for a moderator to spot and
    // investigate, and reads fine wherever a season is shown as plain
    // text (e.g. "Unknown · Home").
    function applySeasonUnknownState(){
      if(seasonUnknownCheckbox.checked){
        seasonInput.value = 'Unknown';
        seasonInput.disabled = true;
        seasonInput.required = false;
      } else {
        if(seasonInput.value === 'Unknown') seasonInput.value = '';
        seasonInput.disabled = false;
        seasonInput.required = true;
      }
    }
    seasonUnknownCheckbox.addEventListener('change', function(){
      applySeasonUnknownState();
      checkDuplicateJersey();
      saveDraft();
    });
    typeNew.addEventListener('input', checkDuplicateJersey);
    typeSubNew.addEventListener('input', checkDuplicateJersey);
    mfrSelect.addEventListener('change', function(){ syncNewVisibility(mfrSelect, mfrNewRow, mfrNew, true); saveDraft(); });
    // Changing the format re-filters which competitions are offered (an
    // ODI shouldn't be able to pick a T20 league), but International
    // itself is tagged with every format - so a Competition/Team already
    // picked (e.g. International/Australia) should carry over to the next
    // format instead of being wiped, since it's almost always still valid.
    formatSel.addEventListener('change', function(){ refreshComps(true); checkDuplicateJersey(); saveDraft(); });
    extraCompToggle.addEventListener('change', function(){
      extraCompRow.hidden = !extraCompToggle.checked;
      if(!extraCompToggle.checked){
        extraCompSel.value = '';
        syncNewVisibility(extraCompSel, extraCompNewRow, extraCompNew, false);
      }
      saveDraft();
    });
    extraCompSel.addEventListener('change', function(){ syncNewVisibility(extraCompSel, extraCompNewRow, extraCompNew, false); saveDraft(); });
    wireNewCancel(compSelect, compNewRow, compNew, true, refreshTeams);
    wireComboOverlay(compSelect, 'f-comp-combo-wrap', 'f-comp-input', 'f-comp-panel', {newLabel: '+ Add a new competition…', newInputEl: compNew});
    wireNewCancel(teamSelect, teamNewRow, teamNew, true);
    // Team gets its own overlay instead of the generic wireComboOverlay -
    // every other combo field searches a fixed, already-loaded option
    // list, but with no competition picked yet, Team needs to search
    // EVERY team in the sport, so someone who knows the club but not its
    // competition ("South Melbourne" - which league is that again?) can
    // find it and have Competition fill itself in. Once a competition
    // IS picked, though, this scopes strictly to that competition's own
    // teams - same as every other competition's team picker - rather
    // than mixing in matches from elsewhere in the sport.
    (function wireTeamComboOverlay(){
      var wrap = document.getElementById('f-team-combo-wrap');
      var panel = document.getElementById('f-team-panel');
      var clearBtn = wrap.querySelector('.combo-clear');
      var MIN_SPORT_CHARS = 2;
      var activeIdx = -1;
      var sportTeamsSlug = null, sportTeamsPromise = null;

      function loadSportTeams(){
        var sportSlug = sportSel.value;
        if(sportTeamsSlug !== sportSlug){
          sportTeamsSlug = sportSlug;
          sportTeamsPromise = supabaseClient.from('teams')
            .select('name, competition_slug, competitions!inner(name, sport_slug)')
            .eq('competitions.sport_slug', sportSlug).order('name')
            .then(function(r){ return r.data || []; })
            .catch(function(){ sportTeamsSlug = null; return []; });
        }
        return sportTeamsPromise;
      }
      function inCompOptions(){
        return [].slice.call(teamSelect.options).filter(function(o){ return o.value && o.value !== '__new__'; })
          .map(function(o){ return {name: o.value, label: o.textContent}; });
      }
      function labelFor(v){
        if(!v) return '';
        var m = [].slice.call(teamSelect.options).filter(function(o){ return o.value === v; })[0];
        return m ? m.textContent : '';
      }
      function syncDisplay(){
        teamInput.value = labelFor(teamSelect.value);
        if(clearBtn) clearBtn.hidden = !teamSelect.value;
      }
      function syncVisibility(){
        wrap.hidden = teamSelect.hidden;
        if(teamInput.hasAttribute('required')) teamInput.required = !teamSelect.hidden;
      }
      function syncAll(){ syncVisibility(); syncDisplay(); }

      async function renderPanel(showAll){
        var raw = showAll ? '' : teamInput.value;
        var q = normalizeText(raw);
        var hasComp = !!compSelect.value && compSelect.value !== '__new__';
        var rows = [];
        if(hasComp){
          // Competition already chosen - scope strictly to its own teams
          // (shown in full, no fetch and no 10-item cap, so a big roster
          // like A-League's isn't cropped before the user can scroll).
          inCompOptions().filter(function(o){ return !q || normalizeText(o.label).indexOf(q) > -1; })
            .forEach(function(o){ rows.push({name: o.name, comp: compSelect.value, html: esc(o.label)}); });
        } else if(q.length >= MIN_SPORT_CHARS){
          // No competition picked yet - search every team in the sport instead.
          var teams = await loadSportTeams();
          if(!showAll && normalizeText(teamInput.value) !== q) return; // query moved on while that fetch was in flight
          teams.filter(function(t){ return normalizeText(t.name).indexOf(q) > -1; })
            .forEach(function(t){
              var compName = t.competitions.name;
              rows.push({name: t.name, comp: compName, html: esc(t.name)+' <span class="meta">&middot; '+esc(compName)+'</span>'});
            });
          rows = rows.slice(0, 10);
        } else if(!showAll && normalizeText(teamInput.value) !== q) return;

        activeIdx = -1;
        var html = rows.length
          ? rows.map(function(r, i){ return '<div class="combo-option search-suggest-row" data-i="'+i+'" data-name="'+esc(r.name)+'" data-comp="'+esc(r.comp)+'"><span>'+r.html+'</span></div>'; }).join('')
          : (hasComp || q.length >= MIN_SPORT_CHARS
              ? '<div class="combo-empty">No matches'+(hasComp ? '' : ' - pick a competition above to add a brand new team')+'</div>'
              : '<div class="combo-empty">Type at least '+MIN_SPORT_CHARS+' letters to search every team in this sport, or pick a competition above first</div>');
        if(hasComp) html += '<div class="combo-option is-new" data-i="'+rows.length+'" data-new="1">+ Add a new team&hellip;</div>';
        panel.innerHTML = html;
      }
      function openPanel(showAll){ renderPanel(showAll); panel.hidden = false; }
      function closePanel(){ panel.hidden = true; activeIdx = -1; }
      function setActive(i){
        var opts = panel.querySelectorAll('.combo-option');
        for(var k = 0; k < opts.length; k++) opts[k].classList.remove('active');
        activeIdx = i;
        if(i > -1 && opts[i]){ opts[i].classList.add('active'); opts[i].scrollIntoView({block:'nearest'}); }
      }
      async function choose(el){
        if(el.dataset.new){
          teamNew.value = teamInput.value.trim();
          teamSelect.value = '__new__';
        } else {
          var compName = el.dataset.comp;
          if(compName && compName.toLowerCase() !== compSelect.value.toLowerCase()){
            compSelect.value = compName;
            syncNewVisibility(compSelect, compNewRow, compNew, true);
            await refreshTeams();
            await refreshExtraComps();
          }
          teamSelect.value = el.dataset.name;
        }
        syncNewVisibility(teamSelect, teamNewRow, teamNew, true);
        checkTeamAlsoSee();
        checkDuplicateJersey();
        syncDisplay();
        closePanel();
        saveDraft();
      }

      teamInput.addEventListener('focus', function(){ openPanel(true); });
      teamInput.addEventListener('input', function(){ openPanel(false); });
      teamInput.addEventListener('keydown', function(e){
        if(panel.hidden){
          if(e.key === 'ArrowDown' || e.key === 'ArrowUp'){ e.preventDefault(); openPanel(true); }
          return;
        }
        var opts = panel.querySelectorAll('.combo-option');
        if(e.key === 'ArrowDown'){ e.preventDefault(); setActive(Math.min(activeIdx + 1, opts.length - 1)); }
        else if(e.key === 'ArrowUp'){ e.preventDefault(); setActive(Math.max(activeIdx - 1, 0)); }
        else if(e.key === 'Enter'){ e.preventDefault(); if(activeIdx > -1 && opts[activeIdx]) choose(opts[activeIdx]); }
        else if(e.key === 'Escape'){ syncDisplay(); closePanel(); }
      });
      panel.addEventListener('mousedown', function(e){
        var opt = e.target.closest('.combo-option');
        if(!opt || !opt.dataset) return;
        e.preventDefault();
        choose(opt);
      });
      teamInput.addEventListener('blur', function(){
        setTimeout(function(){ syncDisplay(); closePanel(); }, 120);
      });
      document.addEventListener('click', function(e){
        if(!panel.hidden && !wrap.contains(e.target)) closePanel();
      });
      if(clearBtn){
        clearBtn.addEventListener('mousedown', function(e){
          e.preventDefault();
          teamSelect.value = '';
          syncNewVisibility(teamSelect, teamNewRow, teamNew, true);
          checkTeamAlsoSee();
          checkDuplicateJersey();
          syncDisplay();
          closePanel();
          saveDraft();
          teamInput.focus();
        });
      }

      new MutationObserver(syncAll).observe(teamSelect, {attributes: true, attributeFilter: ['hidden']});
      new MutationObserver(syncAll).observe(teamSelect, {childList: true});
      var nativeValueProp = Object.getOwnPropertyDescriptor(HTMLSelectElement.prototype, 'value');
      Object.defineProperty(teamSelect, 'value', {
        get: function(){ return nativeValueProp.get.call(teamSelect); },
        set: function(v){ nativeValueProp.set.call(teamSelect, v); syncAll(); },
        configurable: true
      });
      syncAll();
    })();
    wireNewCancel(typeSelect, typeNewRow, typeNew, true);
    wireComboOverlay(typeSelect, 'f-type-combo-wrap', 'f-type-input', 'f-type-panel', {newLabel: '+ Add a new jersey type…', newInputEl: typeNew});
    wireNewCancel(typeSubSelect, typeSubNewRow, typeSubNew, false);
    wireNewCancel(mfrSelect, mfrNewRow, mfrNew, true);
    wireComboOverlay(mfrSelect, 'f-mfr-combo-wrap', 'f-mfr-input', 'f-mfr-panel', {newLabel: '+ Add a new manufacturer…', newInputEl: mfrNew});
    wireNewCancel(extraCompSel, extraCompNewRow, extraCompNew, false);
    [compNew, teamNew, seasonInput, typeNew, typeSubNew, mfrNew, extraCompNew, document.getElementById('f-notes'), document.getElementById('f-credit')].forEach(function(el){
      el.addEventListener('input', saveDraft);
      el.addEventListener('change', saveDraft);
    });

    (async function init(){
      if(restoredDraft && restoredDraft.sport) sportSel.value = restoredDraft.sport;
      // Format before the first refreshComps - it reads formatSel.value
      // to filter the competition list, so a restored format needs to be
      // in place before that first fetch, not applied to it after.
      refreshFormat(restoredDraft && restoredDraft.format);
      await refreshComps();
      refreshPlaceholders();
      await refreshMfrTypeOptions();
      if(restoredDraft){
        if(restoredDraft.comp){
          compSelect.value = restoredDraft.comp.v || '';
          syncNewVisibility(compSelect, compNewRow, compNew, true);
          compNew.value = restoredDraft.comp.n || '';
          await refreshTeams();
        }
        if(restoredDraft.team){
          teamSelect.value = restoredDraft.team.v || '';
          syncNewVisibility(teamSelect, teamNewRow, teamNew, true);
          teamNew.value = restoredDraft.team.n || '';
          checkTeamAlsoSee();
        }
        if(restoredDraft.season){
          seasonInput.value = restoredDraft.season;
          seasonUnknownCheckbox.checked = restoredDraft.season === 'Unknown';
          applySeasonUnknownState();
        }
        if(restoredDraft.type){
          typeSelect.value = restoredDraft.type.v || '';
          syncNewVisibility(typeSelect, typeNewRow, typeNew, true);
          typeNew.value = restoredDraft.type.n || '';
          refreshTypeSubVisibility();
        }
        if(restoredDraft.typeSub){
          typeSubSelect.value = restoredDraft.typeSub.v || '';
          syncNewVisibility(typeSubSelect, typeSubNewRow, typeSubNew, false);
          typeSubNew.value = restoredDraft.typeSub.n || '';
        }
        checkDuplicateJersey();
        if(restoredDraft.mfr){
          mfrSelect.value = restoredDraft.mfr.v || '';
          syncNewVisibility(mfrSelect, mfrNewRow, mfrNew, true);
          mfrNew.value = restoredDraft.mfr.n || '';
        }
        if(restoredDraft.notes) document.getElementById('f-notes').value = restoredDraft.notes;
        if(restoredDraft.credit) document.getElementById('f-credit').value = restoredDraft.credit;
      }
    })();

    form.addEventListener('submit', async function(e){
      e.preventDefault();
      if(!form.reportValidity()) return;

      var seasonVal = seasonInput.value.trim();
      if(!seasonUnknownCheckbox.checked && !/^\d{4}(-\d{2})?$/.test(seasonVal)){
        // A slash instead of a dash (2026/27) is by far the most common
        // slip — call it out specifically rather than just the generic
        // format message, since "invalid" alone doesn't tell you what
        // to fix.
        var slashMatch = seasonVal.match(/^(\d{4})\s*\/\s*(\d{2,4})$/);
        seasonInput.setCustomValidity(slashMatch
          ? 'Use a dash, not a slash — e.g. '+slashMatch[1]+'-'+slashMatch[2].slice(-2)+', not '+seasonVal+'.'
          : 'Enter a year (e.g. 2024) or a split-year season (e.g. 2024-25)');
        seasonInput.reportValidity();
        seasonInput.addEventListener('input', function clear(){ seasonInput.setCustomValidity(''); seasonInput.removeEventListener('input', clear); });
        return;
      }
      seasonInput.setCustomValidity('');

      var photoError = document.getElementById('photo-error');
      if(selectedPhotos.length === 0){
        photoError.hidden = false;
        document.getElementById('field-photos').scrollIntoView({behavior:'smooth', block:'center'});
        return;
      }
      photoError.hidden = true;

      var submitBtn = document.getElementById('upload-submit-btn');
      submitBtn.disabled = true; submitBtn.textContent = 'Uploading…';

      try {
        var sportSlug = sportSel.value;
        var comp = await ensureCompetition(sportSlug, fieldValue(compSelect, compNew));
        var team = await ensureTeam(comp.slug, fieldValue(teamSelect, teamNew));
        var season = seasonVal;
        var type = fieldValue(typeSelect, typeNew);
        if(type === 'Training'){
          var typeSub = fieldValue(typeSubSelect, typeSubNew);
          if(typeSub) type = composeTrainingType(typeSub);
        }
        var manufacturer = fieldValue(mfrSelect, mfrNew) || null;
        var format = FORMATS_BY_SPORT[sportSlug] ? formatSel.value : null;
        var notes = document.getElementById('f-notes').value.trim() || null;
        var credit = document.getElementById('f-credit').value.trim() || null;

        // Photos are uploaded to storage BEFORE the jerseys row exists at
        // all (a client-generated id, same genUUID() used elsewhere,
        // used as the storage folder up front) - the old order created
        // the jersey row first and only rolled it back in a catch block
        // if the photo step then failed, which can't help if the
        // browser tab/connection dies mid-upload instead of throwing a
        // catchable error (closing the tab, losing signal, etc.) -
        // exactly the kind of interruption a "no photo at all" pending
        // jersey turned out to be. With photos going first, that same
        // interruption just leaves orphaned storage files (invisible,
        // harmless) and no DB row at all, instead of a broken
        // submission sitting in the moderation queue.
        var jerseyId = genUUID();
        await Promise.all(photoCompressionPromises);
        var uploadedPaths = [];
        var photoRows = [];
        try {
          for(var i=0; i<selectedPhotos.length; i++){
            var photo = selectedPhotos[i];
            var ext = (photo.file.name.split('.').pop() || 'jpg').toLowerCase();
            var path = jerseyId + '/' + jerseyPhotoFileName(team.name, season, type, photo.label, i+1, ext);
            var up = await supabaseClient.storage.from('jersey-photos').upload(path, photo.file);
            if(up.error) throw up.error;
            uploadedPaths.push(path);
            photoRows.push({jersey_id: jerseyId, storage_path: path, label: photo.label, sort_order: i});
          }
        } catch(photoErr){
          if(uploadedPaths.length) await supabaseClient.storage.from('jersey-photos').remove(uploadedPaths);
          throw photoErr;
        }

        var jerseyIns = await supabaseClient.from('jerseys').insert({
          id: jerseyId, team_id: team.id, season: season, type: type, manufacturer: manufacturer,
          format: format, notes: notes, image_credit: credit, uploaded_by: currentUser.id
        }).select().single();
        if(jerseyIns.error) throw jerseyIns.error;
        var jersey = jerseyIns.data;

        if(extraCompToggle.checked){
          var extraCompVal = fieldValue(extraCompSel, extraCompNew);
          if(extraCompVal){
            var extraComp = extraCompSel.value === '__new__'
              ? await ensureCompetition(sportSlug, extraCompVal)
              : {slug: extraCompVal};
            var tagIns = await supabaseClient.from('jersey_competitions').insert({jersey_id: jersey.id, competition_slug: extraComp.slug});
            if(tagIns.error) throw tagIns.error;
          }
        }

        var imgIns = await supabaseClient.from('jersey_images').insert(photoRows);
        if(imgIns.error){
          // same rationale as before: never leave a photo-less jersey
          // behind if this last step fails.
          await supabaseClient.from('jerseys').delete().eq('id', jersey.id);
          throw imgIns.error;
        }

        await refreshAuthUI();

        var resultEl = document.getElementById('upload-result');
        if(!resultEl) return; // page moved on while this was in flight — upload still succeeded
        resultEl.innerHTML =
          '<div class="result-panel">' +
            '<h3>Your jersey submission is under review</h3>' +
            '<p>The '+season+' '+esc(team.name)+' '+esc(type)+' jersey has been sent for approval. Once approved, it’ll automatically appear on its team, season, and sport pages &mdash; no extra work needed &mdash; and you’ll earn +1 point.</p>' +
            '<div class="result-links">' +
              '<a href="#/jersey/'+jersey.id+'"><span>View your submission (only you and moderators can see it for now)</span><span class="go">View &rarr;</span></a>' +
            '</div>' +
          '</div>';

        // Sport/competition/team/season/manufacturer/format all deliberately
        // stay put — uploading home/away/alternate for the same team and
        // season back to back only needs a new photo and jersey type.
        selectedPhotos.forEach(function(p){ URL.revokeObjectURL(p.url); });
        selectedPhotos.length = 0;
        photoCompressionPromises.length = 0;
        renderPhotoPreviews();
        await reselectAfterSubmit(comp.name, team.name);
        typeSelect.value = '';
        syncNewVisibility(typeSelect, typeNewRow, typeNew, true);
        refreshTypeSubVisibility();
        document.getElementById('f-notes').value = '';
        document.getElementById('f-credit').value = '';
        saveDraft();
      } catch(err) {
        var resultElOnError = document.getElementById('upload-result');
        if(resultElOnError) resultElOnError.innerHTML = errorBox(err);
        else console.error('Upload failed after the page had moved on:', err);
      } finally {
        if(document.body.contains(submitBtn)){ submitBtn.disabled = false; submitBtn.textContent = 'Add jersey'; }
      }
    });
  }

  document.getElementById('search-form').addEventListener('submit', function(e){
    e.preventDefault();
    var val = document.getElementById('search-input').value.trim();
    if(val) location.hash = '#/search/' + encodeURIComponent(val);
  });

  // Live suggestions under the search box, jumping straight to a team or
  // competition page instead of needing the full #/search/ results page
  // for the common case of knowing roughly who you're looking for. Only
  // kicks in from 3 characters on - below that, almost everything matches
  // something, so the list is more noise than help (also keeps the one
  // underlying fetch from firing on every single keystroke of a very
  // short, still-being-typed query).
  (function wireSearchSuggest(){
    var input = document.getElementById('search-input');
    var panel = document.getElementById('search-suggest-panel');
    if(!input || !panel) return;
    var MIN_CHARS = 3;
    var activeIdx = -1;
    var debounceTimer = null;

    // Fetched once and cached, not once per keystroke - reuses the exact
    // same rows + searchTextMatches() the full #/search/ page uses, so a
    // suggestion and what you'd get from pressing Enter stay consistent.
    var teamsPromise = null;
    function loadTeams(){
      if(!teamsPromise){
        teamsPromise = fetchAllRows('teams', '*, competitions(*, sports(*))')
          .then(function(rows){ return rows.filter(function(t){ return t.competitions && t.competitions.sports; }); })
          .catch(function(){ teamsPromise = null; return []; });
      }
      return teamsPromise;
    }

    function closePanel(){ panel.hidden = true; activeIdx = -1; }
    function setActive(i){
      var rows = panel.querySelectorAll('.combo-option');
      for(var k = 0; k < rows.length; k++) rows[k].classList.remove('active');
      activeIdx = i;
      if(i > -1 && rows[i]){ rows[i].classList.add('active'); rows[i].scrollIntoView({block: 'nearest'}); }
    }

    // Ranks a plain substring/token-subset match (e.g. "a-league" matching
    // some unrelated club purely because it contains an "a" and "league"
    // somewhere) below a real prefix match, so the obvious answer doesn't
    // get buried under loose matches. A name that starts with the query
    // ("Hornchurch") and a name where just one word does ("Charlotte
    // Hornets") count as equally strong - "Hornets" IS what someone
    // typing "horn" is after - so they land in the same rank and get
    // sorted apart by sport/tier instead.
    function matchRank(nameRaw, qNorm){
      var name = normalizeSearchText(nameRaw);
      if(name.indexOf(qNorm) === 0) return 0;
      var words = name.split(' ');
      for(var i = 0; i < words.length; i++){ if(words[i].indexOf(qNorm) === 0) return 0; }
      return 1;
    }
    // "top" vs everything else within ONE sport's own competitions (same
    // flag that already orders the upload form's competition dropdown,
    // e.g. NRL over NSW Cup) stays the main tiebreaker - it's why
    // Charlotte Hornets (NBA, top) still outranks Rochdale Hornets
    // (Championship, a non-top rugby league comp) even though rugby
    // league sits above basketball in the site's own sport order. Sport
    // order only steps in to break a tie WITHIN the same tier - that's
    // what puts Brisbane Broncos (NRL, top) ahead of Brisbane Bullets
    // (NBL, also top): both are the top flight of their own sport, so
    // the sport's position in the homepage's "Browse by sport" grid
    // decides between them instead of falling straight to A-Z.
    function tierRank(tier){ return tier === 'top' ? 0 : 1; }
    // A competition's OWN sort_order (the same field competitionsForSport()
    // already uses to put NRL before NSW Cup in the upload form) is a
    // finer, more deliberate signal than tier alone - tier just means
    // "top flight of its own sport" and gets applied broadly (every
    // "International*" competition across every sport was bulk-promoted
    // to top, same for the rugby league "Representative" grab-bag of
    // teams that are really just pinned for sport-page visibility, not
    // because they're prominent). sort_order is hand-curated per
    // competition instead, so it's checked before sport: it's what lets
    // Cricket's International (sort_order 1) outrank Rugby League's
    // Representative (never curated, sitting at the schema default)
    // even though rugby league sits above cricket in the sport order.
    function compSortRank(c){ return c && c.sort_order != null ? c.sort_order : 999; }
    function sportRank(sport){ return sport && sport.sort_order != null ? sport.sort_order : 9999; }

    async function renderSuggestions(){
      var q = input.value.trim();
      if(q.length < MIN_CHARS){ closePanel(); return; }
      var teams = await loadTeams();
      // Query may have changed (or the box may have been cleared/closed)
      // while that fetch/filter was in flight.
      if(input.value.trim() !== q) return;
      var qNorm = normalizeSearchText(q);

      // Not sliced to a small number per type yet - a weaker-but-correct
      // match (Chicago Bulls, buried alphabetically among a dozen other
      // "Bull..." teams) must not get cut before tier/rank sorting and
      // the final combined slice below ever sees it.
      var teamMatches = teams.filter(function(t){ return searchTextMatches(t.name, q); });

      var compSeen = {}, compMatches = [];
      teams.forEach(function(t){
        var c = t.competitions;
        if(compSeen[c.slug] || !searchTextMatches(c.name, q)) return;
        compSeen[c.slug] = true;
        compMatches.push(c);
      });

      activeIdx = -1;
      if(!teamMatches.length && !compMatches.length){
        panel.innerHTML = '<div class="combo-empty">No matches</div>';
        panel.hidden = false;
        return;
      }
      // Combined into one ranked list rather than "teams first, then
      // comps" - otherwise a loose team match (e.g. some club that only
      // matches "a-league" because it happens to contain an "a" and a
      // "league" somewhere) would always sit above the actual A-League
      // competition entry just because it's a team. A team's meta shows
      // its sport alongside the competition name since a generic comp
      // name like "International" exists once per sport - without the
      // sport name there's no telling Australia (Rugby League) apart
      // from Australia (Football) in the dropdown.
      var combined = teamMatches.map(function(t){
        var c = t.competitions, sport = c.sports;
        return {
          rank: matchRank(t.name, qNorm), tier: tierRank(c.tier), compSort: compSortRank(c), sport: sportRank(sport),
          active: t.is_active === false ? 1 : 0, name: t.name,
          html: '<a class="combo-option search-suggest-row" href="#/sport/'+sport.slug+'/'+c.slug+'/team/'+t.slug+'"><span>'+esc(t.name)+'</span><span class="meta">'+esc(c.name)+' &middot; '+esc(sport.name)+'</span></a>'
        };
      }).concat(compMatches.map(function(c){
        return {
          rank: matchRank(c.name, qNorm), tier: tierRank(c.tier), compSort: compSortRank(c), sport: sportRank(c.sports),
          active: 0, name: c.name,
          html: '<a class="combo-option search-suggest-row" href="#/sport/'+c.sports.slug+'/'+c.slug+'"><span>'+esc(c.name)+'</span><span class="meta">'+esc(c.sports.name)+' &middot; Competition</span></a>'
        };
      }));
      combined.sort(function(a, b){
        return (a.rank - b.rank) || (a.tier - b.tier) || (a.compSort - b.compSort) || (a.sport - b.sport) || (a.active - b.active) || a.name.localeCompare(b.name);
      });
      panel.innerHTML = combined.slice(0, 8).map(function(r){ return r.html; }).join('');
      panel.hidden = false;
    }

    input.addEventListener('input', function(){
      clearTimeout(debounceTimer);
      debounceTimer = setTimeout(renderSuggestions, 150);
    });
    input.addEventListener('focus', function(){
      if(input.value.trim().length >= MIN_CHARS) renderSuggestions();
    });
    input.addEventListener('keydown', function(e){
      if(panel.hidden) return;
      var rows = panel.querySelectorAll('.combo-option');
      if(!rows.length) return;
      if(e.key === 'ArrowDown'){ e.preventDefault(); setActive(Math.min(activeIdx + 1, rows.length - 1)); }
      else if(e.key === 'ArrowUp'){ e.preventDefault(); setActive(Math.max(activeIdx - 1, 0)); }
      else if(e.key === 'Enter' && activeIdx > -1){ e.preventDefault(); rows[activeIdx].click(); }
      else if(e.key === 'Escape'){ closePanel(); }
    });
    panel.addEventListener('click', closePanel);
    document.addEventListener('click', function(e){
      if(!panel.hidden && !document.getElementById('search-form').contains(e.target)) closePanel();
    });
  })();

  /* ================= auth ================= */
  function closeAuthPanel(){
    var p = document.getElementById('auth-panel');
    if(p) p.remove();
  }

  function toggleAuthPanel(){
    if(document.getElementById('auth-panel')){ closeAuthPanel(); return; }
    var el = document.getElementById('auth-area');
    var panel = document.createElement('div');
    panel.className = 'auth-panel';
    panel.id = 'auth-panel';
    panel.innerHTML =
      '<p>Sign in with a magic link — no password needed. Uploads, points, and ratings are tied to this email.</p>' +
      '<input type="email" id="auth-email" placeholder="you@example.com">' +
      '<button class="btn" id="auth-send-btn" type="button" style="width:100%;">Send magic link</button>' +
      '<p class="auth-msg" id="auth-msg" hidden></p>';
    el.appendChild(panel);
    panel.addEventListener('click', function(e){ e.stopPropagation(); });
    document.getElementById('auth-send-btn').addEventListener('click', async function(){
      var email = document.getElementById('auth-email').value.trim();
      var msg = document.getElementById('auth-msg');
      if(!email) return;
      this.disabled = true; this.textContent = 'Sending…';
      var res = await supabaseClient.auth.signInWithOtp({ email: email, options: { emailRedirectTo: window.location.origin } });
      this.disabled = false; this.textContent = 'Send magic link';
      msg.hidden = false;
      msg.textContent = res.error ? ('Error: ' + res.error.message) : 'Check your email for the link.';
    });
    setTimeout(function(){
      document.addEventListener('click', function outsideClick(e){
        if(!el.contains(e.target)){ closeAuthPanel(); document.removeEventListener('click', outsideClick); }
      });
    }, 0);
  }

  function renderAuthArea(){
    var el = document.getElementById('auth-area');
    if(currentUser){
      var username = currentProfile ? currentProfile.username : currentUser.email.split('@')[0];
      var points = currentProfile ? currentProfile.points : 0;
      var modLink = (currentProfile && currentProfile.is_admin)
        ? '<a href="#/moderate" style="text-decoration:underline;">Moderate'+(pendingCount ? ' ('+pendingCount+')' : '')+'</a>' : '';
      // A reply on either side of a jersey_messages thread - links
      // straight to the most recent one with something new, since
      // there's rarely more than one or two at a time.
      var msgLink = unreadMsgCount
        ? '<a href="'+unreadMsgLink+'" style="text-decoration:underline;color:var(--danger);font-weight:700;">&#9993; '+unreadMsgCount+'</a>'
        : '';
      el.innerHTML =
        '<div class="auth-status">'+modLink+msgLink+'<span><a class="spec-link" href="#/user/'+encodeURIComponent(username)+'">'+esc(username)+'</a> '+pointsChip(points)+'</span>' +
        '<button id="edit-username-btn" type="button">Edit</button>' +
        '<button id="sign-out-btn" type="button">Sign out</button></div>';
      document.getElementById('sign-out-btn').addEventListener('click', async function(){
        await supabaseClient.auth.signOut();
        await refreshAuthUI();
        render();
      });
      document.getElementById('edit-username-btn').addEventListener('click', function(e){ e.stopPropagation(); toggleUsernamePanel(username); });
    } else {
      el.innerHTML = '<button class="auth-btn" id="sign-in-btn" type="button">Sign in</button>';
      document.getElementById('sign-in-btn').addEventListener('click', function(e){ e.stopPropagation(); toggleAuthPanel(); });
    }
  }

  function toggleUsernamePanel(current){
    if(document.getElementById('auth-panel')){ closeAuthPanel(); return; }
    var el = document.getElementById('auth-area');
    var panel = document.createElement('div');
    panel.className = 'auth-panel';
    panel.id = 'auth-panel';
    panel.innerHTML =
      '<p>Pick a username &mdash; this is what shows publicly on jerseys you upload, never your email.</p>' +
      '<input type="text" id="username-input" value="'+esc(current)+'" maxlength="24">' +
      '<button class="btn" id="username-save-btn" type="button" style="width:100%;">Save</button>' +
      '<p class="auth-msg" id="username-msg" hidden></p>';
    el.appendChild(panel);
    panel.addEventListener('click', function(e){ e.stopPropagation(); });
    document.getElementById('username-save-btn').addEventListener('click', async function(){
      var val = document.getElementById('username-input').value.trim();
      var msg = document.getElementById('username-msg');
      if(!val) return;
      this.disabled = true; this.textContent = 'Saving…';
      var res = await supabaseClient.from('profiles').update({username: val}).eq('id', currentUser.id);
      this.disabled = false; this.textContent = 'Save';
      msg.hidden = false;
      if(res.error){
        msg.textContent = res.error.code === '23505' ? 'That username is taken — try another.' : ('Error: '+res.error.message);
      } else {
        msg.textContent = 'Saved.';
        await refreshAuthUI();
      }
    });
    setTimeout(function(){
      document.addEventListener('click', function outsideClick(e){
        if(!el.contains(e.target)){ closeAuthPanel(); document.removeEventListener('click', outsideClick); }
      });
    }, 0);
  }

  // Just enough to know who's signed in - split out from refreshAuthUI so
  // the auth-state-change handler below can await this one fast call
  // instead of the full thing (profile + four separate admin pending-count
  // queries), which was otherwise adding several round trips' worth of
  // delay to it.
  async function syncCurrentUser(){
    var sess = await supabaseClient.auth.getSession();
    currentUser = sess.data.session ? sess.data.session.user : null;
  }
  // Wrapped in Promise.resolve() because the Supabase query builder is only
  // thenable (implements .then()), not a full Promise - calling .catch()
  // straight on it isn't guaranteed to exist and throws if it doesn't,
  // which happened here: the throw happened before refreshAuthUI() ever
  // reached renderAuthArea(), so the whole header's sign-in/profile area
  // stopped rendering for any admin account (is_admin is what triggers
  // this code path) - including on the very first page load.
  function safeCount(query){
    return Promise.resolve(query).catch(function(e){ return {error: e}; });
  }
  async function refreshAuthUI(){
    await syncCurrentUser();
    pendingCount = 0;
    unreadMsgCount = 0; unreadMsgLink = null;
    if(currentUser){
      var profRes = await supabaseClient.from('profiles').select('*').eq('id', currentUser.id).maybeSingle();
      currentProfile = profRes.data || null;
      if(currentProfile && currentProfile.is_admin){
        // Four independent counts - run together instead of one after
        // another. jersey_images/reports/team_logo_proposals are wrapped
        // since those tables/columns may not exist yet on an install that
        // hasn't run the matching migration.
        var results = await Promise.all([
          supabaseClient.from('jerseys').select('id', {count:'exact', head:true}).eq('status', 'pending'),
          safeCount(supabaseClient.from('jersey_images').select('id', {count:'exact', head:true}).eq('status', 'pending')),
          safeCount(supabaseClient.from('reports').select('id', {count:'exact', head:true}).eq('status', 'open')),
          safeCount(supabaseClient.from('team_logo_proposals').select('id', {count:'exact', head:true}).eq('status', 'pending'))
        ]);
        pendingCount = results.reduce(function(sum, r){ return sum + (r && !r.error ? (r.count || 0) : 0); }, 0);
      }
      // Any signed-in user (not just admins) can have a reply waiting -
      // either side of a jersey_messages or logo_messages thread.
      // Wrapped since either view may not exist yet on an install that
      // hasn't run the matching migration. Combined into one badge/
      // count - whichever thread has the most recent reply wins the
      // link, since there's rarely more than one or two unread at once.
      var unreadResults = await Promise.all([
        safeCount(supabaseClient.from('my_unread_jersey_messages').select('jersey_id, latest_at').order('latest_at', {ascending:false})),
        safeCount(supabaseClient.from('my_unread_logo_messages').select('kind, proposal_id, latest_at').order('latest_at', {ascending:false}))
      ]);
      var unreadJerseyRes = unreadResults[0], unreadLogoRes = unreadResults[1];
      var unreadJerseyRows = (unreadJerseyRes && !unreadJerseyRes.error) ? unreadJerseyRes.data || [] : [];
      var unreadLogoRows = (unreadLogoRes && !unreadLogoRes.error) ? unreadLogoRes.data || [] : [];
      unreadMsgCount = unreadJerseyRows.length + unreadLogoRows.length;
      var newestJersey = unreadJerseyRows[0], newestLogo = unreadLogoRows[0];
      if(newestJersey && (!newestLogo || new Date(newestJersey.latest_at) >= new Date(newestLogo.latest_at))){
        unreadMsgLink = '#/jersey/'+newestJersey.jersey_id;
      } else if(newestLogo){
        unreadMsgLink = '#/logo-proposal/'+newestLogo.kind+'/'+newestLogo.proposal_id;
      }
    } else {
      currentProfile = null;
    }
    renderAuthArea();
  }

  // Supabase fires TOKEN_REFRESHED whenever the tab regains focus (it's just
  // silently renewing the session, not a real identity change) — only a
  // genuine SIGNED_IN/SIGNED_OUT should ever re-render the current page,
  // otherwise switching tabs mid-upload wipes whatever was typed so far.
  // INITIAL_SESSION is the odd one out: it's how a hard refresh reports
  // "a signed-in session was restored from storage", but it fires AFTER
  // the page's own first render() call below (currentUser is still null
  // at that point) — on a page that gates on currentUser/currentProfile
  // (Upload's "Sign in first", Moderate's "Not authorized" for an admin
  // whose profile hadn't loaded yet), that first render already locked
  // in the signed-out/unauthorized version, and without this it never
  // gets a second chance to re-render now that currentUser is actually
  // set. Listed explicitly rather than re-rendering on every route,
  // since a full re-render also wipes any in-progress state on the
  // current page (photos already picked for an upload, an open
  // edit/reject panel) — only worth the risk on pages that would
  // otherwise be stuck showing the wrong thing.
  // 'logo-proposal' hard-blocks with "Not authorized" the same way
  // 'moderate' does if currentProfile hasn't loaded yet - same bug,
  // just missed when that route was added. 'jersey' is softer (it's
  // publicly viewable regardless of auth, just loses its admin-only
  // sections silently until auth settles) but included for the same
  // reason - no reason an admin's own page should flicker.
  var REAUTH_RERENDER_ROUTES = ['upload', 'moderate', 'logo-proposal', 'jersey'];
  supabaseClient.auth.onAuthStateChange(async function(event){
    // Awaited deliberately: syncCurrentUser's own getSession() call always
    // defers at least one microtask even when the answer's already known -
    // calling render() right after an un-awaited call ran it before
    // currentUser was actually updated, so the re-render below still saw
    // the stale (signed-out) value. Only this lightweight call is awaited
    // here, not the full refreshAuthUI() (see below) - the admin
    // pending-count queries it also runs aren't needed for this decision,
    // and awaiting them here held up this handler for several extra
    // round trips, which turned out to be competing with - and stalling -
    // whatever else was in flight at the time, like an in-progress photo
    // upload triggered by the same tab regaining focus.
    var wasSignedIn = !!currentUser;
    await syncCurrentUser();
    // Re-rendering the Upload page is only actually needed when it's
    // showing the signed-out placeholder and now shouldn't be (the
    // hard-refresh-while-already-signed-in case this exists for) - a
    // SIGNED_IN/INITIAL_SESSION event that fires again later while already
    // signed in (Supabase re-validates the session when a tab regains
    // focus/visibility, among other things) isn't a real state change, and
    // render() rebuilds the whole page from scratch - including wiping
    // out any photos already picked for an in-progress upload. Only a
    // genuine transition re-renders; SIGNED_OUT always does, since that's
    // an explicit action and the page genuinely needs to reflect it.
    var justSignedIn = (event === 'SIGNED_IN' || event === 'INITIAL_SESSION') && !wasSignedIn && currentUser;
    if(justSignedIn || event === 'SIGNED_OUT'){
      var currentRoute = location.hash.replace(/^#\/?/,'').split('/')[0];
      if(REAUTH_RERENDER_ROUTES.indexOf(currentRoute) > -1){
        // Moderate's gate also needs currentProfile.is_admin, which
        // syncCurrentUser() above never sets - only refreshAuthUI()
        // fetches the profile. Awaiting it here (unlike the general
        // case below) before render() was the piece still missing:
        // without it, render() re-ran viewModerate() with currentUser
        // now set but currentProfile still null, so "Not authorized"
        // stuck around exactly as before.
        await refreshAuthUI();
        render();
        return;
      }
    }
    // Not awaited - keeps the header's profile/pending-count badge in
    // sync, same as always, just without blocking the render decision
    // above (or anything else in flight) on it.
    refreshAuthUI();
  });

  /* ================= lightbox ================= */
  var lightbox = document.getElementById('lightbox');
  var lightboxImg = document.getElementById('lightbox-img');
  var lightboxPrevBtn = document.getElementById('lightbox-prev-btn');
  var lightboxNextBtn = document.getElementById('lightbox-next-btn');
  var lightboxCount = document.getElementById('lightbox-count');
  var lightboxUrls = [];
  var lightboxIndex = 0;

  function renderLightbox(){
    lightboxImg.src = lightboxUrls[lightboxIndex];
    var multi = lightboxUrls.length > 1;
    lightboxPrevBtn.hidden = !multi;
    lightboxNextBtn.hidden = !multi;
    lightboxCount.hidden = !multi;
    if(multi) lightboxCount.textContent = (lightboxIndex+1) + ' / ' + lightboxUrls.length;
  }
  function openLightbox(url, urls, index){
    lightboxUrls = (urls && urls.length) ? urls : [url];
    lightboxIndex = (typeof index === 'number' && index >= 0) ? index : Math.max(0, lightboxUrls.indexOf(url));
    lightbox.hidden = false;
    renderLightbox();
  }
  function closeLightbox(){ lightbox.hidden = true; lightboxImg.src = ''; }
  function lightboxStep(delta){
    if(lightboxUrls.length < 2) return;
    lightboxIndex = (lightboxIndex + delta + lightboxUrls.length) % lightboxUrls.length;
    renderLightbox();
  }

  // A "gallery" of images sharing one lightbox can come from two shapes on
  // this site: the jersey detail page (main photo + thumbnails, backed by
  // the images array already serialized onto #gallery-thumbs), or a plain
  // grid where every thumbnail is itself a .lightbox-trigger (logo history).
  function lightboxGroupFor(trigger){
    var galleryWrap = trigger.closest('.jersey-gallery');
    if(galleryWrap){
      var thumbsWrap = galleryWrap.querySelector('#gallery-thumbs');
      if(thumbsWrap){
        var images = JSON.parse(thumbsWrap.dataset.images);
        var urls = images.map(function(im){ return publicImageUrl(im.storage_path); });
        return { urls: urls, index: urls.indexOf(trigger.src) };
      }
    }
    var grid = trigger.closest('.lightbox-group');
    if(grid){
      var imgs = Array.from(grid.querySelectorAll('.lightbox-trigger'));
      return { urls: imgs.map(function(im){ return im.src; }), index: imgs.indexOf(trigger) };
    }
    return null;
  }

  document.addEventListener('click', function(e){
    var trigger = e.target.closest('.lightbox-trigger');
    if(trigger){
      var group = lightboxGroupFor(trigger);
      openLightbox(trigger.src, group && group.urls, group && group.index);
      return;
    }
    if(e.target === lightbox) closeLightbox();
    var showMoreBtn = e.target.closest('.show-more-btn');
    if(showMoreBtn){
      var hiddenGrid = showMoreBtn.previousElementSibling;
      if(hiddenGrid) hiddenGrid.hidden = false;
      showMoreBtn.remove();
    }
    // Swaps a sport's 5-jersey preview gallery for its full season-by-season
    // list — see renderGroupedBySport().
    var showSportAllBtn = e.target.closest('.show-sport-all-btn');
    if(showSportAllBtn){
      var fullList = showSportAllBtn.previousElementSibling;
      var preview = fullList && fullList.previousElementSibling;
      if(fullList) fullList.hidden = false;
      if(preview && preview.classList.contains('sport-preview-grid')) preview.hidden = true;
      showSportAllBtn.remove();
    }
    // Jump-to-section nav (see renderGroupedBySport()) — scrolls in place
    // rather than using a real #hash link, which would trigger the
    // router and re-render the whole page out from under it.
    var anchorBtn = e.target.closest('.anchor-nav-btn');
    if(anchorBtn){
      var scrollTarget = document.getElementById(anchorBtn.dataset.scrollTarget);
      if(scrollTarget) scrollTarget.scrollIntoView({behavior:'smooth', block:'start'});
    }
    // Profile page's Uploads/Collection tabs - both panels are already
    // in the page, this just shows one and hides the other.
    var profileTabBtn = e.target.closest('.profile-tab-btn');
    if(profileTabBtn){
      var tabsWrap = profileTabBtn.closest('.profile-tabs');
      if(tabsWrap) tabsWrap.querySelectorAll('.profile-tab-btn').forEach(function(b){ b.classList.toggle('is-active', b === profileTabBtn); });
      var uploadsPanel = document.getElementById('profile-tab-uploads');
      var collectionPanel = document.getElementById('profile-tab-collection');
      if(uploadsPanel) uploadsPanel.hidden = profileTabBtn.dataset.tab !== 'uploads';
      if(collectionPanel) collectionPanel.hidden = profileTabBtn.dataset.tab !== 'collection';
    }
  });
  document.getElementById('lightbox-close-btn').addEventListener('click', closeLightbox);
  lightboxPrevBtn.addEventListener('click', function(e){ e.stopPropagation(); lightboxStep(-1); });
  lightboxNextBtn.addEventListener('click', function(e){ e.stopPropagation(); lightboxStep(1); });
  document.addEventListener('keydown', function(e){
    if(lightbox.hidden) return;
    if(e.key === 'Escape') closeLightbox();
    else if(e.key === 'ArrowLeft') lightboxStep(-1);
    else if(e.key === 'ArrowRight') lightboxStep(1);
  });

  // Footer-wide site stats (teams/competitions counted straight from
  // their tables; jerseys/manufacturers/contributors derived from one
  // pass over approved jerseys' manufacturer + uploaded_by columns,
  // same lightweight-single-column-fetch approach as viewManufacturers).
  // Runs once at startup, not per route — it isn't route-specific.
  async function refreshFooterStats(){
    var el = document.getElementById('footer-stats');
    if(!el) return;
    try{
      var teamsCountRes = await supabaseClient.from('teams').select('id', {count:'exact', head:true});
      var compsCountRes = await supabaseClient.from('competitions').select('slug', {count:'exact', head:true});
      if(teamsCountRes.error || compsCountRes.error) return;
      // head:true counts aren't capped by the row-return limit, but a
      // plain row fetch is — paginated the same way as search so this
      // doesn't quietly under-count once jerseys passes that limit too.
      var jerseys = await fetchAllRows('jerseys', 'manufacturer, uploaded_by', function(q){ return q.eq('status', 'approved'); });
      var manufacturers = {}, contributors = {};
      jerseys.forEach(function(j){
        var m = (j.manufacturer || '').trim();
        if(m) manufacturers[m.toLowerCase()] = true;
        if(j.uploaded_by) contributors[j.uploaded_by] = true;
      });
      var jerseyCount = jerseys.length;
      var teamCount = teamsCountRes.count || 0;
      var compCount = compsCountRes.count || 0;
      var mfrCount = Object.keys(manufacturers).length;
      var userCount = Object.keys(contributors).length;
      el.textContent = 'The archive includes ' + jerseyCount.toLocaleString() + ' jersey' + (jerseyCount===1?'':'s') +
        ' from ' + teamCount.toLocaleString() + ' team' + (teamCount===1?'':'s') +
        ' in ' + compCount.toLocaleString() + ' competition' + (compCount===1?'':'s') +
        (mfrCount ? ', made by ' + mfrCount.toLocaleString() + ' manufacturer' + (mfrCount===1?'':'s') : '') +
        (userCount ? ' and submitted by ' + userCount.toLocaleString() + ' contributor' + (userCount===1?'':'s') : '') + '.';
      el.hidden = false;
    } catch(e){ /* footer stats are decorative — fail silently */ }
  }

  // Floating "scroll to top" button — global chrome, not tied to any one
  // page, so it's wired once here rather than in wireViewEvents (which
  // reruns on every render and would otherwise pile up duplicate
  // listeners). Shows once the page has scrolled past roughly one
  // screen's worth, which is about where a long jersey/season list
  // starts making "scroll all the way back up" actually annoying.
  var scrollTopBtn = document.getElementById('scroll-top-btn');
  if(scrollTopBtn){
    window.addEventListener('scroll', function(){
      scrollTopBtn.hidden = window.scrollY < 600;
    }, {passive:true});
    scrollTopBtn.addEventListener('click', function(){
      window.scrollTo({top:0, behavior:'smooth'});
    });
  }

  refreshAuthUI();
  refreshFooterStats();
  window.addEventListener('hashchange', render);
  render();
})();
