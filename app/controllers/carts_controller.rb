class CartsController < ApplicationController
  def show
    @order_items = current_order.order_items
    @order = current_order
  end

  def confirm_order
    @order = current_order
  end

  def confirm_order_details
    @order = current_order
    @order.order_status_id = 2;
    @order.save!
    @pay = params[:payment]
  end

  def cancel_order
    @order = current_order
    if @order.order_status_id == 2;
      @order.order_status_id = 1;
      @order.save
      redirect_to :back
    end

  end
end
