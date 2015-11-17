class UsersController < ApplicationController

  before_action :authenticate_user, only: [:show]
  before_filter :get_user, only: [:show, :edit, :update]

  def new
  	@user = User.new
  end

  def show
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

  def edit
    user_profile_permission
  end

  def update
    if @user.update_attributes(sanitized_user_params)
      redirect_to root_path, notice: "Successfully updated #{@user.name}'s account"
    else
      render :edit
    end
  end

  private
  def sanitized_user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def get_user
    @user = User.find(params[:id])
  end

  def user_profile_permission
    unless @user.id == current_user.id
      redirect_to '/login'
      flash[:alert] = "Not signed in as User #{@user.id}. Sign in if you wish to access that profile"
    end
  end

end
