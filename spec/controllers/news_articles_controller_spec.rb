require "rails_helper"

RSpec.describe NewsArticlesController, type: :controller do
  describe "#new" do
    it "renders a template to create a new news_article" do
      get(:new)

      expect(response).to(render_template(:new))
    end
    it "creates an instance variable of a news_article with new.NewsArticle" do
      get(:new)
      expect(assigns(:news_article)).to(be_a_new(NewsArticle))
    end
  end

  describe "#create" do
    context "checking with valid parameters " do
      def valid_request
        post(:create, params: { news_article: FactoryBot.attributes_for(:news_article) })
      end

      it "creates a news article in the database" do
        count_before = NewsArticle.count
        valid_request
        count_after = NewsArticle.count
        expect(count_after).to(eq(count_before + 1))
      end
      it "redirects us to a show page of the newly created news_article" do
        valid_request

        news_article = NewsArticle.last
        expect(response).to(redirect_to(news_article_url(news_article.id)))
      end
    end
    context "adding invalid parameters" do
      def invalid_request
        post(:create, params: { news_article: FactoryBot.attributes_for(:news_article, title: nil) })
      end

      it "checks if the news article saves to the database" do
        count_before = NewsArticle.count
        invalid_request
        count_after = NewsArticle.count
        expect(count_after).to(eq(count_before))
      end
      it "renders a template for a new news_article" do
        invalid_request
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#show" do
    it "renders show template of a news_article" do
      news_article = FactoryBot.create(:news_article)
      get(:show, params: { id: news_article.id })
      expect(response).to render_template(:show)
    end
    it "sets an instance variable @news_article for the displayed object" do
      news_article = FactoryBot.create(:news_article)
      get(:show, params: { id: news_article.id })

      expect(assigns(:news_article)).to(eq(news_article))
    end
  end
end
