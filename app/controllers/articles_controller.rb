class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  def show
      
  end

  def index
      # @articles = Article.all
      @articles = Article.paginate(page: params[:page], per_page: 3)
  end

  def new
      @article = Article.new
  end
  
  def edit
  
  end
  
  def create
      @article = Article.new(article_params)
      @article.user = current_user
      #render plain: @article
      #render plain: @article.inspect
      #redirect_to article_path(@article)
      
      if @article.save
          flash[:notice] = "Article was created successfully"
          redirect_to @article
      else
          render 'new'
      end
  end

  def update
      if @article.update(article_params)
          flash[:notice] = "Article was updated successfully"
          redirect_to @article
      else
          render 'edit'
      end
  end

  def destroy
      @article.destroy                        # destroy the article
      redirect_to articles_path               # redirect to the article list
  end

  private

  def set_article
      @article = Article.find(params[:id])    # find the article
  end

  
  def article_params
      params.require(:article).permit(:title, :description)  
  end
end
