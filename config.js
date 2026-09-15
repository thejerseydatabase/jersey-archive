// Supabase connection — the anon/publishable key below is safe to expose in
// client-side code. It only grants what the database's row-level security
// policies (see schema.sql in jersey-database-hub) allow an anonymous or
// logged-in visitor to do. Never put the service_role/secret key here.
const SUPABASE_URL = 'https://gcouhpkxlonjqanczspi.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_ls09zWjL5CCEpoy4SywVRA_A-foafMN';

const supabaseClient = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
