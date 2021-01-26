class Review < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :product
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :review
  validates :rating, presence: { message: " should be present" }, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
