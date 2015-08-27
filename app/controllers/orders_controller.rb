class OrdersController < ApplicationController
  before_action :allow_only_admin, only: [:index, :deliver_order, :destroy]
  before_action :allow_only_user, only: [:user_orders]
  
  def index
    @orders = Order.all
    @orders.each do |order|
      if order.Erstellung? && (order.updated_at > 2.days.ago)
        Order.find(order[:id]).destroy
      end
    end
  end

  def destroy
    Order.find(params[:id]).destroy
    redirect_to orders_path
  end

  def show
    @order = Order.find(params[:id])
  end

  def deliver_order
    @order = Order.find(params[:order_id])
    @order.Abgeschickt!
    @order.save
    redirect_to orders_path
  end

  def user_orders
    @orders = current_user.orders.all
  end

  private

    def allow_only_admin
      if (!current_user.try(:admin?))
        redirect_to(meine_bestellungen_path)
      end
    end

    def allow_only_user
      if current_user.try(:admin?)
        redirect_to(orders_path)
      end
    end
end
