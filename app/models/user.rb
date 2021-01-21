class User < ApplicationRecord
  # scope(:created_after, ->(date) { where("created_at < ?", "#{date}") })
  before_save { self.email = email.downcase }
  has_many :products, dependent: :nullify
  has_many :reviews, dependent: :nullify
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  self.per_page = 10

  def full_name
    "#{first_name} #{last_name}"
  end
end
