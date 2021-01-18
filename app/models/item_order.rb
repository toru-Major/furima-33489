class ItemOrder
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture, :city, :block, :building, :phone, :item_id, :user_id, :token

  with_options presence: true do
    validates :postal_code, format: {with: /\A\d{3}[-]\d{4}\z/}
    validates :prefecture, numericality: { other_than: 1 }
    validates :city
    validates :block
    validates :phone, format: {with: /(0{1}\d{9,10})/}
    validates :token
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(order_id: order.id, postal_code: postal_code, prefecture: prefecture,
                   city: city, block: block, building: building, phone: phone)
  end
end