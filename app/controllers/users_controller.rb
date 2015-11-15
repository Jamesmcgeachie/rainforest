class UsersController < ApplicationController

  before_action :authenticate_user, only: [:show]

  def new
  	@user = User.new
  end

  def show
    @user = User.find(params[:id])
    user_profile_permission
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
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_profile_permission
    unless @user.id == current_user.id
      redirect_to '/login'
      flash[:alert] = "Not signed in as User #{@user.id}. Sign in if you wish to view that profile"
    end
  end

end
