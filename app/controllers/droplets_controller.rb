class DropletsController < ApplicationController
  def index
  end
  
  def show
    @droplet = ocean.droplet(params[:id])
  end
  
  def password_reset
    ocean.password_reset(params[:id])
    redirect_to droplet_path(params[:id])
  end
end
