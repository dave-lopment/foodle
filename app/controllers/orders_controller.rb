class OrdersController < ApplicationController
  before_action :admin_user, only: [:index]
  
  def index
    @orders = Order.all
    @orders.each do |order|
      if order.Erstellung? && (order.updated_at > 2.minutes.ago)
        Order.find(order[:id]).destroy
      end
    end
  end

  def destroy
    Order.find(params[:id]).destroy
    redirect_to orders_path
  end

  def deliver_order
    @order = Order.find(params[:order_id])
    @order.Abgeschickt!
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
