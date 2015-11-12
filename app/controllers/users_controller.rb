class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(sanitized_user_params)
  	if @user.save
  		redirect_to products_url, notice: "Successful signup!"
  	else
  		render :new
  	end
  end

  private
  def sanitized_user_params
  	params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
