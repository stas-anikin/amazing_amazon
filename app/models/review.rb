class Review < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :product
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user
  validates :rating, presence: { message: " should be present" }, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  def self.all_with_vote_counts
    self.left_outer_joins(:votes)
        .select("reviews.*", "Count(votes.*) AS votes_count")
        .group("reviews.id")
  end
end
