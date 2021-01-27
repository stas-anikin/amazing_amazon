class User < ApplicationRecord
  # scope(:created_after, ->(date) { where("created_at < ?", "#{date}") })
  before_save { self.email = email.downcase }
  has_many :products, dependent: :nullify
  has_many :reviews, dependent: :nullify
  has_many :news_articles, dependent: :nullify
  has_many :likes, dependent: :destroy
  has_many :liked_reviews, through: :likes, source: :review
  has_many :votes, dependent: :destroy
  has_many :voted_reviews, through: :votes, source: :review
  has_many :favourites, dependent: :destroy
  has_many :favourite_products, through: :favourites, source: :product
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}".titleize
  end
end
