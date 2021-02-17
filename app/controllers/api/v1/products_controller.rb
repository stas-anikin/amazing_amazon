class Api::V1::ProductsController < ApplicationController
  before_action :find_product, only: [:show, :destroy, :update]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    products = Product.order created_at: :desc
    render json: products
  end

  def show
    render json: @product, each_serializer: ProductCollectionSerializer
  end

  def destroy
    if @product.destroy
      head :ok
    else
      head :bad_request
    end
  end

  def update
    if @product.update product_params
      render json: { id: @product.id }
    else
      render(
        json: { errors: @product.errors },
        status: 422,
      )
    end
  end

  def create
    product = Product.new product_params
    product.user = current_user
    if product.save
      render json: { id: product.id }
    else
      render(
        json: { errors: product.errors },
        status: 422,
      )
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price)
  end

  def find_product
    @product = Product.find params[:id]
  end
end
