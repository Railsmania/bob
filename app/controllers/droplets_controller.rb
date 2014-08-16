class DropletsController < ApplicationController
  def index
    conn = Faraday.new(:url => 'https://api.digitalocean.com/v2/') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    conn.headers['Authorization'] = "Bearer #{current_session_auth['credentials']['token']}"
    @droplets = JSON.parse(conn.get('droplets').body)
  end
end
