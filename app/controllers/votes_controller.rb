class VotesController < ApplicationController
  def create
    review = Review.find params[:review_id]
    vote = Vote.new review: review, user: current_user
    if !can?(:vote, review)
      flash[:alert] = "Can't vote your own review"
    elsif vote.save
      flash[:notice] = "voted +1"
    else
      flash[:alert] = vote.errors.full_messages.join(", ")
    end
    redirect_to product_path(review.product)
  end

  def destroy
    vote = current_user.votes.find params[:id]
    review = vote.review
    if !can?(:destroy, vote)
      flash[:alert] = "Can't unvote someone else's vote"
    elsif vote.destroy
      flash[:notice] = "vote -1"
    else
      flash[:alert] = "Couldn't unvote"
    end
    redirect_to product_path(review.product)
  end
end
