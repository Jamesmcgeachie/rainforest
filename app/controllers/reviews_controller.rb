class ReviewsController < ApplicationController

  before_action :authenticate_user, only: [:edit]
	before_filter :get_product, only: [:show, :create, :edit, :update, :destroy]
	before_filter :get_review, only: [:show, :edit, :update, :destroy]

  def show
  end


  def create
  	@review = @product.reviews.build(sanitized_review_params)
  	@review.user = current_user

    respond_to do |format|
    	if @review.save
    		format.html { redirect_to product_path(@product), notice: "Your review was successfully created! Yay!" }
        format.js {}
    	else
    		format.html { render 'products/show', alert: 'That did not work.' }
        format.js {}
    	end
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
    respond_to do |format|
      format.html { redirect_to product_path(@product), notice: "Deleted Review."}
      format.js {}
    end
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
