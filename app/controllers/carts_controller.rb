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
    @order.street = params[:street]
    @order.postal = params[:postal]
    @order.city = params[:city]
    @order.Auftrag!;
    @order.save!
    @pay = params[:payment]
    #@order = Order.new.save!
  end

  def cancel_order
    @order = current_order
      if (@order.Auftrag?)
        @order.Storniert!
        @order.save
      else 
	@order.Angekommen!
	@order.save
      end
    redirect_to :back
  end
end
