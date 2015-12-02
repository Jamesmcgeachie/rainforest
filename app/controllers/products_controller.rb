class ProductsController < ApplicationController

  before_filter :get_product, only: [:show, :edit, :update, :destroy]
  before_filter :get_categories, only: [:show, :edit]
  before_action :authenticate_user, only: [:new, :edit, :create, :destroy]

  def index
    if params[:search]
      @products = Product.where('name ILIKE ?', "%#{params[:search]}%")
    else
      @products = Product.all
    end

    @products = @products.order('products.created_at DESC').page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    if current_user
      @review = Review.new
    end
  end

  def new
  	@product = Product.new
    2.times { @product.categories.build }
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
  	params.require(:product).permit(:price_in_cents, :description, :name, categories_attributes: [:id, :name])
  end

  def get_categories
    @categories = Category.all
  end
end
