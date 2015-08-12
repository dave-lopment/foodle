class RootPagesController < ApplicationController
  def home
    @articles = Article.all.sort_by {|article| article.get_likes.size }.reverse.first(5)
    @order_item = current_order.order_items.new


  end
end
