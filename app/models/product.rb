class Product < ApplicationRecord
  # before_validation :set_default_sale_price
  # before_save :capitalize_title
  before_destroy :log_delete_details
  has_many :reviews, dependent: :destroy
  belongs_to :user, optional: true
  has_many :favourites, dependent: :destroy
  has_many :favouriters, through: :favourites, source: :user
  # validates :title, presence: true, uniqueness: true
  validates(:title,
            presence: true,
            uniqueness: true,
            exclusion: {
              in: ["apple", "microsoft", "sony"],
              message: "%{value} is reserved. Please use a different title.",
            })

  # validates :price, presence: true, numericality: { greater_than: 0 }
  # validates :description, presence: true
  # validate :sale_price_less_than_price

  scope(:search, ->(query) { where("title ILIKE ? OR description ILIKE ?", "%#{query}") })
  def self.favourite_products
    self.left_outer_joins(:reviews)
      .select("products.*", "Count(reviews.*) AS reviews_count")
      .group("products.id")
  end

  # A constant is a value that should never change. We use these often to replace hard coded values. That way you can use this constant in multiple areas and if you ever need to change it you'd only need to change it at one place.
  # DEFAULT_PRICE = 1 # a ruby convention is to place constants at the top of the file and name them using SCREAMING_SNAKE_CASE
  # rubocop has good guidelines on best practices https://github.com/rubocop-hq/ruby-style-guide

  def self.search_but_using_class_method(query)
    where("title ILIKE?", "%#{query}%")
  end

  def increment_hit_count
    new_hit_count = self.hit_count += 1
    update({ hit_count: new_hit_count })
  end

  private

  # def set_default_price
  #   self.price ||= DEFAULT_PRICE
  # end

  def capitalize_title
    self.title.capitalize!
  end

  # def set_default_sale_price
  #   self.sale_price ||= self.price
  # end

  # def sale_price_less_than_price
  #   if self.sale_price > self.price
  #     errors.add(:sale_price, "sale_price: #{self.sale_price} must be lower than price: #{self.price}")
  #   end
  # end

  def log_delete_details
    puts "Product #{self.id} is about to be deleted"
  end
end
