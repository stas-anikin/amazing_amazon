require "rails_helper"

RSpec.describe NewsArticle, type: :model do
  describe "validates" do
    describe "title" do
      it "requires a title" do
        news_article = NewsArticle.new
        news_article.valid?
        expect(news_article.errors.messages).to(have_key(:title))
      end
    end
  end
end
