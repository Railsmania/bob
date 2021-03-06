class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :verify_session
  helper_method :current_session_auth, :ocean
  
  def verify_session
    redirect_to auth_new_path unless Session.exists?(id: session[:active])
  end
  
  def current_session_auth
    JSON.parse(Session.where(id: session[:active]).first.content)
  end
  
  def ocean
    @ocean ||= Ocean.new(auth_token: current_session_auth['credentials']['token'])
  end
end
