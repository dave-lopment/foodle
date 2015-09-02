class OrderItemsController < ApplicationController
  before_action :allow_only_user, only: [:create, :update ,:destroy]
  def create
    @order = current_order
    @order_item = @order.order_items.find_by(article_id: order_item_params[:article_id])
    if @order_item.nil? 
      then
        @order_item = @order.order_items.new(order_item_params)
        @order.save
        session[:order_id] = @order.id
      else
        update_param = order_item_params
        update_param[:quantity] = update_param[:quantity].to_i + @order_item.quantity.to_i
        @order_item.update_attributes(update_param) 
        @order_items = @order.order_items
      end
  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @order_items = @order.order_items
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
    redirect_to cart_path
  end

  private
  
    def order_item_params
       params.require(:order_item).permit(:quantity, :article_id)
    end

    def allow_only_user
      if current_user.try(:admin?)
        redirect_to(orders_path)
      end
    end
end
