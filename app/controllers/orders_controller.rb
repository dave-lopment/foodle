class OrdersController < ApplicationController
  before_action :allow_only_admin, only: [:index, :deliver_order, :destroy]
  before_action only: [:user_orders, :received_orders] do
    allow_only_normal_user(orders_path)
  end
  before_action :is_there_user, only: [:user_orders]
  before_action :is_correct_user, only: [:show]

  def index
    @orders = Order.all
    @orders.each do |order|
      if order.Erstellung? && (order.updated_at < 2.hours.ago)
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

  def received_order
    @order = Order.find(params[:order_id])
    @order.Angekommen!
    @order.save
    redirect_to meine_bestellungen_path
  end

  def user_orders
    @orders = Order.where(user_id: current_user[:id])
    
  end

  private

    def allow_only_admin
      if user_signed_in?
        if (!current_user.try(:admin?))
          redirect_to(meine_bestellungen_path)
        end
      else
	  redirect_to(bestellen_path)
      end
    end

    def is_there_user
      if !(user_signed_in?) 
        redirect_to(bestellen_path)
      end
    end

    def is_correct_user
      order = Order.find(params[:id])
      if (user_signed_in?)
        if ((current_user[:id] !=  order[:user_id]) && !(current_user.try(:admin?)))
          redirect_to(meine_bestellungen_path)
        end
      else
	 redirect_to(bestellen_path)
      end
    end
end
