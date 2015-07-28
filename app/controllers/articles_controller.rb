class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  # upvote with help of acts_as_votable 
  def upvote
    @article = Article.find(param[:id])
    @article.upvote_by current_user
    redirect_to articles_path
  end
end
