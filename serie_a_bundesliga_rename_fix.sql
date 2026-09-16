-- Corrects Serie A and Bundesliga to your updated team lists. These are
-- UPDATEs against the existing rows (matched by old slug), not a
-- delete-and-reinsert — that keeps each team's id, and with it any jersey
-- history already uploaded against it, intact through the rename. Only
-- name/slug actually changes; colours are untouched. Safe to re-run.

update teams set slug = 'juventus', name = 'Juventus' where competition_slug = 'serie-a' and slug = 'juventus-fc';
update teams set slug = 'roma', name = 'Roma' where competition_slug = 'serie-a' and slug = 'as-roma';
update teams set slug = 'lazio', name = 'Lazio' where competition_slug = 'serie-a' and slug = 'ss-lazio';
update teams set slug = 'napoli', name = 'Napoli' where competition_slug = 'serie-a' and slug = 'ssc-napoli';
update teams set slug = 'fiorentina', name = 'Fiorentina' where competition_slug = 'serie-a' and slug = 'acf-fiorentina';
update teams set slug = 'parma', name = 'Parma' where competition_slug = 'serie-a' and slug = 'parma-calcio';
update teams set slug = 'torino', name = 'Torino' where competition_slug = 'serie-a' and slug = 'torino-fc';
update teams set slug = 'venezia', name = 'Venezia' where competition_slug = 'serie-a' and slug = 'venezia-fc';
update teams set slug = 'bologna', name = 'Bologna' where competition_slug = 'serie-a' and slug = 'bologna-fc';
update teams set slug = 'udinese', name = 'Udinese' where competition_slug = 'serie-a' and slug = 'udinese-calcio';
update teams set slug = 'atalanta', name = 'Atalanta' where competition_slug = 'serie-a' and slug = 'atalanta-bc';
update teams set slug = 'como', name = 'Como' where competition_slug = 'serie-a' and slug = 'como-1907';
update teams set slug = 'genoa', name = 'Genoa' where competition_slug = 'serie-a' and slug = 'genoa-cfc';
update teams set slug = 'cagliari', name = 'Cagliari' where competition_slug = 'serie-a' and slug = 'cagliari-calcio';
update teams set slug = 'lecce', name = 'Lecce' where competition_slug = 'serie-a' and slug = 'us-lecce';
update teams set slug = 'sassuolo', name = 'Sassuolo' where competition_slug = 'serie-a' and slug = 'us-sassuolo-calcio';
update teams set slug = 'monza', name = 'Monza' where competition_slug = 'serie-a' and slug = 'ac-monza';
update teams set slug = 'frosinone', name = 'Frosinone' where competition_slug = 'serie-a' and slug = 'frosinone-calcio';
-- AC Milan and Inter Milan are unchanged.

update teams set slug = 'fc-bayern-munich', name = 'FC Bayern Munich' where competition_slug = 'bundesliga' and slug = 'bayern-munchen';
update teams set slug = 'bayer-leverkusen', name = 'Bayer Leverkusen' where competition_slug = 'bundesliga' and slug = 'bayer-04-leverkusen';
update teams set slug = 'fc-schalke-04', name = 'FC Schalke 04' where competition_slug = 'bundesliga' and slug = 'schalke-04';
update teams set slug = 'sv-werder-bremen', name = 'SV Werder Bremen' where competition_slug = 'bundesliga' and slug = 'werder-bremen';
update teams set slug = '1-fc-union-berlin', name = '1. FC Union Berlin' where competition_slug = 'bundesliga' and slug = 'union-berlin';
update teams set slug = 'tsg-1899-hoffenheim', name = 'TSG 1899 Hoffenheim' where competition_slug = 'bundesliga' and slug = 'tsg-hoffenheim';
update teams set slug = 'sc-paderborn-07', name = 'SC Paderborn 07' where competition_slug = 'bundesliga' and slug = 'sc-paderborn';
-- Borussia Dortmund, Hamburger SV, 1. FC Köln, Eintracht Frankfurt,
-- Borussia Mönchengladbach, VfB Stuttgart, 1. FSV Mainz 05, SC Freiburg,
-- RB Leipzig, FC Augsburg, and SV Elversberg are unchanged.
