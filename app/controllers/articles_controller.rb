class ArticlesController < ApplicationController
  before_action :admin_user, only: [:edit, :new]

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def index
    @categories = Category.all
    @articles = Article.filter(params[:filter]).paginate(:page => params[:page], :per_page => 10)
    @order_item = current_order.order_items.new
  end

  def show
    @article = Article.find(params[:id])
    @order_item = current_order.order_items.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    Article.find(params[:id]).destroy
    redirect_to articles_path()
  end

  # upvote with help of acts_as_votable
  def upvote
    @article = Article.find(params[:id])
    @article.liked_by current_user
    redirect_to article_path
  end

  def downvote
    @article = Article.find(params[:id])
    @article.downvote_by current_user
    redirect_to article_path
  end

  private

    def article_params
      params.require(:article).permit(:name, :description, :price, :isVegetarian, :category_id, :img_name)
    end

    def admin_user
      if current_user
        @user = current_user
        redirect_to(articles_path) unless @user[:admin] == true
      else
	redirect_to(articles_path)
      end
    end
end
