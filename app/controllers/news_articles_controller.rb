class NewsArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_news_article, only: [:show, :update, :destroy, :edit]

  def new
    @news_article = NewsArticle.new
  end

  def create
    @news_article = NewsArticle.new news_article_params
    @news_article.user = current_user
    if @news_article.save
      redirect_to news_article_path(@news_article)
    else
      render :new
    end
  end

  def show
  end

  def index
    @news_articles = NewsArticle.all.order(id: :desc)
  end

  def edit
    if can?(:edit, @news_article)
      render :edit
    else
      redirect_to news_article_path(@news_article)
    end
  end

  def update
    if @news_article.update news_article_params
      redirect_to @news_article
    end
  end

  def destroy
    if can?(:delete, @news_article)
      @news_article.destroy
      flash[:danger] = "news article deleted successfully!"
      redirect_to news_articles_path
    else
      flash[:danger] = "access denied"
      redirect_to news_article_url(@news_article)
    end
  end

  private

  def find_news_article
    @news_article = NewsArticle.find params[:id]
  end

  def news_article_params
    params.require(:news_article)
      .permit(
        :title,
        :description,
        :published_at,
        :view_count,
        :created_at,
        :updated_at
      )
  end
end
