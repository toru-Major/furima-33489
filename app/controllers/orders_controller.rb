class OrdersController < ApplicationController
  
  def index
    @item = Item.find(params[:item_id])
    @order = Order.new
    @address = Address.new
    @item_order = ItemOrder.new
  end

  def create
    @item_order = ItemOrder.new(order_params)
    if @item_order.valid?
      @item_order.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      @order = Order.new
      @address = Address.new
      render action: :index
    end
  end

  private
  
  def order_params
    item = Item.find(params[:item_id])
    params.require(:item_order).permit(:postal_code, :prefecture, :city, :block, :building, :phone)
                               .merge(user_id: current_user.id, item_id: item.id)
  end
end
