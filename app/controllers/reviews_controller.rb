class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def create
    @product = Product.find params[:product_id]
    @review = Review.new review_params
    @review.product = @product
    @review.user = current_user

    if @review.save
      redirect_to product_path(@product), notice: "Review posted"
    else
      @review = @product.reviews.order(created_at: :desc)
      render "/products/show"
    end
  end

  def destroy
    @product = Product.find params[:product_id]
    @review = Review.find params[:id]
    @review.destroy
    redirect_to product_path(@product), notice: "review deleted"
  end

  private

  def review_params
    params.require(:review).permit(:body, :rating)
  end
end
