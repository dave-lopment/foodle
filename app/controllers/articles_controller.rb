class ArticlesController < ApplicationController
  def index
    @articles = Article.paginate(:page => params[:page], :per_page => 10)
    @order_item = current_order.order_items.new
  end

  # upvote with help of acts_as_votable
  # def upvote
  #   @article = Article.find(param[:id])
  #   @article.upvote_by current_user
  #   redirect_to articles_path
  # end
end
