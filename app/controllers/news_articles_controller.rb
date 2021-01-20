class NewsArticlesController < ApplicationController
  before_action :find_news_article, only: [:show, :update, :destroy]

  def new
    @news_article = NewsArticle.new
  end

  def create
    @news_article = NewsArticle.new params.require(:news_article)
                                      .permit(
                                        :title,
                                        :description,
                                        :published_at,
                                        :view_count,
                                        :created_at,
                                        :updated_at
                                      )
    if @news_article.save
      redirect_to news_article_path(@news_article)
    else
      render :new
    end
  end

  def show
    @news_article = NewsArticle.find params[:id]
  end

  def index
    @news_articles = NewsArticle.all.order(created_at: :desc)
  end

  def edit
  end

  def update
    @news_article = NewsArticle.find params[:id]
    if @news_article.update params.require(:news_article)
                              .permit(
                                :title,
                                :description,
                                :published_at,
                                :view_count,
                                :created_at,
                                :updated_at
                              )
      redirect_to @news_article
    end
  end

  def destroy
    @news_article.destroy
    flash[:danger] = "news article deleted successfully!"
    redirect_to news_articles_path
  end

  private

  def find_news_article
    @news_article = NewsArticle.find params[:id]
  end
end
