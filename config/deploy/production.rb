# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

role :app, %w{rails@128.199.229.42}
role :web, %w{rails@128.199.229.42}
role :db,  %w{rails@128.199.229.42}


# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

server '128.199.229.42', user: 'rails', roles: %w{web}

production_secrets = "#{File.dirname(__FILE__)}/../secrets.production.yml"
if FileTest.file?(production_secrets)
  require 'yaml'
  secret = YAML.load_file(production_secrets)
  set :default_env, {
    'SECRET_KEY_BASE' => secret['production']['secret_key_base']
  }
end
# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
  set :ssh_options, {
    forward_agent: false,
    auth_methods: %w(publickey),
    keys: [File.join(ENV["HOME"], ".ssh", "key.bob")],
    user: 'rails'
  }
#
# And/or per server (overrides global)
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
