class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_top

  def index
    @item = Item.find(params[:item_id])
    @order = Order.new
    @address = Address.new
    @item_order = ItemOrder.new
  end

  def create
    @item_order = ItemOrder.new(order_params)
    if @item_order.valid?
      pay_item
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

  def move_to_top
    item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == item.user_id || item.order.present?
  end

  def order_params
    item = Item.find(params[:item_id])
    params.require(:item_order).permit(:postal_code, :prefecture, :city, :block, :building, :phone)
          .merge(user_id: current_user.id, item_id: item.id, token: params[:token])
  end

  def pay_item
    @item = Item.find(params[:item_id])
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
