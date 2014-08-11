Rails.application.config.middleware.use OmniAuth::Builder do
  provider :digitalocean, '', '', scope: "read write"
end