class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def new
    @product = Product.new
  end

  def show
    @reviews = @product.reviews.order(created_at: :desc)
    @product = Product.find params[:id]
    @review = Review.new
  end

  def create
    @product = Product.new product_params
    @answer.user = current_user

    if @product.save
      redirect_to product_path(@product.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update product_params
      redirect_to product_path(@product.id), notice: "product edited successfully."
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  private

  def find_product
    @product = Product.find params[:id]
  end

  def product_params
    params.require(:product).permit(:title, :description, :price)
  end
end
