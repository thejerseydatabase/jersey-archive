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
  // suffix always means international.
  var FORMATS_BY_SPORT = { cricket: ['Test','First Class','ODI','One Day','T20I','T20','T10I','T10'] };
  // Every sport gets these; sports in the per-slug lists below also get
  // those on top. Indigenous jerseys are a rugby league/union/AFL/netball
  // thing (and a few others) — not something football, cricket etc. have,
  // so it's opt-in per sport rather than shown everywhere (a one-off
  // special jersey can still be typed in via "+ Add a new one…").
  var CURATED_TYPES = ['Home','Away','Third','Alternate','Heritage','Training'];
  var EXTRA_TYPES_BY_SPORT = {
    'rugby-league': ['Indigenous'],
    'rugby-union': ['Indigenous'],
    afl: ['Indigenous'],
    netball: ['Indigenous'],
    cricket: ['Indigenous'],
    'field-hockey': ['Indigenous']
  };
  // Picking "Training" reveals a second field for which kind, so
  // "pre-match", "warm up", "captain's run" etc. don't fragment into
  // inconsistent one-off type values — stored as "Training - Warm Up"
  // and collapsed back to the "Training" family by baseJerseyType() for
  // browsing, same way "Home V1"/"Home V2" collapse to "Home". Retro
  // isn't in here — that's a genuine match jersey, already covered by
  // the separate "Heritage" type.
  var TRAINING_SUBTYPES = ['Pre-match','Warm Up','Captain\'s Run','Travel'];
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
    {min:0,    label:'Rookie',      color:'#8FAA98'},
    {min:50,   label:'Contributor', color:'#4FB0E0'},
    {min:100,  label:'Regular',     color:'#3FD1A8'},
    {min:250,  label:'Veteran',     color:'#F5B324'},
    {min:500,  label:'Elite',       color:'#E4645C'},
    {min:1000, label:'Legend',      color:'#B084E8'}
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
  // Remembers which sport pages had "More competitions" expanded, so
  // navigating back to one (e.g. after clicking into a team from the
  // expanded list) shows it already open instead of re-collapsing —
  // a fresh visit still starts collapsed and needs the click.
  var expandedSportComps = {};

  /* ================= helpers ================= */
  function esc(s){ return String(s == null ? '' : s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;'); }
  function fmtDate(iso){ try{ return new Date(iso).toLocaleDateString(undefined,{year:'numeric',month:'short',day:'numeric'}); }catch(e){ return ''; } }
  function slugify(s){ return String(s).toLowerCase().trim().replace(/[^a-z0-9]+/g,'-').replace(/(^-|-$)/g,'') || 'x'; }
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
  function seasonSortKey(s){ return parseInt(String(s), 10) || 0; }

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

  function normalizeTeamName(name){
    return String(name).trim()
      .replace(/\s*\((women|men)\)\s*$/i, '')
      .replace(/\s+wfc$/i, '')
      .replace(/\s+women$/i, '')
      .trim();
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

  function publicImageUrl(path){
    return supabaseClient.storage.from('jersey-photos').getPublicUrl(path).data.publicUrl;
  }

  function publicLogoUrl(path){
    return supabaseClient.storage.from('team-logos').getPublicUrl(path).data.publicUrl;
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
      return '<div class="team-swatch team-swatch-logo'+sizeClass+'"><img class="'+triggerClass.trim()+'" src="'+esc(publicLogoUrl(team.logo_path))+'" alt=""></div>';
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
    return '<div class="team-swatch team-swatch-logo'+sizeClass+'"><img class="'+triggerClass.trim()+'" src="'+esc(publicLogoUrl(comp.logo_path))+'" alt=""></div>';
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
      return '<img src="'+esc(publicImageUrl(images[0].storage_path))+'" alt="">';
    }
    return '<div class="thumb-placeholder" style="background:linear-gradient(135deg,'+esc(team.primary_color)+','+esc(team.secondary_color)+')"><span>No photo yet</span></div>';
  }

  function jerseyCard(jersey, team, opts){
    opts = opts || {};
    var yearType = jersey.season + ' · ' + jersey.type + (jersey.format ? ' · ' + jersey.format : '');
    var primary = opts.showTeam ? team.name : yearType;
    var secondary = opts.showTeam ? yearType : (jersey.manufacturer || 'Unlisted');
    var pendingBadge = jersey.status === 'rejected' ? '<span class="pending-badge is-rejected">Rejected</span>'
      : (jersey.status && jersey.status !== 'approved' ? '<span class="pending-badge">Pending</span>' : '');
    return '<a class="jersey-card" href="#/jersey/'+jersey.id+'" data-format="'+esc(jersey.format || '')+'">' + pendingBadge +
      '<div class="jersey-thumb">'+jerseyThumb(jersey, team)+'</div>' +
      '<div class="jersey-label"><strong>'+esc(primary)+'</strong><span>'+esc(secondary)+'</span></div>' +
    '</a>';
  }

  // Shares the jersey-card markup/CSS so a logo slots into the same
  // "Recently added" grid as jerseys instead of needing its own layout.
  function logoCard(logo, team, opts){
    var label = (opts && opts.label) || 'New logo';
    var sportSlug = team.competitions.sport_slug;
    return '<a class="jersey-card" href="#/sport/'+sportSlug+'/'+team.competition_slug+'/team/'+team.slug+'">' +
      '<div class="jersey-thumb"><img src="'+esc(publicLogoUrl(logo.storage_path))+'" alt=""></div>' +
      '<div class="jersey-label"><strong>'+esc(team.name)+'</strong><span>'+esc(label)+'</span></div>' +
    '</a>';
  }

  function compLogoCard(logo, comp, opts){
    var label = (opts && opts.label) || 'New logo';
    return '<a class="jersey-card" href="#/sport/'+comp.sport_slug+'/'+comp.slug+'">' +
      '<div class="jersey-thumb"><img src="'+esc(publicLogoUrl(logo.storage_path))+'" alt=""></div>' +
      '<div class="jersey-label"><strong>'+esc(comp.name)+'</strong><span>'+esc(label)+'</span></div>' +
    '</a>';
  }

  async function fetchRating(jerseyId){
    var r = await supabaseClient.from('jersey_ratings').select('*').eq('jersey_id', jerseyId).maybeSingle();
    if(r.error) throw r.error;
    return r.data || {avg_rating:0, rating_count:0};
  }

  function ratingWidgetHtml(rating, myValue){
    var rounded = myValue || Math.round(rating.rating_count ? rating.avg_rating : 0);
    var stars = '';
    for(var i=1;i<=5;i++){
      stars += '<button type="button" class="star-btn'+(i<=rounded?' is-filled':'')+'" data-value="'+i+'"'+(currentUser?'':' disabled')+' aria-label="Rate '+i+' star">'+ICON_STAR+'</button>';
    }
    var summary = rating.rating_count ? (rating.avg_rating+' · '+rating.rating_count+' rating'+(rating.rating_count===1?'':'s')) : 'Not yet rated — be the first';
    if(!currentUser) summary += ' — sign in to rate';
    return '<div class="stars-row">'+stars+'</div><p class="rating-summary">'+summary+'</p>';
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
    var jq = supabaseClient.from('jerseys').select('*, jersey_images(*), teams!inner(*)').order('created_at', {ascending:false}).limit(6);
    var lq = supabaseClient.from('team_logos').select('*, teams!inner(*, competitions!inner(sport_slug))').eq('is_current', true).order('approved_at', {ascending:false}).limit(6);
    var cq = supabaseClient.from('competition_logos').select('*, competitions!inner(*)').eq('is_current', true).order('approved_at', {ascending:false}).limit(6);
    if(compSlugs){ jq = jq.in('teams.competition_slug', compSlugs); lq = lq.in('teams.competition_slug', compSlugs); cq = cq.in('competition_slug', compSlugs); }
    var results = await Promise.all([jq, lq, cq]);
    var jRes = results[0], lRes = results[1], cRes = results[2];
    var items = (jRes.data || []).map(function(j){ return {ts: j.created_at, html: jerseyCard(j, j.teams, {showTeam:true})}; })
      .concat((lRes.data || []).map(function(l){ return {ts: l.approved_at, html: logoCard(l, l.teams)}; }))
      .concat((cRes.data || []).map(function(l){ return {ts: l.approved_at, html: compLogoCard(l, l.competitions)}; }));
    items.sort(function(a,b){ return new Date(b.ts) - new Date(a.ts); });
    items = items.slice(0, 6);
    if(!items.length) return '';
    var cards = items.map(function(i){ return i.html; }).join('');
    return '<div class="section-head" style="margin-top:34px;"><h2>Recently added</h2></div><div class="jersey-grid">'+cards+'</div>';
  }

  async function viewHome(){
    setCrumbs([{label:'Home', href:'#/'}]);
    var res = await supabaseClient.from('sports').select('*').order('sort_order');
    if(res.error) throw res.error;
    var sports = res.data || [];
    var cards = sports.map(function(s){
      return '<a class="sport-card" href="#/sport/'+s.slug+'">' +
        '<div class="sport-icon">'+sportIcon(s.slug)+'</div>' +
        '<div><div class="sport-name">'+esc(s.name)+'</div></div>' +
      '</a>';
    }).join('');
    var recentHtml = await recentJerseysHtml(null);
    return '<header class="hero">' +
        '<p class="eyebrow">The Jersey Database &mdash; Archive</p>' +
        '<h1>Every jersey.<br>Filed by hand, found in three clicks.</h1>' +
        '<p class="sub">Pick a sport, then drill into competition, team and season &mdash; or search straight to it.</p>' +
      '</header>' +
      '<div class="section-head"><h2>Browse by sport</h2></div>' +
      '<div class="sport-grid">'+(cards || '<div class="empty-note">No sports found &mdash; has schema.sql been run?</div>')+'</div>' +
      recentHtml;
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
          '<div class="comp-grid" id="more-comps"'+(isExpanded ? '' : ' hidden')+' style="margin-top:12px;">'+more.map(compCard).join('')+'</div>' : '');
    }

    var recentHtml = comps.length ? await recentJerseysHtml(comps.map(function(c){ return c.slug; })) : '';

    return '<header class="hero" style="padding-bottom:26px;"><p class="eyebrow">Sport</p><h1>'+esc(sport.name)+'</h1></header>' +
      '<section class="block"><div class="section-head"><h2>Competitions</h2></div>' +
        (comps.length ? compsHtml : '<div class="empty-note">No competitions yet for '+esc(sport.name)+'.</div>') +
      '</section>' +
      recentHtml;
  }

  // A jersey "in" a competition is either owned by a team that belongs to
  // it directly, or explicitly tagged onto it via jersey_competitions (the
  // same physical jersey also worn in an extra competition — a club's
  // league kit also worn in a cup, a country's regular kit also worn at a
  // World Cup). Competition/season pages need both sources merged.
  async function fetchCompetitionJerseys(compSlug, opts){
    opts = opts || {};
    var directQ = supabaseClient.from('jerseys').select('*, jersey_images(*), teams!inner(*)')
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
      var extraQ = supabaseClient.from('jerseys').select('*, jersey_images(*), teams(*)')
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
    function teamCard(t){
      var note = (t.is_upcoming && t.history_note) ? '<span class="upcoming-note">'+esc(t.history_note)+'</span>' : '';
      var formatsAttr = t.formats && t.formats.length ? ' data-formats="'+esc(t.formats.join(','))+'"' : '';
      var count = jerseyCountByTeam[t.id] || 0;
      var countHtml = '<span class="team-jersey-count">'+(count ? count+' jersey'+(count===1?'':'s') : 'No jerseys yet')+'</span>';
      return '<a class="team-card" href="#/sport/'+sportSlug+'/'+compSlug+'/team/'+t.slug+'"'+formatsAttr+'>'+teamSwatch(t)+'<div class="team-info"><h3>'+esc(t.name)+'</h3>'+note+countHtml+'</div></a>';
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
      var rated = seasonJerseys.filter(function(j){ return ratingsByJersey[j.id]; }).sort(function(a,b){
        var ra = ratingsByJersey[a.id], rb = ratingsByJersey[b.id];
        return (rb.avg_rating - ra.avg_rating) || (rb.rating_count - ra.rating_count);
      }).slice(0, 6);
      if(rated.length){
        var topCards = rated.map(function(j){ return jerseyCard(j, j.teams, {showTeam:true}); }).join('');
        topRatedHtml = '<div class="section-head" style="margin-top:34px;"><h2>Highest rated</h2></div><div class="jersey-grid">'+topCards+'</div>';
      }
    }

    var compLogoButtonsHtml = (comp.logo_path ? '<button class="btn btn-secondary" id="comp-logo-history-toggle" data-comp-slug="'+comp.slug+'" type="button">Logo history</button>' : '') +
      (currentUser ? '<button class="btn btn-secondary" id="propose-comp-logo-toggle" data-comp-slug="'+comp.slug+'" type="button">'+(comp.logo_path ? '+ Update logo' : '+ Propose a logo')+'</button>' : '');
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
    var menTeams = activeTeams.filter(function(t){ return !/\bwomen\b/i.test(t.name); });
    var womenTeams = activeTeams.filter(function(t){ return /\bwomen\b/i.test(t.name); });
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
    var teamsGridHtml = formatChipsHtml + (womenTeams.length
      ? '<div class="gender-split-grid">' +
          '<div><h4 class="extra-kits-label">Men&rsquo;s &middot; <span id="men-count">'+menTeams.length+'</span></h4><div class="team-grid" id="men-team-grid">'+menTeams.map(teamCard).join('')+'</div></div>' +
          '<div><h4 class="extra-kits-label">Women&rsquo;s &middot; <span id="women-count">'+womenTeams.length+'</span></h4><div class="team-grid" id="women-team-grid">'+womenTeams.map(teamCard).join('')+'</div></div>' +
        '</div>'
      : '<div class="team-grid">'+menTeams.map(teamCard).join('')+'</div>');

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
        ? '<div class="section-head" style="margin-top:34px;"><h2>New expansion teams</h2><span class="count">'+upcomingTeams.length+'</span></div><div class="team-grid">'+upcomingTeams.map(teamCard).join('')+'</div>'
        : '') +
      (formerTeams.length
        ? '<div class="section-head" style="margin-top:34px;"><h2>Former teams</h2><span class="count">'+formerTeams.length+'</span></div><div class="team-grid">'+formerTeams.map(teamCard).join('')+'</div>'
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

    var jRes = await supabaseClient.from('jerseys').select('*, jersey_images(*)').eq('team_id', team.id).order('season', {ascending:false}).order('created_at', {ascending:true});
    if(jRes.error) throw jRes.error;
    var jerseys = jRes.data || [];
    var bySeason = {};
    jerseys.forEach(function(j){ (bySeason[j.season] = bySeason[j.season] || []).push(j); });
    var years = Object.keys(bySeason).sort(function(a,b){ return seasonSortKey(b) - seasonSortKey(a); });
    // Same split as footballkitarchive: main kits up top, training/pre-match
    // kept as a smaller section underneath each season rather than mixed in.
    var TRAINING_TYPES = ['training','pre-season','warm-up','pre-match'];
    function isTrainingType(t){ return TRAINING_TYPES.indexOf(String(t||'').toLowerCase()) > -1; }
    var groups = years.map(function(y){
      var main = bySeason[y].filter(function(j){ return !isTrainingType(j.type); });
      var extra = bySeason[y].filter(function(j){ return isTrainingType(j.type); });
      main = sortJerseysByType(main, sportSlug, compSlug, y);
      var mainHtml = main.length ? '<div class="jersey-grid">'+main.map(function(j){ return jerseyCard(j, team); }).join('')+'</div>' : '';
      var extraHtml = extra.length
        ? '<h4 class="extra-kits-label">Training &amp; other</h4><div class="jersey-grid">'+extra.map(function(j){ return jerseyCard(j, team); }).join('')+'</div>'
        : '';
      return '<div class="season-group"><h3><a class="spec-link" href="#/sport/'+sportSlug+'/'+compSlug+'/season/'+y+'">'+y+'</a></h3>'+mainHtml+extraHtml+'</div>';
    }).join('');

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
      (currentUser ? '<button class="btn btn-secondary" id="propose-logo-toggle" data-team-id="'+team.id+'" type="button">'+(team.logo_path ? '+ Update logo' : '+ Propose a logo')+'</button>' : '');
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

    var groups = Object.keys(byTeam).map(function(id){
      var entry = byTeam[id];
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
      return '<button class="gallery-thumb'+(i===0?' is-active':'')+'" data-idx="'+i+'" type="button" title="'+esc(img.label)+'"><img src="'+esc(publicImageUrl(img.storage_path))+'" alt=""></button>';
    }).join('') : '';

    var rating = await fetchRating(id);
    var myRatingVal = null;
    if(currentUser){
      var mine = await supabaseClient.from('ratings').select('value').eq('jersey_id', id).eq('user_id', currentUser.id).maybeSingle();
      if(!mine.error && mine.data) myRatingVal = mine.data.value;
    }

    var uploaderHtml = '';
    if(j.uploaded_by){
      var uploaderRes = await supabaseClient.from('profiles').select('username,points').eq('id', j.uploaded_by).maybeSingle();
      if(!uploaderRes.error && uploaderRes.data){
        uploaderHtml = '<span>uploaded by <a class="spec-link" href="#/user/'+encodeURIComponent(uploaderRes.data.username)+'">'+esc(uploaderRes.data.username)+'</a> '+pointsChip(uploaderRes.data.points)+'</span>';
      }
    }

    var pendingBanner = j.status === 'rejected'
      ? '<div class="pending-banner">This submission was rejected &mdash; only you and moderators can see it.' + (j.rejection_reason ? '<br><strong>Reason:</strong> '+esc(j.rejection_reason) : ' No reason was given.') + '</div>'
      : (j.status && j.status !== 'approved'
        ? '<div class="pending-banner">This jersey is '+esc(j.status)+' &mdash; only you and moderators can see it until it’s approved.</div>' : '');

    var isAdmin = currentProfile && currentProfile.is_admin;
    function specItem(label, valueHtml, editData){
      var editBtn = (isAdmin && editData) ? ' <button class="edit-pencil-btn" type="button" data-edit=\''+esc(JSON.stringify(editData))+'\'>'+ICON_PENCIL+'</button>' : '';
      return '<div class="spec-item"><span>'+esc(label)+'</span><div class="spec-value-row"><strong>'+valueHtml+'</strong>'+editBtn+'</div></div>';
    }
    var notesEditData = {table:'jerseys', matchCol:'id', matchVal:j.id, field:'notes', current:j.notes || '', multiline:true};
    var notesEditBtn = isAdmin ? ' <button class="edit-pencil-btn" type="button" data-edit=\''+esc(JSON.stringify(notesEditData))+'\'>'+ICON_PENCIL+'</button>' : '';
    var notesHtml = (j.notes || isAdmin)
      ? '<div class="notes-block"><div class="spec-value-row">'+(j.notes ? esc(j.notes) : '<em style="color:var(--text-dim2);">No notes</em>')+notesEditBtn+'</div></div>'
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
          (j.format ? specItem('Format', esc(j.format), {table:'jerseys', matchCol:'id', matchVal:j.id, field:'format', current:j.format}) : '') +
        '</div>' +
        notesHtml +
        '<div class="stat-row"><span>logged '+fmtDate(j.created_at)+'</span>'+uploaderHtml+'</div>' +
        '<div class="rate-block"><span class="rate-label">Rate this jersey</span><div id="rating-widget" data-jersey-id="'+j.id+'">'+ratingWidgetHtml(rating, myRatingVal)+'</div></div>' +
        (j.status === 'approved' ? (
          currentUser
            ? '<div class="add-photos-block"><button class="btn btn-secondary" id="add-photos-toggle" data-jersey-id="'+j.id+'" type="button">+ Add more photos</button><div id="add-photos-panel" hidden></div></div>'
            : '<div class="add-photos-block"><p class="field-hint">Sign in to add more photos to this jersey.</p></div>'
        ) : '') +
        renderReportButton('jersey', j.id, j.season+' '+team.name+' '+j.type) +
        (isAdmin ? renderJerseyAdminBlock(j, images, sport.slug) : '') +
      '</div>' +
    '</div>';
  }

  // Tucked away like the team page's own admin panel — fixes a mislabeled
  // front/back photo (which also fixes which one shows as the main image,
  // since that's always whichever is labeled "Front") and reassigns a
  // jersey to a different team/sport entirely, for the rare case one gets
  // approved under the wrong one and can't just be re-uploaded.
  function renderJerseyAdminBlock(j, images, sportSlug){
    var relabelHtml = (images && images.length > 1)
      ? '<label class="rate-label">Photo labels</label><div class="logo-history-grid lightbox-group">' + images.map(function(img){
          return '<div class="logo-history-item"><img class="lightbox-trigger" src="'+esc(publicImageUrl(img.storage_path))+'" alt="">' +
            '<select class="photo-label-select" data-image-id="'+img.id+'">' +
              ['Front','Back','Other'].map(function(l){ return '<option value="'+l+'"'+(img.label===l?' selected':'')+'>'+l+'</option>'; }).join('') +
            '</select>' +
          '</div>';
        }).join('') + '</div>'
      : '';
    return '<div class="admin-settings-block">' +
        '<button class="chip" id="admin-settings-toggle" type="button">Admin: fix photos/team</button>' +
        '<div id="admin-settings-panel" hidden data-sport-slug="'+esc(sportSlug)+'">' +
          relabelHtml +
          '<label class="rate-label" style="margin-top:14px;">Wrong team or sport?</label>' +
          renderJerseyReassignControl('jersey-reassign', j.id) +
          '<label class="rate-label" style="margin-top:14px;">Also used in <small>one extra competition this same jersey was also worn in, e.g. a World Cup</small></label>' +
          '<select id="jersey-extra-comp"><option value="">Loading&hellip;</option></select>' +
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
  // prioritySportSlug/priorityCompSlug: when someone reaches this list by
  // clicking a jersey type/manufacturer FROM a specific jersey, that
  // jersey's own sport (and within it, its own competition) is shown
  // first, with everything else following underneath — more useful than
  // a flat alphabetical dump when you clicked through wanting "more like
  // this one" specifically.
  function renderGroupedBySport(jerseys, prioritySportSlug, priorityCompSlug){
    var bySport = {};
    jerseys.forEach(function(j){ var s=j.teams.competitions.sports; (bySport[s.slug]=bySport[s.slug]||{sport:s,jerseys:[]}).jerseys.push(j); });
    var sportOrder = Object.keys(bySport).sort(function(a,b){
      if(prioritySportSlug && a === prioritySportSlug) return -1;
      if(prioritySportSlug && b === prioritySportSlug) return 1;
      return bySport[a].sport.name.localeCompare(bySport[b].sport.name);
    });
    return sportOrder.map(function(slug){
      var entry = bySport[slug];
      var byComp = {};
      entry.jerseys.forEach(function(j){ var c=j.teams.competitions; (byComp[c.slug]=byComp[c.slug]||{comp:c,jerseys:[]}).jerseys.push(j); });
      var compOrder = Object.keys(byComp).sort(function(a,b){
        if(priorityCompSlug && a === priorityCompSlug) return -1;
        if(priorityCompSlug && b === priorityCompSlug) return 1;
        return byComp[a].comp.name.localeCompare(byComp[b].comp.name);
      });
      var compBlocks = compOrder.map(function(cslug){
        var centry = byComp[cslug];
        var cards = centry.jerseys.sort(function(a,b){return seasonSortKey(b.season)-seasonSortKey(a.season);}).map(function(j){ return jerseyCard(j, j.teams, {showTeam:true}); });
        return '<div class="season-group"><h3><a class="spec-link" href="#/sport/'+entry.sport.slug+'/'+cslug+'">'+esc(centry.comp.name)+'</a></h3>'+limitedJerseyGrid(cards)+'</div>';
      }).join('');
      return '<section class="block"><div class="section-head"><h2><a class="spec-link" href="#/sport/'+slug+'">'+esc(entry.sport.name)+'</a></h2></div>'+compBlocks+'</section>';
    }).join('');
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
  var SEARCH_PHRASE_ALIASES = {
    'man utd':'manchester united', 'man city':'manchester city', 'psg':'paris saint germain',
    'hull kr':'hull kingston rovers'
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
      return '<div class="season-group"><h3>'+esc(entry.sport.name)+'</h3><div class="team-list-compact">'+rows+'</div></div>';
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

    var jerseyRows = await fetchAllRows('jerseys', '*, jersey_images(*), teams(*, competitions(*, sports(*)))');
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

  async function viewManufacturer(name){
    setCrumbs([{label:'Home', href:'#/'},{label:'Manufacturers', href:'#/manufacturers'},{label:name, href:'#'}]);
    var jerseys = await fetchAllRows('jerseys', '*, jersey_images(*), teams(*, competitions(*, sports(*)))', function(q){ return q.eq('manufacturer', name); });
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
  function baseJerseyType(t){
    var s = String(t || '');
    var stripped = s.replace(/\s+(v\.?\s*\d+|\d+)$/i, '').replace(/\s+-\s+.+$/, '').trim();
    return stripped || s;
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
    var allJerseys = await fetchAllRows('jerseys', '*, jersey_images(*), teams(*, competitions(*, sports(*)))');
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
          '<li>Fill in the season (a single year like 2024, or a split year like 2024-25 for competitions that span two calendar years), jersey type, and manufacturer if known.</li>' +
          '<li>Attach at least one photo &mdash; front, back, and any other angle all help, and you can label each one.</li>' +
          '<li>Submit. After it&rsquo;s approved, the sport/competition/team/season/manufacturer stay filled in so you can upload the next kit for the same team (say, the away or alternate jersey) without retyping everything &mdash; just swap the photo and jersey type.</li>' +
        '</ol>' +

        '<div class="section-head" style="margin-top:30px;"><h2>A jersey worn in more than one competition</h2></div>' +
        '<p>Some jerseys aren&rsquo;t just worn in one place &mdash; a country&rsquo;s regular kit might also be what they wore at a World Cup, or a club&rsquo;s league kit might also have been worn in a cup competition. Rather than uploading the same photos twice under two different teams, tick &ldquo;Was this jersey also worn in another competition?&rdquo; on the upload form and pick the extra one (or add it if it&rsquo;s not listed &mdash; this is also how to log a jersey worn only in something like a trial match). The jersey still lives under its real team and competition, but now shows up on both competitions&rsquo; pages too.</p>' +
        '<p>This is also why competitions like the FIFA World Cup, Rugby League World Cup, and other major tournaments aren&rsquo;t options in the main Competition field &mdash; they only exist to be tagged on this way, keeping a country&rsquo;s full jersey history together under its real International team instead of splitting it across two pages.</p>' +
        '<p>Already uploaded something that should have this tag? Open the jersey and use &ldquo;Report a problem&rdquo;, or if you&rsquo;re still pending, admins can add it for you from the moderation queue.</p>' +

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
        '<p>To keep things sane for everyone, there are hourly caps per account: up to 120 uploads per hour for either jerseys or team logos, plus 20 extra photos added to existing jerseys. That&rsquo;s far more than a normal upload session needs &mdash; it only kicks in to stop runaway/accidental spam. If you hit it, just wait a bit and carry on.</p>' +

        '<div class="section-head" style="margin-top:30px;"><h2>Spotted a mistake?</h2></div>' +
        '<p>Every jersey, team, and competition page has a &ldquo;Report a problem&rdquo; button at the bottom &mdash; use it for anything wrong (wrong season, wrong team, bad photo) and it goes straight to moderation. You can also just <a class="spec-link" href="https://thejerseydatabase.com/contact.html" target="_blank" rel="noopener">get in touch</a> directly.</p>' +

      '</div>';
  }

  async function viewUpload(){
    setCrumbs([{label:'Home', href:'#/'},{label:'Upload', href:'#/upload'}]);
    if(!currentUser){
      return '<div class="section-head"><h2>Upload a jersey</h2></div>' +
        '<div class="empty-note">Sign in first (top right) &mdash; it just needs an email, no password. Once you click the magic link we send you, come back to this page.</div>';
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
    var mfrOptions = '<option value="">&mdash; Unlisted &mdash;</option>' +
      PRIORITY_MANUFACTURERS.map(function(m){ return '<option value="'+esc(m)+'">'+esc(m)+'</option>'; }).join('') +
      '<option value="__new__">+ Add a new one…</option>';
    var thisYear = new Date().getFullYear();

    return '<div class="section-head"><h2>Upload a jersey</h2></div>' +
      '<p style="font-family:\'IBM Plex Mono\',monospace;font-size:11.5px;color:var(--text-dim2);margin:-10px 0 22px;">* required &mdash; and at least one photo</p>' +
      '<form id="upload-form" novalidate>' +
        '<div class="upload-grid">' +
          '<div class="field"><label for="f-sport">Sport *</label><select id="f-sport" required>'+sportOptions+'</select></div>' +
          '<div class="field" id="field-format" hidden><label for="f-format">Format * <small>cricket has several</small></label><select id="f-format" required></select></div>' +
          '<div class="field"><label for="f-comp-select">Competition * <small>pick or add a new one</small></label>' +
            '<select id="f-comp-select" required><option value="">Select a competition</option></select>' +
            '<div class="new-value-row" id="f-comp-new-row" hidden>' +
              '<input type="text" id="f-comp-new" placeholder="New competition name">' +
              '<button type="button" class="new-value-cancel" id="f-comp-new-cancel" aria-label="Back to list">&#10005;</button>' +
            '</div></div>' +
          '<div class="field"><label for="f-team-select">Team * <small>any level &mdash; local clubs welcome</small></label>' +
            '<select id="f-team-select" required><option value="">Select a competition first</option></select>' +
            '<div class="new-value-row" id="f-team-new-row" hidden>' +
              '<input type="text" id="f-team-new" placeholder="New team name">' +
              '<button type="button" class="new-value-cancel" id="f-team-new-cancel" aria-label="Back to list">&#10005;</button>' +
            '</div></div>' +
          '<div class="field"><label for="f-season">Season * <small>a single year, or a range for split-year comps</small></label>' +
            '<input type="text" id="f-season" placeholder="e.g. '+thisYear+' or '+thisYear+'-'+String(thisYear+1).slice(-2)+'" required></div>' +
          '<div class="field"><label for="f-type-select">Jersey type *</label>' +
            '<select id="f-type-select" required>'+typeOptions+'</select>' +
            '<div class="new-value-row" id="f-type-new-row" hidden>' +
              '<input type="text" id="f-type-new" placeholder="New jersey type">' +
              '<button type="button" class="new-value-cancel" id="f-type-new-cancel" aria-label="Back to list">&#10005;</button>' +
            '</div></div>' +
          '<div class="field" id="f-type-sub-field" hidden><label for="f-type-sub-select">Training type <small>optional &mdash; e.g. warm up, captain&rsquo;s run</small></label>' +
            '<select id="f-type-sub-select">' +
              '<option value="">&mdash; Just &ldquo;Training&rdquo; &mdash;</option>' +
              TRAINING_SUBTYPES.map(function(t){ return '<option value="'+t+'">'+t+'</option>'; }).join('') +
              '<option value="__new__">+ Add a new one&hellip;</option>' +
            '</select>' +
            '<div class="new-value-row" id="f-type-sub-new-row" hidden>' +
              '<input type="text" id="f-type-sub-new" placeholder="New training type">' +
              '<button type="button" class="new-value-cancel" id="f-type-sub-new-cancel" aria-label="Back to list">&#10005;</button>' +
            '</div></div>' +
          '<div class="field"><label for="f-mfr-select">Manufacturer <small>optional &mdash; click the dropdown or click it and start typing to jump to it; add it below if it&rsquo;s not there</small></label>' +
            '<select id="f-mfr-select">'+mfrOptions+'</select>' +
            '<div class="new-value-row" id="f-mfr-new-row" hidden>' +
              '<input type="text" id="f-mfr-new" placeholder="New manufacturer">' +
              '<button type="button" class="new-value-cancel" id="f-mfr-new-cancel" aria-label="Back to list">&#10005;</button>' +
            '</div></div>' +
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
            '<p class="field-hint">If you leave this page before submitting, your typed-in details are kept for next time &mdash; but photos aren&rsquo;t, so you&rsquo;ll need to re-add them.</p>' +
          '</div>' +
          '<div class="field field-full"><label for="f-notes">Additional info <small>optional</small></label><textarea id="f-notes" placeholder="Sponsor changes, special edition, match it was worn in..."></textarea></div>' +
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
  function renderCompetitionMoveControl(prefix, teamId, sportSlug, currentCompSlug){
    return '<div class="comp-move-row">' +
        '<select class="comp-move-select" id="'+prefix+'-comp-select" data-sport-slug="'+esc(sportSlug)+'" data-current="'+esc(currentCompSlug)+'"><option>Loading…</option></select>' +
        '<button class="btn btn-secondary" id="'+prefix+'-comp-move-btn" data-team-id="'+teamId+'" type="button">Move</button>' +
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
  async function wireCompetitionMoveControl(prefix, onMoved){
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
      var upd = await supabaseClient.from('teams').update({competition_slug: newSlug}).eq('id', btn.dataset.teamId);
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

  // kind is 'team' or 'competition' — same shape of tables for both
  // (a live *_logos history + a logo_path pointer on the main row).
  function logoTables(kind){
    return kind === 'team'
      ? {history: 'team_logos', main: 'teams', refCol: 'team_id', idCol: 'id'}
      : {history: 'competition_logos', main: 'competitions', refCol: 'competition_slug', idCol: 'slug'};
  }
  async function setLogo(kind, refId, path){
    var t = logoTables(kind);
    // never overwrite history — the previous logo just stops being "current"
    var unmark = await supabaseClient.from(t.history).update({is_current:false}).eq(t.refCol, refId).eq('is_current', true);
    if(unmark.error) throw unmark.error;
    var histRow = {storage_path: path, is_current: true};
    histRow[t.refCol] = refId;
    var histIns = await supabaseClient.from(t.history).insert(histRow);
    if(histIns.error) throw histIns.error;
    var mainUpd = await supabaseClient.from(t.main).update({logo_path: path}).eq(t.idCol, refId);
    if(mainUpd.error) throw mainUpd.error;
  }

  async function viewModerate(){
    setCrumbs([{label:'Home', href:'#/'},{label:'Moderate', href:'#/moderate'}]);
    if(!currentUser || !currentProfile || !currentProfile.is_admin){
      return '<div class="empty-note">Not authorized.</div>';
    }
    await refreshAuthUI(); // keeps the topbar count in sync even after changes made outside the app (e.g. deleting rows directly in Supabase)

    var jRes = await supabaseClient.from('jerseys')
      .select('*, jersey_images(*), teams(id, name, competition_slug, competitions(slug, name, sport_slug, sports(name)))')
      .eq('status', 'pending').order('created_at');
    if(jRes.error) throw jRes.error;
    var pendingJerseys = jRes.data || [];

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
    var compLogoRes = await supabaseClient.from('competition_logo_proposals').select('*, competitions(name)').eq('status', 'pending').order('created_at');
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

    if(!pendingJerseys.length && !pendingPhotos.length && !openReports.length && !pendingLogos.length && !pendingCompLogos.length){
      return '<div class="section-head"><h2>Moderation queue</h2></div><div class="empty-note">Nothing waiting for review.</div>';
    }

    var jerseyCards = pendingJerseys.map(function(j){
      var team = j.teams, comp = team.competitions, sport = comp.sports;
      var uploader = uploaderNames[j.uploaded_by] || 'unknown';
      var images = sortImagesForDisplay(j.jersey_images);
      var thumb = images.length
        ? '<img class="lightbox-trigger" src="'+esc(publicImageUrl(images[0].storage_path))+'" alt="">'
        : '<div class="thumb-placeholder" style="background:var(--surface-2)"><span>No photo</span></div>';
      // All submitted photos, not just the first — admin needs to check
      // every one for wrong/bad images before approving, not just the
      // thumbnail. The label dropdown lets a mislabeled front/back get
      // fixed right here, which also fixes which one shows as the main
      // image (that's always whichever one is labeled "Front").
      var allPhotosHtml = images.length > 1
        ? '<div class="logo-history-grid lightbox-group" style="margin-top:8px;">' + images.map(function(img){
            return '<div class="logo-history-item"><img class="lightbox-trigger" src="'+esc(publicImageUrl(img.storage_path))+'" alt="">' +
              '<select class="photo-label-select" data-image-id="'+img.id+'">' +
                ['Front','Back','Other'].map(function(l){ return '<option value="'+l+'"'+(img.label===l?' selected':'')+'>'+l+'</option>'; }).join('') +
              '</select>' +
            '</div>';
          }).join('') + '</div>'
        : '';
      var moveId = 'mod-jersey-'+j.id;
      var reassignId = 'mod-reassign-'+j.id;
      var editId = 'mod-edit-'+j.id;
      var rejectId = 'mod-reject-'+j.id;
      return '<div class="mod-card">' +
        '<div class="jersey-thumb">'+thumb+'</div>' +
        '<div class="mod-info">' +
          '<strong>'+j.season+' '+esc(team.name)+' '+esc(j.type)+'</strong>' +
          '<span>'+esc(comp.name)+' · '+esc(sport.name)+' · by '+esc(uploader)+'</span>' +
          '<span>Manufacturer: '+esc(j.manufacturer || 'Unlisted')+'</span>' +
          (j.format ? '<span>Format: '+esc(j.format)+'</span>' : '') +
          (j.notes ? '<span>Notes: '+esc(j.notes)+'</span>' : '') +
          (extraCompByJersey[j.id] ? '<span>Also used in: '+esc(extraCompByJersey[j.id].name)+'</span>' : '') +
          allPhotosHtml +
          '<button class="chip comp-move-toggle" data-target="'+moveId+'" type="button">Wrong competition?</button>' +
          '<div class="comp-move-panel" id="'+moveId+'" hidden>'+renderCompetitionMoveControl(moveId, team.id, comp.sport_slug, comp.slug)+'</div>' +
          '<button class="chip mod-reassign-toggle" data-target="'+reassignId+'" type="button">Wrong team or sport?</button>' +
          '<div class="comp-move-panel" id="'+reassignId+'" hidden data-sport-slug="'+esc(sport.slug)+'">'+renderJerseyReassignControl(reassignId, j.id)+'</div>' +
          '<button class="chip mod-edit-toggle" data-target="'+editId+'" type="button">Edit details</button>' +
          '<div class="comp-move-panel" id="'+editId+'" hidden style="max-width:420px;">' +
            '<div class="comp-move-row">' +
              '<input type="text" class="comp-move-new-input" id="edit-season-'+j.id+'" placeholder="Season" value="'+esc(j.season)+'">' +
              '<input type="text" class="comp-move-new-input" id="edit-type-'+j.id+'" placeholder="Jersey type" value="'+esc(j.type)+'">' +
            '</div>' +
            '<div class="comp-move-row" style="margin-top:10px;">' +
              '<input type="text" class="comp-move-new-input" id="edit-mfr-'+j.id+'" placeholder="Manufacturer" value="'+esc(j.manufacturer || '')+'">' +
              '<input type="text" class="comp-move-new-input" id="edit-format-'+j.id+'" placeholder="Format (cricket only)" value="'+esc(j.format || '')+'">' +
            '</div>' +
            '<textarea class="report-textarea" id="edit-notes-'+j.id+'" placeholder="Additional info" style="margin-top:10px;">'+esc(j.notes || '')+'</textarea>' +
            (function(){
              var currentExtra = extraCompByJersey[j.id];
              var sameSportComps = allComps.filter(function(c){ return c.sport_slug === sport.slug && c.slug !== comp.slug; });
              return '<label class="rate-label" style="margin-top:10px;">Also used in</label>' +
                '<select id="edit-extra-comp-'+j.id+'" style="width:100%;"><option value="">&mdash; None &mdash;</option>' +
                sameSportComps.map(function(c){ return '<option value="'+esc(c.slug)+'"'+(currentExtra && currentExtra.slug===c.slug?' selected':'')+'>'+esc(c.name)+'</option>'; }).join('') +
                '</select>';
            })() +
            '<button class="btn btn-secondary" data-save-edit="'+j.id+'" type="button">Save changes</button>' +
            '<p class="field-hint" id="edit-msg-'+j.id+'" hidden></p>' +
          '</div>' +
        '</div>' +
        '<div class="mod-actions">' +
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
        '<div class="jersey-thumb"><img class="lightbox-trigger" src="'+esc(publicImageUrl(img.storage_path))+'" alt=""></div>' +
        '<div class="mod-info">' +
          '<strong>'+esc(img.label)+' photo for '+(j ? j.season+' '+esc(team.name)+' '+esc(j.type) : 'a jersey')+'</strong>' +
          '<span>proposed by '+esc(uploader)+'</span>' +
        '</div>' +
        '<div class="mod-actions">' +
          (j ? '<a class="btn btn-secondary" href="#/jersey/'+j.id+'" target="_blank" style="text-decoration:none;">View jersey</a>' : '') +
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
        ? '<div class="jersey-thumb"><img class="lightbox-trigger" src="'+esc(supabaseClient.storage.from('report-attachments').getPublicUrl(r.attachment_path).data.publicUrl)+'" alt=""></div>'
        : '';
      var useAsLogoBtn = (r.attachment_path && r.page_type === 'team')
        ? '<button class="btn" data-type="report-logo" data-action="use" data-id="'+r.id+'" data-team-id="'+esc(r.page_ref)+'" data-path="'+esc(r.attachment_path)+'" type="button">Use as team logo</button>'
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
      return '<div class="mod-card">' +
        '<div class="jersey-thumb"><img class="lightbox-trigger" src="'+esc(publicLogoUrl(l.storage_path))+'" alt=""></div>' +
        '<div class="mod-info">' +
          '<strong>Logo for '+(l.teams ? esc(l.teams.name) : 'a team')+'</strong>' +
          '<span>proposed by '+esc(proposer)+'</span>' +
        '</div>' +
        '<div class="mod-actions">' +
          '<button class="btn" data-type="logo" data-action="approve" data-id="'+l.id+'" data-team-id="'+l.team_id+'" data-path="'+esc(l.storage_path)+'" type="button">Approve</button>' +
          '<button class="btn btn-reject" data-type="logo" data-action="reject" data-id="'+l.id+'" data-path="'+esc(l.storage_path)+'" type="button">Reject</button>' +
        '</div>' +
      '</div>';
    }).join('');

    var compLogoCards = pendingCompLogos.map(function(l){
      var proposer = uploaderNames[l.proposed_by] || 'unknown';
      return '<div class="mod-card">' +
        '<div class="jersey-thumb"><img class="lightbox-trigger" src="'+esc(publicLogoUrl(l.storage_path))+'" alt=""></div>' +
        '<div class="mod-info">' +
          '<strong>Logo for '+(l.competitions ? esc(l.competitions.name) : 'a competition')+'</strong>' +
          '<span>proposed by '+esc(proposer)+'</span>' +
        '</div>' +
        '<div class="mod-actions">' +
          '<button class="btn" data-type="comp-logo" data-action="approve" data-id="'+l.id+'" data-comp-slug="'+esc(l.competition_slug)+'" data-path="'+esc(l.storage_path)+'" type="button">Approve</button>' +
          '<button class="btn btn-reject" data-type="comp-logo" data-action="reject" data-id="'+l.id+'" data-path="'+esc(l.storage_path)+'" type="button">Reject</button>' +
        '</div>' +
      '</div>';
    }).join('');

    return '<div class="section-head"><h2>Moderation queue</h2></div>' +
      '<section class="block"><div class="section-head"><h2>New jerseys</h2><span class="count">'+pendingJerseys.length+' pending</span></div>' +
        (jerseyCards ? '<div class="mod-list">'+jerseyCards+'</div>' : '<div class="empty-note">None waiting.</div>') +
      '</section>' +
      '<section class="block"><div class="section-head"><h2>Proposed photos</h2><span class="count">'+pendingPhotos.length+' pending</span></div>' +
        (photoCards ? '<div class="mod-list">'+photoCards+'</div>' : '<div class="empty-note">None waiting.</div>') +
      '</section>' +
      '<section class="block"><div class="section-head"><h2>Team logo proposals</h2><span class="count">'+pendingLogos.length+' pending</span></div>' +
        (logoCards ? '<div class="mod-list">'+logoCards+'</div>' : '<div class="empty-note">None waiting.</div>') +
      '</section>' +
      '<section class="block"><div class="section-head"><h2>Competition logo proposals</h2><span class="count">'+pendingCompLogos.length+' pending</span></div>' +
        (compLogoCards ? '<div class="mod-list">'+compLogoCards+'</div>' : '<div class="empty-note">None waiting.</div>') +
      '</section>' +
      '<section class="block"><div class="section-head"><h2>Reports</h2><span class="count">'+openReports.length+' open</span></div>' +
        (reportCards ? '<div class="mod-list">'+reportCards+'</div>' : '<div class="empty-note">None open.</div>') +
      '</section>';
  }

  async function viewUserProfile(username){
    setCrumbs([{label:'Home', href:'#/'},{label:username, href:'#'}]);
    var profRes = await supabaseClient.from('profiles').select('*').eq('username', username).maybeSingle();
    if(profRes.error) throw profRes.error;
    if(!profRes.data) return '<div class="empty-note">No user found with that username.</div>';
    var profile = profRes.data;

    var jRes = await supabaseClient.from('jerseys')
      .select('*, jersey_images(*), teams(name, slug, primary_color, secondary_color, competition_slug)')
      .eq('uploaded_by', profile.id).eq('status', 'approved').order('created_at', {ascending:false});
    if(jRes.error) throw jRes.error;
    var jerseys = jRes.data || [];
    var cards = jerseys.map(function(j){ return jerseyCard(j, j.teams, {showTeam:true}); }).join('');

    var teamLogoRes = await supabaseClient.from('team_logo_proposals')
      .select('*, teams(name, slug, competition_slug, competitions!inner(sport_slug))')
      .eq('proposed_by', profile.id).eq('status', 'approved').order('created_at', {ascending:false});
    var compLogoRes = await supabaseClient.from('competition_logo_proposals')
      .select('*, competitions(name, slug, sport_slug)')
      .eq('proposed_by', profile.id).eq('status', 'approved').order('created_at', {ascending:false});
    var logoCards = (teamLogoRes.data || []).map(function(l){ return logoCard(l, l.teams, {label:'Team logo'}); })
      .concat((compLogoRes.data || []).map(function(l){ return compLogoCard(l, l.competitions, {label:'Competition logo'}); }))
      .join('');
    var logoSectionHtml = logoCards
      ? '<div class="section-head" style="margin-top:34px;"><h2>Logos contributed</h2></div><div class="jersey-grid">'+logoCards+'</div>'
      : '';

    return '<div class="section-head"><h2>'+esc(profile.username)+' '+pointsChip(profile.points)+'</h2><span class="count">'+jerseys.length+' upload'+(jerseys.length===1?'':'s')+'</span></div>' +
      (cards ? '<div class="jersey-grid">'+cards+'</div>' : '<div class="empty-note">No approved uploads yet.</div>') +
      logoSectionHtml;
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
      else if(parts[0]==='sport' && parts.length===3){ html = await viewCompetition(parts[1], parts[2]); }
      else if(parts[0]==='sport' && parts.length===5 && parts[3]==='team'){ html = await viewTeam(parts[1], parts[2], parts[4]); }
      else if(parts[0]==='sport' && parts.length===5 && parts[3]==='season'){ html = await viewSeason(parts[1], parts[2], parts[4]); }
      else if(parts[0]==='jersey' && parts[1]){ html = await viewJerseyDetail(parts[1]); }
      else if(parts[0]==='search' && parts[1]){ html = await viewSearch(parts[1]); }
      else if(parts[0]==='manufacturers' && parts.length===1){ html = await viewManufacturers(); }
      else if(parts[0]==='manufacturer' && parts[1]){ html = await viewManufacturer(parts[1]); }
      else if(parts[0]==='types' && parts.length===1){ html = await viewTypes(); }
      else if(parts[0]==='type' && parts[1]){ html = await viewType(parts[1], parts[2], parts[3]); }
      else if(parts[0]==='upload'){ html = await viewUpload(); }
      else if(parts[0]==='help'){ html = viewHelp(); }
      else if(parts[0]==='moderate'){ html = await viewModerate(); }
      else if(parts[0]==='user' && parts[1]){ html = await viewUserProfile(parts[1]); }
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
          card.hidden = card.querySelector('h3').textContent.toLowerCase().indexOf(q) === -1;
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

    var addPhotosToggle = document.getElementById('add-photos-toggle');
    if(addPhotosToggle){
      addPhotosToggle.addEventListener('click', function(){
        var panel = document.getElementById('add-photos-panel');
        if(!panel.dataset.wired){
          panel.dataset.wired = '1';
          panel.innerHTML = renderAddPhotosPanel();
          wireAddPhotosPanel(addPhotosToggle.dataset.jerseyId);
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
          panel.querySelectorAll('.photo-label-select').forEach(function(sel){
            sel.addEventListener('change', async function(){
              sel.disabled = true;
              var upd = await supabaseClient.from('jersey_images').update({label: sel.value}).eq('id', sel.dataset.imageId);
              sel.disabled = false;
              if(upd.error){ alert('Error: ' + upd.error.message); return; }
              render();
            });
          });
          wireJerseyReassignControl('jersey-reassign', panel.dataset.sportSlug, function(){ render(); });
          wireJerseyExtraCompsControl(parts[1], panel.dataset.sportSlug);
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
    var res = await supabaseClient.from(t.history).select('*').eq(t.refCol, refId).order('approved_at', {ascending:false});
    if(res.error){ panel.innerHTML = errorBox(res.error); return; }
    var rows = res.data || [];
    var isAdmin = currentProfile && currentProfile.is_admin;
    panel.innerHTML = rows.length
      ? '<div class="logo-history-grid lightbox-group">' + rows.map(function(r){
          var caption = r.years_used ? esc(r.years_used) : (r.is_current ? 'Current' : 'Added '+fmtDate(r.approved_at));
          var editBtn = isAdmin ? ' <button class="edit-pencil-btn" type="button" data-logo-id="'+r.id+'" data-current="'+esc(r.years_used || '')+'">'+ICON_PENCIL+'</button>' : '';
          return '<div class="logo-history-item"><img class="lightbox-trigger" src="'+esc(publicLogoUrl(r.storage_path))+'" alt="">' +
            '<div class="spec-value-row"><span>'+caption+'</span>'+editBtn+'</div></div>';
        }).join('') + '</div>'
      : '<div class="empty-note">No logo history yet.</div>';
    panel.querySelectorAll('.edit-pencil-btn').forEach(function(btn){
      btn.addEventListener('click', function(){
        var row = btn.closest('.spec-value-row');
        row.innerHTML = '<input type="text" class="inline-edit-input" value="'+esc(btn.dataset.current)+'" placeholder="e.g. 1990–1999">' +
          '<button class="inline-save-btn" type="button">Save</button>' +
          '<button class="inline-cancel-btn" type="button">Cancel</button>';
        var input = row.querySelector('.inline-edit-input');
        input.focus();
        if(input.select) input.select();
        row.querySelector('.inline-cancel-btn').addEventListener('click', function(){ refreshLogoHistoryPanel(kind, refId); });
        row.querySelector('.inline-save-btn').addEventListener('click', async function(){
          var newVal = input.value.trim();
          var upd = await supabaseClient.from(t.history).update({years_used: newVal || null}).eq('id', btn.dataset.logoId);
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

  function renderAddPhotosPanel(){
    return '<div class="dropzone" id="ap-dropzone" tabindex="0" role="button" aria-label="Add photos">' +
        ICON_PHOTO +
        '<p>Drop photos here, or click to choose</p>' +
        '<input type="file" id="ap-photos-input" accept="image/*" multiple style="display:none;">' +
      '</div>' +
      '<div class="photo-previews" id="ap-photo-previews"></div>' +
      '<p class="field-error" id="ap-photo-error" hidden>Add at least one photo before submitting.</p>' +
      '<div style="margin-top:14px;"><button class="btn" id="ap-submit-btn" type="button">Submit for review</button></div>' +
      '<div id="ap-result"></div>';
  }

  function wireAddPhotosPanel(jerseyId){
    var selected = [];
    var dropzone = document.getElementById('ap-dropzone');
    var input = document.getElementById('ap-photos-input');
    var previewsEl = document.getElementById('ap-photo-previews');
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
        sel.addEventListener('change', function(){ selected[Number(sel.dataset.idx)].label = sel.value; });
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
      Array.from(fileList).forEach(function(file){
        if(!/^image\//.test(file.type)) return;
        selected.push({file: file, label: labelForIndex(selected.length), url: URL.createObjectURL(file)});
      });
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
        for(var i=0; i<selected.length; i++){
          var p = selected[i];
          var ext = (p.file.name.split('.').pop() || 'jpg').toLowerCase();
          var path = jerseyId + '/proposed-' + slugify(p.label) + '-' + i + '-' + Date.now() + '.' + ext;
          var up = await supabaseClient.storage.from('jersey-photos').upload(path, p.file);
          if(up.error) throw up.error;
          var ins = await supabaseClient.from('jersey_images').insert({
            jersey_id: jerseyId, storage_path: path, label: p.label, status: 'pending', uploaded_by: currentUser.id
          });
          if(ins.error) throw ins.error;
        }
        document.getElementById('ap-result').innerHTML = '<p class="field-hint is-match" style="margin-top:10px;">Submitted for review — thanks!</p>';
        selected.forEach(function(p){ URL.revokeObjectURL(p.url); });
        selected.length = 0;
        renderPreviews();
      } catch(err) {
        document.getElementById('ap-result').innerHTML = errorBox(err);
      } finally {
        btn.disabled = false; btn.textContent = 'Submit for review';
      }
    });
  }

  function renderProposeLogoPanel(){
    return '<div class="dropzone" id="pl-dropzone" tabindex="0" role="button" aria-label="Add a logo">' +
        ICON_PHOTO +
        '<p>Drop a logo image here, or click to choose</p>' +
        '<input type="file" id="pl-logo-input" accept="image/*" style="display:none;">' +
      '</div>' +
      '<div class="photo-previews" id="pl-logo-preview"></div>' +
      '<p class="field-error" id="pl-logo-error" hidden>Choose an image before submitting.</p>' +
      '<div style="margin-top:14px;"><button class="btn" id="pl-submit-btn" type="button" disabled>Submit for review</button></div>' +
      '<div id="pl-result"></div>';
  }

  function wireProposeLogoPanel(kind, refId){
    var proposalTable = kind === 'team' ? 'team_logo_proposals' : 'competition_logo_proposals';
    var refCol = kind === 'team' ? 'team_id' : 'competition_slug';
    var pathPrefix = kind === 'team' ? refId : 'comp-' + refId;
    var picked = null;
    var dropzone = document.getElementById('pl-dropzone');
    var input = document.getElementById('pl-logo-input');
    var previewEl = document.getElementById('pl-logo-preview');
    var submitBtn = document.getElementById('pl-submit-btn');

    function setFile(file){
      if(!file || !/^image\//.test(file.type)) return;
      if(picked) URL.revokeObjectURL(picked.url);
      picked = {file: file, url: URL.createObjectURL(file)};
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

    submitBtn.addEventListener('click', async function(){
      var errorEl = document.getElementById('pl-logo-error');
      if(!picked){ errorEl.hidden = false; return; }
      errorEl.hidden = true;
      submitBtn.disabled = true; submitBtn.textContent = 'Submitting…';
      try {
        var ext = (picked.file.name.split('.').pop() || 'png').toLowerCase();
        var path = pathPrefix + '/logo-' + Date.now() + '.' + ext;
        var up = await supabaseClient.storage.from('team-logos').upload(path, picked.file);
        if(up.error) throw up.error;
        var proposalRow = {storage_path: path, proposed_by: currentUser.id};
        proposalRow[refCol] = refId;
        var ins = await supabaseClient.from(proposalTable).insert(proposalRow);
        if(ins.error) throw ins.error;
        document.getElementById('pl-result').innerHTML = '<p class="field-hint is-match" style="margin-top:10px;">Submitted for review — thanks!</p>';
        URL.revokeObjectURL(picked.url);
        picked = null;
        previewEl.innerHTML = '';
      } catch(err) {
        document.getElementById('pl-result').innerHTML = errorBox(err);
      } finally {
        submitBtn.disabled = false; submitBtn.textContent = 'Submit for review';
      }
    });
  }

  function wireModerationActions(){
    document.querySelectorAll('.mod-card .photo-label-select').forEach(function(sel){
      sel.addEventListener('change', async function(){
        sel.disabled = true;
        var upd = await supabaseClient.from('jersey_images').update({label: sel.value}).eq('id', sel.dataset.imageId);
        sel.disabled = false;
        if(upd.error){ alert('Error: ' + upd.error.message); return; }
        render();
      });
    });
    document.querySelectorAll('.comp-move-toggle').forEach(function(toggle){
      toggle.addEventListener('click', function(){
        var panel = document.getElementById(toggle.dataset.target);
        if(!panel.dataset.wired){
          panel.dataset.wired = '1';
          panel.hidden = false;
          wireCompetitionMoveControl(toggle.dataset.target, function(){ render(); });
          return;
        }
        panel.hidden = !panel.hidden;
      });
    });
    document.querySelectorAll('.mod-reassign-toggle').forEach(function(toggle){
      toggle.addEventListener('click', function(){
        var panel = document.getElementById(toggle.dataset.target);
        if(!panel.dataset.wired){
          panel.dataset.wired = '1';
          panel.hidden = false;
          wireJerseyReassignControl(toggle.dataset.target, panel.dataset.sportSlug, function(){ render(); });
          return;
        }
        panel.hidden = !panel.hidden;
      });
    });
    document.querySelectorAll('.mod-edit-toggle, .mod-reject-toggle').forEach(function(toggle){
      toggle.addEventListener('click', function(){
        var panel = document.getElementById(toggle.dataset.target);
        panel.hidden = !panel.hidden;
      });
    });
    document.querySelectorAll('[data-save-edit]').forEach(function(btn){
      btn.addEventListener('click', async function(){
        var id = btn.dataset.saveEdit;
        var msg = document.getElementById('edit-msg-'+id);
        var season = document.getElementById('edit-season-'+id).value.trim();
        var type = document.getElementById('edit-type-'+id).value.trim();
        var manufacturer = document.getElementById('edit-mfr-'+id).value.trim();
        var format = document.getElementById('edit-format-'+id).value.trim();
        var notes = document.getElementById('edit-notes-'+id).value.trim();
        if(!season || !type){
          msg.hidden = false; msg.className = 'field-error'; msg.textContent = 'Season and jersey type can\'t be blank.';
          return;
        }
        btn.disabled = true; btn.textContent = 'Saving…';
        var upd = await supabaseClient.from('jerseys').update({
          season: season, type: type, manufacturer: manufacturer || null, format: format || null, notes: notes || null
        }).eq('id', id);
        if(upd.error){
          btn.disabled = false; btn.textContent = 'Save changes';
          msg.hidden = false; msg.className = 'field-error'; msg.textContent = 'Error: ' + upd.error.message;
          return;
        }
        var extraCompEl = document.getElementById('edit-extra-comp-'+id);
        if(extraCompEl){
          var del = await supabaseClient.from('jersey_competitions').delete().eq('jersey_id', id);
          if(!del.error && extraCompEl.value){
            var ins = await supabaseClient.from('jersey_competitions').insert({jersey_id: id, competition_slug: extraCompEl.value});
            if(ins.error){
              btn.disabled = false; btn.textContent = 'Save changes';
              msg.hidden = false; msg.className = 'field-error'; msg.textContent = 'Error: ' + ins.error.message;
              return;
            }
          }
        }
        btn.disabled = false; btn.textContent = 'Save changes';
        render();
      });
    });
    document.querySelectorAll('[data-confirm-reject]').forEach(function(btn){
      btn.addEventListener('click', async function(){
        var id = btn.dataset.confirmReject;
        var msg = document.getElementById('reject-msg-'+id);
        var reason = document.getElementById('reject-reason-'+id).value.trim() || null;
        btn.disabled = true; btn.textContent = 'Rejecting…';
        // kept, not deleted — status flips to 'rejected' with an optional
        // reason so the uploader can see why and fix it, rather than the
        // submission just vanishing with no explanation.
        var upd = await supabaseClient.from('jerseys').update({status:'rejected', rejection_reason: reason}).eq('id', id);
        btn.disabled = false; btn.textContent = 'Confirm reject';
        if(upd.error){
          msg.hidden = false; msg.className = 'field-error'; msg.textContent = 'Error: ' + upd.error.message;
          return;
        }
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
            await setLogo('team', teamId, newPath);
            var repRes2 = await supabaseClient.from('reports').update({status:'resolved'}).eq('id', id);
            if(repRes2.error) throw repRes2.error;
            await supabaseClient.storage.from('report-attachments').remove([oldPath]);
          } else if(type === 'logo' || type === 'comp-logo'){
            var logoKind = type === 'logo' ? 'team' : 'competition';
            var logoProposalTable = type === 'logo' ? 'team_logo_proposals' : 'competition_logo_proposals';
            var logoRefId = type === 'logo' ? btn.dataset.teamId : btn.dataset.compSlug;
            if(btn.dataset.action === 'approve'){
              await setLogo(logoKind, logoRefId, btn.dataset.path);
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
  }

  function wireUploadForm(){
    var form = document.getElementById('upload-form');
    if(!form) return;
    var sportSel = document.getElementById('f-sport');
    var compSelect = document.getElementById('f-comp-select');
    var compNewRow = document.getElementById('f-comp-new-row');
    var compNew = document.getElementById('f-comp-new');
    var teamSelect = document.getElementById('f-team-select');
    var teamNewRow = document.getElementById('f-team-new-row');
    var teamNew = document.getElementById('f-team-new');
    var seasonInput = document.getElementById('f-season');
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
          notes: document.getElementById('f-notes').value
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
        sel.addEventListener('change', function(){ selectedPhotos[Number(sel.dataset.idx)].label = sel.value; });
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
      Array.from(fileList).forEach(function(file){
        if(!/^image\//.test(file.type)) return;
        selectedPhotos.push({file: file, label: labelForIndex(selectedPhotos.length), url: URL.createObjectURL(file)});
      });
      renderPhotoPreviews();
    }
    dropzone.addEventListener('click', function(){ photosInput.click(); });
    dropzone.addEventListener('keydown', function(e){ if(e.key === 'Enter' || e.key === ' '){ e.preventDefault(); photosInput.click(); } });
    photosInput.addEventListener('change', function(){ addPhotoFiles(photosInput.files); photosInput.value = ''; });
    dropzone.addEventListener('dragover', function(e){ e.preventDefault(); dropzone.classList.add('is-dragover'); });
    dropzone.addEventListener('dragleave', function(){ dropzone.classList.remove('is-dragover'); });
    dropzone.addEventListener('drop', function(e){
      e.preventDefault();
      dropzone.classList.remove('is-dragover');
      if(e.dataTransfer && e.dataTransfer.files) addPhotoFiles(e.dataTransfer.files);
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
      var r = await q.order('tier', {ascending:false}).order('name');
      if(r.error) throw r.error;
      return r.data || [];
    }
    async function refreshComps(){
      var comps = await competitionsForSport(sportSel.value);
      compSelect.innerHTML = '<option value="">Select a competition</option>' +
        comps.map(function(c){ return '<option value="'+esc(c.name)+'">'+esc(c.name)+'</option>'; }).join('') +
        '<option value="__new__">+ Add a new competition…</option>';
      compSelect.hidden = false; compNewRow.hidden = true; compNew.value = ''; compNew.required = false;
      await refreshTeams();
      await refreshExtraComps();
    }
    async function refreshTeams(){
      var val = compSelect.value;
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
      var comps = await competitionsForSport(sportSel.value);
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
    function refreshFormat(){
      var formats = FORMATS_BY_SPORT[sportSel.value];
      formatField.hidden = !formats;
      formatSel.required = !!formats;
      formatSel.innerHTML = formats ? formats.map(function(f){ return '<option>'+f+'</option>'; }).join('') : '';
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

      var curatedTypes = CURATED_TYPES.concat(EXTRA_TYPES_BY_SPORT[sportSlug] || []);
      var typeExtra = Object.keys(typeCounts).filter(function(t){ return curatedTypes.indexOf(t) === -1; })
        .sort(function(a,b){ return typeCounts[b] - typeCounts[a]; });
      typeSelect.innerHTML = '<option value="">Select a type</option>' +
        curatedTypes.concat(typeExtra).map(function(t){ return '<option value="'+esc(t)+'">'+esc(t)+'</option>'; }).join('') +
        '<option value="__new__">+ Add a new one…</option>';
      typeSelect.hidden = false; typeNewRow.hidden = true; typeNew.value = ''; typeNew.required = false;
      refreshTypeSubVisibility();

      // Priority brands first, then whatever's actually popular in this
      // sport, then everything else already used ANYWHERE on the site
      // (alphabetical) so a brand added for one sport doesn't look "new"
      // again just because this is its first time in a different sport.
      var mfrExtra = Object.keys(mfrCounts).filter(function(m){ return PRIORITY_MANUFACTURERS.indexOf(m) === -1; })
        .sort(function(a,b){ return mfrCounts[b] - mfrCounts[a]; });
      var listedSoFar = {};
      PRIORITY_MANUFACTURERS.concat(mfrExtra).forEach(function(m){ listedSoFar[m] = true; });
      var mfrRest = globalMfrs.filter(function(m){ return !listedSoFar[m]; }).sort();
      mfrSelect.innerHTML = '<option value="">&mdash; Unlisted &mdash;</option>' +
        PRIORITY_MANUFACTURERS.concat(mfrExtra).concat(mfrRest).map(function(m){ return '<option value="'+esc(m)+'">'+esc(m)+'</option>'; }).join('') +
        '<option value="__new__">+ Add a new one…</option>';
      mfrSelect.hidden = false; mfrNewRow.hidden = true; mfrNew.value = ''; mfrNew.required = false;
    }

    sportSel.addEventListener('change', function(){ refreshComps(); refreshFormat(); refreshMfrTypeOptions(); saveDraft(); });
    compSelect.addEventListener('change', function(){ syncNewVisibility(compSelect, compNewRow, compNew, true); refreshTeams(); refreshExtraComps(); saveDraft(); });
    teamSelect.addEventListener('change', function(){ syncNewVisibility(teamSelect, teamNewRow, teamNew, true); saveDraft(); });
    typeSelect.addEventListener('change', function(){ syncNewVisibility(typeSelect, typeNewRow, typeNew, true); refreshTypeSubVisibility(); saveDraft(); });
    typeSubSelect.addEventListener('change', function(){ syncNewVisibility(typeSubSelect, typeSubNewRow, typeSubNew, false); saveDraft(); });
    mfrSelect.addEventListener('change', function(){ syncNewVisibility(mfrSelect, mfrNewRow, mfrNew, false); saveDraft(); });
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
    wireNewCancel(teamSelect, teamNewRow, teamNew, true);
    wireNewCancel(typeSelect, typeNewRow, typeNew, true);
    wireNewCancel(typeSubSelect, typeSubNewRow, typeSubNew, false);
    wireNewCancel(mfrSelect, mfrNewRow, mfrNew, false);
    wireNewCancel(extraCompSel, extraCompNewRow, extraCompNew, false);
    [compNew, teamNew, seasonInput, typeNew, typeSubNew, mfrNew, extraCompNew, document.getElementById('f-notes')].forEach(function(el){
      el.addEventListener('input', saveDraft);
      el.addEventListener('change', saveDraft);
    });

    (async function init(){
      if(restoredDraft && restoredDraft.sport) sportSel.value = restoredDraft.sport;
      await refreshComps();
      refreshFormat();
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
        }
        if(restoredDraft.season) seasonInput.value = restoredDraft.season;
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
        if(restoredDraft.mfr){
          mfrSelect.value = restoredDraft.mfr.v || '';
          syncNewVisibility(mfrSelect, mfrNewRow, mfrNew, false);
          mfrNew.value = restoredDraft.mfr.n || '';
        }
        if(restoredDraft.notes) document.getElementById('f-notes').value = restoredDraft.notes;
      }
    })();

    form.addEventListener('submit', async function(e){
      e.preventDefault();
      if(!form.reportValidity()) return;

      var seasonVal = seasonInput.value.trim();
      if(!/^\d{4}(-\d{2})?$/.test(seasonVal)){
        seasonInput.setCustomValidity('Enter a year (e.g. 2024) or a split-year season (e.g. 2024-25)');
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
          if(typeSub) type = 'Training - ' + typeSub;
        }
        var manufacturer = fieldValue(mfrSelect, mfrNew) || null;
        var format = FORMATS_BY_SPORT[sportSlug] ? formatSel.value : null;
        var notes = document.getElementById('f-notes').value.trim() || null;

        var jerseyIns = await supabaseClient.from('jerseys').insert({
          team_id: team.id, season: season, type: type, manufacturer: manufacturer,
          format: format, notes: notes, uploaded_by: currentUser.id
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

        try {
          for(var i=0; i<selectedPhotos.length; i++){
            var photo = selectedPhotos[i];
            var ext = (photo.file.name.split('.').pop() || 'jpg').toLowerCase();
            var path = jersey.id + '/' + slugify(photo.label) + '-' + i + '-' + Date.now() + '.' + ext;
            var up = await supabaseClient.storage.from('jersey-photos').upload(path, photo.file);
            if(up.error) throw up.error;
            var imgIns = await supabaseClient.from('jersey_images').insert({jersey_id: jersey.id, storage_path: path, label: photo.label, sort_order: i});
            if(imgIns.error) throw imgIns.error;
          }
        } catch(photoErr) {
          // don't leave an orphaned, photo-less jersey behind if the upload half fails
          await supabaseClient.from('jerseys').delete().eq('id', jersey.id);
          throw photoErr;
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
        renderPhotoPreviews();
        await reselectAfterSubmit(comp.name, team.name);
        typeSelect.value = '';
        syncNewVisibility(typeSelect, typeNewRow, typeNew, true);
        refreshTypeSubVisibility();
        document.getElementById('f-notes').value = '';
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
      el.innerHTML =
        '<div class="auth-status">'+modLink+'<span><a class="spec-link" href="#/user/'+encodeURIComponent(username)+'">'+esc(username)+'</a> '+pointsChip(points)+'</span>' +
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

  async function refreshAuthUI(){
    var sess = await supabaseClient.auth.getSession();
    currentUser = sess.data.session ? sess.data.session.user : null;
    pendingCount = 0;
    if(currentUser){
      var profRes = await supabaseClient.from('profiles').select('*').eq('id', currentUser.id).maybeSingle();
      currentProfile = profRes.data || null;
      if(currentProfile && currentProfile.is_admin){
        var jerseyCountRes = await supabaseClient.from('jerseys').select('id', {count:'exact', head:true}).eq('status', 'pending');
        pendingCount = jerseyCountRes.count || 0;
        try {
          var photoCountRes = await supabaseClient.from('jersey_images').select('id', {count:'exact', head:true}).eq('status', 'pending');
          if(!photoCountRes.error) pendingCount += (photoCountRes.count || 0);
        } catch(e){} // jersey_images.status may not exist yet if add_photos.sql hasn't been run
        try {
          var reportCountRes = await supabaseClient.from('reports').select('id', {count:'exact', head:true}).eq('status', 'open');
          if(!reportCountRes.error) pendingCount += (reportCountRes.count || 0);
        } catch(e){} // reports table may not exist yet if edit_and_report.sql hasn't been run
        try {
          var logoCountRes = await supabaseClient.from('team_logo_proposals').select('id', {count:'exact', head:true}).eq('status', 'pending');
          if(!logoCountRes.error) pendingCount += (logoCountRes.count || 0);
        } catch(e){} // team_logo_proposals may not exist yet if team_logos.sql hasn't been run
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
  supabaseClient.auth.onAuthStateChange(function(event){
    refreshAuthUI();
    if(event === 'SIGNED_IN' || event === 'SIGNED_OUT'){
      if(location.hash.replace(/^#\/?/,'') === 'upload') render();
    }
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

  refreshAuthUI();
  refreshFooterStats();
  window.addEventListener('hashchange', render);
  render();
})();
