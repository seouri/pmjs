# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_pmjs_session',
  :secret => '4c4f333c7bb9b578bdbfc4ccab4cf29011c59222f358c8c81159241c13fe4bb40d5cf621cd349abb587e9b9c9195722c2ef65e1627f4e9803eec5ee11aa4788f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
