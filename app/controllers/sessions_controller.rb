class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:email])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect_to products_url, notice: "You logged in!"
  	else
  		flash[:alert] = "Invalid email or password!"
  		render :new
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to products_url, notice: "You got logged out. I hope you wanted that."
  end
end
