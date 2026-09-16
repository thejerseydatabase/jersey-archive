(function(){

  var ICON_SHIRT = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" width="17" height="17"><path d="M8 3 5 5 2 8l3 3 2-1.5V21h10V9.5L19 11l3-3-3-3-3-2-2 2h-4z"/></svg>';
  var ICON_STAR = '<svg viewBox="0 0 24 24" fill="currentColor" width="21" height="21"><path d="M12 2.5l3.09 6.26 6.91 1-5 4.87L18.18 21.5 12 18.27 5.82 21.5 7 14.63l-5-4.87 6.91-1z"/></svg>';
  var FORMATS_BY_SPORT = { cricket: ['Test','T20','T20I','ODI','One Day','First Class'] };
  var JERSEY_TYPES = ['Home','Away','Alternate','Indigenous','Heritage','Training'];
  var MANUFACTURERS = ['ISC','Classic','Kappa','Canterbury','BLK','Burley Sekem','Macron','Puma','Nike','Adidas','New Balance'];

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

  var currentUser = null, currentProfile = null;

  /* ================= helpers ================= */
  function esc(s){ return String(s == null ? '' : s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;'); }
  function fmtDate(iso){ try{ return new Date(iso).toLocaleDateString(undefined,{year:'numeric',month:'short',day:'numeric'}); }catch(e){ return ''; } }
  function slugify(s){ return String(s).toLowerCase().trim().replace(/[^a-z0-9]+/g,'-').replace(/(^-|-$)/g,'') || 'x'; }
  function hashStr(s){ var h=0; for(var i=0;i<s.length;i++){ h=(h*31+s.charCodeAt(i))>>>0; } return h; }
  function hashColors(name){
    var h = hashStr(name), hue = h % 360, hue2 = (hue + 150) % 360;
    return { primary: 'hsl('+hue+',48%,28%)', secondary: 'hsl('+hue2+',70%,58%)' };
  }

  function publicImageUrl(path){
    return supabaseClient.storage.from('jersey-photos').getPublicUrl(path).data.publicUrl;
  }

  function teamSwatch(team){
    return '<div class="team-swatch"><div class="a" style="background:'+esc(team.primary_color)+'"></div><div class="b" style="background:'+esc(team.secondary_color)+'"></div></div>';
  }

  function jerseyThumb(jersey, team){
    var images = jersey.jersey_images || [];
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
    return '<a class="jersey-card" href="#/jersey/'+jersey.id+'">' +
      '<div class="jersey-thumb">'+jerseyThumb(jersey, team)+'</div>' +
      '<div class="jersey-label"><strong>'+esc(primary)+'</strong><span>'+esc(secondary)+'</span></div>' +
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
  async function viewHome(){
    setCrumbs([{label:'Home', href:'#/'}]);
    var res = await supabaseClient.from('sports').select('*').order('sort_order');
    if(res.error) throw res.error;
    var sports = res.data || [];
    var cards = sports.map(function(s){
      return '<a class="sport-card" href="#/sport/'+s.slug+'">' +
        '<div class="sport-icon">'+ICON_SHIRT+'</div>' +
        '<div><div class="sport-name">'+esc(s.name)+'</div></div>' +
      '</a>';
    }).join('');
    return '<header class="hero">' +
        '<p class="eyebrow">The Jersey Database &mdash; Archive</p>' +
        '<h1>Every jersey.<br>Filed by hand, found in three clicks.</h1>' +
        '<p class="sub">Pick a sport, then drill into competition, team and season &mdash; or search straight to it.</p>' +
      '</header>' +
      '<div class="section-head"><h2>Browse by sport</h2></div>' +
      '<div class="sport-grid">'+(cards || '<div class="empty-note">No sports found &mdash; has schema.sql been run?</div>')+'</div>';
  }

  async function viewSport(sportSlug){
    var sportRes = await supabaseClient.from('sports').select('*').eq('slug', sportSlug).single();
    if(sportRes.error) throw sportRes.error;
    var sport = sportRes.data;
    setCrumbs([{label:'Home', href:'#/'},{label:sport.name, href:'#/sport/'+sportSlug}]);

    var compRes = await supabaseClient.from('competitions').select('*').eq('sport_slug', sportSlug);
    if(compRes.error) throw compRes.error;
    var comps = compRes.data || [];
    var top = comps.filter(function(c){ return c.tier === 'top'; });
    var more = comps.filter(function(c){ return c.tier !== 'top'; });

    function compCard(c){
      return '<a class="comp-card" href="#/sport/'+sportSlug+'/'+c.slug+'"><strong>'+esc(c.name)+'</strong></a>';
    }
    var compsHtml = '<div class="comp-grid">'+top.map(compCard).join('')+'</div>' +
      (more.length ? '<button class="chip more-toggle" id="more-comps-btn" type="button">More competitions ↓</button>' +
        '<div class="comp-grid" id="more-comps" hidden style="margin-top:12px;">'+more.map(compCard).join('')+'</div>' : '');

    return '<header class="hero" style="padding-bottom:26px;"><p class="eyebrow">Sport</p><h1>'+esc(sport.name)+'</h1></header>' +
      '<section class="block"><div class="section-head"><h2>Competitions</h2></div>' +
        (comps.length ? compsHtml : '<div class="empty-note">No competitions yet for '+esc(sport.name)+'.</div>') +
      '</section>';
  }

  async function viewCompetition(sportSlug, compSlug){
    var res = await supabaseClient.from('competitions').select('*, sports(*)').eq('slug', compSlug).single();
    if(res.error) throw res.error;
    var comp = res.data, sport = comp.sports;
    setCrumbs([{label:'Home', href:'#/'},{label:sport.name, href:'#/sport/'+sportSlug},{label:comp.name, href:'#'}]);

    var teamsRes = await supabaseClient.from('teams').select('*').eq('competition_slug', compSlug).order('name');
    if(teamsRes.error) throw teamsRes.error;
    var teams = teamsRes.data || [];

    var teamCards = teams.map(function(t){
      return '<a class="team-card" href="#/sport/'+sportSlug+'/'+compSlug+'/team/'+t.slug+'">'+teamSwatch(t)+'<div class="team-info"><h3>'+esc(t.name)+'</h3></div></a>';
    }).join('');

    return '<div class="section-head"><h2>'+esc(comp.name)+'</h2><span class="count">'+teams.length+' teams</span></div>' +
      (teams.length ? '<div class="filter-row"><input type="text" id="team-filter" placeholder="Filter teams..."></div><div class="team-grid" id="team-grid">'+teamCards+'</div>'
        : '<div class="empty-note">No teams logged in '+esc(comp.name)+' yet.</div>');
  }

  async function viewTeam(sportSlug, compSlug, teamSlug){
    var teamRes = await supabaseClient.from('teams').select('*, competitions(*, sports(*))').eq('competition_slug', compSlug).eq('slug', teamSlug).single();
    if(teamRes.error) throw teamRes.error;
    var team = teamRes.data, comp = team.competitions, sport = comp.sports;
    setCrumbs([{label:'Home', href:'#/'},{label:sport.name, href:'#/sport/'+sportSlug},{label:comp.name, href:'#/sport/'+sportSlug+'/'+compSlug},{label:team.name, href:'#'}]);

    var jRes = await supabaseClient.from('jerseys').select('*, jersey_images(*)').eq('team_id', team.id).order('season', {ascending:false});
    if(jRes.error) throw jRes.error;
    var jerseys = jRes.data || [];
    var bySeason = {};
    jerseys.forEach(function(j){ (bySeason[j.season] = bySeason[j.season] || []).push(j); });
    var years = Object.keys(bySeason).sort(function(a,b){ return b - a; });
    var groups = years.map(function(y){
      var cards = bySeason[y].map(function(j){ return jerseyCard(j, team); }).join('');
      return '<div class="season-group"><h3><a class="spec-link" href="#/sport/'+sportSlug+'/'+compSlug+'/season/'+y+'">'+y+'</a></h3><div class="jersey-grid">'+cards+'</div></div>';
    }).join('');

    return '<div class="section-head">'+teamSwatch(team)+'<h2 style="margin-left:2px;">'+esc(team.name)+'</h2></div>' +
      (groups || '<div class="empty-note">No jerseys logged yet.</div>');
  }

  async function viewSeason(sportSlug, compSlug, year){
    year = Number(year);
    var compRes = await supabaseClient.from('competitions').select('*, sports(*)').eq('slug', compSlug).single();
    if(compRes.error) throw compRes.error;
    var comp = compRes.data, sport = comp.sports;
    setCrumbs([{label:'Home', href:'#/'},{label:sport.name, href:'#/sport/'+sportSlug},{label:comp.name, href:'#/sport/'+sportSlug+'/'+compSlug},{label:year+' season', href:'#'}]);

    var jRes = await supabaseClient.from('jerseys').select('*, jersey_images(*), teams!inner(*)').eq('season', year).eq('teams.competition_slug', compSlug);
    if(jRes.error) throw jRes.error;
    var jerseys = jRes.data || [];
    var byTeam = {};
    jerseys.forEach(function(j){ (byTeam[j.teams.id] = byTeam[j.teams.id] || {team:j.teams, jerseys:[]}).jerseys.push(j); });

    var groups = Object.keys(byTeam).map(function(id){
      var entry = byTeam[id];
      var cards = entry.jerseys.map(function(j){ return jerseyCard(j, entry.team); }).join('');
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

    var images = j.jersey_images && j.jersey_images.length ? j.jersey_images : null;
    var mainHtml = images ? '<img src="'+esc(publicImageUrl(images[0].storage_path))+'" alt="">' : jerseyThumb(j, team);
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
        uploaderHtml = '<span>uploaded by '+esc(uploaderRes.data.username)+' '+pointsChip(uploaderRes.data.points)+'</span>';
      }
    }

    return '<div class="detail-grid">' +
      '<div><div class="gallery-main" id="gallery-main">'+mainHtml+'</div>' +
      (thumbs ? '<div class="gallery-thumbs" id="gallery-thumbs" data-images=\''+esc(JSON.stringify(images))+'\'>'+thumbs+'</div>' : '') +
      '</div>' +
      '<div>' +
        '<h1 class="detail-title">'+j.season+' '+esc(team.name)+' '+esc(j.type)+'</h1>' +
        '<p class="detail-sub">'+esc(comp.name)+' &middot; '+esc(sport.name)+'</p>' +
        '<div class="spec-list">' +
          '<div class="spec-item"><span>Sport</span><strong><a class="spec-link" href="#/sport/'+sport.slug+'">'+esc(sport.name)+'</a></strong></div>' +
          '<div class="spec-item"><span>Competition</span><strong><a class="spec-link" href="#/sport/'+sport.slug+'/'+comp.slug+'">'+esc(comp.name)+'</a></strong></div>' +
          '<div class="spec-item"><span>Team</span><strong><a class="spec-link" href="#/sport/'+sport.slug+'/'+comp.slug+'/team/'+team.slug+'">'+esc(team.name)+'</a></strong></div>' +
          '<div class="spec-item"><span>Season</span><strong><a class="spec-link" href="#/sport/'+sport.slug+'/'+comp.slug+'/season/'+j.season+'">'+j.season+'</a></strong></div>' +
          '<div class="spec-item"><span>Jersey type</span><strong>'+esc(j.type)+'</strong></div>' +
          '<div class="spec-item"><span>Manufacturer</span><strong>'+esc(j.manufacturer || 'Unlisted')+'</strong></div>' +
          (j.format ? '<div class="spec-item"><span>Format</span><strong>'+esc(j.format)+'</strong></div>' : '') +
        '</div>' +
        (j.notes ? '<div class="notes-block">'+esc(j.notes)+'</div>' : '') +
        '<div class="stat-row"><span>logged '+fmtDate(j.created_at)+'</span>'+uploaderHtml+'</div>' +
        '<div class="rate-block"><span class="rate-label">Rate this jersey</span><div id="rating-widget" data-jersey-id="'+j.id+'">'+ratingWidgetHtml(rating, myRatingVal)+'</div></div>' +
      '</div>' +
    '</div>';
  }

  async function viewSearch(term){
    setCrumbs([{label:'Home', href:'#/'},{label:'Search: '+term, href:'#'}]);
    var res = await supabaseClient.from('jerseys').select('*, jersey_images(*), teams(*, competitions(*, sports(*)))');
    if(res.error) throw res.error;
    var q = term.toLowerCase();
    var matches = (res.data || []).filter(function(j){
      var t = j.teams, c = t.competitions;
      return t.name.toLowerCase().indexOf(q) > -1 || c.name.toLowerCase().indexOf(q) > -1 ||
        String(j.season).indexOf(q) > -1 || j.type.toLowerCase().indexOf(q) > -1 ||
        (j.manufacturer||'').toLowerCase().indexOf(q) > -1;
    });

    if(!matches.length){
      return '<div class="section-head"><h2>Results for &ldquo;'+esc(term)+'&rdquo;</h2><span class="count">0 jerseys</span></div><div class="empty-note">Nothing matches yet.</div>';
    }
    var bySport = {};
    matches.forEach(function(j){ var s=j.teams.competitions.sports; (bySport[s.slug]=bySport[s.slug]||{sport:s,jerseys:[]}).jerseys.push(j); });
    var html = Object.keys(bySport).map(function(slug){
      var entry = bySport[slug];
      var byComp = {};
      entry.jerseys.forEach(function(j){ var c=j.teams.competitions; (byComp[c.slug]=byComp[c.slug]||{comp:c,jerseys:[]}).jerseys.push(j); });
      var compBlocks = Object.keys(byComp).map(function(cslug){
        var centry = byComp[cslug];
        var cards = centry.jerseys.sort(function(a,b){return b.season-a.season;}).map(function(j){ return jerseyCard(j, j.teams, {showTeam:true}); }).join('');
        return '<div class="season-group"><h3><a class="spec-link" href="#/sport/'+entry.sport.slug+'/'+cslug+'">'+esc(centry.comp.name)+'</a></h3><div class="jersey-grid">'+cards+'</div></div>';
      }).join('');
      return '<section class="block"><div class="section-head"><h2><a class="spec-link" href="#/sport/'+slug+'">'+esc(entry.sport.name)+'</a></h2></div>'+compBlocks+'</section>';
    }).join('');

    return '<div class="section-head"><h2>Results for &ldquo;'+esc(term)+'&rdquo;</h2><span class="count">'+matches.length+' jerseys</span></div>'+html;
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
    var typeOptions = JERSEY_TYPES.map(function(t){ return '<option value="'+t+'">'; }).join('');
    var mfrOptions = MANUFACTURERS.map(function(m){ return '<option value="'+esc(m)+'">'; }).join('');
    var thisYear = new Date().getFullYear();
    var seasonOptions = ''; for(var y=thisYear+1; y>=1900; y--){ seasonOptions += '<option value="'+y+'">'; }

    return '<div class="section-head"><h2>Upload a jersey</h2></div>' +
      '<p style="font-family:\'IBM Plex Mono\',monospace;font-size:11.5px;color:var(--text-dim2);margin:-10px 0 22px;">* required &mdash; and at least one photo</p>' +
      '<form id="upload-form" novalidate>' +
        '<div class="upload-grid">' +
          '<div class="field"><label for="f-sport">Sport *</label><select id="f-sport" required>'+sportOptions+'</select></div>' +
          '<div class="field" id="field-format" hidden><label for="f-format">Format * <small>cricket has several</small></label><select id="f-format" required></select></div>' +
          '<div class="field"><label for="f-comp">Competition * <small>type to add a new one</small></label><input type="text" id="f-comp" list="comp-list" required><datalist id="comp-list"></datalist><p class="field-hint" id="hint-comp"></p></div>' +
          '<div class="field"><label for="f-team">Team * <small>any level &mdash; local clubs welcome</small></label><input type="text" id="f-team" list="team-list" required><datalist id="team-list"></datalist><p class="field-hint" id="hint-team"></p></div>' +
          '<div class="field"><label for="f-season">Season *</label><input type="text" inputmode="numeric" id="f-season" list="season-list" placeholder="e.g. 2022" required><datalist id="season-list">'+seasonOptions+'</datalist></div>' +
          '<div class="field"><label for="f-type">Jersey type *</label><input type="text" id="f-type" list="type-list" placeholder="e.g. Home" required><datalist id="type-list">'+typeOptions+'</datalist></div>' +
          '<div class="field"><label for="f-mfr">Manufacturer <small>optional</small></label><input type="text" id="f-mfr" list="mfr-list" placeholder="e.g. ISC"><datalist id="mfr-list">'+mfrOptions+'</datalist></div>' +
          '<div class="field field-full" id="field-photos"><label>Photos *</label>' +
            '<div class="photo-slots">' +
              '<div class="photo-slot"><p>Front</p><span>recommended</span><input type="file" id="f-photo-front" accept="image/*"></div>' +
              '<div class="photo-slot"><p>Back</p><span>optional</span><input type="file" id="f-photo-back" accept="image/*"></div>' +
              '<div class="photo-slot"><p>Other</p><span>tag, sponsor detail...</span><input type="file" id="f-photo-other" accept="image/*"></div>' +
            '</div>' +
            '<p class="field-error" id="photo-error" hidden>Add at least one photo (front, back, or other) before submitting.</p>' +
          '</div>' +
          '<div class="field field-full"><label for="f-notes">Additional info <small>optional</small></label><textarea id="f-notes" placeholder="Sponsor changes, special edition, match it was worn in..."></textarea></div>' +
        '</div>' +
        '<div style="margin-top:20px;"><button type="submit" class="btn" id="upload-submit-btn">Add jersey</button></div>' +
      '</form>' +
      '<div id="upload-result"></div>';
  }

  async function ensureCompetition(sportSlug, name){
    var slug = slugify(name);
    var existing = await supabaseClient.from('competitions').select('*').eq('slug', slug).maybeSingle();
    if(existing.error) throw existing.error;
    if(existing.data) return existing.data;
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
      else if(parts[0]==='upload'){ html = await viewUpload(); }
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
        document.querySelectorAll('#team-grid .team-card').forEach(function(card){
          card.hidden = card.querySelector('h3').textContent.toLowerCase().indexOf(q) === -1;
        });
      });
    }
    var moreBtn = document.getElementById('more-comps-btn');
    if(moreBtn){
      moreBtn.addEventListener('click', function(){
        var panel = document.getElementById('more-comps');
        panel.hidden = !panel.hidden;
        moreBtn.textContent = panel.hidden ? 'More competitions ↓' : 'Show fewer ↑';
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
          main.innerHTML = '<img src="'+esc(publicImageUrl(images[Number(btn.dataset.idx)].storage_path))+'" alt="">';
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

    if(parts[0]==='upload' && currentUser){ wireUploadForm(); }
  }

  function wireUploadForm(){
    var form = document.getElementById('upload-form');
    if(!form) return;
    var sportSel = document.getElementById('f-sport');
    var compInput = document.getElementById('f-comp');
    var compList = document.getElementById('comp-list');
    var teamInput = document.getElementById('f-team');
    var teamList = document.getElementById('team-list');
    var formatField = document.getElementById('field-format');
    var formatSel = document.getElementById('f-format');

    // Text fields survive an unexpected reload (e.g. the browser discarding
    // a backgrounded tab to save memory) — photos can't be restored this
    // way (browsers block scripts from setting file input values), so this
    // only saves the typing, not the attached images.
    var DRAFT_KEY = 'jersey-archive-upload-draft';
    var DRAFT_FIELDS = ['f-sport','f-comp','f-team','f-season','f-type','f-mfr','f-notes'];
    function saveDraft(){
      try {
        var draft = {};
        DRAFT_FIELDS.forEach(function(id){ draft[id] = document.getElementById(id).value; });
        sessionStorage.setItem(DRAFT_KEY, JSON.stringify(draft));
      } catch(e){}
    }
    function clearDraft(){ try{ sessionStorage.removeItem(DRAFT_KEY); }catch(e){} }
    var restoredDraft = null;
    try { restoredDraft = JSON.parse(sessionStorage.getItem(DRAFT_KEY) || 'null'); } catch(e){}
    if(restoredDraft){
      DRAFT_FIELDS.forEach(function(id){ if(restoredDraft[id]) document.getElementById(id).value = restoredDraft[id]; });
      form.insertAdjacentHTML('afterbegin', '<p class="field-hint is-match" style="margin-bottom:14px;">Restored what you’d typed before the page reloaded &mdash; you’ll need to re-attach any photos.</p>');
    }

    async function competitionsForSport(sportSlug){
      var r = await supabaseClient.from('competitions').select('*').eq('sport_slug', sportSlug);
      if(r.error) throw r.error;
      return r.data || [];
    }
    async function currentCompetitionRow(){
      var name = compInput.value.trim();
      if(!name) return null;
      var comps = await competitionsForSport(sportSel.value);
      return comps.filter(function(c){ return c.name.toLowerCase() === name.toLowerCase(); })[0] || null;
    }
    async function refreshComps(){
      var comps = await competitionsForSport(sportSel.value);
      compList.innerHTML = comps.map(function(c){ return '<option value="'+esc(c.name)+'">'; }).join('');
    }
    async function refreshTeams(){
      var comp = await currentCompetitionRow();
      if(!comp){ teamList.innerHTML = ''; return; }
      var r = await supabaseClient.from('teams').select('name').eq('competition_slug', comp.slug);
      teamList.innerHTML = (r.data||[]).map(function(t){ return '<option value="'+esc(t.name)+'">'; }).join('');
    }
    function refreshFormat(){
      var formats = FORMATS_BY_SPORT[sportSel.value];
      formatField.hidden = !formats;
      formatSel.required = !!formats;
      formatSel.innerHTML = formats ? formats.map(function(f){ return '<option>'+f+'</option>'; }).join('') : '';
    }
    function wireComboFeedback(input, hint, getNames, label){
      function update(){
        var val = input.value.trim();
        if(!val){ hint.textContent=''; hint.className='field-hint'; return; }
        getNames().then(function(names){
          var match = names.some(function(n){ return n.toLowerCase() === val.toLowerCase(); });
          hint.textContent = match ? '✓ matches an existing '+label : '✖ no '+label+' found for “'+val+'” — this will create a new one';
          hint.className = 'field-hint'+(match?' is-match':'');
        });
      }
      input.addEventListener('input', update);
    }

    refreshComps(); refreshFormat();
    sportSel.addEventListener('change', function(){ refreshComps(); refreshFormat(); compInput.value=''; teamList.innerHTML=''; });
    compInput.addEventListener('change', refreshTeams);
    wireComboFeedback(compInput, document.getElementById('hint-comp'),
      function(){ return competitionsForSport(sportSel.value).then(function(cs){ return cs.map(function(c){return c.name;}); }); }, 'competition');
    wireComboFeedback(teamInput, document.getElementById('hint-team'),
      function(){ return currentCompetitionRow().then(function(comp){
        if(!comp) return [];
        return supabaseClient.from('teams').select('name').eq('competition_slug', comp.slug).then(function(r){ return (r.data||[]).map(function(t){return t.name;}); });
      }); }, 'team');
    if(restoredDraft && restoredDraft['f-comp']) refreshTeams();
    DRAFT_FIELDS.forEach(function(id){
      var el = document.getElementById(id);
      el.addEventListener('input', saveDraft);
      el.addEventListener('change', saveDraft);
    });

    form.addEventListener('submit', async function(e){
      e.preventDefault();
      if(!form.reportValidity()) return;

      var seasonInput = document.getElementById('f-season');
      var seasonVal = seasonInput.value.trim();
      if(!/^\d{3,4}$/.test(seasonVal)){
        seasonInput.setCustomValidity('Enter a year, e.g. 2022');
        seasonInput.reportValidity();
        seasonInput.addEventListener('input', function clear(){ seasonInput.setCustomValidity(''); seasonInput.removeEventListener('input', clear); });
        return;
      }
      seasonInput.setCustomValidity('');

      var files = {};
      ['front','back','other'].forEach(function(slot){
        var input = document.getElementById('f-photo-'+slot);
        if(input.files && input.files[0]) files[slot] = input.files[0];
      });
      var photoError = document.getElementById('photo-error');
      if(Object.keys(files).length === 0){
        photoError.hidden = false;
        document.getElementById('field-photos').scrollIntoView({behavior:'smooth', block:'center'});
        return;
      }
      photoError.hidden = true;

      var submitBtn = document.getElementById('upload-submit-btn');
      submitBtn.disabled = true; submitBtn.textContent = 'Uploading…';

      try {
        var sportSlug = sportSel.value;
        var comp = await ensureCompetition(sportSlug, compInput.value.trim());
        var team = await ensureTeam(comp.slug, teamInput.value.trim());
        var season = Number(seasonVal);
        var type = document.getElementById('f-type').value.trim();
        var manufacturer = document.getElementById('f-mfr').value.trim() || null;
        var format = FORMATS_BY_SPORT[sportSlug] ? formatSel.value : null;
        var notes = document.getElementById('f-notes').value.trim() || null;

        var jerseyIns = await supabaseClient.from('jerseys').insert({
          team_id: team.id, season: season, type: type, manufacturer: manufacturer,
          format: format, notes: notes, uploaded_by: currentUser.id
        }).select().single();
        if(jerseyIns.error) throw jerseyIns.error;
        var jersey = jerseyIns.data;

        var labelMap = {front:'Front', back:'Back', other:'Other'};
        for(var slot in files){
          var file = files[slot];
          var ext = (file.name.split('.').pop() || 'jpg').toLowerCase();
          var path = jersey.id + '/' + slot + '-' + Date.now() + '.' + ext;
          var up = await supabaseClient.storage.from('jersey-photos').upload(path, file);
          if(up.error) throw up.error;
          var imgIns = await supabaseClient.from('jersey_images').insert({jersey_id: jersey.id, storage_path: path, label: labelMap[slot]});
          if(imgIns.error) throw imgIns.error;
        }

        await refreshAuthUI();

        var resultEl = document.getElementById('upload-result');
        if(!resultEl) return; // page moved on while this was in flight — upload still succeeded
        resultEl.innerHTML =
          '<div class="result-panel">' +
            '<h3>Filed automatically</h3>' +
            '<p>The '+season+' '+esc(team.name)+' '+esc(type)+' jersey now appears on four pages &mdash; no manual placement needed:</p>' +
            '<div class="result-links">' +
              '<a href="#/jersey/'+jersey.id+'"><span>Its own jersey page, with full details</span><span class="go">View &rarr;</span></a>' +
              '<a href="#/sport/'+sportSlug+'/'+comp.slug+'/team/'+team.slug+'"><span>'+esc(team.name)+' team page, sorted by year</span><span class="go">View &rarr;</span></a>' +
              '<a href="#/sport/'+sportSlug+'/'+comp.slug+'/season/'+season+'"><span>'+esc(comp.name)+' '+season+' season page</span><span class="go">View &rarr;</span></a>' +
              '<a href="#/sport/'+sportSlug+'"><span>'+esc(sportSlug)+' hub</span><span class="go">View &rarr;</span></a>' +
            '</div>' +
            '<p style="margin:16px 0 0;font-family:\'IBM Plex Mono\',monospace;font-size:11px;color:var(--text-dim2);">+1 upload point &mdash; check the top right.</p>' +
          '</div>';
        form.reset();
        clearDraft();
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
      el.innerHTML =
        '<div class="auth-status"><span>'+esc(username)+' '+pointsChip(points)+'</span>' +
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
    if(currentUser){
      var profRes = await supabaseClient.from('profiles').select('*').eq('id', currentUser.id).maybeSingle();
      currentProfile = profRes.data || null;
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

  refreshAuthUI();
  window.addEventListener('hashchange', render);
  render();
})();
