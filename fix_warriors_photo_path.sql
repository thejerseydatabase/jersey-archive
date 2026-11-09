-- The crop tool on this jersey's photo was saving a crop of the on-screen
-- preview canvas (shrunk to fit the screen) instead of the full source
-- photo - since fixed in app.js. For this jersey, it left jersey_images
-- pointing at a tiny 31KB crop while the real 2.1MB original photo is
-- still sitting untouched in the jersey-photos bucket under its old
-- filename (the "best-effort cleanup" delete of the old file silently
-- failed). This just points the row back at the original - run it, then
-- re-do the crop from the website using the (now-fixed) crop tool if you
-- still want it cropped, and it'll keep full resolution this time.

update jersey_images
set storage_path = 'fd311c1c-b560-4ae4-b273-c382b4122610/new-zealand-warriors-2012-away-kit-front.jpg'
where jersey_id = 'fd311c1c-b560-4ae4-b273-c382b4122610'
  and storage_path = 'fd311c1c-b560-4ae4-b273-c382b4122610/new-zealand-warriors-2012-away-kit-front-crop-1794134692033.jpg';
