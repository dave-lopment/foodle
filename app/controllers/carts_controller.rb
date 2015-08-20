class CartsController < ApplicationController
  def show
    @order_items = current_order.order_items
  end

  def okay
    @order = current_order
  end

  def okay_okay
    @order = current_order
    @order.order_status_id = 2;
    @pay = params[:payment]

  end
end
