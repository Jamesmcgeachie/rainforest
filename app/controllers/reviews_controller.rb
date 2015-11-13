class ReviewsController < ApplicationController

	before_filter :get_product, only: [:create]
	before_filter :get_review, only: [:show, :destroy]

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
  	@review = Review.find(params[:id])
  end

end
