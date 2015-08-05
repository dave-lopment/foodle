class ArticlesController < ApplicationController
  def index
    @articles = Article.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def destroy
    Article.find(params[:id]).destroy
    redirect_to articles_path
  end

  # upvote with help of acts_as_votable
  # def upvote
  #   @article = Article.find(param[:id])
  #   @article.upvote_by current_user
  #   redirect_to articles_path
  # end

  private

    def article_params
      params.require(:article).permit(:name, :description, :price, :isVegetarian)
    end
end
