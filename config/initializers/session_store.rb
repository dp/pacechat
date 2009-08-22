# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_pacechat_session',
  :secret      => 'b9db5546adcb52934c9ba6c8fa699e8e79bec814311a6d060cd6daacd55ab78c9eb66578d2553549b4e0fef8b422cd702a6c4eaaed7fcd0b8255664615173a79'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
