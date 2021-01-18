class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_top
  before_action :set_item
  
  def index
    @item_order = ItemOrder.new
  end

  def create
    set_item
    @item_order = ItemOrder.new(order_params)
    if @item_order.valid?
      pay_item
      @item_order.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private
  
  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_top
    set_item
    if current_user.id == @item.user_id || @item.order.present?
      redirect_to root_path
    end
  end

  def order_params
    set_item
    params.require(:item_order).permit(:postal_code, :prefecture, :city, :block, :building, :phone)
                               .merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
      )
  end
end
