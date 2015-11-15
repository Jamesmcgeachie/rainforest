class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def authenticate_user
  	unless current_user
  		redirect_to '/login'
  		flash[:alert] = "Gotta be logged in to do that."
  	end
  end

  helper_method :authenticate_user

end
