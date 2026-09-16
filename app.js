(function(){

  var ICON_SHIRT = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" width="17" height="17"><path d="M8 3 5 5 2 8l3 3 2-1.5V21h10V9.5L19 11l3-3-3-3-3-2-2 2h-4z"/></svg>';
  var ICON_STAR = '<svg viewBox="0 0 24 24" fill="currentColor" width="21" height="21"><path d="M12 2.5l3.09 6.26 6.91 1-5 4.87L18.18 21.5 12 18.27 5.82 21.5 7 14.63l-5-4.87 6.91-1z"/></svg>';
  var ICON_PHOTO = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" width="26" height="26"><rect x="3" y="5" width="18" height="14" rx="2"/><circle cx="9" cy="11" r="2"/><path d="M3 17l5-4 4 3 3-2 6 5"/><path d="M17 3v4M15 5h4"/></svg>';
  var ICON_PENCIL = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" width="13" height="13"><path d="M12 20h9"/><path d="M16.5 3.5a2.12 2.12 0 0 1 3 3L7 19l-4 1 1-4 12.5-12.5z"/></svg>';
  var ICON_FLAG = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" width="13" height="13"><path d="M4 15s1-1 4-1 5 2 8 2 4-1 4-1V3s-1 1-4 1-5-2-8-2-4 1-4 1z"/><path d="M4 22V3"/></svg>';
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

  var currentUser = null, currentProfile = null, pendingCount = 0;

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
    var pendingBadge = jersey.status && jersey.status !== 'approved' ? '<span class="pending-badge">Pending</span>' : '';
    return '<a class="jersey-card" href="#/jersey/'+jersey.id+'">' + pendingBadge +
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
            '<button class="btn" type="button" data-submit>Submit report</button>' +
            '<p class="field-hint" id="report-msg-'+esc(uid)+'" hidden></p>';
          var textarea = panel.querySelector('textarea');
          var submitBtn = panel.querySelector('[data-submit]');
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
                message: message, attachment_path: attachmentPath, reported_by: currentUser ? currentUser.id : null
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
        : '<div class="empty-note">No teams logged in '+esc(comp.name)+' yet.</div>') +
      renderReportButton('competition', comp.slug, comp.name);
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

    // Once a team has a logo, changing it is rare — fold that into the
    // generic "Report a problem" flow (with an optional image attached)
    // instead of a permanent button. Only teams with no logo yet get the
    // prominent top-level proposal button.
    var logoBlock = (currentUser && !team.logo_path)
      ? '<div class="add-photos-block"><button class="btn btn-secondary" id="propose-logo-toggle" data-team-id="'+team.id+'" type="button">+ Propose a logo</button><div id="propose-logo-panel" hidden></div></div>'
      : (team.logo_path
        ? '<div class="add-photos-block"><button class="btn btn-secondary" id="logo-history-toggle" data-team-id="'+team.id+'" type="button">Logo history</button><div id="logo-history-panel" hidden></div></div>'
        : '');

    return '<div class="section-head" style="align-items:center;">'+teamSwatch(team, {large:true})+'<h2 style="margin-left:2px;">'+esc(team.name)+'</h2></div>' +
      logoBlock +
      (groups || '<div class="empty-note">No jerseys logged yet.</div>') +
      renderReportButton('team', team.id, team.name);
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

    var pendingBanner = j.status && j.status !== 'approved'
      ? '<div class="pending-banner">This jersey is '+esc(j.status)+' &mdash; only you and moderators can see it until it’s approved.</div>' : '';

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
      '<div><div class="gallery-main" id="gallery-main">'+mainHtml+'</div>' +
      (thumbs ? '<div class="gallery-thumbs" id="gallery-thumbs" data-images=\''+esc(JSON.stringify(images))+'\'>'+thumbs+'</div>' : '') +
      '</div>' +
      '<div>' +
        '<h1 class="detail-title">'+j.season+' '+esc(team.name)+' '+esc(j.type)+'</h1>' +
        '<p class="detail-sub">'+esc(comp.name)+' &middot; '+esc(sport.name)+'</p>' +
        '<div class="spec-list">' +
          specItem('Sport', '<a class="spec-link" href="#/sport/'+sport.slug+'">'+esc(sport.name)+'</a>', null) +
          specItem('Competition', '<a class="spec-link" href="#/sport/'+sport.slug+'/'+comp.slug+'">'+esc(comp.name)+'</a>', {table:'competitions', matchCol:'slug', matchVal:comp.slug, field:'name', current:comp.name}) +
          specItem('Team', '<a class="spec-link" href="#/sport/'+sport.slug+'/'+comp.slug+'/team/'+team.slug+'">'+esc(team.name)+'</a>', {table:'teams', matchCol:'id', matchVal:team.id, field:'name', current:team.name}) +
          specItem('Season', '<a class="spec-link" href="#/sport/'+sport.slug+'/'+comp.slug+'/season/'+j.season+'">'+j.season+'</a>', {table:'jerseys', matchCol:'id', matchVal:j.id, field:'season', current:j.season, numeric:true}) +
          specItem('Jersey type', esc(j.type), {table:'jerseys', matchCol:'id', matchVal:j.id, field:'type', current:j.type}) +
          specItem('Manufacturer', esc(j.manufacturer || 'Unlisted'), {table:'jerseys', matchCol:'id', matchVal:j.id, field:'manufacturer', current:j.manufacturer || ''}) +
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
          '<div class="field field-full" id="field-photos"><label>Photos * <small>drag in several at once, or click to choose</small></label>' +
            '<div class="dropzone" id="photo-dropzone" tabindex="0" role="button" aria-label="Add photos">' +
              ICON_PHOTO +
              '<p>Drop photos here, or click to choose</p>' +
              '<input type="file" id="f-photos-input" accept="image/*" multiple style="display:none;">' +
            '</div>' +
            '<div class="photo-previews" id="photo-previews"></div>' +
            '<p class="field-error" id="photo-error" hidden>Add at least one photo before submitting.</p>' +
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

  async function setTeamLogo(teamId, path){
    // never overwrite history — the previous logo just stops being "current"
    var unmark = await supabaseClient.from('team_logos').update({is_current:false}).eq('team_id', teamId).eq('is_current', true);
    if(unmark.error) throw unmark.error;
    var histIns = await supabaseClient.from('team_logos').insert({team_id: teamId, storage_path: path, is_current: true});
    if(histIns.error) throw histIns.error;
    var teamUpd = await supabaseClient.from('teams').update({logo_path: path}).eq('id', teamId);
    if(teamUpd.error) throw teamUpd.error;
  }

  async function viewModerate(){
    setCrumbs([{label:'Home', href:'#/'},{label:'Moderate', href:'#/moderate'}]);
    if(!currentUser || !currentProfile || !currentProfile.is_admin){
      return '<div class="empty-note">Not authorized.</div>';
    }
    await refreshAuthUI(); // keeps the topbar count in sync even after changes made outside the app (e.g. deleting rows directly in Supabase)

    var jRes = await supabaseClient.from('jerseys')
      .select('*, jersey_images(*), teams(name, competitions(name, sports(name)))')
      .eq('status', 'pending').order('created_at');
    if(jRes.error) throw jRes.error;
    var pendingJerseys = jRes.data || [];

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

    var uploaderIds = pendingJerseys.map(function(j){ return j.uploaded_by; })
      .concat(pendingPhotos.map(function(img){ return img.uploaded_by; }))
      .concat(openReports.map(function(r){ return r.reported_by; }))
      .concat(pendingLogos.map(function(l){ return l.proposed_by; }))
      .filter(Boolean);
    var uploaderNames = {};
    if(uploaderIds.length){
      var profRes = await supabaseClient.from('profiles').select('id,username').in('id', uploaderIds);
      (profRes.data || []).forEach(function(p){ uploaderNames[p.id] = p.username; });
    }

    if(!pendingJerseys.length && !pendingPhotos.length && !openReports.length && !pendingLogos.length){
      return '<div class="section-head"><h2>Moderation queue</h2></div><div class="empty-note">Nothing waiting for review.</div>';
    }

    var jerseyCards = pendingJerseys.map(function(j){
      var team = j.teams, comp = team.competitions, sport = comp.sports;
      var uploader = uploaderNames[j.uploaded_by] || 'unknown';
      var thumb = j.jersey_images && j.jersey_images.length
        ? '<img class="lightbox-trigger" src="'+esc(publicImageUrl(j.jersey_images[0].storage_path))+'" alt="">'
        : '<div class="thumb-placeholder" style="background:var(--surface-2)"><span>No photo</span></div>';
      return '<div class="mod-card">' +
        '<div class="jersey-thumb">'+thumb+'</div>' +
        '<div class="mod-info">' +
          '<strong>'+j.season+' '+esc(team.name)+' '+esc(j.type)+'</strong>' +
          '<span>'+esc(comp.name)+' · '+esc(sport.name)+' · by '+esc(uploader)+'</span>' +
          (j.notes ? '<span>'+esc(j.notes)+'</span>' : '') +
        '</div>' +
        '<div class="mod-actions">' +
          '<button class="btn" data-type="jersey" data-action="approve" data-id="'+j.id+'" type="button">Approve</button>' +
          '<button class="btn btn-reject" data-type="jersey" data-action="reject" data-id="'+j.id+'" type="button">Reject</button>' +
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

    return '<div class="section-head"><h2>Moderation queue</h2></div>' +
      '<section class="block"><div class="section-head"><h2>New jerseys</h2><span class="count">'+pendingJerseys.length+' pending</span></div>' +
        (jerseyCards ? '<div class="mod-list">'+jerseyCards+'</div>' : '<div class="empty-note">None waiting.</div>') +
      '</section>' +
      '<section class="block"><div class="section-head"><h2>Proposed photos</h2><span class="count">'+pendingPhotos.length+' pending</span></div>' +
        (photoCards ? '<div class="mod-list">'+photoCards+'</div>' : '<div class="empty-note">None waiting.</div>') +
      '</section>' +
      '<section class="block"><div class="section-head"><h2>Logo proposals</h2><span class="count">'+pendingLogos.length+' pending</span></div>' +
        (logoCards ? '<div class="mod-list">'+logoCards+'</div>' : '<div class="empty-note">None waiting.</div>') +
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

    return '<div class="section-head"><h2>'+esc(profile.username)+' '+pointsChip(profile.points)+'</h2><span class="count">'+jerseys.length+' upload'+(jerseys.length===1?'':'s')+'</span></div>' +
      (cards ? '<div class="jersey-grid">'+cards+'</div>' : '<div class="empty-note">No approved uploads yet.</div>');
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
          wireProposeLogoPanel(proposeLogoToggle.dataset.teamId);
        }
        panel.hidden = !panel.hidden;
      });
    }

    var logoHistoryToggle = document.getElementById('logo-history-toggle');
    if(logoHistoryToggle){
      logoHistoryToggle.addEventListener('click', async function(){
        var panel = document.getElementById('logo-history-panel');
        if(!panel.dataset.wired){
          panel.dataset.wired = '1';
          panel.hidden = false;
          panel.innerHTML = '<p class="loading">Loading…</p>';
          var res = await supabaseClient.from('team_logos').select('*').eq('team_id', logoHistoryToggle.dataset.teamId).order('approved_at', {ascending:false});
          if(res.error){ panel.innerHTML = errorBox(res.error); return; }
          var rows = res.data || [];
          panel.innerHTML = rows.length
            ? '<div class="logo-history-grid">' + rows.map(function(r){
                return '<div class="logo-history-item"><img class="lightbox-trigger" src="'+esc(publicLogoUrl(r.storage_path))+'" alt="">' +
                  '<span>'+(r.is_current ? 'Current' : fmtDate(r.approved_at))+'</span></div>';
              }).join('') + '</div>'
            : '<div class="empty-note">No logo history yet.</div>';
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

  function wireProposeLogoPanel(teamId){
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
        var path = teamId + '/logo-' + Date.now() + '.' + ext;
        var up = await supabaseClient.storage.from('team-logos').upload(path, picked.file);
        if(up.error) throw up.error;
        var ins = await supabaseClient.from('team_logo_proposals').insert({
          team_id: teamId, storage_path: path, proposed_by: currentUser.id
        });
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
            await setTeamLogo(teamId, newPath);
            var repRes2 = await supabaseClient.from('reports').update({status:'resolved'}).eq('id', id);
            if(repRes2.error) throw repRes2.error;
            await supabaseClient.storage.from('report-attachments').remove([oldPath]);
          } else if(type === 'logo'){
            if(btn.dataset.action === 'approve'){
              await setTeamLogo(btn.dataset.teamId, btn.dataset.path);
              var logoApprove = await supabaseClient.from('team_logo_proposals').delete().eq('id', id);
              if(logoApprove.error) throw logoApprove.error;
            } else {
              if(btn.dataset.path){
                var logoRm = await supabaseClient.storage.from('team-logos').remove([btn.dataset.path]);
                if(logoRm.error) throw logoRm.error;
              }
              var logoDel = await supabaseClient.from('team_logo_proposals').delete().eq('id', id);
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
          } else if(btn.dataset.action === 'approve'){
            var r = await supabaseClient.from('jerseys').update({status:'approved'}).eq('id', id);
            if(r.error) throw r.error;
          } else {
            var imgRes = await supabaseClient.from('jersey_images').select('storage_path').eq('jersey_id', id);
            var paths = (imgRes.data || []).map(function(row){ return row.storage_path; });
            if(paths.length){
              var rmRes = await supabaseClient.storage.from('jersey-photos').remove(paths);
              if(rmRes.error) throw rmRes.error;
            }
            var delRes = await supabaseClient.from('jerseys').delete().eq('id', id);
            if(delRes.error) throw delRes.error;
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
        form.reset();
        clearDraft();
        selectedPhotos.forEach(function(p){ URL.revokeObjectURL(p.url); });
        selectedPhotos.length = 0;
        renderPhotoPreviews();
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
  function openLightbox(url){ lightboxImg.src = url; lightbox.hidden = false; }
  function closeLightbox(){ lightbox.hidden = true; lightboxImg.src = ''; }
  document.addEventListener('click', function(e){
    var trigger = e.target.closest('.lightbox-trigger');
    if(trigger){ openLightbox(trigger.src); return; }
    if(e.target === lightbox) closeLightbox();
  });
  document.getElementById('lightbox-close-btn').addEventListener('click', closeLightbox);
  document.addEventListener('keydown', function(e){ if(e.key === 'Escape') closeLightbox(); });

  refreshAuthUI();
  window.addEventListener('hashchange', render);
  render();
})();
