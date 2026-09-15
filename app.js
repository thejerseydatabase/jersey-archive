(function(){

  var ICON_SHIRT = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" width="17" height="17"><path d="M8 3 5 5 2 8l3 3 2-1.5V21h10V9.5L19 11l3-3-3-3-3-2-2 2h-4z"/></svg>';

  /* ================= helpers ================= */
  function esc(s){ return String(s == null ? '' : s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;'); }
  function fmtDate(iso){ try{ return new Date(iso).toLocaleDateString(undefined,{year:'numeric',month:'short',day:'numeric'}); }catch(e){ return ''; } }

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
    var teamRes = await supabaseClient.from('teams').select('*, competitions(*, sports(*))').eq('slug', teamSlug).single();
    if(teamRes.error) throw teamRes.error;
    var team = teamRes.data, comp = team.competitions, sport = comp.sports;
    setCrumbs([{label:'Home', href:'#/'},{label:sport.name, href:'#/sport/'+sportSlug},{label:comp.name, href:'#/sport/'+sportSlug+'/'+compSlug},{label:team.name, href:'#'}]);

    var jRes = await supabaseClient.from('jerseys').select('*, jersey_images(*)').eq('team_slug', teamSlug).order('season', {ascending:false});
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
    jerseys.forEach(function(j){ (byTeam[j.teams.slug] = byTeam[j.teams.slug] || {team:j.teams, jerseys:[]}).jerseys.push(j); });

    var groups = Object.keys(byTeam).map(function(slug){
      var entry = byTeam[slug];
      var cards = entry.jerseys.map(function(j){ return jerseyCard(j, entry.team); }).join('');
      return '<div class="season-group"><h3><a class="spec-link" href="#/sport/'+sportSlug+'/'+compSlug+'/team/'+slug+'">'+esc(entry.team.name)+'</a></h3><div class="jersey-grid">'+cards+'</div></div>';
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
        '<div class="stat-row"><span>logged '+fmtDate(j.created_at)+'</span></div>' +
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
  }

  document.getElementById('search-form').addEventListener('submit', function(e){
    e.preventDefault();
    var val = document.getElementById('search-input').value.trim();
    if(val) location.hash = '#/search/' + encodeURIComponent(val);
  });

  window.addEventListener('hashchange', render);
  render();
})();
