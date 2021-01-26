class LikesController < ApplicationController
  def create
    review = Review.find params[:review_id]
    like = Like.new review: review, user: current_user
    if !can?(:like, review)
      flash[:alert] = "Can't like your own review"
    elsif like.save
      flash[:notice] = "Liked +1"
    else
      flash[:alert] = like.errors.full_messages.join(", ")
    end
    redirect_to product_path(review.product)
  end

  def destroy
    like = current_user.likes.find params[:id]
    review = like.review
    if !can?(:destroy, like)
      flash[:alert] = "Can't unlike someone else's like"
    elsif like.destroy
      flash[:notice] = "Like -1"
    else
      flash[:alert] = "Couldn't unlike"
    end
    redirect_to product_path(review.product)
  end
end
