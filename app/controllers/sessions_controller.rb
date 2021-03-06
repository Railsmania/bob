class SessionsController < ApplicationController
  skip_before_filter :verify_session
  
  def new
  end
  
  def create
    session_instance = Session.find_or_create_by(content: auth_hash.to_json)
    session[:active] = session_instance.id
    redirect_to dashboards_path
  end
  
  def destroy
    Session.destroy(session[:active])
    reset_session
    redirect_to auth_new_path
  end
  
  def failure
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end