class NewsArticle < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :published_at, presence: true
  validate :published_at_before_created_at
  belongs_to :user

  private

  def published_at_before_created_at
    if published_at < created_at
      errors.add(:published_at, "must be after created at")
    end
  end
end
