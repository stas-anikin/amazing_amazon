class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:create, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

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
    @product.user = current_user

    if @product.save
      flash[:notice] = "Product created successfully."

      redirect_to product_path(@product.id)
    else
      render :new
    end
  end

  def edit
    redirect_to root_path, alert: "access denied" unless can? :edit, @product
  end

  def update
    if @product.update product_params
      redirect_to product_path(@product.id), notice: "product edited successfully."
    else
      render :edit
    end
  end

  def destroy
    redirect_to root_path, alert: "access defined" unless can? :destroy, @product

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

  def authorize_user!
    redirect_to root_path, alert: "not authorized" unless can?(:crud, @product)
  end
end
