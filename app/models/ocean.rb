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
    JSON.parse(@conn.get('droplets').body)['droplets']
  end
  
  def images
    JSON.parse(@conn.get('images').body)['images']
  end
end