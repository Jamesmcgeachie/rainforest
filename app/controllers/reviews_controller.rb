class ReviewsController < ApplicationController

  before_action :authenticate_user, only: [:edit]
	before_filter :get_product, only: [:show, :create, :edit, :update]
	before_filter :get_review, only: [:show, :edit, :destroy]

  def show
  end


  def create
  	@review = @product.reviews.build(sanitized_review_params)
  	@review.user = current_user

  	if @review.save
  		redirect_to products_path, notice: "Your review was successfully created! Yay!"
  	else
  		render 'products/show'
  	end
  end

  def edit
  end

  def update
    if @review.update_attributes(sanitized_review_params)
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
  	@review.destroy
  end

  private
  def sanitized_review_params
  	params.require(:review).permit(:comment, :product_id)
  end

  def get_product
  	@product = Product.find(params[:product_id])
  end

  def get_review
  	@review = @product.reviews.find(params[:id])
  end
end
