class TagsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy, :favoured]

  def index
    @tags = Tag.all.order(created_at: :desc)
  end

  def show
    @tag = Tag.find params[:id]

    @products = @tag.products
  end

  private

  def find_product
    @product = Product.find params[:id]
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, tag_ids: [])
  end
end
