class WelcomeController < ApplicationController
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def home
  end

  def admin_panel
    @products = Product.all.order(created_at: :desc)
    @reviews = Review.all.order(created_at: :desc)
    @users = User.all.order(created_at: :desc)
  end

  def about
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
