class ProductsController < ApplicationController

  before_filter :get_product, only: [:show, :edit, :update, :destroy]

  def index
  	@products = Product.all
  end

  def show
    if current_user
      @review = @product.reviews.build
    end
  end

  def new
  	@product = Product.new
  end

  def edit
  end

  def create
  	@product = Product.new(sanitized_product_params)

  	if @product.save
  		redirect_to products_path
  	else
  		render :new
  	end
  end

  def update
  	if @product.update_attributes(sanitized_product_params)
  		redirect_to product_path(@product)
  	else
  		render :edit
  	end
  end

  def destroy
  	@product.destroy
  	redirect_to products_path
  end

  private

  def get_product
  	@product = Product.find(params[:id])
  end

  def sanitized_product_params
  	params.require(:product).permit(:price_in_cents, :description, :name)
  end
end
