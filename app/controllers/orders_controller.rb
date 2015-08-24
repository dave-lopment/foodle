class OrdersController < ApplicationController
  before_action :admin_user, only: [:index]
  
  def index
    @orders = Order.all
  end

  def destroy
    Order.find(params[:id]).destroy
    redirect_to orders_path
  end

  def deliver_order
    @order = Order.find(params[:order_id])
    @order.order_status_id = 3
    @order.save
    redirect_to orders_path
  end

  def show
    @order = Order.find(params[:id])
  end

  private

    def admin_user
      if current_user
        @user = current_user
        redirect_to(articles_path) unless @user[:admin] == true
      else
	redirect_to(articles_path)
      end
    end
end
