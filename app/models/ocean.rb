class Ocean
  attr_accessor :droplets, :images
  
  def initialize(params = {})
    @conn = Faraday.new(:url => 'https://api.digitalocean.com/v2/') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    @conn.headers['Authorization'] = "Bearer #{params[:auth_token]}"
  end
  
  def droplets
    @droplets ||= JSON.parse(@conn.get('droplets').body)['droplets'] || {}
  end
  
  def droplet(id)
    JSON.parse(@conn.get("droplets/#{id}").body)['droplet']
  end
  
  def action(droplet_id, action_id)
    JSON.parse(@conn.get("droplets/#{droplet_id}/actions/#{action_id}").body)['action']
  end
  
  def password_reset(id)
    @conn.post do |req|
      req.url "droplets/#{id}/actions"
      req.headers['Content-Type'] = 'application/json'
      req.body = '{"type": "password_reset"}'
    end
  end
end